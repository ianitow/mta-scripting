ACL_DETRAN              =   "Detran";
COLOR_MESSAGE_ORANGE    =   "#FFA500"
COLOR_MARKER            =   {255,69,0}
VEHICLE_FOR_USERS       =   578;
DEFAULT_PRICE           =   10000
LET_VEHICLE_MARKER      =   createMarker(1603.71729, -1630.22583, 12.50546,"cylinder",1,unpack(COLOR_MARKER))
POSSIBLE_CARS           =   {"Automobile","Bike","BMX","Quad"}
SKIN_DETRAN_PLAYER      =   309
DEFAULT_POSITION        =   {1591.72449, -1612.82214, 13.38281} --SPAWN VEHICLE
DEFAULT_PRICE_LIMIT   =   2000




-------------------DATA ELEMENTS FOR DETRAN-------------------------------
--Não alterar.

CAR_DETRAN_ELEMENT      =   "DETRAN.carElement";
CAR_TOWED_ELEMENT       =   "DETRAN.carTowedElement";
IS_CAR_TOWED            =   "DETRAN.isCarTowed";
CAR_TIME_TOWED_LEFT     =   "DETRAN.carLeft";
IS_DETRAN_CAR           =   "DETRAN.isDetranCar";
MARKER_PLAYER_INSIDE    =   "DETRAN.markerPlayerInside";

------------------POSITIONS -------------------------------------------------
pickupsPositions={
    ['skin'] = {1604.52295, -1606.97864, 13.51412},
    ['vehicle'] = {1604.52295, -1609.97864, 13.51412}
}

--X,Y,Z E ROTAÇÃO
parkingLot =
  {
    [1] = {
      ['position'] = {1602.37, -1683.922, 5.891,0},
      ['markerPosition'] = {1595.80664, -1683.99451, 4.89063},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    [2] = {
      ['position'] = { 1602.318, -1688.717, 5.891,270},
      ['markerPosition'] = {1595.80664, -1687.96252, 4.89063},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    [3] = {
      ['position'] = {1602.318, -1691.717, 5.891,270},
      ['markerPosition'] = {1595.80664, -1691.91553, 4.89063},
      ['markerElement'] = nil;  
      ['vehicleElement'] = nil;
  },
    [4] = {
      ['position'] = {1602.318, -1695.717, 5.891,270},
      ['markerPosition'] = {1596.67725, -1696.01965, 4.89063},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    [5] = {
      ['position'] = {1602.163, -1700.106, 5.891,270},
      ['markerPosition'] = {1595.89539, -1700.12927, 4.89699},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    [6] = {
      ['position'] = {1595.261, -1711.413, 5.891,0},
      ['markerPosition'] = {1595.64587, -1706.09900, 4.89063},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    [7] = {
      ['position'] = {1591.146, -1711.398, 5.891,0},
      ['markerPosition'] = {1591.37329, -1705.80945, 4.89063},
      ['markerElement'] = nil;
      ['vehicleElement'] = nil;
    },
    
}