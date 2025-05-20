Return-Path: <linux-pci+bounces-28130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EAABE18D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0701791B7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2BE2B9A9;
	Tue, 20 May 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBbss4nD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD631258CF2;
	Tue, 20 May 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760901; cv=fail; b=qaboYawr0hJBAZFoJkc+3nrq1auGKTyVgX3M84A8drQU0m1XVrpvL5MXU96Exz9GHHV37lMLtzzHt+vb/sHb6BgX31KbnNYxd+UB8D0Qf38vhny9mcXHHkPy2O7d4gS7MjK6OMwFR9+DuGNCnLRHwdAkJaLiIPNFRKobgO+cY7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760901; c=relaxed/simple;
	bh=Mcc3pgRebJiD3QM8hr96cp4Lvmb5G/kqflViNdwm2w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TsILsvZ97MX6t5WueBOYfoHUkf13ecEjqUfvfzt/kGbdvZNPYN1+yjeIkpFcEeS+7KLN9E6j4xVaf0BBoTv9nGgbcmzWd4G5Kc94Mr4rJ7MJF0Hxm/IbtpRamt0ZWbYnsAxcNaDgEiyh5aBss4CQMs+5+cgkYVmM3+WjxVnoDyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBbss4nD; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4yIKlW14uFQYGt1GPvdZCRPSr9QARqPuf0IVJv8uH6dhd7MEZ83uKNk1dP3vS0I80V/XfZ9KExvkvJUqpVNwqPeiknMYdcY1QH8LgTJ/I8H4P/VJ4Ng4KdDog5mhD+JTy0NnDJpz9h15yh1lKI5twgwTAheVckqh2+93fjXT3tXl+dMUlMHIfk3Wq/ePVAGmdm0V2avw5xvzAz5rHM9mxe2vR8Hr5qfJOB3/pZcCALAme6N8TAWVjx8W2188dTm9F0PP+ltgQEQbMZCQTSXy9xVWdiiIht6ZajSwjYo4fHAeaP1huhlWB2PfpuuW3stiQ6/U2jC+kBMrJSnZT8uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84JtjWTUGGsJDLSGOSuIII7fcxsoJb9Z4sjlxzj7Lp4=;
 b=KZ9YvyL65SAOZvziykiG37dC+fFywcon/jKkxo/Xkwis7JIrN82Sxb6MwActwmZNLBH533iQKMm3d6QvefrBqZqMZU8URoHIxe0BHUYm3QuNLhvKFAGSxVGRzFi9Q+kNTtOS7dMJfPIdo/g7qmmzIKS2Y8qbN7luSkvHXYNDaie9f8VJ3qQzfkPysvB5GyszKU/Vp0lVvRy1wf1E5I81VKMxAu0stWEE+FBaCHmZWxZZK/Kp5Ni5GgZMSxhmLHvMIIrs2y/WyrCrpCsogS+klOpQPeXe+aGfSeT+Ds+MoD5O5Rjgd69nMzDKT++cTm0XJ9EZqrZD/y9mf2uBg1lPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84JtjWTUGGsJDLSGOSuIII7fcxsoJb9Z4sjlxzj7Lp4=;
 b=fBbss4nDv1AGKP2Ei3vUF/dACC7G5d8oAB1KAkqyjizYFu2wJwTKDLVaxyEllRuGWDz7pKNNy6DdPN7gU/LttKD21GFDAcu77nSw5PBPI85Gkw3CPpKaLYoHpHz0FPhC8t7G6qApC6M0OUkq//JvEMr90IFaX5LkqQUTwgHhDfuJn2EYWOuDgwxlXEAdKaq8KWdLyehTZYrzNi1k7A2Wwb4wP9UEgNez5bIr+iHDQEAQCLxJznJP4ROH+F16u3GyhC9wzgegJhTFWLBJ1wYVu83MQUZVlxUW3HPnNdTMkTuN06TGACLP4cv1XGopo0g4njusUXbyy8sQ5f0evsH5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8770.eurprd04.prod.outlook.com (2603:10a6:20b:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 17:08:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 17:08:13 +0000
Date: Tue, 20 May 2025 13:08:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 configuration
Message-ID: <aCy29TCa4t05r7q/@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-3-0e0d12b2fa71@baylibre.com>
 <aCuwy5ZjkhAiCPoZ@lizhi-Precision-Tower-5810>
 <1j8qmrn1tg.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1j8qmrn1tg.fsf@starbuckisacylon.baylibre.com>
