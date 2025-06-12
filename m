Return-Path: <linux-pci+bounces-29559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A677AD7747
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C823188FEC2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822629AAF3;
	Thu, 12 Jun 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHLmVHfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D04299944;
	Thu, 12 Jun 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743533; cv=fail; b=e6MNDZvuLRRy66P+pLhgpqS9JplBB1GTOBQBX0z+XQBiMgqJ36ysLk7x7e/Q2pEt2iIxvpxcf1Bv5a++sVNrlPVrCES3ue8cRt/dqxB/HoUr3QYukrYlS6+TDaLvG31hlDPfm63/95sdp8VqC/L0tpcYw6JNPBcTVOjND2PZ9U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743533; c=relaxed/simple;
	bh=+LGVRzFqXzZWqV4kFexE2VLxwbmXEoDFGuorI7vJGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phd2d5LITNnuZL5/GBHA9YX9vQWR5vtyiDg+KCCljnWNYFAOStT0QTwYZj5i75wSjxUmCQtSayH9DprBJ7tsYwD8gOQUaHfr6zvK9w0G3RzPQvLYoOd/tqrqUONwhPXXtwXXFJsF2Patovrzl1IyZezjoPdmpQvTPZ8GdCgAxuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RHLmVHfQ; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y16qEIgUMbdIUHwNabPgcy/9bRTlcFG4lDbgBeeGf1l2mC0/qtcy9/PoPANdxaddYDDUUn7aX/k+tXaMtiT6bMnqF4Va3KIWQlUqXZ4jQjuHnOg0SeXE7Nai6bs8GmFbV7/zRu9hMCK5tOwNrhtGsU04y3F7uySIHckL4P7yF3N56y22aquZEUO7fAySu8VBo5ZKlSymXKG93ir9DZ4pmhLAtHSLjUxKQ13npy2vVillMuf5tW1qCrSoupmnMPfS/gk4wJYFPwyESgqj9U6JTCE5/PD2pY333w7mYaaGQ6J2FEakN1P8zXKtnYCxuw65VqRLz4EiQ7n+RJOp0CJphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNJyS9Zj4LH1TGaT20wYAamo7NdZJMLFPgBtnygKSE=;
 b=LD9t4GKwP8YWVdhzIX1Q8VHC4ln4ATYyIbFxWUCxHfq4VSMtPKKWYTWfMePlYyLzyLIsP8fIICFiZ/WQ51fmtLtKgkueIC+e+jqbIURPcx5PKtDrv9bFiY/jnovF1pF+Mdt9vSwgyq+EUKQJbmM/c3ju6A5CW67Uj3nFl+iiWWAutw6yu3YxrbTmDTUcnovYXGB1n4OU0E0/Nu+yC1tKRorjIETfWvWuXYycTgN2vlTfagkuN66mh/MEBpyKdmX2b8kQX2Pu8LIqbzWsTr3bltbm2d0AlFseXI3HXSBDf4bhtj4t62D0Sou7G571zkPqupMQszwOyPK+Ekff7AvH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNJyS9Zj4LH1TGaT20wYAamo7NdZJMLFPgBtnygKSE=;
 b=RHLmVHfQgV6SWSjLYO6zUhCZA6pGYKKS+WuY7337Jmr07svHwuqEK39WUs096efpmufTODjX832RJ9OdIErQh0A+qppxww1euLTkTloMaMdDEHbpD0b7iHa7cvWaNmTCOx+oNvAZtGJxhgtnVEUiAMQvPVe8usfR2dLtcMcC9KZR2PXWUxvHUjA6UxASdubmd/hoWiSYqbzBB1pLM0cnEH3Lo/6qdB0AgAaIvPfGllVO8QajCN/KnFwWIbfAKX6YBxQAKID9CMycHVomUI66jITT4sgRrIeFn8V5XKkw1KZHvtTS7c9oSK5WgZqorRTHva1sWIUuTZIMs++QddZnNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 12 Jun
 2025 15:52:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 15:52:07 +0000
