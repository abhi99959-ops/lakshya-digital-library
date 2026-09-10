import 'package:flutter/material.dart';

void main() => runApp(const LakshyaApp());

const primary = Color(0xFF5B4BC4);
const ink = Color(0xFF202036);
const bg = Color(0xFFF7F7FC);
const green = Color(0xFF2E9B67);
const amber = Color(0xFFB38B00);

class LakshyaApp extends StatelessWidget {
  const LakshyaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'लक्ष्य Digital Library',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg, foregroundColor: ink, elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int tab = 0;
  final titles = ['Dashboard','Students','Seats','Payments','More'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 18,
        title: Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.menu_book_rounded, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('लक्ष्य Digital Library',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17))),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(index: tab, children: const [
        Dashboard(), StudentsPage(), SeatsPage(), PaymentsPage(), MorePage()
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people_rounded), label: 'Students'),
          NavigationDestination(icon: Icon(Icons.event_seat_outlined), selectedIcon: Icon(Icons.event_seat_rounded), label: 'Seats'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments_rounded), label: 'Payments'),
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'More'),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
    children: [
      const Text("Today's Overview", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: ink)),
      const SizedBox(height: 4),
      Text('A quick view of your library', style: TextStyle(color: Colors.grey.shade600)),
      const SizedBox(height: 16),
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.5,
        children: const [
          Stat('Active Students','0',Icons.people_alt_rounded,primary),
          Stat('Free Seats','46',Icons.event_seat_rounded,green),
          Stat("Today's Collection",'₹0',Icons.account_balance_wallet_rounded,Color(0xFFDE8A36)),
          Stat('Expiring in 3 Days','0',Icons.schedule_rounded,Color(0xFFDB5962)),
        ],
      ),
      const SizedBox(height: 20),
      const SectionTitle('Today'),
      Card(child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(children: [
          CircleAvatar(backgroundColor: Color(0xFFEDEAFF), child: Icon(Icons.qr_code_scanner_rounded, color: primary)),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Today's Attendance", style: TextStyle(fontWeight: FontWeight.w800)),
            SizedBox(height: 3), Text('No attendance recorded yet', style: TextStyle(color: Colors.grey)),
          ])),
          Text('0', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primary))
        ]),
      )),
      const SizedBox(height: 20),
      const SectionTitle('Seat Status'),
      const SizedBox(height: 10),
      const Row(children: [
        Dot(Colors.green,'Free'), SizedBox(width: 16), Dot(amber,'Filled'), SizedBox(width: 16), Dot(Colors.red,'Expired')
      ]),
      const SizedBox(height: 12),
      const Room('Room A', 'A', 26),
      const Room('Room B', 'B', 20),
    ],
  );
}

