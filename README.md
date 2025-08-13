Procesador de Gramáticas (G1 a G5)
📌 Descripción
Este proyecto implementa un verificador de cadenas para cinco gramáticas formales definidas en la presentación (páginas 31 a 35 del PDF).
Existen dos implementaciones:

Python: Implementación sencilla y directa de las funciones de validación.

C con Flex/Bison: Implementación equivalente que utiliza un analizador léxico y sintáctico.

El programa lee un archivo de texto con varias cadenas, una por línea, y determina si todas cumplen alguna de las cinco gramáticas.

Si todas las líneas cumplen al menos una gramática → se imprime acepta.

Si alguna línea no cumple ninguna gramática o no hay líneas válidas → se imprime NO acepta.

📜 Gramáticas
G1: Palíndromos binarios (alfabeto {0,1}).

G2: a^n b^(n+1) , n≥0.

G3: a^n b^(2n+1) , n≥1.

G4: Solo "ab" o "abb".

G5: a(ab)^n b, n≥0.

📂 Estructura de archivos
/Proyecto
│── gramatica.py         # Versión en Python

│── gramatica.l          # Lexer en Flex

│── gramatica.y          # Parser en Bison

│── cadenas.txt          # Archivo de prueba con cadenas

│── README.md            # Este documento

▶ Ejecución en Python
Guardar las cadenas de prueba en cadenas.txt (una por línea).

Ejecutar:

python3 gramatica.py cadenas.txt
Ejemplo de salida:

acepta

▶ Ejecución en C con Flex/Bison
Compilar:

bison -d gramatica.y
flex gramatica.l
gcc -o gramatica gramatica.tab.c lex.yy.c -lfl    # -ll en mac

Ejecutar:

./gramatica cadenas.txt

Ejemplo de salida:

NO acepta

📌 Notas importantes
El archivo de entrada no debe tener líneas vacías (o serán ignoradas).

El verificador funciona por línea completa, no por subcadenas.

La lógica de validación es idéntica en ambas versiones.

En Flex/Bison, el lexer no clasifica cadenas por patrón sino que envía cada línea al parser, que replica las funciones de validación de Python.
