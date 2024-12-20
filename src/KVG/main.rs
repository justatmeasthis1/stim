use std::env;
use std::process;
use std::io::{self, Write};

const VB2_SHA256_DIGEST_SIZE: usize = 32;
const MAX_HEX_LENGTH: usize = 10;

#[repr(C, packed)]
struct Vb2SecdataKernelV0 {
    struct_version: u8,
    uid: u32,
    kernver: u32,
    reserved: [u8; 3],
    crc8: u8,
}

#[repr(C, packed)]
struct Vb2SecdataKernelV1 {
    struct_version: u8,
    struct_size: u8,
    crc8: u8,
    flags: u8,
    kernver: u32,
    ec_hash: [u8; VB2_SHA256_DIGEST_SIZE],
}

struct Vb2Context<'a> {
    secdata_kernel: &'a [u8],
}

fn vb2_crc8(data: &[u8]) -> u8 {
    let mut crc: u16 = 0;
    for byte in data {
        crc ^= (*byte as u16) << 8;
        for _ in 0..8 {
            if crc & 0x8000 != 0 {
                crc ^= 0x1070 << 3;
            }
            crc <<= 1;
        }
    }
    (crc >> 8) as u8
}

fn is_v0(context: &Vb2Context) -> bool {
    let major_version = (context.secdata_kernel[0] & 0xf0) >> 4;
    major_version == 0
}

fn secdata_kernel_crc(context: &Vb2Context) -> u8 {
    if is_v0(context) {
        let size = std::mem::size_of::<Vb2SecdataKernelV0>() - 1;
        vb2_crc8(&context.secdata_kernel[0..size])
    } else {
        let struct_size = context.secdata_kernel[1] as usize;
        let offset = 3;
        vb2_crc8(&context.secdata_kernel[offset..struct_size])
    }
}

fn is_valid_hex(input: &str) -> bool {
    if input.len() > MAX_HEX_LENGTH {
        return false;
    }

    if let Some(stripped) = input.strip_prefix("0x") {
        stripped.chars().all(|c| c.is_digit(16))
    } else {
        false
    }
}

fn sanitize_input(input: &str) -> String {
    input.replace('\n', "\0")
}

fn convert_to_u32(input: &str) -> u32 {
    u32::from_str_radix(input.trim_start_matches("0x"), 16).unwrap_or_else(|_| {
        eprintln!(
            "The entered kernver, {}, was not valid hexadecimal. Please try again.",
            input
        );
        process::exit(1);
    })
}

fn print_hex(data: &[u8]) {
    for byte in data {
        print!("{:02x} ", byte);
    }
    println!();
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 || args.contains(&"--help".to_string()) {
        println!(
            "USAGE: {} <kernver> <optional flags>\n\
            e.g.: {} 0x00010001 --raw\n\
            --raw - prints the output as raw hex bytes\n\
            --ver=<0/1> - specifies the kernver struct version to use\n\
            --help - shows this message :3\n\
            KVG was created by kxtzownsu\n\
            (now written in Rust)",
            args[0], args[0]
        );
        process::exit(0);
    }

    let kernver = sanitize_input(&args[1]);
    if !is_valid_hex(&kernver) {
        eprintln!(
            "The entered kernver: {}, wasn't detected as valid hexadecimal (max 10 characters). Please try again.",
            kernver
        );
        process::exit(1);
    }
    let kvarg = convert_to_u32(&kernver);

    let version = args.iter().find(|arg| arg.starts_with("--ver=")).map_or("", |v| &v[6..]);
    if version != "0" && version != "1" {
        eprintln!(
            "The entered struct version: {}, wasn't valid (see --help). Please try again.",
            version
        );
        process::exit(1);
    }

    let mut buffer = Vec::new();
    if version == "0" {
        let mut secdata0 = Vb2SecdataKernelV0 {
            struct_version: 0x02,
            uid: 0x4752574c,
            kernver: kvarg,
            reserved: [0x00; 3],
            crc8: 0,
        };
        let ctx = Vb2Context {
            secdata_kernel: unsafe {
                std::slice::from_raw_parts(
                    &secdata0 as *const _ as *const u8,
                    std::mem::size_of::<Vb2SecdataKernelV0>(),
                )
            },
        };
        secdata0.crc8 = secdata_kernel_crc(&ctx);
        buffer.extend_from_slice(unsafe {
            std::slice::from_raw_parts(
                &secdata0 as *const _ as *const u8,
                std::mem::size_of::<Vb2SecdataKernelV0>(),
            )
        });
    } else if version == "1" {
        let mut secdata1 = Vb2SecdataKernelV1 {
            struct_version: 0x10,
            struct_size: std::mem::size_of::<Vb2SecdataKernelV1>() as u8,
            crc8: 0,
            flags: 0x0,
            kernver: kvarg,
            ec_hash: [0; VB2_SHA256_DIGEST_SIZE],
        };
        let ctx = Vb2Context {
            secdata_kernel: unsafe {
                std::slice::from_raw_parts(
                    &secdata1 as *const _ as *const u8,
                    std::mem::size_of::<Vb2SecdataKernelV1>(),
                )
            },
        };
        secdata1.crc8 = secdata_kernel_crc(&ctx);
        buffer.extend_from_slice(unsafe {
            std::slice::from_raw_parts(
                &secdata1 as *const _ as *const u8,
                std::mem::size_of::<Vb2SecdataKernelV1>(),
            )
        });
    }

    if args.contains(&"--raw".to_string()) {
        io::stdout().write_all(&buffer).unwrap();
    } else {
        print_hex(&buffer);
    }
}
