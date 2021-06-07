
import 'package:flutter/material.dart';
import 'package:mix_center/providers/products.dart';
import 'package:mix_center/widgets/singleProduct.dart';
import 'package:mix_center/widgets/textForm.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  var _filteredProducts=[] ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filteredProducts=Provider.of<Products>(context,listen: false).findProductsWithSearch("");
    //print("_filteredProducts lenghth=${_filteredProducts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
        color: Colors.purple,
        size: 30.0,), onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
      ),
         body: Directionality(
           textDirection: TextDirection.rtl,
           child: Form(
            key: formKey,
             child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [

                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'ادخل اسم المنتج للبحث';
                        }

                        return null;
                      },
                      // onSubmit: (String text) {
                      //  // SearchCubit.get(context).search(text);
                      // },
                      onChange: (String value){
                        value = value.toLowerCase();
                          _filteredProducts = Provider.of<Products>(context,listen: false).findProductsWithSearch(value);

                          setState(() {

                          });
                      },
                      label: 'بحث',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),

                    Expanded(
                      child:_filteredProducts.length>0
                          ?RawScrollbar(
                        thumbColor: Colors.purple,
                        radius: Radius.circular(15),
                        child: Scrollbar(
                          isAlwaysShown: true,
                          thickness: 2.0,
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2/2.65,
                              crossAxisSpacing:1.0,
                              mainAxisSpacing: 5.0,
                            ),

                            itemCount: _filteredProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleProduct(
                                imgPath: _filteredProducts[index].pro_image,
                                prodName: _filteredProducts[index].pro_name,
                                prodNewPrice: _filteredProducts[index].pro_new_price,
                                prodId: _filteredProducts[index].pro_id,
                                prodInfo: _filteredProducts[index].pro_info,
                                prodoldPrice: _filteredProducts[index].pro_price,
                                prodoffer: _filteredProducts[index].pro_offer,
                              );
                            },

                          ),
                        ),
                      )
                           :Center(
                        child: Container(
                          child: Text("لايوجد عناصر مطابقة للبحث"),
                        ),
                      ),

                      ),

                  ],
                ),
             ),
      ),
         ),
    );
  }
}
