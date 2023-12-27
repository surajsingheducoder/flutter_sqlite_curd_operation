// import 'package:flutter/material.dart';
//
// import 'dashboard.dart';
//
// class CustomerDetails extends StatefulWidget {
//   final String name;
//   final String email;
//   final String gender;
//   final String habit;
//   final String address;
//
//   const CustomerDetails({super.key,
//     required this.name,
//     required this.email,
//     required this.gender,
//     required this.habit,
//     required this.address
//   });
//
//   @override
//   State<CustomerDetails> createState() => _CustomerDetailsState();
// }
//
// class _CustomerDetailsState extends State<CustomerDetails> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//
//   String? selectedGender;
//   var genders = ['Male', 'Female', 'Other'];
//
//   List<String> selectedHabits = [];
//
//   List<String> allHabits = [
//     'Reading',
//     'Writing',
//     'Playing',
//     'Binge watching',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text("Customer Details", style: TextStyle(color: Colors.white),),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(15),
//         children: [
//           const SizedBox(height: 20),
//           const Text(
//             'Name*',
//             style: TextStyle(color: Colors.green, fontSize: 18),
//           ),
//           SizedBox(
//             height: 65,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.green,
//               shadowColor: Colors.black,
//               elevation: 5,
//               child: TextField(
//                 controller: nameController,
//                 keyboardType: TextInputType.name,
//                 cursorColor: Colors.white,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.person),
//                   suffixIcon: IconButton(onPressed: () {
//
//                   }, icon: Icon(Icons.edit,color: Colors.white,)),
//                   hintText: "Enter your name",
//                   border: InputBorder.none,
//                   iconColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(vertical: 18),
//                   hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
//                   prefixIconColor: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Email*',
//             style: TextStyle(color: Colors.green, fontSize: 18),
//           ),
//           SizedBox(
//             height: 65,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.green,
//               shadowColor: Colors.black,
//               elevation: 5,
//               child: TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 cursorColor: Colors.white,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.email),
//                   suffixIcon: IconButton(onPressed: () {
//
//                   }, icon: Icon(Icons.edit,color: Colors.white,)),
//                   hintText: "Enter your email",
//                   border: InputBorder.none,
//                   iconColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(vertical: 18),
//                   hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
//                   prefixIconColor: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Gender*',
//             style: TextStyle(color: Colors.green, fontSize: 18),
//           ),
//           SizedBox(
//             height: 65,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.green,
//               shadowColor: Colors.black,
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DropdownButton(
//                   isExpanded: true,
//                   alignment: Alignment.bottomLeft,
//                   value: selectedGender,
//                   underline: Container(),
//                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
//                   dropdownColor: Colors.green,
//                   items: genders.map((item) {
//                     return DropdownMenuItem(
//                       value: item,
//                       child: Text(item),
//                     );
//                   }).toList(),
//                   hint: const Text("Select Gender",
//                     style: TextStyle(color: Colors.white),),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedGender = value.toString();
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Habit*',
//             style: TextStyle(color: Colors.green, fontSize: 18),
//           ),
//           SizedBox(
//               child: Wrap(
//                 spacing: 8.0,
//                 children: allHabits.map((habit) {
//                   return ChoiceChip(
//                     checkmarkColor: Colors.green,
//                     label: Text(habit),
//                     selected: selectedHabits.contains(habit),
//                     onSelected: (selected) {
//                       setState(() {
//                         if (selected) {
//                           selectedHabits.add(habit);
//                         } else {
//                           selectedHabits.remove(habit);
//                         }
//                       });
//                     },
//                   );
//                 }).toList(),
//               )
//           ),
//
//           const SizedBox(height: 15),
//           const Text(
//             'Address*',
//             style: TextStyle(color: Colors.green, fontSize: 18),
//           ),
//           SizedBox(
//             height: 65,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.green,
//               shadowColor: Colors.black,
//               elevation: 5,
//               child: TextField(
//                 controller: addressController,
//                 keyboardType: TextInputType.streetAddress,
//                 cursorColor: Colors.white,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.location_on),
//                   suffixIcon: IconButton(onPressed: () {
//
//                   }, icon: Icon(Icons.edit,color: Colors.white,)),
//                   hintText: "Enter your address",
//                   border: InputBorder.none,
//                   iconColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(vertical: 18),
//                   hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
//                   prefixIconColor: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20,),
//
//           Center(
//             child: SizedBox(
//               height: 55,
//               width: 200,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       elevation: 5,
//                       backgroundColor: Colors.white,
//                       shape: const StadiumBorder()),
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
//                   },
//                   child: const Text(
//                     'Update',
//                     style: TextStyle(color: Colors.green, fontSize: 20),
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
