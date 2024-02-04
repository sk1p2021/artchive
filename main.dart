import 'package:flutter/material.dart';

void main() {
  runApp(ArtInventoryApp());
}

class ArtInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Inventory',
      home: ArtInventoryHomePage(),
    );
  }
}

class ArtInventoryHomePage extends StatefulWidget {
  @override
  _ArtInventoryHomePageState createState() => _ArtInventoryHomePageState();
}

class _ArtInventoryHomePageState extends State<ArtInventoryHomePage> {
  final List<Artwork> artworks = [];

  void _addArtwork(Artwork artwork) {
    setState(() {
      artworks.add(artwork);
    });
  }

  void _markAsSold(String title) {
    setState(() {
      for (var artwork in artworks) {
        if (artwork.title == title) {
          artwork.isSold = true;
          break;
        }
      }
    });
  }

  void _deleteArtwork(String title) {
    setState(() {
      artworks.removeWhere((artwork) => artwork.title == title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Inventory'),
      ),
      body: artworks.isEmpty
          ? Center(
              child: Text('No artworks in inventory.'),
            )
          : ListView.builder(
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                final artwork = artworks[index];
                return Dismissible(
                  key: Key(artwork.title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteArtwork(artwork.title);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${artwork.title} deleted")),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(artwork.title),
                    subtitle: Text('Medium: ${artwork.medium}, Price: \$${artwork.price.toString()}'),
                    trailing: Icon(artwork.isSold ? Icons.check : Icons.close),
                    onTap: () => _markAsSold(artwork.title),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndDisplayAddArtworkScreen(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _navigateAndDisplayAddArtworkScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddArtworkScreen()),
    );

    if (result != null) {
      _addArtwork(result);
    }
  }
}

class AddArtworkScreen extends StatefulWidget {
  @override
  _AddArtworkScreenState createState() => _AddArtworkScreenState();
}

class _AddArtworkScreenState extends State<AddArtworkScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final creationDateController = TextEditingController();
  final mediumController = TextEditingController();
  final dimensionsController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    creationDateController.dispose();
    mediumController.dispose();
    dimensionsController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Artwork'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: creationDateController,
                decoration: InputDecoration(labelText: 'Creation Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the creation date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: mediumController,
                decoration: InputDecoration(labelText: 'Medium'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the medium used';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dimensionsController,
                decoration: InputDecoration(labelText: 'Dimensions'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the dimensions';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newArtwork = Artwork(
                        title: titleController.text,
                        creationDate: creationDateController.text,
                        medium: mediumController.text,
                        dimensions: dimensionsController.text,
                        price: double.parse(priceController.text),
                      );
                      Navigator.pop(context, newArtwork);
                    }
                  },
                  child: Text('Add Artwork'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Artwork {
  String title;
  String creationDate;
  String medium;
  String dimensions;
  double price;
  bool isSold = false;

  Artwork({
    required this.title,
    required this.creationDate,
    required this.medium,
    required this.dimensions,
    required this.price,
  });
}
