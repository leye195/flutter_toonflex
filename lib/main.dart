import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/currency_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color(0xff181818),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ), //box with size
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'Hey, Selena',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 4),
                              Text('Welcome back',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 60),
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 4),
                      const Text('\$5 194 382',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Button(
                              text: 'Transfer',
                              bgColor: Color(0xfff2b33a),
                              textColor: Color(0xff000000)),
                          Button(
                              text: 'Request',
                              bgColor: Color(0xff1f2123),
                              textColor: Colors.white)
                        ],
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('Wallets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600)),
                          Text('View All',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const CurrencyCard(
                          amount: '6 425',
                          currency: 'EUR',
                          name: 'Euro',
                          symbol: Icons.euro_symbol,
                          isInverted: false),
                      const CurrencyCard(
                        amount: '2 200',
                        currency: 'BTC',
                        name: 'Bitcoin',
                        symbol: Icons.currency_bitcoin,
                        isInverted: true,
                        offset: -25,
                      ),
                      const CurrencyCard(
                        amount: '55 203',
                        currency: 'USD',
                        name: 'Dollar',
                        symbol: Icons.attach_money,
                        isInverted: false,
                        offset: -50,
                      ),
                    ]),
              ),
            )));
  }
}
