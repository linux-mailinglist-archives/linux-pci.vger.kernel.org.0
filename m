Return-Path: <linux-pci+bounces-23653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E860AA5FA28
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D6517FC21
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DF62690EA;
	Thu, 13 Mar 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cy9q8Fia"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F59268FCC;
	Thu, 13 Mar 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880347; cv=fail; b=D/02l5utNedsQOwF4J+wo1T04qEQ8BAhHFmJLMpO1P/h1eN2C0NwaSpuQXckHuvxCLsBSkkyDD4lBcCtCb5fCcitLcF01XkRNqfBdGFj+ZbhYSvYn841jo3ARAjV8uZ/vAEIMY9uV8eBGoSOiEgOrO280HyrnhigjqRPdaqAG4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880347; c=relaxed/simple;
	bh=fGknCafYNnH1QeTy4gIeyaSkKKRcngp/TKUtFyH3iuA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b5AAV9jtkuxTx8CBsiX6RZwGROw/b3kmnQRwjjl8RWUl17lN2QUIKrrxA7qsK2vJWx4VruBlBINjmnEuy13uPasGHIFOc7f5WQMA2VqdKzUnRcJHwyg26VpIwNCgVc+rDG2ZciNVKvUZNStqtLVlBGjsJdZNAT17NrpNNsxgwt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cy9q8Fia; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD7vc6vyOVdUSQ8T6jMiFfZBmgYuGWccjPB9K0hyKd8g21jisZstUVmCZjMzipah6uFJq2NTwAkSN8q3NEXqlAkdpsP60vPoxp2yL7F4GRPrMWcMvMzsQreubEhUPVe+JDBLBjj8+0jvnFCFT7a3EzeoD20OMDpDKNjtub2xp6gRgSKXW2JuXZEvby1MaYJJWfwbeq8O/UKEvURva85pwgARg+6JBc1AXUioQb3QBvY3eZ9yM/ZHoHJitPZHQaoKDD9JKE+7303srudwVD8djFyfIX+8nNlsxk1qAW5OkUvQYLgez2eh6tun2+bhcgZi2dUZ1T/vU/Dwf/0pOLt6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD6obUYyabkRBBBKyx3KwDiZhXHhwe6nCrrs1df7P+E=;
 b=NA5ZdS9d1xzJ6DrAv8HxwsrAswUHSVDltUr7DIY4cTh4L3SHk89IXBahWMgZ5Ig47K1elAe3328sp5g6UTlOQDPESHIGDPcTYb1bsMoIcLHURNgnFubvUtct9udSJhsTePB7y6BF/eWrdqVEvnMD+VfoOAlYUHRFvxNdwFRK6DLIFt3jysSbOJd94GezUZ0s7+g8vyReydgj6Z0NVtC2rA1BranAzyVnQl23/j67tSFmHfLwlU2rYqtENKib0wcVC/7T+ogVLuRwQLUD26hVyRZUh+IcM+njRzGlmOwgOR2zkwxFejAZDyIVaNysmC1GZGYEj2cmV8dupUXYetBJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD6obUYyabkRBBBKyx3KwDiZhXHhwe6nCrrs1df7P+E=;
 b=Cy9q8FiaqOzmVmPWOOCcjT4yJq0Vk0yXKHjGJ1QQCdw05jr3EtRCcHdw/EZ7LRhmjPTDLyESEsEnYZeF7ETx+GW8Cs8PYcqlr1k9Lo+85VxSvXyc0eGQ27Uk59v8twrqyJ9Q8QQyPCF9irBIXuK2oOMw2jqBbOTCYwn6/GxKUyRUtXfQDohrPqEs8vpBZQo3hpBae9UJQmIjS08jMsZ/BBJ6e8k70Wp+pumJnze8qCdJab2vT02L/MWuMjPtzgWdAj+2wHEly0eeFBWifzTO2V6+mIu9E8WoPV16q1a+yZcIdpaAdnD8AooOUFTC/poGxcgdK+z7fz0wgtEVWHO9aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:37 -0400
