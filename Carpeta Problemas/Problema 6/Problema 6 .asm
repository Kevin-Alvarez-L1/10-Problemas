// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Convertir pulgadas a yardas, y pies a pulgadas.

.section .data
    prompt_inches: .asciz "Ingrese la medida en pulgadas: "
    prompt_feet:   .asciz "Ingrese la medida en pies: "
    result_yards:  .asciz "La medida en yardas es: %f\n"
    result_inches: .asciz "La medida en pulgadas es: %f\n"
    buffer:        .space 64

.section .text
    .global _start

_start:
    // Convertir pulgadas a yardas
    // Mostrar mensaje para ingresar pulgadas
    mov x0, 1                      // File descriptor (stdout)
    ldr x1, =prompt_inches
    ldr x2, =28                    // Length of the prompt
    syscall

    // Leer entrada de pulgadas
    mov x0, 0                      // File descriptor (stdin)
    ldr x1, =buffer
    ldr x2, =64                    // Size of buffer
    syscall

    // Convertir entrada a número (asumiendo que se ingresa como float)
    ldr x0, =buffer
    bl atof                        // Convertir a float
    fmov s0, s0                    // Guardar el valor en s0 (pulgadas)

    // Realizar la conversión a yardas
    fdiv s1, s0, #36.0            // yardas = pulgadas / 36
    ldr x0, =result_yards
    fmov s2, s1                    // Guardar el resultado para imprimir
    bl printf                      // Imprimir resultado

    // Convertir pies a pulgadas
    // Mostrar mensaje para ingresar pies
    mov x0, 1                      // File descriptor (stdout)
    ldr x1, =prompt_feet
    ldr x2, =28                    // Length of the prompt
    syscall

    // Leer entrada de pies
    mov x0, 0                      // File descriptor (stdin)
    ldr x1, =buffer
    ldr x2, =64                    // Size of buffer
    syscall

    // Convertir entrada a número (asumiendo que se ingresa como float)
    ldr x0, =buffer
    bl atof                        // Convertir a float
    fmov s0, s0                    // Guardar el valor en s0 (pies)

    // Realizar la conversión a pulgadas
    fmul s1, s0, #12.0            // pulgadas = pies * 12
    ldr x0, =result_inches
    fmov s2, s1                    // Guardar el resultado para imprimir
    bl printf                      // Imprimir resultado

    // Salir del programa
    mov x0, 0                      // Código de salida
    mov x8, 93                     // syscall: exit
    svc 0

// Función para convertir string a float (atof)
.type atof, %function
atof:
    // Implementación de la función atof
    // Aquí debes incluir la lógica para convertir el string en buffer a un número de punto flotante.
    // Puedes utilizar cualquier algoritmo de conversión o la implementación de libc si es necesario.
    ret
.end


