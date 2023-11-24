import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'assets.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF1E2630);
    const textColor = Color(0xFFFFFFFF);

    return  Scaffold (
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, backgroundColor),
      body: buildBody(context, textColor),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  PreferredSize buildAppBar(BuildContext context, Color backgroundColor) {
    final Widget menuSvg = SvgPicture.asset(menu, width: 24.0, height: 24.0);
    final Widget bellSvg = SvgPicture.asset(bell, width: 24.0, height: 24.0);

    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 5.0,
          right: 5.0,
        ),
        child: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: backgroundColor,
          leading: Builder(
            builder: (BuildContext builderContext) {
              return IconButton(
                icon: menuSvg,
                onPressed: () {
                  // Access Scaffold using the builderContext
                  Scaffold.of(builderContext).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: bellSvg,
              onPressed: () {},
            ),
          ],
        )
      )
    );
  }

  Widget buildBody(BuildContext context, Color backgroundColor) {
    final Widget searchSvg = SvgPicture.asset(search, width: 12.0, height: 12.0);
    final Widget filterSvg = SvgPicture.asset(filter, width: 12.0, height: 12.0);

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: searchSvg,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: filterSvg,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19.5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF303B49),
                ),
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: tabCarousel(context),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: events(context),
              ),
            ],
          )
      ),
    );
  }
  
  Widget tabCarousel(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List <String> tabs = ['All', 'Popular', 'New', 'Top', 'Free'];

    return CarouselSlider(
      options: CarouselOptions(
        initialPage: 1,
        height: 60.0,
        reverse: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.322, // Adjust this value to display more tabs at a time
        onPageChanged: (index, reason) {
          // setState(() {
          //   _current = index;
          // });
        },
      ),
      items: tabs.map((tab) {
        double tabWidth = screenWidth / 3;

        return Builder(
          builder: (BuildContext context) {
            return Container(
              // width: MediaQuery.of(context).size.width,
              width: tabWidth,
              margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: tab == 'All' ? const Color(0xFF8250CA) : const Color(0xFF303B49),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: tab == 'All' ? const Color(0xFF8250CA).withOpacity(0.8) : const Color(0xFF000000).withOpacity(0),
                    blurRadius: 7.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: tab == 'All' ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget events(BuildContext context) {
    return Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Events',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF8250CA),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CarouselSlider(
              options: CarouselOptions(
                initialPage: 1,
                height: 360.0,
                enableInfiniteScroll: true,
                aspectRatio: 2.0,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(seconds: 5),
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   _current = index;
                  // });
                },
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return eventCard(context, 'https://i.ibb.co/S5CPJTY/1ee05a32-fc1e-4382-86f1-84a3d380754d.jpg', '10 - 12 December, 2023', 'Polygon Global Guild Tour - Kolkata');
                  },
                );
              }).toList(),
            ),
          )
        ],
      );
  }

  Widget eventCard(BuildContext context, String imgURL, String dateInfo, String title) {
    final Widget heartSVG = SvgPicture.asset(heart, width: 24.0, height: 24.0);

    return Container(
      // width: MediaQuery.of(context).size.width,
      width: 260.00,
      height: 360.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(36.0)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 260.0,
              height: 360.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36.0)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(36.0)),
                child: Image.network(
                  imgURL,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 260.0,
              height: 360.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(36.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 444.0,
                    // spreadRadius: 36.0,
                    offset: const Offset(0.0, -120.0),
                    inset: true,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15.0,
            right: 15.0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: heartSVG,
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            width: 220.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateInfo,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 20.0,
      ),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFF303B49),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            bottomNavigationBarItem(context, home),
            bottomNavigationBarItem(context, add),
            bottomNavigationBarItem(context, discover),
            bottomNavigationBarItem(context, profile),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBarItem(BuildContext context, String imgURL) {
    final Widget svg = SvgPicture.asset(imgURL, width: 24.0, height: 24.0);

    return Center(
      child: svg
    );
  }
}