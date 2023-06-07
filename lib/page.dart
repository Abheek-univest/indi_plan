import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class indiplans extends StatefulWidget {
  const indiplans({super.key});
  @override
  State<indiplans> createState() => _indiplansState();
}
class _indiplansState extends State<indiplans> {
  String planName='';
  String planId='';
  String purchasedOn='';
  String renewalOn='';
  String purchasePrice='';
  String renewalPrice='';

  void init() async
  {super.initState();}

  void getvalues(dynamic data) async {
    setState(() {
      planName = data['activePlanDetails']['planName'];
      planId = data['activePlanDetails']['planId'];
      int pur = data['activePlanDetails']['purchasedOn'];
      DateTime purOn = DateTime.fromMillisecondsSinceEpoch(pur);
      purchasedOn = DateFormat('dd MMM "yy').format(purOn);
      int ren = data['activePlanDetails']['renewalOn'];
      DateTime renon = DateTime.fromMillisecondsSinceEpoch(ren);
      renewalOn = DateFormat("dd MMM ${"' "}yy").format(renon);
      purchasePrice = data['activePlanDetails']['purchasePrice'];
      int renp = data['activePlanDetails']['renewalPrice'];
      renewalPrice=renp.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const Text('Indi PLANS'),
          onPressed: () async {
            var data = await Data.getdata();
              getvalues(data);
              bottomsheet();
          }
      ),
    );
  }
  void bottomsheet() async{
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('PRO membership',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff202020),
                              fontSize: 24
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Active plan :$planName",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff202020),
                              fontSize: 14
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Align(alignment: FractionalOffset.centerLeft,
                                  child: Text('Purchased on',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff606060),
                                          fontSize: 12
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.centerLeft,
                                  child: Text(purchasedOn,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff202020),
                                          fontSize: 14
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text('Purchase Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff606060),
                                        fontSize: 12
                                    )),
                              ),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text(purchasePrice,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff202020),
                                        fontSize: 14
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: FractionalOffset.centerLeft,
                                  child: Text('Expires on',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff606060),
                                          fontSize: 12
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.centerLeft,
                                  child: Text(renewalOn,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff202020),
                                          fontSize: 14
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text('Renewal Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff606060),
                                        fontSize: 12
                                    )),
                              ),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text(renewalPrice,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff202020),
                                        fontSize: 14
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50, //height of button
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.black)),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                          ),
                          child: const Text(
                            'Alright!',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff202020),
                                fontSize: 16
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ],
                ),
              );
            },);
        });
  }
}

