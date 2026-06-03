program ListaEnlazada;

type
    PNodo = ^Nodo;
    Nodo = record
        dato: Integer;
        siguiente: PNodo;
    end;

{ Crear nodo }
function crearNodo(valor: Integer): PNodo;
var
    nuevo: PNodo;
begin
    New(nuevo);
    nuevo^.dato := valor;
    nuevo^.siguiente := nil;
    crearNodo := nuevo;
end;

{ Insertar al inicio }
procedure insertarInicio(var cabeza: PNodo; valor: Integer);
var
    nuevo: PNodo;
begin
    nuevo := crearNodo(valor);
    nuevo^.siguiente := cabeza;
    cabeza := nuevo;
end;

{ Insertar al final }
procedure insertarFinal(var cabeza: PNodo; valor: Integer);
var
    nuevo: PNodo;
    actual: PNodo;
begin
    nuevo := crearNodo(valor);

    if cabeza = nil then
    begin
        cabeza := nuevo;
        Exit;
    end;

    actual := cabeza;
    while actual^.siguiente <> nil do
        actual := actual^.siguiente;

    actual^.siguiente := nuevo;
end;

{ Mostrar lista }
procedure mostrarLista(cabeza: PNodo);
var
    actual: PNodo;
begin
    if cabeza = nil then
    begin
        Writeln('La lista esta vacia');
        Exit;
    end;

    Write('Lista: ');
    actual := cabeza;
    while actual <> nil do
    begin
        Write(actual^.dato, ' -> ');
        actual := actual^.siguiente;
    end;
    Writeln('NULL');
end;

{ Buscar }
function buscar(cabeza: PNodo; valor: Integer): PNodo;
var
    actual: PNodo;
begin
    actual := cabeza;
    while actual <> nil do
    begin
        if actual^.dato = valor then
        begin
            buscar := actual;
            Exit;
        end;
        actual := actual^.siguiente;
    end;
    buscar := nil;
end;

{ Eliminar nodo }
procedure eliminarNodo(var cabeza: PNodo; valor: Integer);
var
    actual: PNodo;
    anterior: PNodo;
begin
    if cabeza = nil then
    begin
        Writeln('La lista esta vacia');
        Exit;
    end;

    actual := cabeza;
    anterior := nil;

    if actual^.dato = valor then
    begin
        cabeza := actual^.siguiente;
        Dispose(actual);
        Writeln('Elemento eliminado');
        Exit;
    end;

    while (actual <> nil) and (actual^.dato <> valor) do
    begin
        anterior := actual;
        actual := actual^.siguiente;
    end;

    if actual = nil then
    begin
        Writeln('Elemento no encontrado');
        Exit;
    end;

    anterior^.siguiente := actual^.siguiente;
    Dispose(actual);
    Writeln('Elemento eliminado');
end;

{ Contar nodos }
function contarNodos(cabeza: PNodo): Integer;
var
    contador: Integer;
    actual: PNodo;
begin
    contador := 0;
    actual := cabeza;
    while actual <> nil do
    begin
        Inc(contador);
        actual := actual^.siguiente;
    end;
    contarNodos := contador;
end;

{ Liberar lista }
procedure liberarLista(var cabeza: PNodo);
var
    actual: PNodo;
    temp: PNodo;
begin
    actual := cabeza;
    while actual <> nil do
    begin
        temp := actual;
        actual := actual^.siguiente;
        Dispose(temp);
    end;
    cabeza := nil;
end;

{ Leer entero con validacion }
function leerEntero(mensaje: String): Integer;
var
    linea: String;
    valor: Integer;
    codigo: Integer;
begin
    while True do
    begin
        Write(mensaje);
        Readln(linea);
        Val(linea, valor, codigo);
        if codigo = 0 then
        begin
            leerEntero := valor;
            Exit;
        end;
        Writeln('Entrada invalida, ingrese un numero');
    end;
end;

{ Programa principal }
var
    lista: PNodo;
    opcion: Integer;
    valor: Integer;
    encontrado: PNodo;

begin
    lista := nil;

    repeat
        Writeln;
        Writeln('========================');
        Writeln('   LISTAS ENLAZADAS');
        Writeln('========================');
        Writeln('1. Insertar al inicio');
        Writeln('2. Insertar al final');
        Writeln('3. Mostrar lista');
        Writeln('4. Buscar elemento');
        Writeln('5. Eliminar elemento');
        Writeln('6. Contar nodos');
        Writeln('0. Salir');

        opcion := leerEntero('Opcion: ');

        case opcion of
            1:
            begin
                valor := leerEntero('Valor: ');
                insertarInicio(lista, valor);
                Writeln('Nodo insertado al inicio. Total: ', contarNodos(lista));
            end;
            2:
            begin
                valor := leerEntero('Valor: ');
                insertarFinal(lista, valor);
                Writeln('Nodo insertado al final. Total: ', contarNodos(lista));
            end;
            3:
                mostrarLista(lista);
            4:
            begin
                valor := leerEntero('Valor a buscar: ');
                encontrado := buscar(lista, valor);
                if encontrado <> nil then
                    Writeln('Elemento encontrado: ', encontrado^.dato)
                else
                    Writeln('Elemento no encontrado');
            end;
            5:
            begin
                valor := leerEntero('Valor a eliminar: ');
                eliminarNodo(lista, valor);
                Writeln('Total de nodos: ', contarNodos(lista));
            end;
            6:
                Writeln('Cantidad de nodos: ', contarNodos(lista));
            0:
                Writeln('Saliendo...');
        else
            Writeln('Opcion invalida');
        end;

    until opcion = 0;

    liberarLista(lista);
end.
