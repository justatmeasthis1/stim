// credit to Hannah / ZegLol for making this!

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