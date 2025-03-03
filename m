Return-Path: <linux-pci+bounces-22796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9CA4CDC6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2269018955EF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5121F12F9;
	Mon,  3 Mar 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XiLUKuWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354141F0E2A;
	Mon,  3 Mar 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039149; cv=fail; b=OcHDUQhszrfI9gmuPfk8wRlQ98GsEw6TWIQeaK/Se6IRBm6pSl0eLUQzzUcft4V0r204jWfsF7PohSOYD1gAKISfgluHw0XpXFLbUBXJmjAaxRSY03Ay+HOdOXS5XJ4BkRz+9Genj6dYKKoY0t+w6p5KtSorVcmLtvvp52QBSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039149; c=relaxed/simple;
	bh=IR31zkCQMTUG7ZUsti1OSX3pH5rA6mgvH1T5yLhdN2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owS2jX6vlLwVRs8oPULT+tiopKYzTiO3gywk9wrgHBoDTnr7xksIcglK+/cDi1KrUT4quE5D86FWVcX/TYuljrfVaMK1uE/fYqotizK9wef5mj2CMdh4EUhAJLjFTDT8eYrKZ2onsDdEr2vfLsAfa79d1HnB8kXFb9o5IwYvcC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XiLUKuWI; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGsuK8M6mI0wRtf724ErKJDtjCvc1NpZYxA6m+OFUhUb2aAjcLJOM2j7J4/vyLwdxuKoqiFGB/IcucYvu1RBJMx5nBZpVdYK5vktYTMyF0QufjfAmqo7NvJ2T3LVOkahWPSUjXihE5VbJkpw1hRApt6rRYlMmZLEiqJqGDmtAlYfxnLSujGUntuwxUkslUf+WKCJPQayUo1ANZYO0sSmIFBzpvOOMDuPuW7KxQsqxpUqzIXeIQSa4Drd64U8DNHObWreP6DGkRWjoG+7SRXw+UugJ2XZVKJqEfyGVU8PR7wzybr2yfTHHV9OQ50VfwQhyv4ju6xdveX5CCk6YDFiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aTUAwKXUg9/Tgo4S4zYcikDxnpI32rMeKfY9HP7IQ4=;
 b=sNp9cme+OhY8jy7Ess5S8hkrJEKxVnvPcArHpeydilRSyWl/pA2eGH3TLsxEM/ZkT9w/88bYSO3Xaa1nTs8dIyfMHutQvyUmfOfE5KKCbqAyucAegXL+QYKjU9BHYN5ezlKPs9yhMEFmGvg8wwwfUFqomVpY3bmP95y0ckRT0DiEgrHdKIIIGZvFYewCQIik3/EOobm86oLbCQb0ufXLlQR2HdKCE1ZHRcj9yC3kg169sfITjfU8bQHHaBWEPUl2ibgaHsWAd9puxaXtB5QXps/ukZXu7UIeSm0pMtKGz06K98ddE2YIPkA6LiZg4UwP3BtZKeFQwstdKKpgIKYyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aTUAwKXUg9/Tgo4S4zYcikDxnpI32rMeKfY9HP7IQ4=;
 b=XiLUKuWIz169gPWQaJoRdNnnTNDoO1RjUdHW7wP+gJxINSiH85SlRWQzWw6sRUimFw2dCLXolUduYmQtRqFDg9Gh4uTlGbQWXTCliOPtumU0Zea+7fqpNvdu9ItUMRfWjk9LWAXcjJ8gmxx0ZKSEKSctkWtyhm+IH2SjUiJ53GUJYleXLWhAOvWp5USW7UgOm6zwmdxWZa3q5Kyu3NFyzjZAZoDhtk70lXzg4hAoTm8SrYHUNh0RotSyB5d60TwuCeRC9ZQBv5xmrdrqVG15nWp03RUxX0RZC8brMjk8t8E45kHuvpJ1zLoLlDDqNhmA/Zldko1aWELrjTY9MfdWuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 21:59:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Mon, 3 Mar 2025
 21:59:04 +0000
