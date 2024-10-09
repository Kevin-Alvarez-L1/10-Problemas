// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Determinar si un número dado es divisible entre 14.

.section .data
prompt: .asciz "Ingrese un número: "
div_msg: .asciz "El número es divisible entre 14.\n"
not_div_msg: .asciz "El número no es divisible entre 14.\n"

.section .bss
.comm num, 8         // Reservar espacio para el número

.section .text
.global _start

_start:
    adrp x1, prompt
    add x1, x1, :lo12:prompt
    bl printf            // Imprimir mensaje de entrada

    bl scanf             // Leer número ingresado
    ldr x2, [num]        // Cargar el número en x2

    mov x3, 14           // Cargar 14 en x3
    udiv x4, x2, x3      // Dividir x2 por 14
    msub x5, x4, x3, x2  // Calcular el residuo (x5 = x2 - (x4 * x3))

    cbz x5, divisible    // Si el residuo es 0, es divisible

    // Si no es divisible
    adrp x1, not_div_msg
    add x1, x1, :lo12:not_div_msg
    bl printf
    b end

divisible:
    // Si es divisible
    adrp x1, div_msg
    add x1, x1, :lo12:div_msg
    bl printf

end:
    mov x8, 60           // Syscall para exit
    mov x0, 0            // Código de retorno 0
    svc 0                // Llamar al sistema para finalizar
