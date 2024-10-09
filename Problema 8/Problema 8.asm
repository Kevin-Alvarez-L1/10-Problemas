// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Determinar si un entero dado es un múltiplo de 6

.section .data
    prompt: .asciz "Ingrese un número entero: "
    msg_multiple: .asciz "El número es un múltiplo de 6.\n"
    msg_not_multiple: .asciz "El número NO es un múltiplo de 6.\n"
    buffer: .space 64

.section .text
    .global _start

_start:
    // Mostrar mensaje para ingresar un número
    mov x0, 1                  // File descriptor (stdout)
    ldr x1, =prompt
    ldr x2, =26                // Longitud del mensaje
    syscall

    // Leer entrada del usuario
    mov x0, 0                  // File descriptor (stdin)
    ldr x1, =buffer
    ldr x2, =64                // Tamaño del buffer
    syscall

    // Convertir la cadena a número entero
    ldr x0, =buffer
    bl atoi                    // Convertir a entero
    mov x1, x0                 // Guardar el número en x1

    // Calcular el resto de la división entre 6
    mov x2, 6                  // Divisor
    udiv x3, x1, x2            // x3 = x1 / 6
    mul x4, x3, x2             // x4 = x3 * 6
    sub x5, x1, x4             // x5 = x1 - (x3 * 6)

    // Verificar si el resto es cero
    cbz x5, is_multiple        // Si x5 es cero, es múltiplo de 6

not_multiple:
    // Mostrar mensaje de no múltiplo
    mov x0, 1                  // File descriptor (stdout)
    ldr x1, =msg_not_multiple
    ldr x2, =35                // Longitud del mensaje
    syscall
    b end_program              // Saltar al final

is_multiple:
    // Mostrar mensaje de múltiplo
    mov x0, 1                  // File descriptor (stdout)
    ldr x1, =msg_multiple
    ldr x2, =31                // Longitud del mensaje
    syscall

end_program:
    // Salir del programa
    mov x0, 0                  // Código de salida
    mov x8, 93                 // syscall: exit
    svc 0

// Función para convertir string a entero (atoi)
.type atoi, %function
atoi:
    // Implementación de la función atoi
    // Aquí debes incluir la lógica para convertir el string en buffer a un número entero.
    // Puedes utilizar cualquier algoritmo de conversión o la implementación de libc si es necesario.
    ret
.end
