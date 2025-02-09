import 'package:creative_movers/helpers/api_helper.dart';

class Endpoints {
  static const login_endpoint = '${ApiConstants.BASE_URL}api/login';

  static const register_endpoint = '${ApiConstants.BASE_URL}api/register';
  static const biodata_endpoint = '${ApiConstants.BASE_URL}api/user/biodata';
  static const categories_endpoint = '${ApiConstants.BASE_URL}api/user/fetch_category';
  static const acount_type_endpoint = '${ApiConstants.BASE_URL}api/user/account-type';
  static const add_connection_endpoint = '${ApiConstants.BASE_URL}api/user/choose-connection';
  static const logout_endpoint = '${ApiConstants.BASE_URL}api/user/logout';
  static const add_feed_endpoint = '${ApiConstants.BASE_URL}api/feed/add-feed';
  static const fetch_feed_endpoint = '${ApiConstants.BASE_URL}api/feed/fetch';
  static const comment_endpoint = '${ApiConstants.BASE_URL}api/feed/comment';


  static const fetch_connections_endpoint = '${ApiConstants.BASE_URL}api/connections/fetch-all';
  static const search_endpoint = '${ApiConstants.BASE_URL}api/user/search';
  static const pending_request_endpoint =
      '${ApiConstants.BASE_URL}api/connections/fetch-all-pending';
  static const request_react_endpoint =
      '${ApiConstants.BASE_URL}api/connections/react';
  static const String stripe_intent =
      "https://api.stripe.com/v1/payment_intents";

  static const String myProfileEndpoint =
      '${ApiConstants.BASE_URL}api/user/my-profile';
  static const String userProfileEndpoint =
      '${ApiConstants.BASE_URL}api/user/user-profile';

  static const profilePhotoEndpoint =
      '${ApiConstants.BASE_URL}api/user/update-profile-image';
  static const profileCoverImageEndpoint =
      '${ApiConstants.BASE_URL}api/user/update-cover-image';
  // static const pending_request_endpoint = '${ApiConstants.BASE_URL}api/connections/fetch-all-pending';
  // static const request_react_endpoint = '${ApiConstants.BASE_URL}api/connections/react';
  static const send_request_endpoint = '${ApiConstants.BASE_URL}api/connections/connect';
  static const follow_endpoint = '${ApiConstants.BASE_URL}api/connections/follow';
  // static const String stripe_intent = "https://api.stripe.com/v1/payment_intents";

  // static const add_feed_endpoint = '${ApiConstants.BASE_URL}api/feed/add-feed';
}
