       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISTA-ENLAZADA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *----------------------------------------------------------------
      * Tabla de nodos (simula heap, maximo 100 nodos)
      * Indice 0 significa nil (sin siguiente)
      *----------------------------------------------------------------
       01 WS-NODO-TABLA OCCURS 100 TIMES.
           05 WS-DATO         PIC S9(9).
           05 WS-SIGUIENTE    PIC 9(3) VALUE 0.
           05 WS-LIBRE        PIC 9 VALUE 1.

      *----------------------------------------------------------------
      * Control de lista y variables auxiliares
      *----------------------------------------------------------------
       01 WS-CABEZA           PIC 9(3) VALUE 0.
       01 WS-OPCION           PIC 9 VALUE 9.
       01 WS-VALOR            PIC S9(9) VALUE 0.
       01 WS-NUEVO-IDX        PIC 9(3) VALUE 0.
       01 WS-ACTUAL-IDX       PIC 9(3) VALUE 0.
       01 WS-ANTERIOR-IDX     PIC 9(3) VALUE 0.
       01 WS-ENCONTRADO-IDX   PIC 9(3) VALUE 0.
       01 WS-IDX              PIC 9(3) VALUE 0.
       01 WS-CONTADOR         PIC 9(3) VALUE 0.
       01 WS-NODO-HALLADO     PIC 9 VALUE 0.
       01 WS-INPUT-LINE       PIC X(20) VALUE SPACES.

      *================================================================
       PROCEDURE DIVISION.
      *================================================================

       MAIN-PARA.
           PERFORM MENU-LOOP UNTIL WS-OPCION = 0
           PERFORM LIBERAR-LISTA
           STOP RUN.

      *----------------------------------------------------------------
      * MENU PRINCIPAL
      *----------------------------------------------------------------
       MENU-LOOP.
           DISPLAY " " UPON SYSOUT
           DISPLAY "========================" UPON SYSOUT
           DISPLAY "   LISTAS ENLAZADAS" UPON SYSOUT
           DISPLAY "========================" UPON SYSOUT
           DISPLAY "1. Insertar al inicio" UPON SYSOUT
           DISPLAY "2. Insertar al final" UPON SYSOUT
           DISPLAY "3. Mostrar lista" UPON SYSOUT
           DISPLAY "4. Buscar elemento" UPON SYSOUT
           DISPLAY "5. Eliminar elemento" UPON SYSOUT
           DISPLAY "6. Contar nodos" UPON SYSOUT
           DISPLAY "0. Salir" UPON SYSOUT
           DISPLAY "Opcion: " UPON SYSOUT
           ACCEPT WS-INPUT-LINE FROM SYSIN
           MOVE FUNCTION NUMVAL(WS-INPUT-LINE(1:1)) TO WS-OPCION

           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM CASO-INSERTAR-INICIO
               WHEN 2
                   PERFORM CASO-INSERTAR-FINAL
               WHEN 3
                   PERFORM MOSTRAR-LISTA
               WHEN 4
                   PERFORM CASO-BUSCAR
               WHEN 5
                   PERFORM CASO-ELIMINAR
               WHEN 6
                   PERFORM CONTAR-NODOS
                   DISPLAY "Cantidad de nodos: " WS-CONTADOR
                       UPON SYSOUT
               WHEN 0
                   DISPLAY "Saliendo..." UPON SYSOUT
               WHEN OTHER
                   DISPLAY "Opcion invalida" UPON SYSOUT
           END-EVALUATE.

      *----------------------------------------------------------------
      * CREAR NODO: busca slot libre, retorna indice en WS-NUEVO-IDX
      *----------------------------------------------------------------
       CREAR-NODO.
           MOVE 0 TO WS-NUEVO-IDX
           PERFORM VARYING WS-IDX FROM 1 BY 1
               UNTIL WS-IDX > 100 OR WS-NUEVO-IDX > 0
               IF WS-LIBRE(WS-IDX) = 1
                   MOVE WS-IDX TO WS-NUEVO-IDX
                   MOVE WS-VALOR TO WS-DATO(WS-IDX)
                   MOVE 0 TO WS-SIGUIENTE(WS-IDX)
                   MOVE 0 TO WS-LIBRE(WS-IDX)
               END-IF
           END-PERFORM
           IF WS-NUEVO-IDX = 0
               DISPLAY "Error: no hay espacio disponible" UPON SYSOUT
           END-IF.

      *----------------------------------------------------------------
      * INSERTAR AL INICIO
      *----------------------------------------------------------------
       INSERTAR-INICIO.
           PERFORM CREAR-NODO
           IF WS-NUEVO-IDX > 0
               MOVE WS-CABEZA TO WS-SIGUIENTE(WS-NUEVO-IDX)
               MOVE WS-NUEVO-IDX TO WS-CABEZA
           END-IF.

       CASO-INSERTAR-INICIO.
           DISPLAY "Valor: " UPON SYSOUT
           ACCEPT WS-INPUT-LINE FROM SYSIN
           MOVE FUNCTION NUMVAL(WS-INPUT-LINE) TO WS-VALOR
           PERFORM INSERTAR-INICIO
           PERFORM CONTAR-NODOS
           DISPLAY "Nodo insertado al inicio. Total: " WS-CONTADOR
               UPON SYSOUT.

      *----------------------------------------------------------------
      * INSERTAR AL FINAL
      *----------------------------------------------------------------
       INSERTAR-FINAL.
           PERFORM CREAR-NODO
           IF WS-NUEVO-IDX > 0
               IF WS-CABEZA = 0
                   MOVE WS-NUEVO-IDX TO WS-CABEZA
               ELSE
                   MOVE WS-CABEZA TO WS-ACTUAL-IDX
                   PERFORM UNTIL WS-SIGUIENTE(WS-ACTUAL-IDX) = 0
                       MOVE WS-SIGUIENTE(WS-ACTUAL-IDX)
                           TO WS-ACTUAL-IDX
                   END-PERFORM
                   MOVE WS-NUEVO-IDX
                       TO WS-SIGUIENTE(WS-ACTUAL-IDX)
               END-IF
           END-IF.

       CASO-INSERTAR-FINAL.
           DISPLAY "Valor: " UPON SYSOUT
           ACCEPT WS-INPUT-LINE FROM SYSIN
           MOVE FUNCTION NUMVAL(WS-INPUT-LINE) TO WS-VALOR
           PERFORM INSERTAR-FINAL
           PERFORM CONTAR-NODOS
           DISPLAY "Nodo insertado al final. Total: " WS-CONTADOR
               UPON SYSOUT.

      *----------------------------------------------------------------
      * MOSTRAR LISTA
      *----------------------------------------------------------------
       MOSTRAR-LISTA.
           IF WS-CABEZA = 0
               DISPLAY "La lista esta vacia" UPON SYSOUT
           ELSE
               MOVE WS-CABEZA TO WS-ACTUAL-IDX
               DISPLAY "Lista:" UPON SYSOUT
               PERFORM UNTIL WS-ACTUAL-IDX = 0
                   DISPLAY "  " WS-DATO(WS-ACTUAL-IDX)
                       " ->" UPON SYSOUT
                   MOVE WS-SIGUIENTE(WS-ACTUAL-IDX)
                       TO WS-ACTUAL-IDX
               END-PERFORM
               DISPLAY "  NULL" UPON SYSOUT
           END-IF.

      *----------------------------------------------------------------
      * BUSCAR ELEMENTO
      *----------------------------------------------------------------
       BUSCAR-ELEMENTO.
           MOVE 0 TO WS-ENCONTRADO-IDX
           MOVE WS-CABEZA TO WS-ACTUAL-IDX
           PERFORM UNTIL WS-ACTUAL-IDX = 0
               OR WS-ENCONTRADO-IDX > 0
               IF WS-DATO(WS-ACTUAL-IDX) = WS-VALOR
                   MOVE WS-ACTUAL-IDX TO WS-ENCONTRADO-IDX
               ELSE
                   MOVE WS-SIGUIENTE(WS-ACTUAL-IDX)
                       TO WS-ACTUAL-IDX
               END-IF
           END-PERFORM.

       CASO-BUSCAR.
           DISPLAY "Valor a buscar: " UPON SYSOUT
           ACCEPT WS-INPUT-LINE FROM SYSIN
           MOVE FUNCTION NUMVAL(WS-INPUT-LINE) TO WS-VALOR
           PERFORM BUSCAR-ELEMENTO
           IF WS-ENCONTRADO-IDX > 0
               DISPLAY "Elemento encontrado: "
                   WS-DATO(WS-ENCONTRADO-IDX) UPON SYSOUT
           ELSE
               DISPLAY "Elemento no encontrado" UPON SYSOUT
           END-IF.

      *----------------------------------------------------------------
      * ELIMINAR NODO
      *----------------------------------------------------------------
       ELIMINAR-NODO.
           IF WS-CABEZA = 0
               DISPLAY "La lista esta vacia" UPON SYSOUT
           ELSE
               MOVE WS-CABEZA TO WS-ACTUAL-IDX
               MOVE 0 TO WS-ANTERIOR-IDX

               IF WS-DATO(WS-ACTUAL-IDX) = WS-VALOR
                   MOVE WS-SIGUIENTE(WS-ACTUAL-IDX) TO WS-CABEZA
                   MOVE 1 TO WS-LIBRE(WS-ACTUAL-IDX)
                   DISPLAY "Elemento eliminado" UPON SYSOUT
               ELSE
                   MOVE 0 TO WS-NODO-HALLADO
                   PERFORM UNTIL WS-ACTUAL-IDX = 0
                       OR WS-NODO-HALLADO = 1
                       IF WS-DATO(WS-ACTUAL-IDX) = WS-VALOR
                           MOVE 1 TO WS-NODO-HALLADO
                       ELSE
                           MOVE WS-ACTUAL-IDX TO WS-ANTERIOR-IDX
                           MOVE WS-SIGUIENTE(WS-ACTUAL-IDX)
                               TO WS-ACTUAL-IDX
                       END-IF
                   END-PERFORM

                   IF WS-ACTUAL-IDX = 0
                       DISPLAY "Elemento no encontrado" UPON SYSOUT
                   ELSE
                       MOVE WS-SIGUIENTE(WS-ACTUAL-IDX)
                           TO WS-SIGUIENTE(WS-ANTERIOR-IDX)
                       MOVE 1 TO WS-LIBRE(WS-ACTUAL-IDX)
                       DISPLAY "Elemento eliminado" UPON SYSOUT
                   END-IF
               END-IF
           END-IF.

       CASO-ELIMINAR.
           DISPLAY "Valor a eliminar: " UPON SYSOUT
           ACCEPT WS-INPUT-LINE FROM SYSIN
           MOVE FUNCTION NUMVAL(WS-INPUT-LINE) TO WS-VALOR
           PERFORM ELIMINAR-NODO
           PERFORM CONTAR-NODOS
           DISPLAY "Total de nodos: " WS-CONTADOR UPON SYSOUT.

      *----------------------------------------------------------------
      * CONTAR NODOS
      *----------------------------------------------------------------
       CONTAR-NODOS.
           MOVE 0 TO WS-CONTADOR
           MOVE WS-CABEZA TO WS-ACTUAL-IDX
           PERFORM UNTIL WS-ACTUAL-IDX = 0
               ADD 1 TO WS-CONTADOR
               MOVE WS-SIGUIENTE(WS-ACTUAL-IDX) TO WS-ACTUAL-IDX
           END-PERFORM.

      *----------------------------------------------------------------
      * LIBERAR LISTA
      *----------------------------------------------------------------
       LIBERAR-LISTA.
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 100
               MOVE 1 TO WS-LIBRE(WS-IDX)
           END-PERFORM
           MOVE 0 TO WS-CABEZA.
