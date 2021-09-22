/// 手机号验证
String? phoneValidator(String? value) {
  return value == null || value.isEmpty
      ? '请输入手机号'
      : RegExp(r'^1\d{10}$').hasMatch(value)
          ? null
          : "请输入正确的手机号码";
}

/// 密码验证
String? passwordValidator(String? value, String? sameAs) {
  if (value == null || value.isEmpty) {
    return '请输入密码';
  }
  if (value.length < 6) {
    return '请输入6位以上密码';
  }
  if (sameAs != null && value != sameAs) {
    return "两次输入的密码不一致";
  }
}

/// 必填验证
String? requiredValidator(String? value, String? msg) {
  if (value == null || value.isEmpty) {
    return msg ?? '不能为空';
  }
}

/// 验证码验证
String? codeValidator(String? value) {
  return requiredValidator(value, '请输入短信验证码');
}

/// 姓名验证
String? nameValidator(String? value) {
  return requiredValidator(value, '请输入姓名');
}
