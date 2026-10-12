@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection view'
@Metadata.allowExtensions: true
define root view entity ZC_BOOKING_001
  provider contract transactional_query
  as projection on ZI_BOOKING_001

{
  key BookingUuid,
      CustomerId,
      AirlineId,
      FlightDate,
      BookingStatus,
      CreatedAt

}
