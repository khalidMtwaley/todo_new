import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseUtils{
  static CollectionReference <UserModel> getUsersCollection()=>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );


  static CollectionReference<TaskModel> getTaskCollection(String userId)=>
      getUsersCollection().doc(userId).collection('tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) =>TaskModel.fromJson(snapshot.data()!),
      toFirestore: (task, _) => task.toJson(),
  );



  static Future<void> addTaskToFireBase(TaskModel task,String userId)  {
    final collectionReference =getTaskCollection(userId);
    final doc = collectionReference.doc();
    task.id =doc.id;
    return doc.set(task);
  }

  static Future <List<TaskModel>> getAllTasksFromFireStore(String userId)async {
    final tasksCollection = getTaskCollection(userId);
    final querySnapShot = await tasksCollection.get();
    return querySnapShot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteTask(String iD,String userId){
    final taskCollection = getTaskCollection(userId);
    final doc = taskCollection.doc(iD);
    return doc.delete();
  }

  static Future<void> editTaskData(String iD,String newTitle,String newDesc,DateTime newDate,String userId){
    final taskCollection =getTaskCollection(userId);
    final doc = taskCollection.doc(iD);
    return doc.update({
      'title': newTitle,
      'description':newDesc,
      'dateTime':Timestamp.fromDate(newDate),
    });
  }

  static Future<void> editTaskSituation(String taskID,String userId)async{
    final taskCollection = getTaskCollection(userId);
    final doc = taskCollection.doc(taskID);
    List<TaskModel> allTasks=await getAllTasksFromFireStore(userId);
    TaskModel task = allTasks.firstWhere((task) => task.id==taskID);
    return doc.update({
      'isDone': !task.isDone,
    });
  }

  static Future<UserModel> register(String name,String email,String password)async{
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
  password: password,
);
    final user =UserModel(userName: name,
    userEmail: email,
      userId: credential.user!.uid,
    );
    final userCollection=getUsersCollection();
    await userCollection.doc(user.userId).set(user);
    return user;
  }

  static Future<UserModel> login(String email,String password)async{
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    final userCollection=getUsersCollection();
    final docSnapshot = await userCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout(){
    return FirebaseAuth.instance.signOut();
  }
}