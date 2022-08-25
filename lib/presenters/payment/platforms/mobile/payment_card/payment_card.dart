import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/main.dart';
import 'package:flutter_credit_card/presenters/payment/shared/card_type.dart';
import 'package:flutter_credit_card/presenters/payment/shared/card_utilis.dart';
import 'package:flutter_credit_card/presenters/payment/shared/input_formatters.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  TextEditingController creditCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagamento com cartão'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (cardNum) {},
                      controller: creditCardController,
                      keyboardType: TextInputType.number,
                      validator: CardUtils.validateCardNum,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SvgPicture.asset(
                            "lib/presenters/payment/assets/icons/card.svg",
                          ),
                        ),
                        suffixIcon: SizedBox(
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: CardUtils.getCardIcon(CardType.Master),
                          ),
                        ),
                        hintText: "Número",
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        onSaved: (name) {},
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SvgPicture.asset(
                                "lib/presenters/payment/assets/icons/user.svg"),
                          ),
                          hintText: "Nome completo",
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onSaved: (cvv) {},
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: CardUtils.validateCVV,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SvgPicture.asset(
                                    "lib/presenters/payment/assets/icons/Cvv.svg"),
                              ),
                              hintText: "CVV",
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                          child: TextFormField(
                            onSaved: (value) {},
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter(),
                            ],
                            validator: CardUtils.validateDate,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SvgPicture.asset(
                                    "lib/presenters/payment/assets/icons/calender.svg"),
                              ),
                              hintText: "MM/YY",
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(flex: 1),
              OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                    "lib/presenters/payment/assets/icons/scan.svg"),
                label: const Text("Escanear cartão"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: defaultPadding),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Adicionar cartão"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
