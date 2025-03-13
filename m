Return-Path: <linux-pci+bounces-23655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DEA5FA2F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB64B880964
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841362698A3;
	Thu, 13 Mar 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBBqn1CO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57182269896;
	Thu, 13 Mar 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880355; cv=fail; b=u6BcbdJUY3GcNwoyC4jzjjj0rPxT7PEntJwl6ABSqaFmaRqpdLLJ2xYAfWMh2bfVtEz36cZu0o7Y0dmQV1v6kWktNc3MnMRy+BbZwXoSf/AFMXComaZl8yB8h9LoL2hG6ce01wfJiFFTx33xrAhrQhVWSMkuYs733KOuEmC4XhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880355; c=relaxed/simple;
	bh=k9jjAZXXya2Q8DdbpvyP5IdKBBPjl1TDyYEBtX85b6E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XSVKnctgZawwT9qT5L/WUyZi3BSwlYSQLQgeP7EzonBf+JKFyk7lsuKYdsrGvfIEwNKCWi4zSbZgHimm5XkkOVQM7deyu6FGOwHzxndBeBR7J9GPjFWtbEWWLMi6V+v378yXNS8ZWV0pUjI2UBQYeuSt2UHji3wVDX2xgZN6758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cBBqn1CO; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SG2v+vrrF+StX4SZyS0d9IgQI9TvpaV50sInUW5qaRUMtIwXFxRmwsUFAw026QKSBa4ReG/Vdek8lyxU1qr2y2v8np2WHApMyjxqf/Pv8L4lirL9FZajpCWdhPo98pr1eQAJ7cO0wW9esg0jm1WQu749wU2Od77ccuEX/DuQrTXfEAGy7PlSaxyJbuKHjLHcjpKmwap3u9TmhqJAvjfrreMKsX2YDDhXQUADwDXwMEREBJET0ZsLLHOhPA7smV4BuyWxNpjGIgtdOsHfw2m6BapYxfCM4qmyUk7jAMfQDal6t52MxwZU7ylZiVgndn+5K5FXcueYGyFm+rK4AEac2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oxuv6bJx1270PTY+vW0lcN/N+3YYVKRePdGbD++6zw=;
 b=tae40nrLGW5NePmGLIgonI1qc1SIEtkEN4gcyBsmWba8+JO81S1HvS/3wUQ+Fp73RIYwYcBCGVmQc59AKS+EWLWRLOyt3j7Ci2ld0D+cGt65V2y2T3dsvczcWLY3eMzlsPyMFi6hp0HMrAkCGHfkzFoIjlDQ77ByVtLofWmRdgWjOJdLwu3f++7h3VF83jVVQU1pK7GrrJHD7U4yyeqfdeI0uTiw06UnzFp5eAzgsc6wX2zyyUxMv23GU5dYgSk80MVixQtunABkU6OdCGfwgxJOvOmkvdSsGcIJljH+2ARalHPxoD9WUC9R49Ioczi7+Qnei6Z7TVF+SdO6P+JXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oxuv6bJx1270PTY+vW0lcN/N+3YYVKRePdGbD++6zw=;
 b=cBBqn1COswX2LUDYF7WHfoV3cska7oa4mlPxM2UIfZl1tnih57LbXUiPOeDEBDSQ/L0y0oNaFII3bqg0PIjJG/EzAkWMr+7mIVuFsco+oDDv9UFqHxO3wf7vuinwz3GDO1zR1Yav4oniO4shSS/GNs/kegMLhW95yGdspmFkqbdKn9mbN9i7n0lV/20cycSh6DzLeJhNPpqNcrmqemVdq9gOT/Iiv8xMgVQnoxXdExPtL887icqIJzQN1/SDmoXZOoV6lYMP+zTM2G6O8jCQyGCYH1KqHoaOkXzjs5wyFS1/M9WlzQ8LAdbgaU51YsFvF/fEFuW5aa57TJRm/KFs2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:39 -0400
