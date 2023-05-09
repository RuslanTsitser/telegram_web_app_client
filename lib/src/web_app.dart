import 'package:js/js.dart' show allowInterop;

import 'service/web_app_js_client.dart' as js;
import 'utils/json_object_wrapper.dart';

class TeleWebApp extends JsObjectWrapper<js.WebAppJsImpl> {
  factory TeleWebApp() {
    _instance ??= TeleWebApp._();
    return _instance!;
  }

  TeleWebApp._() : super(js.WebApp);

  static TeleWebApp? _instance;

  String get initData => jsObject.initData;

  WebAppInitData get initDataUnsafe => WebAppInitData.fromJsObject(jsObject.initDataUnsafe);

  // String get colorScheme => jsObject.colorScheme;

  // ThemeParams get themeParams => ThemeParams.fromJsObject(jsObject.themeParams);

  bool get isExpanded => jsObject.isExpanded;

  // double get viewportHeight => jsObject.viewportHeight.toDouble();

  // double get viewportStableHeight => jsObject.viewportStableHeight.toDouble();

  BackButton get backButton => BackButton.fromJsObject(jsObject.BackButton);

  MainButton get mainButton => MainButton.fromJsObject(jsObject.MainButton);

  void onEvent(WebAppEventType eventType, Function eventHandler) =>
      jsObject.onEvent(eventType.name, allowInterop(() => eventHandler));

  void offEvent(WebAppEventType eventType, Function eventHandler) =>
      jsObject.offEvent(eventType.name, allowInterop(() => eventHandler));

  void sendData(String data) => jsObject.sendData(data);

  void ready() => jsObject.ready();

  void expand() => jsObject.expand();

  void close() => jsObject.close();

  void showPopup(PopupParams params, void Function(int value) callback) => jsObject.showPopup(
        js.PopupParams(
            title: params.title,
            message: params.message,
            buttons: params.buttons?.map((e) {
              return js.PopupButton(id: e.id, type: e.type, text: e.text);
            }).toList()),
        allowInterop((int value) => callback.call(value)),
      );
}

class PopupParams {
  PopupParams({
    this.title,
    this.message,
    this.buttons,
  });

  final String? title;
  final String? message;
  final List<PopupButton>? buttons;
}

/// `ìd` Identifier of the button, 0-64 characters. Set to empty string by default.
/// If the button is pressed, its id is returned in the callback and the popupClosed event.

///
/// `type` Type of the button. Set to default by default.
/// Can be one of these values:
/// - `default`, a button with the default style,
/// - `ok`, a button with the localized text “OK”,
/// - `close`, a button with the localized text “Close”,
/// - `cancel`, a button with the localized text “Cancel”,
/// - `destructive`, a button with a style that indicates a destructive action (e.g. “Remove”, “Delete”, etc.).
///
/// `text` The text to be displayed on the button, 0-64 characters. Required if type is default or destructive. Irrelevant for other types.
class PopupButton {
  PopupButton({
    this.id,
    this.text,
    this.type,
  });

  final String? id;
  final String? type;
  final String? text;
}

class MainButton extends JsObjectWrapper<js.MainButtonJsImpl> {
  MainButton.fromJsObject(super.jsObject);

  String get text => jsObject.text;

  String get color => jsObject.color;

  String get textColor => jsObject.textColor;

  bool get isVisible => jsObject.isVisible;

  bool get isActive => jsObject.isActive;

  bool get isProgressVisible => jsObject.isProgressVisible;

  void setText(String text) => jsObject.setText(text);

  void onClick(void Function() callback) => jsObject.onClick(allowInterop(callback));

  void offClick(void Function() callback) => jsObject.offClick(allowInterop(callback));

  void show() => jsObject.show();

  void hide() => jsObject.hide();

  void enable() => jsObject.enable();

  void disable() => jsObject.disable();

  void showProgress({bool leaveActive = true}) => jsObject.showProgress(leaveActive);

  void hideProgress() => jsObject.hideProgress();

  void setParams({
    String? text,
    String? color,
    String? textColor,
    bool? isActive,
    bool? isVisible,
  }) =>
      jsObject.setParams(
        js.MainButtonParams(
          text: text,
          color: color,
          text_color: textColor,
          is_active: isActive,
          is_visible: isVisible,
        ),
      );
}

class BackButton extends JsObjectWrapper<js.BackButtonJsImpl> {
  BackButton.fromJsObject(super.jsObject);

  bool get isVisible => jsObject.isVisible;

  void onClick(void Function() callback) => jsObject.onClick(allowInterop(callback));

  void offClick(void Function() callback) => jsObject.offClick(allowInterop(callback));

  void show() => jsObject.show();

  void hide() => jsObject.hide();
}

class ThemeParams extends JsObjectWrapper<js.ThemeParamsJsImpl> {
  ThemeParams.fromJsObject(super.jsObject);

  String? get bgColor => jsObject.bg_color;

  String? get textColor => jsObject.text_color;

  String? get hintColor => jsObject.hint_color;

  String? get linkColor => jsObject.link_color;

  String? get buttonColor => jsObject.button_color;

  String? get buttonTextColor => jsObject.button_text_color;
}

class WebAppInitData extends JsObjectWrapper<js.WebAppInitDataJsImpl> {
  WebAppInitData.fromJsObject(super.jsObject);

  String? get queryId => jsObject.query_id;

  WebAppUser? get user => WebAppUser.fromJsObject(jsObject.user);
  WebAppUser? get receiver => WebAppUser.fromJsObject(jsObject.receiver);

  // String? get startParam => jsObject.start_param;

  // DateTime get authDate => DateTime.fromMillisecondsSinceEpoch(jsObject.auth_date as int);

  String get hash => jsObject.hash;
}

class WebAppUser extends JsObjectWrapper<js.WebAppUserJsImpl?> {
  WebAppUser.fromJsObject(super.jsObject);

  int get id => jsObject!.id.toInt();

  bool? get isBot => jsObject?.is_bot;

  String? get firstName => jsObject?.first_name;

  String? get lastName => jsObject?.last_name;

  String? get username => jsObject?.username;

  String? get languageCode => jsObject?.language_code;

  String? get photoUrl => jsObject?.photo_url;
}

enum WebAppEventType {
  themeChanged,

  viewportChanged,

  mainButtonClicked
}
