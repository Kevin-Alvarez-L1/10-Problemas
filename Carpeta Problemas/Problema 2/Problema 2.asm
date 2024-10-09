// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Imprimir los enteros impares del 7 al 51.
.section .data
msg:    .asciz "Numero impar: %d\n"

.section .text
.global _start

_start:
    mov x0, 7          // Inicializar con el primer número impar
    bl print_odd       // Llamar a la función para imprimir

increment:
    add x0, x0, 2      // Incrementar por 2 para obtener el siguiente impar
    cmp x0, 51         // Comparar con el valor final
    ble print_odd      // Si es menor o igual, imprimir el siguiente impar
    b end              // Si no, finalizar el programa

print_odd:
    adrp x1, msg       // Cargar la dirección del mensaje
    add x1, x1, :lo12:msg
    mov x2, x0         // Pasar el número impar a imprimir
    bl printf          // Llamar a printf para imprimir
    ret

end:
    mov x8, 60         // Syscall para exit
    mov x0, 0          // Código de retorno 0
    svc 0              // Llamar al sistema para finalizar
