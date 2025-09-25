Return-Path: <linux-pci+bounces-37011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD083BA0BB0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC5BB4E112C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80230ACEC;
	Thu, 25 Sep 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+39q7+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F867306B15;
	Thu, 25 Sep 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819733; cv=fail; b=F3Czub6LgoStlTN+ADIWWzsllOGShhRkdOcgKkQT3U02NXntC3by+q9+ypCvjvcgomXP0/sxLlX4I8MDPW7rag/UXl8bZR6E9IW32cCnfPY0A1JKivjdEsjfnp/SS8Eg6oRXE7NDJf0slmTtCulxpb2oPRJpIyciKgRqeqTAFxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819733; c=relaxed/simple;
	bh=LvSSEm3UscPO2SYTdwF8PrJOf8fETIBodOE+/WiYI9U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A35A7NbfYCCEws8B/08q/Ncuqi+73ZWIqp66WzEy+WYOCzZky0W2d6rItMV2yhSzOoFPqKHVogNk0nZb8pb7lG/gnlM9Y+MiP6WT686lxyDRja3jqGE/HwrQ8XeBCVPT8LEfeFarCHCC51Y1cyXrR/7tV+jjWiDBtYg39j3pkjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N+39q7+t; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpLQojUGcn0Vt+DFjUzcDSc0U+SlYWhLV0+oH8jLpq+kMNT/vC5zOw1qEo4dBuso3fcsvAJHvi37ALzlRGIoBOienpP5j6hT9FpA5SkekOCImKC7LbHNwJpn/gsg1g+LfStLAWbNvQevRi/lmcgK2AyFXJWLQjWuqLqRwFWt6qCBRan0S5/wdrI6FFlJuFr21uJ+QEEOX8b+aST32YmTVk7prauBagHnCLipJ6280+m4pGOmuL/1bK0JcDPBsxfsDc6JLKtVBBzntM5jH77NckNJup5ndK0tLbQ5M3mdA6/5S/BkbptkFU0j3NiX8VRbGpoGX/VGCERoiHFA3dBjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMKZFjuXaAhPmDp7K+LSsh4KMEuwU8g9J9eeCmX0R3M=;
 b=x1UBsxnaaNvFV6pG+S202y8QwsLxDe4+TsIYD8QQFPk7hrX/tVWQTz2JHjf3kl9b7wS/IAJ0Y0lkET32hry9O0kpAhtXdoLjEiys93bjIfmQJUynTZF1tw7ftKi2TVLed3WHydHZQCHmG/dBLAjHloTz7vF/UfN5MV40iMTeTr1jb/IPX+mFhOh004Wbcvf5x6xJZaCJOONFv6HL7PKgIslPpFHX3l/xcLMLZG8vasiosVERvR/zXfraOl+EE1pTpbOvyg0yKylvs5VCkVXp8mTOipYqCpD1uc8JhOzdJoGFzc6x80y4yrsuuJehlDOUhrsGGIavn97WL77f2dTDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMKZFjuXaAhPmDp7K+LSsh4KMEuwU8g9J9eeCmX0R3M=;
 b=N+39q7+tJrJ6zfNlbTJnCYu8I/+rlt3VIBQavZEjmQera92VUZl/x/HsTYPIKGy3DBOiv+8BdCbitDr1yAnhfHoMy+abxxHkmAWFZitQ7cpTy/Dr7OiIy87kkT6mRHLGOUbDhbRH4maP+qkp1hVy72FxI9Xivv66N6jZQamDr4KMhj9aMsXp7+OnBfPVKlqq56JhBRInDTb0NuLb+GCebs93T9CPdyFHlouC8EFihpI0CVyXnZAgsWvORo/BL+JPavCg1FmJEO3S6ecgAfbWozx2ywXvO0+KbfftgpyvtOFhCuZXlplZGZRheq0LdKqTKFuy9i+vDfO9h2Gt5gaeqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:02:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:02:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 13:01:47 -0400
