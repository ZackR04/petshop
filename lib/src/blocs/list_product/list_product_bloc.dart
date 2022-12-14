import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_petshop/src/models/models.dart';
import 'package:my_petshop/src/services/services.dart';
import 'package:my_petshop/src/utilities/utilities.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(ListProductInitial()) {
    on<FetchListProduct>((event, emit) async {
      emit(ListProductIsLoading());
      final result = await ProductService().fetchListProduct();

      emit(result.fold((l) => ListProductIsFailed(message: l),
          (r) => ListProductIsSuccess(products: r)));
    });
  }
}
