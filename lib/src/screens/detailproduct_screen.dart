part of 'screens.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  //ubah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "Detail Produk".text.make()),
      bottomNavigationBar: BlocConsumer<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartIsSuccess) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return BlocBuilder<DetailProductBloc, DetailProductState>(
            builder: (context, detailState) {
              if (detailState is DetailProductIsSuccess) {
                return ButtonWidget(
                  text: 'Add to Cart',
                  isLoading: (state is AddToCartIsLoading) ? true : false,
                  onPressed: () {
                    BlocProvider.of<AddToCartCubit>(context)
                        .addToCart(detailState.model);
                  },
                );
              }
              return Container();
            },
          );
        },
      ),
      body: SafeArea(
        child: BlocConsumer<DetailProductBloc, DetailProductState>(
          listener: (context, state) {
            if (state is DetailProductIsFailed) {
              Commons().showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DetailProductIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailProductIsSuccess) {
              final data = state.model;
              return VStack([
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data.picture!,
                    fit: BoxFit.cover,
                  ),
                ),
                8.heightBox,
                data.price!.text.bold.size(20).base.make(),
                8.heightBox,
                data.name!.text.bodyText1(context).make(),
                8.heightBox,
                data.desc!.text.make(),
                24.heightBox,
                HStack([
                  "Variant Produk".text.make(),
                  16.widthBox,
                ])
              ]).p16();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
