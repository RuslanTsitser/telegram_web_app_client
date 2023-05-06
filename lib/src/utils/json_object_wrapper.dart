abstract class JsObjectWrapper<T> {
  JsObjectWrapper(this.jsObject);

  JsObjectWrapper.fromJsObject(this.jsObject);

  final T jsObject;
}
