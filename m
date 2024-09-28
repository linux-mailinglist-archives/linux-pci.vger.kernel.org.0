Return-Path: <linux-pci+bounces-13616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316CB988E04
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 08:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AD1F21EAB
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC419A282;
	Sat, 28 Sep 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N7l5NuQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD74A08;
	Sat, 28 Sep 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727505864; cv=fail; b=KkTT4rzW/1UZbi09FYKRLC60sUG81Gvn9UJlIjoBUFOK9ohR9DAaGtB1bo6kQ9RxNt69baRiA2H1RdMZzhvJyGUEWzfXWrH45Z/zhvbOGvMVSYcyRVAiQstp4+HVPdsZwGZML2R5YaBNruP9ZBGpHJUfu+K7i5Esd6KXATrfkak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727505864; c=relaxed/simple;
	bh=tdcDEML5qw3L+r+YQ4tPYrsvxfmKeELyHmEN7bBdnRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B00FSAzx3XUzo0F1yKwS88a77arQAayuTEOhkg44LKPmzDJ9y2lgNKIXGTjE+fUK+w5eFtYgN4UuO1mIWG43HoRk9bLNn4bUh4YSooqlk5dLcYqUMAoXimF1hJop1ql7za/xnbx69U3Qfn0YNkFHbyV7PxT70gXev4ANsBDSvKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N7l5NuQv; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYZYe6JB6EhQpvPA0lq0lvf6snCs2QN1WQmi9Onp4KtagDTZcwe0eF/zjaf5/VbIO61PVcsT8tIr7DANQc1j0v3dor6bFypuN7SZsGBdVZhm7/38kMEic3MfG2Ts+4j0H/VFYHL16Wbc+9oZoaIL4BWrE/k0hldSwYcnJpv60sLQ7kYlxUOJBqP93KREeBYvND8a/1XcwkCDMHCpHWHX1wCHx5XPT1DybfdQOkDn5/JAR93802xfSv2Y9QiyuIwCAIF1Z/dliFWKRy/TSmAdwPC1OGRZisvHOkZzRToQcFFeFPChWVorYiBPfC2Pim7u7peRS4r/d7e1OcfMx1wRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyLvOTjs6AJj8/y+6i/9ICIOxADZ1js71i0dhVhTOX8=;
 b=aoG8ul0T5kAgnICIbj6hYCrba6RzW7vA1EHDZ4OHs78WlJvQwXnz+CIAJQc3SJ9ozx8BmiZGdjdBnNfhO+skBvU/PF5C/P37mjs0pEHGFS+eP7CJLQakoEuzc1+N2zHJsxr9g+/+0UQyHj3ZylCBZwOd2Vgl5i5yUZv0Ru+FqQRsmLhiZMzHvU4S1Zo2BsjH2vXRtqvIHDzhKEPAidalcX4yVou0dAMEIcIgQF1Mt6XRlRVlDt2NYDvLNh0fWLA1K5al3NX8E8o40NHCkPYEEyLm3QPFrzOF1YCvYBpQvm3f38qk1bJVuYaTHeXN7unT3ZEcXW0kQClAOhLJxZoibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyLvOTjs6AJj8/y+6i/9ICIOxADZ1js71i0dhVhTOX8=;
 b=N7l5NuQvYPmkEXIJTjSADz25OcMAcbfgPRzXMLleLte7Z1bOeaYR+/8akHasmirIlyomgNUWepmqt3LwGaaW9XtloPYbO655Y+C8F5MVdhfE9c0x/Yma6rcmGAZO3urL0F+Rkl7nKk/dF5nQRhzqZThFN0joXJ1hqO2MeJHemJJt9ZaPBvjWw+D2dcAN06POP+hsNOoV1W4zejv+2/NFibIM+yokHAOk+tFuOOBFY3+RFtMQEkjy6nMTCFLSaVU42YYXiZFrZZPYRU9736nPx441JoygEu4CwfB2no7W9r7QYxdl20HM2ERycg9VJVQRDN87Z+tPLlg4Aox8XHsclg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Sat, 28 Sep
 2024 06:44:15 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8005.021; Sat, 28 Sep 2024
 06:44:15 +0000
