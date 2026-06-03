import java.util.Scanner;

public class ListaEnlazada {

    // ----------------------------------------------------------------
    // Clase interna que representa un nodo
    // ----------------------------------------------------------------
    static class Nodo {
        int dato;
        Nodo siguiente;

        Nodo(int dato) {
            this.dato = dato;
            this.siguiente = null;
        }
    }

    // ----------------------------------------------------------------
    // Referencia a la cabeza de la lista
    // ----------------------------------------------------------------
    private Nodo cabeza = null;

    // ----------------------------------------------------------------
    // Insertar al inicio
    // ----------------------------------------------------------------
    public void insertarInicio(int valor) {
        Nodo nuevo = new Nodo(valor);
        nuevo.siguiente = cabeza;
        cabeza = nuevo;
    }

    // ----------------------------------------------------------------
    // Insertar al final
    // ----------------------------------------------------------------
    public void insertarFinal(int valor) {
        Nodo nuevo = new Nodo(valor);

        if (cabeza == null) {
            cabeza = nuevo;
            return;
        }

        Nodo actual = cabeza;
        while (actual.siguiente != null) {
            actual = actual.siguiente;
        }
        actual.siguiente = nuevo;
    }

    // ----------------------------------------------------------------
    // Mostrar lista
    // ----------------------------------------------------------------
    public void mostrarLista() {
        if (cabeza == null) {
            System.out.println("La lista esta vacia");
            return;
        }

        StringBuilder sb = new StringBuilder("Lista: ");
        Nodo actual = cabeza;
        while (actual != null) {
            sb.append(actual.dato).append(" -> ");
            actual = actual.siguiente;
        }
        sb.append("NULL");
        System.out.println(sb);
    }

    // ----------------------------------------------------------------
    // Buscar elemento — retorna el nodo o null si no existe
    // ----------------------------------------------------------------
    public Nodo buscar(int valor) {
        Nodo actual = cabeza;
        while (actual != null) {
            if (actual.dato == valor) return actual;
            actual = actual.siguiente;
        }
        return null;
    }

    // ----------------------------------------------------------------
    // Eliminar nodo
    // ----------------------------------------------------------------
    public void eliminarNodo(int valor) {
        if (cabeza == null) {
            System.out.println("La lista esta vacia");
            return;
        }

        if (cabeza.dato == valor) {
            cabeza = cabeza.siguiente;
            System.out.println("Elemento eliminado");
            return;
        }

        Nodo anterior = cabeza;
        Nodo actual = cabeza.siguiente;

        while (actual != null && actual.dato != valor) {
            anterior = actual;
            actual = actual.siguiente;
        }

        if (actual == null) {
            System.out.println("Elemento no encontrado");
            return;
        }

        anterior.siguiente = actual.siguiente;
        System.out.println("Elemento eliminado");
    }

    // ----------------------------------------------------------------
    // Contar nodos
    // ----------------------------------------------------------------
    public int contarNodos() {
        int contador = 0;
        Nodo actual = cabeza;
        while (actual != null) {
            contador++;
            actual = actual.siguiente;
        }
        return contador;
    }

    // ----------------------------------------------------------------
    // Leer entero con validacion
    // ----------------------------------------------------------------
    private static int leerEntero(Scanner sc, String mensaje) {
        while (true) {
            System.out.print(mensaje);
            String linea = sc.nextLine();
            try {
                return Integer.parseInt(linea.trim());
            } catch (NumberFormatException e) {
                System.out.println("Entrada invalida, ingrese un numero");
            }
        }
    }

    // ----------------------------------------------------------------
    // Main
    // ----------------------------------------------------------------
    public static void main(String[] args) {
        ListaEnlazada lista = new ListaEnlazada();
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println();
            System.out.println("========================");
            System.out.println("   LISTAS ENLAZADAS");
            System.out.println("========================");
            System.out.println("1. Insertar al inicio");
            System.out.println("2. Insertar al final");
            System.out.println("3. Mostrar lista");
            System.out.println("4. Buscar elemento");
            System.out.println("5. Eliminar elemento");
            System.out.println("6. Contar nodos");
            System.out.println("0. Salir");

            opcion = leerEntero(sc, "Opcion: ");

            switch (opcion) {
                case 1 -> {
                    int valor = leerEntero(sc, "Valor: ");
                    lista.insertarInicio(valor);
                    System.out.println("Nodo insertado al inicio. Total: "
                        + lista.contarNodos());
                }
                case 2 -> {
                    int valor = leerEntero(sc, "Valor: ");
                    lista.insertarFinal(valor);
                    System.out.println("Nodo insertado al final. Total: "
                        + lista.contarNodos());
                }
                case 3 -> lista.mostrarLista();
                case 4 -> {
                    int valor = leerEntero(sc, "Valor a buscar: ");
                    Nodo encontrado = lista.buscar(valor);
                    if (encontrado != null)
                        System.out.println("Elemento encontrado: "
                            + encontrado.dato);
                    else
                        System.out.println("Elemento no encontrado");
                }
                case 5 -> {
                    int valor = leerEntero(sc, "Valor a eliminar: ");
                    lista.eliminarNodo(valor);
                    System.out.println("Total de nodos: "
                        + lista.contarNodos());
                }
                case 6 -> System.out.println("Cantidad de nodos: "
                        + lista.contarNodos());
                case 0 -> System.out.println("Saliendo...");
                default -> System.out.println("Opcion invalida");
            }

        } while (opcion != 0);

        sc.close();
    }
}
