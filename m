Return-Path: <linux-pci+bounces-17096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB09D2F00
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6085B1F23841
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC41D435C;
	Tue, 19 Nov 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYXh/0no"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6B1D356F;
	Tue, 19 Nov 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045500; cv=fail; b=s7KtpNc4A4OVowI/s20S4TaGrKg08GJiU4Ntv2Ynff8dkezyoD25/8LmuYrQvyNyc7IxmrgaDQ5G9O13GL2J8TPfDhU1K+35/k7wk6lreuBYc1LAesDrn5cY7aYlukSOCfAuHv2scHBPp93crTK9T0JNx5IODQy0EsnntHdr0S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045500; c=relaxed/simple;
	bh=I0aB8s9mgt7c/wPNl4Q9fV9Vkbql7lyhVemIzXKa6vk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JQEF1QYI9cRqFfDH/spuHfboq7egfu5wbnvtVbVRv20yWJflvTzJm8TiBjqiSthd/nuDuflDwcogNcRxixPAv9VGDEFKS32hlRAjBhD3OOc7QWsApT6fqZrZZls33cA1vtiiFKylKKKvHN9JRxaqo8Kbb2FMfhYvlrdXEAcXm/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYXh/0no; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqNPfHA2sfXqtikoV1IoTrufKV92+7vw5jN3ER4N5WWsu/2s87KOuoriVeWxULP9b0w2YcgX6j+stfOqCsGqov5h2rTvhxraVpNcOMIlpT5ked3DycBsyZbjIo1KwV8ztGXOgG/l4IAnWvnJnm2JHqDF83n8v35iYUNoC65v8aOCILsAghZqhqzIlc6utXt2yvB/MmqQLget9MwIapW3yA+X/bzH0fGyuK74hRXUUhyRFTXEH4+bHh/jLa8dZaUIMVeWDpJvVGjm7aCcNFISUHmh31O3qb7Vep6czBX1/G4t5cZyIMCIixjinGJPTBO8kKWKjJCBjE0Q73f9yQHgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MDrE0QkVGaSwDsZhJXehBvAhAGHitWF51NhOtmt0vo=;
 b=otFdApvdLt9UTSHrmZfyNknEveFMuEALSy7YMN4c2mWy6lf6wHNh79GOLwgC9xycgtp770Kaoh65bT7Wn1tQ6QSP4iAFBq2GguEEGVSpKRiQBi5T5t7KmJyg2WyhJSWJo5PjIZXHNj8SNFBLVbDpS/ux+Fn6yyyrsna0nABUaG8d9Q2vm7SuCCET/C+x77uAfdiUSVj9t5qeLUWizKrGDXciwQ0DgeR8fcUL6zbq/pZPqmqMu9+hEjh2/HudzozzvZ0qQuoD0uw6KuoYqBauWn97GucQ4cVwz0Oya4V01szVJnWq/LPyg4msOJXSkCLkTCUktXHeRtXtpzHG72JoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MDrE0QkVGaSwDsZhJXehBvAhAGHitWF51NhOtmt0vo=;
 b=CYXh/0noeP6atpqILw20anNKjQVxkadudOmfMRT+cyyyyIgDAGwAA2ihbjE4pKwGaFBHuFQPJ62wQffJGTxWOWxmZ5QefRfbm/9MwUd+oqcMnmwg8RNm4jBdb4u8DxvzVilb0zz6+jiMvzGEHSaxAn7ue3qAj8BR1m973j7heODhcT/MhasosEODOSdCs9kIAsEdNHtt1BqlXLd57vWM7bbSxt2OruqECRgcD7qhZfj1ZCrz8rKcBO+GRUaWeorAnxYooGlPopVJfCRsmaerBBdwpTYyoSjpy17fVjagoPau/qOzNNtQORA4LeRhHkwPmmiIIeX6ziyHNXbuI8MRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:44:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:22 -0500
