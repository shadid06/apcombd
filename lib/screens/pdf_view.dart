import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdf extends StatefulWidget {
  ViewPdf({Key key, this.link}) : super(key: key);
  String link;
  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _PdfViewerSateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SfPdfViewer.network(
        widget.link,
        scrollDirection: PdfScrollDirection.vertical,
        pageSpacing: 4,
        pageLayoutMode: PdfPageLayoutMode.single,
        controller: _pdfViewerController,
        key: _PdfViewerSateKey,
        initialZoomLevel: 1,
      )),
    );
  }
}
