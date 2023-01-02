class Profile {
  String? name;
  String? email;
  String? mobile;
  String? password;
  List<String>? titles;
  String? isVerified;

  Profile(
      {this.name,
        this.email,
        this.mobile,
        this.password,
        this.titles,
        this.isVerified});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    titles = json['titles'].cast<String>();
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['titles'] = this.titles;
    data['isVerified'] = this.isVerified;
    return data;
  }
}