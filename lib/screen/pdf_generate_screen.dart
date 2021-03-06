import 'package:flutter/material.dart';
import 'package:pdf_invoice/generator/pdf_invoice_generator.dart';
import 'package:pdf_invoice/model/companyDetail.dart';
import 'package:pdf_invoice/model/customer.dart';
import 'package:pdf_invoice/model/invoice.dart';
import 'package:pdf_invoice/utils/pdf_storageUtils.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("INVOICE PDF"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Icon(Icons.picture_as_pdf, size: 100, color: Colors.white),
                    const SizedBox(height: 16),
                    Text(
                      "Invoice Pdf here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: FittedBox(
                    child: Text(
                      "Download and Show PDF",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));
                    final invoice = Invoice(
                      companyDetailModel: CompanyDetailModel(
                        name: 'ABC Company',
                        address: 'xxxxxx yyyyyy, zzzzzz - 0000000',
                      ),
                      customer: Customer(
                        name: 'xyz',
                        phoneNumber: '9000050000',
                      ),
                      info: InvoiceInfo(
                        orderedDate: date,
                        deliveryDate: dueDate,
                        invoiceDescription:
                            'This Order Billing Details are Verified and Generated by Official ABC Company Team',
                        billNumber: '${DateTime.now().year}-9999',
                      ),
                      items: [
                        InvoiceItem(
                          productName: 'Asus Zenfone Max M1 pro',
                          quantity: 1,
                          unitPrice: 10099,
                        ),
                        InvoiceItem(
                          productName: 'Boat EarPhones',
                          quantity: 1,
                          unitPrice: 1299,
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceGenerator.generate(invoice);

                    PdfStorageUtils.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
