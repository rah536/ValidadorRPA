*** Settings ***
Documentation    Flujo principal de RPA para validación de infracciones.
Resource         ../resources/conexion.resource
Resource         ../resources/scraping.resource

*** Tasks ***
Validar Estado de Infracciones de Flota
    TRY
        Conectar a Base de Datos
        Abrir Portal De Infracciones
        
        ${lista_pendientes}=    Obtener Conductores Pendientes
        
        Log To Console    \n--- INICIANDO PROCESAMIENTO ---
        FOR    ${conductor}    IN    @{lista_pendientes}
            Log To Console    -> El bot debería buscar a: ${conductor}[1] ${conductor}[2] (DNI: ${conductor}[0])
            # Pronto haremos: Ingresar DNI En Web    ${conductor}[0]
        END
        
        Cerrar Portal    # <-- El bot cierra Chrome
        Desconectar de Base de Datos
    EXCEPT    AS    ${error}
        Log To Console    \n[ERROR] Ocurrió un error: ${error}
        Cerrar Portal    # Aseguramos cerrar el navegador aunque haya un error
        Desconectar de Base de Datos
    END