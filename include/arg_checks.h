// credit to Hannah / ZegLol for making this!

#ifndef ARG_CHECKS_H
#define ARG_CHECKS_H

#include <stddef.h>
#include <string.h>


int gargc;
char **gargv;

// fval("--parameter", 1) = "burger" (assuming --parameter burger was passed)
char *fval(const char *arg, const char *shorthand, int param)
{
	for (int i = 0; i < gargc; i++) {
		if (!strcmp(gargv[i], arg) || !strcmp(gargv[i], shorthand)) return gargv[i + param];
	}

	return "";
}

// fequals("--parameter"); = "burger" (assuming --parameter=burger was passed)
char *fequals(const char *arg)
{
	for (int i = 0; i < gargc; i++) {
		if (!memcmp(gargv[i], arg, strlen(arg) - 1))
			return gargv[i] + strlen(arg) + 1;
	}

	return "";
}

// fbool("--parameter") == true (assuming --parameter was passed)
bool fbool(const char *arg, const char *shorthand)
{
	for (int i = 0; i < gargc; i++) {
		if (!strcmp(gargv[i], arg) || !strcmp(gargv[i], shorthand)) return true;
	}

	return false;
}

#endif