import 'package:flutter/material.dart';

import '../Model Class/bitcoin_Model.dart';
import '../Service/BitcoinService.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List Price = [];
  List bitname = [];
  bool isloading = false;
  late BitCoin _coins;
  BitCoinService bitcoinService = BitCoinService();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    setState(() {
      isloading = true;
    });
    BitCoin coins = await bitcoinService.GetDetails();
    setState(() {
      _coins = coins;
      _coins.bpi.forEach((k,v) {
        bitname.add(v.code);
        Price.add(v.rate);
      });
    });
    setState(() {
      isloading = false;
    });
  }

  int _selectedItemIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade500,
      body: isloading ?
      const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 60,
      ) :
      SafeArea(
        top: true,
        bottom: true,
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    'assets/coin.jpg'
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).width/6,),

              Text(
                _selectedItemIndex == -1 ? 'Price':
                Price[_selectedItemIndex],
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.yellow.shade800,
                  fontWeight: FontWeight.w300
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 250,
                child: ListWheelScrollView(
                  itemExtent: 60,
                  useMagnifier: true,
                  magnification: 1.5,
                  children: bitname.map((e) => Card(
                    elevation: 1,
                    color: Colors.teal,
                    child: Center(
                      child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  )).toList(),
                  onSelectedItemChanged: (int index){
                    setState(() {
                      _selectedItemIndex = index;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