Date: Mon, 3 Mar 2025 16:58:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 4/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <Z8YmINgrQS7w0Myg@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com>
 <20250226233339.GA562682@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226233339.GA562682@bhelgaas>
X-ClientProxiedBy: PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d6234e-adc4-4bcd-d0d4-08dd5a9e9d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0hWO6YQ8nbvCN4gfLL3wO+FUoAgk//JFVLAOd9sfhSBWDkYATulFtrzSvKJ?=
 =?us-ascii?Q?a47U1JLv34IGKq8lw5Tvd84Z7iidaa9hTXAAfTLsNIfsgyf7I6pQYJnPcMn4?=
 =?us-ascii?Q?Ab2xBHvpe4BnImTexmNfftaKMet0yqiGFWv9IbsmHXK2bHUtX9blg1FZ8JKC?=
 =?us-ascii?Q?/Rv2ww0GMC5jdtVDezuKnZHWcB5rxy23qulSXGYfY7DY2Hxesuyy9ScP1iiN?=
 =?us-ascii?Q?kjhgLsMOjml4TceldIxamtizIuZO5HQObpge5m2KVxGB2k0CvHO8q24YJZb0?=
 =?us-ascii?Q?PjtpCkpct8GdYFCnBjCFznVyvegs5lZZS4hMisSFvtwQH5y6sq1khics+p9b?=
 =?us-ascii?Q?RXRiMwChjdp8cpKM56fR4D4ATY4qbxpzvYsaOsMr9gKjvtApdlpPrDRq/pp3?=
 =?us-ascii?Q?Rp1DdTNHDGodz+CQwGPJch43zHzBrk+sA3WBr1EptklNC96FXsWlJZNgjQV7?=
 =?us-ascii?Q?ExzwuaiqRA2lJhyIJgHtP9XvDg8Uj8Heguw/ZbL2gFy5JUIgMhP53rPFujny?=
 =?us-ascii?Q?3FeE8esD+rTErcuLONklKWhJnXIisrjo6++eVoFRjSoP3mGnlzhCw4b3LqDm?=
 =?us-ascii?Q?/lDDHsNtgstDtAzJLfLimKjpVD1jvoNpjGcEQtkBIwk1vg0bsXw+QL4/5ZHr?=
 =?us-ascii?Q?Z5ytDpaDszCbSHX6uW5NzhFD+qvgPbvm86lj2QjV0sr0Zw2u5mrvn+UdiDlS?=
 =?us-ascii?Q?4xDidkJBgZ4Sk6qHTZBplEy6sWRI7H4diwT2oxanJzhnV4R4t926cuwvctJA?=
 =?us-ascii?Q?T3Z6FrBidCJuN/IzcJ3X7eVjCODcU6//2A/VmAL8wL/fNPZbLFelNPdsVtcL?=
 =?us-ascii?Q?7bm6eJ972uDkVRJdgCT0J9zdifRWEJCqKZR0NyXMJuqMpa15IPYV+zA2nbDK?=
 =?us-ascii?Q?GveNOZjZn8qeVGEmH6XxuqzHTH3CBzemQoKlLzstQQxLCwaw1gnPkCtJNOHW?=
 =?us-ascii?Q?WYxP98R5YLH9MsJa0R6D/G+Phb5DkiJVcDK4Tbb+vctUbfeQ3E70VE487qaG?=
 =?us-ascii?Q?jkiMLiAtURj6bpymxRlR3crL/Eb/9ehY+UmmNrzvjxr9sFs2ai2sFEuVxx5n?=
 =?us-ascii?Q?0fQJyVefFi1KLj+3+tKktuXNl+VMT0lSF1+6+2t4q2EopyKy/ZRYowfFU758?=
 =?us-ascii?Q?ONSuKUB3Su1fw+9nguOn+efNF6IFcJL8clkzbLL/Z145OnuBOeysCWtCsKQO?=
 =?us-ascii?Q?gj0faCR7uzfGf5uBzefdRD+6ZX383QK5/XzesHLSKs87dPOsn8NjeNVAuVUB?=
 =?us-ascii?Q?Pqc0THkNFfwnEX9Ds+pQrEFyDXNKkS3ZQvMMkZKoWj5Z2t3217hwUmAKAVS+?=
 =?us-ascii?Q?gokXFTaEkrd9ijV+yazy5fltn3Et15rqOccxzKeKdVFHxdY2iEaGQG2qwSLI?=
 =?us-ascii?Q?ua2k5wG4gEaOCMkizaRiVt/t6ztIfEG8Lg3+8AFuh2i6BvX8jQYN5WkAFtNa?=
 =?us-ascii?Q?IoDYsn0Pz8CmNdHkodkL3fzsyCEkpykF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rLLPPO/CFV37ELDTgPJ+4MNrrinFQtWj4Rn3llDlKBuiLEEX0ao/EEV3I/8n?=
 =?us-ascii?Q?sT8d3iAimU9gJ0TpeyabxBR94KffC05c5wfq/SVAE4uPNmExv73P8EAH97cc?=
 =?us-ascii?Q?Q80asQDfAN8ysvM2sI7E0j8d+hJJY9JoD491qDReDZKqvfFL4SznKX8vK8+F?=
 =?us-ascii?Q?g65eEQ17NKDqEm/x/YKIn9FlTVT1mLif4CGUcvc3f48r1g7x0R6fnScokUbD?=
 =?us-ascii?Q?Ay4iniVqYHRUyJo10I3bVpRtfpM2s4rHTtd/F8bPG5t08pFHc13tEDJHbFYg?=
 =?us-ascii?Q?bCjcpdzvYW4FTVaSDoy9GPB57CwuvgMpr081PO8NYd5lV0R7nEnQVklxGgSU?=
 =?us-ascii?Q?lRMgqlt0dB/mLZJmHJq0CTutkW0HWAFmuGG8cz6QuDDobZ4+9ek76hVQBHKp?=
 =?us-ascii?Q?v0fIEUVkv1L72HdEalvpmkoUVszIem7WmzNeoDJT0K6eQWeXSAsyMzwlYtV8?=
 =?us-ascii?Q?YsHkHqU4khrhyxhyprzqxfN9HyfJ+v+EtffWJtd8Qu3tVEh/8pAQS5B3jei/?=
 =?us-ascii?Q?Z+QmO2Pmpfo7f2XeTXrRvJ1JTooQrDSrvUWWaHdOFUcL4yvkQ9qwaGcQkKZU?=
 =?us-ascii?Q?tyK/7yBXitDg8i+3c1H2xgJNDAI9G5ixOY6D4kkZJHyycMo84+ga5DmPPSSV?=
 =?us-ascii?Q?HttmGKuHuKwzLdi+z/U/FT2o0AeYENYASOKOuOq6glagCUOQM93ou5PNOPTh?=
 =?us-ascii?Q?Q4OXMpEvewvnY2Ck7Ps9YoYvDJiCp81OqrxUTFjWjYWTzXRCKlINo26Uh3c/?=
 =?us-ascii?Q?xGMtVa6LnagVEAiWRUvwUZwVSI2cIrV+RoQ12z4jXg1tC7RkVzgycR1rzXiE?=
 =?us-ascii?Q?cvXMG0tVxgWwT7YrggjChj3ie6KqP2AoBuyJ6qmZSfDUZ2iVUuFMrAkaOs3t?=
 =?us-ascii?Q?ltcdhnDJO5nsHSu7uRqZuURaUNc0WXJcdYcN+kvZgGnqWzw6JFG62WnGE3Zt?=
 =?us-ascii?Q?Xyf3uQ5B4sYfoIHaQLuZaNqeNBZWx4mQhYsu1H+3SQk71C5EAFom93lWcCT0?=
 =?us-ascii?Q?4dy9orfPNiiaKvMZTSdYtCjEiLl6w8OJVzjigcHF+iW1+aqUd1NczxcTB5bY?=
 =?us-ascii?Q?p86Stj0uY1UlRlD4dQtpmuqtgoRtFHRfj9cc2rzH8EIAztq0CFJHSGOQlXpm?=
 =?us-ascii?Q?i7/Z0mqw2qSJCTFGO5/40BXBkG1SN+NfyV7/E0NUMdiw3BWLiSz4Dltoz7cl?=
 =?us-ascii?Q?41lAzfP9Ny6iwf4QGfS3zVTnrPn0uCRo6qp69dmtig32EMu5qjCMlpYBgvXJ?=
 =?us-ascii?Q?N0D/KxCEvQH3LgOHKERO6GMGxPuwQHApmcT0JDZ2oDm+MYi6OdrJirdBGSgz?=
 =?us-ascii?Q?v82l/1+RtP1b+OpwpLro8cciQughaji4pQyOrzc0MWSP9S2wOJNULNCNYSFa?=
 =?us-ascii?Q?IyuDTGBHHIK1WdW0AWg5d/jfUrXGMOfyt3ofQoXROuVzt7sf8zjphJXTaIFN?=
 =?us-ascii?Q?gvbDFn0LsTn0v5YfMclFCixpSpJVKQPKuGoHGhRQjVZXnmF2IFWdkGT5aBXD?=
 =?us-ascii?Q?pz2zMEbFWQ9c5n92jO3jLdwkHN5BNqXYu3PNUzfZdnHUgtpTHE9bJNIo+NUh?=
 =?us-ascii?Q?0uLWLQfUK/Kr8aCCorvYMorvzYYjVhpLVw1UWjrm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d6234e-adc4-4bcd-d0d4-08dd5a9e9d2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:59:04.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4/gblCtvDGd4ogdnfgEiis5j6LZl63LDXOLzfKMUl/4gq2MqtN7Q+0X7sO2lS3wNbx53mMCEKGPr11d9qjrvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9910

