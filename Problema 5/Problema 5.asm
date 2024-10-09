// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Imprimir una tabla de potencias del 2 que no exceda al 1,000.

.section .data
    msg:    .asciz "2^%d = %d\n"   // Mensaje para imprimir
    limit:  .quad 1000             // Limite superior

.section .bss
    power:  .skip 8                // Espacio para almacenar la potencia actual
    exp:    .skip 8                // Espacio para almacenar el exponente actual

.section .text
.global _start

_start:
    mov x0, 0                       // Inicializar el exponente (x0 = 0)
    mov x1, 1                       // Inicializar la potencia (x1 = 2^0 = 1)

loop:
    // Imprimir la potencia
    mov x2, x0                      // Cargar el exponente
    mov x3, x1                      // Cargar la potencia
    ldr x4, =msg                    // Cargar la dirección del mensaje
    bl printf                       // Llamar a printf

    // Calcular la siguiente potencia de 2
    add x0, x0, 1                   // Incrementar el exponente (exponente++)
    shl x1, x1, 1                   // Multiplicar la potencia por 2 (potencia *= 2)

    // Verificar si la potencia excede 1000
    ldr x5, =limit                  // Cargar el límite
    cmp x1, x5                      // Comparar potencia con el límite
    b.lt loop                       // Si potencia < límite, continuar el bucle

    // Salir del programa
    mov x0, 0                       // Código de salida 0
    mov x8, 93                      // Llamada al sistema: exit
    svc 0                           // Invocar al sistema
