class UserDAO {
  int id;
  String nomusr;
  String telusr;
  String mailusr;
  String fotousr;

  UserDAO({this.id, this.nomusr, this.telusr, this.mailusr, this.fotousr});

  factory UserDAO.fromJSON(Map<String,dynamic> map){ //Factory construye un OBJETO a partir de JSON
    return UserDAO(
      id: map['id'],
      nomusr: map['nomusr'],
      telusr: map['telusr'],
      mailusr: map['mailusr'],
      fotousr: map['fotousr']
    );
  }

  //Devuelve un mapa
  Map<String,dynamic> toJSON(){
    return{
      "id":id,
      "nomusr":nomusr,
      "telusr": telusr,
      "mailusr":mailusr,
      "fotousr": fotousr
      };
  }
}