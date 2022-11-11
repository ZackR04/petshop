part of 'screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Tambah Produk'.text.make(),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminIsSuccess) {
            Commons().showSnackBar(context, state.message);
          } else if (state is AdminIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return VStack([
            _buildProductForm(),
            ButtonWidget(
              onPressed: () {
                BlocProvider.of<AdminBloc>(context).add(AddProduct(
                  name: productNameController.text,
                  price: double.parse(productPriceController.text),
                ));
              },
              isLoading: (state is AdminIsLoading) ? true : false,
              text: 'Unggah Produk',
            ).px16()
          ]);
        },
      ),
    );
  }

  Widget _buildProductForm() {
    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Nama Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productPriceController,
        title: 'Harga Produk',
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ZStack(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      state.file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductPictureCubit>(context).getImage();
                    },
                    icon: const Icon(Icons.image),
                  )
                      .box
                      .color(colorName.white.withOpacity(.8))
                      .roundedFull
                      .make(),
                ],
                alignment: Alignment.center,
              ),
            );
          }
          return IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).getImage();
            },
            icon: const Icon(Icons.image),
          );
        },
      )
    ]).p16();
  }
}
