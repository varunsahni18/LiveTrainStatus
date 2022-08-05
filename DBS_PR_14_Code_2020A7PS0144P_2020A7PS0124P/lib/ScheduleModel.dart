class ScheduleModel {
  final String? ArrivalTime;
  final String? DepartureTime;
  final String? Distance;
  final String StationID;
  final String? NextStationID;
  final String TrainID;

  const ScheduleModel(this.ArrivalTime, this.DepartureTime, this.Distance,
      this.StationID, this.NextStationID, this.TrainID);
}
