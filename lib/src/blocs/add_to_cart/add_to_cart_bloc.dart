import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_petshop/src/models/models.dart';
import 'package:my_petshop/src/services/services.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddToCart>((event, emit) async {
      emit(AddToCartIsLoading());
      final selectedVariant = <String>[];

      if (event.data.variant!.isNotEmpty) {
        if (event.selectedVariant.isNotEmpty) {
          print('INI LHOO ${event.data.name} ${event.selectedVariant.length}');
          selectedVariant.add(event.selectedVariant);
          final result = await ProductService().addToCart(event.data.copyWith(
            variant: selectedVariant,
          ));
          emit(result.fold(
              (l) => AddToCartIsFailed(l), (r) => AddToCartIsSuccess(r)));
        } else {
          emit(AddToCartIsFailed('Silahkan pilih variant'));
        }
      } else {
        final result = await ProductService().addToCart(event.data);
        emit(result.fold(
            (l) => AddToCartIsFailed(l), (r) => AddToCartIsSuccess(r)));
      }
    });
  }
}
