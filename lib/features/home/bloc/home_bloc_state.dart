part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

sealed class HomeActionState extends HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

final class HomeLoadingState extends HomeBlocState {}

final class HomeLoadedSuccessState extends HomeBlocState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products}); // Constructor
}

final class HomeErrorState extends HomeBlocState {}

final class HomeNavigateToWishlistPageActionState extends HomeActionState {}

final class HomeNavigateToCartPageActionState extends HomeActionState {}

final class HomeProductItemWishlistedActionState extends HomeActionState {}

final class HomeProductItemCartedActionState extends HomeActionState {}
