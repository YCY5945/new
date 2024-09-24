class LogUtils {


  static bool _isLog = true;
  static String _logFlag = "航大SRS";

  static void init({bool islog = false,String logFlag ="航大SRS"}){
    _isLog = islog;
    _logFlag = logFlag;
  }


  static void e(String message){

    if(_isLog){
      print("$_logFlag | $message");
    }
  }

}