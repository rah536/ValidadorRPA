*** Settings ***
Documentation    Conexión a la base de datos SQL Server (Estilo DAO).
Library          DatabaseLibrary
Variables        credenciales.py

*** Test Cases ***
Prueba de Conexion y Lectura
    Conectar a Base de Datos
    Obtener Conductores Pendientes
    Desconectar de Base de Datos

*** Keywords ***
Conectar a Base de Datos
    # Le pasamos los parámetros exactos a pyodbc usando el driver moderno (ODBC Driver 17)
    # y forzamos TrustServerCertificate=yes para evitar bloqueos de seguridad de la red.
    Connect To Database    db_module=pyodbc    DRIVER={ODBC Driver 17 for SQL Server}    SERVER=${DB_HOST},1433    DATABASE=${DB_NAME}    UID=${DB_USER}    PWD=${DB_PASS}    TrustServerCertificate=yes
    Log To Console    \n[OK] Conectado a la BD LogisticaMultas con éxito.

Obtener Conductores Pendientes
    ${resultados}=    Query    SELECT DNI, Nombre, Apellido FROM Conductor WHERE TieneMulta IS NULL
    
    Log To Console    \n--- TAREAS PENDIENTES ---
    FOR    ${fila}    IN    @{resultados}
        Log To Console    -> Validar DNI: ${fila}[0] - ${fila}[1] ${fila}[2]
    END
    Log To Console    ---------------------------

Desconectar de Base de Datos
    Disconnect From Database
    Log To Console    [OK] Desconectado.