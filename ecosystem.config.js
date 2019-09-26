module.exports = {
	apps: [
		{
			name: 'app',
			script: './app.js',
			env: {
				NODE_ENV: 'development',
				SERVER_PORT: '${SERVER_PORT}',
				__SECRET__TOKEN: '${__SECRET__TOKEN}'
			},
			env_production: {
				NODE_ENV: 'production'
			},
			args: `-p ${process.env.SERVER_PORT} -t ${process.env.__SECRET__TOKEN} -o /data --token-file /app/.coding-tracker-token.json`
		}
	]
};
