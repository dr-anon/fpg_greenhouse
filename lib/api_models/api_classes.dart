class Data {
  String? temp;
  String? humidity;
  

  Data({this.temp, this.humidity});

  Data.fromJson(Map<String, dynamic> json) {
    temp = json["feeds"][1]["field1"];
    humidity = json["feeds"][1]["field2"];
  }
}

class PlotOne {
  String? description;
  String? temp;
  String? humidity;
  String? ph;
  String? moisture;
  String? name;

  PlotOne({this.description,this.name, this.temp, this.humidity, this.ph, this.moisture});

  PlotOne.fromJson(Map<String, dynamic> json) {
    name = json["channel"]["name"];
    description = json["channel"]["description"];
    temp = json["feeds"][1]["field1"];
    humidity = json["feeds"][1]["field2"];
    ph = json["feeds"][1]["field3"];
    moisture = json["feeds"][1]["field4"];
  }
}

class PlotTwo {
  String? description;
  String? temp;
  String? humidity;
  String? ph;
  String? moisture;
  String? name;

  PlotTwo({this.description,this.name, this.temp, this.humidity, this.ph, this.moisture});

  PlotTwo.fromJson(Map<String, dynamic> json) {
    name = json["channel"]["name"];
    description = json["channel"]["description"];
    temp = json["feeds"][1]["field1"];
    humidity = json["feeds"][1]["field2"];
    ph = json["feeds"][1]["field3"];
    moisture = json["feeds"][1]["field4"];
  }
}

class PlotThree {
  String? description;
  String? temp;
  String? humidity;
  String? ph;
  String? moisture;
  String? name;

  PlotThree({this.description,this.name, this.temp, this.humidity, this.ph, this.moisture});

  PlotThree.fromJson(Map<String, dynamic> json) {
    name = json["channel"]["name"];
    description = json["channel"]["description"];
    temp = json["feeds"][1]["field1"];
    humidity = json["feeds"][1]["field2"];
    ph = json["feeds"][1]["field3"];
    moisture = json["feeds"][1]["field4"];
  }
}

class EditedPlotOne {

  String? description;
  String? temp;
  String? humidity;
  String? ph;
  String? moisture;
  String? name;

  EditedPlotOne({this.description,this.name, this.temp, this.humidity, this.ph, this.moisture});

  EditedPlotOne.fromJson(Map<String, dynamic> json) {
    name = json["channel"]["name"];
    description = json["channel"]["description"];
    temp = json["feeds"][1]["field1"];
    humidity = json["feeds"][1]["field2"];
    ph = json["feeds"][1]["field3"];
    moisture = json["feeds"][1]["field4"];
  }
}

class EditedPlotOneDataChange{
  
}