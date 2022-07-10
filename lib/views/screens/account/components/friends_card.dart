import 'package:buddyscripts/controller/auth/user_controller.dart';
import 'package:buddyscripts/controller/friends/all_friends_controller.dart';
import 'package:buddyscripts/controller/friends/friend_suggestions_controller.dart';
import 'package:buddyscripts/models/friend/friend_model.dart';
import 'package:buddyscripts/services/app_mode.dart';
import 'package:buddyscripts/services/navigation_service.dart';
import 'package:buddyscripts/views/global_components/dialogs/k_dialog.dart';
import 'package:buddyscripts/views/global_components/dialogs/processing_dialog_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buddyscripts/views/global_components/user_name.dart';
import 'package:buddyscripts/views/global_components/user_profile_picture.dart';
import 'package:buddyscripts/views/styles/b_style.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global_components/dialogs/confirmation_dialog_content.dart';

class FriendsCard extends ConsumerStatefulWidget {
  final FriendType type;
  final Datum friendData;

  const FriendsCard({Key? key, required this.type, required this.friendData})
      : super(key: key);

  @override
  _FriendsCardState createState() => _FriendsCardState();
}

class _FriendsCardState extends ConsumerState<FriendsCard> {
  @override
  Widget build(BuildContext context) {
    return widget.friendData.id ==
            ref.read(userProvider.notifier).userData!.user!.id
        ? Container()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserProfilePicture(
                          avatarRadius: 25,
                          profileURL: widget.friendData.profilePic,
                          onTapNavigate: true,
                          slug: widget.friendData.username,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: KSize.getHeight(context, 10)),
                              Row(
                                children: [
                                  Expanded(
                                    child: UserName(
                                      name:
                                          '${widget.friendData.firstName} ${widget.friendData.lastName}',
                                      onTapNavigate: true,
                                      type: 'profile',
                                      slug: widget.friendData.username,
                                      userId: widget.friendData.id,
                                      overflowVisible: true,
                                      backgroundColor: AppMode.darkMode
                                          ? KColor.darkAppBackground
                                          : KColor.appBackground,
                                      textStyle: KTextStyle.subtitle1.copyWith(
                                          color: KColor.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
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
                        _deleteConfirmationDialog(widget.friendData.id);
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
              SizedBox(height: KSize.getHeight(context, 12)),
            ],
          );
  }

  _deleteConfirmationDialog(id) async {
    return (await showPlatformDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (context) => ConfirmationDialogContent(
          titleContent: 'Are you sure you want to delete this user?',
          onPressedCallback: () {
            Navigator.pop(context);
            KDialog.kShowDialog(
                context, const ProcessingDialogContent('Deleting...'),
                barrierDismissible: false);
            ref.read(friendSuggestionsprovider.notifier).deleteUser(id: id);
          }),
    ));
  }
}
