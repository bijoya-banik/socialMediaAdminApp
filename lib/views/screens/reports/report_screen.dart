// ignore: must_be_immutable
import 'package:buddyscripts/controller/friends/all_friends_controller.dart';
import 'package:buddyscripts/controller/friends/friend_suggestions_controller.dart';
import 'package:buddyscripts/controller/friends/state/friend_suggestions_state.dart';
import 'package:buddyscripts/controller/pagination/friends/friend_suggestions_scroll_provider.dart';
import 'package:buddyscripts/controller/pagination/scroll_state.dart';
import 'package:buddyscripts/report/report_controller.dart';
import 'package:buddyscripts/report/report_state.dart';
import 'package:buddyscripts/views/global_components/k_cupertino_nav_bar.dart';
import 'package:buddyscripts/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:buddyscripts/views/global_components/loading_indicators/k_pages_loading_inidcator.dart';
import 'package:buddyscripts/views/screens/account/components/friends_card.dart';
import 'package:buddyscripts/views/screens/reports/reportCard.dart';
import 'package:buddyscripts/views/screens/reports/reportCard.dart';
import 'package:buddyscripts/views/styles/b_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportProvider);

    
     

    return CupertinoPageScaffold(
      backgroundColor: KColor.darkAppBackground,
      navigationBar: KCupertinoNavBar(title: 'Report', automaticallyImplyLeading: false, hasLeading: true),
      child: reportState is ReportSuccessState
          ? CustomScrollView(
          
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              CupertinoSliverRefreshControl(onRefresh: () => ref.read(reportProvider.notifier).fetchReport()),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      SizedBox(height: KSize.getHeight(context, 20)),
                      Column(
                        children: List.generate(reportState.reportModel.length, (index) {
                          return ReportCard(
                              reportData: reportState.reportModel[index]);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          : const Center(child: KLoadingIndicator(
         
          ))
    );
  }
}