Date: Sat, 28 Sep 2024 02:43:50 -0400
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: imx6: Remove cpu_addr_fixup()
Message-ID: <Zvelpl76mYccxwFY@lizhi-Precision-Tower-5810>
References: <20240926-pci_fixup_addr-v2-3-e4524541edf4@nxp.com>
 <20240927235444.GA98792@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927235444.GA98792@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: 629b2253-cb01-4a5e-6beb-08dcdf88f041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTD1aJFuLXVz+uTKGcRlQQFpLpDB9F3SDjRDI4dEN644YV5PlS7oeIB5Kmyv?=
 =?us-ascii?Q?o8YJKAjIv/q3k96tvUc3YXYUEY8V6fYsvytewmxOQfslZGFgHzJLxQTOHSOj?=
 =?us-ascii?Q?am2AFb7I2dzvr4J8lybyFN0e5AO6afkeirZqXfI60XdmWIHxw2alVb7bSnhO?=
 =?us-ascii?Q?S78Qeb/pfH7AK11ClI10cyHRIQxslYvfPQ9UnY5WIW5NA6g7ckimKAnJL2J0?=
 =?us-ascii?Q?9maAcpIW7P0+AR3Wp0EQwuxhcPGh7TwrZTU7ErjhKSJn/GyPgMOtty5NpH9r?=
 =?us-ascii?Q?1tEUMSUuLqoKbV3VRl7XiKm/8yIulDBXxhZHaou6KkNEwnUejst4hdFLz6S4?=
 =?us-ascii?Q?DJ9qcU+MAeXPMX6Ys2AFiIaRDW95+F1nwcru6mG2LBuUyZvYAKSxUBjoAlnH?=
 =?us-ascii?Q?2x3/mGHYZ2fZkd//V3E+BHgWzMYFrRdizwxT2RrVOks+viPCMun4nZvmbEaz?=
 =?us-ascii?Q?Mg37L1gEaSpe6j76Ge45Rbil0BDpNm3bI9TjRAa0N8H8WCCI7gq6FdBSbLpN?=
 =?us-ascii?Q?SwOK92P+XPEPVHmiFih+Nb4uo/yL4+8NLWdBvlOO+qmSxOmdf4RYQRgUJk29?=
 =?us-ascii?Q?LSaIv6ryhEBgsEATEmmx+YC5bOy4ogFF1OxGMenfoZlJFzEA4UrZgcH0JBGZ?=
 =?us-ascii?Q?v2jP3mNK0bsbrWH5P0n3vNJTvAaoVZUzMormhS1a8W24cx6851rDSWiuaKtd?=
 =?us-ascii?Q?YPfyL7pRJmk0s7EODt8u3k0CxkH2LCU/+VlQF6ZOqKxVzB+EQBY0H0eSo0vy?=
 =?us-ascii?Q?m6/BE83CoGeNwUeFdEmrNdKfGgAdflktkF1T5TIM7GBTPASP13o8XcEtWZgG?=
 =?us-ascii?Q?pbrpSq6M4T6xIkd6dtFiccQk2y2/IRAUXDGOpR2/qES7FPAfJaV/rc/7eUbi?=
 =?us-ascii?Q?PsWP0Povv4CcmAOiW/4O0Q/I31VagSogc4mnx0EvAE/DJZCef1H5H8IbY75v?=
 =?us-ascii?Q?Ps+GR0BVYE1o+nRff4goq1LWipuVeIxwJsUblPEyoLBcsmAVEcHNw/cuBslb?=
 =?us-ascii?Q?rmpFdEzvm8gN0kt08WjRGdT1zub/9cM29Ok3U9qJGCFiWUeQZbGzV6Nng9e6?=
 =?us-ascii?Q?KXXOBkW0mXxK+7pZClm7hRlKEJGwrQyo3glPe703rNA6bcIadWEwPox8Bq/y?=
 =?us-ascii?Q?DkGB8twtyF02Jt8DbHPtlrLr4aSL+472JLAvNZ3UqRITtVT7W5WE38+gsYwz?=
 =?us-ascii?Q?Ui4eiqCTArndFVZU8FdEeeQ2VAE6s9CPAqf+xaSk0W6ghnYIn/M+hIavE8ag?=
 =?us-ascii?Q?yFzQuaQX/duUk3X0akwPKbKM+EK7ckr12neRScf9Mile7Gk4NUjJLNn44OOb?=
 =?us-ascii?Q?yNBz2v98Qa89YJchCSokdoP7dVs8J6HArOXvyWa8mhBfgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaxv7EccsRoDPY65ZyEagA+SGErFrTGMhMyJKpqkGVIqujhyT54h6ZXNrWm0?=
 =?us-ascii?Q?LbcEPmXmZhs78vaO9X0j+IG0S0uEGGcAV/NA+Dsrhi9yiAnV1nZP15xy/BXy?=
 =?us-ascii?Q?PMDix3QPIVP1wW19dL7MsNcJwGBwUcNAJ/NUqfvTWNM2UkmhD2CBYJodeuYM?=
 =?us-ascii?Q?cGQ302ZfukaOJDSXcmjxJxSnjxZkHWVzuD72WwCNZfei5MpeCgiclyC04q/6?=
 =?us-ascii?Q?juJz+M4Dd/iCf5fih2+6kX6L+m0x5YXHkGwT3lUr8ivevO+ZzX3e9xwEttlF?=
 =?us-ascii?Q?qp9tw8VPXwX3RDgyzvlE4LFj955eBDwc5aCj8LHHCKDUh0R5LvU39DrycI/z?=
 =?us-ascii?Q?cLW5ZPXv96d0gseCvUvmX++ilSr7M3yu6mPjwAZkrK/Shc9pKNJ0bcWbqnR3?=
 =?us-ascii?Q?WGQnZiYRbgC1BR0vA2Dt49kSjBGDFlKKJ1CHJdcLwBqhBhSLjfNtDzLbnNv2?=
 =?us-ascii?Q?DMZH2tY19LEcUdUktb5xs8WvCBEbJHe6Zfvl8lctNeAyfnlbAhz8U2juGejp?=
 =?us-ascii?Q?rjYxp9NrDbdThaTyyr0OAs4cVaLqRLj6uUTqiW5pblTislR7yGZlpt6OsJN1?=
 =?us-ascii?Q?4ugymQtZWWe4ZuGCpBT/1tDMEVF4QWNgfhp8+1eHJfqGu1ELyhXUfxM+PZE7?=
 =?us-ascii?Q?DdPpFYrZ4dAmCCJH6vNEBEPMZWHpk0DX+BsspacO6P1GYFYAEjI1yII8mmfp?=
 =?us-ascii?Q?ENUIg+EArJ/DSJt/mCBwjNKLHqdCibAnhFYQIEV1zYEaPQmbTfrglbcTkc5u?=
 =?us-ascii?Q?hypKnyZHOmR8JitTDC3zgIXfcTSWs7yWorg7fMjU6Vrl+ggy6fBJFsI6y/k0?=
 =?us-ascii?Q?9QSPGJtmjhzPCe3Y3xTOifrAeOUQKjiehAAQF91lbcp4XIqUpUnARDoFofR8?=
 =?us-ascii?Q?kzf8SgkL43eKaIMi4Rmlkr5V4NpXg9DyAWRpTq8QZMYK8rJtVU/bDrwlWAIX?=
 =?us-ascii?Q?+StFHU5dU4XW8r6G+9753LjobdBzj5H6xTmxAKCXHCb6BmJrqbztvA8H23uN?=
 =?us-ascii?Q?mav76SLubQHgy7pjf5HvdOarvK1x7Mdxknt4bVg6Sz4PXVQxJw5Nzmps0I3y?=
 =?us-ascii?Q?BxQOlc11fls7qczcTK3YelvTEK7Hl23CJJfeyargLXo//RMS3Aa3A7hGn6l8?=
 =?us-ascii?Q?ESKu2NNAuEIDSgiRTn+4vt9hOnTOQ5yqNN2KGnDh5diCa016N9Sm+BB+8uKg?=
 =?us-ascii?Q?fBUvbU2FJMfvxsWgAP/KchEcjyVuXMgcxjoLIzcV2Eta9x1f13v923+FVk0r?=
 =?us-ascii?Q?39dzW7oFFQGdd8YGxkyuVD+oVVl2wJwBqhVyp1yOVQqupFyxN4+SI8XTAtFj?=
 =?us-ascii?Q?WIoKnwA6ecm9/J0qHgkmgd58vDCqeqdVz/mLaOiy5UOHZEGnwbm73aa6bpYe?=
 =?us-ascii?Q?jttnYaN92/kXroGqWkT602paH0xq1pOJrfmHHZPYAzPyO762/+qHb0JhzwAR?=
 =?us-ascii?Q?VA+ztD2WspmowtnNC9nN+/CI/WZT+uAJCEnEtPI8aTk3z8zpcD8CMfUWtLOA?=
 =?us-ascii?Q?L0BwsVHwEBdl8djfjPAlOfjhmXs4sf6DKDCcc36gnvzjSpgT929PJnk4G7zz?=
 =?us-ascii?Q?2olG8Ke3LDNneMf+zmM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629b2253-cb01-4a5e-6beb-08dcdf88f041
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 06:44:15.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZOb6CZ0Iyhaj89ab3MNCVj0L9REUmMJs7XeSOyw6qR4320TffLPEwoJYrcKUBzFdq3m3BH/OPk4l3NebE/oEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568

