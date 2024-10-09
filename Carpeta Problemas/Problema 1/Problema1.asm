// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Imprimir los enteros del 9 al 43.

.section .data
    buffer: .space 12          // Espacio para almacenar la cadena del número
    newline: .asciz "\n"       // Nueva línea

.section .text
.global _start

_start:
    mov x0, 9                  // Inicializar el contador con 9

print_loop:
    cmp x0, 44                 // Comparar el contador con 44
    bge end                    // Si el contador es mayor o igual a 44, salir del bucle

    // Convertir el número a cadena
    mov x1, x0                 // Copiar el número a x1
    mov x2, buffer             // Dirección de buffer
    bl itoa                    // Llamar a la función itoa

    // Escribir el número en stdout
    mov x0, 1                  // File descriptor (stdout)
    mov x2, x3                 // Longitud de la cadena
    mov x8, 64                 // syscall: write
    svc 0                      // Llamar al sistema

    // Escribir una nueva línea
    ldr x0, =newline           // Cargar la dirección de la nueva línea
    mov x2, 1                  // Longitud de la nueva línea
    mov x8, 64                 // syscall: write
    svc 0                      // Llamar al sistema

    add x0, x0, 1              // Incrementar el contador
    b print_loop               // Volver al inicio del bucle

end:
    mov x0, 0                  // Código de salida
    mov x8, 93                 // syscall: exit
    svc 0                      // Llamar al sistema

itoa:                           // Función para convertir entero a cadena
    mov x3, 0                  // Longitud de la cadena
itoa_loop:
    mov x4, 10                 // Divisor
    udiv x5, x1, x4            // x5 = x1 / 10
    mul x6, x5, x4             // x6 = x5 * 10
    sub x7, x1, x6             // x7 = x1 - x6
    add x7, x7, '0'            // Convertir a carácter ASCII
    strb w7, [x2, x3]          // Almacenar carácter en el buffer
    add x3, x3, 1              // Incrementar longitud
    mov x1, x5                 // Preparar el siguiente número
    cmp x5, 0                  // ¿El cociente es 0?
    bne itoa_loop              // Si no, continuar el bucle

    // Invertir la cadena
    mov x4, x3                 // Longitud total
    lsr x4, x4, 1              // Dividir longitud entre 2
    mov x5, 0                  // Índice inicial
reverse_loop:
    cmp x5, x4                 // Comparar índices
    bge reverse_done           // Si se ha terminado, salir
    ldrb w6, [x2, x5]          // Cargar carácter en el índice inicial
    ldrb w7, [x2, x3, lsl #0]  // Cargar carácter en el índice final
    strb w7, [x2, x5]          // Intercambiar caracteres
    strb w6, [x2, x3, lsl #0]  // Intercambiar caracteres
    add x5, x5, 1              // Incrementar índice inicial
    sub x3, x3, 1              // Decrementar índice final
    b reverse_loop             // Repetir

reverse_done:
    strb wzr, [x2, x3]         // Null-terminator para la cadena
    mov x0, x1                 // Devolver el número original
    mov x3, x3                 // Devolver la longitud
    ret
