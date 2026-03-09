*** Settings ***
Documentation    Palabras clave para interactuar con la web de infracciones.
Library          SeleniumLibrary
Library          Dialogs

*** Variables ***
${URL_MULTAS}    https://infraccionesba.gba.gob.ar/consulta-infraccion    # <-- Reemplazar con la URL real del gobierno
${NAVEGADOR}     chrome

*** Keywords ***
Abrir Portal De Infracciones
    # Abre el navegador maximizado para evitar que los elementos web se escondan
    Open Browser    ${URL_MULTAS}    ${NAVEGADOR}
    Maximize Browser Window
    Log To Console    \n[OK] Navegador abierto en el portal de multas.

Completar Busqueda Por DNI
    [Arguments]    ${dni}    ${genero}
    
    # 1. Cambiar a la pestaña de Documento
    Click Element    css=a[href="#x-document"]
    Sleep    1s    # Le damos un respiro para que la animación de la pestaña termine
    
    # 2. Seleccionar Tipo de Documento (0 = DNI)
    Select From List By Value    id=filtroIdTipoDocumento    0
    
    # 3. Ingresar el Número de DNI
    Input Text    id=filtroNroDocumento    ${dni}
    
    # 4. Seleccionar el Género (El HTML usa name="filtroGenero" y los values M, F o X)
    Select Radio Button    filtroGenero    ${genero}
    
    # 5. EL BLOQUEO DEL CAPTCHA (Pausa Manual)
    Log To Console    \n[ATENCIÓN] Resolvé el Captcha en Chrome y hacé clic en Buscar.
    Pause Execution    Por favor, resuelve el Captcha en el navegador, haz clic en 'Buscar' y luego presiona OK en esta ventanita para que el bot siga trabajando.

Cerrar Portal
    Close All Browsers
    Log To Console    [OK] Navegador cerrado.