Date: Thu, 12 Jun 2025 11:51:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 10/11] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <aEr3nGCqRuyIwA37@lizhi-Precision-Tower-5810>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
 <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
 <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc567f6-ed86-4603-b715-08dda9c915d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpBNE5JNXhnejdQNi9BUDc0NjhLeHN1Y0ZTWUk3MWVpcmo1NW0waUc2eU1h?=
 =?utf-8?B?QmppVlpLZWpPUzBDT3FyTThXcmJNVFFVbWRZTldQaEIvMFF5cXZlRUxtWHB1?=
 =?utf-8?B?K0xrYmhoalB2TE4rSFdDZ1NIK3lKT0loZWM1TmN1VEdtWmRiUmo1N0I0TEYv?=
 =?utf-8?B?SUJ1N2dIWkg4QndWL1llZFI2UFp6NzJIS281K292R0VxMk9JMVJXQVBQZnR0?=
 =?utf-8?B?NkNBVHgxUUVQRk9xdFpyVng0L3NuM2Z4VzM4Z0VZOEFuY1FSWk54OEdzVHBz?=
 =?utf-8?B?bzNKQ0ZkV3dsd0szRjlrcTFZdTdSUU1LbFl4UTZCUzFCMWh2THVZQnlabzJV?=
 =?utf-8?B?eDV2SGhETkh6ZmF1Q0Z4ZE1OYzM3aktUeE9GaHhCZFBhMTU4L0JzWHRESnZ4?=
 =?utf-8?B?V2c5Q21LYjFXTThyYTZnSzBLMmU5ZTJERWlodEZxVlY1V20xMG9aS09LaGNO?=
 =?utf-8?B?S29mZUhkMlVueVJnR1BuNS9OL0txeEdHRTRCdGRLcjAyTldvdnN5QmxPcERx?=
 =?utf-8?B?REZvT1U2aU4wNytxVXNMWlRnMlZLc2dCbUNQb0RFYjRiS3BTVGVoUUxDRTR4?=
 =?utf-8?B?a3NNR1BDRjRKSmRVQmRwY2NqbGlrWEpQUkRBNHRJWUdKZzJJcHdRQ1hCdDVG?=
 =?utf-8?B?OUR2MjdoUkJURmw2OTlkdHdpVDZFWXFFOHZkRndROVhrUEwyUTZvWisyVG8x?=
 =?utf-8?B?SStYbzNZcms0UTU3bHJOQ2oyKzRidXlQaDJkRDgvMlJGcGg3MmZ5c0JJcDlF?=
 =?utf-8?B?bFVOajA0bFF1M0hsTkVDSWhDYUo1bklLOUZVdHlPNnl2KytSZGVTK1BuOTI3?=
 =?utf-8?B?bGVoV0VYMVFpN29xR3NmSHFxa3pGUGFvRVhnNFY3VXluQlVwN2J0SS9MVjlI?=
 =?utf-8?B?dFZER1ltbDBiSklYYVhHRlRxR3hjL1Axby9GNHZYNGZGNGdDLzJCdk54V1Jn?=
 =?utf-8?B?RkcxK090a3pOdmlwOXlKNEUrblFQK1lOQ0RyYnRSOWxRR1NBZUhpYU1DcDUy?=
 =?utf-8?B?L2FhT2lxQm5oZHQxM1lFVFZqK3BaOE5VajBncEUzRXRia09IVkdQVGRRS1U0?=
 =?utf-8?B?UnprZHhJVXMzMFJOeTZPZDV5Sm8xTWJKenlyNjVTd3BtcDR5WW1vRytMbW02?=
 =?utf-8?B?di9NYlVqSzJtSWVMTUU5d3MrTmI5eTRGRDlyK21RNHd0cDh0SG9QYU5VRGR1?=
 =?utf-8?B?eFJYbU9iUVdubHZSV0xxeEZWN3A4aHcyV1N2K2JBSEJ6OHdOcW9VOTRsUWlN?=
 =?utf-8?B?emE4TmtkWjBnNXB4ZDBieTFOWCs2YlpiMTQxZGtDVmhXSlEzZ3lzTGFGU0Ji?=
 =?utf-8?B?N0JQby9waTYxYjRQclJSUGc5YmhLaTVwZzVoaFZWb0NvSnJlQlRWano4Z21J?=
 =?utf-8?B?MG5uK0ErUkZtdStDZ0dFc1dmRHZWdGx1elVOQWh1V0ZWWmphQ3IzREZpbTcz?=
 =?utf-8?B?bGI3MGZsZG5KYmp6ejZCSjRKeWVBTXlndjNiMFpSRGkvMzRuYVZLZGZvbE02?=
 =?utf-8?B?L0ovNmVqQndTV2s2Kzl6M2w4Wnd3WWpVZXM5ckdBczA2Z0FVSkVHMW9lblVK?=
 =?utf-8?B?emlMUEd3cWdTM3RTWkRxTXZoRVA2WkREM2NVRmxweUJ1MzUzS29lOVh5NXB6?=
 =?utf-8?B?ODRkYVIrRTh6L0FVTWFTeVA5UEZKd3VXM2NkbGx3dWM3cDN5VG9xR3RIYTlp?=
 =?utf-8?B?WDRTUHd5U0c1WVZJS1RPdlVKWE9YUkdITGppT3dldFVuekdQSTkvN0tkVEZ4?=
 =?utf-8?B?NzZ3Lzk5dFVVblp5WUtPMjFZOTdqaTcrMWtvK2JPWk1HQ2RtRFNHM2k2MTBD?=
 =?utf-8?B?Y2dVZnMxeDFVaTdGQkVMSEJnbnNkOGN1VTVyMWwvdWEzRDhyYXBaU3Q5MW5j?=
 =?utf-8?B?UytNbmlHMHlpUExFNFVVMFJhZUtVcGpNNEh3cTBsS1NuSk84d005amNweU1w?=
 =?utf-8?B?bVd1RFJRQUhkT1ZqTWYzaUVCaUNqbVA4dlBYQ3NQek40NUFqbjVlVkt3NG83?=
 =?utf-8?B?KzB0UmhWcDhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxabURXSnFqS1RmR3Q2dlA0UTNVL3BVc3hVS2ZEamtxN2E3NnQrcnQ4cFhL?=
 =?utf-8?B?MEZGT0lZZFdnNmJqaHN4Y3M1R2V6WEpZQWZSMzNYYkx3elRtY05DeFQvVmtX?=
 =?utf-8?B?ZHcraXJIZTJaRElRTWpoWUJkV0l2VzFEMDJyV2RyNXVSK2ZBOEw3akFpd3Bt?=
 =?utf-8?B?N0hiNi9SNFNGNlRtOC80OWdjVTA1blE0dGlVS1IvdDRWRFNFREVOeFRQS2M5?=
 =?utf-8?B?akZNRmRuVGFuTVhWL1lGUGg2UXFxUE85OGZDR1k3aWxadi9uSUlGUExUYi9F?=
 =?utf-8?B?YTdOeHJZeTRqRUVvQ1F0YlVzSWs5Z3dTM2I5RzcwWCtNR25yUlpSbDJlUmlL?=
 =?utf-8?B?M1ovYzMyL0U4TElKVGVCRFNOeUM0SUhXMjJYRVdyaUFNNTZJQit5aFp1cVlS?=
 =?utf-8?B?WFpWMXpadDl3QVBmKzFMbzZESlNBeTdaSEdGZFgvSmloZlFKYzcyYy9GL3dI?=
 =?utf-8?B?Y1dJRCtGOEVOSVlCdklqS3V3aWpVSXhuaWcrRlg1WituV1Zhd0h3NXQzTVF6?=
 =?utf-8?B?VTM0MGliRDFFdlVsMktQei9ZMUQ5ckRvcXFuMGVGMWhMNlpycXc4MjRoRHFp?=
 =?utf-8?B?dEdZRzZkT1ZURS9UNWIxZFJEZWtxc20vakZocXFKMDFwaDRyTmdlajFQZkxn?=
 =?utf-8?B?amdlM2ZkMjdkNEI4Q1gyQTBKSjFjOVc0V2RSU0thSVZGeGh3VmtMNkhjdzBs?=
 =?utf-8?B?bVorVDJ1ckpkSno1azFteEwreTlZamVWVlQxRUVpMm1WN2JpNmM4MVo0ei9G?=
 =?utf-8?B?NlQ1azVOZUVIV0FEM2FqdjVsNkNvMWMzOEJLSmpEcWk3TUYxYW9LNXh5ckJ0?=
 =?utf-8?B?RVBMZEVmbHZ5NE1LWXVVNWRnbWxrLzFDNjFranN4dGp5U3NpbkR6TjhOZXpD?=
 =?utf-8?B?dERWMWlKblE4Yzl6Yk5NeWZIMEYzZXJDYVV5bTdpK2NMbE1FUFpLZmhoRmYz?=
 =?utf-8?B?bjFWQmo4ak9Fczl0QjdHN2E1QnBIRURtVmcvR1Vqa1hSekVIak4xUDdkWjVz?=
 =?utf-8?B?N1RhRmVKdmlaZWxtVU1KOWtXNjhZWk11MTZ3VEdHR3MyUTEyZDR5Snkxb3FT?=
 =?utf-8?B?Z2c4K1ZEelhHV3kxZmRWMVFwcVQzNEc1WVFTNVFvRHNRcjlvWm1ESklVNU5k?=
 =?utf-8?B?SWU3OXJrUHFtOTRVUUdvT1pCV0h3LzM2TUVwZ1kxVG9ZVlBjNmpRQVZJUmRi?=
 =?utf-8?B?VWl6RXcwVXY1cDhYN2toL2NqM1p0Y1F1Y1psNlFoUENrYkhsY1BqRmo0RFhj?=
 =?utf-8?B?TWp4N3JkWVdMYzB6VjJhaXpTZWNrN3pUOHdkaHRxMnI2VlA3emhsU0VjS0VR?=
 =?utf-8?B?cGI4Z3VWd1dJMG56d0N6NjlDV3BYbVhjbE9vbkdZZVN6dDVQMTR4TGZLZytj?=
 =?utf-8?B?MHFzT0JtZkR6SnRlL0dMV0RSTmFtdzZuTmFvR3BFQnV4TXdxSnZhU3lmb2xk?=
 =?utf-8?B?RzgrMFpCRDNJZVRwcXJya1dOVG5icncweFRodnNMaHpsSGFWUXVrYmNGMWhq?=
 =?utf-8?B?WTg3K0JHbzZUZUpiMkgzTExHYmZLN1kva2VWOU9pUkdFV045bDBKZFpEN08z?=
 =?utf-8?B?UGhuYmh4Mkx3SlVnK21LamN0L2g0UUlLblpiWnNkTXk5TkJCZnl3SFkvaVlL?=
 =?utf-8?B?d0wrMk15RnJYenY5aUpzNXZ3VStTbmdRaFlPMjcxSFVVYy9qUUtiS2JOUUYv?=
 =?utf-8?B?RFFyeHA4YWIzMUM4NWhFUGZ4a21RM0NUL0Q4bFpBT2ZMczZiYmNQbGEwQlJC?=
 =?utf-8?B?NDRybGVxTjVPQ09SR2tBYUlEM1ZoOUJIdnJWZ0MwSGtJeXc1eWJROHZSdnd5?=
 =?utf-8?B?SVV6akZpMWRpT1dHRzRBVUhuTXJlSzZmRUVwUGtSaE1hQzFPYjFma2w2cTNK?=
 =?utf-8?B?U3J4dmI3Q00rMG4yT3FPdXhvSXEveCtRNW1HMHVzcU9Fa2FWc0NmMFRBOHRR?=
 =?utf-8?B?L0IveXdlQktKeU9wZTJqdzlJUjF6NlptK3phcUw5dk9YanZ6NUZKYUF5eWc2?=
 =?utf-8?B?Wm9takkrNWdhb04yS2FEZlRvektJOGdpTjdMNE0vUUwyS3loUDUyeEtPdGQ5?=
 =?utf-8?B?TGRnSWxTbTh2SWJ1WGNXWm9YYlBMYlF2Z2tmRjMzMG9wenFhLzEzZEpXRzBm?=
 =?utf-8?Q?DPUCEcsL1PPMYZAiGPoS0jLf6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc567f6-ed86-4603-b715-08dda9c915d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:52:07.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhznqJth9702h5Gl0zul0IiTD6SwOtXPkdKiigYcZukMK7Z2MooaeBSxSqFJjx73YNxdDQbL/47QwjRftrZZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386