class Stat extends StatelessWidget {
  final String label, value; final IconData icon; final Color color;
  const Stat(this.label,this.value,this.icon,this.color,{super.key});
  @override Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(15), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 42,height: 42, decoration: BoxDecoration(color: color.withOpacity(.11), borderRadius: BorderRadius.circular(13)),
          child: Icon(icon,color: color)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 23,fontWeight: FontWeight.w900,color: ink)),
        Text(label, style: TextStyle(fontSize: 12,color: Colors.grey.shade700,fontWeight: FontWeight.w600)),
      ],
    )),
  );
}
class SectionTitle extends StatelessWidget {
  final String t; const SectionTitle(this.t,{super.key});
  @override Widget build(BuildContext context)=>Text(t,style:const TextStyle(fontSize:18,fontWeight:FontWeight.w900,color:ink));
}
class Dot extends StatelessWidget {
  final Color c; final String t; const Dot(this.c,this.t,{super.key});
  @override Widget build(BuildContext context)=>Row(children:[
    Container(width:10,height:10,decoration:BoxDecoration(color:c,shape:BoxShape.circle)),
    const SizedBox(width:6),Text(t,style:const TextStyle(fontWeight:FontWeight.w600))
  ]);
}
class Room extends StatelessWidget {
  final String name,prefix; final int count;
  const Room(this.name,this.prefix,this.count,{super.key});
  @override Widget build(BuildContext context)=>Card(
    margin:const EdgeInsets.only(bottom:12),
    child: Padding(padding:const EdgeInsets.all(14),child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[
          Expanded(child:Text(name,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w900))),
          Text('$count seats',style:TextStyle(color:Colors.grey.shade600,fontWeight:FontWeight.w600))
        ]),
        const SizedBox(height:12),
        Wrap(spacing:8,runSpacing:8,children:List.generate(count,(i)=>Container(
          width:50,height:42,alignment:Alignment.center,
          decoration:BoxDecoration(color:Colors.green.withOpacity(.08),borderRadius:BorderRadius.circular(11),
            border:Border.all(color:Colors.green.withOpacity(.22))),
          child:Text('$prefix${i+1}',style:const TextStyle(fontWeight:FontWeight.w800,color:ink)),
        )))
      ])));
}
class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const SectionTitle('Students'), const SizedBox(height:12),
    TextField(decoration:InputDecoration(prefixIcon:const Icon(Icons.search),hintText:'Search student / LDL ID',filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:BorderSide.none))),
    const SizedBox(height:20), EmptyCard(Icons.people_outline,'No students yet','Students registered through the common QR will appear here.')
  ]);
}
class SeatsPage extends StatelessWidget {
  const SeatsPage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const SectionTitle('Seat Management'),const SizedBox(height:12),
    const Room('Room A','A',26),const Room('Room B','B',20),
    Card(child:ListTile(leading:const Icon(Icons.add_circle_outline,color:primary),title:const Text('Add room / seats',style:TextStyle(fontWeight:FontWeight.w800)),subtitle:const Text('Future seats can be added from Settings.')))
  ]);
}
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const SectionTitle('Payments'),const SizedBox(height:14),
    Row(children:[
      Expanded(child:Stat('Collection','₹0',Icons.currency_rupee_rounded,green)),
      const SizedBox(width:12),Expanded(child:Stat('Due','₹0',Icons.pending_actions_rounded,Color(0xFFDB5962)))
    ]),
    const SizedBox(height:14),
    Card(child:Column(children:[
      ListTile(leading:const Icon(Icons.payments_outlined,color:primary),title:const Text('Cash / PhonePe / UPI'),subtitle:const Text('Discount and due payment supported')),
      const Divider(height:1),ListTile(leading:const Icon(Icons.receipt_long_outlined),title:const Text('PDF + WhatsApp receipts'))
    ]))
  ]);
}
class MorePage extends StatelessWidget {
  const MorePage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const SectionTitle('More'),const SizedBox(height:12),
    ...[
      ['Attendance','QR + live selfie + 10m location',Icons.fact_check_outlined],
      ['Locker Management','Manage lockers and assignments',Icons.lock_outline],
      ['Expenses','Track library expenses',Icons.receipt_long_outlined],
      ['Reports','Students, attendance and payments',Icons.bar_chart_outlined],
      ['Registration QR','One common QR for new members',Icons.qr_code_2_rounded],
      ['Settings','Plans, prices, rooms and app settings',Icons.settings_outlined],
    ].map((x)=>Card(child:ListTile(
      leading:CircleAvatar(backgroundColor:const Color(0xFFEDEAFF),child:Icon(x[2] as IconData,color:primary)),
      title:Text(x[0] as String,style:const TextStyle(fontWeight:FontWeight.w800)),
      subtitle:Text(x[1] as String),trailing:const Icon(Icons.chevron_right_rounded)
    )))
  ]);
}
class EmptyCard extends StatelessWidget {
  final IconData icon; final String title, sub;
  const EmptyCard(this.icon,this.title,this.sub,{super.key});
  @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(28),child:Column(children:[
    Icon(icon,size:48,color:primary),const SizedBox(height:12),
    Text(title,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:17)),
    const SizedBox(height:5),Text(sub,textAlign:TextAlign.center,style:TextStyle(color:Colors.grey.shade600))
  ])));
}
