// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Imprimir los enteros del 1 al 30, apareados con sus recíprocos.
.section .data
msg:    .asciz "Número: %d, Recíproco: %.5f\n"  // Formato para printf

.section .text
.global _start

_start:
    mov x0, 1          // Inicializar con el primer número entero
    b increment         // Saltar a la sección de incremento

increment:
    cmp x0, 30         // Comparar con el valor final (30)
    bgt end            // Si es mayor que 30, finalizar el programa

    // Imprimir el número y su recíproco
    bl print_rec       // Llamar a la función para imprimir

    add x0, x0, 1      // Incrementar por 1 para el siguiente número
    b increment         // Volver a la sección de incremento

print_rec:
    adrp x1, msg       // Cargar la dirección base del mensaje
    add x1, x1, :lo12:msg
    scvtf d0, x0       // Convertir el número entero a flotante (d0)
    
    // Calcular el recíproco
    fmov d1, #1.0      // Mover 1.0 a d1
    fdiv d1, d1, d0    // Dividir 1.0 por el número entero para obtener el recíproco
    
    // Llamar a printf
    mov x0, x0         // Mover el número entero a x0 (para printf)
    mov x2, d1         // Mover el recíproco a x2 (para printf)
    bl printf          // Llamar a printf
    ret

end:
    mov x8, 93         // Syscall para exit
    mov x0, 0          // Código de retorno 0
    svc 0              // Llamar al sistema para finalizar