X-ClientProxiedBy: PH8PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:510:23c::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b56c706-3a0f-43e3-7502-08dd97c0e7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6jSTGtciAtdKxMSwUWTR7a1FrkfPUfZDURaEBj76Iw6W5Dpv4Vlg9LcZhRXP?=
 =?us-ascii?Q?c+Tm8QeMwauPI77+eAB4/bF5FOrMi7uTq5K3yyDqmnFtjjBwi+pkiBhBROGO?=
 =?us-ascii?Q?cdKP/J9C5i+LAR6+0NCmkZd1C0XzwK2eFTVgJU2edGLKZKBS8kLh5r43IeN7?=
 =?us-ascii?Q?RqQsl1uUkGM73LCkxPcVOkdTVUgVjUggE2qKCRnatp/YbK7NAz4DFCQ1U9u+?=
 =?us-ascii?Q?bCohc1Z+fQxe9iuN3I7tTQeFZwQC/N9JJEHHksorjJykY1jTeyuz89KRvYjP?=
 =?us-ascii?Q?3MZfhSPry/PGAc+xbbJkeTFYSgFDr8dF4NmFo5J6zvwGF2n9HauEBoZRFktv?=
 =?us-ascii?Q?JKSHS5bx44YIMpIag8egn7Zbt2NZ8YvPBbmh6JJd5F8vQADNcXDXOX/3Ymdr?=
 =?us-ascii?Q?HPX4LyG4xHZ1mM9LxkOU8T6FKTzxBT9+PkfEj30uVbUfVUORrf4O8AKSAvDC?=
 =?us-ascii?Q?tVLn31Z4VkKxo3xuZOyqQFj/lMw+BeW3BzShuD999XImlAPtWIunqh32wUfp?=
 =?us-ascii?Q?GVjyEcdO1ibVcA/apNdQ4UtwUdRwB7sbK1aOjtlN1u4SewqIZsPJahHJdcZD?=
 =?us-ascii?Q?naUDE2fNgGEWxEAInZd/yTk9LmdwSh1fKJpMNq844PSG/p2Jj4qTXinPDTfJ?=
 =?us-ascii?Q?4FlORTJQAjbJJEKvurXMzrty1uhKXydeDaou/nszdScDiZMshENo7f3qrRoj?=
 =?us-ascii?Q?0G09jTw37xb1p59BRDzxBg+GVyvaMFH4gnyMJM3m5Nn5DTlWYZ92/RV0FQeO?=
 =?us-ascii?Q?11+uyEH9CW6FT40E2vO7NPO0deMicKdn63u74sIXn0IzLA8v5yUh5OLFcLkA?=
 =?us-ascii?Q?kZc8UA0UDNjD1K9oCgssUvvRPYb646z2IWSq8WOLT3fwjz8P/gxoWDyzFPUY?=
 =?us-ascii?Q?b+Ms9kWHSxp3wD27ifDqR02E2pCdXix3qwPICeYYWwmouvzvr1OABflzCsyb?=
 =?us-ascii?Q?trYFSezdqmfN8mzf4UbWCnTM8NxSPDzCLAbUf44Caq8A3DJ9sgh5MzuVjxBu?=
 =?us-ascii?Q?OoF3289PUNxOCoP0EeEcs9Isf1qF6EUvc+CFJ5oHodYN3d1R8CxlFEMdF+XW?=
 =?us-ascii?Q?7CZGZE9i4LanITabvL9iPdnQ9vUWEGDvgJrBGqcyO/LaLrLDmfMfTEGcjwE3?=
 =?us-ascii?Q?sMEVyljeltgY3SD5JiRxDVnccq0eDNY21mksLUkdwrOaLxJOrcCWsK7+F4yN?=
 =?us-ascii?Q?PFH1EvyN08wRz2QbRMcX7aIBFVCtY48oMBuE1fgM3XxpnqEtoZil6CTd9uz5?=
 =?us-ascii?Q?sv62tbiBaBbw6I41tQ6NfAwKFdIk1ABDpPqb5txIToritlEwcCITH/G0Illr?=
 =?us-ascii?Q?tWkN+BPlKenfvO/vQ1UhIbx6IP9GDafpG8SSTz2S3uap6Aw8pogbGsoHC/qr?=
 =?us-ascii?Q?KRoooKbBAWULDaEfyk7HtpKrIVELPSULvfor7VPnMZNLf8AsZLS6s8Oo8G15?=
 =?us-ascii?Q?aYoofdrZqvkxBqoYIfVBHFHfZTZwVs+goZm27DgPCrX59FfXtsYd1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbBJa6mshj7TL01nMxWY4cC7S6YIZh0yeq8dcduQoP2zo9bC5hOzl+ULziXB?=
 =?us-ascii?Q?XXZxmZfmmzsfSPxX6MfQzwdwEXtxhleP1Qg83HpgorOg4ysBOe+MOj14DCN3?=
 =?us-ascii?Q?tIvNsGB3Mqt3v4ZsEVdZ5/nPpK4cY6ffG/SxOpPzC2UpEUUtBhIfBCsbdmQL?=
 =?us-ascii?Q?CSPV/zyEPWdpu34Sw/8VmjLBedLiYxx8/QotOMaeX8fI1RsYGaRvlFhazaHE?=
 =?us-ascii?Q?uAU4rnBFgqTu0nAiWzkxWDu/O9ndYfTFRqUQ2eBq99iBEJ+JtTxZ84usZfmr?=
 =?us-ascii?Q?Z6pLo70z4G3uh5QD+ZAuezlPahpQho+LJEDPlY6W58qYGHl9s5iGRacmTus8?=
 =?us-ascii?Q?t6DlEb+OekH3ej/sj1S+wBHpeiBTt4H9XOBW2i2BBRxHHSioyrgTfojlYTRt?=
 =?us-ascii?Q?qOFc/2Ix/4CoWPUH2gE3xxMIB1P0CfFwh3NE/MjBZqyhCIjIgVA0dk79/t6M?=
 =?us-ascii?Q?qGxXCpM/FzWv4ukXu7qOc/O4icJHr5leFSbqvSgFE0Js7YJIz6j25Cet9dLj?=
 =?us-ascii?Q?d9Iu8SsRY5DuO1yTE10WVq7NBzJ0w/b5FptSWAwsWtx8gMRA6/Ub6PbpuZyW?=
 =?us-ascii?Q?jUC1SamNmtPYnszOCXRZW9QZmo/RuvzPd+JM+kdlNTeXYqVjgErnwrirHWJ4?=
 =?us-ascii?Q?FPXGOQiKx0Yg/yLM93DLLEOjo2UOVeJid5wd9D2HBpZ/ZC0J5Wp7uFoq6V1T?=
 =?us-ascii?Q?zKcQC8O7qo0NZHH3CUTjknTI4cesCXwZkoNpW3Gp4RGXx5X/T8uJByeS8YDx?=
 =?us-ascii?Q?FSJdlhyGUt7u4ZIVKucgfsQXiqjzUQoqIVxsfJpIuPk0hjuTSLIfODcJjAgV?=
 =?us-ascii?Q?goY5jzJnQ7TJZ5xLzAc7qlALoLALLMetNUdymARVtwamR8iKzo8civQz8+WG?=
 =?us-ascii?Q?Jh/ic4FZEAgrnHgrrWSoR8NnRhTNgkHYhJvOYfcwTsj7Heus9YH6KtOhPkRz?=
 =?us-ascii?Q?wAmsYBDMpOmm7LViTjLHDI1shmKT3ukBqv9uDZ9RdV7j4NaggUTqGUXWqoXr?=
 =?us-ascii?Q?KyK7HPYJF9IklhZjLKejfBCPbm4OxSqpIkFdAVQgIYzm80v0Zzj5P0Z8xOjW?=
 =?us-ascii?Q?qdJA1kwbLSahf21mhirbRRrp5AEzubmJFc1dzAfAWrI8EWJIunPkvgh3/Hnz?=
 =?us-ascii?Q?cY0F2jH9m9+dIbQytkY3Oc6b64fW4nf31Mr7J/AWGuif30YI+hD3gHCKoDy1?=
 =?us-ascii?Q?gNn8OnjLHoA0IBMJDbCyBlLsvIIA+TUFnSxDaaz92p2NRuPy+bcRgjswkX26?=
 =?us-ascii?Q?Kcg2L/u1bQy6wqT5AsaMa3/kmzVwMjtD4iH89gEmyhRqAr06irMqXHAn6Th0?=
 =?us-ascii?Q?4VWnZCNr2NEu00yhZkrzFRAK62VHM1EQSi/pzygJ+O82ZYyMDt2qU9uCvy0/?=
 =?us-ascii?Q?t6q1H88TjnbBW+V6Tfl2JikoNOV5bauCas0ZPsM/rne3cRywBiBkxALGCnoP?=
 =?us-ascii?Q?eV4lxofpIX/QntfawwXuOnlk2NiCUa2+KeIEobw9tylgiH8gmD6MfNIQnTI+?=
 =?us-ascii?Q?rjsYSvf2p80++FahHbCFPfZohEN49xsmb8AhO/YNt8lixYHkj+A2b8y/98a5?=
 =?us-ascii?Q?pIu+h6Avfe6Qk3qHx/2EbsnKQOplWUlwCkeZXgsx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b56c706-3a0f-43e3-7502-08dd97c0e7c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 17:08:13.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPtbKCgomlmPNN2uhRYY9GV1ymum81yweFbSdkjJs9bB7sdqS5R1dI7lc9EurGPZfyW/bSn2okVwgejMwgntmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770

