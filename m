Return-Path: <linux-pci+bounces-23370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9FA5A4B5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B383A5336
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D121E32A2;
	Mon, 10 Mar 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CG8bi4YF"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013063.outbound.protection.outlook.com [52.101.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7E1DED58;
	Mon, 10 Mar 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637878; cv=fail; b=q6Jvt702pAG7oPZQXtDXgYrh4OJ4JS2YERJEdL9f/w21ggvUy1JAVGzqrXD2gQkHT+uo3o+OeBoEBxyjT3hCyQLjJk+alQXaMVYMcI3OQ1KeejMY3tKeYrAwyMoXsm0WXUj+3IDTBoDwgPXBMp3Ux2guJ6LUf+YkH5Oiq7/AckU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637878; c=relaxed/simple;
	bh=TPqn2J0fkzVWw3gxP0HDAQYczYAQq8Phxt0ninyGW1o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qfA1YUSbx4XM7T8ZWgD+YIIWW2c+C9cOchhgr8eFSciiynUEPo0Ca2NmQC5zXQHVaR8wawF3VQ4ntUOA4gy62A36lJa/w6/jSlksBzaM9mDMtb4IYVLSd7OJJSXxvr8E/vRllGGPuxsW3nORhOb51qADtg7bimMMxKo7Auxu6HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CG8bi4YF; arc=fail smtp.client-ip=52.101.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqPm9Js3rrTz6FvJdV4woLeGYO8BeLIUqmy/FSUYF3NptmtDijdKYCYLuekjQfFfEleNnH0koUbstNniZhErOszsHF0QQ5YxJKTgFcaBvE3AtuAJTE+8hErUv2Ko3XZNA4f/3GB58jEOpaPZ7RtQgui8XeHpA8gM9W9vRcPW6862bm5Ax32vQ6nt/5w+atzqoAewdfa22zgzrNBcxoAC1fP+KOdm1R90F2n1qc/wTr2+1U0l8ua15Kdixwbau3wmjgyJhmhf4E6B5t4jQua/mrLSWsFuelY6MmWWKAiT54HhN12GAppAcvpYCLfvOv4i0WICO98DWSVahw9AA8xvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnGD3WiJcIUHK/QQYPPVXVa3JDkd62MKKkaM6nl/XQ8=;
 b=cIUk1oPyWhmeHeNdH09arqUdt4ibJxNLJEKIdwLP45gdC9mO+3Xge+1TlumilDkXG0CPtgeEu6pLcJFvtn/OakZDQ5HnG7gOdRNseHVjVM6XAjP240kPMBEjZsUVdadwzoFrB3aUQifT0UyZsaGbU4UXWG7m0jwGVCc9/6p8vKJcjamhG1biRbXAdR2rMOZoJa3QXgLcLiHv+I4eIM56wtp++y+zergDdGcLTVgVNU+viW3bW5ZcwSbwDneYabaoJbATkzOFBM75VgqoGFC+ZJT5SwLzTu03PeGKQqR5loIV+2kYv6GbMVp5UfLtsN78H0liJakliHKpx9a7pPVX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnGD3WiJcIUHK/QQYPPVXVa3JDkd62MKKkaM6nl/XQ8=;
 b=CG8bi4YFGvRjmxZ9UrzCMz+We9Ca1Xbavw3Js+m3KuLt+XNP7kFiUdai7clh533yM+ujk6BAtYGlOs3ovskKFfX0IHEWpleQocJfei8H5yGT+l3rN4IUSOW8PSMgvy7v3n15KybEsI1+3BOTjGsVcrMnjpeXXML4h1wHL7V17uCBgMf88aDRAWA5ezkeSCovmhcLYPCt9Glkttd+Yb4FLesM6mEbTiUCSjteK5v8iUTw9Yv4121jpCavkx2BOKyyGCT46fLONFB65fgTzlV9eSZAB/Hudi0ueE0YfvBu8BIzdnkDeJnseaid8RB9dyxSTFK57zKsBpqYux/6dKjMsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:45 -0400
