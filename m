Return-Path: <linux-pci+bounces-13660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED598AC4D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297FC1C21B54
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F6199381;
	Mon, 30 Sep 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bYba2D6+"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC27192B88;
	Mon, 30 Sep 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721923; cv=fail; b=Exc6Z59Zs1sFxTSKVBW4ECCzLQg2ZTBwresscVYzCxpJfLprbYcV4ZVR4IdBJiua//aOx8LOmgDA1ct4noT7gCtWKe/6T4+AFltq1VEpNPF77R4dEm4yV9AbYx+vD2h+EmmJ9KFbDEKynSAjnGe9TgERbr+RF/J4hzIlzu/gT5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721923; c=relaxed/simple;
	bh=MJ/EpQBArZ7D4L3xDn4c6F2C8fdgSVJoocAwFLKtG24=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WJQvWYzRZiW7Jg6+ekKsm9AODqs2oLTOujLyoYXmVdpukVst95soZL/YSBqY4fTpi68LRYOTRPoILCbTpNHfUnzjFdRieEWLfWouyctTgEobQLdouLrTvD0jCJx4o1gxmtXCUyMAqCd2uvIeKSLLJS/COMXu79+FBKkS1qXyd6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bYba2D6+; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFsxzpjoEcuNeTNp5Q8ebjK9MLUHWXDr4fVtk0u6nmBXBcmuWkCEWmCU8ny3dQtKnfzJGm9aWUHhj1T3emIqCR9Ksi82BVKv0hITxOa+U/7LB/aKdJ7PIC8qQq1AyCgOwWuAgJtKg+Xz7aMJtKKj4FZl0ctNDHY/D0BJqk04OZx82OzVsjZ5ivOt4S3n1EI44Vj0tOF4pjagyCe4piYYKq/pkRJP11JYB0l2dS9ch3yHIQGdhsGeU7z9lOXIu7tPsMJ0lr0NBvAcjbA2d6zboMDZJYow3yuDiIXvRDCfPlLIwBdtBbif1Wu55dqNoKKRTFy6TK4VP1YT7zVTq6JmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uegrPoJkOOTCjxRwuT+0ynal28Fn3rOY8mZJoLKu+ds=;
 b=YEZ5iC7EnjMXcVgIepghlqV66e6HODCeETCRbIFXtGk2Y1/od9vqRdkmo1J+UDM3AL2KeSy7IxVEyNsUKuOPx0spaPiexWkvDoUZOCnHfaO7oR3WdmuFut/f1yp/soz8GHqee1kc2kGzTDtHYFjcyjkl+hko3q5vtYTty1Hbfxwfsmwx3suyUOyqO5GYTzetxEXGFA+Q4F5+p/Cwe17RpR8/BMCNXTy1rDFNBNM0H8wpV2FZXzalnOv2nPJK5MeiPg5zlYQo55fALW8p63+18QcMpn9Nn+/qsFa5nLX0AXGAwtiXTVuTfV3daTrVtLD3tbAndG0hAk/DgbcpEu7hQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uegrPoJkOOTCjxRwuT+0ynal28Fn3rOY8mZJoLKu+ds=;
 b=bYba2D6+lB8f7dz9k2mczapv5ZvPYJPsx2n8Jq2b59NIB8gK5GR923qQiPbdUWzsVLLmUaUsA8shFYUlBQQQNjmHxec8DKLPLq5ARuT7S/dBWfKKeiGdXNzuzY/EpGglsIHklc3wginPpP9jtiOCiKhfknUduuLbg4FBvrKvLH/twaMQCvWB5feJ01LujvfGRVVmSt7GKtR/u75aXkAguo1PKFNTl+Vl5EcmCBqesDOfb/rUMvWrxErEOXVMm87PoYRcEDuKBGEBTNEV1djZ4ILzPZ3ZlY0Q/0RRu4MMVxTOhpnj58733cXGjIdJ/6g/mfgUuLbECWWg/J1Td6kFEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 18:45:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 18:45:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 30 Sep 2024 14:44:53 -0400
