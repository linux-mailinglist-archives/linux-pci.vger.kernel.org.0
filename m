Return-Path: <linux-pci+bounces-15548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0059B4F86
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C275F286926
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E43205135;
	Tue, 29 Oct 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lxVMvKBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1B1DB37A;
	Tue, 29 Oct 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219837; cv=fail; b=HS5/ESKFPAuQz1ajmDid5BpsW7qx8RR/2xcSoY8gaW/DTrihmtCUlUJc8IFXDdVIuUmk+X4w7k/Wv5DmmJgaJk2IS3n8c4rX4r2zdUd+CPMOpMYo8ZPSTRg0voo5J2UA85HRPRfVVsuTFyEt0wZ5fXp4Ti9btqBeIuspo01FjOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219837; c=relaxed/simple;
	bh=UZs/9ItHp52qTaKjFxZYB4V5+jvB1u6qYUMVnsusbtc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rg5ivO2+oMnYKtF2lHr6jzXCl4JfScenSuzZv+y/HNSIrlVEYvOa8+us2J5vVMiioEaefL99xWFAJlGYErC2DVQ4wTmEx9krfzIYVSmD0zu87wu7gaAR/ccnYxfIxJSSxXL9zsxUbx3RSJP2QG2QRo2F/vMrrkBUSBixU0UPJWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lxVMvKBb; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Jth3E+fJdus3LnAmz2khReek8JkSC0lOvN8RA8aBa784ChUbwlwR68KUK3Hr+KlEbpmgDFz/ua0y/Oo3IRKb64pZ9Jy5UhVlFJgIsBJ/R4s/+6yHrRtd6OIv/LEk0u46tPY7K+CifYFu4lVfwoPidNj+foXtQeYAU4uIFiQs3LhSrJTQPg+TTGGssU965/I1FX5tFpzq2c+LKYasrKrsFlZqblXVLrIi2NbKxhcs5DuzgpWN5DG6rJnvga1xPxuIgU+GcOtSSzJBHkKKSna5V4npS/yKSX7mrJWyV2Ev4GoHswQgdQrJn08iVIeOSc1EJciWKKypVMWzBjaittqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8W/MN5dTLwVKfDTf/LqjNNpJdK6uYbSr2j3BbcfCR8=;
 b=nkxYPL0K27obdxLuuRiyDQ7Y9yapw6maGga0iIkNyVr4ogoggA0av4eo8HFAdU3J/PElOk6OHnZ+S2J77S6sKNAoFDSxtkW/IPfNMsMU9yS36f0tHWxoltXvDXmh8iQArVgaO5psStiYmaCvfqghN7ArRjLDqZI2YglCutNs+uNyYO+1IEYoGVnp7Ej/dRxf35UGJjxcCjnKN7RB4Ntzg2qeVtl3iGfx405m79TSK50rjckgO5OEre/QKPgmFobFBz8LFl3/sL04SYelFFRPprO4OibbDL7l9rTP72doEygutHqBvU9lF0aOa8SLBDBSEW4Sx8zse4Ra9/QsqZVB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8W/MN5dTLwVKfDTf/LqjNNpJdK6uYbSr2j3BbcfCR8=;
 b=lxVMvKBb4SP5DU7U+SPogvjJIz55a+eKqURcUXExzC4TfWGFNF+qqO21Ye2uvU+J0iR40Ro/ueyqfC0UGSjBMxI4nikOI3B2viEge/TBS7kFYc4I44rxnsz97Qxqvwnsd/dC4zqrlmGlyD7nv64F37CZuWzu3sWwtFUIyiFiE5FsVzjG/FSp1wqk0lzUXAzlY/jBRPLOfW65Qh/jBeA/4Rh6RTLq3lhAPvzPSafyX2+QLSkINrCjIrBrehASa3fregL2zA3G4JiZiTymtZGZJ7LHTDXAb0nQCiKL8vnGKY77DRDevzXnWQBDKA28Dl0y9bVS0fDF4J4IWIFiqbQeZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:37:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:37:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:38 -0400
