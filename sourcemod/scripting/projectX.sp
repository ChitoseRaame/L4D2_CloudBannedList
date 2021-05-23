/*
 * 作者:Localia-cn
 * 本项目Github地址:https://github.com/ChitoseRaame/L4D2_CloudBannedList
 * 重新分发插件需同时分发源码及该LICENSE信息
*/

#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <ripext>


public APLRes AskPluginLoad2(Handle myself, bool late, char[] error,int err_max)
{
	char sGameName[12];
	GetGameFolderName(sGameName, sizeof(sGameName));
	if( strcmp(sGameName, "left4dead2", false) )
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 2.");
		return APLRes_SilentFailure;
	}

	return APLRes_Success;
}

public void OnMapStart()
{
	QueryList();
}

void QueryList()
{
	char URL[128];
	HTTPClient httpClient = new HTTPClient("http://bannedlist.nekochocolate.space:2086");
	httpClient.SetHeader("Content-Type", "application/json");
	httpClient.SetHeader("User-Agent", "Agent");
	Format(URL,sizeof(URL),"get.php");
	httpClient.Get(URL,OnReceivedList,_);
}

public void OnReceivedList(HTTPResponse response, int index)
{
	if (response.Status != HTTPStatus_OK)
	{
		return;
	}

	JSONArray pool = view_as<JSONArray>(response.Data);
	int numTodos = pool.Length;
	JSONArray todo;
	char ID[64];

	for (int i = 0; i < numTodos; i++) 
	{
		todo = view_as<JSONArray>(pool.Get(i));
		todo.GetString(0,ID,sizeof(ID));
		LogAction(0, -1,"Ban %s'", ID);
		ServerCommand("banid 0 %s",ID);
		delete todo;
	}
}