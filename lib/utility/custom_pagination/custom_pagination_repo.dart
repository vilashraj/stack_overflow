

abstract class CustomPaginationRepo<T, P> {
  Future<T> fetchPaginationData({P data, int page, int noOfRecords});
}
