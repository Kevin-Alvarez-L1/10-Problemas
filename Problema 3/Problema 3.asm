// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Imprimir los enteros pares del 2 al 48.

.section .data
    msg: .asciz "%d\n"      // Formato de salida para printf
    start: .word 2          // Valor inicial (2)
    end: .word 48           // Valor final (48)

.section .text
    .global _start

_start:
    // Inicializar el registro con el valor inicial
    ldr x0, =start          // Cargar la dirección de start
    ldr w0, [x0]            // Cargar el valor inicial en w0

loop:
    // Comprobar si el valor es mayor que 48
    ldr x1, =end            // Cargar la dirección de end
    ldr w1, [x1]            // Cargar el valor final en w1
    cmp w0, w1              // Comparar w0 con w1
    bgt exit                // Si w0 > w1, salir del bucle

    // Imprimir el número par
    ldr x2, =msg            // Cargar la dirección del mensaje
    mov x0, w0              // Mover el número a imprimir a x0
    bl printf               // Llamar a printf

    // Incrementar en 2
    add w0, w0, #2          // w0 = w0 + 2
    b loop                  // Volver al inicio del bucle

exit:
    // Terminar el programa
    mov x0, #0              // Código de salida
    mov x8, #93             // syscall: exit
    svc 0                   // Llamar al sistema
