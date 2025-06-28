import sqlite3

def ejecutar_query_desde_archivo(db_path, query_path):
    conexion = sqlite3.connect(db_path)
    cursor = conexion.cursor()
    try:
        with open(query_path, 'r', encoding='utf-8') as archivo_sql:
            query = archivo_sql.read()
        cursor.execute(query)
        resultados = cursor.fetchall()
        conexion.commit()
        return resultados
    except Exception as e:
        conexion.rollback()
        print(f"Error al ejecutar la query: {e}")
        return None
    finally:
        conexion.close()

if __name__ == "__main__":
    ruta_bd = "assignment/BasePrueba.db"
    ruta_query = "assignment/queries/revenue_by_month_year.sql"
    resultados = ejecutar_query_desde_archivo(ruta_bd, ruta_query)
    if resultados:
        for fila in resultados:
            print(fila)