On Fri, Sep 27, 2024 at 06:54:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 26, 2024 at 12:47:15PM -0400, Frank Li wrote:
> > Remove cpu_addr_fixup() because dwc common driver already handle address
> > translate.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - set using_dtbus_info true
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
> >  1 file changed, 2 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 1e58c24137e7f..94f3411352bf0 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -82,7 +82,6 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > -#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> >
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >
> > @@ -1015,22 +1014,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >
> > -static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > -{
> > -	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > -	struct dw_pcie_rp *pp = &pcie->pp;
> > -	struct resource_entry *entry;
> > -
> > -	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> > -		return cpu_addr;
> > -
> > -	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > -	if (!entry)
> > -		return cpu_addr;
> > -
> > -	return cpu_addr - entry->offset;
> > -}
> > -
> >  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  	.init = imx_pcie_host_init,
> >  	.deinit = imx_pcie_host_exit,
> > @@ -1039,7 +1022,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.start_link = imx_pcie_start_link,
> >  	.stop_link = imx_pcie_stop_link,
> > -	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
>
> This is tremendous, thank you very much for doing this!
>
> Have you looked at the other users of .cpu_addr_fixup()?  It looks
> like cadence, dra7xx, artpec6, intel-gw, and visconti all use it.
>
> Do we know whether any of them have to deal with DTs that don't
> describe the correct translations?  It would be even better if we
> could fix them all and we didn't need using_dtbus_info.