Subject: [PATCH v7 5/7] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pci_fixup_addr-v7-5-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=2245;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UZs/9ItHp52qTaKjFxZYB4V5+jvB1u6qYUMVnsusbtc=;
 b=4epCvFW/6EZO1xZs7xlAeOR1Zr2YfkWMVGeyHsFEPIYCOd+4quY/T3i3rit7D82dIGNoJ+0dB
 52tIcdI/Eh9Bio8LLIbzAzvLjpbpDzNd0e04kopNakSKKDav2T95wch
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c8e11b-850a-4637-b0b9-08dcf837f062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUM0VDh1akdudEsyN2tYVjVyYnNMZ2ViN2pqUmEyb2g5ZndZaklxOUFaanZJ?=
 =?utf-8?B?R3EvbWNacEZlZnp5NUdoeVUzVnZJaDZQS3dxcGRLV1B6N0VrSnZpK0U2L1Fh?=
 =?utf-8?B?dlZZbzlhY1VwZmxMTno2b2N4WjBCN0p5cmwvQTlhVXpNWlBYRE5NYWQ2bkhr?=
 =?utf-8?B?M0MxaVpmSHZJUER3N2ZXNVJIMmo3cUJmWDEyc3JyR3dhVVFHMjY0Zm5YQ2Rr?=
 =?utf-8?B?elhabzJMR1NibzF1bUlDb2ZnY1hPWXpuQVN6OFFPcUxYMjVtYVFMaFJMeXRh?=
 =?utf-8?B?QTNJcSt1dVlqUGFuUzJzMU5LcUhZeTE2WEFXRTNQTUM0SXF2V1dxWTJBaWlH?=
 =?utf-8?B?KzVwMGdFRExCMHh6dzNjTXc5a2FaSjg2M2VoNUNOcndWQThzOTB5ZkFzL0pZ?=
 =?utf-8?B?M0c3L2lPcGVsZ3hpMVpTZ2VQNkczdkJHWVhaNlNoMTlqbnV1V3pTTDNhYmZU?=
 =?utf-8?B?SjNFa3ZMaHArOFhiSm5EWWQ5clNSeFJWYzZVSDU3U28vSCtDTWplUUw1djhQ?=
 =?utf-8?B?akNuemlMeEpZR1J4MHRSbk8ydFY2U0x6V1NHUzNPZ3BmblBVRTMxeTNiZWF2?=
 =?utf-8?B?WlREazFHQXdKVVczOEQ5QkdjQVh1L1llVkJnc0JSd25yMGRsbTVGKzV5WHZ5?=
 =?utf-8?B?T3VZSklieUxKYmNJb0MxeDlLb2gvSE9aQXZNek5BRi8yRmZ0eGtiUk1CMDFk?=
 =?utf-8?B?Z0ZyZ1lTRFlmN2dqVEhEMy9NVW5qaDNRcVU4RlJhY3VBLy96SW5PMi9HY1M5?=
 =?utf-8?B?OWY5bHB0aGNtQW5ZK091MnRwYVRmZHdFb0ZpcDI4RS96d0tjemdWcXFKMlN4?=
 =?utf-8?B?WXp5bEEwZWNURlpOemEvc1V0ZkY1aDNNT0VJTUxrYURKcDdFRm55U0RVaENB?=
 =?utf-8?B?T1dvMXV1M3R5cC93bnBZWVkzVERqejFrUS9BYWRONW8rdzJLS2FpT1lnNVZF?=
 =?utf-8?B?K1NuV2NEMTVzZ0JwRGNkS0hsNlg5YVlLM3ZUOE1qM09obk8zUmExT2x5WmY2?=
 =?utf-8?B?TDZSRkN6czFMdjluSFJMTWxVMFdpa1NMMzN6em84UjVuN2t2MVFmOVU4U3d6?=
 =?utf-8?B?K2lGSlJqdklqWm5WNnhqSmlXYkxQTFVFVjVUclhpMy9VNEk1Y2h2NDhCRnk3?=
 =?utf-8?B?UzY3bzdzYWtPL3hiRjA2N3cxdWI2N3l4aXAwa2E5UmJVTVJKSytQVEZmNlUw?=
 =?utf-8?B?cjM1NlFualhQOHVrMU9yMVl5eHFlemg0MVE3REkrWW93SEpWU3JsdU5xMTRY?=
 =?utf-8?B?aklCU1AwZDJMN0RFQ1ZZd0Z3WVJMMlNwYlRFZ1VSOEVGYTM5aWR1c05aTzB3?=
 =?utf-8?B?Y0VUdm1Jem9DQmNMM041MEZCa3YxVUdVVytXS1ZFZk9NK2ExbWZmSXB1b01M?=
 =?utf-8?B?NUlsNUFMRmR5M3N1YWhxQVBkWjBUMWJaTmkyTE9DeGlWZEloL1BFNGF3UDhn?=
 =?utf-8?B?NGQ1V2IvVUlCeFpmZENpTlg5bnNLYjVwQ1lPeXhVU2pzeW8valM0cXhtbFJq?=
 =?utf-8?B?LzNmS2dWUkhNTEdWZ3ZDTVpkdDREcHAxVWFQNGk0empWNE9tUnFJLy9NN2Iz?=
 =?utf-8?B?S2Jic2NWN25xalhSaXR2eVVzbGx6T2s0b0htRWdkM1FDVGVGN3ExVTdRMmpo?=
 =?utf-8?B?Zlh4TXRYWmdSRkcxdnBkUEJpU1NTTEFVQVJPZ3c2UHRhcytmWnhuTDMzYlpH?=
 =?utf-8?B?Q25wMzRTZU1hUWp1TkcxZ0ZNQjN2RXFrMTFnWEpYOFRXOFBwbGJrK3hITExI?=
 =?utf-8?B?eEo1VkQ3Z3dFN2VqQUpnWUZGVlR2aitHSk15bW96eHUyT1kwNWF0VHVVYlVa?=
 =?utf-8?B?N0hORnd3WVJCUXVkKzhKTlZ5d1JaY25TR2YraUVxV2ZEWE1valRNa1RUMnpu?=
 =?utf-8?Q?BgB8Ovp/Eez5t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eml4V1dJNnVLUDBzWmJ6M2lTUU5BZTRpWEF5Z1JPa1BMRjJqS0Frd0Jxbll5?=
 =?utf-8?B?WjBLNVI4UnZqYzJzRHhnU1B3QTRrRnkzTG51R1pnOXpJa0hPTDFkbzBVd2Yx?=
 =?utf-8?B?M1dLUnFWemJuVnptdzB2NmNaelZkWHpCV2hnazQ1REVSNGZCeUozdFZnN3Yw?=
 =?utf-8?B?Ti9EYjVBcWdXSEw5bHpKWEZrRDdEQ1RnQzJuamtzSmtVcUUyRlZ1ODNHb25C?=
 =?utf-8?B?MmgydS9RMlprcmlKODBFRmoyd3kveStCUHdYK3FQT3FOci9kbjRLWVhuUUZt?=
 =?utf-8?B?VllYQWl0T0FpL29XVXI2WXpkeFFNS2YwbEVoSTZudTFFMTFGRWtjb1psZmh0?=
 =?utf-8?B?WmRBS25xNW5kRnA5NW94RkZwMVV2QjFWY1M3TEJZOCtKUnl1RzV5VmFyRGNK?=
 =?utf-8?B?am1PVWxFRFZUc0dEdEtkUEZoeVRnWlNaWC95WVlYbkZIZGNzZW9YMmZGbVNs?=
 =?utf-8?B?KzdMTVhaVHRHdjNaclV3QlN3OWtMZU1uYlhvVDFiZzJ4MHVnZWZwQWtjd1Fn?=
 =?utf-8?B?T3lOMVpCdTJramNaVWZqRXc0cjNKR25CR0JPSjRhdmtNRHlIeGFmVlBwZEtp?=
 =?utf-8?B?TGNBQzBTRkVZSnBKODYxaXh3bDRBZ0JyUW1oOTc1VXErclVXejhEM28xNktL?=
 =?utf-8?B?VDFDSFNHK2xIZVlZdUhTcUpYU1MxbmlHWmYzTHFKNFB0Rmp6TzYwTTI4YXpi?=
 =?utf-8?B?WmZqKzJ4blozdGJzM3V1Y0xjQXJ0MUw2U0l0VFk4ZlVMLzRKSjBGcmNQRU90?=
 =?utf-8?B?ajJBZXR6QW9UZnJPR2E2RHFwMEVmeGNaNmVROU1pbXBueGpPcXA2QzIvbkt5?=
 =?utf-8?B?U3VMalpnb1pqaVk3cXBqVU1UcG1xQloxOWsrNTd1RzJRMm9nVkNSSWhYUWUz?=
 =?utf-8?B?dGo0WlUzVXJvTVB3S1FabEZ2emFTZmJ0RExXcStETmRVaFpwRlJ3TTNUSmhM?=
 =?utf-8?B?QkJ1d1kya0pGSitOUytyZ1VMNnB1dFZYN2hBNElDall3c3JHT29GNXA0cFpS?=
 =?utf-8?B?UFRiU0w3c2lnTzgzMkxteXlFeHZxWkh6OGRoZG5TWVRtNlIwSCtRRVF5emMx?=
 =?utf-8?B?aHYxdG9HajlIcEo5UzlFRnU1aFJrSHM3enlpY3JLUENieUxSYkFnYnp5bVNB?=
 =?utf-8?B?UGt2RTg4QWxDTkRvQUxUaVVzTkNRVUVpLzU1V3ZhdDF6MjFJTktZQ3U2Nk16?=
 =?utf-8?B?NHlaaDVDK1Z5YWUzcWJ6WVpzZGlPcnlLbHF1NDZkNjA4TjBjSjBUWlprVDMy?=
 =?utf-8?B?aGdmd2VqQWl5aCtVaUxORzFsejVML2JEQnZFZ0x3eERNWUxDaTNrRTJFR3E3?=
 =?utf-8?B?SkR4N1hZZnB2dTA3UVpGWkRWenF5RnNGa0dDV1U4RjRROGVrWFg0aUVmSG8z?=
 =?utf-8?B?bGMyeHhUdnlweEJ3TDUwQXJWRFgzemQzRE16RGJ2L0tTMkNwVjBHbm9FcEtM?=
 =?utf-8?B?S2U0SFNvOFVpcXdHWmFxeU1vNVBqMEh0Z1pFWnMxT3hBRVhBZytzRFNuY2VB?=
 =?utf-8?B?QmQ0am03ZDdwdFpjQUN2enhvbk54RnZZa29ndS9OTW0yY3FCUTFxakRqRUFm?=
 =?utf-8?B?YTIyeUsxa2tjcDZ3eWlwZjIxT1Axa3duTTNRR1Q1UjlGTWNtYlpjd3dXY2p6?=
 =?utf-8?B?VFh1dzRkUzNDa0NiSlBJZUdyUzFieHBicm1MU0o2dmFhSmNZTE5uOXdnNGhO?=
 =?utf-8?B?cEJWTldOdEFzNkp5N2JJR3ZlU1VBdGM4UDNxVzhOZVgrREp5cEh2RlB6Z01J?=
 =?utf-8?B?aTA1Tm1IRHVCdGxtZVJnc0grdUptRzhFM1dYUWZRK3VoKzNvSDl3MWYzUTlz?=
 =?utf-8?B?NDJtU3VwNmFKUWdqTWhjOHBvZjRnSnBIUTQ1cjhMUytQakpTYXBsaXp1QlA0?=
 =?utf-8?B?ZUFJK3ovWkxKS3RpS1hMb2lablNCejJrMUlGOHVvS0w2clhORmJSaXRyWUFk?=
 =?utf-8?B?dXVXQTB3NzJQbG5xa0xmNFUvczgwd0prZnFOVGJOaVFtYk42SlhHRE9JblJ3?=
 =?utf-8?B?Qk5tUWpLeHRrZ09xdXo2TVZ3RmtMNFYxczJuZWZNUjU5LytsVVdTYXhUcXlR?=
 =?utf-8?B?OVZIQkZZZzBjVi9BcEZaOWFuNDhWLzl4dVEvSmorUkZ5bU40VEV1bGc4c3gv?=
 =?utf-8?Q?4tQroFwPl12X6ASUobgWuI/EF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c8e11b-850a-4637-b0b9-08dcf837f062
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:37:12.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooMA0Hj/I63qBY0jcnHG5f9ucnmdZgGpGbkFEA+y9VbwVMOZNE+W4CNMBXIuWYSr0Vi0fcL7Uy8OaZSjeOkSzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v7
- none
Change from v2 to v3
- Add conor review tag
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


