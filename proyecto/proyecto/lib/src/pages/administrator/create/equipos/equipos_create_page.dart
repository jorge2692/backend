import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class EquiposCreatePage extends StatefulWidget {
  @override
  _EquiposCreatePageState createState() => _EquiposCreatePageState ();
}



class _EquiposCreatePageState extends State<EquiposCreatePage> {
  EquiposCreateController _con = new EquiposCreateController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);});
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Equipo'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
          children: [
            SizedBox(height: 25),
            _textFieldEquipo(_con),
            _textFieldDescripcion(_con),
            _textFieldSerial(_con),
            _textFieldModel(_con),
            _textFieldId_Lavanti(_con),
            _textFieldvoltaje(_con),
            _textFieldCorriente(_con),
            _textFieldPotencia(_con),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CardImage(null, 1),
                  _CardImage(null, 2)

                ],
              ),
            ),

            _dropDownCategories(_con.categories, _con),

          ],

      ),
      bottomNavigationBar: _buttonCreate(_con),
    );
  }

  Widget _dropDownCategories (List  <Category> categories, _con ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search_outlined,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Seleccionar Categoria',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  items: _dropDownItems(categories),
                  value: _con.idCategory,
                  onChanged: (option) {
                    setState((){
                      _con.idCategory = option;
                    });
                  },
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name!),
        value: category.id,
      ));
    });
    return list;
  }

  Widget _CardImage (File? imageFile, int numberFile){
    // BuildContext context;
    return imageFile != null ?
    Card(
      elevation: 3.0,
      child: Container(
        height: 140,
        // width: MediaQuery.of(context).size.width/3,
        width: 10,
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
        ),
      ),
    )
    : Card(
      elevation: 3.0,
        child: Container(
          height: 140,
          // width: MediaQuery.of(context).size.width/3,
          width: 150,
          child: Image(
            image:AssetImage('assets/logo-lavanti.png'),
            fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buttonCreate(_con) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed:_con.createEquipo,
        child: Text('Crear Maquina'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );

  }

  Widget _textFieldEquipo(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Nombre de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.local_laundry_service_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldDescripcion(_con) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.descriptionController ,
        maxLines: 2,
        maxLength: 180,
        decoration: InputDecoration(
          hintText: 'Descripcion',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.description,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }
  Widget _textFieldSerial(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Numero de Serial',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.confirmation_number_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldModel(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Numero de Modelo',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.model_training_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldId_Lavanti(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Codigo Interno Empresa',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.confirmation_number_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldvoltaje(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Voltaje de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.broken_image_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldCorriente(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Corriente de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.warning_amber_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }
  Widget _textFieldPotencia(_con) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Potencia de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.power_rounded,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }



  void refresh(){
    setState(() {

    });
  }
}





