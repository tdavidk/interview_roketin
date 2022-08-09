part of 'controller.dart';

class PersonController {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  static final DateTime now = DateTime.now();

  Future<void> updatePerson(Person person) async {
    await _userCollection.doc(person.idUser.toString()).set({
      "id": person.idUser,
      "username": person.username,
      "password": person.password,
      "phoneNumber": person.phoneNumber,
      "email": person.email,
      "CreatedApp": DateFormat.yMMMd().add_jm().format(now),
      "UpdatedApp": DateFormat.yMMMd().add_jm().format(now),
    });

    SaveData.data?.setString(AppVariable.idUser, person.idUser);
    SaveData.data?.setString(AppVariable.username, person.username);
    SaveData.data?.setString(AppVariable.password, person.password);
    SaveData.data?.setString(AppVariable.phoneNumber, person.phoneNumber);
    SaveData.data?.setString(AppVariable.email, person.email);
  }

  Future<Person> getPerson(Person person) async {
    DocumentSnapshot snapshot = await _userCollection.doc(person.idUser).get();

    SaveData.data?.setString(AppVariable.idUser, person.idUser);
    SaveData.data?.setString(AppVariable.username, snapshot.get("username"));
    SaveData.data?.setString(AppVariable.password, snapshot.get("password"));
    SaveData.data
        ?.setString(AppVariable.phoneNumber, snapshot.get("phoneNumber"));
    SaveData.data?.setString(AppVariable.email, snapshot.get("email"));

    return Person(
      idUser: person.idUser,
      username: snapshot.get("username"),
      password: snapshot.get("password"),
      phoneNumber: snapshot.get("phoneNumber"),
      email: snapshot.get("email"),
    );
  }
}
