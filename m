Return-Path: <linux-pci+bounces-13462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF202984D17
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 23:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7DF2843A4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823C1547C5;
	Tue, 24 Sep 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KbzyCQnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165D1482F5;
	Tue, 24 Sep 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214887; cv=fail; b=MKJF2/BpLq29nBW5RAq571sbUYjNheSKr208poBxUMQpywDBneKrXVvMPYI6KHCqU1wEfxQcBEgm2vju9Z7BQtF1EPeRE3UhnVJF0tQQ496VfmWKunqCxW0pE5r7u9GAYIWO6Fvk2KePmibmj1z8IC0anyyu0ARqcFYwSNdEQjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214887; c=relaxed/simple;
	bh=z4KaswFJYOePVkot3vtaaDaA7AqrHslIbrV1jsqJ4FY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FNT7NYyQFdOiwgFOKr5b3gwdOesoGl62syTaACZE583gM7cWVphoUQ6dqxMKL5O9gMVZJe3BoKhNoZfQ5H3HN3RfoWds7BrpWjn7XS3we+ORwHh3sX7Bycwm9GzkdyM2Jkp3exwBLzpMKXtEJVJbbOmG0XWhT6qZ3OyMuF3Ut2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KbzyCQnl; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj8Yv/z4E3zqjOAuoGRoMqjUDo/qFdEc6bLpx/iACevm5Y+PdCRQdVBdNvsyNor2E80HnXXJwCQ4FXEfMGncLiVF2LOK21oSaewAtKEj5BRLwXMk2VjO7GxX7xpRoOCgkr316fvjJlnG4ZpaXMEDetdZhKI4y2nLgBaChLglEx1/yFEH7a8XK/8yWX4euyWp4mbfjWHeSVpreAOowKjJmTmO9Y/qaVkrrUZt6ZKIJpYi34igbmfp2/78DU06G6/XAWrzYRDbpnTVSRt/s/NdJWfe7AGM8yXsxU2ZsFT6zFSukuCVd415lu5ql2uC4xYte9W3rC1xIlc16qMiU/NcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN+yv2c3XxYPdVprLkTMIJC2lil7IeASvtS18gALS4Y=;
 b=qtQRcafNdsa9Zm+2my51dUzVw0yUkly9WnBqjCkzxc7o5dQfWruu/wG5r8R0IY6yk03Wsp8FZfXT+BKs5n0H6dx5ZpOHZQrmPRpffBM+4EUaBFlO/xkmhSxn6C9OyHuDR93aRQyP8cIKb2D70ayDNMRscJKGfQy+PXotaYU2QWzpaCRuD4oxTXEvc0CDpZrnBnDAergql3Ij4NWKJXenkyGlT10f7zsvbY75YsiMyv+4yEevBYqchhjZC7eMNzd53DW5uGldIJ8ub91HZkv/clrk9nI7qL51ahWnT1LT3FIh8b/l7wRW89G8tpPy4XhoWk6UftxvisO7OxxR0iP1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN+yv2c3XxYPdVprLkTMIJC2lil7IeASvtS18gALS4Y=;
 b=KbzyCQnl5Hel+ULqZ0oiNzOjbv9nLvmMwHUNs6t629xoS75POgdzHOUTqd4geb/wQLdB/X6CFldR0nHhaxAwlO/lxvdOGeWTKk1fWqqFWTJa1Wtn9Jr46/mXCbr1uHXdrX5J5ETpfOpfGG8I2/J3XH8ZToDNwgQUZUd7bXXT6oMFfHShPyFGOVO2id0btoZsmeWonomjaBX7yO8BbqzgWOj50FSLUMRBAjjO4xP2c4vt4ahGUdHtwB5jU5T3Mx0+P8fmud0wJ5mufXm4WkueSClZxsWNjq6MCwjdqFqyj3SETCJVi+oWxNjqnp1Fll++xNnB48r5tgjnC9f/nNHhAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 21:54:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 21:54:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 24 Sep 2024 17:54:19 -0400
Subject: [PATCH 1/3] of: address: Add helper function to get untranslated
 'ranges' information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240924-pci_fixup_addr-v1-1-57d14a91ec4f@nxp.com>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
