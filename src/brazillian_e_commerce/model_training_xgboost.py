import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import root_mean_squared_error, r2_score, mean_absolute_error, median_absolute_error
from brazillian_e_commerce.database import get_engine

engine = get_engine()

df = pd.read_sql("SELECT * FROM ml_features", engine)

y = df['delivery_time']
X = df.drop(columns=['order_id','delivery_time'])

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

seller_avg_series = X_train.groupby('seller_id')['current_fulfillment_time'].mean()

X_train['avg_seller_fulfillment'] = X_train['seller_id'].map(seller_avg_series)
X_test['avg_seller_fulfillment'] = X_test['seller_id'].map(seller_avg_series)

X_train = X_train.drop(columns=["seller_id", "current_fulfillment_time"])
X_test = X_test.drop(columns=["seller_id", "current_fulfillment_time"])

categorical_cols = ['seller_state', 'customer_state']
for col in categorical_cols:
    X_train[col] = X_train[col].astype('category')
    X_test[col] = X_test[col].astype('category')

model = xgb.XGBRegressor(
    n_estimators=100,
    learning_rate=0.1,
    max_depth=6,
    missing=float('nan'),
    enable_categorical=True, 
    random_state=42
)

model.fit(X_train, y_train)

predictions = model.predict(X_test)

print(f"R² Score: {r2_score(y_test, predictions):.4f}")
print(f"RMSE: {root_mean_squared_error(y_test, predictions):.4f}")
print(f"MAE: {mean_absolute_error(y_test, predictions):.4f}")
print(f"MedAE: {median_absolute_error(y_test, predictions):.4f}")


print("\nFeature Importance:")
importance_scores = model.get_booster().get_score(importance_type='gain')

total_gain = sum(importance_scores.values())
feature_importance = {
    feature: (gain / total_gain) * 100 
    for feature, gain in importance_scores.items()
}

sorted_importance = sorted(feature_importance.items(), key=lambda x: x[1], reverse=True)
for feature, percentage in sorted_importance:
    print(f"- {feature}: {percentage:.2f}%")