On Wed, Feb 26, 2025 at 05:33:39PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 28, 2025 at 05:07:37PM -0500, Frank Li wrote:
> > parent_bus_offset in resource_entry can indicate address information just
> > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > map. See below diagram:
> > ...
>
> > @@ -448,6 +451,26 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	if (IS_ERR(pp->va_cfg0_base))
> >  		return PTR_ERR(pp->va_cfg0_base);
> >
> > +	if (pci->use_parent_dt_ranges) {
> > +		if (pci->ops->cpu_addr_fixup) {
> > +			dev_err(dev, "Use parent bus DT ranges, cpu_addr_fixup() must be removed\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		index = of_property_match_string(np, "reg-names", "config");
> > +		if (index < 0)
> > +			return -EINVAL;
> > +
> > +		 /*
> > +		  * Retrieve the parent bus address of PCI config space.
> > +		  * If the parent bus ranges in the device tree provide
> > +		  * the correct address conversion information, set
> > +		  * 'use_parent_dt_ranges' to true, The
> > +		  * 'cpu_addr_fixup()' can be eliminated.
> > +		  */
> > +		of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> > +	}
>
> I think all this code dealing with the "config" resource could go in a
> helper function.  It's kind of a lot of clutter in
> dw_pcie_host_init().
>
> It would be nice to assign pp->cfg0_base once, not assign res->start
> to it and then possibly overwrite it later.
>
> > @@ -841,6 +841,15 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  	pci->region_align = 1 << fls(min);
> >  	pci->region_limit = (max << 32) | (SZ_4G - 1);
> >
> > +	if (pci->ops && pci->ops->cpu_addr_fixup) {
> > +		/*
> > +		 * If the parent 'ranges' property in DT correctly describes
> > +		 * the address translation, cpu_addr_fixup() callback is not
> > +		 * needed.
> > +		 */
> > +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
> > +	}
>
> Can you split the warnings out to a separate patch?  I think we should
> warn once in every initialization path where .cpu_addr_fixup() could
> be used, i.e.,
>
>   dw_pcie_host_init()
>   dw_pcie_ep_init()
>   cdns_pcie_host_setup()
>   cdns_pcie_ep_setup()
>
> IMO these should warn if .cpu_addr_fixup() is implemented, regardless
> of use_parent_dt_ranges.
>
> I'm still puzzling over some of the rest of this, so no need to post a
> revised series yet.

Do you have additional comments, so I can post a revised series?

Frank

>
> Bjorn

