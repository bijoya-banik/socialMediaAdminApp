
import 'package:buddyscripts/models/friend/friend_model.dart';
import 'package:buddyscripts/network/api.dart';
import 'package:buddyscripts/network/network_utils.dart';
import 'package:buddyscripts/report/reportModel.dart';
import 'package:buddyscripts/report/report_state.dart';
import 'package:buddyscripts/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportProvider =
    StateNotifierProvider<ReportController, ReportState>(
  (ref) => ReportController(ref: ref),
);

class ReportController
    extends StateNotifier<ReportState> {
  final Ref? ref;
  ReportController({this.ref})
      : super(const ReportInitialState());

  List<ReportModel>? reportModel;
  int currentPage = 1;

  updateSuccessState(Datum reportInstance) {
    state = ReportSuccessState(reportModel!);
  }

  Future fetchReport() async {
    state = const ReportLoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.getAllReport));
      print(responseBody);
      if (responseBody != null) {
        //ReportModel = FriendModel.fromJson(responseBody);
        reportModel = (responseBody as List<dynamic>)
            .map((e) => ReportModel.fromJson(e))
            .toList();
        // currentPage = ReportModel?.meta?.currentPage;
        state = ReportSuccessState(reportModel!);
      } else {
        state = const ReportErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ReportErrorState();
    }
  }

  Future deleteReport({id}) async {
    var requestBody = {'id': id};
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.deleteReport, requestBody),
      );
     
        reportModel!.removeWhere((element) => element.id == id);
        state = ReportSuccessState(reportModel!);
        NavigationService.popNavigate();
      
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ReportErrorState();
    }
  }
}