Subject: [PATCH v10 07/10] PCI: dwc: Use parent_bus_offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-7-409dafc950d1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=4829;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QFCJ0UFvmjJ5pvzmkxILKJdn2lN/6NHTku1LIcUM4ww=;
 b=85q7rOAtro5MMcuFEnC6VCIAYraC/oZmW4uWJ5JmTudzJ2c3MLKTs6WbuASqMg7arX1sf1Xdh
 tIXlBnZ/eouC/tqBbJotmmX1A7RzGVyH5fjch4/cQr1cZmcIJjgG3Rs
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
X-MS-Office365-Filtering-Correlation-Id: 5d8e54cf-91e9-4fb6-6a66-08dd6010a395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1FzMlk4QkJtbEM2MnNtMllkdWFEcUVMRnFjQ2ZQMGE3ZDlqbGYxTG1UaDcx?=
 =?utf-8?B?Ums0YWlYeG1NM05tMmpYNnp5amdSQ2k2T2NDUE1XYVozRlAvL2pzZzNpT2U5?=
 =?utf-8?B?bDBScEc4UGhUM3M3UlZuYVRyeHNKdmhNVTc2YklQZjZsUzd5NVZKdUl6K2VT?=
 =?utf-8?B?MXB3RW9ETUUxRW14UjVEVWV3RHFyTUxsNVpESytwZnBUL0xXOXNpcnM1eW1h?=
 =?utf-8?B?UXkvbFJGQ3RHZ21EaTJjNXR1czN0MVR0eHJXM2x4c0FXeTJyVEFNMG1mT20w?=
 =?utf-8?B?bVREcjdVaC9PVnJZalVwVXBUc25MK1NKaUdjcFhReUtWVjBoa0hsK20wR0NH?=
 =?utf-8?B?bjN4U0ZxZTlBYkxTRDJ0bmZibFFwVXlEUE5QUlpFUlphNTV5M3pUcTBpK0xJ?=
 =?utf-8?B?aitMalcxeC9TQjdKcVZEenVKUzg4cHlLVkxNcVZtZHdxbUdGYlZaWjEvY2FH?=
 =?utf-8?B?RlZISURmaHZyY01OTkxvd2pRcFRKOTRFaTVBT1Y3czc1N2ZidWRRTkNFdk5r?=
 =?utf-8?B?QlplSElpZUdHZzFlcVNiK1RhOFdXdUVpenpqNEg5eUZxN20zY3l1S0k1Lzcv?=
 =?utf-8?B?VHgwMDV2eWRQWWJtQXQ5S0J2VVMxUG1wVllSb1NtL3diSjZ5YS9iRmo1TXV5?=
 =?utf-8?B?enQ0YkN0N3plUENkL1I5ZmhLWVJ1dGlxNWZMUFBRcTdBMDhScisxSmZEVTk0?=
 =?utf-8?B?aEZjWmZQYWJIdDdiK1UxSjQrUVVUaHM4amt1MlNyYUZPM1p2UWFVcEhzbE11?=
 =?utf-8?B?TzRrRUlqcFRNSzNzL0xXN1RuQWVmQ1h3SGpoRWtQZS9QUWlFSEFOM3diUm81?=
 =?utf-8?B?TDBLRkRjSVpFaVdkeFJ6aFM2Z0pibUU2RnFzaGlhQTBOY0Q4N3JCbVBCajBr?=
 =?utf-8?B?VXR2U3lIeEZieGtpT1F5RnBrR3F1TW9oSjhuTlNJcUpYR21UWTYvdFNjRlph?=
 =?utf-8?B?MWxzbHFDc2JycXVNam1XMnV0elpoK3lseDNBUVR2c0RNRmlyNGhpRVlrUWU2?=
 =?utf-8?B?N2xPWC8zYTZOalJtWG11SzF5Sit4RWVnZGNkUzNrN3p1bzRkMUh0SWlmNnA2?=
 =?utf-8?B?dnJiNDdCNllSdUFMMm9UOXRneUJiWUVDWjVid2FqNEZvTFk4OHB1VW9BTk9n?=
 =?utf-8?B?bFNUZ2ZKOS95UkN2RnJvUm1BSGg3YU1VWkMwRWlNcG1Vem5WVzE4WW9OcUE3?=
 =?utf-8?B?VVpteG5TclkvdjlxMlBEQWliaWphZXZSeEhJa3IxN1h5OEdDM0gzYklucyts?=
 =?utf-8?B?OCtJMjJVYTFNUWZraFBxSS9HclVZRFlQczB2dDVjVGErS041bVNtU25Uakda?=
 =?utf-8?B?bGxBd21TZkhrQkg2U3V1S09scEdILzduRUlLZ3N5VWhjazFNWlEvVURWTHov?=
 =?utf-8?B?bWhwRGVSZndHVjE2V0V3ZVc2NUxXVVZIVzdoaGNjQ1c5SjcvczhwUEl1bE1N?=
 =?utf-8?B?WEFxWG45YmdOTVZyM1dBd0UwSStsczI5Tm9qZnkrZElmdTk2R2NOMVEwSEha?=
 =?utf-8?B?UUhLQXpsMkF6VVRhbGk0UFE3ZkgzVlRqbklkR1VkM2l2Qk1Teno5elFsOGYz?=
 =?utf-8?B?dWFyOWJVYlFwOWltSDNQeW0zVWxJYUZnWThoSXhtd3h5UnpadGVMZ3FZRzdj?=
 =?utf-8?B?ajVXdlVWUkc2SGg5QWhmMVFORXBEdTNjUmNZN3hVNk1yS2lCeGxxTXowbUtZ?=
 =?utf-8?B?ZUQ2aGp3S1dadjZzY04ybmFpMGgxeGRzRk9nbDYvNmJOOC9yRDhXU0d6dElQ?=
 =?utf-8?B?U0pndjVZQkhwRU93ZzhZMHMrTGVnZXNqRU80a253S0llSmlRbHZHT2I4YXIv?=
 =?utf-8?B?V1gxQ3JScTkrbGFRbDRqU2RwY3hhYTNrVnRiR0VzVjUxOXdsaU5UcWhqSm1J?=
 =?utf-8?B?Z3RkSklzc1Eybkk2ejFqeGsrT0V3RGxyK0hiL3c5TCtOZUQ0K3djZTBZdXIv?=
 =?utf-8?B?UlIxcmEzeEc5RWdodWtCeGpWMHhubTRnU3FkczJPb1F5U2s1Yk9uei8zT1FD?=
 =?utf-8?B?R1gxeFRySk93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzNGa2RacXVxQ0ExWVRrVzkrbFJsR1BBbk1ITkxUTGkvSXpSb1RyN3JaeUZo?=
 =?utf-8?B?VDk0em1kZGhQaWlseWV2OHRmeE9BTUFEMXNvRHNVNFVZcjdpdTZNRVNLNVZI?=
 =?utf-8?B?Mk5ucnBudFlPTHNVZlAzRVVoZFNGOEI5THNrSjVDaGNIbXJSVGRwN2ZRVjdU?=
 =?utf-8?B?bzZnU09SNzE2M1NMdGJhQlF5SGtMcVhGbDdiK2Uwb29iR2t3SmhOaWkvSDRW?=
 =?utf-8?B?dFlTTER2VGJnMXBqV05FNTNxVWRZYSs2ZFUvWk9QZXRjYmk2TXhiM3h2NDUx?=
 =?utf-8?B?Z1NqOFZvS3hNS084WEQzRGtNVGZ6eGNTL2x4T3N5SnA3VkJUVUNoa0xiK204?=
 =?utf-8?B?RDZZVEtmRWhIZ1I5TTIyUm1kc1dVbEpzZDBLMUtXK0pPaVlKRHhGZXcralBW?=
 =?utf-8?B?S05GTkMrRVBTa1cwUTZBaWVlZjNNQlExb20rZGRFZWgwN014QStTWFNuQW00?=
 =?utf-8?B?N21ua2k2aVI0QmNaSi9oZW5QbzVoR2F0eU15RWNqQ2xzbldrK0VYeG5pTTBL?=
 =?utf-8?B?N2JMK0hLYjdrZnVKWTZTdk03d3kvZFo4QVIzTU5SaU1yd2dhSWNQQ1FVQ0lY?=
 =?utf-8?B?aUNqOUdIMGxPU3cvdTZCQ0VqakZxUHF0TUJaSHZManAvNHMrQTZtdGY2N2Iw?=
 =?utf-8?B?M2gxNGRmdWcybCtMbUpZcDFoSno4ZlRXckJ1a2liWGpjN29sWTNLSXV5T1dx?=
 =?utf-8?B?eGgzUzdmOG4rcnNlS1VhZCtGUENqVXBHU3U5MXcyaHFWQnFaY0RlRklwU1h1?=
 =?utf-8?B?TkorV2UrSVBFUEVxdDNnSVJDZVlJalVGQkQvUmtQaFp2N01wSzRFdythWE9n?=
 =?utf-8?B?NmxmbXJpZnFHV1RoNG54Wkh1dk9velA5SzIwU3VoK3BLQ3FwaytPQWxrNVNs?=
 =?utf-8?B?QXpDSmxzeDgyV2F6MmVoRnV5RCt3VFVCZlZiYllwMEgzR2VlU0pmcG1TeTd1?=
 =?utf-8?B?Ylk0dDRlU3haZy83TGRNOXo5bXo4L2RjYWZDWkYxa1M4eSt0ZzgxV2EwZDRn?=
 =?utf-8?B?SmJFZFVxUlpyakYyMWNwVmJQWnJOTDdWc2lvNTZiSjJxV1pTdXlxOVJNYlBN?=
 =?utf-8?B?RzhRN3E3LzVlL0E1MnZXZW8vMzRoY0gxQ2Q4NXB4c0w5U3pNbHBGZXc5ZHd0?=
 =?utf-8?B?MXdkUnJhYjgwenVqdnB5QmFocDZiNzZjNktLQmRTdWdheDFQY1dvNkk0TkJK?=
 =?utf-8?B?SkxJTjVUTGVkSjVPQ2gzU09QbEY0c1h1OU5BN3hPNW9nT0NSYkxMQWZGL284?=
 =?utf-8?B?Z2piYkdvS05ucWR6YlRRMElnYzNBVWFCZE5sQUEyZm5ndEN3NDExU0FrM3JY?=
 =?utf-8?B?VVhrSVlTZkk3UHRpZktyTjMycmx1V1g1NjJoR2lBTTRhQ2hPMlZYZExWWm1C?=
 =?utf-8?B?b2cwdlo3NExYd3pLdGN4VVYvUXlDVER0cFB0ZTJ6L0trZHJoRDRDNjNEU2Rz?=
 =?utf-8?B?ZTZDZDB0bzkwN0swOWhPY2JIYjNjZ1hhZytWaldsMDYxQ2dXZytMNUVGbzhj?=
 =?utf-8?B?OGJ2Z3F5RTAvaTQzcnlNZDVvNmZnUWtQYnZhcjZXaTRBUlN1a2JZMS9URlAr?=
 =?utf-8?B?Nkd3ZE5xZUF1Q3oxbHVlVnBvVlNjbjJ0cTA4dTNyckZMakxEemhhZTBtakVZ?=
 =?utf-8?B?dGZUVkdTdmtPMEM3L2VPYWZZUGw4OWEyNXE0OTZXMGE3Z3pDMCtPMUVFWlQ1?=
 =?utf-8?B?NU9YUEQ1Z1lTWDZrUVk5TTFRYUxaMU1seS9NQndqS2h1S0txMjh3UmxIQjBi?=
 =?utf-8?B?Z2FpTTJBTnhjejdmQ1pKczdkSDBOWUlGU3JtRGhPWjBQVUROUUJBeDRqbG9B?=
 =?utf-8?B?MU9sU3k3K1E2bU5IS3l3dGkwT2FpY1BmS2pSWmt4MFVqUTJGZHhFVjlGeWc3?=
 =?utf-8?B?VS9CczhLL2xWdGJ3ZlVnZXU1bnZxR0VzVHgxT2R2QXhubiswd0NVTkh2MktB?=
 =?utf-8?B?OTI3QldiMXVGT29RZ1VOYjBwMnEzcFNCTUIyZ05iUkQxbkc5eEhpU1BIYWFC?=
 =?utf-8?B?dzlwaFNIbk9WaUtYbkZncUU2dWFCTWNhN2ZtOXhYazd2bmRmYytoTEJSU2Nh?=
 =?utf-8?B?T3Jja1ZxYndlOEN6VE9CUVB6V255U3huMG12UlB5ZXBFUDVLc1I2OFROeWIw?=
 =?utf-8?Q?gDorD2Pq7UDAIKOSRf/KCYlr0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8e54cf-91e9-4fb6-6a66-08dd6010a395
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:53.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOZlCmVGBKkN5kNt0GDwq7wcDzejW7o44Q93kKjE/ZzGk+iFprMhDXW5+itFjfnWok3fdHzFcCoSxdx/GIK87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

