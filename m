Return-Path: <linux-pci+bounces-20085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF5A15921
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 22:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5967A0F52
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392B1ABECA;
	Fri, 17 Jan 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIZP/EAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8761AA78D;
	Fri, 17 Jan 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150273; cv=fail; b=gjDsZcl0PKUfCUbi2tgd6iYP5c2gCSn9tpbmhzzIW2+jXmeKoV/CXisqLZbj/PjwWtp8ZBGml9DI3J/Egl/CQdq0507fzYTMDwlVNC9Qtnrk3ujLggvfhyvABjIT+GS8vAAdu7iZRewdi4GZHtiqPRUfosyTIocXSwmgSUG9ON8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150273; c=relaxed/simple;
	bh=74MoLW6en6RMqQZjl1Kvt/kh+Fy/iKbaNkJ0YBF/dIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfCPwj5NdMtbsC6SUIAygWRsUjcMtoIWx2BMqpi6MOJGchoMa18DrJpWmUcvPXdOGJQ8kj/hWpelke4h7xWiw7mXMg7eg1aOxStnKQCDG3R64XYOvKYOmcLWVQh3jh7gfOExd3lRD3fOts7TuD5c45+ZFsqoZtqX82kk8b9AKsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIZP/EAx; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBBs5X7cbC7ttsO8qLZzk12M/SHX0RLQTy3kPGASjRAQBE7V16Sz00Ku1Wz7EQ4kLdkiY0h0JgsNb8I0UbpvQXmlgTLEUf/vR+wL8OAhTN27PO32qxSBWXz5ur125dFS6xxYpRHLiGlbj5it3kQYCe+QgTVGgb0bMt7JR+grY3I8TYW15fJZ1KdSaOH97ko8G2f+D2B6nnJWpKZFUppV2gnO1934g8kHakfPr0jJlhJShHuOUCX2w60m+WnNImIijolJ/u+fs4c314RLM2elnInDSBDTyUXlZEUV0j9z+Yt3XkseKGarbMJJblo4359KR2TtlC7OxxOQcZE4ydNbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3jdkQJAKqlZFsa+CoYxD/QYKcOvR5FsjKvHyirA2aM=;
 b=qc1551PsBdJF8SMNhqApImZu0YYoCiZk60LZpD+DKIBQjUR/2lO/E3x3nnTXNsAOUxiqrhBWTh3XUVw51qxp7I4DiYAnobWLqwzXKX2eVdbdwRhfLZZ4BeL4hA1NIHYuaL03pJCeyrath7nuw6DQ51hdRkm8bBGEzBO8sgzotoYAKKn/KmRQiEcw6FqtTF86KZ9M4kngaDpQuffJLG8ZaMI4fr9w6ff9UY93e9StX/C2j/B3Z1NRHQj714PaS+9pT8EgY0U/o6IRP4e6ZsupH1T52+va5HrHQaNwIec4sywL0+rewZwp9nv1JmjBMhXTkk3hJhD/saPOFzFgCjxUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3jdkQJAKqlZFsa+CoYxD/QYKcOvR5FsjKvHyirA2aM=;
 b=mIZP/EAxiPogfL4QfFLfn2Lp5BTXKtouamLLE6K0EyNKVZ9yqxB0LY/m9zvXcl7MBKruWJ7FXHtVCurJ+axqvQqtf5cgqelkh/7LYT8JIIIUvugHn6z1YBknbBQ+ZZNfjo/ytfkxiZlWnDq1EkUyW8lmX2UE8TsIVyLuyF/68zsIarV3PxETRsDZKwMK6dZa61SyuEcbDh3/ADtXbop6eDKPeMFJ0McgwauBAVE9JZuB8DSg+TVYlYh9UR5iV3i5meBES8hIE/jLW68/hGxihAvUdo3DOy1tdHfFL7HZO/ViabsbMZOtATD76DWZLF20ClZMMH41Iw/7VTL6Owk9ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10598.eurprd04.prod.outlook.com (2603:10a6:10:580::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 21:44:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 21:44:27 +0000
Date: Fri, 17 Jan 2025 16:44:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:PCI DRIVER FOR IMX6" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: imx6: Add CONFIG_PCIE_DW_HOST check for
 suspend/resume
Message-ID: <Z4rPMkrmw6rF8SxT@lizhi-Precision-Tower-5810>
References: <20250117180722.2354290-1-Frank.Li@nxp.com>
 <20250117213810.GA656803@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117213810.GA656803@bhelgaas>
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0d0e63-1385-4b63-3e3c-08dd37401dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ElBKO3rook04g7UENkLX5hN8ZDn7M5K0bjMVaHOSuGfDVbAYe1dCnk/U+z9z?=
 =?us-ascii?Q?wN315cOq9BRc6t4KRmu246B0QglZ2OEge/VLv5LtD6juXcmCtga7dT8qaL+U?=
 =?us-ascii?Q?DxAxLh8NTl/N7r1kVFdjesRBjIXPJWjsc9q1HYmNdAMrblFxKEYL/pHarPIE?=
 =?us-ascii?Q?PaaWcEZHTtetZB/Y3ej0ukk01ddRj+M23Hs4rzUrKSi51w/Z7Z8toF76kfLS?=
 =?us-ascii?Q?7pr7yYqZH/YULbPLC+A+SVx8wRdeN7GwjUqD44gzp0KOqQZgPyhCJP7NGRdz?=
 =?us-ascii?Q?Qbtfth6G1fVN4LSURyBewSC1npSKO1C4Jx1uhAfhZDeFAUcgJkD2NTstslTp?=
 =?us-ascii?Q?Sfx2gbnn5wrscxyx8VsMXybJGJjJjvqfpwG4or6nJEBKqRdGpOHEY5L7376P?=
 =?us-ascii?Q?2QP+duX4l/q6uHa8b7mne9jSHhTeRgMYNUglGJC5HljuVaqnh3fIAQSz0vTM?=
 =?us-ascii?Q?ZBMp0hickLc2ualu+V1uUR5tsrxNlyX5MC9JML5taolz4aarg+crnBJL99P8?=
 =?us-ascii?Q?U4Wix4eWF39KxLxblgPGk2WeNH0hEQCEbqmIn3uzUUTmZmRTav68W/6FlMCd?=
 =?us-ascii?Q?AC07oDKjxNNZrdKvzsG7vULpc+DzpsL2CN1dBZZEXNG4G5l9ozo5dUfGVgXX?=
 =?us-ascii?Q?VhZLJ4/wnyJTeo0n0AJmtre1CjlOmyypdeKY/M0oKZIKA0lrwuOmtxWk1ScP?=
 =?us-ascii?Q?mWe85Hf8+8o7UwUjxDCI1PXgWv8c9v00Nz2tyt05xBCAy6JFTSJtfQLe/i12?=
 =?us-ascii?Q?m3xR1wJRDwZmW7eDEPd8XVXyyqIg0s9sBjjjP6Ppg1RgwjquLgdbmYrgOiUV?=
 =?us-ascii?Q?J5+5wTHHLAUbdvTHVh3QmKJYWGgw6ynpUvmoTHLBq7AqDRksRihgAw3WeB8m?=
 =?us-ascii?Q?Fpa34GqMOmSgNrzSHcZXW+tcIC9OoPzotNGv36xlLjc3FA16hUfFPwbiazCx?=
 =?us-ascii?Q?juh3wQ50CYZFp7FF2A/3TSTxIH/SGgp0vDtKy7wLn0rTsoe3LQIGs7xQECl4?=
 =?us-ascii?Q?wT2kkjKQBtTw7T6eLzvALGnIRk+sPoTJDkNV2iqnha3IDKNxztfDdeA5FZzg?=
 =?us-ascii?Q?IMLoM2x+oiGJOZifZTb6zqgRjYOVnul/cX50wxbZAFvII2VDrMcQE9abpTWi?=
 =?us-ascii?Q?OmYMzhgdxOBMkXbbmLSJT/vwg6+6N5p3Oefvy3XzsyASNNVQ5LDm8W4i+A70?=
 =?us-ascii?Q?hFwUagoW4xzBJsGSoXUKc9cIAI+7yUoNxb1FC+XqUGAMxoolqRU7rdDlE10V?=
 =?us-ascii?Q?MYCTKe90rDyX/smLH/JpgJb3E+ihQZUt3Ez5M3A4o/ESUT092C8zKQDCZIoM?=
 =?us-ascii?Q?tnZOjPlUHxmurgRg04xQqKV5peXaYNUh31CuRYbMjmQfc+hVSyj157Y5Pp6B?=
 =?us-ascii?Q?hUeZQQzyLD+Q0TVv9JvAWj/u6KUmbcXx9v0tCNkfiA0UDWQUAw+qsnTdh9GI?=
 =?us-ascii?Q?wM19uzYCE9ZlIvRHctx6GQ8LBYlGwINs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWjFL3n/mi+edZ19B9iO79AqZR3PbRPPSrD/UG3HCVHWChzx6p2l5JLCunIW?=
 =?us-ascii?Q?dokXl+eEoVEGDEaHOx3XW7L+gjh/CvF11hRv3ikgnOShEHYe3IuLtkdi1SsK?=
 =?us-ascii?Q?/uj1Ea9LLl2puG4KyTU01s2Vq0r6ZncF0ic8IyryAGMkodFHQIEgh/v+HtGY?=
 =?us-ascii?Q?9y44sFzWx6N9gA8MZqwVYOcGtxDfev+SVr6ERn4kY1fo/0aBXz41GfthXu2S?=
 =?us-ascii?Q?BkhZXa7QAkZPKcxV8v+ALktk8qa0R2ESGrQVXiepSM3uOW8+QMuQ8Gq1yYFT?=
 =?us-ascii?Q?zoGi7hdq3IohG0l5D5ofYkY7wuZPFi+nd/KTfKFckTd1AsTcha/ZO+Ln0q98?=
 =?us-ascii?Q?d6hz3HyVbWSFEKDoJx+SKY0C8f7OmI8jgmjzq+Qn9iHRUs5wgDXunFt6KuMi?=
 =?us-ascii?Q?hh0XRpCozD25eMQS3bduwLgnzx4wXLJScZoDy1haB0TNhzUJlMepxvR6ElHA?=
 =?us-ascii?Q?7NfcDdVoaY05lmrvgpycAtMCZf58DG5YfrTjjs61nOueEX8zbCubHDpRGfhq?=
 =?us-ascii?Q?Ieg38K1maiQy70A98w0sUolMWxcAO+gzKUTH+VTsOnkuCR86DbxmzQEpvMcC?=
 =?us-ascii?Q?RsChSPBNX5wB6Y7S8Lt+yaLv91Kzwp0URLzejrf8kfVv4Kvpcjy/djSCIKlE?=
 =?us-ascii?Q?UG6mVx4yrEiUOxE8u2JI+RDeI0yMd8WDZlkuSy9x7afiwP7DfqEXfB6jqFzr?=
 =?us-ascii?Q?78JVTxg20JkDRSem35jHdb7buqPbdO2r8tt/9Ek7bKXlFi1nNL0TVXMbsYlP?=
 =?us-ascii?Q?eKd3jTvDMtU/CpXk2BtLJVckIlnH7AWrhEUOkKKFYm6djt9S0HPiXjE1RrSu?=
 =?us-ascii?Q?Vnb/PXRzwLBnwTFkMa8yH9NmSgy9i6VJRwEJXFjF2s1snXjLIwYg04hqYF6G?=
 =?us-ascii?Q?gmaQFS+83NbK4MJzJtmR0OLvNFIAxbzSm8gLxUtpWYftCOl3SddcgrGYTMxs?=
 =?us-ascii?Q?HZ+446MeXfAM9jL7EqYjECFjplueYW8M+P/XzxaHFO2VJfEckcEHxkuh44d8?=
 =?us-ascii?Q?62lp4FSvqeIMq9ALYfM47l6z3i7cYlSm4YVyGb5Apv+FNuW9f8zLHBrlel1s?=
 =?us-ascii?Q?63nJhYAm7dmfPYhKDj5gkpQ3eZ54YJseJGSMKjlIJGZjUwywvqFK/YAuyKQ7?=
 =?us-ascii?Q?fAJ4Sl36jT8onRWeXtpnEPbtZQf99ad0thmiw9X/ySPPAfIVqUEuZXdoZosg?=
 =?us-ascii?Q?A/M5f5HlSAW4AASnsGM1qmg6u29+dPsGPjwjN5qUc+VPoIPT5ZpnPTIE0kJt?=
 =?us-ascii?Q?XBCpWpUUezztRcQ2z8b4wfVAJ8cKPKpB4cAf7ayUyjv7EUX2u4I8XC9H4PiT?=
 =?us-ascii?Q?YY9iKvUhNXADHga0YlChswJQgXPE2jACU04/zwkRrFUeusm9qYsgqVotNAH1?=
 =?us-ascii?Q?Dr+ZDmT1m4W/OYruXnvpyuKrVYiA4O6OOtl6PuLxw9Gb3TGStLv+y6syLxG8?=
 =?us-ascii?Q?6rbr2IyyrbslMbzPgqvUfm3pz/HzR5W1O77ahwQwaMze3/Lp24cuQi1llcUZ?=
 =?us-ascii?Q?6PaRp7aIVBPoGXBG2j7NQdKfbHcxB5nKjlf2nl2ObLQ1te9329RRmTDan5HB?=
 =?us-ascii?Q?jt3QY2PGw77hw1zB3AM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d0e63-1385-4b63-3e3c-08dd37401dab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:44:27.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFL+ywFITuVB61yM232zVbQCBz/qAWy40J+g7gkjnyA++JXsG+lvtKaT0J1ZcNwzhLYCRnI+LCdWrXZ7z6DpqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10598

On Fri, Jan 17, 2025 at 03:38:10PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 17, 2025 at 01:07:22PM -0500, Frank Li wrote:
> > Add CONFIG_PCIE_DW_HOST check for suspend/resume to avoid build issue
> > when CONFIG_PCIE_DW_HOST is not defined but CONFIG_PCIE_DW_EP defined.
> >
> > Only host support suspend/resume at i.MX chips.
>
> What would you think of inserting the following patch before
> "[PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume method"?

Okay!

>
> Then we wouldn't need to add #ifdefs in every driver that supports
> both RC and EP mode and also supports power management for RC mode.
>
> Bjorn
>
>
> commit d3b04bf25988 ("PCI: dwc: Add dw_pcie_suspend_noirq(), dw_pcie_resume_noirq() stubs for !CONFIG_PCIE_DW_HOST")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Jan 17 15:03:04 2025 -0600
>
>     PCI: dwc: Add dw_pcie_suspend_noirq(), dw_pcie_resume_noirq() stubs for !CONFIG_PCIE_DW_HOST
>
>     Previously pcie-designware.h declared dw_pcie_suspend_noirq() and
>     dw_pcie_resume_noirq() unconditionally, even though they were only
>     implemented when CONFIG_PCIE_DW_HOST was defined.
>
>     Add no-op stubs for them when CONFIG_PCIE_DW_HOST is not defined so
>     drivers that support both Root Complex and Endpoint modes don't need
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8c0222f019d7..f400f562700e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -500,9 +500,6 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
>
> -int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> -int dw_pcie_resume_noirq(struct dw_pcie *pci);
> -
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
>  	dw_pcie_write_dbi(pci, reg, 0x4, val);
> @@ -680,6 +677,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  }
>
>  #ifdef CONFIG_PCIE_DW_HOST
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> +int dw_pcie_resume_noirq(struct dw_pcie *pci);
>  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
>  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
>  int dw_pcie_host_init(struct dw_pcie_rp *pp);
> @@ -688,6 +687,16 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
>  void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  				       int where);
>  #else
> +static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +
> +static inline int dw_pcie_resume_noirq(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +
>  static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  {
>  	return IRQ_NONE;

