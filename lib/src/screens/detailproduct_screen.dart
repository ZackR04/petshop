part of 'screens.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  //ubah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "Detail Produk".text.make()),
      body: SafeArea(
          child: BlocConsumer<DetailProductBloc, DetailProductState>(
        listener: (context, state) {
          if (state is DetailProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailProductIsLoading) {
            return const CircularProgressIndicator();
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
              data.name!.text.bodyText1(context).makeCentered(),
              8.heightBox,
              data.price!.text.bodyText1(context).makeCentered(),
            ]).p16();
          }
          return Container();
        },
      )),
    );
  }
}