Subject: [PATCH v8 4/7] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pci_fixup_addr-v8-4-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=2679;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=I0aB8s9mgt7c/wPNl4Q9fV9Vkbql7lyhVemIzXKa6vk=;
 b=MATppPIs138QqC88p86N6l8VmPqKeOgbQxRpSnrquzgj6hwnWbc9VRRhTp6OLF4zpVzKW09Zq
 Yqe7zLnVjGwDjc9hjEsxIFWWIczSNm4brHolgj3ND93qUR2SBO6sH7V
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: cc96936f-c6ec-446b-4bf7-08dd08d2a441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWwvQVFQbXpMTFZPRTJCdWRZUURVQ3FoY2RRQ25tdmVad09wNFpjdE9XekNt?=
 =?utf-8?B?UVRRRjBJSEsvdGRQSFNQOVBnTVZYakQxMU5qcis3aG8wRG9ZMFZLaWZDcWtD?=
 =?utf-8?B?eVhrOTdZTkg5SVlwUTUzUGVjQUJLVVNxUVhTNFlQN3JzRTBGdkxWYlRhRTFD?=
 =?utf-8?B?cXQ4OHdkWEdpWklvOVVndWxWM2x0MWdMck9pN3JRREdhd1hBRDV3UVlVWTEx?=
 =?utf-8?B?N0JmdmswVzVHMERRR255ZHJjRStZNW9UWk43L0ZLM2tLZ2JKQXNzSDFITDJu?=
 =?utf-8?B?RzZTK1J1QlFRTmtaTC9abkZ3eEQ0cTZuTjZYM3h4QmFDcWNXdVR3RjVHQWxF?=
 =?utf-8?B?eXBPQ3VDVFJFck1aeWJzVUthVXJUYUVMYXJjeExTQklqd2xoSC9kaFc1NEF2?=
 =?utf-8?B?dHJYSW9WRVhYd2tEUE03NEFBNnpETjdqSXczQXViWWQ0UUs4YkR4TnVnR2hz?=
 =?utf-8?B?aDE4TmNFZk01RFNHN0ZYTlo0cEJqaGZ2N1Z6SUpyVU1RUDdTcGZVWndqcnZq?=
 =?utf-8?B?bnhYTlhJbXFyazYrVjNpOFloUEF2blNtSEFtUWVVdVhtbS82MU0rTjc2RUZD?=
 =?utf-8?B?ejRGZ3cxN0h1MEk3QmI4d2RJSkVuY3lpNENIdEgyTVRWK0VJTFNGblpWTG15?=
 =?utf-8?B?TXdqKzVnY3pkdHREUUN2SGt6S2Z3U1lSK0hoZjR6RmNLeFh1VjRLS3c1Skg4?=
 =?utf-8?B?ck1WRjVlWCtjRkJjMUt3WVJ6NFVYMXg0YzBMWTM1RGVxa1lLVlRwN1NMbXJi?=
 =?utf-8?B?Qk90K2o5K0tRc1A0TnNpL0xIRDZ0c1phVkZxcko3aHJJK0s0bVlUT0ZKWm5H?=
 =?utf-8?B?MHJOTnpsdTVuVGtxSUxweFNsMWxhUzNOajh2VWFhSG1BNWZjVDZNcU1OOUJh?=
 =?utf-8?B?Z0ozYW5YM1Z6OEFRV1JTd2N6RG5Ub0NyNkE5V1NxQlBvN2Q1bHJpeXNQSXhy?=
 =?utf-8?B?dm9vRDd4TG40TldtZDE5cFBCbTJlT0RtSTQ0bkVUTnM2NmVQZytJVFhPUEov?=
 =?utf-8?B?cEFaYXZpcUtWdHZOdWtVeGJwWk82R2JDK1BiM1IyTGhyMm9YWWx1MGlLdmVP?=
 =?utf-8?B?V3UxMjBDNUlLL1NZQldRM0tZWExjQXBINUVUclkzcFN6a1dFUHZHcFNlbkhi?=
 =?utf-8?B?VFlDM3JsSEQ2UkQyeWpGOHQ5cWNDZnQ4TVVuWUNRZVZkVGNSeVkwK0NXSS82?=
 =?utf-8?B?MjZxeE9kNElGRnRBTXd3MWwwamlGZEFSb1RpSXFBV0ZKZTZzdjBCMHlzSEpD?=
 =?utf-8?B?MXB6YVZkaVZJd3loUmtNRkovVnEwRFZNbWhSV0ZUOW5FVzJEZ2VVWTdoNlVO?=
 =?utf-8?B?b1orY1dFWHFsQ3NkZHZtTVVBMjB4bWNPZXdUYmEzUkFNaWJIbnFBRWtyKy9M?=
 =?utf-8?B?QzVXbTBKWHZyaVI2YVpxOGFTR3d0N3YySVV2cWU2L2E1WXVQLzRvYkFjdXpC?=
 =?utf-8?B?TCthQ29XS2E3M01QWEFhd3p1MUJOSFl1QVk0MVdZWm5JMFNWTmhyZ0lDVDNH?=
 =?utf-8?B?eHFTMDVSc0Exa0dRYnJDa01EMlVWcGQrVlVFQkZraENNdkEyRDRVYmZudFFF?=
 =?utf-8?B?SldYRlExekZQTWUva09WbXY1dVlSV3BtRlozZHRDYWpoeFBNOXlQdjV3aE9y?=
 =?utf-8?B?MnJQVkl3R3dvRmkvb2JCSW1VMzVVRGxPV3dXSEcrWG1oUHRPVitQK1ZibXN6?=
 =?utf-8?B?VXMyNUlaSjdvU1ZXbzMzelpGMVBvZ2FsOTdvdC9laTRPY2pJUHhyRTRoVGFy?=
 =?utf-8?B?OVNmYmpkSDVNSEo1ZTBKQWhPczNIZ0ZzMU82ZnhQRHJ4eUZqaGlEczRuSTJS?=
 =?utf-8?B?VVRqNlcvRVdqWEpEcEE1aHFIVkhGWm1aRU5lMWNmZWduZFJXNGhOaUNoTkhD?=
 =?utf-8?Q?mbuEC0op+FN2C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdCNkhWVkZISUFJY3BlTmJ0NHJOWVJsUGF0UTNkTkM0S2crL2RvTEtzaDNm?=
 =?utf-8?B?c3M1Uko1aG8xcTlDc2p3VEMxemY1Rk1WdjNYRmN5cytXK1RPM0Z6ejEyeVMr?=
 =?utf-8?B?bXVPSE5hU2oyRitJVXcvSTI5VmdGaUxTWEdOMjRITFNZT0lVa09uekhoQ3M4?=
 =?utf-8?B?YTYyUjFRUTN6c0ZRU0NmdkYxbzlwdnF6cWM4S3hIbXMwS0IvRVVTOGdZbjg0?=
 =?utf-8?B?Z0xFSTI0b0JBVGVHK2dwYlB4Y1VHUHRmTUsvWDJ6K2tCeHR5RFBrVVJBc0ND?=
 =?utf-8?B?MmU3dk5GUi8rTmVhNDBsNURJRldoTUFJL3o4OWhwMWd3bERESmZEaGdBMzlv?=
 =?utf-8?B?dWZlRUdIRE9EaG0rd1ZIYjhhbHM1ZWhlSk5SeWNOYXJyOVJ1TGlCZ2k5Uks2?=
 =?utf-8?B?YjBHNk1TUU9YOWhDamNlKzNpRUJvdmViUGExT1ZYbHhTSUc4R216WWROdk1a?=
 =?utf-8?B?WmRjTm1rTzhsMDNXNUk4RjhqNnViT1JTWURuZGU3bjllYnU1dkVKWWYrK0pT?=
 =?utf-8?B?QWZUSi9TUjIyUWRhU280cWFadkVDWWJ4VVB6aVRtc0kwTldLcVUxY2duclhk?=
 =?utf-8?B?NHAzMTdvdUo2dERYSG1Hajc4THNIZDVuSTNlUVdOSGxQU2pXUjkxRWduTzkr?=
 =?utf-8?B?ejR3d2xpSDZZNkQ2YjBRemkxMzdxb0NIbk1oUUhmWXh5emVEWWZ5QVBuYXZD?=
 =?utf-8?B?RGVua2QxdndqUHhET0RpSjY4NVVzT2FxWVFESVRnVnVwbDNTaFkzcDUrSW1a?=
 =?utf-8?B?MGwwMnFkZEZubjAwbndVVWlWbWFrZEVLSHN1UmxMTENzR0wySUVmNXdnTHNS?=
 =?utf-8?B?YzdpenlZem1jaTdML1RFT0dpc1hWZW9oK1djTnRQN1Y4V0xKRHZaV1FEWHIx?=
 =?utf-8?B?TzZtQ3BkK09TSlJSRlhHS0hvYVRxd2Z3M3JWVzdSNE9pM2hzZURPYk01Tk9v?=
 =?utf-8?B?Y1BoQnY0M0JidGRneHJzVzdLM2hiWEwycUZ6NWNmTitLVkMveGpKVmNvVGJY?=
 =?utf-8?B?dncyQXhJcFdWYWJyTUo1Z1RLZGhOM1A4UnQ4MlNYSHl5TzlEQUs1dml3QXFX?=
 =?utf-8?B?N0JEVllQc1pLYTV5RzI2OXZmVjYxWU9OQWFKUEtPeDJIWkM5RkVvM3o4bDd3?=
 =?utf-8?B?ZTF2akQ0UUUvdzhFbGdGQUpkZjRsOWNVeFQwa2JYNVU4SVo4bHhXYU5ML3Y2?=
 =?utf-8?B?QlROY29WUXkvbFZIS2xDcWk3K2kyanBIY2dSV3dnMFVTdGlrVFJqakx6S3pR?=
 =?utf-8?B?VzhRbkZla0tueDFkSFZQa28yMmswZ0dVeWduMDdxL3VmbzBiUnk3Qk9qSnE3?=
 =?utf-8?B?TXJrYnJQV0FHMSt4dnVnZ3N5bjFKb0ZMVWw1MEk0N3M1RzIzQ0JMamE5N1Nj?=
 =?utf-8?B?UGZIc2g0RnZIbHhnaGRXbFFzY2ZRZWtjYVBERXJ3czV6U1FGNUVxa3FnVTJG?=
 =?utf-8?B?VUYxdm52c25IZU5ROXc3R2YvcGpKZVFrQitCRkZtMWp2NXo5UU9URE1OMlda?=
 =?utf-8?B?SkpmQW10MlE3d2hSN1NMVWlrY1JLMGVuOEV4OGRIQjg3U0J6UWhkT2dHV1Bp?=
 =?utf-8?B?LzRhYzJNcEt3TGRiUEZybEU4YW8wZ0JhSStlUkNzcUFUem1pQzJyZ3VQMUpa?=
 =?utf-8?B?eEVBelFRai9vajV2cG10WVp4emhmSzN4WTRsWmRTUGFLaXlYYTFDZ1BoRWNm?=
 =?utf-8?B?U0NGWXZ0cjBzNXBVSGNreXE4UElZcllBcU84RmdPdHpyNmtkbVNoeGVPbkVt?=
 =?utf-8?B?dG5DTy9XT0NOYjM0YkROcXFZTE85N3NkbHlaY3ZyVG5VVll1bitHeUNRYUY1?=
 =?utf-8?B?UitjZFRUL0szRGpzR2gzT2NjbUx3eElZUHZyWHh2R290VSsvbUIwdjRCdGI4?=
 =?utf-8?B?dU1KMzI3MWx4RkxrcE8wV0dTSzlSbmgzWFgzenlKTThpUlVvRXpxK0UwajA5?=
 =?utf-8?B?akozc0FtNVVTcFF3RjRkV3pTKzhkVEYxU3VVSS9oMENMM2piSjJtRC9KaldP?=
 =?utf-8?B?bTh5eVVjcmFtL2Z3bk5SQ3V1cVBoRzlhRFM1WEgyRFBaamxDTTVScW11T0Qr?=
 =?utf-8?B?RG4vbzg4K1FQbjR1Y3FSc25XSXIyY0lQT09DdXhjb2FjNzdMUDB2dUdBZmJa?=
 =?utf-8?Q?8YXY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc96936f-c6ec-446b-4bf7-08dd08d2a441
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:54.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URTiZVC12JfT8kPndQFN71YIC24KE1jRBWlYIn7JmtNLeZA2gB0h1kaXQEQeodQ8feeaLkCHL2aiUXKaSS2Y3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- add mani and richard's review/ack tag
- use varible 'use_parent_dt_ranges'

Change from v2 to v7
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..cf033e672dbde 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,7 +81,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1012,22 +1011,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
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
@@ -1036,7 +1019,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1446,6 +1428,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1585,8 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


