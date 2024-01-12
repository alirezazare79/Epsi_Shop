import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    double subtotal = 129.36;
    double tax = subtotal * 0.2;
    double total = subtotal + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text('Finalisation de la commande'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          OrderSummaryCard(subtotal: subtotal, tax: tax, total: total),
          SizedBox(height: 16),
          ShippingAddressCard(),
          SizedBox(height: 16),
          PaymentMethodCard(
            onMethodSelected: (method) {
              setState(() {
                selectedPaymentMethod = method;
              });
            },
            selectedMethod: selectedPaymentMethod,
          ),
          ConfirmPurchaseButton(selectedPaymentMethod: selectedPaymentMethod),
        ],
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final double subtotal, tax, total;

  const OrderSummaryCard({
    Key? key,
    required this.subtotal,
    required this.tax,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Récapitulatif de votre commande'),
            SizedBox(height: 8),
            Text('Sous-Total: ${subtotal.toStringAsFixed(2)}€'),
            Text('TVA: ${tax.toStringAsFixed(2)}€'),
            Text('TOTAL: ${total.toStringAsFixed(2)}€'),
          ],
        ),
      ),
    );
  }
}
class ShippingAddressCard extends StatelessWidget {
  final String name = 'Michel Le Poney';
  final String address = '8 rue des ouvertures de portes';
  final String postalCode = '93204 CORBEAUX';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adresse de livraison',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(address),
            Text(postalCode),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final Function(String) onMethodSelected;
  final String? selectedMethod;

  const PaymentMethodCard({
    Key? key,
    required this.onMethodSelected,
    this.selectedMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Méthode de paiement'),
            Wrap(
              spacing: 8.0,
              children: [
                PaymentMethodIcon(
                  method: 'ApplePay',
                  icon: FontAwesomeIcons.applePay,
                  selected: selectedMethod == 'ApplePay',
                  onSelected: onMethodSelected,
                ),
                PaymentMethodIcon(
                  method: 'Visa',
                  icon: FontAwesomeIcons.ccVisa,
                  selected: selectedMethod == 'Visa',
                  onSelected: onMethodSelected,
                ),
                PaymentMethodIcon(
                  method: 'MasterCard',
                  icon: FontAwesomeIcons.ccMastercard,
                  selected: selectedMethod == 'MasterCard',
                  onSelected: onMethodSelected,
                ),
                PaymentMethodIcon(
                  method: 'PayPal',
                  icon: FontAwesomeIcons.paypal,
                  selected: selectedMethod == 'PayPal',
                  onSelected: onMethodSelected,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodIcon extends StatelessWidget {
  final String method;
  final IconData icon;
  final bool selected;
  final Function(String) onSelected;

  const PaymentMethodIcon({
    Key? key,
    required this.method,
    required this.icon,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(method),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: selected ? Border.all(color: Colors.red, width: 2) : null,
          color: selected ? Colors.red.withOpacity(0.2) : null,
        ),
        child: Column(
          children: [
            FaIcon(
              icon,
              size: 40,
              color: selected ? Colors.red : null,
            ),
            Text(
              method,
              style: TextStyle(
                color: selected ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmPurchaseButton extends StatelessWidget {
  final String? selectedPaymentMethod;

  const ConfirmPurchaseButton({Key? key, this.selectedPaymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // Background color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
      ),
      onPressed: selectedPaymentMethod != null
          ? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Votre commande est validée'),
            backgroundColor: Colors.green,
          ),
        );
      }
          : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          'Confirmer l\'achat',
          style: TextStyle(fontSize: 16), // Text size
        ),
      ),
    );
  }
}