import 'package:cloud_firestore/cloud_firestore.dart';

class databasMethods{
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async{
    return await FirebaseFirestore.instance
    .collection('user')
    .doc(id)
    .set(userInfoMap);

  }

  Future<Stream<QuerySnapshot>> getClothesItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

Future<bool> addClothestoCart(Map<String, dynamic> userInfoMap, String id) async {
  try {        // userInfoMap => Map that contains item data (name, price, image, quantity, total)
    await FirebaseFirestore.instance   
        .collection('user') // go to user coll
        .doc(id)          //Pick the document that matches the current user ID
        .collection('Cart')    // go to this user cart
        .add(userInfoMap);     // add the item to this cart 
    return true;
  } catch (e) {
    print("Error adding to cart: $e");
    return false;
  }
}

  Future<Stream<QuerySnapshot>> getClothesCart(String id)async{
    return await FirebaseFirestore.instance.collection('user').doc(id).collection('Cart').snapshots();
  }

  

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("user").doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error getting user data: $e");
    }
    return null;
  }


}


