import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spbus/controllers/map.dart';
import 'package:spbus/widgets/button.dart';
import 'package:spbus/themes/themes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required GlobalKey<ScaffoldState> scaffold,
  })  : _key = scaffold,
        super(key: key);

  final GlobalKey<ScaffoldState> _key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 300 + 8),
              child: ButtonWidget(icon: Icons.close, scaffold: _key),
            ),
          ),
        ),
        Drawer(
          width: 300,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'SPBus',
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w900,
                      color: greenTheme,
                    ),
                  ),
                ),
                Menu(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _controller = Get.put(MapExtendedController());

  bool _bus = false;
  bool _sube = false;

  Divider _divider() {
    return const Divider(
      height: 0,
      thickness: 2,
      color: greenTheme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider(),
        // <item>
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text('BUS',
                    style: TextStyle(
                      fontSize: 16,
                      color: greenTheme,
                    )
                  ),
                ),
                Icon(
                  _bus ? Icons.expand_less : Icons.expand_more,
                  color: greenTheme,
                )
              ],
            ),
          ),
          onTap: () {
            _bus = !_bus;
            setState(() {});
          },
        ),
        // </item>
        _divider(),
        // <submenu>
        if (_bus)
          Column(
            children: [
              // <item>
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: const Text('¿DÓNDE ESTÁ?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                    )
                  ),
                ),
                onTap: () {
                  _controller.target = 'locations';
                },
              ),
              // </item>
              // <item>
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: const Text('RECORRIDOS',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                    )
                  ),
                ),
                onTap: () {
                  _controller.target = 'routes';
                },
              ),
              // </item>
            ],
          ),
        // <submenu>
        _divider(),
        // <item>
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text('SUBE',
                    style: TextStyle(
                      fontSize: 16,
                      color: greenTheme,
                    )
                  ),
                ),
                Icon(
                  _sube ? Icons.expand_less : Icons.expand_more,
                  color: greenTheme,
                )
              ],
            ),
          ),
          onTap: () {
            _sube = !_sube;
            setState(() {});
          },
        ),
        // </item>
        _divider(),
        // <submenu>
        if (_sube)
          Column(
            children: [
              // <item>
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: const Text('PUNTOS DE CARGA',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                  ),
                  onTap: () {
                    _controller.launch('https://tarjetasube.sube.gob.ar/subeweb/WebForms/admin/views/mapa-sube.aspx');
                  }),
              // </item>
              // <item>
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: const Text('CARGA SALDO',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                    )
                  ),
                ),
                onTap: () {
                  _controller.launch('https://tarjetasube.sube.gob.ar');
                },
              ),
              // </item>
            ],
          ),
        // </submenu>
        _divider(),
        // <item>
        InkWell(
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text('AUTOGESTIÓN',
                style: TextStyle(
                  fontSize: 16,
                  color: greenTheme,
                )
              ),
            ),
          ),
          onTap: () {
            _controller.launch('https://apps.saenzpeña.gob.ar');
          },
        ),
        // </item>
        _divider(),
        // <item>
        InkWell(
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text('NOTICIAS DEL MUNICIPIO',
                style: TextStyle(
                  fontSize: 16,
                  color: greenTheme,
                )
              ),
            ),
          ),
          onTap: () {
            _controller.launch('https://saenzpena.gob.ar');
          },
        ),
        // </item>
        _divider(),
      ],
    );
  }
}
