import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //rimuove il banner in alto del debug
      debugShowCheckedModeBanner: false,
      //titolo dell'app che si vede nello switch dell'app
      title: 'Calcola costi viaggio',
      theme: ThemeData(
        //imposto un colore primario all'applicazione tramite il tema
        primarySwatch: Colors.orange,
      ),
      home: CalcolaCostiScreen(),
    );
  }
}

class CalcolaCostiScreen extends StatefulWidget {
  @override
  _CalcolaCostiScreenState createState() => _CalcolaCostiScreenState();
}
class _CalcolaCostiScreenState extends State<CalcolaCostiScreen>{
  //definisco il tipo di percorso con una variabile generica perchè DropdownButton -> necessita di un valore diverso dal vuoto
  //successivamente cambierà da bool a String per il valore corretto
  var tipoPercorso;
  String messaggio = '';
  final TextEditingController chilometriController = TextEditingController();
  final List<String> tipiPercorso = ['Urbano','Extraurbano', 'Misto'];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Calcola Costo del Viaggio",
          style: TextStyle(
              color: Colors.white
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: chilometriController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
              ),
              decoration: InputDecoration(
                hintText: 'Inserisci il numero di Km',
                  hintStyle: TextStyle(
                  fontSize: 18,
              )
              ),
            ),
            Spacer(),
            DropdownButton<String>(
              value: tipoPercorso,
              items: tipiPercorso.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[800],
                  ),
                  ),
                );
              }).toList(),
              onChanged: (nuovoValore) {
                setState(() {
                  tipoPercorso = nuovoValore;
                });
              },
            ),
            Spacer(flex: 2,),
            ElevatedButton(
              onPressed: (){
                calcolaCosto();
              },
                child: Text('Calcola Costo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
            ),
        Spacer(flex: 2,),
        Text(messaggio,
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[800]
        )
          ,),
          ],
        ),
      ),
    );
  }
  void calcolaCosto() {
    double costoLitroCarburante = 1.4;
    double? numeroChilometri = double.tryParse(chilometriController.text);
    double kmTipoPercorso;
    double costo;

    if(tipoPercorso == tipiPercorso[0]){
    kmTipoPercorso = 14;
    }
    else if (tipoPercorso == tipiPercorso[1]){
      kmTipoPercorso = 18;
    }
    else {
      kmTipoPercorso = 16;
    }
    costo = numeroChilometri! * costoLitroCarburante / kmTipoPercorso;
    setState(() {
      if(numeroChilometri < 0){
        messaggio = 'Errore';
      } else {
        messaggio = 'Il costo previsto per il tuo viagio è di € ' + costo.toString();
      }
    });
  }
}