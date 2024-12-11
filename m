Return-Path: <linux-pci+bounces-18189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D19ED800
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996D2283E2C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE1243B74;
	Wed, 11 Dec 2024 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mL1ASNKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E2243B6A;
	Wed, 11 Dec 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950711; cv=fail; b=cxi1b40Wp0PE7dir6uYGNzIPl9FgmAjELWUQTXJ7p8EPwvHmLwUkiv5EzEQsAdiAHWwlG5xUYUJsB2QFyB1yYFYuS6qHeN0wUkC/Z30kZcm7y//8bbB3f4ZGt+j31TqG7ju61v2/Uy737Iw43xoKV8tSczh2nRSYh2yXzSJLWe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950711; c=relaxed/simple;
	bh=mJBGb3x/IT3kU6QxbS0pDIxty8JwWoRws5fh7D2yIVI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NRQOm27M/qJgal4YaLNEJO+sXS8z00QYV7rRiG6DnAh887/ZCtumcrpOjMCtZLUr9HtOnZt2yJvq5K7Xdsu8NhQSixcRPP+MoFsoGrSIchnAcfSqRmtEo+XVFWLWIzScetvACOgixjB+pZKcnNva9CMVm6ZvxgDdU2nYukCo4Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mL1ASNKs; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogpN0wttNWCz5UQFWsjrq73gWObgToDadaTKTQfrS2mYPAFkXY15I1LLrdHhllhOVWtNyi6GhRaPZd5RS/eDwxXSgKUGI9jsi9GMKUUb7M+UMVNg+RS/B7X1AYijs1gmrTrWM1VrHpD8Kpj6xw6S4XONH0w806AS2DO+IzCcV++ULB95jk8Ipla7ERaLEVi+8HmDcURLRx/2IsWcbh/C8O+K9XdSUAUbbOKyX7CoVNbN2pnWNxS8VdoaR3xZPTWyKGz48l58PGeSmt3WH6pcz1RmKmTp6cPk4e/13QIC9VtIiVIer3R4+w6e5uuJ77iq/i/RGPuq4p64Q5hdp7Hktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ34FODL+rWvjEXX2BjWCcNtXyZaoeDOc5977Me123c=;
 b=sMnXMwAvjNR+QWA1x0aDUGzcj+cYparvKTQENJ0ACnv9muExQHt9tlVPsh50j/68n4Dmjes6IsE2W9gOmH6O7pKYJnlPco9To6U8XeXNKmo+ARxp8+HTcmARM7MqnOdzY8a2RR6Wyonu9FjpmKjfBMSRDymXdhEQFai7GOtjHFmWdcoxVc+PHksSuC8Y0k72wfO7loKI+A5PLPHXd1DJF4T7nNisZZuhRrOnla+FESwNnZ6lFsqEAYJvdxm/3aGUO18oZFW1W6/sTwakYjLfeQHEAsFbD/FdZm/6iQKmxwlg9vjk/EQrux96BVXvu7PvSEHtp+sxLn+dYcYnoyBuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ34FODL+rWvjEXX2BjWCcNtXyZaoeDOc5977Me123c=;
 b=mL1ASNKso2qgrThMujzMRmg+cHSGlTax23hthvA3EiC9T2qwR7H6c3hl6t4/RBdkQ5ZYo4kbndtP4Jm+coknIwOV6F8gGuCcrDwawGg3VGXLYXl6dPAtN11gNdo4m7Aa3GTECQI4QS9KSjDOYPFRt9nRLo7oiyQekGmZ58ALZt4MFKDH3IB0BGLgqtsQitmAPLOJWmc8YogLN6YMdYLQrSoToAnsTplcobE5A7KYn09H7Q1JICHpRaCV3ifyRKONYBzOwrTVGFN7J/B50OYh8DiK2PN/PsvwXYwIO4NW4tjCkU+HtV6V/6Qth+QCtxhmMEhKJyZllOXuObXcmw3NNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:37 -0500
