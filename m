Return-Path: <linux-pci+bounces-23372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01097A5A4BB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0FB7A2FD2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77E1E520E;
	Mon, 10 Mar 2025 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fTbdgArK"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013066.outbound.protection.outlook.com [52.101.67.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9011DF248;
	Mon, 10 Mar 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637887; cv=fail; b=Rv6mtQ23HPWBkqfFggTIqD96oVcJMe+EGS2+prlHoI1ph+ZuGog60P+hNSPuGeHNCLyq/teLjA1d5ZyNitauIq+6oOj0lm8R8W1GiK5r8j+8fo3IzRRfoh7dbOPOnPRMo9Zk/eIg71I2hAKfIpSFcbklclF8ZjUWMEUwWbreqkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637887; c=relaxed/simple;
	bh=NN9KOcS9NNW5yd8VEpgIqFGnP2to3DUIOpQ709UsPNY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T4dZPXECGppvp0Hzu4LzdqIH0/Y5NS9qjjIDm0jl3Cf2jRn3Dfh/9x8VZLXuPezX+4d/enXl7A8Ge6uiQ3Dlv0Y1U79TZj30fEHsy12hWNLb4EdHLZBn5Len0CLeQHqMix+ldmijRvY9nPmXeNkkg+mPDkb04dGYOGYm6krYvQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fTbdgArK; arc=fail smtp.client-ip=52.101.67.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJUUl3md37euI6P5gL3bQKwWD5dsYOzWyCvKtWaGl135d+OMhuzh3pLwS1+gDxlNS65EPA0oa2QeZtcoW8kvqCIqwcL8qA+M9USJJ/qmLodSPqYdI3ZTZhD5QHPISN6ZzoIPCr/6jD+1Xx/Q77lV+rYpVun2mLETXbudBvm/vdpckRSff4aGY2iraBLbhDYwuvUPSIahVpJ10SwKYoH2SAWinlRjlldMVdSvnJvDwGdDA+z1GbrnSmfswTfPDeqXQqgSg/J5ozDWN8HCAFiJRU4gLzNsUjuyCLJRbfcXMg4YaTnquMGKuJWV84Yieuyh4VIuB5mqb0hVtyfUfVuTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppyyX9Q2wxZTypjuPhcXkP3T2A2ooftwehps2NlrrWQ=;
 b=kQ5jFffj8f/MmKqYv3oLnW2IKHSVBfoCNmXvjzkD/yLyqoj6BIHtLdJXkoFxPID0K/PUibqkN07j9LJdmbzHXfdr+7gOxy603cpu10LLs9BbBoBU8t8wAbDpAWQoEuF7t6rZzQEOd+3/jNXjq6dS1qcU0hNf9e+wbqvaVH/1l1dCD3NCPjkotSzFTPzdNgKZgfMDKPD8026qlsZg4kUXLKHZ+KM2mH9eS5c5WdYYINazeBy/UTWjYRm17rh384HBVsP4G9ZQOnXqECVzzOR/VCZN1GY9a0QnZrKOFfbkHH71QVfuf/T6/az8838+LIeWBQVuL9tLOKHQYyyP+9b0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppyyX9Q2wxZTypjuPhcXkP3T2A2ooftwehps2NlrrWQ=;
 b=fTbdgArKLKPUScmZeXiTOYrEbBl+X0todQ86tnBpch0GbiSkVJMqE7H6YkBy1u/YM8vV3IiNPJ0FBDboQbazyXdDlZItnHpz1p9v4aMuE0UhrOOcc8u62qiWWFQv6+G1nFS8hH93/k8LmRuVrwYT6rfliBZP2le8aMDGAtzGWZvAFIiHKy37uav9XsA85DlOMCmna78x8CYVFWsAD6ElD8aPRjLVZk3h3OcZzpnxcFbioMtU2Uao9vIbyUBzkImQK4txcK2DBFWHvygIwzOFJi/t+gzQZ1cowcoEr3dB3ccIwvf8BsrldwlhIdEO+ACjvZtO62cdL/TLK0fLRyUFhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:18:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:18:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:47 -0400
