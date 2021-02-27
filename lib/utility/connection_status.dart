import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';


class ConnectionStatus {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatus _singleton =
  new ConnectionStatus._internal();

  ConnectionStatus._internal(){
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  factory ConnectionStatus(){
    return _singleton;
  }

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController =
  new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate

  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}