Subject: [PATCH v12 9/9] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-9-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=1851;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mJBGb3x/IT3kU6QxbS0pDIxty8JwWoRws5fh7D2yIVI=;
 b=QFLvfupamU6j1m6GC7+ti6gAF9Lji2I/ymk1eSE3p5fzudCDf3+vupHDN3ZmLnRNTbtBXTsSI
 3K+V2/zfZ5zBNOmUiQmemeCheOGXGKqBO+y2GZeNxfCCsQtQZgB5XU9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 83310109-7cd7-4036-3e4d-08dd1a268edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkZWVjBvOUhxMWRMTU9yUXdMTEhSZnJITVVvdTd2TmJBWllKamp5VlVwcjVZ?=
 =?utf-8?B?UStJMVQ4UFlHdytUK1pvZlEzYnBiL3BEY0hlOTZnY21pTHdoUFB1OURFSW9a?=
 =?utf-8?B?WEg0YjRsa3F0MTZGNldyWmlibTc2V1V3K0ZxMGpRT1BkZzBvcmRlNk9zbTJ6?=
 =?utf-8?B?WlNkSDZBQ3JpYUI5YUkxcjNTNDlJL3BoV3JhVnpQYUl3b3lxcjJyek5pandF?=
 =?utf-8?B?b3hHYVhiL3pXNW94bTV0aUF6eUV3VmxQQkRWRWRQS0RwcXpTN2VYa2V4aGdG?=
 =?utf-8?B?ZE1YYXFBTmE1OU00VUFodHE3NVVLUmJqY01hdGkyTWVyMlFvSHFsZ0dkUjhk?=
 =?utf-8?B?YTZaU25PNTZTamJINjhXeWFlRWRFM3JLOEwzdzBJdExmTWtYUE5EUDN1bTNM?=
 =?utf-8?B?enp6NGlsU0VXazlCcUdrcnNNZ0ZXWHhtV2k3cFFuVlZIWWdCN094M01VY1Bx?=
 =?utf-8?B?ZHBhU0dENTFUNmRDVTRJeXRqR3V6dnpHRU9XRnVjd0JrVEhML0d6aGZKOWp2?=
 =?utf-8?B?TEJONGhjUGw0bU9Mc250aGVOTGlwMUJrVWpqR2dNVjdYSjM4cmhObHp1bUYv?=
 =?utf-8?B?SVdOaHN5ajRVY25mOExUbFFNZXcvWUR1cUszaVhMTExPSXdUckdtWFFrNENC?=
 =?utf-8?B?Q1g0a2ZvdEM4K1hkczBLQkYxMkVtVTI2OGVvZHM1Qi9IYmlHYXQySk9RWTFo?=
 =?utf-8?B?TktTOHdCZy9TY2xYaVQ3YUh1elAzVGsxc1o4WGRSbDFXQ0FwZ1ZvczM1dDFz?=
 =?utf-8?B?NVBsZFBXZzlTN0tQME5ZTEVRWDR1dTEybGMwMCtoaVpiTXVEZDBkR2NUdHRj?=
 =?utf-8?B?czF0WDdqV2xGWTF6YXc4ellKVENBdS9oVDJzbEdjTFdQeW9yZlpMNUxuTXZ5?=
 =?utf-8?B?K3Fjc3pucEdxWTdwcjJvbHJwdndhOHQyYzJQSVRjYWhsdnJVK0xHaDV5NDMr?=
 =?utf-8?B?OUYrY1VLbGRZb2laZFdVMExQNzdzYk1QblFzL2xkdjVjL2kxU0FoVW9FaW9p?=
 =?utf-8?B?WEpYc0NkejdjM0k3a21JTGIwTTBzY0JlaVVrNkhCUVk3b3lDbEkrc3VnMDdn?=
 =?utf-8?B?aWF0Yjkycy9aY3JwMHAwWkowcVJTbDliWVBXcXFBd0xMa1BNTGlSQkl5bzUr?=
 =?utf-8?B?TWVDR3hZcXZwZm41dG4zTnVyQ2o3UUdRUStDaTltWXVibDNYSWN0MmN0Y28y?=
 =?utf-8?B?SndLcXNGcjg0V291anAveVpaNXN0L2tjaURPQ2lkc1JObURGVGlzaG5Qdyt2?=
 =?utf-8?B?NzVPbC81aWNkS1dyWWJhNnlYL1ptWjVBZHdmaWVGWFRHWUFaYWllQ2tRNGJX?=
 =?utf-8?B?dGdkYUNGRFhnMXlMY1hlZzJqc0RUaU1rdlgxMTFTeGlUYzY5cThsdmEyK1Q4?=
 =?utf-8?B?VkdKNERsUjlpQldGbUNLbEZYa2R3L084b1NjMExCb1NWL1FwMjVJd3RuaWlj?=
 =?utf-8?B?OWVGcUx3ODBXR1REMldveXQrMzJPMUw0TWdzS0VrTlUrQVIrb1NPNXA2cXg5?=
 =?utf-8?B?Y0o4Smd5dzFjVjEwdFFyVnhiNTR5UmVzcTh0dkpGR2E3N3ZJNlEvSVUvNUZh?=
 =?utf-8?B?ZDNTdzVuWjIzL1JPK1Y1NHBkUktxQVRIQlZIbHJ2RjJCNWNzSTE4Q2lWVitN?=
 =?utf-8?B?ajA5K1RMWVorY0ljcDh3Z1p4M1hIQUYyc1h0RjBaV01DTms1Z2VhemFodlFT?=
 =?utf-8?B?MVpuRVZmVDNKYjY1dHhZSC96SHBObWNyc0llU05DRGhqTStXU2ZLaDBDSkdu?=
 =?utf-8?B?Rk1TeHJUYTF4aHpRQ0hqc2Y4amh6QThScldSQUNSaTUzc044NVlEc0xzQUZL?=
 =?utf-8?B?eUVTMTBVR25wbXRjZUVIVm1XSzVtNUQvRGxiUHp1b3ZHNFdZYW5CcTBsalZS?=
 =?utf-8?B?YlFqbzNSbkhwS3ZSemFHbFFsSlVCaGc2aWovU1RnejZJV2h4aysyZHNtbDB4?=
 =?utf-8?Q?kfmKhjRFLT4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFFiamFzRnYxNFZOWmhNOXF1eFBRUjJxQXd4c1pCY1JZeDQySTdxTHdqbnUr?=
 =?utf-8?B?cll4Tnh6VmpSWU9nN0U3dysrU0JKNVNONHZpaXR1NmZTVEFOOTVYUkJJbTVV?=
 =?utf-8?B?Y2hhUnJkeXEwc0lQbnpGdnN0dGNxdEo4RGx1UjZpR25BVkVNSTBSVzNYMFZD?=
 =?utf-8?B?T2doS1ZrdnpCY1ZWSWJtWVJxajBjeGVrU0poVU5mTlFnakdZTnViOW1OVnVy?=
 =?utf-8?B?V1ZhTlF2ckcwN3JvVEs2eG9obFVFeHhQcDF1RnU5T1JlZFYxbG5uYmp3ZGxu?=
 =?utf-8?B?MVFucTJMOEk5Z1hCb1NOeXlVNGlrN2Fzd1A3ZnovTlRJZnVRRllGamxsK3VF?=
 =?utf-8?B?aU40Mks5TWlnVEUzbjl5VWFFY2lBM1JWUFdHTXU4WWE2ZCtQUTNQdkNlWVp3?=
 =?utf-8?B?THVEOC9XM210eUc0bEgvdVJxR0hvR1ZyK2tQa2g0VzlNU0NuT1BETFJ6cTNq?=
 =?utf-8?B?SEhvZnJwODl1WkRGM3hIQ3ZuN2t5cjIwVDMwdy8yaXI3YXdBRWt6YTFSZjRG?=
 =?utf-8?B?WWRmbWk5R1ptWGhaR1N3NGt6NzJSY2kycHJ5U1B4SWZJb2RiSktTVkFhUGlj?=
 =?utf-8?B?SjRjSVk5TkFsalZrdjFvWStNUEtrb2lzb2NwOUlJQkY1N21xV2MrZ3RzckFY?=
 =?utf-8?B?T0h4ZVFuUFhmQlU4aU5JMjI1U2syaUFyUm9YSkVyTXJsS2crL05IWnZhaVJM?=
 =?utf-8?B?NzU1WFdBTHVreFNGVm00QVRnMWUwRHRRRE40NThIZE9BRlQ4MENNRUJZVDYr?=
 =?utf-8?B?bmFFbHUvaERKTCtBc3NtcXNZQ1ZjUUFPYUlIK2trYzRiNjJrclVaYmRQWGRT?=
 =?utf-8?B?Z0pId0xqeCthaWRsREtFeVQ5TDlheFlFZGorRy9mWGtyNnFvZWg2eVJxTXor?=
 =?utf-8?B?L3lwZ3BVRFNDMHhoSW0wUGx5anpxa05IN0IxdUlRMFFYUldPcXVtUEdsRzR2?=
 =?utf-8?B?OW5NMWJPU2NwQVJyYVpsZm16aDltbk9wT01LNDQ5eEt1a1pFdGRhVlNTbWRp?=
 =?utf-8?B?WFJaeDJ5RnNEMW1KZmcveXBuQkFIMHk4QlJoTXF6czIrVE9JSGwyZDQ5UGNF?=
 =?utf-8?B?RnJ1d2k3ZzVkU2QwZUwwZzNwaW1nZlAwSktjRXg0VklLREk1dmxlVkI0blEr?=
 =?utf-8?B?eDA3eDF4NEtoTEg2SGhyckFnR2phUGdsWEExKytvUEthSm5ta2pqMlFmMHFt?=
 =?utf-8?B?eHJqNXI5QkpIWmtJV2FGV2RMN2tFdGVFZjdnQ1BrR1lVOGJBbk5tQmlBTmE0?=
 =?utf-8?B?d3JEYTc3OTZjNTROam84SHpqWnZMU1g1czhPQ2pYb3BKYzBydzZXUGtRQnUx?=
 =?utf-8?B?ODM5MjRQaVR6VWRNWlBUbHB1dHI4WVdHTnRiRnpUWlZFektuQk5vK3RYUTFE?=
 =?utf-8?B?Z3d5TUlWelVBTTBhMHdmdGdUUENkOTdmSWx0K0V0WExWeDArU0dNQ0U4ZjRr?=
 =?utf-8?B?SkFmTmpEYjRPZHR4K2pyck1IdURQcGVBeDhlcGpNL2hOQnh0QjMwNUgxRGhr?=
 =?utf-8?B?Z1JJLzc2T3k0TjFoY25qQ2oxOWJaUWQwaERnM3F0NEI1Ty9qQU9Vbjl2ZDFv?=
 =?utf-8?B?aW9FMHZvWHZRSzB5elRBNGpjVlV2bEZPTWhwUGtwUi9ZUm9uK3pnK0FMeEp5?=
 =?utf-8?B?U1JIa1pqU0dTK3VOV0dONWJOR1MrbnZpbjhPZG1wVnE3ZnRZaVg5bCtVclRV?=
 =?utf-8?B?RGtJRHlRUGdQcUMxbitFQ1o0a0YxUUpZUlE4M3hJUnA0cGVsL3ZMVHdGeGZY?=
 =?utf-8?B?cXRuUndCM0NjbmEvdk1ITVo2QkpMQnNzc2lsZFduYlNwUnJVVEYyby93bmVl?=
 =?utf-8?B?V2t3MUd6eUhmVXNFVWlrY3dUTXJubkNVNzBjRkswaDNJZ3VFT2NGTWlYOS96?=
 =?utf-8?B?Yno4RGJWNWhLM3dpQ2V2dUxTbTBkRE5sYVFVUEluUTFSeFMvaFFrejFvUyts?=
 =?utf-8?B?Qm53eStiMCs2NEI0bFRQanIxMVJ3c1MwVXRzSVIwaWpwc2JzVTM1TmUvUXpk?=
 =?utf-8?B?bGV0bHluK3lnOWtwc1ZpYmdNMnZGK1B2bElSOExoS2pGeVF4K1g5b3dpRy9t?=
 =?utf-8?B?K1hubUhoNWpUNDVrQTBoY2g3U0U5T01ZaHgvN0lHeHhyZ0wzUVloaC9mM2xV?=
 =?utf-8?Q?WvVraTNsV7uA5o19gN/9cL2gz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83310109-7cd7-4036-3e4d-08dd1a268edb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:26.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mlrP60UE2o5Qo0UxGw6QTaE2cUh1weyHkujOFprdYB/Gh5oHGN2aI1ypgSurTzsokoymrsBfiUUQwmBvana6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v12
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 7b530d838d408..fcff0224a3381 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