Subject: [PATCH v3 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
In-Reply-To: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758819722; l=5152;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LvSSEm3UscPO2SYTdwF8PrJOf8fETIBodOE+/WiYI9U=;
 b=We//vKLvowoUUdRbWqXt6IIy2gmGkzR//xgrnjjx6+NaH9FC6DrFsxft/lKLNNu5hMCw4SpCo
 QwR8XlJ6Ns0DWMvZDoXgJy2fE6esixeMI53iLtI6pciLL8fQeSxvY7M
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: fda50910-06b7-42c1-a292-08ddfc5542e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVo2NlpWQjFGRW91bTRiT1I0K0UxV3JFZi95NllRTjM4blNQeFJyMWJHMEZi?=
 =?utf-8?B?dkowNzJiRm1RZXQ4TWloV1lyOEtvQmF1UkNzeVVSVWRpTXl6b0FXbW9kWCth?=
 =?utf-8?B?QmxaeUx1cHV6bWRVclR3aCt6RGlvUWdLcHNxWEhMeDFIdkp0d1RDelZDT1lz?=
 =?utf-8?B?eFBETFRhOWxnWnNWaFVJSTRGajNNQjhwMGJaL0I2UDFZbzJRNENUM21HaFVi?=
 =?utf-8?B?VU5DZmhqd1NDYjZYMkp5eUZjalhSeXBQa3lGbVJoalFhVmFmOCtldUF4d0g3?=
 =?utf-8?B?V1E4bFJHUi9Cd2pteDBoTHU2SmdMQVhvRkJSVmMrRmRraVFRM0ZENkgyeEU0?=
 =?utf-8?B?bkQ5YUVFTUFqZ3JJbnM1Mkk4bjNEaFBGQW5LVVBQV2xpT0hLalRadFNLOFlY?=
 =?utf-8?B?Ui9xRnB1eTJDV3ZxUjZCTmlKTGN5Y2xVL0pqZHMrdTNyUmdJeU84LzBnNFUx?=
 =?utf-8?B?V3p6UU1VN3ZsYkhlQ1hZL1ZpaHBpMGRxYlpRL3F6MWhYY2FkUFM1WmU2aVI1?=
 =?utf-8?B?WnpEVG4xMGtvMnRuaUE1N2Jvc2hLZlNFVTVHWUh6RWx0VmtmQVQyRnZiSExr?=
 =?utf-8?B?TzB3dUs4cURXWUV3ZDl2WkFsdEYxc1RaeHEwd1p6Y1VLRmwrZjkxM3VBNVpT?=
 =?utf-8?B?RG4wN2hzNHBJdnJDNkhBNG1XQVVPQ2FhRXhWM2cveVJLOXE0WVV3UTViTHpP?=
 =?utf-8?B?Nk1pWlJQSmtqMnMyTkRDTTFxQUNHUi9xQlYyMm54VWhBNU5halYvYnV3Z0FM?=
 =?utf-8?B?SXRuOXNEVHN4a1lkZUpGRTBNSTVGalBqZFNtUTU2ekV5R0lxL1lOc0pFa29B?=
 =?utf-8?B?cWc0aHQwV1JsVjJHZG81dnZUbHFFUjRldzJXZ3pJUEVhSXh1ZjBRaElIYngz?=
 =?utf-8?B?bm9pME1OTWNZcHNjVk5VcVFnZFVYR1BBRmZkamxhY2Iya1E4VFNMTUtLSlRI?=
 =?utf-8?B?SUZDQXVrWXdLWDQ1YjVVZVJzU0xDWSt2REpuallaTytnRTk1cGdTN2ZKS3NR?=
 =?utf-8?B?N2xNNEpPZWtVRWg2SEE4Z3Rid3FsbU03ODVwYTd1SkdlbzRFVUhlWXgzNHJa?=
 =?utf-8?B?Q3NCZEVNUy9Yc25FbkRtb1lSZmhmZVg0VGhWRXREMHFLWmlYNWRpSU5PNkFh?=
 =?utf-8?B?UnF4N3laYkF6WTJOSTdpR0NNVitDVzcwakhpSTBwY29yOUI2M3dwcFFzUHdL?=
 =?utf-8?B?VUNuSHhJSG84TUxTVU9YaHNRUDcyRmdkaHhBS01ISHB0Nm9sYlBKUXJIQkdx?=
 =?utf-8?B?dWppTmp3aGtENS9UbmJ3N2syQmRLZkx2UlAxTmErSVo2czZsS3UvTVlOMUF6?=
 =?utf-8?B?UXEraklKLy90dVBTV1Y3UUFUYkJlb0swakdrRXpObFJMYjZpbFM4SGxYeGN3?=
 =?utf-8?B?d0gvVlo5eldYTlBZRkE5disxMEYyWnhZRzhEMkRxOU1xaFZza21udmpvTkFt?=
 =?utf-8?B?djlIelQrRVdldnljWWlVd0dQcEorSFQyQ2I2d3ducTQ1MW5yUjNNdGdEUFlk?=
 =?utf-8?B?UEE0NFhvUUFjZlB2b0tQaEdrb05YSW9oYmlETGdqVTFZYVU1bTB2ZU5SNXJk?=
 =?utf-8?B?blZIRlJzWmlya0wvTFIyQit6Sm8wRmx6YzFlZDFhTGJoa1F0aVlkWThzNTNr?=
 =?utf-8?B?blJTUEpOQTE1cHhaaWNkZktBanFka0JtYThudmZuL1hJVG1kemZuUTZKdlB0?=
 =?utf-8?B?dXBha2dqVFRXclUvTkZ0bk5QRUlFaWx3SDlad3lMUE9vTlMzS3Bnc3RmM0FY?=
 =?utf-8?B?UExDWC9XZ2FXcjhIVThnLythYjZjVEIzSXN5QzFjMm4xSFRmZU1vWGlXUXJs?=
 =?utf-8?B?MEpXODJMV1JpVEhlM1A4MUllSHA4RVE3RXQ4NTVWdTMvTXh3bVk0T2Nqb2dy?=
 =?utf-8?B?R3RZS21rckJlRk1hVFA1TlFJdGd1NDZqSmxabXR3NU12Zk1wS05WZ0pLd3d6?=
 =?utf-8?B?WFNXQmw2TWNTS3ZnenlKdWxhOFBSZjZnKytZTmd0ZGdSUy8rYUdwaWw2VGg0?=
 =?utf-8?B?YzMxaUZuckdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUcyMVQyNnU2bUx6aXVUcnNIaks4cGNiZjFsRjZNZ2RyTDdUZXlwR1V1dW1E?=
 =?utf-8?B?TVpVRmtRaHA1emVkNEtLcCtOZlp1YXlsTHZzUCthWklQTWVncTVJL2twUXdp?=
 =?utf-8?B?R1ZINFZqUnZ1V2RxQ3FGZS9TdEtPVnZjelBCcjRTTTBIMU5jVzRTWjA3Wndu?=
 =?utf-8?B?Nkp5UUhOMVNiTncrdXkzalNuZFEvWFI5eE4yaHZ6ODBIZ2F2Z29MMlRpK2RJ?=
 =?utf-8?B?azYrR05tMDBnOGZ2aVZHalZ5S1UyRXBDVUpaSWRWZXFoa09ZNmpxb3dod2M1?=
 =?utf-8?B?QXlPNHhMWW1jMXh0TnNJVFlVV2JJMFpmQy9yMU1OWnNYK09qN3ZiM0djUU9h?=
 =?utf-8?B?S0RBUEJsOVA4UlZHcnFBc2FtaHVKcW5TVlpaZDJ3WmY4bmoxVDdsVXd1OXpi?=
 =?utf-8?B?Q2E5OGg2SU81YWVqdzFtak1HWW1JZUZDVWRyY3NNdlBHckJqbm5PTUF2UHRy?=
 =?utf-8?B?OTVsTDJtVlVVMVV0OXVFSVZSWmhPS2NBZGk4c0NyTWF4VGFjWEN6aXRmUUcv?=
 =?utf-8?B?RXJCcnF6MmJlTFRqZjhZdGdxSExKNU51ZWpBczBGRkpiSnFwRWJIeWtYbWV1?=
 =?utf-8?B?RktSSHRQZnlKUXJEUm9FZmhqUlc2a2hxeXgvQjFmdEdnZDl6bjZDejNIWDdx?=
 =?utf-8?B?RVN6dHIwaDhUSVlPdmQwUXhjTTRRd0QydWhaa0dTNkk3WDVVSmZRSjlxYTE2?=
 =?utf-8?B?ZVoxK2dweUV1N0tKL1BlVVdXcTlnTXZGRmc5TmVBRlhvMURERmw5cXlULzdI?=
 =?utf-8?B?c2tMdnlxQzdCSjVjaHVBVkh6RzYyZzNHVE9oYlFTV3RRbVZRSUdVMlQ4V3VS?=
 =?utf-8?B?Y3ZVenhQc3VrODkzU3M2YnA3UHhRSlR4dTRZTFFwNEdQR2lVRjVPNlk2SjJz?=
 =?utf-8?B?bmdBMWNyb2xQRmhVKzdMSHdsS0phdHBrS2NadS9DZHd0RlVMdGtBaEpsaUxL?=
 =?utf-8?B?QW4yZ3h4VWFWWEJKR1RCRzJZYTA4eXE4VWRJa2lDLzc1UUVydCs0NUZPOWQ3?=
 =?utf-8?B?QzVPR1d6Q0hkc2taLzdFWDBlYkRvVmswdkJMUkdDRjJWSnZGYThDcnE5N3Jm?=
 =?utf-8?B?TWI4ZTQ5S1ZCbWZybitTVlU0Y1ZXY3dIVWoyRG91ZXphK0xnUXJSYzliNEU3?=
 =?utf-8?B?NHVnNEtNQnQydTg4SStBTnA1TkRnU1ZEQUdwNE96MGZUbjZnZFB2aFNXK0Vp?=
 =?utf-8?B?blYrSysySkprTGo4UTB2MmFQMFRhaU14ajFnbEErQ0hRVXY4Ky9YTVBJdUg1?=
 =?utf-8?B?eUJzUG5UZmhwQ3lvSFlhbXcwZ2VBQ21hNTByQ0NnV09CRjk2Mis1elhUeWd6?=
 =?utf-8?B?TzBLVDJuR0JTNWFhUFZKVGpvdVRYdDFOdkdSSHkxdzcxM0pRRTVaWlEzM25r?=
 =?utf-8?B?R0xYRk5HdUdRTGY4dWozbTNPS292WE5SbVNiR1pNZ0pmZVZtMVEwSTFCUXEw?=
 =?utf-8?B?TWJYaGhSNUhLbjZqUmxwano1OTlHUnZBOXJZV21NQi9SWmxiTENMLzJXM3p1?=
 =?utf-8?B?MTR3dnpTSDZyZHpENEpDbi9NRDVTT0tPR2Nsam1qUlVPTjIrb2EwbGRjbXdq?=
 =?utf-8?B?dGtTek13bitDaWhHTUZYaEZjY1lTZ2EzTU1ZQUlta0t0a2U1Nmd6MXFkbEJx?=
 =?utf-8?B?ZmtPTkwxeklTR2o5ak5rRWN6MnZBeFI3WGNPMFhsU29ZNzMwdytxN1MxM0Ro?=
 =?utf-8?B?Y0pHclUvYWJLNzUycnI4REkvaUxzVHZacDZQdVRwM2QvY29qQXY3RzRjOW9H?=
 =?utf-8?B?Nll6VWx0MmUzS2N0cVc1Y3RjY3A1WWhEbXN2cXhNMFR3NGtjTU1OOTFwdHdj?=
 =?utf-8?B?NHoxbUkyNG5VMHAvd0dIVDlrUmRjSkcvSzF2WTdKWk9xdk55aUF3ZnpJVmNT?=
 =?utf-8?B?NjJIV09KcGpxNURCRm5oVmJOb3VOaHBtb0EyODYrSm56eTgrTUVTS05PSkE1?=
 =?utf-8?B?MDRMc1ZTdkVDL3k3Q1I2bm5vWlpuaStYWVlGbDRHdTBUTDh3UE82aTg0SWxr?=
 =?utf-8?B?WHNWWXlzOEJxQmRrTTI2aWdBZmNUNGV5SFVVclBEcGlZSnhWQkhkQVpsUWpC?=
 =?utf-8?B?YVR4R3VJNFVybHoyYWVHeWovWWdMZVBHcGhYc09xeDhMZld2Q3R1QXUxSjkv?=
 =?utf-8?Q?aTgs29YN24ySxfDZhUKrYuouv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda50910-06b7-42c1-a292-08ddfc5542e7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:02:08.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1KAnM3oC+5pJqJk202xmTLB936fFE5DD4jCoyktC8UVmm5WN72gQYJV+CqmZbQCvVN+2zu9Du5gA345/1i9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
size and memory size. Prepare for adding support to set an MMIO address to
a specific BAR.

Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
confuse.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- change return value to int.
- use two pointers return bar size aligned and memory start address aligned
- update comments about why need memory align size. Actually iATU require
start address match aligned requirement. Since kernel return align to
size's address.
- use two varible aligned_bar_size and aligned_mem_size to avoid confuse
use 'size'.

change in v2
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..2cd0257831f9885a4381c087ed8f3326f5960966 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 }
 EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
 
