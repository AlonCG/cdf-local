print('>>> Start <<< ########## MONGO INIT ##########');

print('>>> cdf-local-dev <<< ');
db = db.getSiblingDB('cdf-local-dev');
db.createUser(
  {
    user:   'cdflocal_user',
    pwd:    'P@ssword',
    roles:  [{ role: 'readWrite', db: 'cdf-local-dev' }],
  },
);
db.createCollection('base-collection');

print('>>> cdf-local <<< ');
db = db.getSiblingDB('cdf-local');
db.createUser(
  {
    user:   'cdflocal_user',
    pwd:    'P@ssword',
    roles:  [{ role: 'readWrite', db: 'cdf-local' }],
  },
);
db.createCollection('base-collection');

print('>>> End <<< ########## MONGO INIT ##########');