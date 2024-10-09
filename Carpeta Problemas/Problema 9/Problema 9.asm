// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Introducir un número y determinar si es “par” o “impar”.

.section .data
    prompt: .asciz "Ingrese un número entero: "
    msg_even: .asciz "El número es par.\n"
    msg_odd: .asciz "El número es impar.\n"
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

    // Verificar si el número es par o impar
    and x2, x1, #1             // x2 = x1 & 1 (verifica el bit menos significativo)

    // Si el resultado es 0, es par
    cbz x2, is_even            // Si x2 es cero, salta a is_even

is_odd:
    // Mostrar mensaje de impar
    mov x0, 1                  // File descriptor (stdout)
    ldr x1, =msg_odd
    ldr x2, =25                // Longitud del mensaje
    syscall
    b end_program              // Saltar al final

is_even:
    // Mostrar mensaje de par
    mov x0, 1                  // File descriptor (stdout)
    ldr x1, =msg_even
    ldr x2, =26                // Longitud del mensaje
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
