

validInput(String val , int max , int min , String  textType ,String  feildTextType) {

  //  محتوى الحقل هو هل اكبر من  ماكس
  if (val.trim().length > max  ) {
    return "لا يمكن ان ${textType} اكبر  من ${max} " ;
  }

  //  محتوى الحقل هو هل اكبر من  قيمة

  if (val.trim().length <  min   ) {
    return "لا يمكن ان ${textType} اصغر من ${min} احرف" ;
  }
  //  محتوى الحقل هو هل فارغ

  if (val.trim().isEmpty) {
    return "لا يمكن ان ${textType} فارغ"  ;
  }


  if (feildTextType=="mobile"  ) {
    if (val.trim().length <  max   ) {
      return "لا يمكن ان ${textType} اصغر من ${min} ";
    }
  }


}