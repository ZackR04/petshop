// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_to_cart_cubit.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartIsLoading extends AddToCartState {}

class AddToCartIsFailed extends AddToCartState {
  final String message;
  AddToCartIsFailed({
    required this.message,
  });
}

class AddToCartIsSuccess extends AddToCartState {
  final String message;
  AddToCartIsSuccess({
    required this.message,
  });
}