In-Reply-To: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727214875; l=7228;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=z4KaswFJYOePVkot3vtaaDaA7AqrHslIbrV1jsqJ4FY=;
 b=vdiTM/i9IXmSRCY8OIRTUgBORXi6IhsA05iSjV+r0f+Wjozi/1DoExUY+j0YsF1uqcc+hkwLw
 6C4E/T7BV8qCN04UWEcJ6uE0zamT8VHdNbcjkGH8qQDqRW/+HNUG3p4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 520c3e4d-4506-48af-5e15-08dcdce37fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFdrRGJIb2FDWTdzelA4bzVWMWx6b1o2cHRYSUxSLzB4NmtQYmMrRDJITXd4?=
 =?utf-8?B?QktvTktFdFFWMm13T0tBWGFxdlN1SmM5WFV3UDhud0ZFc1FEVDJpclBQdzlE?=
 =?utf-8?B?WlYvU0YxMkgvdFh3aXZGZzh1RGQxaE1MYmk2L1BGQ0ZIV1VaMFNaMkMrb0cz?=
 =?utf-8?B?L2VMNmN1Y2ZVQVh1SmR0U0VCTjlkdjB5V2ZWZ1c4cWIrZWloSEtyVWNOMitJ?=
 =?utf-8?B?VHA0TXB0T1YvK0htSGIvZ29IRXl4NnR1U0czSTdvbGx5TkZRZFR0ZGVXUW9J?=
 =?utf-8?B?T0Z3dzNlWXZmTDJTclI3TUViQjFsTGdFYTNGbkpDUWxnLytIY1Y4VVEybUpN?=
 =?utf-8?B?cmxEanBlL2R2TXB2MjMwTGt5Zkc0c1pUL2dVci8rOHBnVURObCt0V0lDUU12?=
 =?utf-8?B?cTZWS2VUSTdHUTdieXBISFFrMWlVMlhJQituQVJuMCt5b21DVm1KSndIRlJw?=
 =?utf-8?B?T09xR3dVMFJwVEp1TWZCVnFUNXRoL0duUU9Ea2lIMUlBWVNwekFHNWdDV1RM?=
 =?utf-8?B?ZHp3RG5udUpDekU2ZHdKK1QxTjNCMmRQcFZCcytDbWZWSWFnQlk0ODJENWQ2?=
 =?utf-8?B?OUVIMENSRElXb04zTDZJM1JDNVcrL2ZlRFVVT1o0eTMvUmhQekZTSFp5QmpE?=
 =?utf-8?B?VEZjWkFjZHNvVGNrb2Fwam5GRzhhSlRleXZoK3dtU1VIWjg4RG92cHYrUWxC?=
 =?utf-8?B?SHdKa05rOXVMeFBkMUE5cnBYcWJHdUtJUGxZY2NqMDlxYkgxTUxheXZPalhv?=
 =?utf-8?B?dms0eE0rZVQ3aUdOdjdKcnVSY2s2L0lQNW01d0dSQjF5eEh5aU1yUWN4Z1Bp?=
 =?utf-8?B?UjEyRTEyNTBNM2VPTExsZk5tYXNnVUVFVnRUZFFIUkEyS25GM1J0VVFOck1X?=
 =?utf-8?B?NDl0ZVNseGFQY2tpclNmMVNiNnBiSEF3NHI2MkpkVzdGWUQvN1hXcXlhQ0Ni?=
 =?utf-8?B?RkpIajVXcjhWTzNkWDFQWEtlcVl3dTJrV01NWXMyTnRlT2h0UG8ySURib2t3?=
 =?utf-8?B?NDJKN3NSS0M5VHdnR3VrUW9sSTVTc0xXMXAxUmJPcWZLQXpjZ3FPdldXMTdT?=
 =?utf-8?B?cnpTTEgwVjYxSCs3cmtIU2RMWk1UNUFSRjlZQzdYV0JIcFF6VDExK3FaR1Fp?=
 =?utf-8?B?SGtOQ2NBYzlOckdyOStiRmlFUEU4LzhKWjVDajNDMTY2VUppOFFQc1haRGZL?=
 =?utf-8?B?UDFRdHJCbFJ0SHlKUlVzdkEyVWF1ZEZWWVBodGdYamltTExzN3J1UlhuQUZx?=
 =?utf-8?B?T09qUUxtRVNHcFdJcGEwSGtMUndJRjNoaTh2R3NVNE55TjJ1cHpaRnBqcEpr?=
 =?utf-8?B?NWxKVzRHaUFUQ0x5a3Fzd3NHWXhuSWsyMEw2OTl5OURya29hclZwelg5QzJK?=
 =?utf-8?B?a25hb0NZZ2xBSU5LdVJyRmxSdlIra2Ftcys1a1VOT3NRQjhZQi9EUHdDVCt5?=
 =?utf-8?B?UHc4eGxxT2dMQWIrWjlpcnM3dnJrUDFGZW9aQXFxZnFFeHVzUjRId3J6c0xn?=
 =?utf-8?B?M1FGOEdPdkVST25sTDV3NU5RdHR3cEl6aTNJeEVHV2NZMWt5c0U1K0d4UWF2?=
 =?utf-8?B?MHpVbnlvSGs4dVY4amhod3gxemJsTzl2MU51TksrU25Wd2JRRU8xb0xxSjF6?=
 =?utf-8?B?OU9sdFlPR1dxM2JadXpUNW1jV2JESjFxc1NnTWttTGV0dkJZM1JISzFkNW9E?=
 =?utf-8?B?T25NWXplaTZkcmt6d0JKMFFUeThHSzBBOUlIZnV4Y1hhR0dmMndZMTBWZEZT?=
 =?utf-8?B?cVk4a3prbFdXU2M0SDd5R3pHcmhDL0hnWTdjY0ozem1xcVVvdStrUnpzRlQr?=
 =?utf-8?B?Rmxid2M2NGtEcmUxNjRDNEJPNWNtSERqOUJHRTUzR0dGRUx6K0pSZElzSERV?=
 =?utf-8?B?c0gxZGdpcGZGVzF3ak1jbUJDSFhJc0lyMzd2L255YTZuRWU1KzFVSkxvWGRO?=
 =?utf-8?Q?5WExpYcp+jA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?algraW9LdUkyYU9SL3RONTd5ZzF4aHh3YjhmcnN1VnFRZ1VuWTJVelc1dHpD?=
 =?utf-8?B?WlhaOHpkbG5yUm91M2d1S0NDOGhPLytaUmFsbDlUdVpnV3lJWjc1Y0lsc0xS?=
 =?utf-8?B?UkNvMmF2dUJhRXFhL1owR1Z2VHlGNW9NNDhybXZiSnkwSlNNTU5FV1VFaFUr?=
 =?utf-8?B?VFIzNVZTRElNWml2T09RVnpGa0UvaWFXdWdjWHRpMEVlcVhDMCsyUGVkejBx?=
 =?utf-8?B?VWhIWkVwL0w4RXhTUTZGMmpWV1NWbFFnVHo0L3RQL3prZllsMndiME94Zm9L?=
 =?utf-8?B?NWNHaUdNZCs1ZGg4eU4xTWtvYk9saHpLS3k4NmlTV2ZBclc1NXVxR093VjMr?=
 =?utf-8?B?YnpaazVkb3ljWFhLYjh3c1lNeElpZ0RJWi85dW1UWVpvd2VMVDR0UXhsSEJD?=
 =?utf-8?B?RFNpcEtndGpibERhYnZOU01jS2p0ZmhXWGQzZm16RnpEc0NkdzZ4cmxpeTJF?=
 =?utf-8?B?SVQ1RlpGbVJ6bWFxTHh4L0l1ZStHSVpqL1o4MTRLa24wNnFkbGpkdFFMUkRB?=
 =?utf-8?B?SkY4RjZ5Z0tDZEk3TitPNkMyQlgrQUc0NlRVTTZVaWZNbG90b2dGdmxrcldp?=
 =?utf-8?B?L0l5MVJXWERwQVg0TDBnUkVJd0paK3VNVVcra0Vna3ZaUUxFSmxCcjhlU0N4?=
 =?utf-8?B?VVd5WmVQd3hUOTNpN0Z2RXVGVGJZdUtnWHdTVlpndXE5dUROVkxJeURSRHYr?=
 =?utf-8?B?a1hxT3dCUUdZN29RanZEdUxsQWJwYzEwRFZGekdXQUtsejNYaUJScEhnKzJ5?=
 =?utf-8?B?Qyt5a3hiSHNkbHJYMHcwclhQZUpWY2R2OEQ0SUNqZ1RyVHBTTld1WlZXRDJE?=
 =?utf-8?B?SFFKWkEvUzJsZDVCL2FjT3VLZllhOW5zeXd5VkFHaVNqb29LcENCdHJJNmxn?=
 =?utf-8?B?c0RBUk9YYWZUNUtzbVBWN0VNc0NZSjlqbVhKbkY3YUtuMW0xVHU2MDdlNzI3?=
 =?utf-8?B?YWxYSXFGbExCeGJTOG5iRTE1WWtpUGdaSnRZTElVbFRxaDY3N1AvYjQ3Zitk?=
 =?utf-8?B?aUl1MWt5RkF3TytRMzIzS2FRR3VkY2JnOVU1MTZvQnFkRm9Ld24wYWEveHdU?=
 =?utf-8?B?Y3FvSTF4UU4wd1lQbkF1SmU4WTl4dTBqdmxZb1hqS2MzakZHL2FLU2Fuak9E?=
 =?utf-8?B?TFpXUDlSUE0wY0FDNWFUY3ZhVnpndzN1NDFoREZoUGNwYzJOWFZwRDhMWkVa?=
 =?utf-8?B?dGJBVU1nU0ZZTEZtSTdMbU55WVluZ3RJWjNlOHJLOVF6U2dwT05YbU9BeXVL?=
 =?utf-8?B?SmVvektCcEg3OXlPTStMbnhWcFh4UHpYeWwrYlRGdGsxZ3JEMEszalYzNU9K?=
 =?utf-8?B?c2UxWjFNYTUrbFFKdVkrMnlaMHpJK0srdks4NER4L3l5SHlYQ3JOZ3lUcnN3?=
 =?utf-8?B?UnprSFoxdzQ2dk1vblg5cDd1UGk4emJ1Ris4QnRkbTBPZU1jM21QLzdTWm4y?=
 =?utf-8?B?MkNFMFc1T0RBcjQyLzRwRTlUY3J1TENVSGFJMUh5aklCUEluWDdsUGdRaDhV?=
 =?utf-8?B?dFpVWEljTmlKVktpOWxuaVMycXVVQnRySVZqN3lpUjdXczEzcGxBcDUzVUZS?=
 =?utf-8?B?eHQ3aXhLSDVXQVlsOHpZaHpOaU9ndFZ1RU1KVGNzSkdtQnNjakVZSWFTZ2R5?=
 =?utf-8?B?dHdnSHlJNTVKeW0zYjh2T1cwczZkSC9ob29MVVU0NU9PWUxaU1YyRVRaOVJJ?=
 =?utf-8?B?NS9RSXdmWFoxY2hxSDZjdmlMbTh3bTQrWXRxZzRmYzYxYVdUNmJnVXo1T1d6?=
 =?utf-8?B?YnB0NDI5RnM3WHZwanAweTBkYVJKb3M3RTdlY2FiamcwM1I5VUxGNGV4ai9T?=
 =?utf-8?B?bDdDZVBsb0NRS2RYOG0zZVNKbk5XZVc3RVN2eG9nMDRqK1dsMmtvZzhjbVQ4?=
 =?utf-8?B?RitzNkZFUVltVmxXL3NQQlZIMjlmQTNyT2IxYlBQUVpyR2Ywd08vQVU5OVRk?=
 =?utf-8?B?Y2tNU0ZvYUpJTTBBTTRqVExGSFpFUTljOS9IMkJXVUtCc3dsY1FpT0xLSysz?=
 =?utf-8?B?K01lTEpESnRncGxOYlJhRW1pL3hRTlZTR2h6Tml1OUpseWEwKzAxVW5mYlZH?=
 =?utf-8?B?a2YrVUtiaEx6OG91SitpQVV2SitYYkxtYThWZlJxRUI0Sm5Yd2U3MjRMUkZq?=
 =?utf-8?Q?vvcI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520c3e4d-4506-48af-5e15-08dcdce37fec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 21:54:44.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlH/YPmN1kfSyRt+S4CqWKmm0g+BCZJihXm89zcF51eYFl4LBlP1FP11v8GfzYgsKdkI7IYT5kMYkntPnlUC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

