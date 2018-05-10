#include <folly/futures/Future.h> 
using folly::Future;

Future<Output> asyncOperation(Input);
Future<Output> f = asyncOperation(input);
