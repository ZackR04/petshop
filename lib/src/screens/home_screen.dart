part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserIsFailed) {
              Commons().showSnackBar(context, state.message);
            } else if (state is UserIsLogOut) {
              context.go(routeName.login);
            }
          },
          builder: (context, state) {
            if (state is UserIsLoading) {
              return const CircularProgressIndicator().centered();
            } else if (state is UserIsSuccess) {
              return VStack(
                [
                  _buildAppBar(context, state.data),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, UserModel data) {
    return VxBox(
        child: HStack([
      HStack([
        VxCircle(
          radius: 65,
          backgroundImage: DecorationImage(
            image: NetworkImage(data.photoProfile!),
            fit: BoxFit.cover,
          ),
        ).onTap(() {
          context.go(routeName.adminPath);
        }),
        10.widthBox,
        "Selamat Datang,\n".richText.size(11).withTextSpanChildren([
          data.username!.textSpan.size(14).bold.uppercase.make(),
        ]).make(),
      ]).expand(),
      IconButton(
        onPressed: () {
          BlocProvider.of<UserBloc>(context).add(LogOutUser());
        },
        icon: const Icon(Icons.logout),
      ),
    ])).make();
  }
}
