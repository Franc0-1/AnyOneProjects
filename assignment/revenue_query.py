import sqlite3

def ejecutar_query_desde_archivo(db_path, query_path):
    conexion = sqlite3.connect(db_path)
    cursor = conexion.cursor()

    try:
        with open(query_path, 'r', encoding='utf-8') as archivo_sql:
            query = archivo_sql.read().strip().rstrip(';')  # 🔧 parte clave

        cursor.execute(query)
        resultados = cursor.fetchall()
        return resultados

    except Exception as e:
        print(f"Error al ejecutar la query: {e}")
        return None

    finally:
        conexion.close()


