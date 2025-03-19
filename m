Return-Path: <linux-pci+bounces-24120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8DA68DAC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB65517CB9F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725642566D0;
	Wed, 19 Mar 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UATWJ8rt"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012015.outbound.protection.outlook.com [52.101.71.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4E2561CD;
	Wed, 19 Mar 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390589; cv=fail; b=cjKfZgooMXQS0FtSQZEc0V/5Ws33NBEdRzDfKfdQVRv+9ZIn2vCWKrK3r9cp7iNu2wMEhlTv+IlECB3gDtevPFge0Ow8l4LkU/bmnyel2UVdoACDiBxVq9uCjzftlIZ+MxCar8rhcpxrxhSEVbt9H5poXQhMemXDX0LZrva4EdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390589; c=relaxed/simple;
	bh=8SoP/6anSZt2IXooHItcvH99C0vDKi9XRAthmI2h410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLn7Q/mjiPC36+aickeZiNfhL4Kv/P5RJFXeqmriCcx3UdcWxwip0vHRsntfGfrthfUVKptsG6YzGnx1ao0RmoL4pSMMlZZCNu0vDhYsOwxCAcYjTwcZOmIhb2FLbiXuF+wV9Ijt+tKbi3rqF2JgWzvmR+JcCxsrH2oYOxbKxC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UATWJ8rt; arc=fail smtp.client-ip=52.101.71.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5xy9zvPbOrwXr79OGDRFfbkU+9qkPL8nIVRuPswjcZvX10C0khJLnWoscRI+Dx4f+T+dDwSDYlYRNaAzICGmUHh4PPhOyV7H1QSm6yRQ003q13pL4kRQ85ByuCR0tWRDgBO/7FvKermpbiBgKrOSPxTCYj8O2O5vyzOcLe6sOb5ld4T1ymiIOOoK8N1vc6pEFjaDFufemNptLRHLJIT54i5XOiK34sIs74IGG/e7ammYTQiZcvP10bnh17xfe2g2/q04qOdjgSBagAGcqn/t6JfiwGHW50DeSAB5wBC4O1W8tKKbHjnPBnjFJx4tCZ5wYW9Yb4FiTz+vEu7XXnfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnOMottt6fk1LgijeAg4vrH/BOvWCdfZhb2TyVU4pKo=;
 b=yDsqzD/xjE77zxJJyWuBJaeZGSuOjJxk9usdEnl8zCtQubRFBgG+HXG81bo56WJYBXoHKRJIMHha6hk8fe6khOwQr1nIQH2joHg/LRdat+gOqHKM+qIp8dBeXWJuMiV0E+KoC7XD7stHLhXYT8eNYEJWSTyfd+ohQ8+Nn0CGy7+U4JqxZ67s54Yr4lbyKb45/F8XpgZJfe2U+XCc2C2NSpIXQi+kDryfiJkmKA2FNsRLT/973LdcJJ9AE5OLiapapT0sW0TkumhUQJ3IDSYyOAYOGb5WUlgt+tTzBLCjAX9uden7vUl2nunGXDbdrz0PgFSRt7PCQyZ4fohZllCN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnOMottt6fk1LgijeAg4vrH/BOvWCdfZhb2TyVU4pKo=;
 b=UATWJ8rto+LstMvnP/MMslu99lBH1Uqqe1h+JypksmSxMuAd37i2LEL+nrHSGeHrdN6E2mOSxQKqyVaHFU5JKRUqlALFJR1KzE+3L1zXwC+RB2Y7TLfLSTIydPwFQY7OCiHTsZHHKLLthW1843oXCt1cx70vA5cQp0Xom67RXc/OuJijtAp+8vh3Dl6WxEFPS329AFlAxOrESk1eTJHp/5RP3iYGZ9f6o/K0XnBEJRIgiAx8bwb7IP7IsUaxOA7G9Pg4bXmex5NbTaXurNxlP2GlrTPeIVYbKgQ6OJbkckYuRCIKuYtZXVvdqGWd6WbzH1GDGLdgH0VlKCkn0sPX3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9678.eurprd04.prod.outlook.com (2603:10a6:102:23c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 13:23:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:23:03 +0000
Date: Wed, 19 Mar 2025 09:22:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <Z9rFLSf9bcGyJqiT@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-7-helgaas@kernel.org>
 <20250318153820.GA1001146@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153820.GA1001146@bhelgaas>
X-ClientProxiedBy: PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2d) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 358b4070-1292-4628-c3cc-08dd66e92cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/ivKcuNEeYpQAPMvRun1d1mAj8lHPg3p7V8/GXtjPeneUjUSB4QiBq4Ezxd?=
 =?us-ascii?Q?R7F5KIp+96hJnM/cXzP3D95kB5ABaMoWt1aJx3QvrBkQcbjfIslgR77kdZqz?=
 =?us-ascii?Q?0hsS5M+7O68l55bKdDK/7+n9XAS336MErFqQX9AuiA8VsVqj3F/8Wgrm00AL?=
 =?us-ascii?Q?2kTcgpcoi7V52kIkTDCG6mcy0oGM/35m98xvNIyESJZAb3tyjO6EgVxMAMNs?=
 =?us-ascii?Q?hZmOOgOZYqY7fZhuCJljq9eCKvb1isjnxhO7KKd+fXTHl0OTz77NX6fU6Oao?=
 =?us-ascii?Q?AlBmlBwe0bjGrnjrQaAeQhU/wXspCIYYeJcYM2zRfizAwisF478UMDHhkq6S?=
 =?us-ascii?Q?oOlIiojKUnaF08ysdfnATPU4E/JKvFoQ3Pt17wcP7rv4QqQ48ju88qVISlgY?=
 =?us-ascii?Q?4R2bjxqvOX4YAWbjDgLlvmfivCinmW2GTs5veRdqGjbb9dpzG74VRiwQyEdT?=
 =?us-ascii?Q?wo2xS3c6b9vQSlOHOemfif5ueC3JqlrfRWv8LnmL0xycvIVtopIWoUfCe7ya?=
 =?us-ascii?Q?DFHkQRUEo7lO/noB+ptEG7DCHjOYfG8w55FTJ12lhjDuQ6UgK9vnMFBfveCw?=
 =?us-ascii?Q?4SlqhUcUUSWrzR5fjChYR8GX758pC41HyGFRi9gmjF5COpJ5aC1/XaWTXrDn?=
 =?us-ascii?Q?GZ1spPpOfIcdd4OGnS2B28aaR4lJQ5j0fopQ3khtl0S7C2d9K62+ptQ0xtjf?=
 =?us-ascii?Q?J4WfY8ElhDCM97uh1/9RKV1Y6JVsyktvPbCdwCe/7vTsd3s0l+pUhfn6hPT1?=
 =?us-ascii?Q?nhpUer+6eiDoT8guXAuaTm9u4tD/G7mX9xu6Z2xE6lyIBe2etOZFGEYPQH6n?=
 =?us-ascii?Q?xjHC3gE2dhqBv91HJiOB7W6YsHQmwtnIteqE39ThZVc35Rgi9OqaG/SZbp0E?=
 =?us-ascii?Q?tU3BShcdHRs1kMgzGk2QZ0h0TaVGgD0C8yDckoawhyYn6UvMlXDzBz9KwVt9?=
 =?us-ascii?Q?py0dp7mdzXwLgTvWNqIXUBuhLG3Zht2q1VGZZBOF4aSDpMgZ9BIiJ0YMz5/5?=
 =?us-ascii?Q?K0/kaftYJ7FbZ5fF77yxZc7Sh8XJBjPFyYcuglvjOP0XRjDMAdwe1ZHise0t?=
 =?us-ascii?Q?KdqeDzFwp+VRMgFXO+Vd2+3XgxlSmlFzOGYIVGlwgGJ3E2g73IYurKvOWSmY?=
 =?us-ascii?Q?elXlbFKm3AlCKk5gdi4R/wqV9IpSkNxyKs0Mt/KURC2V4b20Qh0chPWwVzc5?=
 =?us-ascii?Q?y8Rvb9/zSf3DaPtl8WW/aC25WY4YqnqSMueeqAYVKkDD3n1cOIy0w3E1rtBH?=
 =?us-ascii?Q?wM/DBmyfn5Uh25V+tzMjP02Q6JF7a7EpHK8IS392vkI6ZIQNDNoH/0s0xyK3?=
 =?us-ascii?Q?8FwnsbsYyJNvfwqXxJX7oAyLP9EhmRHYAr1E7xFOmllazb9KPkteLc8Hx+jN?=
 =?us-ascii?Q?skm+Wh+Kn7h6uGW9Ey9vG5fmlqf8eojTRWQlL+NM51VYfay+CTrOIda/AGNl?=
 =?us-ascii?Q?KjnmdwX36Vfhf3O9h3gHyNEFX2loW++z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MipxnRwKea9x+cphvzKm78X/YC009Lg51Ce4etWhByENLnPavFYSKRs2R6Up?=
 =?us-ascii?Q?h8btdFCp9E0ZDvJlhYxyBUq5Pb/VXOS2lhkxgTeAAdScSK9YzyDUIwHDry7C?=
 =?us-ascii?Q?2HEyfJyAhRXwApe0OXnbGagKpRDozG/tT2eU/Xm9pnllILLv1+QCppyS+Jfo?=
 =?us-ascii?Q?BrozL9iuR3AjIDe2qePkLK3ktHlS10WPUlNOk2gaYn1b6HFPZFFzxtxR7bPl?=
 =?us-ascii?Q?W8lR8PFTUmGVA9eUNi0W16LPSgAYWoapVBr+hPFkI9VLjAbPisEFVb90+c9w?=
 =?us-ascii?Q?3/k+sMPBGOdfuKgSPy7JrLRVsa3oSZ2fGLvFC5LmeEt7bH1u5moX07IKeHXg?=
 =?us-ascii?Q?wvdkSXtQ22pjHKjbUclkLZJQ0tLnPMCIGSR9pIy7v9B15WNl/3vzOL5oNsNu?=
 =?us-ascii?Q?Ht4ZMbIspYlY6isTPNY/NKp2/ynYjbB8gE3EN2TAeTVzVT8vA4vuSSmUgLEJ?=
 =?us-ascii?Q?MmmHz0ew0mRFCNqbjYXF1V18Rr+IDP3IDUe9y7HLnjSvqjqqijNMWGOXZbLI?=
 =?us-ascii?Q?Q75XAPvT4KF1MNT2z9AjvEubw534+MzxWx/RI3dMFP+vfl9RdkpoBNxserJk?=
 =?us-ascii?Q?WNLtcrExKlP1s1voQtNwySmNKgfzz9Di18tp/rWfXtJ7DDr4RNbVDF7AHF3k?=
 =?us-ascii?Q?Uhg+jX34oP11LWOkc2148QXUoBlmJL1rgYTj1yc4WjRYvPNkMSSvEUjBOWX3?=
 =?us-ascii?Q?OP1OUwh31JxJeAmQxWw1VlkdgKDpEPNjx6+pvUqBKmmEmAUC5XeDQuyXEYyo?=
 =?us-ascii?Q?LGkFMXLsHOmdIpjabpKW6UjpFG0a+oMplPgQGuK8OqjBcoVgO6fo7WjeXUrw?=
 =?us-ascii?Q?AiT6VwmU7xCY93Xyy7/FJJ9f4iKZXjKt8MiPgd/otsHLZDhQnKVg2W/luVxU?=
 =?us-ascii?Q?jO3VFVTHQ3S6b0QtwXjOEb+cBTYcIVo9+tiAAG0DkvwWg4yZ1BgdVK3u0XHa?=
 =?us-ascii?Q?QMMgS6VRhDpZNgfCaRqzq22MkED2ja62B4F5sLN712r5LmI7QOTz5TWKM1sz?=
 =?us-ascii?Q?XPn9xtrx7PSJq5C3eZgWzVmrigoKBdRCm64kAiwW2n18Nl1XsRjlbaFMxVrB?=
 =?us-ascii?Q?EnEkMnA42Wz7h+/U3i1Xtu0d3TDudUdCQ4mNAUhpdBmTcl9ae3LTEHRSdu3p?=
 =?us-ascii?Q?evaCWbZadctjLNUu98Ik1Ih5FNH8PZehf+dKc5dgkyyw+zbe9TB1hgUrw0ZJ?=
 =?us-ascii?Q?XQqLm/+Mioo01NhK8UKSgtoUqNX+GmDewdwvl8X5avgpDtjp6ZyNNn5+jBtn?=
 =?us-ascii?Q?wB1uf9rnIAAXFL7p4crXKGuza1+CUbp+iImVUEOA25fQBmAM7bqP8FfN0JhS?=
 =?us-ascii?Q?ST5vnc28d7GB8bD8BNJiafP+U3N8T1CsBn4RzrTIdwm+Bj//Dqcq4iXo+TVj?=
 =?us-ascii?Q?WikzW/ao1859idPQwAGN1dlYCq2tEocJ29FvMGK2mrFnNTcFRLsGi+PK6CqH?=
 =?us-ascii?Q?5jJ1fhoWJr7rcMKIu5oeiBf0+H992Jnz/Ry++o+eoY4fD6mQLDl5hmhKafBl?=
 =?us-ascii?Q?Y5HYNToGUlSRtbv81+PJE6lgYjKEEVXfnDjNLNCj2kHsSyMlf1+FNpPP3p48?=
 =?us-ascii?Q?BRcpi8cLrwPx6S5mxmY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b4070-1292-4628-c3cc-08dd66e92cf4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:23:03.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WaemAZiMB5jwZBrt/8/mKg1pv8LHUsmqNZIonVcN39F+0xR9mWWoXdnSPdNP1Fq3ZKc585urax7Mh/Dhn76VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9678

