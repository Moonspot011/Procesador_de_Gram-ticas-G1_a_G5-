#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_palindrome(const char *str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1]) {
            return false;
        }
    }
    return true;
}

bool check_grammar(int grammar_num, const char *input) {
    int a_count = 0, b_count = 0;
    int len = strlen(input);
    
    switch (grammar_num) {
        case 1: // L(G1): Números capicúa con 0 y 1
            return is_palindrome(input);
            
        case 2: { // L(G2): a^n b^{n+1} donde n >= 0
            bool in_b_section = false;
            for (int i = 0; i < len; i++) {
                if (input[i] == 'a') {
                    if (in_b_section) return false;
                    a_count++;
                } else if (input[i] == 'b') {
                    in_b_section = true;
                    b_count++;
                } else {
                    return false;
                }
            }
            return (b_count == a_count + 1) && (a_count >= 0);
        }
            
        case 3: { // L(G3): a^n b^{3n} donde n >= 1
            bool in_b_section = false;
            for (int i = 0; i < len; i++) {
                if (input[i] == 'a') {
                    if (in_b_section) return false;
                    a_count++;
                } else if (input[i] == 'b') {
                    in_b_section = true;
                    b_count++;
                } else {
                    return false;
                }
            }
            return (b_count == 3 * a_count) && (a_count >= 1);
        }
            
        case 4: // L(G4): abb o ab
            return (strcmp(input, "abb") == 0) || (strcmp(input, "ab") == 0);
            
        case 5: { // L(G5): a(ab)^n b donde n >= 0
            if (len < 2 || input[0] != 'a' || input[len-1] != 'b') {
                return false;
            }
            if (len == 2) return true; // caso "ab"
            
            for (int i = 1; i < len - 1; i += 2) {
                if (i + 1 >= len - 1) return false;
                if (input[i] != 'a' || input[i+1] != 'b') {
                    return false;
                }
            }
            return true;
        }
            
        default:
            return false;
    }
}

int main() {
    FILE *file;
    char filename[20];
    char line[100];
    
    for (int i = 1; i <= 5; i++) {
        snprintf(filename, sizeof(filename), "gramatica_G%d.txt", i);
        file = fopen(filename, "r");
        
        if (file == NULL) {
            printf("Archivo %s no encontrado, omitiendo G%d\n", filename, i);
            continue;
        }
        
        printf("\nProbando gramatica G%d:\n", i);
        while (fgets(line, sizeof(line), file)) {
            // Eliminar el salto de línea
            line[strcspn(line, "\n")] = '\0';
            
            if (check_grammar(i, line)) {
                printf("'%s' - acepta\n", line);
            } else {
                printf("'%s' - NO acepta\n", line);
            }
        }
        fclose(file);
    }
    
    return 0;
}