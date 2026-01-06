import 'package:flutter/material.dart';

void main() => runApp(const MegaUygulama());

class MegaUygulama extends StatelessWidget {
  const MegaUygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF242F3D),
        scaffoldBackgroundColor: const Color(0xFF17212B),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      home: const AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final List<String> _mesajlar = ["Hoş geldin!"]; 
  final TextEditingController _controller = TextEditingController();
  bool kanalaKatildi = false;

  void _gonder() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _mesajlar.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mega Cloud"),
        elevation: 10,
        actions: [IconButton(icon: const Icon(Icons.notifications_active), onPressed: () {})],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Kullanıcı Adı"),
              accountEmail: Text("@kullanici"),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person)),
            ),
            ListTile(leading: const Icon(Icons.group), title: const Text("Yeni Grup"), onTap: () {}),
            ListTile(leading: const Icon(Icons.campaign), title: const Text("Kanal Oluştur"), onTap: () {}),
            ListTile(leading: const Icon(Icons.settings), title: const Text("Ayarlar"), onTap: () {}),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(radius: 26, backgroundImage: NetworkImage("https://picsum.photos/200/200?sig=$index")),
                    ),
                    const Text("Kullanıcı", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("RESMİ KANALIM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("En yeni güncellemeler burada!", style: TextStyle(fontSize: 12)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                  onPressed: () {
                    setState(() => kanalaKatildi = true);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kanala başarıyla katıldın!")));
                  },
                  child: Text(kanalaKatildi ? "Katılındı" : "KATIL"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0E1621),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _mesajlar.length,
                itemBuilder: (context, index) => Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B5278),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(_mesajlar[index]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF17212B),
            child: Row(
              children: [
                const Icon(Icons.add, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Bir mesaj yaz...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color(0xFF242F3D),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Colors.blue), onPressed: _gonder),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
