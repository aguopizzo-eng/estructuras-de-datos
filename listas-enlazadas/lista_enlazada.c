#include <stdio.h>
#include <stdlib.h>

typedef struct Nodo {
    int dato;
    struct Nodo* siguiente;
} Nodo;

Nodo* crearNodo(int valor) {
    Nodo* nuevo = malloc(sizeof(Nodo));
    if (nuevo == NULL) { printf("Error al reservar memoria\n"); return NULL; }
    nuevo->dato = valor;
    nuevo->siguiente = NULL;
    return nuevo;
}

void insertarInicio(Nodo** cabeza, int valor) {
    Nodo* nuevo = crearNodo(valor);
    if (nuevo == NULL) return;
    nuevo->siguiente = *cabeza;
    *cabeza = nuevo;
}

void insertarFinal(Nodo** cabeza, int valor) {
    Nodo* nuevo = crearNodo(valor);
    if (nuevo == NULL) return;
    if (*cabeza == NULL) { *cabeza = nuevo; return; }
    Nodo* actual = *cabeza;
    while (actual->siguiente != NULL) actual = actual->siguiente;
    actual->siguiente = nuevo;
}

void mostrarLista(Nodo* cabeza) {
    if (cabeza == NULL) { printf("La lista esta vacia\n"); return; }
    printf("Lista: ");
    Nodo* actual = cabeza;
    while (actual != NULL) { printf("%d -> ", actual->dato); actual = actual->siguiente; }
    printf("NULL\n");
}

Nodo* buscar(Nodo* cabeza, int valor) {
    Nodo* actual = cabeza;
    while (actual != NULL) { if (actual->dato == valor) return actual; actual = actual->siguiente; }
    return NULL;
}

void eliminarNodo(Nodo** cabeza, int valor) {
    if (*cabeza == NULL) { printf("La lista esta vacia\n"); return; }
    Nodo* actual = *cabeza;
    Nodo* anterior = NULL;
    if (actual->dato == valor) { *cabeza = actual->siguiente; free(actual); printf("Elemento eliminado\n"); return; }
    while (actual != NULL && actual->dato != valor) { anterior = actual; actual = actual->siguiente; }
    if (actual == NULL) { printf("Elemento no encontrado\n"); return; }
    anterior->siguiente = actual->siguiente;
    free(actual);
    printf("Elemento eliminado\n");
}

int contarNodos(Nodo* cabeza) {
    int c = 0; Nodo* actual = cabeza;
    while (actual != NULL) { c++; actual = actual->siguiente; }
    return c;
}

void liberarLista(Nodo** cabeza) {
    Nodo* actual = *cabeza;
    while (actual != NULL) { Nodo* temp = actual; actual = actual->siguiente; free(temp); }
    *cabeza = NULL;
}

int leerEntero(const char* mensaje) {
    char buf[64];
    int valor;
    while (1) {
        printf("%s", mensaje);
        if (fgets(buf, sizeof(buf), stdin) == NULL) { printf("Error de entrada\n"); exit(1); }
        if (sscanf(buf, "%d", &valor) == 1) return valor;
        printf("Entrada invalida, ingrese un numero\n");
    }
}

int main() {
    Nodo* lista = NULL;
    int opcion, valor;

    do {
        printf("\n========================\n");
        printf("   LISTAS ENLAZADAS\n");
        printf("========================\n");
        printf("1. Insertar al inicio\n");
        printf("2. Insertar al final\n");
        printf("3. Mostrar lista\n");
        printf("4. Buscar elemento\n");
        printf("5. Eliminar elemento\n");
        printf("6. Contar nodos\n");
        printf("0. Salir\n");

        opcion = leerEntero("\nOpcion: ");

        switch (opcion) {
            case 1:
                valor = leerEntero("Valor: ");
                insertarInicio(&lista, valor);
                printf("Nodo insertado al inicio. Total: %d\n", contarNodos(lista));
                break;
            case 2:
                valor = leerEntero("Valor: ");
                insertarFinal(&lista, valor);
                printf("Nodo insertado al final. Total: %d\n", contarNodos(lista));
                break;
            case 3:
                mostrarLista(lista);
                break;
            case 4:
                valor = leerEntero("Valor a buscar: ");
                Nodo* encontrado = buscar(lista, valor);
                if (encontrado != NULL) printf("Elemento encontrado: %d\n", encontrado->dato);
                else printf("Elemento no encontrado\n");
                break;
            case 5:
                valor = leerEntero("Valor a eliminar: ");
                eliminarNodo(&lista, valor);
                printf("Total de nodos: %d\n", contarNodos(lista));
                break;
            case 6:
                printf("Cantidad de nodos: %d\n", contarNodos(lista));
                break;
            case 0:
                printf("Saliendo...\n");
                break;
            default:
                printf("Opcion invalida\n");
        }
    } while (opcion != 0);

    liberarLista(&lista);
    return 0;
}
