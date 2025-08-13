%{
#include "gramatica.tab.h"
#include <stdlib.h>
#include <string.h>

static char* trim_copy(const char* s, size_t n) {
    // copia s[0..n) quitando espacios/tabs al inicio y fin
    size_t start = 0, end = n;
    while (start < n && (s[start]==' ' || s[start]=='\t' || s[start]=='\r')) start++;
    while (end > start && (s[end-1]==' ' || s[end-1]=='\t' || s[end-1]=='\r')) end--;
    size_t outlen = end - start;
    char* out = (char*)malloc(outlen + 1);
    if (!out) exit(1);
    memcpy(out, s + start, outlen);
    out[outlen] = '\0';
    return out;
}
%}

%option noyywrap

%%

^[ \t]*\n              { }

^[^\n]*\n             {
                        /* tomar la línea completa sin el '\n' final */
                        size_t n = yyleng;
                        if (n == 0) return 0;
                        if (yytext[n-1] == '\n') n--;

                        char* t = trim_copy(yytext, n);
                        if (t[0] == '\0') { free(t); /* quedaba vacía tras trim -> ignora */ }
                        else { yylval.str = t; return LINE; }
                      }

<<EOF>>               { return 0; }
.                     { /* ignora cualquier basura suelta */ }

%%
