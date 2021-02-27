

abstract class CustomRepo<T,P> {
  Future<T> fetchData({P data});
}
