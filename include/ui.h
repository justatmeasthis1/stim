#ifndef UI_H
#define UI_H

void ui_flash(char* flashtype);
void ui_header(const char* fwver, const char* kernver, const char* tpmver, const char* fwmp, const char* gscver, const char* gsctype);
void show_credits();
void troll();

#endif