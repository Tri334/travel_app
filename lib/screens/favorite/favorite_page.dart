import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/bloc_get_data/fetch_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_favorite/favorite_get_bloc.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:travel_app/models/travel_icons_icons.dart';
import 'package:travel_app/widgets/place_info.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteGetBloc>().add(EventGetFavorite());
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocBuilder<FavoriteGetBloc, FavoriteGetState>(
        bloc: BlocProvider.of<FavoriteGetBloc>(context),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: SingleChildScrollView(
              child: Column(
                  children: state.dataFavorite.map<Widget>((data) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        height: 60.sp,
                        width: 240.sp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40.sp,
                                    width: 40.sp,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(data.place.img),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 4.sp,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaceInfo(
                                              widget: data.place,
                                              ref: data.ref),
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.place.judul,
                                          style: GoogleFonts.poppins(
                                              color: styleColor.judul,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\$${data.place.harga}',
                                          style: GoogleFonts.poppins(
                                              color: styleColor.style,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  context.read<FetchDataBloc>().add(
                                      EventFavorite(updateFavorite: data.ref));
                                  Future.delayed(const Duration(seconds: 1))
                                      .then((value) => context
                                          .read<FavoriteGetBloc>()
                                          .add(EventGetFavorite()));
                                },
                                child: Icon(
                                  TravelIcons.favorite,
                                  size: 15.sp,
                                  color: data.place.favorite
                                      ? styleColor.style
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                );
              }).toList()),
            ),
          );
        },
      );
    });
  }
}
