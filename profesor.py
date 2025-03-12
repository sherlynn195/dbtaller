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
        return conexion  # ✅ Retorna la conexión para ser utilizada
    except mysql.connector.Error as e:
        print(f"Error al conectar: {e}")
        return None  # ✅ Retorna None si hay un error

def insertar_profesor(nombreProf):
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "INSERT INTO profesor (nombreProf) VALUES (%s)"
        try:
            cursor.execute(sql, (nombreProf,))
            conn.commit()
            print("Se insertó correctamente el profesor.")
        except mysql.connector.Error as e:
            print(f"Fallo al insertar profesor: {e}")
        finally:
            cursor.close()
            conn.close()

def obtener_profesores():
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "SELECT * FROM profesor"
        try:
            cursor.execute(sql)
            profesores = cursor.fetchall()
            print("\nLista de Profesores:")
            for profesor in profesores:
                print(f"ID: {profesor[0]}, Nombre: {profesor[1]}")
        except mysql.connector.Error as e:
            print(f"Error al obtener datos: {e}")
        finally:
            cursor.close()
            conn.close()

def eliminar_profesor(idprofesor):
    conn = conectar()
    if conn:
        cursor = conn.cursor()
        sql = "DELETE FROM profesor WHERE idprofesor = %s"
        try:
            cursor.execute(sql, (idprofesor,))
            conn.commit()
            print("Se eliminó correctamente el profesor.")
        except mysql.connector.Error as e:
            print(f"Fallo al eliminar profesor: {e}")
        finally:
            cursor.close()
            conn.close()

if __name__ == "__main__":
    while True:
        print("\n=== CRUD para Profesores ===")
        print("1. Insertar Profesor")
        print("2. Mostrar Profesores")
        print("3. Eliminar Profesor")
        print("4. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            nombreProf = input("Ingrese el nombre del profesor: ")
            insertar_profesor(nombreProf)
        elif opcion == "2":
            obtener_profesores()
        elif opcion == "3":
            idprofesor = input("Ingrese el ID del profesor a eliminar: ")
            eliminar_profesor(idprofesor)
        elif opcion == "4":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Intente de nuevo.")