Subject: [PATCH v11 03/11] PCI: dwc: Move cfg0 setup to
 dw_pcie_cfg0_setup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-3-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=2742;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oTmyMZfU8537ytBOcf3bYNYM+J10fr3vTNA/77LnHNQ=;
 b=m/jPcHO21NiZcl4xWUhm/nXHSQNuM50MwSruWaaPH6o6DNkqoR1R3oSrT2X2SQcm7MXZ6Or0+
 9EVjGgHLXK4BoHK3VEoAYuy0y+NUGo6WGMhSW8H5H4iB7lGewKxR93L
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
X-MS-Office365-Filtering-Correlation-Id: 6549a310-2b5a-44ae-0c0c-08dd6245324f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVI2ZEFGMjZBWFZ4VlJneDE5cjcxQmZuUVhBZy9rOGlvSllpUGd0dEVBblFv?=
 =?utf-8?B?OGFTYWNiTlFMcjJ0NXI4WGhGUitUeHhqUW5PakZaeGM4bnZSUTNQK3lOM2lx?=
 =?utf-8?B?dGRmbUtWUm8xZ3NUd1p6NE5HaVcyUmtpSUxJaWJsbWlOenFnNFBkdmNVa05Z?=
 =?utf-8?B?Q0l1Wi9nU0RyMEpYRjlSSnQ0YjZKVTVOQllkOTB3NTd4MmJkdFpUbzMwdjBU?=
 =?utf-8?B?YkVtZ2xsKzFxZm1zQWlqR0g4K0tDTUxTUTZGcmhXV3owejBQZHFUUFVGRTdT?=
 =?utf-8?B?UlFvZld5TExySW9QREl1WGg2Yzh6MTlHbmhacjM4b2U3SVZEZDh3L21KaXJW?=
 =?utf-8?B?SnZvcGVYN2djeSs5aDZ0clFKcUZGbkFOakUweWhqSzZXajJUbzgrSWNiR2lG?=
 =?utf-8?B?ak52S1p0SGI4OWhRTnl3NnR0OWprUEw2TjhIWmJIZnRzYWZ5WTF5Q1hRU3Nm?=
 =?utf-8?B?Y2FHMzg3ZXA4d1c1MW0vVVhWT1RSazhWOThseFNsYVZ6eVo4NHZmdmpKd1VC?=
 =?utf-8?B?ZFZRbDIvT0JnSnJUVnV0YTlDbFRhcGlIL2E4VUpBZ1VSbGJWaVI0eGE5dkZL?=
 =?utf-8?B?MFBzUlJoYjQ1VmtvWVh0ZFQrSmRNSFNwc0JDemRhK1hVKzFLb05KSkpVMU40?=
 =?utf-8?B?dlgzL0xIdHBZZk4zY3lYQ2JYMVVMcTVDMnhYMlg4NHlHYjVDQTY2QW5SdU9r?=
 =?utf-8?B?YzArbG1yQnlkNDVyRjhreTVBdFJyaVBEQzFXT3Y0ZVkzbG5mcVRNYzdFakdC?=
 =?utf-8?B?Z2ZVa3c1bm5PQ1hGS0FrenlVQ3VtVk5wUEh3c1M1TnpKUVdWa2EyVFRaMmIy?=
 =?utf-8?B?TWR5aWhhZ0JaaDByZW5QTlVCRjAwcHg4YmQ3eHorb0lFczFoL2FjYmtxZG01?=
 =?utf-8?B?RnlvcHJ6YUF4VGNDWjVhL3RFTHZSdWVQZ01OSVJzYzlhVG01RVcvVGRtcmhF?=
 =?utf-8?B?SEpkMGMrSEFFRjlpWFJWdU9TQUZ2U2MwZUlTU3hhUVNUMWdmejJsRjVxTThJ?=
 =?utf-8?B?UkNJVGVuZmt5UGo1Z2xlS0ZjMkFCM3JiWmpBeDZGS3Zya2lzY3p3b3FjZWJW?=
 =?utf-8?B?dm5iWndMZEp0Yzd1cWdMWmxTOGFUMElpWmRnb2p6dVdGZm9GVU1lQXBQQVpT?=
 =?utf-8?B?UUpzS29tSmZlVUVkblMvSk0wQmIzaUFkeXhYbkRnUWNuc1ZEOEpkQTI3aStT?=
 =?utf-8?B?QzZ3Mm9GZlhXb0YyNU5hV0JFTmtsRDRsWCttUi95NS9OL2FLcmlDNzhrQVhx?=
 =?utf-8?B?c1BxZi9HMG9nbUJ1MkdZd1g3TmQrRFBFOCtQeERxQlBhWWthaFMzL2NxQXBC?=
 =?utf-8?B?MHhiYkFLQUt4SU9sM1NOQkpxQ2ZVWUFKMS9hMWNSL3dhOXZNN1hkWC9rMFBK?=
 =?utf-8?B?bnlhV0JWNFQ2TEFVZ1kySFNNbnRHVENqdEtUTDJZdFd0L1dWRmY0KzZIcFVR?=
 =?utf-8?B?VTU0R1g4SWwwK1QxSmc0K2hmckpjcGFaVWg0VkdXWXpjZTE2dU9qTUJqTjNJ?=
 =?utf-8?B?NER0dHZPeVVzejJVdDIreGtzQlV3SG03d2IrRFRCY0YxL1VEa2s3dm0zNEV5?=
 =?utf-8?B?M1RJNEpkbTlQTElveTBKOW83OVB6c25XTndsTVhmUHVVOCtETmZFdzVMaDMw?=
 =?utf-8?B?eVRkeGRySG0weGtIUFZFRThYbXRIUDZhY25EamtxdUhGRGN5ZGxwY0xoWVVx?=
 =?utf-8?B?d1NxR1lqSC9xR2Vjc2VEMnh6YkRVQWlxS1lHdW54YmdHQmhHWEVnLzdZMThx?=
 =?utf-8?B?Z2M3M29leHFUN3YxeUhTcWQyZTR1NnFwODR6dDc5S09GK3YralFKQkY2ZUM5?=
 =?utf-8?B?M3RKTUc0VU55bmxEOHl2NE1rVmJNeVd3TnVzVVE2Zm4zdUxJMEFuYkp5dlVy?=
 =?utf-8?B?VzRZQkJIekFQdUVuL2F3WHFzNEJNS2hoQlVPanQ1TEtrZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0dlV0prdlkwTENWcU45c05XVmplV0tGQ0dmdEp3MzJUQ0wwczJVOHFkV1p5?=
 =?utf-8?B?MlZFRkQvSHdtTjJ4eFAyOUdraUZPT2xvK1FoTUNuNjkwSmE0VDcxcFVaWlBD?=
 =?utf-8?B?QnBqY3NEYlRwanNtM0tNSHJsT3BOQnFpN0o2OFBCVURnTCtUOFFKTlJCOGFR?=
 =?utf-8?B?UUZXcCsvb0NJWW8vTlFxcEFBeHg3N0d3UmwrRkszR0FQQ1JlSU82R0UvZXBG?=
 =?utf-8?B?cDNEMHIzb1NwRlhWbWIwV1hOWDhPbyttekpudEJjWlhMZlF4Q2trdlk4cGJH?=
 =?utf-8?B?bVBqdlo2dEl6aGwrM1dzRk4zMzcyNDFHUUs5dnBvbHUrZVZaRDZFNDllYkZN?=
 =?utf-8?B?b0RDV1pTWDRVd0o3SlF1ekpLQWxFelZRaGRYUGVQYWRjZEQ0ZnBwUEh4L2V0?=
 =?utf-8?B?M2ZhRzNtN0FUL0pUcDRaSHVqZHUxaEtIb0tYMUpoVkRsa3g5REJmSEVwejlS?=
 =?utf-8?B?bzFrT0dpSHJPREJwTUxLL1JvcVJ2TjJZbXlTQXF1S2owTEczSGlIemtqT2xK?=
 =?utf-8?B?a1Q4eVNhc2pUeElkcTRhSDh5V1pGV0FuTHNPYXUvc3hMRFh6U255b0d1b3JL?=
 =?utf-8?B?ajhHUjI1WHBSVys1amZnMEtXUzBPcHIybGtzMEtJNTAvc2YwbXZpN2Fvcjhq?=
 =?utf-8?B?MEo0N1lySXlOODJ5dUE4NS9Pc2NMMkxuWElQQUhJekI1VEp6QmFyMitMd3Vu?=
 =?utf-8?B?MUZPWXJ2K3J0UU42MHhoT2Izem1LVTV5dmlabVFmVmIwTkhNU2ZEeDVEVHBG?=
 =?utf-8?B?S3U0NGpQVG1iL2xsM0pEbjdHdlVMblg4Z3NubGI5R3JpQzRLeGtDbHFXU1Y2?=
 =?utf-8?B?eHVKck45NFptWTEvZG11M2M2aHZSZmU1cHhHVGR6V05CUmdQVW0xd1JRK293?=
 =?utf-8?B?QXF5Vk9BRHFTOUludWtBQW1CeUJwNlc5VWx3Zzd3RE12TmVUSG1FMGJsZjh6?=
 =?utf-8?B?SFRZKzNEOGl4NGdvNGlXY0IzSFZkLzV3VnZtSkdHa29PT0FxMVhHUC9HTVQr?=
 =?utf-8?B?QUtKVlBNSmdjWlFjQ2g4LzhSUXRQcjE3MEZ0Wm9sVVNBWjJGYjVaVys2d2RF?=
 =?utf-8?B?bEFzUjNVTHVxWGd5a090Y3hCb1ZHYkg5bkdvdHFsWUU0RHcvOUNyVmZxZElS?=
 =?utf-8?B?K0E0MWpBd2JiSW91dWxFQzlYdktNVlBNeTM2cEpFc3IyMEJpYmUwWTFESWds?=
 =?utf-8?B?ckdLWFJUS1VyQjN5NEtveGtnZ0NSdkk4S2hNNDd1Zk9CeWRpYlhUaDRjandG?=
 =?utf-8?B?a09KQ1VrZDgxajA5RkhyL3VSajRleUdxcGE1ankxWXhOQXVFMjJ0T1BlNXRK?=
 =?utf-8?B?LzFreXR0VDFPaUFUNHBPVlhkNWpvbFZySXQ4QWFGNWRnVHZyVnNmRlBLRGRJ?=
 =?utf-8?B?NTBFVVpDVjJJQ2l2WFk2bXlzR1NEMWFXNWJxR0tzWlZOdzJNL01pN2pJaDBZ?=
 =?utf-8?B?S1VMbDNxalVSemMvbTlSQ2UvbUl1UEF6SFNEZUl5OExHL0hoUGJ0UTJGTW5U?=
 =?utf-8?B?YUlNRjc0S1dzM3hjd3lCUDVlRnFEd2NicGVOc3g1b0FyRTZYRTFObnNPVXFG?=
 =?utf-8?B?MzNVcWdDK0VXL2d3U2Y4cnQ3V2kyYVA2K2d4ek95WERGL0pSUWJSQUhQMHpB?=
 =?utf-8?B?V1hLdGRJNXY5NmtDd2RTT2J3RU0xSkpxdDRvRjJaYXJHbW9jdG1WZlNNanFi?=
 =?utf-8?B?QW52blNLMFk4TXZPN2dTY09rUkVDaXVGbGh6cHdVYlFOdEVLU1dXd0JyYTFN?=
 =?utf-8?B?MDdjbnQ4MDJWbVRrNVRSanFvczJ4eW5ZWC9xZWpjVkZTbitnaDFXUXk1TXZC?=
 =?utf-8?B?WC9kd1JJVWJVUExNRGJIakxhM3hpRkZmd2l3YlJPQWdIcitpU1ovakc1Y3d3?=
 =?utf-8?B?SlVsdGU1YkhTZ1o4ZjdNWDUzOHppQ2psUDFCRFFacUpheit1aUFzSk55emF0?=
 =?utf-8?B?WHhOMFFDU1kxeHJ4a0ZrUXU2RmQ1NXlYWnJ1OWRLTEhLOFQ3UWc4dDBhSG1P?=
 =?utf-8?B?SlpLcCtqZTdScjYzR1U3MFpJVjVxSk02R01RK2pWRy9nbFpTby9BREJVZ0o1?=
 =?utf-8?B?cUVhN0s4VkozY09ndk95aGNCdEd4SjdNMTJyN0lzbi9Db0UwUFFKaU1xVitl?=
 =?utf-8?Q?97Ouu2L2FX00dMxUwbhTMGjwk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6549a310-2b5a-44ae-0c0c-08dd6245324f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:09.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZn5L74T7wIOtZ4xjQL6IZJJfNrVpu3GA6iLfG2m3h7Wni2QCZiGGzkdIGiQzO7B8yVoYSJ1C3Oi+vW7QkZZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

From: Bjorn Helgaas <bhelgaas@google.com>

Move pp->cfg0 setup to dw_pcie_cfg0_setup(). No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v10 v0 v11
- none

Change from v9 to v10
v9 means https://lore.kernel.org/linux-pci/20250307233744.440476-1-helgaas@kernel.org/T/#maa0134c1826bffcccab6028c7732a13f7adcec4d

- move dw_pcie_cfg0_setup() ahead of dw_pcie_host_request_msg_tlp_res() to
nice git diff and easy to review.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 40 +++++++++++++++--------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1206b26bff3f2..c57831902686e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -392,6 +392,29 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!res) {
+		dev_err(dev, "Missing \"config\" reg space\n");
+		return -ENODEV;
+	}
+
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
+
+	return 0;
+}
+
 static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -423,10 +446,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
-	struct resource *res;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -435,18 +456,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (!res) {
-		dev_err(dev, "Missing \"config\" reg space\n");
-		return -ENODEV;
-	}
-
-	pp->cfg0_size = resource_size(res);
-	pp->cfg0_base = res->start;
-
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
+	ret = dw_pcie_cfg0_setup(pp);
+	if (ret)
+		return ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)

-- 
2.34.1