There are two case,

Case 1: .

bus {
	pci {
		ranges = <MEM: C, B, size>;
	};
}

Need update to

bus {
	ranges <A, B, Size>
	pci {
		ranges= <MEM, C, A, size>;
	}
}

The good thinks this change don't break back compatiblty, need change dts
first then remove fixed up. but it will be problem if use new kernel with
old dts.

Case 2: use fake transalation

bus {
	ranges = <0x8000_0000, 0xa_80000_0000, size>
	pci {
		ranges = <MEM, 0x8000_0000, 0x8000_0000, size>;
	}
}

This one need fix ranges first, then remove fixed up. The same as case1
it will be problem if use new kenrel with old dts.


Anyways, it's long way to remove all fixes up. I have not these hardware
to test change.

I feel like use using_dtbus_info first, then remove fixedup one by one.
after all fixedup removed, we can remove using_dtbus_info.


Frank

>
> >  };
> >
> >  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> > @@ -1459,6 +1441,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	pci->using_dtbus_info = true;
> >  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
> >  		ret = imx_add_pcie_ep(imx_pcie, pdev);
> >  		if (ret < 0)
> > @@ -1598,8 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8Q] = {
> >  		.variant = IMX8Q,
> > -		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
> > -			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
> > +		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
> >  		.clk_names = imx8q_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8q_clks),
> >  	},
> >
> > --
> > 2.34.1
> >

