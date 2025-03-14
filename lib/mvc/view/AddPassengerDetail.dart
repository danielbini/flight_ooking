import 'package:flutter/material.dart';

class PassengerDetailPage extends StatefulWidget {
  @override
  _PassengerDetailPageState createState() => _PassengerDetailPageState();
}

class _PassengerDetailPageState extends State<PassengerDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _EmailController = TextEditingController();
  final _frequentFlyerNoController = TextEditingController();
  String? _selectedGender;
  String? _selectedCategory;
  bool _needsWheelchair = false;
  bool _isFrequentTraveler = false;
  String? _selectedAirline;
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      final passengerDetails = {
        'gender': _selectedGender,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _EmailController.text,
        'category': _selectedCategory,
        'needsWheelchair': _needsWheelchair,
        'isFrequentTraveler': _isFrequentTraveler,
        'frequentFlyerAirline': _selectedAirline,
        'frequentFlyerNo': _frequentFlyerNoController.text,
      };
      print('Passenger Details: $passengerDetails');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passenger details submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Adult 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Select Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGenderButton('Mr.'),
                  _buildGenderButton('Mrs.'),
                  _buildGenderButton('Miss.'),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First & Middle Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first and middle name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _EmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              // DropdownButtonFormField<String>(
              //   value: _selectedCategory,
              //   decoration: InputDecoration(
              //     labelText: 'Category',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: ['Adult', 'Child', 'Infant']
              //       .map((category) => DropdownMenuItem(
              //     value: category,
              //     child: Text(category),
              //   ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedCategory = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a category';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16),
              // SwitchListTile(
              //   title: Text('Select Wheelchair'),
              //   value: _needsWheelchair,
              //   onChanged: (value) {
              //     setState(() {
              //       _needsWheelchair = value;
              //     });
              //   },
              // ),
              // SizedBox(height: 16),
              // SwitchListTile(
              //   title: Text('Frequent Traveler No'),
              //   subtitle: Text('(Frequent flyer number is subject to airline acceptance)'),
              //   value: _isFrequentTraveler,
              //   onChanged: (value) {
              //     setState(() {
              //       _isFrequentTraveler = value;
              //     });
              //   },
              // ),
              // if (_isFrequentTraveler) ...[
              //   SizedBox(height: 16),
              //   DropdownButtonFormField<String>(
              //     value: _selectedAirline,
              //     decoration: InputDecoration(
              //       labelText: 'Frequent Flyer Airline',
              //       border: OutlineInputBorder(),
              //     ),
              //     items: ['Airline 1', 'Airline 2', 'Airline 3']
              //         .map((airline) => DropdownMenuItem(
              //       value: airline,
              //       child: Text(airline),
              //     ))
              //         .toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         _selectedAirline = value;
              //       });
              //     },
              //     validator: (value) {
              //       if (_isFrequentTraveler && (value == null || value.isEmpty)) {
              //         return 'Please select an airline';
              //       }
              //       return null;
              //     },
              //   ),
              //   SizedBox(height: 16),
              //   TextFormField(
              //     controller: _frequentFlyerNoController,
              //     decoration: InputDecoration(
              //       labelText: 'Frequent Flyer No',
              //       border: OutlineInputBorder(),
              //     ),
              //     validator: (value) {
              //       if (_isFrequentTraveler && (value == null || value.isEmpty)) {
              //         return 'Please enter your frequent flyer number';
              //       }
              //       return null;
              //     },
              //   ),
              // ],
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Okay, Got It'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedGender == gender ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: _selectedGender == gender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}