+static int
+pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
+			      size_t *aligned_bar_size,
+			      size_t *aligned_mem_size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type)
+{
+	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
+	size_t align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
+	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+		if (size > bar_fixed_size) {
+			dev_err(&epf->dev,
+				"requested BAR size is larger than fixed size\n");
+			return -ENOMEM;
+		}
+		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
+	}
+
+	*aligned_bar_size = size;
+
+	/*
+	 * The EPC's BAR start address must meet alignment requirements. In most
+	 * cases, the alignment will match the BAR size. However, differences
+	 * can occur—for example, when the fixed BAR size (e.g., 128 bytes) is
+	 * smaller than the required alignment (e.g., 4 KB).
+	 */
+	*aligned_mem_size = align ? ALIGN(size, align) : size;
+
+	return 0;
+}
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @epf: the EPF device from whom to free the memory
@@ -264,40 +307,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
-	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t aligned_size, align = epc_features->align;
+	size_t aligned_mem_size, aligned_bar_size;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
 	struct device *dev;
 	void *space;
 
-	if (size < 128)
-		size = 128;
-
-	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
-	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
-		size = SZ_1M;
-
-	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
-		if (size > bar_fixed_size) {
-			dev_err(&epf->dev,
-				"requested BAR size is larger than fixed size\n");
-			return NULL;
-		}
-		size = bar_fixed_size;
-	} else {
-		/* BAR size must be power of two */
-		size = roundup_pow_of_two(size);
-	}
-
-	/*
-	 * Allocate enough memory to accommodate the iATU alignment
-	 * requirement.  In most cases, this will be the same as .size but
-	 * it might be different if, for example, the fixed size of a BAR
-	 * is smaller than align.
-	 */
-	aligned_size = align ? ALIGN(size, align) : size;
+	if (pci_epf_get_bar_required_size(epf, size, &aligned_bar_size,
+					  &aligned_mem_size, bar,
+					  epc_features, type))
+		return NULL;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -308,7 +328,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
+
+	space = dma_alloc_coherent(dev, aligned_mem_size,
+				   &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -316,8 +338,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
-	epf_bar[bar].size = size;
-	epf_bar[bar].aligned_size = aligned_size;
+	epf_bar[bar].size = aligned_bar_size;
+	epf_bar[bar].aligned_size = aligned_mem_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;

-- 
2.34.1


