Rails.application.routes.draw do
  resources :payments
  get 'gpay_payment', to: "payments#gpay_payment"
  get 'gpay', to: "payments#gpay"
  post 'gpay', to: "payments#create_gpay"
  post 'gpay_payment', to: "payments#create_gpay_payment"
end