Introduce `for_each_of_range_untranslate()` to retrieve untranslated CPU
address information, similar to `of_property_read_reg()`. This is required
for hardware like i.MX8QXP to configure the PCIe controller ATU and
eliminate the need for workaround address fixups in drivers. Currently,
many drivers use hardcoded CPU addresses for fixups, but this information
is already described in the Device Tree. With correct hardware
descriptions, such fixups can be removed.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
 └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
0x7000_0000 │         │             │   │  │            │
            │         │             │   │  │            │   PCI Addr
            │         │             │   └──► CfgSpace  ─┼────────────►
            │         ├─────────┐   │      │            │    0
            │         │         │   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
                                │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                 <0x80000000 0x0 0x70000000 0x10000000>;

        pcieb: pcie@5f010000 {
                compatible = "fsl,imx8q-pcie";
                reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                reg-names = "dbi", "config";
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci";
                bus-range = <0x00 0xff>;
                ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                         <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Currently all function related 'range' return CPU address. THe new help
function for_each_of_range_untranslate() can get above diagram IA address
informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/of/address.c       | 33 +++++++++++++++++++++++----------
 include/linux/of_address.h |  9 ++++++++-
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..09c73936e573f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -787,8 +787,9 @@ int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
 #define of_dma_range_parser_init of_pci_dma_range_parser_init
 
-struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
-						struct of_pci_range *range)
+struct of_pci_range *of_pci_range_parser_one_common(struct of_pci_range_parser *parser,
+						    struct of_pci_range *range,
+						    bool translate)
 {
 	int na = parser->na;
 	int ns = parser->ns;
@@ -806,11 +807,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
 
 	if (parser->dma)
-		range->cpu_addr = of_translate_dma_address(parser->node,
-				parser->range + na);
+		range->cpu_addr = translate ? of_translate_dma_address(parser->node,
+						parser->range + na) :
+					      of_read_number(parser->range + na, parser->pna);
 	else
-		range->cpu_addr = of_translate_address(parser->node,
-				parser->range + na);
+		range->cpu_addr = translate ? of_translate_address(parser->node,
+						parser->range + na) :
+					      of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
@@ -823,11 +826,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 		flags = parser->bus->get_flags(parser->range);
 		bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
 		if (parser->dma)
-			cpu_addr = of_translate_dma_address(parser->node,
-					parser->range + na);
+			cpu_addr = translate ? of_translate_dma_address(parser->node,
+						parser->range + na) :
+					       of_read_number(parser->range + np, np);
 		else
-			cpu_addr = of_translate_address(parser->node,
-					parser->range + na);
+			cpu_addr = translate ? of_translate_address(parser->node,
+						parser->range + na) :
+					       of_read_number(parser->range + np, np);
 		size = of_read_number(parser->range + parser->pna + na, ns);
 
 		if (flags != range->flags)
@@ -842,6 +847,14 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 
 	return range;
 }
+EXPORT_SYMBOL_GPL(of_pci_range_parser_one_common);
+
+struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
+					     struct of_pci_range *range)
+{
+	return of_pci_range_parser_one_common(parser, range, true);
+}
+
 EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
 
 static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..692aae853217a 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -32,8 +32,11 @@ struct of_pci_range {
 #define of_range of_pci_range
 
 #define for_each_of_pci_range(parser, range) \
-	for (; of_pci_range_parser_one(parser, range);)
+	for (; of_pci_range_parser_one_common(parser, range, true);)
+#define for_each_of_pci_range_untranslate(parser, range) \
+	for (; of_pci_range_parser_one_common(parser, range, false);)
 #define for_each_of_range for_each_of_pci_range
+#define for_each_of_range_untranslate for_each_of_pci_range_untranslate
 
 /*
  * of_range_count - Get the number of "ranges" or "dma-ranges" entries
@@ -78,6 +81,10 @@ extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
 extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
+extern struct of_pci_range *of_pci_range_parser_one_common(
+					struct of_pci_range_parser *parser,
+					struct of_pci_range *range,
+					bool translate);
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);

-- 
2.34.1


