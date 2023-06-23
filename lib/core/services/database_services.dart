import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';
import '../models/app_user.dart';
import 'auth_services.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;

  ///
  /// Add user
  ///
  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  ///
  /// Get user
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      print('Current app User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception@DatabaseService/getUser $e');
      return AppUser();
    }
  }

  Future<AppUser?> getSigupUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      print('Current app User Data: ${snapshot.data()}');

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data(), snapshot.id);
      } else {
        // User data not found in the database
        return null;
      }
    } catch (e) {
      print('Exception@DatabaseService/getUser $e');
      return null;
    }
  }

  updateUserProfile(AppUser appUser) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(appUser.appUserId)
          .update(appUser.toJson());
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }
}
