import sys

def check_g1(input_string):
    """L(G1): Números capicúa con 0 y 1"""
    return input_string == input_string[::-1] and all(c in '01' for c in input_string)

def check_g2(input_string):
    """L(G2): a^n b^{n+1} donde n >= 0"""
    # Caso especial para solo "b"
    if input_string == "b":
        return True
    
    # Verificar que solo contiene 'a's y 'b's
    if not all(c in 'ab' for c in input_string):
        return False
    
    # Verificar que todas las 'a's están primero
    if 'ba' in input_string:
        return False
    
    a_count = input_string.count('a')
    b_count = input_string.count('b')
    
    return b_count == a_count + 1

def check_g3(input_string):
    """L(G3): a^n b^{2n+1} donde n >= 1"""
    if not all(c in 'ab' for c in input_string):
        return False
    a_count = input_string.count('a')
    b_count = input_string.count('b')
    return (b_count == 2 * a_count + 1) and (a_count >= 1)

def check_g4(input_string):
    """L(G4): abb o ab"""
    return input_string in ['ab', 'abb']

def check_g5(input_string):
    """L(G5): a(ab)^n b donde n >= 0"""
    if len(input_string) < 2 or input_string[0] != 'a' or input_string[-1] != 'b':
        return False
    if len(input_string) == 2:
        return True  # "ab"
    middle = input_string[1:-1]
    return all(middle[i:i+2] == 'ab' for i in range(0, len(middle), 2))


def get_matching_grammars(input_string):
    """Devuelve lista de gramáticas que cumplen con la cadena"""
    grammars = []
    if check_g1(input_string): grammars.append(1)
    if check_g2(input_string): grammars.append(2)
    if check_g3(input_string): grammars.append(3)
    if check_g4(input_string): grammars.append(4)
    if check_g5(input_string): grammars.append(5)
    return grammars

def main():
    if len(sys.argv) != 2:
        print("Uso: python gramatica.py archivo.txt")
        sys.exit(1)

    try:
        with open(sys.argv[1], 'r') as file:
            lines = [line.strip() for line in file if line.strip()]
            if not lines:
                print("NO acepta")
                return

            # Verificar que cada línea cumpla AL MENOS UNA gramática
            for line in lines:
                if not get_matching_grammars(line):
                    print("NO acepta")
                    return

            print("acepta")

    except FileNotFoundError:
        print(f"Error: Archivo {sys.argv[1]} no encontrado")
        sys.exit(1)

if __name__ == "__main__":
    main()