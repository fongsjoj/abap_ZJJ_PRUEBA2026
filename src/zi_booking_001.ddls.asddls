@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view para las reservaciones'
define root view entity ZI_BOOKING_001
  as select from zbooking_001
{
  key booking_uuid   as BookingUuid,
      customer_id    as CustomerId,
      airline_id     as AirlineId,
      flight_date    as FlightDate,
      booking_status as BookingStatus,
      @Semantics.systemDateTime.createdAt: true
      created_at     as CreatedAt
}
