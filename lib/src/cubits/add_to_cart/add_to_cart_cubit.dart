import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_petshop/src/models/models.dart';
import 'package:my_petshop/src/services/services.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  void addToCart(ProductModel model) async {
    emit(AddToCartIsLoading());
    final result = await ProductService().addToCart(model);

    emit(result.fold((l) => AddToCartIsFailed(message: l),
        (r) => AddToCartIsSuccess(message: r)));
  }
}