Subject: [PATCH v11 01/11] PCI: dwc: Use resource start as iomap() input in
 dw_pcie_pme_turn_off()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-1-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=1398;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fGknCafYNnH1QeTy4gIeyaSkKKRcngp/TKUtFyH3iuA=;
 b=9PnwmOe7/c4YFdCLeILPgOltk1k3JaUflkBvrre9T2Qi/VklLhKbqZZFWKDcoRSXChlOGMWM6
 za8d20vrm61A2QsKF7lQqZ+IEJr8J7P2YBtEnoubMhIqVXOa2xmfogc
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f93b16-afac-4bf6-665a-08dd62452dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lpcmc1NmkyQmgyZk5FanFQcnNkYzVXYTVZR0FDYVpKS2RjVXloSFBvY012?=
 =?utf-8?B?SE5YR1J5dVIyOCtvT3dPaVJKVERRNkU3VG1FZWtOejlNSnlFOVltRk9PMi9S?=
 =?utf-8?B?VUlsZGQyWnBwbCtxMlFJbEtBRmFVZE9Oc2MrM2hYRnJuRElqcUZLVGlNaWlF?=
 =?utf-8?B?TFBlb0VRYjMzdThYY0k5ZzNJcVdueEtHRUNmd05vM09oYlhRYzNXWVY0dlBj?=
 =?utf-8?B?eXJycHFTdWtXais5RXQ0eVRSTS9QRTRZTTlPNTVhMFlTeVloTVJ6bk52Y0E4?=
 =?utf-8?B?Z0t2ZmY2Z0l2empVZkhpKzFMSHNOdHE1K0djQklBcjNSb3NRYURWV0hMZmpz?=
 =?utf-8?B?dXBUbDlSM3Z5aThrbkJ6WTJrM0oyWDhWbnVyVzlIK1NvV3hPYzU2cmhoR3Z4?=
 =?utf-8?B?R215bVFJbDRjZ3lZR0RlaDV3VmNHN2dOSUo3WkJmQ1Uxc1dNZ2NQbG5qYzVW?=
 =?utf-8?B?NmNlY1hobnY3bDE4WjE1ZlVvcTVodzRqWkFjZ2x6RVVJeGVKc1RZTUZwWjF6?=
 =?utf-8?B?S2N4alpKY3RRU2d6a20rMmRTRVFTbDBDWHh0KytkbFlLbjArOUVlY0RZZUZH?=
 =?utf-8?B?Mk94Qi81UlNLMCthd1pqdzBvVjQwR0lHem5YR24yb28wK1A1ZmhlQXhqK0x4?=
 =?utf-8?B?THZvcXhYL2MrYTJSUGo3cFFsemRYOTM1UVp0Y3VGMkJId1ArU0RCQlpOWXdi?=
 =?utf-8?B?TEtFcFZkK09FaXUvL0k1UXBkUVZJcGZ1VHViSTZmNnU5R2NBL21KQzVZRnpt?=
 =?utf-8?B?bFhldUlyUlk1QmUrdHNWMmUvaUIyb29IalBTQ0habkRBMC9ZdjNYYmVIYWNo?=
 =?utf-8?B?ZStpaWlLQVZYL0gvNkxOWXYzdTRWajkyN3BDRjFrYWw2SXJaMWVYQmxGUzVU?=
 =?utf-8?B?ZjVUM2dkNDdQbWJPMldrYmdYc2ErMHFUVEJ3SCsrRlJrMitld2RySUxIQlFC?=
 =?utf-8?B?dE1iRTR1SWxtRHR1VmNDT1poS3lIL2oycUl0M0xBb2pGVVlZUzRVQnlRNGRY?=
 =?utf-8?B?VDdCY0NMeWVLV2JGa3ZrK2xYVFBwUnROMS9MNXQyQUl2V0tENitNcHE2WW1w?=
 =?utf-8?B?SVlDd3VKR0VNTE9HMDRkbkNwVVdJZGlodmQ3RVpSa1ZSMndmbFRIdW1xWkxl?=
 =?utf-8?B?WStEa0pDQjd1bUpnWjdOekc5TmpYajA0aVpYZ25UdHNjTEFFZjF1cUw0elNy?=
 =?utf-8?B?M05nUVVSeE85ZHNwSVliWnFjTVJWTnRMaE9GU2daT2V2TWZ6LzRKTkNSUjdB?=
 =?utf-8?B?cXdxaDhRL1h6QWVQRndhekxKbUFHN20yTWZoZkdmeWVTb01qY2E5NmI2UFNh?=
 =?utf-8?B?V1NCSmhWL0d6SUZTRXArRGVuUkx5VjlJWVFsQ2xEUVpsK3orOU10R2pYekpS?=
 =?utf-8?B?bzhMVWlZOTJ1WTRsVnZvL1g1RWttdTVra3dETGhUSEg3L01sbHl4RmhkMEdk?=
 =?utf-8?B?Rkh3bWxDY2pUb3VYaFZRRFkrU3NqV3hNNHpFMEFYNVhzUTdCWFhSN1NGdENu?=
 =?utf-8?B?WkpuTEpWM3pPTU1aNVkrUjdjdDF1YVhBREx1OFBhcmYzaVJLTG1sQTN2UHVE?=
 =?utf-8?B?VXU3cm40REJPd2dTcld6U3N1bjMvMDhGS2FMaHJVRWhaeHpsWmNBZmtLKzI2?=
 =?utf-8?B?WlY2MTFSU3BZcjVJYkQrWGdMWFBRR2FubnRJZUpsRVdScWM3Q3hxVXduZEFF?=
 =?utf-8?B?S2NCN0xZclVrcnA2a3hPYzVLc3FLVnlIUWR4M0dqK2RaUnZtaEd1bU83R2ds?=
 =?utf-8?B?UGxPcW8yRlBWR1o5cWRnUDBIUytBeDFTbU1zYlUyNHFDWG0yeXVqZjJ5ZmZ5?=
 =?utf-8?B?c1lvSFZjRVVkUE1WeGhKUXRTbnB3UGdnbFZHeWxwSWloNTgwaGx5RlVCNy9S?=
 =?utf-8?B?L0RaL2xHYnF2c3lsZFNlZlI2b3FCemxaRjdCa2VFb0tSeFN5ZkVhdjRqbFNG?=
 =?utf-8?B?WjRTUVhpMmVHN1NqTEY5TG9MZURmSTFDcHA4d2JMVGsvdmdkSG1BUmhmMkcx?=
 =?utf-8?B?WndQZkQwbnB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0ozcTJSL240RVpQNGdYVFc5Rit0RGRsMFFZQnJxZ0kwRGJkRTBiWmh6OTNT?=
 =?utf-8?B?UUt6cDNyVldjL2dUa1RWc0EwRGJiV29XM2U2QkcwWGo5ODJDNUxvbE9xSmZS?=
 =?utf-8?B?N3N1ZnpSbldVNUpieUFLVGVFN3BqOHdGbG9vZ1lCUEduUWJaYngrWlZYdmw3?=
 =?utf-8?B?QkppR09FckRKcUxCeUhNRG8xc2crQ2FuREV1YVNQbVhwZkdoRStPNXhyVlo1?=
 =?utf-8?B?amsxTGNreDZkK1EyUUN1R1BvaWlNdWx4SkpCeVJ3U0VCd2lRbm9CVUFMVnBW?=
 =?utf-8?B?UGJSc3RkRkw0VDV4S1NSNkZMQ0tOa2JBbWRHYTNCNU44dEg4eWVaYUlqUUda?=
 =?utf-8?B?Y1p4cGVrZWlPYUNiQm5qVjVtZXVheXFMWkFIY1lrTUdMVmg1emd6a3hKUVg4?=
 =?utf-8?B?Ull3OW05Q0pnQlRDK0VxZnFmeFRnR2lNYmJnVHpZM3NLdTdvM0ZsMXRnTnZN?=
 =?utf-8?B?N0JBVDNGeXF6L1ZPZ0h3WkxrcEUyRXExNVdNSGhiNEs4RGo5bTZUVGUzemNx?=
 =?utf-8?B?MnpCTFpPekt6MHVWcUFsak85eGQ3L3p4TzcvaWFJQVJkQ3Q3MDRqR1E5dnFi?=
 =?utf-8?B?NSs3Z0Npc0dYOEthUlFXeEhzYXg1azhUV29wbU9ybFdwbHltVXF4b2puYzBv?=
 =?utf-8?B?K3Z2ZktKQmRjb3h2VzA2MkE1UmlKVWxGV3NoZnVXc3Q4L0ZUdzRLN2dnRFdP?=
 =?utf-8?B?UkJNRzZRSldQU0djQnJrWmxoT0QxdlZER2w1bHptWS8zdmxPb0xNc0lRT0w4?=
 =?utf-8?B?K2ZIY2ZONnFuTGkvOWE2VEt1ZTlYSFJhaWlpTVI1OFpaK1M1ZTUwdmZaaTF2?=
 =?utf-8?B?aThCd1hOZHhQQTJiNzI3amZ0aGhlNllJNWlrZUlKbzc4WkxJbCtnUEJOb2ZF?=
 =?utf-8?B?c3c4Y1JESWhEa1dIaWN4YTZFbEwzbnhQSGYxU21yYjlHNVBEUXEvNlFYTFMv?=
 =?utf-8?B?VTFqWjFoSFEwcC9zakRYZXkrWDRSS3pPK25Iem1UbEFVbmZMOW5rbWkrQ2hl?=
 =?utf-8?B?MHdYTldUN2dyV1dWS2VHU3M1d1RaUTNWY282aXpuMWhXVEJxbkhwL3J6cjBn?=
 =?utf-8?B?aitxWVEwWlpWaTNEMjVUSzhydTEzRkxZby9BYUR2UXpTbXExVEZKVTNGQ205?=
 =?utf-8?B?ODBXTDYrbDJOZG1PUnIzOHNGSGlpcUgwdjBCU2k4eHoxNWdvaStPN2RETzRi?=
 =?utf-8?B?dlJqQmRwYUpZaUV1WnpvQy9VUHZtS3RYOTEyNjJ1NExqOVFQNDBwWnlEb01S?=
 =?utf-8?B?bDdXYzc5dk9qR1krb3dFbTdVZmxzQnBUWWdKalZPQ3ZvSVZ4WE1hdTQxY2xL?=
 =?utf-8?B?Yy9iS2dsOC9iaGlxZlVwSTZPRFF5MmlMSm5sRjRkNVpVQ2lvems1dkl2Vmox?=
 =?utf-8?B?RmllaE9lMUNJNlNKYlhBQ2Ywd1RKZGwzWndYeGtlWFN6V292bFQ0SzQ4TVlw?=
 =?utf-8?B?dXB3L29RKytHd05Hd3UwMmI1NjlVYmJCSWpaMG1sY1NFTVQ3RW8vR3ZSbEFM?=
 =?utf-8?B?OTl5ZlVJTjZ2YnVMV0VaUGs0djFPM1FWeHk1OUZ6S00xeU11QTBudnd5ZXdR?=
 =?utf-8?B?d3c5V2hCRzJ6WGJyR05VcjZqRnloZmRQWUxuWHFGcW1MYzM5SEdiWnc3ZXh3?=
 =?utf-8?B?Z2ZkOUwveVVoUVR2dDJmMmd5b2FRcEFtR3lpclFoa0FqN2wrN2I4Zm1zeUdT?=
 =?utf-8?B?ZmpBQVVnR1JNQTNVZFowOUFsejlYcWUyOWNuOXNaWC9KS254Q2JUaEY0YS94?=
 =?utf-8?B?K1JnZ2RldWE5dVFnWTBCVVA4VVNpS05BNHRpc2oyNktlcDBiUk9WYzJUQ1BW?=
 =?utf-8?B?MWdaRDYxbWtvZGNuM25oZmJvcTRrTzhFbTdRZVVIcFdyM3p1OWtvUk52eklP?=
 =?utf-8?B?WEFjR2QrbFZWd1lzY2ZKY2N2QUg4QUpLcVp6UWhZWWJGOVI4Ky9QUDd0dWxB?=
 =?utf-8?B?QVU2N1FkT2luUnJUc2E1YmV6NFdlK0ZZejFkWDZiMGdDd2puWmNXUjhvVFQ3?=
 =?utf-8?B?WkI3K3dDdGs3eG5KN0pnOHN6TUxITk5GTkltK3RidXlJd1JYdXMxQUtwQ3E4?=
 =?utf-8?B?ek9xTkJ2UE5iZk41VHo2Q05BTUtIVHBLM2J5Mkd1eUpIL0t4TkpFdWpLaGFG?=
 =?utf-8?Q?6GVs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f93b16-afac-4bf6-665a-08dd62452dfa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:02.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgALZqwDWRbtXV1vNceLBWNiFDo6LlykiyvN+VJMxY7H53JlKmxQ5kvnRFgQpORnftGbY3zxN8FJL/zoH3tAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

The msg_res region translates writes into PCIe Message TLPs. Previously we
mapped this region using atu.cpu_addr, the input address programmed into
the ATU.

"cpu_addr" is a misnomer because when a bus fabric translates addresses
between the CPU and the ATU, the ATU input address is different from the
CPU address.  A future patch will rename "cpu_addr" and correct the value
to be the ATU input address instead of the CPU physical address.

Map the msg_res region before writing to it using the msg_res resource
start, a CPU physical address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- none

change from v9 to v10
- use bjorn's suggested commit messaage.

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7b..ae3fd2a5dbf85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 

-- 
2.34.1


