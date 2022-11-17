import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_petshop/src/cubits/cubits.dart';
import 'package:my_petshop/src/models/models.dart';
import 'package:my_petshop/src/services/services.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ProductPictureCubit productPictureCubit;
  AdminBloc(this.productPictureCubit) : super(AdminInitial()) {
    on<AddProduct>((event, emit) async {
      emit(AdminIsLoading());
      ProductModel data = ProductModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          dateTime: DateTime.now(),
          name: event.name,
          price: event.price,
          desc: event.desc);
      final result = await AdminService().addNewProduct(data,
          file: (productPictureCubit.state is ProductPictureIsLoaded)
              ? (productPictureCubit.state as ProductPictureIsLoaded).file
              : null);

      result.fold((l) => emit(AdminIsFailed(message: l)),
          (r) => emit(AdminIsSuccess(message: r)));
    });
  }
}