On Thu, Jun 12, 2025 at 08:16:03PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 13, 2025 at 11:38:46AM -0400, Frank Li wrote:
> > If the parent 'ranges' property in DT correctly describes the address
> > translation, the cpu_addr_fixup() callback is not needed. Print a warning
> > message to inform users to correct their DTB files and prepare to remove
> > cpu_addr_fixup().
> >
>
> This patch seem to have dropped, but I do see a value in printing the warning to
> encourage developers/users to fix the DTB in some way. Since we fixed the driver
> to parse the DT 'ranges' properly, the presence of cpu_addr_fixup() callback
> indicates that the translation is not properly described in DT. So DT has to be
> fixed.

This patch already in mainline with Bjorn's fine tuned at when merge.

	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
        if (fixup) {
                fixup_addr = fixup(pci, cpu_phys_addr);
                if (reg_addr == fixup_addr) {
                        dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
                                 reg_name, index, reg_addr, fixup_addr,
                                 (unsigned long long) cpu_phys_addr, fixup);
                } else {
                        dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
                                 reg_name, index, reg_addr, fixup_addr,
                                 (unsigned long long) cpu_phys_addr);
                        reg_addr = fixup_addr;
                }

                return cpu_phys_addr - reg_addr;
        }

I have not seen this "dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");"

Frank

>
> Bjorn, thoughts?
>
> - Mani
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v10 to v11
> > - change to dev_warn()
> > - Bjorn: this is opitional patches to encourage user fix their dtb file.
> >
> > change from v9 to v10
> > - new patch
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 8b546131b97f6..d4dc8bf06d4c1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
> >
> >  	fixup = pci->ops->cpu_addr_fixup;
> >  	if (fixup) {
> > +		dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");
> > +
> >  		fixup_addr = fixup(pci, cpu_phy_addr);
> >  		if (reg_addr == fixup_addr) {
> >  			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

