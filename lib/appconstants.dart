class DATABASE {
  static const DB_NAME = "uahep.db";
  static const TABLE_INFO = "grievance_info";

  static const ID = "sync_id";
  // report
  static const ORIGIN = "origin";
  static const TITLE = "title";
  static const WARD = "ward_no";
  static const APPLICATION_TYPE = "application_type";
  static const GRIEVANCE_AT = "grievance_at";
  static const DESCRIPTION = "description";
  static const CREATED_AT = "data_created_at";
  static const REPORTER_INFO = "reporter_info";
  //reporter info
  static const NAME = "name";
  static const PHONE_NO = "phone_no";
  static const ADDRESS = "address";
  static const EMAIL = "email";
  static const IS_ANONYMOUS = "is_anonymous";

// audio
  static const TABLE_AUDIO = "grievance_audio";
  static const AUDIO_NAME = "audio_name";
  static const AUDIO_PATH = "audio_link";

  //extra
  static const SYNC_STATUS = "sync_status";
  static const STATUS = "status";

  static const CREATE_GRIEVANCE_TABLE = "CREATE TABLE $TABLE_INFO ("
      "$ID TEXT PRIMARY KEY,"
      "$TITLE STRING,"
      "$DESCRIPTION STRING,"
      "$STATUS STRING,"
      "$SYNC_STATUS INTEGER"
      ")";
}

class API {
  static const BASE_URL = 'http://pact-grms.staging.yipl.com.np';

  static const LOGIN = "$BASE_URL/api/auth/login";
  static const USER_INFO = "$BASE_URL/api/auth/me";
}

class Preference {
  static const TOKEN = 'token';
  static const USER_INFO = 'user-info';
}