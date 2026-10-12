CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setconfirmed FOR MODIFY
      IMPORTING keys FOR ACTION Booking~setconfirmed RESULT result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD setConfirmed.

  MODIFY ENTITIES OF ZI_BOOKING_001 IN LOCAL MODE
   ENTITY Booking
     UPDATE FIELDS ( BookingStatus )
     WITH VALUE #( FOR KEY IN KEYS ( %tky      = key-%tky
                                    BookingStatus = 'C' ) )
     FAILED failed
     REPORTED reported.

   READ ENTITIES OF ZI_BOOKING_001 IN LOCAL MODE
    ENTITY Booking
      ALL FIELDS WITH VALUE #( FOR key IN KEYS ( %tky = key-%tky ) )
    RESULT DATA(lt_bookings).

    result = value #( for booking in lt_bookings
                                ( %tky = booking-%tky
                                 %param = booking ) ).

  ENDMETHOD.


ENDCLASS.
