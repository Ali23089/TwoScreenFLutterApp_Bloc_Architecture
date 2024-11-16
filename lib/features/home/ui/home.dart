import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc_bloc.dart';
import 'package:flutter_bloc_app/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homebloc.add(HomeInitialEvent()); // Initialize HomeBloc
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeBlocState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Item Carted")));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Item Wishlisted")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Ali Grocery App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white
                  ),
                ),
                // centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      homebloc.add(HomeWishlistNavigateButtonEvent());
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white, // Set icon color to white
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homebloc.add(HomeCartNavigateButtonClicked());
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white, // Set icon color to white
                    ),
                  ),
                ],
                backgroundColor:
                    Colors.deepOrange, // Keep your AppBar background color
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homebloc,
                        productDataModel: successState.products[index]);
                  }),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text("Unknown State"),
              ),
            ); // Handle unknown states gracefully
        }
      },
    );
  }
}
