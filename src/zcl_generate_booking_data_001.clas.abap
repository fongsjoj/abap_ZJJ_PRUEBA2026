CLASS zcl_generate_booking_data_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_generate_booking_data_001 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_bookings TYPE TABLE OF zbooking_001,
          ls_booking  LIKE LINE OF lt_bookings.

    " 1. Limpiar registros anteriores para evitar duplicados en pruebas
    DELETE FROM zbooking_001.

    " 2. Obtener fecha y hora actual del sistema
    GET TIME STAMP FIELD DATA(lv_timestamp).

    " 3. Preparar Registro 1 (Estado 'N' - Nuevo)
    ls_booking-client         = sy-mandt.
    TRY.
        ls_booking-booking_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
    ENDTRY.
    ls_booking-customer_id    = '00001001'.
    ls_booking-airline_id     = 'LAN'.
    ls_booking-flight_date    = cl_abap_context_info=>get_system_date( ) + 10. " Vuelo en 10 días
    ls_booking-booking_status = 'N'. " Nuevo / Pendiente
    ls_booking-created_at     = lv_timestamp.
    APPEND ls_booking TO lt_bookings.

    " 4. Preparar Registro 2 (Estado 'N' - Nuevo)
    ls_booking-client         = sy-mandt.
    TRY.
        ls_booking-booking_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
    ENDTRY.
    ls_booking-customer_id    = '00001002'.
    ls_booking-airline_id     = 'AAL'.
    ls_booking-flight_date    = cl_abap_context_info=>get_system_date( ) + 20. " Vuelo en 20 días
    ls_booking-booking_status = 'N'. " Nuevo / Pendiente
    ls_booking-created_at     = lv_timestamp.
    APPEND ls_booking TO lt_bookings.

    " 5. Preparar Registro 3 (Estado 'C' - Ya Confirmado)
    ls_booking-client         = sy-mandt.
    TRY.
        ls_booking-booking_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
    ENDTRY.
    ls_booking-customer_id    = '00001003'.
    ls_booking-airline_id     = 'IBE'.
    ls_booking-flight_date    = cl_abap_context_info=>get_system_date( ) + 30. " Vuelo en 30 días
    ls_booking-booking_status = 'C'. " Ya Confirmado
    ls_booking-created_at     = lv_timestamp.
    APPEND ls_booking TO lt_bookings.

    " 6. Insertar en la base de datos SAP HANA
    INSERT zbooking_001 FROM TABLE @lt_bookings.

    IF sy-subrc = 0.
      out->write( '¡Datos de reservas insertados exitosamente en zbooking_001!' ).
      out->write( |Se crearon { lines( lt_bookings ) } registros.| ).
    ELSE.
      out->write( 'Error al insertar los registros.' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