On Tue, May 20, 2025 at 10:06:35AM +0200, Jerome Brunet wrote:
> On Mon 19 May 2025 at 18:29, Frank Li <Frank.li@nxp.com> wrote:
>
> > On Mon, May 05, 2025 at 07:41:49PM +0200, Jerome Brunet wrote:
> >> The BAR configuration used by the PCI vNTB endpoint function is rather
> >> fixed and does not allow to account for platform quirks. It simply
> >> allocate BAR in order.
> >>
> >> This is a problem on the Renesas platforms which have a 256B fixed BAR_4
> >> which end-up being the MW1 BAR. While this BAR is not ideal for a MW, it
> >> is adequate for the doorbells.
> >>
> >> Add more configfs attributes to allow arbitrary BAR configuration to be
> >> provided through the driver configfs. If not configuration is provided,
> >> the driver should retain the old behaviour and allocate BARs in order.
> >> This should keep existing userspace scripts working.
> >>
> >> In the Renesas case mentioned above, the change allows to use BAR_2 as for
> >> the MW1 region and BAR_4 for the doorbells.
> >
> > Suggest commit message.
> >
> > PCI: endpoint: pci-epf-vntb: Allow configurable BAR assignment via configfs
> >
> > The current BAR configuration for the PCI vNTB endpoint function allocates
> > BARs in order, which lacks flexibility and does not account for
> > platform-specific quirks. This is problematic on Renesas platforms, where
> > BAR_4 is a fixed 256B region that ends up being used for MW1, despite being
> > better suited for doorbells.
> >
> > Add new configfs attributes to allow users to specify arbitrary BAR
> > assignments. If no configuration is provided, the driver retains its
> > original behavior of sequential BAR allocation, preserving compatibility
> > with existing userspace setups.
> >
> > This enables use cases such as assigning BAR_2 for MW1 and using the
> > limited BAR_4 for doorbells on Renesas platforms.
>
> Great, thanks
>
> >
> >>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 127 ++++++++++++++++++++++++--
> >>  1 file changed, 120 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> index f9f4a8bb65f364962dbf1e9011ab0e4479c61034..3cdccfe870e0cf738c93ca7c525fa2daa7c87fcb 100644
> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> @@ -74,6 +74,7 @@ enum epf_ntb_bar {
> >>  	BAR_MW2,
> >>  	BAR_MW3,
> >>  	BAR_MW4,
> >> +	VNTB_BAR_NUM,
> >>  };
> >>
> >>  /*
> >> @@ -133,7 +134,7 @@ struct epf_ntb {
> >>  	bool linkup;
> >>  	u32 spad_size;
> >>
> >> -	enum pci_barno epf_ntb_bar[6];
> >> +	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> >
> > It should be PCI_STD_NUM_BARS
>
> I thought so too initially but that's actually not the same thing and
> wrong, if it happens to be 6 here.
>
> This tracks the mapping of function to bar number, not which function is
> assigned to a BAR.

Okay.

>
> >
> >>
> >>  	struct epf_ntb_ctrl *reg;
> >>
> >> @@ -655,6 +656,59 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
> >>  	pci_epc_put(ntb->epf->epc);
> >>  }
> >>
> >> +
> >> +/**
> >> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
> >
> > epf_ntb_is_bar_pre_reverved()?
>
> That would be mis-leading because the result change as the sequential
> allocation goes, so it is not limited to pre-reservation.
>
> >
> >> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> >
> > missed @barno
> >
> >> + *
> >> + * Returns: 0 if unused, 1 if used.
> >> + */
> >> +static int epf_ntb_is_bar_used(struct epf_ntb *ntb,
> >> +			   enum pci_barno barno)
> >
> > return value bool is better
>
> Fine by me
>
> >
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < VNTB_BAR_NUM; i++) {
> >
> > PCI_STD_NUM_BARS
>
> As noted above, it is easy to get confused on this but that would be incorrect.
>
> >
> >> +		if (ntb->epf_ntb_bar[i] == barno)
> >> +			return 1;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/**
> >> + * epf_ntb_set_bar() - Assign BAR number when no configuration is provided
> >
> > Look like it is find a free bar number, which have not reserved by configfs.
> > so
> > epf_ntb_find_bar() or epf_ntb_alloc_bar()?
>
> I'll replace with find_bar sure.
>
> >
> >> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> >
> > missed bar and barno
> >
> >> + *
> >> + * When the BAR configuration was not provided through the userspace
> >> + * configuration, automatically assign BAR as it has been historically
> >> + * done by this endpoint function.
> >> + *
> >> + * Returns: the BAR number found, if any. -1 otherwise
> >> + */
> >> +static int epf_ntb_set_bar(struct epf_ntb *ntb,
> >> +			   const struct pci_epc_features *epc_features,
> >> +			   enum epf_ntb_bar bar,
> >> +			   enum pci_barno barno)
> >> +{
> >> +	while (ntb->epf_ntb_bar[bar] < 0) {
> >> +		barno = pci_epc_get_next_free_bar(epc_features, barno);
> >> +		if (barno < 0)
> >> +			break; /* No more BAR available */
> >> +
> >> +		/*
> >> +		 * Verify if the BAR found is not already assigned
> >> +		 * through the provided configuration
> >> +		 */
> >> +		if (!epf_ntb_is_bar_used(ntb, barno))
> >> +			ntb->epf_ntb_bar[bar] = barno;
> >
> > missed "break" ? you find one free bar.
>
> No ... the while exit condition is already correct I think

You are right.

>
> >
> >> +
> >> +		barno += 1;
> >> +	}
> >> +
> >> +	return barno;
> >
> >
> > return ntb->epf_ntb_bar[bar] ?
> >
> > if pre reserved, while loop will be skipped.  reversed bar number should be
> > return, instead of input barno.
>
> I don't think so.
>
> Say a config sets DB on BAR6, while still having everything unused from
> 2 to 5, you'd get stuck with what you are proposing. What's done here
> emulate the old behavior while making sure we iterate over all BARs
>
> That being said, mixing the old ways with explicit config would be weird
> but it is possible.
>
> >
> >> +}
> >> +
> >>  /**
> >>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
> >>   * constructs (scratchpad region, doorbell, memorywindow)
> >> @@ -677,23 +731,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
> >>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> >>
> >>  	/* These are required BARs which are mandatory for NTB functionality */
> >> -	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
> >> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> >> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
> >> +		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
> >>  		if (barno < 0) {
> >>  			dev_err(dev, "Fail to get NTB function BAR\n");
> >>  			return -EINVAL;
> >>  		}
> >> -		ntb->epf_ntb_bar[bar] = barno;
> >>  	}
> >>
> >>  	/* These are optional BARs which don't impact NTB functionality */
> >> -	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
> >> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> >> +	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
> >> +		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
> >>  		if (barno < 0) {
> >>  			ntb->num_mws = i;
> >>  			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
> >>  		}
> >> -		ntb->epf_ntb_bar[bar] = barno;
> >>  	}
> >>
> >>  	return 0;
> >> @@ -861,6 +913,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >>  	return len;							\
> >>  }
> >>
> >> +#define EPF_NTB_BAR_R(_name, _id)					\
> >> +	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
> >> +					      char *page)		\
> >> +	{								\
> >> +		struct config_group *group = to_config_group(item);	\
> >> +		struct epf_ntb *ntb = to_epf_ntb(group);		\
> >> +									\
> >> +		return sprintf(page, "%d\n", ntb->epf_ntb_bar[_id]);	\
> >> +	}
> >> +
> >> +#define EPF_NTB_BAR_W(_name, _id)					\
> >> +	static ssize_t epf_ntb_##_name##_store(struct config_item *item, \
> >> +					       const char *page, size_t len) \
> >> +	{								\
> >> +	struct config_group *group = to_config_group(item);		\
> >> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> >> +	int val;							\
> >> +	int ret;							\
> >> +									\
> >> +	ret = kstrtoint(page, 0, &val);					\
> >> +	if (ret)							\
> >> +		return ret;						\
> >> +									\
> >> +	if (val < NO_BAR || val > BAR_5)				\
> >> +		return -EINVAL;						\
> >> +									\
> >> +	ntb->epf_ntb_bar[_id] = val;					\
> >
> > do you need check the same val to assign two difference ntb bar?
>
> I rely on the user input being correct indeed. Worst case, an allocation
> will fail later on. I could try to implement something in that direction
> but will get complex. For example, I would eventually like to allow
> sharing the BAR for DB and MW1, as done on the NTB function. (The idea
> is to get 2nd MW and enable MSI on the ntb transport but I'm not there yet)

Okay.

Frank
>
> >
> > Frank
> >
> >> +									\
> >> +	return len;							\
> >> +	}
> >> +
> >>  static ssize_t epf_ntb_num_mws_store(struct config_item *item,
> >>  				     const char *page, size_t len)
> >>  {
> >> @@ -900,6 +983,18 @@ EPF_NTB_MW_R(mw3)
> >>  EPF_NTB_MW_W(mw3)
> >>  EPF_NTB_MW_R(mw4)
> >>  EPF_NTB_MW_W(mw4)
> >> +EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
> >> +EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
> >> +EPF_NTB_BAR_R(db_bar, BAR_DB)
> >> +EPF_NTB_BAR_W(db_bar, BAR_DB)
> >> +EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
> >> +EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
> >> +EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
> >> +EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
> >> +EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
> >> +EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
> >> +EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
> >> +EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
> >>
> >>  CONFIGFS_ATTR(epf_ntb_, spad_count);
> >>  CONFIGFS_ATTR(epf_ntb_, db_count);
> >> @@ -911,6 +1006,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
> >>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
> >>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
> >>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> >> +CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
> >> +CONFIGFS_ATTR(epf_ntb_, db_bar);
> >> +CONFIGFS_ATTR(epf_ntb_, mw1_bar);
> >> +CONFIGFS_ATTR(epf_ntb_, mw2_bar);
> >> +CONFIGFS_ATTR(epf_ntb_, mw3_bar);
> >> +CONFIGFS_ATTR(epf_ntb_, mw4_bar);
> >>
> >>  static struct configfs_attribute *epf_ntb_attrs[] = {
> >>  	&epf_ntb_attr_spad_count,
> >> @@ -923,6 +1024,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
> >>  	&epf_ntb_attr_vbus_number,
> >>  	&epf_ntb_attr_vntb_pid,
> >>  	&epf_ntb_attr_vntb_vid,
> >> +	&epf_ntb_attr_ctrl_bar,
> >> +	&epf_ntb_attr_db_bar,
> >> +	&epf_ntb_attr_mw1_bar,
> >> +	&epf_ntb_attr_mw2_bar,
> >> +	&epf_ntb_attr_mw3_bar,
> >> +	&epf_ntb_attr_mw4_bar,
> >>  	NULL,
> >>  };
> >>
> >> @@ -1380,6 +1487,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >>  {
> >>  	struct epf_ntb *ntb;
> >>  	struct device *dev;
> >> +	int i;
> >>
> >>  	dev = &epf->dev;
> >>
> >> @@ -1390,6 +1498,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >>  	epf->header = &epf_ntb_header;
> >>  	ntb->epf = epf;
> >>  	ntb->vbus_number = 0xff;
> >> +
> >> +	/* Initially, no bar is assigned */
> >> +	for (i = 0; i < VNTB_BAR_NUM; i++)
> >> +		ntb->epf_ntb_bar[i] = NO_BAR;
> >> +
> >>  	epf_set_drvdata(epf, ntb);
> >>
> >>  	dev_info(dev, "pci-ep epf driver loaded\n");
> >>
> >> --
> >> 2.47.2
> >>
>
> --
> Jerome

