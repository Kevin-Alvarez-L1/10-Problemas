// ChatGTP 4o - Fecha: 2024-10-09
// Programa en ARM64 Assembly para RaspbianOS
// Escribir un programa que acepte 25 enteros positivos como datos y describir cada uno como “impar” o “par”.

.data
    prompt:    .asciz "Ingrese un entero positivo (0 para terminar): " // Mensaje para solicitar un número
    even_msg:  .asciz " es par\n"                                        // Mensaje para números pares
    odd_msg:   .asciz " es impar\n"                                      // Mensaje para números impares
    buffer:    .space 100                                                // Espacio reservado para almacenar el número ingresado
    num_count: .word 0                                                   // Contador de números leídos

.text
    .global _start

_start:
    // Inicializar el contador de números leídos
    mov x1, #0 // Inicializar el contador de números leídos a 0

input_loop:
    // Desplegar el mensaje para solicitar un número
    ldr x0, =1                  // Cargar en x0 el descriptor de archivo 1 (STDOUT)
    ldr x2, =prompt             // Cargar en x2 la dirección del mensaje "prompt"
    mov x3, #40                 // Cargar en x3 la longitud del mensaje (40 caracteres)
    mov x8, #64                 // Cargar en x8 el número de syscall para 'write' (64)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall

    // Leer un número del usuario
    ldr x0, =0                  // Cargar en x0 el descriptor de archivo 0 (STDIN)
    ldr x2, =buffer             // Cargar en x2 la dirección del buffer donde se almacenará el número ingresado
    mov x3, #100                // Cargar en x3 la longitud máxima a leer (100 caracteres)
    mov x8, #63                 // Cargar en x8 el número de syscall para 'read' (63)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall

    // Convertir el input a entero
    ldr x0, =buffer             // Cargar en x0 la dirección del buffer
    bl string_to_integer        // Llamar a la función para convertir la cadena a entero
    mov x2, x0                  // Mover el número convertido a x2 para procesarlo

    // Verificar si el número es cero
    cmp x2, #0                  // Comparar el número con cero
    beq end_input_loop          // Si es cero, salir del bucle de entrada

    // Determinar si el número es par o impar
    and x3, x2, #1              // Realizar un AND con 1 para verificar par/impar
    cmp x3, #0                  // Comparar el resultado con cero
    beq print_even              // Si es 0, es par
    b print_odd                 // Si no, es impar

print_even:
    // Imprimir mensaje "es par"
    ldr x0, =1                  // Cargar en x0 el descriptor de archivo 1 (STDOUT)
    ldr x1, =buffer             // Cargar en x1 la dirección del buffer que contiene el número
    mov x8, #64                 // Cargar en x8 el número de syscall para 'write' (64)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall

    ldr x1, =even_msg           // Cargar en x1 el mensaje "es par"
    mov x2, #9                  // Longitud del mensaje "es par" (9 caracteres)
    mov x8, #64                 // Cargar en x8 el número de syscall para 'write' (64)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall
    b input_loop                // Volver al bucle de entrada

print_odd:
    // Imprimir mensaje "es impar"
    ldr x0, =1                  // Cargar en x0 el descriptor de archivo 1 (STDOUT)
    ldr x1, =buffer             // Cargar en x1 la dirección del buffer que contiene el número
    mov x8, #64                 // Cargar en x8 el número de syscall para 'write' (64)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall

    ldr x1, =odd_msg            // Cargar en x1 el mensaje "es impar"
    mov x2, #10                 // Longitud del mensaje "es impar" (10 caracteres)
    mov x8, #64                 // Cargar en x8 el número de syscall para 'write' (64)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall
    b input_loop                // Volver al bucle de entrada

end_input_loop:
    // Terminar el programa
    mov x8, #93                 // Cargar en x8 el número de syscall para 'exit' (93)
    svc #0                      // Llamar al sistema operativo para ejecutar la syscall

// Función para convertir cadena a entero
// Entrada: dirección de la cadena en x0
// Salida: número entero en x0
string_to_integer:
    mov x1, #0                  // Inicializar el número a 0
    mov x3, #10                 // Base para la conversión (decimal)

next_digit:
    ldrb w2, [x0], #1           // Leer un byte de la cadena y avanzar al siguiente
    cmp w2, #10                  // Comparar con el carácter de nueva línea (10)
    beq end_conversion           // Si es nueva línea, terminar la conversión
    sub w2, w2, #48              // Convertir de ASCII a número (restar '0')
    mul x1, x1, x3               // Multiplicar el número actual por 10
    add x1, x1, w2               // Sumar el nuevo dígito
    b next_digit                 // Volver a leer el siguiente dígito

end_conversion:
    mov x0, x1                   // Mover el número resultante a x0
    ret
