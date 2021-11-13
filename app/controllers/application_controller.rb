class ApplicationController < ActionController::Base

  before_action :authenticate_user!,except: [:top]
  #↑ログインしていないとログイン画面にリダイレクト

  #deviseのコントローラーはライブラリで用意されているので直接修正ができない。
  #deviseのコントローラーに修正が必要ならばここに記述する。
  #カラム(name)をuserテーブルに追加しているので追記する。

  before_action :configure_permitted_parameters,if: :devise_controller?
  #devise利用の機能（ユーザー登録、ログイン認証など）が使われる場合、
  #その前にconfigure_permitted_parametersが実行されます

  def after_sign_in_path_for(resource)
    post_images_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
  end

  #configure_permitted_parametersでは、devise_parameter_sanitizer.permitで
  #nameのデータ操作を許可するアクションメソッドが指定されています。
  #今回のケースでは、ユーザ登録（sign_up）の際に、ユーザ名（name）の
  #データ操作が許可されます。

  #これは、CARAVAN作成時のStrong Parametersと同様の機能です。
  #privateは、自分のコントローラ内でしか参照できません。
  #一方、protectedは呼び出された他のコントローラからも参照できます。

end
