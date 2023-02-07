import 'package:flutter/material.dart';

const _black = Colors.black;
const _white = Colors.white;

class CurrencyCard extends StatelessWidget {
  final String name;
  final String amount;
  final String currency;
  final IconData symbol;
  final bool isInverted;
  final double? offset;

  const CurrencyCard(
      {super.key,
      required this.amount,
      required this.currency,
      required this.name,
      required this.symbol,
      required this.isInverted,
      this.offset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset ?? 0),
      child: Container(
        clipBehavior: Clip.hardEdge, // hide overflow
        decoration: BoxDecoration(
            color:
                isInverted ? const Color(0xffffffff) : const Color(0xff1f2123),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(58),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: isInverted ? _black : _white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(amount,
                          style: TextStyle(
                              color: isInverted ? _black : _white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(currency,
                          style: TextStyle(
                              color:
                                  isInverted ? Colors.black87 : Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                ],
              ),
              Transform.scale(
                  scale: 2.2,
                  child: Transform.translate(
                    offset: const Offset(-10, 15),
                    child: Icon(
                      symbol,
                      color: isInverted ? _black : _white,
                      size: 80,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
