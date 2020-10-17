import discord
from dbl import DBLClient

dbltoken = "token"
bottoken = "token"

client = DBLClient(token=dbltoken)
bot = discord.Client()

@bot.event
async def on_guild_join(server):
    await client.post_stats(jsonObject={
        "server_count": len(bot.guilds)
        })

@bot.event
async def on_guild_leave(server):
    await client.post_stats(jsonObject={
        "server_count": len(bot.guilds)
        })

bot.run(bottoken)
Async:
import discord
from dbl import DBLClient

dbltoken = "token"
bottoken = "token"

client = DBLClient(token=dbltoken)
bot = discord.Client()

@bot.event
async def on_server_join(server):
    await client.post_stats(jsonObject={
        "server_count": len(bot.servers)
        })

@bot.event
async def on_server_leave(server):
    await client.post_stats(jsonObject={
        "server_count": len(bot.servers)
        })

bot.run(bottoken)
