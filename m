Return-Path: <linux-pci+bounces-14003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E621E9957F0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0C71C21A23
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A3216424;
	Tue,  8 Oct 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M7d1AgAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6A215007;
	Tue,  8 Oct 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417287; cv=fail; b=CmXAfdI6d2ws/V5lMNUF+KDIBuVEjo1Nx92VpRjs6mJuY6NWyalpVH//hbuo6lHRQR92ud1BeG/aUCqSML2hkhYctvGK9xbHg7GvyfOtObhM5lSYE84L/JzzxjaXjrgVn9vYXSO5mTooTQ7g44qErhJsIKI8ISwhSvXtYxH+vE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417287; c=relaxed/simple;
	bh=MSaZLUc5PtP8YnYAS2wnuP2FJ1mAuEYhZZgffyYJ450=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fs77h+lWEmtaTz9vb+G4MndKynGMc+2C0N1fhst/S2I1dqWJCQApZCAHTd5DBczlILZavyMuXl+DSY3DSH6EM9/R92KHd6TUrS2DTr+fvk429Z0+9weMj3lktK2C9v0ce/N6Ec1s2SqlS472C+Nq6tziXm3a+z4v/KkYW+8Y+HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M7d1AgAr; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pygt9Dsp0bHKz3QMbU7AKJB2OYsa0Y/skkVDnvyJAgjj/wvRJfnQ4XoeQeBK/oMg4eLgJEVTA2ndp3HQ+V/dJYAm35P0zQ2IyA5JDp3A9L8K79lemppxGchQrpDZhLKkCXraC50NTxNhf8w7kGiVL3W6RpGFw3A8N9VHiBjvlYdZhToKnYX81ck6oWjHYBjf37BbJt38iJTkVDIlB7sO2dnuyvBlvmxlUJVYIkW5HD/nytSHokRaf2KnnzeJG+Q3Ih8oA4hiNnWNqJiCAkgWq3xOXDurQB3nKQEqZAJxTTl7Gfauu/cgy9/EG5g6SP+0FqNUlq9wnJ/CaOt894M/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXHYIwoka3iYigA8Wm0ay+xHwGBdoHK3DHRGpBMZUZ0=;
 b=TVTvqHVex77kYewmtiE3vSfPgwPb9eqdsSq6EnNqwpKFgFnlBc1LIMYQTTSJvDxEtX2kvTYPLP11kpPF4MGweVbubNYKqgj+arN1cDfSSNKJVHln9w61WbsuQYPQjGbBe3Z8WqZ5KYNqexuwg/81dlDhXaiU/n3NJJ3om3y3HuqU3IW9g74LH0cpm98wgkw0Etazrn1Wku5VUUDGNQ87MkVMLqiNTVxlulNaMWkrr2IFTLTyWwjjFTMi1LKVMPPyEO/9Cleqfwpu7aYQTLjf5oh8Camzazf99smRIWQn0DXWp5BCPytyXrnFzb71BrvkNW8ElHOL5lEbcYLhTHb0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXHYIwoka3iYigA8Wm0ay+xHwGBdoHK3DHRGpBMZUZ0=;
 b=M7d1AgArY3fSWzBAnzBN1GDkrlBjZjQtxUltB/xlHOV0IaNDaFeyeXCn3izOW1KwSLHviVoAJzfqOaR4XqAuJkB59JV1cnq7tD783WTW+ViWpMd1WVZn5y5NYGIdUfE2YuhlFNChRI6J3Wm4EMtYZZl5xT7RT1t2/GRBgBaxD+yIqz2dh5NwdHDOAEEeCbhfEIEUFzD3mYiSko0pdMMEBiGNnUna3w9QSUmTg7eBAvr20jTBTQWgsadB4vo5Th085OAWfOOXfoXWOkJiBoqUoOTWpeDjKsygF2VqidiE4okzygdK2PWoxUGGKVYZKBWkJCwe+TBfMWYlodYiID6Ypg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:54:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 19:54:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 15:54:00 -0400
