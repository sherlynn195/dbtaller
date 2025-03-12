import mysql.connector

def conectar():
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="dbtaller",
            port=3306
        )
        return conexion
    except mysql.connector.Error as e:
        print(f"Fallo conexion: {e}")
        return None

def insertar_linea_inv(idlinea, nombreproy):
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "INSERT INTO lineainv (idlinea, nombreproy) VALUES (%s, %s)"
        try:
            cursor.execute(sql, (idlinea, nombreproy))
            conn.commit()
            print("Insertada la linea de investigacion correctamente.")
        except mysql.connector.Error as e:
            print(f"Error al insertar: {e}")
        finally:
            cursor.close()
            conn.close()

def obtener_lineas_inv():
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "SELECT * FROM lineainv"
        try:
            cursor.execute(sql)
            lineas = cursor.fetchall()
            print("\nLista de lineas de Investigacion:")
            for linea in lineas:
                print(f"ID: {linea[0]}, Proyecto: {linea[1]}")
        except mysql.connector.Error as e:
            print(f"Fallo al obtener datos: {e}")
        finally:
            cursor.close()
            conn.close()

def eliminar_linea_inv(idlinea):
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "DELETE FROM lineainv WHERE idlinea = %s"
        try:
            cursor.execute(sql, (idlinea,))
            conn.commit()
            print("Se eliminó correctamente la linea de investigacion.")
        except mysql.connector.Error as e:
            print(f"Fallo al eliminar: {e}")
        finally:
            cursor.close()
            conn.close()

def insertar_tipo_proyecto(tipo):
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "INSERT INTO tipoproyecto (tipo) VALUES (%s)"
        try:
            cursor.execute(sql, (tipo,))
            conn.commit()
            print("Se insertó correctamente el tipo de proyecto.")
        except mysql.connector.Error as e:
            print(f"Fallo al insertar en tipo de proyecto: {e}")
        finally:
            cursor.close()
            conn.close()

def obtener_tipos_proyecto():
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "SELECT * FROM tipoproyecto"
        try:
            cursor.execute(sql)
            proyectos = cursor.fetchall()
            print("\nLista de Tipos de Proyecto:")
            for proyecto in proyectos:
                print(f"Tipo: {proyecto[0]}")
        except mysql.connector.Error as e:
            print(f"Fallo al obtener datos: {e}")
        finally:
            cursor.close()
            conn.close()

if __name__ == "__main__":
    while True:
        print("\n=== CRUD para lineas de Investigacion y Tipos de Proyecto ===")
        print("1. Insertar Linea de Investigacion")
        print("2. Mostrar Lineas de Investigacion")
        print("3. Eliminar Linea de Investigacion")
        print("4. Insertar Tipo de Proyecto")
        print("5. Mostrar Tipos de Proyecto")
        print("6. Salir")
        opcion = input("Seleccione una opcion: ")

        if opcion == "1":
            idlinea = input("Ingrese el ID de la linea de investigacion: ")
            nombreproy = input("Ingrese el nombre del proyecto: ")
            insertar_linea_inv(idlinea, nombreproy)
        elif opcion == "2":
            obtener_lineas_inv()
        elif opcion == "3":
            idlinea = input("Ingrese el ID de la línea de investigacion a eliminar: ")
            eliminar_linea_inv(idlinea)
        elif opcion == "4":
            tipo = input("Ingrese el tipo de proyecto: ")
            insertar_tipo_proyecto(tipo)
        elif opcion == "5":
            obtener_tipos_proyecto()
        elif opcion == "6":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Intente de nuevo.")