import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/downloads/widgets/image_post_widget.dart';

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvevt.getDownloadsImages());
    });
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Introducing Downloads for you",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        khight,
        const Text(
          "We will download a personalized selection of\n movies and shows for you so there is\n always to something to watch on your\n device",
          style: TextStyle(fontSize: 22, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(builder: (context, state) {
          return state.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        radius: size.width * 0.33,
                      ),
                      ImagePostWidget(
                        size: size,
                        images:
                            '$imageAppendUrl${state.downloads[0].posterpath}',
                        angle: 30,
                        hight: 0.44,
                        margin: const EdgeInsets.only(left: 120, bottom: 60),
                      ),
                      ImagePostWidget(
                        size: size,
                        images:
                            '$imageAppendUrl${state.downloads[1].posterpath}',
                        angle: -30,
                        hight: 0.44,
                        margin: const EdgeInsets.only(right: 120, bottom: 60),
                      ),
                      ImagePostWidget(
                        size: size,
                        images:
                            '$imageAppendUrl${state.downloads[2].posterpath}',
                        angle: 0,
                        margin: const EdgeInsets.only(top: 0),
                      ),
                    ],
                  ),
                );
        }),
      ],
    );
  }
}
