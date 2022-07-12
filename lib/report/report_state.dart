import 'package:buddyscripts/models/friend/friend_model.dart';
import 'package:buddyscripts/report/reportModel.dart';

abstract class ReportState {
    const ReportState();
}
class ReportInitialState extends ReportState {
    const ReportInitialState();
}
class ReportLoadingState extends ReportState {
    const ReportLoadingState();
}
class ReportSuccessState extends ReportState {
   final List<ReportModel> reportModel;
    const ReportSuccessState(this.reportModel);
}
class ReportErrorState extends ReportState {
    const ReportErrorState();
}