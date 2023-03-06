import 'package:flutter/material.dart' hide Card;
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mu_project/common/abtest/abtest_util.dart';
import 'package:mu_project/common/widgets/easy_refresh_header.dart';
import 'package:mu_project/common/widgets/home_loading.dart';
import 'package:mu_project/common/widgets/no_shadow_scroll_behavior.dart';
import 'package:mu_project/gen/assets.gen.dart';
import 'package:mu_project/modules/debug_page/index.dart';
import 'package:mu_project/modules/home_page/widgets/special_card/drift_bottle_card.dart';
import 'package:mu_project/modules/home_page/widgets/special_card/right_guide_countdown_tag.dart';
import 'package:mu_project/modules/home_page/widgets/special_card/spotlight/home_spotlight_card.dart';
import 'package:mu_project/pkgs/swipeable_stack/swipable_stack.dart';

import '../../drift_bottle/mixins/drift_bottle_card_mixin.dart';
import '../../match/mixins/square_guide_card_mixin.dart';
import '../controllers/home_controller.dart';
import '../mixins/match_recommend_user_card_mixin.dart';
import '../mixins/spotlight_card_mixin.dart';
import '../widgets/special_card/match_succee_tag.dart';
import '../widgets/special_card/recommend_match_user_card.dart';
import '../widgets/special_card/square_guide_card.dart';
import 'card.dart';
import 'home_filter_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const DebugPage());
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => RepaintBoundary(
                child: controller.isAdjustCampaiginHomePageGroup
                    ? buildAdjustCampaiginHeader()
                    : buildHeader())),
            Obx(() => RepaintBoundary(
                  child: IndexedStack(
                    index: controller.homePageIndex.value,
                    children: [
                      buildMeetUCard(),
                      if (controller.isAdjustCampaiginHomePageGroup)
                        buildAdjustCampaiginContainer(),
                    ],
                  ),
                )),
            buildRightGuideCountDownSneakBar(),
            buildMatchSucceedCountDownSneakBar(),
          ],
        ),
      ),
    );
  }

  Widget buildAdjustCampaiginContainer() {
    return Container(
      margin: const EdgeInsets.only(
        top: kToolbarHeight + 10,
        left: 10,
        right: 10,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: controller.adjustCampaiginItem.value?.pageWidget,
    );
  }

  Widget buildMeetUCard() {
    return IndexedStack(
      index: controller.currentDataState.value.index,
      children: [
        buildLoading(),
        buildLoading(),
        buildSwipableCard(controller),
        buildNoData(controller),
      ],
    );
  }

  Widget buildMatchSucceedCountDownSneakBar() {
    return Visibility(
      maintainState: true,
      maintainAnimation: false,
      maintainSize: false,
      visible: (controller.showMatchUserDialog && true),
      child: RepaintBoundary(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Align(
            alignment: Alignment.topCenter,
            child: MatchSucceedTag(
              name: controller.matchSucceedName.value,
              onTap: controller.onMatchSucceed,
              onClose: controller.disappearMatchSucceed,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRightGuideCountDownSneakBar() {
    return Visibility(
      maintainState: true,
      maintainAnimation: false,
      maintainSize: false,
      visible: ABTestUtil.isRightGuideGroupB() && controller.isShowCountDown,
      child: RepaintBoundary(
        child: Align(
          alignment: Alignment.topCenter,
          child: RightGuideCountDownTag(
            countDownSec: controller.timeEnd,
            countDownCallback: (sec) {
              controller.timeEnd = sec;
            },
            controller: controller.countDownController,
            onCountDownCompleted: () async {
              await controller.refreshRemainsCount();
            },
            onTap: controller.jumpToRightGuidePage,
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: controller.isMeetUPage && controller.canRewind,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            child: IconButton(
              icon: Assets.images.homeCancel.image(
                width: 28,
                height: 28,
              ),
              onPressed: controller.onRewind,
            ),
          ),
          Image(
            width: 115,
            height: 24,
            image: Assets.images.homeMeetuLogo,
          ),
          Row(
            children: [
              if (controller.isMeetUPage)
                IconButton(
                  icon: Assets.images.homeMenu.image(
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () => Get.to(
                    () => const HomeFilterPage(),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget buildAdjustCampaiginHeader() {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (controller.isMeetUPage)
            Visibility(
              visible: controller.canRewind,
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              child: IconButton(
                icon: Assets.images.homeCancel.image(
                  width: 28,
                  height: 28,
                ),
                onPressed: controller.onRewind,
              ),
            )
          // else if (controller
          //         .adjustCampaiginItem.value?.tabBarLeftButtonWidget !=
          //     null)
          //   controller.adjustCampaiginItem.value!.tabBarLeftButtonWidget!
          else
            const SizedBox(width: 28),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DisplayAdjustCampaiginTabBarItem(
                  onTap: controller.onMeetUHome,
                  activeWidget: Image.asset(
                      'assets/images/home_meetu_logo_active.png',
                      width: 86,
                      height: 26),
                  inactiveWidget: Image.asset(
                      'assets/images/home_meetu_logo_inactive.png',
                      width: 86,
                      height: 26),
                  isActive: controller.isMeetUPage,
                ),
                if (controller.isAdjustCampaiginHomePageGroup ||
                    controller.adjustCampaiginItem.value != null) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    color: const Color(0xFFEEEEEE),
                    height: 18,
                    width: 1,
                  ),
                  _DisplayAdjustCampaiginTabBarItem(
                    onTap: controller.onAdjustCampaigin,
                    activeWidget: controller
                        .adjustCampaiginItem.value!.activeTabBarTitleWidget,
                    inactiveWidget: controller
                        .adjustCampaiginItem.value!.inactiveTabBarTitleWidget,
                    isActive: !controller.isMeetUPage,
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              if (controller.isMeetUPage)
                IconButton(
                  icon: Assets.images.homeMenu.image(
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () => Get.to(
                    () => const HomeFilterPage(),
                  ),
                )
              else if (controller
                      .adjustCampaiginItem.value?.tabBarRightButtonWidget !=
                  null)
                controller.adjustCampaiginItem.value!.tabBarRightButtonWidget!
              else
                const SizedBox(width: 28)
            ],
          )
        ],
      ),
    );
  }

  Widget buildSwipableCard(HomeController logic) {
    return SwipableStack(
      controller: logic.swipableStackController,
      itemCount: logic.recommendUsers.length,
      allowVerticalSwipe: false,
      swipeAnchor: SwipeAnchor.bottom,
      stackClipBehaviour: Clip.antiAlias,
      horizontalSwipeThreshold: 0.5,
      customSwipeAssistDuration: logic.customSwipeAssistDuration,
      onSwipeCompleted: logic.onSwipeCompleted,
      onWillMoveNext: logic.onWillMoveNext,
      builder: (BuildContext context, props) {
        bool isCurrentCard =
            logic.swipableStackController.currentIndex == props.index;

        var data = logic.recommendUsers[props.index];

        if (data.recommendUserIdentifier == kMatchRecommendCardID) {
          return RecommendMatchUserCard(
            onClickSwipeButton: logic.onRecommendMatchUserCardSwipe,
            recommendUser: data,
          );
        }
        if (data.recommendUserIdentifier == kSpotlightCardID) {
          return SpotLightCard(
            spotlightList: logic.spotlightRecommendList,
            onTap: logic.jumpToSpotlightMorePage,
            onClickSpotLight: (index) {
              logic.clickSpotlightWithIndex(index);
            },
          );
        }
        if ([kFirstDriftBottleCardID, kSecondDriftBottleCardID]
            .contains(data.recommendUserIdentifier)) {
          return DriftBottleCard(
            onTap: logic.onTapDriftCard,
            id: data.recommendUserIdentifier!,
          );
        }
        if (data.recommendUserIdentifier == kSquareGuideCardID) {
          return SquareGuideCard(
            info: logic.squareGuideCardInfo,
            onTap: logic.onTapToMatch,
          );
        }

        return Card(
          direction: props.direction,
          swipeProgress: props.swipeProgress,
          showCardOverlay: !logic.isRewinding && isCurrentCard,
          isCurrentCard: isCurrentCard,
          data: data,
          onClickSpotLight: (uid) {
            logic.clickSpotlightWithIndex(uid);
          },
        );
      },
    );
  }

  Widget buildLoading() {
    return const Center(child: HomeLoader());
  }

  Widget buildNoData(HomeController logic) {
    return Padding(
      padding: EdgeInsets.only(top: 86.h),
      child: EasyRefresh(
        header: EasyRefreshHeader(),
        onRefresh: logic.onRefreshData,
        child: CustomScrollView(
          scrollBehavior: NoShadowScrollBehavior(),
          slivers: [
            SliverFillRemaining(
              child: Container(
                color: Colors.white,
                width: Get.width,
                child: Align(
                  alignment: const Alignment(0, -0.2),
                  child: Image.asset(
                    'assets/images/home/home_recommend_empty.png',
                    width: 200.w,
                    height: 186.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DisplayAdjustCampaiginTabBarItem extends StatelessWidget {
  const _DisplayAdjustCampaiginTabBarItem({
    Key? key,
    required this.onTap,
    required this.activeWidget,
    required this.inactiveWidget,
    required this.isActive,
  }) : super(key: key);

  final void Function() onTap;
  final Widget activeWidget;
  final Widget inactiveWidget;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isActive ? _WrapItemBaseLine(child: activeWidget) : inactiveWidget,
    );
  }
}

class _WrapItemBaseLine extends StatelessWidget {
  const _WrapItemBaseLine({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      child,
      Positioned(
        left: 8,
        right: 8,
        bottom: -10,
        child: Container(
          width: 64,
          height: 2,
          decoration: BoxDecoration(
              color: const Color(0xFFFF4B7C),
              borderRadius: BorderRadius.circular(1.5)),
        ),
      )
    ]);
  }
}