Subject: [PATCH v3 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240930-pci_fixup_addr-v3-1-80ee70352fc7@nxp.com>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
In-Reply-To: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727721910; l=4395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MJ/EpQBArZ7D4L3xDn4c6F2C8fdgSVJoocAwFLKtG24=;
 b=N9wt+sjsYH0aNxUchyB2/qwmvNKReH4fMw6NrS5h7gtG8h1pnr7Yjh5fl8mYeK6oRfXDGmgxA
 ukzU91nT7rHBhOZmTlErkJB1cq48pr7hidjVbn2cAaivKRtCzjBts1A
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dabdd97-73ca-4b92-512e-08dce180086b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWpuclpMUHQ5ZEdzMWp1b0oxNHlHS2FRYkFCWXAxUTB0T1pNUjBBWjY0K0xJ?=
 =?utf-8?B?U2IyKytUWXhLRG5rTVMxZks0OUZJUWM2TEtXbUhmM0RHYUQwVkxTbjdYL0ZE?=
 =?utf-8?B?UnZtTEdMeWVMUTRIcFgvQk5MTDErU1ZkZXpLbHZYTWdKMmpvanNvR3Q3UTgw?=
 =?utf-8?B?TnU1R3FFVUJtTjRYTW1yZng1R2ZhenNRTVQvSU90SjhqZHBIdk44VVZReDlw?=
 =?utf-8?B?bWthdmFwMGFmUUc4eGt1ODB5eW01Ty9HL0hYZVpzZVBYamlpT0Zmd21yM3J2?=
 =?utf-8?B?QWtQVmNTUi9vZDJCSkROdWl0c3Y5OTBYNUcxTVg2cGFEVmw4blpGaGhWbWJs?=
 =?utf-8?B?clFwUml3MysxRDVPSmI2Z2VETU83a3Q4TTMvdGFIbEhpTXlTN0V0NkVNZ0d0?=
 =?utf-8?B?aVlHZ0N5Z29SWm82ejJVWEFHbVVwV2pKdW1jRTN5dWRodzNwN3lqT2tPdURN?=
 =?utf-8?B?YWNFQTNZNXE2cllpWkF2UXJVM09SZHh3N0RGc082bXR4RlI4Z2QzMm12SWJV?=
 =?utf-8?B?TXF0N0xnVjlLTTBWQ1IxNHNIL3BHdGxEYzdPeEVLOThtamYvSDAydk04RWZL?=
 =?utf-8?B?RmV3UzFEQ1FMK0FaTVNUeXExbDZKRGc2L3lUZXNDVVh4bHFkS1c0SmNJUkhQ?=
 =?utf-8?B?eFg0aFp3eHM5UmJPUnFWK0d1SCs5MjlvOFpTVDR3dVdNNXcreUtLNTBIUk5t?=
 =?utf-8?B?bFBPa2J0TFE3ZmVhakxKbk1nbFJRRUFLZ3YvaWdaZmx3UmJjejIrVjBScWZJ?=
 =?utf-8?B?bUJSKzQ2Y0p4L29vYTZpOEMxUGo2QVEzbVorUXFmU1g4bnoyZWVZTzFNeVNz?=
 =?utf-8?B?YW9iV1ZZWndrSVpXN3hqVktZYWtSeDd3MHMvQndFeXBCRXpiemxnZlVjcU5m?=
 =?utf-8?B?YXdkSU9ucFlxc3QxYm9wclpRT2tCbXpublRLSHVyVEd3OWhiTUN2TE0yU3JU?=
 =?utf-8?B?eGsvZ09lSUI3UVh2OGNQQWs1ejQrNXBGejNiQi90M0lYUTRJYStyTkpCS0tq?=
 =?utf-8?B?WXVGdC9hTmxyYmtVQnUvc3pyeVFxaGpNdm5SRFhJb2xGVGN4YmxQUjYzUUQv?=
 =?utf-8?B?a05rZE55Ky96Uy9UM1owcExUQ2d2dERwUXNYM25EbnNUeGhKTG1oVlZYbkx3?=
 =?utf-8?B?OVhERmdWSUFEM09tM1d4Y2JXUmU4VTlaQStueHQyQ0lYYk4xS1ZsRW54VWgy?=
 =?utf-8?B?Y2tOZnNWaWxuMzZHOFdlZUc4K0d3cTZqSlVQRHp5OUtZZDNRQlhFWTVldEtm?=
 =?utf-8?B?SXdGcmNieXR3YnBIVjRicFp6ZCt2eVJ6UzYyWW80MTkrTG5Tb0NERm8vWmov?=
 =?utf-8?B?QWQwNzRPRDFXRTNOR0RXcXM3STV1blRCQzJ1Um9XejlNdGpNL2t4b3NpTUZy?=
 =?utf-8?B?SG4yNWsyZnJEaUhVQ2c4SXR1SGZDRlAvK3FKdUl2TEFHaEZVOUZkUTFaYVFG?=
 =?utf-8?B?dDFVNEFZZlF4WWJBVUE1eXJxdE1welBKZ3JYT2UwZEl1NGk0b2o5bFlBRS9z?=
 =?utf-8?B?U083cWhoQnRRbXFXWGQ3QkZ2QmtrUDBJTmRPbkVZTkxmNEVIOENnbTl3KzhG?=
 =?utf-8?B?ZjF4aFRkZ0h5cnFuZTQyWVJmZFgxWnp3MFV0QXdxam83R0thcGhwV2YzenRN?=
 =?utf-8?B?aU8ySVBtazRsSmJ4enZaWWVxdGNCVW03aWJLdElKdk84NkRsNDFBSzZEMFBD?=
 =?utf-8?B?SEdyZEN5TmI5R1V4YUtLWVFxWVJaOG1xQml6U2tYVTEwUGRhYnMxSDBUdE5q?=
 =?utf-8?B?UklTbkZRaFFLaWVVN1dpQUZ5ak9WL0pkL3NuUklldVJIYW8rN1FWaXNzYXNm?=
 =?utf-8?B?VXFuSkFWOVByYXJUWTN2dTFhd3JQMGdwaHdoQThDK1YvNnhQdGlqT1JKaU1K?=
 =?utf-8?B?bEVtMmdHOE5yT1NiVXBqZTdjR1E2SWZJM0tQOUhzeXpJQVo2WExrdE8zMmNO?=
 =?utf-8?Q?2NcY3bkonng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1VsWGhQUC9odjBEYnVINTd6OEdRMmU3RVBYN2JVNUpCRDRCdzJ2UDRRbVJh?=
 =?utf-8?B?eTBPeDk2bVFxK2FVNW5jUmYraDNGdzFpRld6RDhCWUVjbmQvKzRSSHpVdVIw?=
 =?utf-8?B?anhHY2ZuZHdmWmllM0YyL0FxQkpveEJ3UVVEMVlzK2hldGV1N1NoZU5sK0Jo?=
 =?utf-8?B?OTNhTTM1ZVMxMGFvREtuQTc3UVNUSXhMNE9yelpZdUdLMVFKT2wycVJzRlJz?=
 =?utf-8?B?ejcrUjBHSzREbHl1NXJjUWRwYy9JRnpodGdDWGNnb2U4OFFDT3FMR2NnN0Q2?=
 =?utf-8?B?R0dNbXNuRGg2bTVkMVJVYjZ3ZUpsQzByVlQ4OFZxRWpVNlpxN3R3K21sWjNB?=
 =?utf-8?B?YlE3T1I4WDhFT1F5TFNHZTBmald0ek9LS3ZhNEZQNG9ML2xpQkFHNmN1dzdW?=
 =?utf-8?B?U1d3SDlWRzVRcmFTUld0WHRPRHYrNDBjdlRYS3BlSys1eS9LODUrRC9TWTJC?=
 =?utf-8?B?eDdvL0s3Mmtpczc4Q3crRXRoZndNazh2OGs4S1M1bXpyS0JORmtORW5uNFFq?=
 =?utf-8?B?SjAyNldhYWw5RlFSbUhqSXR1T0R6N0lMcTY1WnhqK3BTL2pqUldlcUZXZVNE?=
 =?utf-8?B?dktTM2o2TGlwRy9tZ2lqR0prSzkrWjNSbDRkM25iTE9DRFQ2NEh2ZHpiRmZz?=
 =?utf-8?B?RXVzVmlhOUY2VTlRQlBWY3VDN2tIL2NRcnR6dzMzbCt6KzlxcFNlQTdrdFht?=
 =?utf-8?B?RE5vZkRxWVB6MGFicVBXMGVodE1jWHppUGQ1YUx2UVFncDdkMHgzOVEzc2My?=
 =?utf-8?B?MTRCTTFTTnlVakRmdXgvOGtCcVdVRjF3b3BTM3ArNE1BRTRicXVRTmNKSjZM?=
 =?utf-8?B?ZUs2TEFOZlZKcmduWENacXl1QzB0ZEVqWDVPTS90bjFhaUNQazdJbnF4Vnlm?=
 =?utf-8?B?dWhUUllHM0Z5SFN4d1dIUVZxYUovZExiTFpSbFBpSTdJTmFoa1FEZ0RtVmV1?=
 =?utf-8?B?akxrcyt2Q0tQNWJUM1pYNTNiZGtaY0tXZmgyS1BjYllPdjc3MkVPdk83czdS?=
 =?utf-8?B?UDVoVVZYV1hiYSswY0NKbEI2T0JoTEp1Wm84ZU5TUUM2d3hXM00wRmY3VkFK?=
 =?utf-8?B?RG9xcDF5RVRFMVRWejBPY2cyOE5pTGdwUXhkUndKK1hBa2ZkUnBuU0FJMEFG?=
 =?utf-8?B?RENqZkpQUkpQbkhGSXVaVnlCdnJMN2kyc1l4SlZjeTFoL21nMzlFdGZROFBR?=
 =?utf-8?B?aTNpRnR6eVBIbWNkWlRoRXhHLzNTcXJ3OXRrRWNOdVJPL2NTRTQvWGd4MTBP?=
 =?utf-8?B?dDEyOUhaQWRvZHBWSjRPT1RVVmlxQ1hWY3dIZlNXVGlFRzNtOG9tbDhLZTRS?=
 =?utf-8?B?alI1MGlXeUdGYXV0MTlXWXIzUDJlV3Y5UzQ0TW0rc0lmdjZneW43VVBMV21l?=
 =?utf-8?B?U28yVjA5ZUQrNzJBYzFoa2hMK2tCOGJPUGNHcWhJcUVURXRZTkFxb0xtTWdv?=
 =?utf-8?B?OXhoaVpBci9pQm5tT0FldnB5OFk2bEgxMkFtc3h1R0syUmZhVWRkcStCT1l6?=
 =?utf-8?B?MlNBZWNNek5DSDF6YVdvblJ6cHpwSVl5eXgvZ1ZlMG96THF1QitLNitxWnhZ?=
 =?utf-8?B?b1F3STRBVGxOV2NqRzZ3OE9BRzhLZlBCYXcyZnlmQmFEOFZtWmw3WDY2WWVS?=
 =?utf-8?B?WEhiTkdYd2kvdFF3QVN4SEhRVitraTNlVFBKU252WlZqZmhZQ0RzTkM4WUp3?=
 =?utf-8?B?ZGlZcmNoSExsOFM5NGQ3U2lDUFEycm8zbFFqc0w5MFdlU3NRV0gwaXFuRGQw?=
 =?utf-8?B?djNTYVA5S0o4V2hlYk9kUWhibmlKdUdmekkxVFBNck1CTzF5RThrOTNSM1VU?=
 =?utf-8?B?dUI3c3pXNkNSUlVrZHJsY0E0QUhXaFVZTm82NERKZlhQUkFDL3gzSGRoQjZD?=
 =?utf-8?B?K1R2MHpkVVZSK3dOaVpBckhvcm56YnJZUVhHd3U3cks2emZWNHpDbUM5NGVM?=
 =?utf-8?B?Qk5UWFRoaU9hYnZLOVBQb2tURUZxWm8yZWE0ODZ0U0dCczdLRGdHemZRNkl1?=
 =?utf-8?B?dnczNFE5MEZoeU4xdDRHVG85M1dqVnA5eUVJYzkzTS9VZVQwaFdmYWozcS9z?=
 =?utf-8?B?Z1AwRi9nRlVldDB1TkMrT25QaEZuT1gvd01yOE1IbG5BY2JjTGx6dGxRSkgx?=
 =?utf-8?Q?TG9A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dabdd97-73ca-4b92-512e-08dce180086b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 18:45:19.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwao/uJ4BIH3qcpSmX4lFk1IMBsEenvsjvsRPb/Rhp4V5vHXqdAyUSeOVsRs26mqqRQP2Ai957M3prrTpLp5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
CPU address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many drivers use .cpu_addr_fixup() callback hardcodes that
translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR",
"cpu_addr + BUS_IATU_OFFSET", etc, even though those translations *should*
be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in of_pci_range.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff0_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
             BUS Fabric         │          │            │    0
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

        pcie@5f010000 {
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

'parent_bus_addr' in of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..1a0229ee4e0b2 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..13dd79186d02c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


