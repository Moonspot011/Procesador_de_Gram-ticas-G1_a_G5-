%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex(void);
extern int yyparse(void);
extern FILE* yyin;
void yyerror(const char* s);

/* ====== Funciones que replican tu lógica de Python ====== */

// G1: palíndromos binarios (0/1)
static int check_g1(const char* s) {
    for (const char* p = s; *p; ++p) if (*p!='0' && *p!='1') return 0;
    size_t i = 0, j = strlen(s);
    if (j==0) return 1;         // por consistencia (en tu Python no entran líneas vacías)
    j--;
    while (i < j) if (s[i++] != s[j--]) return 0;
    return 1;
}

// G2: a^n b^{n+1}, n>=0
static int check_g2(const char* s) {
    int a=0,b=0; const char* p=s;
    while (*p=='a') { a++; p++; }
    while (*p=='b') { b++; p++; }
    if (*p!='\0') return 0;
    return b == a + 1;
}

// G3: a^n b^{2n+1}, n>=1
static int check_g3(const char* s) {
    int a=0,b=0; const char* p=s;
    while (*p=='a') { a++; p++; }
    while (*p=='b') { b++; p++; }
    if (*p!='\0') return 0;
    return (a >= 1) && (b == 2*a + 1);
}

// G4: "ab" o "abb"
static int check_g4(const char* s) {
    return (strcmp(s,"ab")==0) || (strcmp(s,"abb")==0);
}

// G5: a (ab)^n b, n>=0
static int check_g5(const char* s) {
    size_t len = strlen(s);
    if (len < 2) return 0;
    if (s[0] != 'a' || s[len-1] != 'b') return 0;
    if (len == 2) return 1; // "ab"
    for (size_t i=1; i+1 < len-1; i+=2)
        if (!(s[i]=='a' && s[i+1]=='b')) return 0;
    return ((len-2) % 2 == 0);
}

static int line_count = 0;
static int all_ok = 1;

static int matches_any_grammar(const char* s) {
    return check_g1(s) || check_g2(s) || check_g3(s) || check_g4(s) || check_g5(s);
}
%}

%union {
    char* str;
}

%token <str> LINE

%start input

%%

input
    : lines
    ;

lines
    : lines line
    | line
    ;

line
    : LINE            {
                         line_count++;
                         if (!matches_any_grammar($1)) all_ok = 0;
                         free($1);
                      }
    ;

%%

void yyerror(const char* s) { (void)s; /* silencioso */ }

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("NO acepta\n");
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("NO acepta\n");
        return 1;
    }

    yyparse();
    fclose(yyin);

    if (line_count == 0) {
        printf("NO acepta\n");   
    } else {
        printf(all_ok ? "acepta\n" : "NO acepta\n");
    }
    return 0;
}
