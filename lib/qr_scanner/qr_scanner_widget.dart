import 'dart:io';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScannerWidget extends StatefulWidget {
  const QrScannerWidget({Key key}) : super(key: key);

  @override
  _QrScannerWidgetState createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final qrKey=GlobalKey(debugLabel:'QR');

  Barcode barcode;
  QRViewController controller;



  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid){
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Qr scanner',
          style: FlutterFlowTheme.title1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body:Stack(
        alignment: Alignment.center,
        children:<Widget> [
          buildQrView(context),
          Positioned(bottom: 10,child: buildResult())],),
      backgroundColor: FlutterFlowTheme.darkBG,
    );
  }

  Widget buildResult() => Text(
    barcode !=null ? 'Result : ${barcode.code}': 'Scan a code',
    maxLines:3,
  );

  Widget buildQrView(BuildContext context) =>QRView(key: qrKey, onQRViewCreated: onQRViewCreated,
  overlay: QrScannerOverlayShape(
    borderColor: Theme.of(context).accentColor,
    borderRadius: 10,
    borderLength: 20,
    borderWidth: 10,
    cutOutSize: MediaQuery.of(context).size.width* 0.8,
  ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
    .listen((barcode)=>setState(() =>this.barcode=barcode));
  }
}