#include <langinfo.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

void
prepare_locale(void)
{
  setlocale(LC_ALL, "");
}

char *
get_day(int i)
{
#define DAY(x) case x: return nl_langinfo(DAY_ ## x ); break;
	switch (i)
	{
	DAY(1)
	DAY(2)
	DAY(3)
	DAY(4)
	DAY(5)
	DAY(6)
	DAY(7)
	default:
		fprintf(stderr, "Tried to call get_day() with bogus day: %d\n", i);
		exit(-1);
	}
#undef DAY
}

char *
get_abday(int i)
{
#define ABDAY(x) case x: return nl_langinfo(ABDAY_ ## x ); break;
	switch (i)
	{
	ABDAY(1)
	ABDAY(2)
	ABDAY(3)
	ABDAY(4)
	ABDAY(5)
	ABDAY(6)
	ABDAY(7)
	default:
		fprintf(stderr, "Tried to call get_abday() with bogus day: %d\n", i);
		exit(-1);
	}
#undef ABDAY
}

char *
get_mon(int i)
{
#define MON(x) case x: return nl_langinfo(MON_ ## x ); break;
	switch (i)
	{
	MON(1)
	MON(2)
	MON(3)
	MON(4)
	MON(5)
	MON(6)
	MON(7)
	MON(8)
	MON(9)
	MON(10)
	MON(11)
	MON(12)
	default:
		fprintf(stderr, "Tried to call get_mon() with bogus month: %d\n", i);
		exit(-1);
	}
#undef MON
}

char *
get_abmon(int i)
{
#define ABMON(x) case x: return nl_langinfo(ABMON_ ## x ); break;
	switch (i)
	{
	ABMON(1)
	ABMON(2)
	ABMON(3)
	ABMON(4)
	ABMON(5)
	ABMON(6)
	ABMON(7)
	ABMON(8)
	ABMON(9)
	ABMON(10)
	ABMON(11)
	ABMON(12)
	default:
		fprintf(stderr, "Tried to call get_abmon() with bogus month: %d\n", i);
		exit(-1);
	}
#undef MON
}

char *
get_am(void)
{
  return nl_langinfo(AM_STR);
}

char *
get_pm(void)
{
  return nl_langinfo(PM_STR);
}

char *
get_d_t_fmt(void)
{
  return nl_langinfo(D_T_FMT);
}

char *
get_t_fmt(void)
{
  return nl_langinfo(T_FMT);
}

char *
get_d_fmt(void)
{
  return nl_langinfo(D_FMT);
}

char *
get_12h_fmt(void)
{
  return nl_langinfo(T_FMT_AMPM);
}