Subject: [PATCH v10 09/10] PCI: dwc: ep: Ensure proper iteration over
 outbound map windows
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-9-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=1438;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NN9KOcS9NNW5yd8VEpgIqFGnP2to3DUIOpQ709UsPNY=;
 b=Owo0r3ib/35TFiH88AKwmpewAtBKvJX64sL3M4SMpRT45uuqsovw7XxO828niHmrMYRDLWtjY
 QM3XjEqVEJVDa5EeoRf6FJhBUvj0tg2fI7Ls7mPW7vbZHqlwsmcQinb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c01c310-44e0-4b83-842f-08dd6010a950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THRwN2VtYVUrS292NTdxaS9OZW5XSGVJWlZMVThha0RGeEZZUXVDZWZPMjZM?=
 =?utf-8?B?OEI3WW9sdmpkcDZsWjBOY1BjUnhSME5jcUtIbkt2OEJNS2xEVU9MRnZ3Wnl6?=
 =?utf-8?B?Q0V5eENTSVlrRERqNzJKU09tWDB4aGhxNzZsSlg5KzNId2hoNUtYQmJJZytp?=
 =?utf-8?B?eElaSDR0YStvTXVhdjcyKzNaOXhwM3h5ZUZZeVZjNk13b0dEZndVNUMzMjNL?=
 =?utf-8?B?NExRalhZUjhwZy9tSTBVSkNEN2gxUVhQc2NpREZERkJKbEwvZFNtS0N2cGo3?=
 =?utf-8?B?Y0ZXMklHcFlwQ2JVbUxvQlhMUS9qdjNsa2sxNXJNWFoxZXRVR0pQaW5mWHpj?=
 =?utf-8?B?djhnTXl2TGRyMXpCd3UwbXVCclFuVlh6dU9Md3ZEWDdYbDZ6VlJabDY2Z05r?=
 =?utf-8?B?YzlXVnV6UGFReGtWSVF2SU5RUytiRmhVbTVjUTA2M1JHUHpxZE9DNlY0aVg4?=
 =?utf-8?B?cXp6bnVDN2ZXK2VsRlRJaEVrbjc1S3dwd09SNzFYTGt0elNyQ1V1ZWVLZlFt?=
 =?utf-8?B?MFlWL2tmbk13YjNjRjJyWG11WHRMVGlWaFFqR2xmL2lzcFhZMlV6eEo2Qk9G?=
 =?utf-8?B?ZVhTOGV5dXRmMlJuQXRLdTdtWVVGZG5scUE3UmpqNUpWRzdrZXQxaGRmNGdR?=
 =?utf-8?B?RkhjTlg5YnFSUk01a29iSDJXaldJTWpsRnRVcU1Wd2t5OHNrZ2haU241K3JX?=
 =?utf-8?B?MkJCMkx6NkRGYzN1WjA5Q2JKUVdvVHAwcUxreVRtR3h1OTNmeFVxR3MwYTNo?=
 =?utf-8?B?UHlMUVpsRWxld1BSU2xud24yMFhTckdoWVRSQXREbWZrWGthY3NsK3lIYXJZ?=
 =?utf-8?B?ek1vNFY4djVkWWxhUnQrdlpBSjBlckFHb1ZkeUUvWmRxc3k4bEI4WWVtWnY4?=
 =?utf-8?B?VjBzWFhwQzEvWFBKcG0rR2hOZm1OVG85Z0pwbVRTYTc5dW5RbUpQdTJteDlh?=
 =?utf-8?B?Mk9OUkNISm50NnB1S053a3BGc1JMNmhmbE9aMTRZSTgzMGUyR04wanNPeTFq?=
 =?utf-8?B?K1JuWmtXOEMrVW5idlFqekU1MjhHenlIenUyK21NS3pqUHM0QnNvOU5BdWRj?=
 =?utf-8?B?Nm94SHNiUUFzL0ZBRzg2NEE3TlFhbmV0NmFiY1drUVNsNVhUbUNQK1ozcEFa?=
 =?utf-8?B?N0kyVEduT1JHeTdNZXM4RzhuckszZC9nK2M2eUhOdWpPYSt3d1pJZmhqNFRR?=
 =?utf-8?B?dEFPZEs1eHhpWDlNZ0VZOTc0cU80UDhyNG16dDFienJ6cjZGaDNtYjJ4WTZm?=
 =?utf-8?B?MlhPMEdLT1l3U3NHaDZwU3lDS2FFWXM2ZDJUQi9GUFRxN3Q2VGxhNWR3aGcz?=
 =?utf-8?B?dG43SFRzcFZmWEg1RjdBNFVkZ0NWSkRoL0pXc3d0MlhmcWptNEZwWnNDMDhr?=
 =?utf-8?B?cE9GY2xuVnBtUGhOZkxtZEQrazNJWHlvWlQvY3IvKzZXcGJ6Q0NONVB5MWta?=
 =?utf-8?B?MHVocGlSeVNkZ2ZOcHZnZXdza0ZwL2V5YTlkTzI2WGpoRllib2hvTjV2dFNN?=
 =?utf-8?B?dVMvUWJuN3ErR1VjYkNVZjZWOGtOOHR5c1g4dU44c05hclFFNHFnYjY2R0VH?=
 =?utf-8?B?dCtuTDAzc2t0T0NqakNuUFZlT3g4U0ZsSk5xRTZHTVVhd0p3WFpPd3M0Tnh2?=
 =?utf-8?B?c1VKUHd6MWExZThGOW1RMlRQWDBybm05VEtLWXFXVjh2QVo5bUVwMURkb0dU?=
 =?utf-8?B?TjRnRXRhaTRQMTBUYVZ2UGNRYzVlSGw1VFUzalhxSWZMblBnL1JNV2Z0L2xU?=
 =?utf-8?B?cnFlSU5yVlFSZkp3dTV5NExaVW9EUjJwWkxtb3RZcDc1UVRrL1hoeDl1azR0?=
 =?utf-8?B?QzVHU1M0S3Bpa0ZENzYvTkwyUHZoa3I0b1ZQNHpRUVh0TUdybW5aMUdaSUht?=
 =?utf-8?B?MUFlTDloZkg4aEp3SFh0dFByOUxDazdDN3NUSDdVdDZTd3dDeVFzSHZNZkE1?=
 =?utf-8?B?cEczem5RamNmN0FqL3drRUxrRm1iM3BLOWY4amk1eVJNZFYyNzlrR282bzBx?=
 =?utf-8?B?ZkZFd2d6UzdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdLQ3ZXWjhmY0IzdnFHNWVseXpEQnhVaXZkd2tGSlVOSUZsdWRGMUk2VElR?=
 =?utf-8?B?NUFUR3UyZThPWGQ2VThYVjNBSC9pYUNXZ0p1Yk9OeUdBRlFoM1JONnRob0tv?=
 =?utf-8?B?clZRanVsMGdySnpDNnpsYVJUbWp1RVJtTk5vMjFqM045SzA5SUdtSjA5amRN?=
 =?utf-8?B?RjNTRTFHcVh3YnVYRC9IaXZhVTdVcDRMUEg3UkFlV1VrU255WCtMT2dlRmZV?=
 =?utf-8?B?bDBRa1JZdmxOemUxK2U5NGxzTWorcUxzdlovS09qd01TWHVHQlRMZlk1a3p6?=
 =?utf-8?B?MDFUN3ZsNWMrd2Z0MUdjZm9VeTZObmhmenBVYTY0Rk5LYlFkR2tjWnJDeHpF?=
 =?utf-8?B?eTkyUHNmbVc5cFFFUmR6VUtRalJ2SDMrQnJZQTNhUWJYWDRaQ2Y3aDVDeWR5?=
 =?utf-8?B?a05zc1pOamxiQnYybGcwOHorOVdzWi9XNGg4TSs4d1RPSWxTVEMrcGh0dVN2?=
 =?utf-8?B?QkJLRVBWa0NaUVFaWVBrSnpxTHk3SVE4MU9TRC8xYWVKSGp2N1pjRXNRZUlu?=
 =?utf-8?B?RDkzOHJvUHhrL09hRzBNc1h1bGg0eUgyeks5NTNmQUdaV1p6MHNUNGxSYUcy?=
 =?utf-8?B?M0tIK1VLOHE3M0xHclFDd2dCL2RaSG4zNlF5S1Z2WGJxR3hLVWZiOG9ycENn?=
 =?utf-8?B?WjM4T0lCWkFrU0lhWWJYY0VOanN1VXlaaVVlWlpTMm1mekxVdXVjT0tVa0xi?=
 =?utf-8?B?aDI5UUptNThkZ0VuV3hINEpwWmU0Tm1SdzhPdEJTeWE0RUxuemlhalV0RitZ?=
 =?utf-8?B?Qm5kS0xVa3hNOU53VHNpY1hLaGcwTXU2cGpSMTQrL09kOXMxc1VNVjBjcjZl?=
 =?utf-8?B?QVMxaHdIODMvMW5Oa01jWkx1SVVmbUJVTVB4REhOL1dDeGdoODFOdC9YOVlM?=
 =?utf-8?B?a21HT3NXSTJKRGY5cTAvNGdBWTBDRkNjak5xTm1XcXRiZGUvWFBPWEtUU3V0?=
 =?utf-8?B?dXhtSG5VU01wOXFQb1hIU0VWNGNmZ3drb0VzWGdSQ0ZHNmJORjN0cjNCbkE2?=
 =?utf-8?B?NDE4djIyNHg4QmZ1THFQd2krYkVPaElXQzNTNExMdDJsdzFWNDlZUWxwYXJy?=
 =?utf-8?B?dHZ0K2NhQmF6Sld6aFFXc2gvdDRFYkJsaGIvUVhYU1RvLzFTNWdJSFR2YkFB?=
 =?utf-8?B?ZjZPYUsrR25iQ1ZmcWhUbnp4MXJIbW5uRVF6L3k4MDFYYnRGdlZ0WDhCMkhJ?=
 =?utf-8?B?MlpBZGdmeWZXR1I5TVNKOUxXVzczUUdaUWVMOUtqcWgra0hFbW5lb0hibTdq?=
 =?utf-8?B?V3J4eGEwU2VnR3kycWlQZ2V6bFRJNWFVT0FBMDVaNWxWbDh5ZHdKUU94NWhm?=
 =?utf-8?B?QjBwTEUzdmFHSUlINkZHT01ocWE0aHNUeHlQWDVoQ0pnU3BlQUpFdlpEd0tu?=
 =?utf-8?B?WnNBMkxOSHFkVTl4TnFleVFvME5IdUErcjlzdDd3MysxaVpkaU5Sc2NRd3Bu?=
 =?utf-8?B?aDFGMTMxNGNBSVo1M2tuV2NMNWJBckN2dzc1bnlyd1M0cEhwbnREdExnUDEw?=
 =?utf-8?B?Ly94WVlESzJpOGxsTmMzQ0IvdnVUalVOODhNTHVubkFzRHFTYk9jV2tSb25T?=
 =?utf-8?B?aThOMEFPWnJRTkRVUXgxTW5aNlFPZHNrLzc5U2N0TEorb2xpdWlUUm85eE9K?=
 =?utf-8?B?RUtCUGlVeUxUdGdiNjVUd1ltUEp0bHFvOG95SG5uYThTanNHZXFiSEd6RzUv?=
 =?utf-8?B?ejN1RitCa0l0SlRlV1Q0dUFBRC8yNUhKSlhXQmpqeTFTNVd1L2tqcExlVEdG?=
 =?utf-8?B?dThpdFZiLzFOY29IUE9YeTZ3VDZsU2M5Z1ltdFRUMERRYXRUU2gzVmR2OWZt?=
 =?utf-8?B?V0hqV2ZrRHdNWG1Cb1F2dmJ6WmhkYWNPVE5xTzJ2RHU4RmhzWWpMY24ya3RI?=
 =?utf-8?B?Tk5nZjBEbGxBQXpCRXduWjhCQWZnMnh0Qk9iOXJWVmUvOE1zK1ZpbXFXbkdk?=
 =?utf-8?B?bDBBZTdjZURjeS93RElsRnhPay95U1I0Mkl0clVhek9WM2FHMiswdkk1ZFdC?=
 =?utf-8?B?Y1FSTXhMUEdLaTh6QitPSDllWUZIdmc2TTk4SGFCUFU3NEpmdzRicXdSdnF2?=
 =?utf-8?B?NjFCQVZyMXY1NnFybktPcDl3MVlBbUdVejdnaG1jVW9uMmF1bnUzQTM3Q0g5?=
 =?utf-8?Q?FFqfBTUmkQsf9w7VX/K+4HbCJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01c310-44e0-4b83-842f-08dd6010a950
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:18:03.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZGoU0t1VRwho+oHTGSd+U2h+KfAsWjlwKjqVM6rffd9EerBnkn8h5gkgDOPabsEi948+NeB2y0GcNAFLOwg7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

Most systems' PCIe outbound map windows have non-zero physical addresses,
but the possibility of encountering zero increased with commit
("PCI: dwc: ep: Add bus_addr_base for outbound window").

'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
some hardware, which trims high address bits through bus fabric before
sending to the PCIe controller.

Replace the iteration logic with 'for_each_set_bit()' to ensure only
allocated map windows are iterated when determining the ATU index from a
given address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- remove commit hash value

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 62bc71ad20719..e333855633a77 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;

-- 
2.34.1


