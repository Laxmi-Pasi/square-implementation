Rails.application.routes.draw do
  resources :payments
  get 'gpay_payment', to: "payments#gpay_payment"
end
