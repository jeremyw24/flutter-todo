# Flutter ToDo App Demo (Web)

ToDo App built using Flutter Web, Firebase Auth, Firebase Firestore and Firebase Hosting. 

You can view a live version of the app here: https://fluttertodoweb.firebaseapp.com/#/

## Getting Started

Fork or Clone this repository. 

You will need to create your own Firebase Web Project to generate the necessary API Keys and Associated Information to go in /web/index.html for the application to function, including the necessary configuration on GCP Console to allow authentication. 

To run the app locally: `flutter run -d chrome --web-hostname localhost --web-port 5000` (port 5000 is default for localhost on GCP API OAuth)

You  can run the app, as above without Google Authentication by calling `Home()` in `Main` instead of `SignIn()` eg.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), <-- Change from SignIn()
    );
  }
}
```

## Setting Up Firebase

1. Goto: https://console.firebase.google.com
2. Add new project.
3. Enter a name for your project eg. FlutterToDo
4. Once project is created, under gettting started select 'Web App'
5. Copy your keys to /web/index.html

That's it! Your project should now be able to communicate with Firebase. 

## Setting Up User Authentication

1. On Firebase Console, select Authentication
2. Click Get Started
3. Firebase will create all the necessary configurations. 
4. Copy your clientID and paste into /web/index.html in the head under `google-signin-client_id`

Authentication should now be functional, provided you serve the local build on porrt 5000. 
