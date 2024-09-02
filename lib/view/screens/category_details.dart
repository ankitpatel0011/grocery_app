import 'package:flutter/material.dart';
import 'package:grocery/utils/widget.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/utils/colors/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CategoryDetails extends StatefulWidget {
  final ProductModel ds;

  const CategoryDetails({super.key, required this.ds});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(firstLetterCapital(input: widget.ds.category ?? ""),
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.white,
              fontSize: 24,
            )),

      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          SizedBox(
            width: fullWidth(context) / 10,
            height: fullHeight(context) / 2.5,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.network(
                widget.ds.image ?? "",
                fit: BoxFit.fill,
              ),
            ),
          ),
          heightSpace(10),
          Row(
            children: [
              Text(
                firstLetterCapital(input: widget.ds.category ?? ""),
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              widthSpace(10),
              Expanded(
                child: Text(
                  "${widget.ds.price.toString()} RS",
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
              ),
            ],
          ),
          heightSpace(10),
          Text(
            widget.ds.title ?? "",
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          heightSpace(10),
          Text(
            widget.ds.description ?? "",
            maxLines: 5,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          heightSpace(10),
          const Text(
            "Ratings",
            maxLines: 5,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          heightSpace(2),
          RatingBar.builder(
            initialRating:
                int.tryParse(widget.ds.rating?.rate.toString() ?? "")!
                    .toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            tapOnlyMode: true,
            updateOnDrag: true,
            glow: true,
            ignoreGestures: true,
            itemCount: 5,
            itemSize: 40,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.green),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
