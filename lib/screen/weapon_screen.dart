import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weapon_classification/screen/weapon_view_model.dart';

class DiseasePage extends StatefulWidget {
  const DiseasePage({super.key});

  @override
  State<DiseasePage> createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  TextEditingController textController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<WeaponViewModel>(context, listen: false);
      await viewModel.getAllWeapons();
    });
  }

  Widget listView(WeaponViewModel viewModel) {
    final filteredDiseases = viewModel.weapons
        .where((disease) =>
            disease.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchText.isEmpty
          ? viewModel.weapons.length
          : filteredDiseases.length,
      itemBuilder: (context, index) {
        final disease = searchText.isEmpty
            ? viewModel.weapons[index]
            : filteredDiseases[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  disease.name,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2465ac),
                  ),
                ),
                subtitle: Text(
                  disease.description,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF2465ac),
                  ),
                ),
                child: const Text('See More'),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 370,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  disease.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2465ac),
                                  ),
                                ),
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child: Image.asset(disease.image),
                                ),
                                subtitle: Text(
                                  disease.description,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color(0xFF2465ac),
                                  ),
                                ),
                                child: const Text('Close'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget body(WeaponViewModel viewModel) {
    final isLoading = viewModel.state == WeaponViewState.loading;
    final isError = viewModel.state == WeaponViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(child: Text('Failed to fetch data.'));
    }

    return listView(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    WeaponViewModel viewModel = Provider.of<WeaponViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          AnimSearchBar(
            onSubmitted: (String value) {
              setState(() {
                searchText = value;
              });
            },
            width: 400,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
                searchText = '';
              });
            },
            rtl: true,
            color: Colors.white,
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: body(viewModel),
    );
  }
}
