// credit to Hannah / ZegLol for making this!

#ifndef ARG_CHECKS_H
#define ARG_CHECKS_H

#include <stddef.h>
#include <string.h>


int gargc;
char **gargv;

char *fval(const char *arg, int param)
{
	for (int i = 0; i < gargc; i++) {
		if (!strcmp(gargv[i], arg)) return gargv[i + param];
	}

	return "";
}

bool fbool(const char *arg)
{
	for (int i = 0; i < gargc; i++) {
		if (!strcmp(gargv[i], arg)) return true;
	}

	return false;
}

char *fequals(const char *arg)
{
	for (int i = 0; i < gargc; i++) {
		if (!memcmp(gargv[i], arg, strlen(arg) - 1)) 
			return gargv[i] + strlen(arg) + 1;
	}

	return "";
}

#endif