Subject: [PATCH v4 3/3] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-pci_fixup_addr-v4-3-25e5200657bc@nxp.com>
References: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
In-Reply-To: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728417259; l=2455;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MSaZLUc5PtP8YnYAS2wnuP2FJ1mAuEYhZZgffyYJ450=;
 b=2BbU2aQgzOxJ1q4XsiXSgRbKVGk+ZRGBAI/9m1Nmljg4YUiqIrzbXe2gsNLEaPCgmlshWIC32
 Juf0XOnGXaWDIPSjMcFRUFLw7JCd/VjY3jiolhfnB7TfwFpXc2imZDK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d3e4b2-6370-4bae-2cb8-08dce7d30af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGtVV3NiS2hmb1E0eG41NnJlbUdZY1dkblRkcHJUN3h3U2pxeVZCaGpHdk1x?=
 =?utf-8?B?V3BMN3NSTUtNWGo3cldVUU00azJFNTZCanNoSCtkTmxsekRrdWQ0SHZGNFhT?=
 =?utf-8?B?SXdZeithcUZIamhmOXQ1N1l3T0l2clJybE1pTnJVenlXVDVpaUtaSTcrQnVC?=
 =?utf-8?B?RXpsanptUTBiazE1OVNDM2t4T28rWmZuTGEzNzIwMXU3SnoxaVlhWkRKalBo?=
 =?utf-8?B?M1ZobmtOL3FEblN1VWdXNytYUC9HZVhtVFVNZkgrcjVueWF4WkdtMGNVamVs?=
 =?utf-8?B?U3hIS0NzWjdSVWNzcXhUeFhsbVJXVXA0bFBIK2FHL3VIcVlzMWRTVWdVcVFN?=
 =?utf-8?B?bS9lbXJ4NkFUcm5YcVZmSVhlYkM1cWZkTGtBeU9JMlptZkFXeWoxNzUrZU1h?=
 =?utf-8?B?YVdzSHFRbENVT2Z3d01IU2JRdTVRbWhEeTFYRm0zclQzSW9OMkZwL0d4TXNX?=
 =?utf-8?B?cGtnVy96aDUzbjdTcW5jNDNKc1pZVW45bXlwbG90aHhQTGRIa3Y3VlF4MVlo?=
 =?utf-8?B?VWlxaG9WTVY4ZW1zN3Q5RjEycGQ3a282bmZzY1NVMFNnMzVtVS9aWXREUVNl?=
 =?utf-8?B?dmtSVHVNcWRQWXluUFZxV0VKTXVoNGdXUTlKWk5UNmxjdGc4UlBTNEMrYW1E?=
 =?utf-8?B?YmJWR0FqcHgwQXE3TWxLZVNXUEhMOVhoK2lHeUswYituRnBncFJvaTdXS3V6?=
 =?utf-8?B?NkpNbStqN0V2VjVLaVFpbE9HL21ZZ2ppamhPRkhBRjdId2ZRNWY3c0V3VENv?=
 =?utf-8?B?QmEybWg1dGN3a0tkSE5LM3dybzZ4T1pMQlZ0TUNpZXBXOTMrcWdsQ203WU1l?=
 =?utf-8?B?MEdFNEZLUHFBN1ZnMktnS0FPZWtJUVJyK0ozTitYcTB0S0RyS1dpWVRsSmVr?=
 =?utf-8?B?TFBOUmZiY1BidTc1MEwwT1NFVWJpZS9IMjg3KytwS3JGNzJrWElzb3JBakUr?=
 =?utf-8?B?U2lLeHdEdWhwdWk2cXEzaXlrd2lMVG5selZCcGNwVkJQUHFaTExOdkpsZkp4?=
 =?utf-8?B?RWJiWHR5YzQyamJkeFB6RktRYVNXeUNJOUdRTFdMV2JDWlRtcWhGVWhYclNP?=
 =?utf-8?B?WDBIWWF0b21kUGR4VjJlNmtzTnREbytzY3E2WW5SOGwzYy92OFI2K1dUMnlz?=
 =?utf-8?B?VjlKU3VibGtJaEwzbDcwaGxYcWgzNWVJcDFqRHY1Yk9mZEdBSDlLZEZFbmdO?=
 =?utf-8?B?VnVTYVlSQVk3K3l5ZmUvZ2FqSHdJQk1uczB5MnNNQTlzUmsydzN0UDQrd3lq?=
 =?utf-8?B?cWE0TmRzTkxaaWtscllSU3lBUVNXM3NSZE1IN2kvSDI3Q1dMYTV3SDZZUTNp?=
 =?utf-8?B?OGtnVjZrM1BadWFWQy82MTBOMHFLdFNzeWVWUzVqQVpYM203UmVXRkE5dzNo?=
 =?utf-8?B?QUxZS0JicDlrSzl4Wmk0Tk8zT0hyVm5kMU41V0ZGZWVKSDhncmlmWXo4R083?=
 =?utf-8?B?Sk1kckVZZWRBazhoS0k0aUxiRzBoVWpXVFRDNCtYblVoOUJEUFRrS1ZtSVN6?=
 =?utf-8?B?RGk0eVpVVzZGWHFDTG5yNlBGYTJNMzFKZ2tiK3d2S0FZeWlVNWt4d0hwOG5U?=
 =?utf-8?B?VDJBOTZ2Nmh0bm16a2kyVTR5aEpWYlNnSkkrRnlIblo1WFRCbldVb05Kd0Vu?=
 =?utf-8?B?bEVPckZHdVRqam5halVSTUt0UlJiaEF2ZUVWUkd2QXgrc2JVNHZNMTdtN0lH?=
 =?utf-8?B?REVTeWtYdGhvUWVzZGZTRUE1eG9iZkVmU1B2OHRwbFk2azZPSkw3VzUzT1hK?=
 =?utf-8?B?UTlsVUFuQUR3aGt4K2pJS3lRdGthSnVFanl0WTdnUGs0eEc2V2xKZlZrQThH?=
 =?utf-8?Q?6/fifYeM3176yVtjH0YTIDCxEhYbYhvBk+sKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVZTcDd6TkRqdFRYVmVkL1NZT2l4dGdsMXNndHptdjArWVVRWmRtL2dHVEdB?=
 =?utf-8?B?NWdTazNhbXlIVjRLS3Bsckh5bVBhQzE5ck50YjhYT2xURFUzNjNOTnFmK0xD?=
 =?utf-8?B?aEM2T0Z5Z3FlY1lhdVEzaFpoY2MrVWFPRFU1OHZyZmJZVUkveGJIaDFUb041?=
 =?utf-8?B?UUxrOW4rckZLZjhaWWxrRnh4NnRTdWUzcjU4OXdKUlVxbjM0OE4zd2orbEgy?=
 =?utf-8?B?cWY3UndXUU02Y2FDTkxQVnRNY2VGalp5UnJpTGhCUUtlaCtpUzZUdmw3U29s?=
 =?utf-8?B?TWkyNVFELzVHSXhOajMxOEM5YU53ZmNwSU8zcklXN2Y4U0UvYTFuRFFrQi8x?=
 =?utf-8?B?SXZxaTZUSjAybk9QeUFZSVIrMWNsd0JyMVpVSmtBMVh4cWZDWWNyNW1XdW1w?=
 =?utf-8?B?SkdqSXFBczJTQlhpVVhhMHRuS0M4OWJVeVIrV3lSQ0NwT1M4YVUreTFzbm1S?=
 =?utf-8?B?M0w0UkZRSXhUZWgwT0N5MktmOTFwT1o1YWlPZUdvSXFDb0diSkIxWFJaWSty?=
 =?utf-8?B?MjF2WVA1a1JLalJaRWhKcFR2WWI0RnY5SmxmV1RIT2NKMGlhVjNkNUMyR3hB?=
 =?utf-8?B?bGVPaC9OSzJqa2xXS2xIeVFyT2ZmbWdFbGNkK05mejJXMmR4L0xsT0NiQWpL?=
 =?utf-8?B?dUluM2cvRkk2TEVkZHhhazZBWEUwRUh6UE94aTdydkJHOWgyRGRRUjhVVmw4?=
 =?utf-8?B?VmtwM2lvbjNrem0vSnh2RHQ0YUFEU0NvaVB5SzdFU2xodDM5OG1WVlJCa2k4?=
 =?utf-8?B?Q0dxNlRSaFRHZ3RDVWJKK3Y0SFFxV1NEQk51NDhrYVFaRzQyTDYwTERCUFpo?=
 =?utf-8?B?cUxNUzVRR013NzdHMkhhcFBOWlJGclBDbkYxeHlCYldVRnk5Z0U0RGEyK1d2?=
 =?utf-8?B?cnovcVJMRlhOZzFlT2xjWFpBSldwL3FHK20vbHN6bnNUZVF5bVFrK2M0ZmxJ?=
 =?utf-8?B?UzdVNmE4akV0dkxIeU5tam1WZXVQdkYzNHRzMElER25jM04yam9SWUtMcFpB?=
 =?utf-8?B?aC91S01WaFA0QlIyWDBnRDlzQWQzQWhqeTUzOHZGa1d1VXpST1NjWUwyOWhk?=
 =?utf-8?B?a3BWalArbFY3MHhzcEtRMHJwNEtMajJXdkt6Q0drVWxlRXZVOTlVS2syOW1x?=
 =?utf-8?B?OVV0YmttdTR3c2xDcFYzaWZrOGsxSXo4Qit3Q3NaaVYrYUpxTXB5MXVOMTBS?=
 =?utf-8?B?M1Z1WUNBV0lxWnBUV2pKcG9lVEswenNpMHNBSGw1M2ErMnkxeWtjV0pXVG1k?=
 =?utf-8?B?RG1LNWEzc3RNcWRxd2h1OWM4VDZ4QXdMNXdCSGdXN2pOOVJxNWVUditFajJx?=
 =?utf-8?B?a21iV1k2TXZkcVpqR0lyT25XOUZjTUJWTS9MY3Fqc09UU2d0RzcraXZtUDFO?=
 =?utf-8?B?VDcwMEUrSzhpNUIvWmRUZnFvZnNpMHVvKzUzbkxBa1ltUmIzeHNVRHdkSmRm?=
 =?utf-8?B?UGRIZEF5amZtQldYTlEzMlljNlNJRUEwc2pUajN3dnZzclFIZFVYcnBheGtn?=
 =?utf-8?B?eHlDSkNyTWJObDhNMFRnWGhTRDBlTVpUR3hOaDIwbVVCdGpoSWI5eXljWEhz?=
 =?utf-8?B?b0MycEM5MWthMFU3WWdDblprcDd1Tk94SXF3cXJGSW16eGtRNS81TnJEZ0x4?=
 =?utf-8?B?clFPUE5nRjNoQjFRRE5VclB1OFlKQmlVZlcyNHI5bGE3TnkzcUVtd2c1aEo4?=
 =?utf-8?B?aSs4TU05YVgrWGw1SFJQejcrbkFvRXJMQkVNMVlWZ2Nldk5OYmJ0MllnTFkz?=
 =?utf-8?B?QXhzRzBXSGZQbWVnZFFqdWhiekIrQklaOFg5dytBT1J4RjdNRFk5czFlUXJv?=
 =?utf-8?B?d1MzcnBxMXBOMzM3V0l6ZTVQMk1OVVpPakNydmVLR1Azc250ZEVPeEJGUVFG?=
 =?utf-8?B?VzJDSUJkSGFSYkpuQ3F2UkhnL09zenVxR3A1OFg3OGtLQUYyTU80RllSVW9O?=
 =?utf-8?B?aURweHNqTGp4NmpWU21BNVdUS2dTR0JkNVhJQ0dCbmR4WEFidGQ4N1Q0dUxM?=
 =?utf-8?B?bEs3QTQxajJKNWhWeWxEU2hFeE1MVHRLU1NKUGJrUkRjL3RoaHhKcGRlRUMr?=
 =?utf-8?B?SUdTTkxvSHlSM0VuVzNjQlF3c2tCR0JCTDJXbGtNbXkxRHpkclp5WVFWWTdC?=
 =?utf-8?Q?cUzfmc5+jOVj83/un8TiiGbyK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d3e4b2-6370-4bae-2cb8-08dce7d30af6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:54:39.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Nmtj3Z+h5FgNr/9f/Mp9YY3mXJFj+Sh1YD7pjTwvhpGtGrN3TyjFpz8NujOkJHD5NA/2wxZUTc0mLpWKmeK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v4
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e58c24137e7f..94f3411352bf0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,7 +82,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1015,22 +1014,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
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
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1039,7 +1022,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1459,6 +1441,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1598,8 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1


