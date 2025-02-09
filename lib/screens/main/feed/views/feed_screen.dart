import 'package:creative_movers/blocs/feed/feed_bloc.dart';
import 'package:creative_movers/blocs/profile/profile_bloc.dart';
import 'package:creative_movers/constants/storage_keys.dart';
import 'package:creative_movers/di/injector.dart';
import 'package:creative_movers/helpers/app_utils.dart';
import 'package:creative_movers/helpers/storage_helper.dart';
import 'package:creative_movers/screens/main/feed/views/create_post.dart';
import 'package:creative_movers/screens/main/feed/widgets/feed_loader.dart';
import 'package:creative_movers/screens/main/feed/widgets/new_post_item.dart';
import 'package:creative_movers/screens/main/feed/widgets/post_card.dart';
import 'package:creative_movers/screens/main/feed/widgets/post_item.dart';
import 'package:creative_movers/screens/main/feed/widgets/status_views.dart';
import 'package:creative_movers/screens/main/notification/views/notification_screen.dart';
import 'package:creative_movers/screens/main/search/views/search__screen.dart';
import 'package:creative_movers/screens/widget/error_widget.dart';
import 'package:creative_movers/screens/widget/sliver_persistent_delegate.dart';
import 'package:creative_movers/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  String? username;
  FeedBloc feedBloc = FeedBloc();
  @override
  void initState() {
    feedBloc.add(GetFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFeedAppBar(
        username: username,
      ),
      body: NestedScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverPersistentHeader(
            //     pinned: true,
            //     floating: true,
            //     delegate: SliverAppBarDelegate(
            //       const PreferredSize(
            //           preferredSize: Size.fromHeight(0),
            //           child: SizedBox.shrink()),
            //     )),
            // SliverPersistentHeader(
            //     pinned: true,
            //     // floating: true,
            //     delegate: SliverAppBarDelegate(
            //       const PreferredSize(
            //         preferredSize: Size.fromHeight(100),
            //         child: StatusViews(
            //           curvedBottom: true,
            //         ),
            //       ),
            //     )),
          ];
        },
        body: RefreshIndicator(
          onRefresh: (() async {
            await Future.delayed(const Duration(seconds: 1));
            feedBloc.add(GetFeedEvent());
          }),
          child: CustomScrollView(
            // controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                  // pinned: true,
                  floating: true,
                  delegate: SliverAppBarDelegate(
                    const PreferredSize(
                      preferredSize: Size.fromHeight(100),
                      child: StatusViews(
                        curvedBottom: true,
                      ),
                    ),
                  )),
              SliverToBoxAdapter(child: PostCard(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreatePostScreen(),
                  ));
                },
              )),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: BlocBuilder<FeedBloc, FeedState>(
                  bloc: feedBloc,
                  builder: (context, state) {
                    if (state is FeedLoadingState) {
                      return const SliverToBoxAdapter(child: FeedLoader());
                    }
                    if (state is FeedSuccessState) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return NewPostItem(
                              feed: state.feedResponse.feeds.data[index],
                            );
                          },
                          childCount: state.feedResponse.feeds.data.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                        ),
                      );
                    }
                    if (state is FeedFaliureState) {
                      return SliverToBoxAdapter(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: AppPromptWidget(
                                isSvgResource: true,
                                message: state.error,
                                onTap: () => feedBloc.add(GetFeedEvent()),
                              )));
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomFeedAppBar({Key? key, this.username}) : super(key: key);
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocProvider.value(
                      value: injector.get<ProfileBloc>(),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return Text(
                              'Hello ${context.watch<ProfileBloc>().firstname}!',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black));
                        },
                      ),
                    ),
                    Text('${greeting()} 🌞',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return ' Good Morning';
    }
    if (hour < 17) {
      return ' Good Afternoon';
    }
    return ' Good Evening';
  }
}