From: Bjorn Helgaas <bhelgaas@google.com>

We know the parent_bus_offset, either computed from a DT reg property (the
offset is the CPU physical addr - the 'config'/'addr_space' address on the
parent bus) or from a .cpu_addr_fixup() (which may have used a host bridge
window offset).

Apply that parent_bus_offset instead of calling .cpu_addr_fixup() again.

This assumes that all intermediate addresses are at the same offset from
the CPU physical addresses.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
v9: https://lore.kernel.org/linux-pci/20250307233744.440476-5-helgaas@kernel.org/#R
- pp -> pci
- add ep side support
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  5 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d69d76c150d92..62bc71ad20719 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -314,7 +314,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	ret = dw_pcie_find_index(ep, addr, &atu_index);
+	ret = dw_pcie_find_index(ep, addr - pci->parent_bus_offset,
+				 &atu_index);
 	if (ret < 0)
 		return;
 
@@ -333,7 +334,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.parent_bus_addr = addr;
+	atu.parent_bus_addr = addr - pci->parent_bus_offset;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index eaa6dd4c7edda..a7b7e15d7b0db 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -637,7 +637,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.parent_bus_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base - pci->parent_bus_offset;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -662,7 +662,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -688,7 +688,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -757,7 +757,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.parent_bus_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -779,7 +779,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.parent_bus_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -923,7 +923,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.parent_bus_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 70b4d3369158a..7061a7ec08cb2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -475,9 +475,6 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	if (pci->ops && pci->ops->cpu_addr_fixup)
-		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
-
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||

-- 
2.34.1


