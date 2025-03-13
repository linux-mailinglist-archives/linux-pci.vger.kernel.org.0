Return-Path: <linux-pci+bounces-23663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E1A5FA4B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5F84219BD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6126B09E;
	Thu, 13 Mar 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NCuhXh6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012064.outbound.protection.outlook.com [52.101.71.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C726AABA;
	Thu, 13 Mar 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880380; cv=fail; b=FNw0U9UagjReHoD2Kj0IBCOum1PloxstJ3ZbQchvGIlftltTMYn7smjpvkHbga8Tj7I30gwTvgSh7Bhv3Ezo05IzuqNBJrL0j6DyA9PEDf8Ylswjvh9PL/2TO2CgjQY2lDN238Gd0pVEojX8z7HK2UonpuTAyHwxwaJYGhpzJis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880380; c=relaxed/simple;
	bh=QkQe+24nf1SiQxBPNOVWAEG60VZcc9QC3yjg/IDPRmw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NWEKcifFasrCykNil2psM38NAL4pmZ6uzC/v1jzK/SyTD9tX2M9yKaHHPTIAX8KRjyBPM6gv8UX3McMUtjByIKqLtPwx4kjm2C9KyfmpXPk059eIu2p/MWVlj6UfkGtMgZ91Xg1oydxMdgNjK7bdO9cKsuu3tdYIbgjRpPZwycU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NCuhXh6/; arc=fail smtp.client-ip=52.101.71.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI8cN1zURP3BD8oTkiyaWJFW/Gl0//2uo4AwNrgErXOhm3byVywvrHwayvP8zoXCvWYiRfSN9f/192qLkV6U5jWa5tcBJnTKHBqYT41lYgKSKzpt2xLS3gJzRohKhKXWjMoS3NQXnid2u/kEpz0b+bBqZfZLM1aIkbjHVmxauXN3cgM972K5dAyfzDUlbZk1MttTQyI6QXNinhirjBHMgw/h6T78Oncl+6IaeX2TBuWbChmVuq4AXxHKTEP+ilw2Ju7My4nx37Ld52utldi/TXqthcPGPefAkwvNgY4+f60v9Ecxk9g1SalcaGpz/X1WkaiptD9z6xF14VYNPH2JWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6QSNG6/x6BFtXs29wKQYVSNew2bOwYe9Nnss9hQbRw=;
 b=WXXJ+j73Pgofsg0kzjiD66BCl5RxdFH+WOhw5YS+B6ZYXTNuwg0RbAPwmFB+xlBaz19h6OSIQU9WzHMfWgsdvhKgoE9m0J6eUlxjwFub3s3Dp2PcrFMZDCXnOc1GEe1dZ7hRWW3opoBwN1HtQk7gCdrduWJdrPgzimVo/pMJh/OU2W2WZGCcWHrEqmnM7vqdt5EcCKJ76bb+WCYz7ZFkJftZwaabySmeijiOlyggTPcjOcK0F5hgrfForm2KHPEYXb72UM7w4RgXN0YcOyXFKPWzsPyEMLqrQRjc4j0I7fgsJ/O7PU35Fm/dsBeFFxlPfcj7q9anGRa58FXkvP32tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6QSNG6/x6BFtXs29wKQYVSNew2bOwYe9Nnss9hQbRw=;
 b=NCuhXh6/17V737xdEua7gyITYVg897MuIO3tCYGYQmdvu/WDZnax7Zseiq0Mc3briAlme41+IxvMX5ozpFQ05eTKMRficegURRpeLT7qNDXix8nIRRvuEcpcfmWeR/rIfQ02amWOqa/JUYeTJ0XKBAY8r4rSj8aieEVa1MSyFSLicGE217NFW4MoCvSXEZCOQodGKMn1MjzLMhXTcu+oq/Ngg98QkN4WBmZpuHlGLkt1AnDp/U5AIXUJnEDaWGh0fwgjaRH0jWjV6IQEwlcxshh2Uw/45tgjbvgauoq86bbeh7GaXHlmCW1xvrYQn8vu61C9RnvE/BomPKcAGLEjXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:47 -0400
Subject: [PATCH v11 11/11] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-11-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=2220;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QkQe+24nf1SiQxBPNOVWAEG60VZcc9QC3yjg/IDPRmw=;
 b=0fhrxrfdB45wq+zOohNBgHV80XvuzXRX/fMgjTJ5dZPR7nT7Vnljb5CEceyYbu1xTNGu2AOe3
 DfQBPavRDqUBp3uaZUvp3dqfG3sWrwXCOsERHaK8rNaISHFEC7EWc3W
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f21427b-4654-4ae2-c052-08dd624541d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bloyYVRCZ3lUT1U4djFLT0ZONEl6ekJoellmNmNBSk1XbHJQdmliQ005emlv?=
 =?utf-8?B?bzF1SXBnZlkrc29LL1ZKRmFiNE9tUTNSbnRSRk5KcVVlTlVJbFYrTWR5RWdt?=
 =?utf-8?B?SlBOTkFLck9lVlZoYUZRY3I5ZWVQVkpTRWpWYWh5R2tJOHFKV3FRbEgzUXlL?=
 =?utf-8?B?MU5aZ2FSczZvanowMm1HbHM5QVNtMzFyUWE1UDBOc0tMRDlKS0JVYmhPVGdB?=
 =?utf-8?B?OXFtMHJWc09OUFlualgxNTI2eEdOY0RheW9kaGM3Mkl4QWVvazdHSmtmcENt?=
 =?utf-8?B?djJVK21pakVHMmZvUG1XTElvUGlKNVliZk1WVkcrZ3FmZldLWGdjN2o1VkJ3?=
 =?utf-8?B?a1pqTXZ3a2hCNjhDT0gyQTJXVnhVR1Y0R3RRU1dWem5YR21wdVBLZHk3RDJP?=
 =?utf-8?B?YzhjT3FlMk1xQkZpUnV5ckx6dGxyRnlSdzVsY1BCSEtmdFhGSG40dE5MUk1K?=
 =?utf-8?B?aFZoRVZCMWNSb0F3cVBkTGExeVgxOE4xbjF2T3VpYW5UOGpEcmlMMWl1QWdy?=
 =?utf-8?B?T2tBZEdNbnV2MFBZbGlqMUxZemxWcktKZlAzQ3A3MURRNDhjaTNIekxpNTA4?=
 =?utf-8?B?eWRXaTZXMlM1SHU0TjhwQ1lNWDkwV3BUekNhaVFvMGtCS01ZUDhjclN2b01G?=
 =?utf-8?B?WENLWTBBdzY4U3RYNjczK1RTcGoxUUM2MFN0QUd1emFuVWRlZDZzck5Ta1VM?=
 =?utf-8?B?SUZIbGNPRUJ4bXkyaVYwWVdETWNGc09mZ1RjOUo1RXp4UTd0Y1VWUCsrV2ZS?=
 =?utf-8?B?WUdZQk1LMGw0YytXQ3RUZFlmRGpJZlhqOU1sbTJiSFhJZGVIdzN4bXBZT2VC?=
 =?utf-8?B?S2Q3YXVIY2Q1dGJFSVE3TmFoTUtIdllsN0ZoMCtVTEhlNnU0ZDNia21mSjk5?=
 =?utf-8?B?NmxmMWUybGNFaTlHUHMyNmVsLzBoVnJidEIrTjVsaWQvalVNd0FFSWtKejVP?=
 =?utf-8?B?dVdDcFA2ZzFpT3RrNVdENUMrMnBiMWN6TXJvRkZrb3BjRUpwQ2RGSytMTTUw?=
 =?utf-8?B?ZGYzTGROTmxwaDFFS1NDTHNpRXRGaU5uS2Z4Vis4VXZyYW1Lb2wvSkhaMmZa?=
 =?utf-8?B?Y0VWOHB1citXMUl0aUdyTTY2b1AvN0dYWnExbDJrQmVtUDE4bkdEaklkL1pD?=
 =?utf-8?B?RGZhanpWOW5aNlRlUmVUSW9IOEtjRlF5SW14dFBJM1A0bmlXcFVzdzdjeVkx?=
 =?utf-8?B?MCtjRm9oN0JBd0g3LzJUUlYxZVQ0TGVIZEFKMnBpTmMxSWNsTnJrWnBXUERD?=
 =?utf-8?B?RTNuU1IvN3owaGd6T0xLV0lxRmM5WDFhSDhBTy8zL1cwY3RacjEvWGVWOTlK?=
 =?utf-8?B?V01XSDJKWHA0SWl0VFpxS2xHWnlpa3Jjd3kwM3htZWdFWTFBOExHSlkzMHhZ?=
 =?utf-8?B?Z1JTTWxkQmoxbmVNc1dyUU1BMkpPb05DcWtYUWt3U2RYTjUvenRhSElUMGt4?=
 =?utf-8?B?cTJxS1BHdk9ud0NCcm8vUkVwbkI0UGp5ODJKK0U0NldoRlFyOHNDaTVZVDM3?=
 =?utf-8?B?aUdnTFFvZ1dablpxRjhnY1dZSVlZRWxHVU1MQlFCNnZwRkhpaGZ2WVhaNklm?=
 =?utf-8?B?eE9VMTcxQlBZVk93TG5qNFRWekZLNk11ajJsSzdOTnoxOW45N1NqSENvcWlP?=
 =?utf-8?B?MVVYNWdJQUsrckdqc0c4cmhOc2h1UnVnQkIvNHZUZWJyVStVaVpodXlhdjNF?=
 =?utf-8?B?bVFFbzB6a0JWYmI1VkM4SGJMRXQ0UHBETVBmbVF2cm0xaUkrb0liRktHNm9k?=
 =?utf-8?B?R1NyNHdkZHRya0lscU5wOTc2V3J5ZUNBQStWMUN4MkErYkVBdlRQek1wc2p4?=
 =?utf-8?B?NTE3amxUNWlRd2hjbDd5Y0lINXRweG4zOU9sQno0SG8zUzk5ZUZUTllaUGxk?=
 =?utf-8?B?bEsvR0JrNDdDbmdJRkg5RmdKT3QwbTdZQUlvQ2NKbmt6ck5qdFcvWlF3d3o0?=
 =?utf-8?Q?eSg//8Q9J1/t3dNU7K6XjOpWWyySRimw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEY3UE9QeTVxcDhUSDZlT250a0VoZmpqaDFWZTk4K3Q1S1hhclFYQkU4YlRS?=
 =?utf-8?B?VjA5SUMrUy9qK2pmTEhaRVhraFBJdTBVOVdGbGVsamxIN090MXRJOUlzc0RG?=
 =?utf-8?B?dDExZ1ErSU9vUHZFWU15dVd1SWlLaDVCT0hXY1V1cFRBUDN6VnkvbUFiRzdX?=
 =?utf-8?B?aHZWM0RESXY2aTlycWVBdmNja2lwdGN5cmRsY25SOFZ5anNMV1lUbzFWV2pk?=
 =?utf-8?B?NnM5eExQVWRPNFhhdEE1a1YrTGxIeHdGRmFKRHg0Ym5HVk5OdGM2eUZ2aTEx?=
 =?utf-8?B?UkY0VnBLNXRZZlc1VlRpMC90SnB6aUNTQjl3NDYzVGIyeFowWnRMOXFQVmpQ?=
 =?utf-8?B?eFNScnZ2NlhiRlhxNDFnaElVV1Q0UnplWDUzbUUwcEMzbmRYY0Q2QzBrbStL?=
 =?utf-8?B?MnhvU0c4N1VyVjVUTkJkaXM4SkovOGhGM0tVV2tZQW56M2FjeUErbWYwaHJn?=
 =?utf-8?B?S015cEkrdEJMQkl0QVljWTE2MEJhZnU2WkViTXlWbWR6WXJiMDA5ckR2am80?=
 =?utf-8?B?YU1lejNjU2tneEhJZk1VNWZXNURBMkpzY1hCVTBYaFlHRjZ5M2w5YThKR0Rq?=
 =?utf-8?B?VmxQWENDaUJ5M2MrYjAwNENEK1lxNGlHQUVvazcwOWxqbjVKc21hWW5LZ1l2?=
 =?utf-8?B?bHJLeUFlU3AzL28xZ01peDJTTC9QbUpjSERhQTgvNllqTUFHcUFuaFZyK3F5?=
 =?utf-8?B?L1Y1M2d3ZVk4YXY2UkdBZGFpUmtJUTExQ1ZaWGZMbHBJcTQyWmV5ZHhFbzJa?=
 =?utf-8?B?cHRLa3VjY0wzZ2xqNW5RRkxZdWVsRlVTMWUzaHdqSU1OaS9LM093Ung4RCtp?=
 =?utf-8?B?bExxeW53L3lsM0Q4eDA4b1B3ekkySnBOcnc0ZmJ4K2JteU5wZTdDNzhxN05G?=
 =?utf-8?B?a3JHeDFGVmtTTHZqL24yY0ZnNGJVNlNYUVNqNFlsS3F1VlJJb1dnSzZPNTkx?=
 =?utf-8?B?ZlFqYlBoVlJ1blFFK0hISURWUHBjR2czN3B4ci91T29FelY5MHUzdmp0Z0wy?=
 =?utf-8?B?cWgxZU9rQVQ0enY1R1ZoVTlNVG1WWTRhdElhdlJnVE1PY200bVpjTTZYcXpN?=
 =?utf-8?B?NUU1M0NSWU9xcWRQZHlMNjI5L1laMEJpMWNLTDBLM28wNmZDalRLd3Q1Q0s0?=
 =?utf-8?B?WnhiTVM5YTJycGx0UkJUYzNGc0dUZ2RkbFlsaXQ5eW9NRkFncTh1WDBMWEtB?=
 =?utf-8?B?TUh5UUlwTEpSY0hidS9xMXZtVXIxbHU4cFlYODRiM3lkY2VZNHNiVHllaU82?=
 =?utf-8?B?QWFMd29aYi9xcS9wRGFDSWV3M1J0OURPQkJnMWtuNjFFVENPSFZyY0xBNURx?=
 =?utf-8?B?dzU0QnkrN3prai9lWmhHTlgyV1VFK2QrQnQ4bms5MUZGRHh1SUlqd0ZGb3Rq?=
 =?utf-8?B?WEp3Y2hpL0Y3TTZRVk10ZWcyNHI3Qmw1bjhLYWd3UnpGb01OWmxKOVBqb3lt?=
 =?utf-8?B?aDByQXQ2YVhLcnhXMVJXeThGZ0JjUXBmNEFyeFFVU21zM1F0aUl5Zm0zQjJM?=
 =?utf-8?B?Z0xNWlRMdU52WDBmZ1JNUk1nZjg5cDhLTW5UT2NWYm9RUFc0YWlDcnR4TlpN?=
 =?utf-8?B?ZHIxV2pHNEFqVDhyVzgxWFlyVjRNdk1Fbmk4Z2JZdEhBZEJEd1BNeUlaV1la?=
 =?utf-8?B?WllocUcvZEtlYlhFWUFRS1lKc2xVdzloYlJHYmIyVy9aaFFnRllSTXYzWHhI?=
 =?utf-8?B?NHY4citQTHFvNUtyUWk0Tlg2dERQeHl3ZkdjRGIvbk9QZjVHMDMvUlFCcHZG?=
 =?utf-8?B?NE5uVmIyeVBBbVpSTVl5MlVldDVjZ0JSVEF3L1NIdldVNEdMY2s1VFVxVXdi?=
 =?utf-8?B?cTR1MkNBWHBZYkJFQkE1cDlQUTNFWkVTcGI2NWdlM1M4SEc2T2lMZmNiZENh?=
 =?utf-8?B?R21DM3psbFZTTHIwVWxKZHNMdC9mRkljSW9BWlRhT3Vpc1B1eWJ6NjRPNEdH?=
 =?utf-8?B?WHlqRkpQTEQ1MWZGSDZQdGlTSzMycUxXdlJDcVhyVHNpZ1FVS2tzYlA3RUtj?=
 =?utf-8?B?cEVQZjZNSHUyeGVrRklWS3dpVUxodFlVZVpVcEtaQytaQ2l1cENmNHI2bnRz?=
 =?utf-8?B?TGtmbXFPMGZiam55dFdkRGFsbllmMTlTU1lXLzMycm91MDcxREdvanRZYUVW?=
 =?utf-8?Q?hzB6GXj9EUrwBNeigMIM8l/9E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f21427b-4654-4ae2-c052-08dd624541d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:35.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbXII+tdMGxKlg8fYxbGN8NXQERxvJmKfZHaOPg8kwmwzauOq+dt0w6ZN3r4mMopDpm1eIbG2CHcnWizKzcf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v11
- none

Change from v8 to v9
- rebase latest linux-next (close enough to v6.14-rc1)

Change from v7 to v8
- add mani and richard's review/ack tag
- use varible 'use_parent_dt_ranges'

Change from v2 to v7
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f9..d1eb535df73e1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1217,22 +1217,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 /*
  * In old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD in iATU Ctrl2
  * register is reserved, so the generic DWC implementation of sending the
@@ -1263,7 +1247,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1645,6 +1628,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)

-- 
2.34.1