On Tue, Mar 18, 2025 at 10:38:20AM -0500, Bjorn Helgaas wrote:
> On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > is a hard-coded way to get the parent bus address corresponding to a CPU
> > physical address.
> >
> > Add debug code to compare the address from .cpu_addr_fixup() with the
> > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > redundant and should be removed; if they differ, warn that something is
> > wrong with the devicetree.
> >
> > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > identical to the CPU physical address because we previously ignored the
> > parent bus address from devicetree.  If the devicetree has a different
> > parent bus address, warn about it being broken.
>
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >  	struct device *dev = pci->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int index;
> > -	u64 reg_addr;
> > +	u64 reg_addr, fixup_addr;
> > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> >
> >  	/* Look up reg_name address on parent bus */
> >  	index = of_property_match_string(np, "reg-names", reg_name);
> > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >
> >  	of_property_read_reg(np, index, &reg_addr, NULL);
> >
> > +	fixup = pci->ops->cpu_addr_fixup;
> > +	if (fixup) {
> > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > +		if (reg_addr == fixup_addr) {
> > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
>
> On second thought, I think this one should be a dev_info(), not a
> dev_warn().  We know the *current* devicetree describes the offset
> correctly, but there may be other devicetrees that do not describe it,
> and we need to keep .cpu_addr_fixup() for those other devicetrees.
>
> So there's nothing the current user can or should do about this.

Okay

Frank
>
> > +				 cpu_phy_addr, reg_name, index,
> > +				 fixup_addr, fixup);
> > +		} else {
> > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > +				 cpu_phy_addr, reg_name,
> > +				 index, fixup_addr);
> > +			reg_addr = fixup_addr;
> > +		}
> > +	} else if (!pci->use_parent_dt_ranges) {
> > +		if (reg_addr != cpu_phy_addr) {
> > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > +				 cpu_phy_addr, reg_addr);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > +		 reg_name, cpu_phy_addr - reg_addr);
> >  	return cpu_phy_addr - reg_addr;
> >  }

