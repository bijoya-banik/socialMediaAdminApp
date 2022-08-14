import 'package:buddyscripts/controller/auth/user_controller.dart';
import 'package:buddyscripts/controller/feed/feed_details_controller.dart';
import 'package:buddyscripts/controller/friends/all_friends_controller.dart';
import 'package:buddyscripts/controller/friends/friend_suggestions_controller.dart';
import 'package:buddyscripts/models/friend/friend_model.dart';
import 'package:buddyscripts/report/reportModel.dart';
import 'package:buddyscripts/report/report_controller.dart';
import 'package:buddyscripts/services/app_mode.dart';
import 'package:buddyscripts/services/date_time_service.dart';
import 'package:buddyscripts/services/navigation_service.dart';
import 'package:buddyscripts/views/global_components/dialogs/k_dialog.dart';
import 'package:buddyscripts/views/global_components/dialogs/processing_dialog_content.dart';
import 'package:buddyscripts/views/screens/home/feed_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buddyscripts/views/global_components/user_name.dart';
import 'package:buddyscripts/views/global_components/user_profile_picture.dart';
import 'package:buddyscripts/views/styles/b_style.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global_components/dialogs/confirmation_dialog_content.dart';

class ReportCard extends ConsumerStatefulWidget {
  final ReportModel reportData;

  const ReportCard({Key? key, required this.reportData}) : super(key: key);

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<ReportCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(widget.reportData.text ?? "",
                                                style: KTextStyle.subtitle1.copyWith(
                                                    color: KColor.black87,
                                                    fontWeight: FontWeight.normal))),
                                      ],
                                    ),
                                    SizedBox(height: KSize.getHeight(context, 3)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          tooltip: '',
                          onSelected: (selected) {
                            if (selected == 'delete') {
                              _deleteConfirmationDialog(widget.reportData.id);
                            }
                          },
                          color: AppMode.darkMode
                              ? KColor.feedActionCircle
                              : KColor.appBackground,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          offset: const Offset(0, -10),
                          child: Icon(MaterialIcons.more_vert, color: KColor.black87),
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                value: "delete",
                                child: Text('Delete',
                                    style: KTextStyle.subtitle2.copyWith(
                                        color: KColor.black87,
                                        fontWeight: FontWeight.normal))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text("Feed Id : ${widget.reportData.feedId}",
                      style: TextStyle(color: KColor.grey800)),
                       const SizedBox(height: 6),
                    Text("Created At : ${DateTimeService.convert(widget.reportData.createdAt,isCustomDateFormat:true)}",
                      style: TextStyle(color: KColor.grey800)),
                       const SizedBox(height: 6),
                    InkWell(
                      onTap: (){
                        ref.read(feedDetailsProvider.notifier).fetchFeedDetails(widget.reportData.feedId!);
          Navigator.of(context, rootNavigator: true).push((CupertinoPageRoute(builder: (context) => const FeedDetailsScreen())));
                      },
                      child: Text("See Post Details>",
                      style: TextStyle(color: KColor.blue900,fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                color: KColor.grey350,
              ),
              
            ],
          );
  }

  _deleteConfirmationDialog(id) async {
    return (await showPlatformDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (context) => ConfirmationDialogContent(
          titleContent: 'Are you sure you want to delete this report?',
          onPressedCallback: () {
            Navigator.pop(context);
            KDialog.kShowDialog(
                context, const ProcessingDialogContent('Deleting...'),
                barrierDismissible: false);
            ref.read(reportProvider.notifier).deleteReport(id: id);
          }),
    ));
  }
}
