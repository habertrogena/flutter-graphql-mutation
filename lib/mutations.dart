import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

typedef RunMutation = void Function(
  Map<String, dynamic> variable, {
  Object optimisticResult,
});

typedef MutationBuilder = Widget Function(
  RunMutation runMutation,
  QueryResult result,
);

typedef OnMutationCompleted = void Function(dynamic data);
typedef OnMutationUpdate = void Function(QueryResult result);
