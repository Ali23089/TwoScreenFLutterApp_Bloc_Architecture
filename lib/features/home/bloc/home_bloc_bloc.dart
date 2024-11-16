import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_app/data/cart_items.dart';
import 'package:flutter_bloc_app/data/grocery_data.dart';
import 'package:flutter_bloc_app/data/wishlist_items.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistNavigateButtonEvent>(homeWishlistNavigateButtonEvent);
    on<HomeCartNavigateButtonClicked>(homeCartNavigateButtonClicked);
  }

  Future<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList())); // HomeLoadedSuccessState
  }
}

FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event, Emitter<HomeBlocState> emit) {
  print('Wishlist cliked');
  wishlistItems.add(event.clickedProduct);
  emit(HomeProductItemWishlistedActionState());
}

FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
  print('cart Cliked');
  cartItems.add(event.clickedProduct);
  emit(HomeProductItemCartedActionState());
}

FutureOr<void> homeWishlistNavigateButtonEvent(
    HomeWishlistNavigateButtonEvent event, Emitter<HomeBlocState> emit) {
  print('Wishlist Navigation Clicked');
  emit(HomeNavigateToWishlistPageActionState());
}

FutureOr<void> homeCartNavigateButtonClicked(
    HomeCartNavigateButtonClicked event, Emitter<HomeBlocState> emit) {
  print('Cart Navigation clicked');
  emit(HomeNavigateToCartPageActionState());
}
