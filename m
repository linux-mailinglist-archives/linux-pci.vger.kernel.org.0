Return-Path: <linux-pci+bounces-3060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFA847E02
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 02:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7793B2265A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756C280A;
	Sat,  3 Feb 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hLP+NBkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD310E6;
	Sat,  3 Feb 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922079; cv=fail; b=B8lP7B3BgIZDAnTjsmDrM3anpnznH4DpdXJ+lwxPz1CSBgYLKP5NAVmOySrFBOtbvEgQ691Ezh60OXBSrgE1fOyGydvzEM88yxvAAI8hiinqgwFmIeOt0VwExceA1Ezs3Cc7XoVWP/1AyR4b8+GlznUjPpPGFnxzrKXyI9okFwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922079; c=relaxed/simple;
	bh=YlZ4CL/EHNH6OuO68tyuzzD9eCjFovXogcfuNNNVrL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMuxNvpcdIJeU65zA+LujmJA6LkJS3ybf7iPFtMyN0n2ZAU04pQ7tB0SQBLrhn2hRTEY0vyG3pgYwX6Nz9lLhoqkNVFXRiJAOPENejt9EQw9nOtcjhogtskShgl9nQq5PHP4CGU323UMYEzMi8zuYWu7J1R0AlKj0Qfwl68aFuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hLP+NBkD; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOZjMtoSsnyWxKHbBq4b81Ea8Qpn0fD9+2mEjErGJWqzEHYdOyrjpOdflAxwr3y616HQsIdAEQEDjrq59zEywh6HTK7xj1cOCIgJgEHbh26dB7bKO+tKDS4OrmFQ/wbGCLgMlvETE6WjZLoL8qKwX5KF27ynw5kAgOdratekIBFgoP98HkcXVL+Of8szge2Zk7wBbXONhTwbcjK5Gfl1qJD/Hrf+FsjGL7GFVJkJxJedI3Cy8zJ02VSCW3sjMBmbT+SZXcs8aComtCJ+vbbZyU8b9luZFkJw1c1q++BKuCzJe8K3tZ4aduth/as1mXdnYP7timMr2KPLoyZ2FtQ8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2x7qCQQufb53CvI2fg83Lz/BQ2+FhrWDKcI9pC4YZ4=;
 b=eeNJXJmR86z6LU9lgMbxzB8WF6xp6iZL+AhmuwGPXQYiBv5bV7xPhVe0mhHAyBfYlebNTI+EipifvqMmHKVI38cugaf4YlkMPnGWXH7ak56ZbSY8tBmAtLTedvwb82haNuLOGUB8TpqaoqzP61zWPGpxg/Y70gZ4341loruELU70FJ5dcTW3MsQPFBgyRlor5YxdqylO/eDCyIoXREuB0Wlm/I1fC6MI/MbQc2v6oYU2hdWIfbEFCuP4YNBe7xR7DyZZAuQrpTtr6ckzOMeqUJArsLyOB9hpKid5hjLNJHwK6fTJcvkA7vXcqhujOfFUbeeuPgVyF6nK1+hqyWV6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2x7qCQQufb53CvI2fg83Lz/BQ2+FhrWDKcI9pC4YZ4=;
 b=hLP+NBkDVo+RFXYJPdE6pI+QYxMM0CerqnB01oJmQzwZfZSefq7zv4rXxquCvtdP1vOCyl9zMb7UHIAC3QdkdrR7ibC+ZPTAJDJnrvXMRUty1EKPMRZM1q56i5q81/Bn0kBj8Lml9OirpTbKA60S9hfO+u+beYo9YlwGvOYZRkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Sat, 3 Feb
 2024 01:01:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 01:01:12 +0000
Date: Fri, 2 Feb 2024 20:01:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <Zb2QUTenlj3kEeE/@lizhi-Precision-Tower-5810>
References: <Zb1rD4WK5D0ckKos@lizhi-Precision-Tower-5810>
 <20240202225116.GA732628@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202225116.GA732628@bhelgaas>
X-ClientProxiedBy: SA9PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:21::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 716db753-3329-4f8e-01a8-08dc24539dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MpMclEeLpxINyddfSmX3K3xPgnlFm1ys64PQfSh0C4a+N/UfdUp4ygMvRInUdVB4blOeNwED4eXlP4hOyCpo+gBOpQvuVsf3QnK1kWAIF6vAp4yLogl30nVBNFUN/ME4YILiyZ45IGMSd7wI86BZY9ovV0RUyusWsU5TxfxF2JKin/pKdMJcHmBi2eDj/Sar9KXB17BD6mVPO80trnTFh5dc8fbCgQfa1hCMvHYsskFd0pV6zgduMSclwL5a6FlJUrTdzZDtLT4/NJjYkIEkYMMCIGF7RgVvUetzy4He19/FtOxdE6Y9oZHNtzH+0WyzRwXZVbrr/MaXpXJ64Iz84v4xgOAB9H7MWPnnxkDu0WUEke7E/Ce/l7fLi/G+mpiPK8AF6zs/5lDj4pVYmUQIEZOV0aSVQ4LyBl8QgXgKc4ULMK9bRTxmiQa0a5QbAk4mFgxz4OOJHiulVU9L2hhPndceXzdV6CHyw0Osh8Mnm8cI6+7WrraFEh3zUxtzy7qeiGa20S2zA8P9y4KqQMlX3R+fKTXBVd+PqS8WQ2OiAMkwR/gPJb91C6MZIspVbDtbzlfMqTrOoW1W9ity2Zfs6wNJShGydDcVOMOlqb0IguE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(9686003)(6512007)(26005)(7416002)(41300700001)(5660300002)(6666004)(52116002)(38100700002)(6506007)(966005)(8676002)(8936002)(4326008)(478600001)(316002)(6486002)(38350700005)(6916009)(86362001)(66556008)(66946007)(66476007)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCpOIx0sbK6OuvKyNiEtdXsne0traF0FuElHqIFidf6GDA/QZnwWDSS2ES0T?=
 =?us-ascii?Q?8pvJWTH3iF7eQNSg3Vkb6y4ax60+zwjBulpzSvnl5kfbwRStlVsG4XueFkt4?=
 =?us-ascii?Q?uepNhi6gyChhuhUNYDYbKmT9eEPsM8c6OuiL/V6W1k5UqUkzAzTtxi/Q1h/y?=
 =?us-ascii?Q?1vqrKjQaJAA5Njc3zhlbblAbfZIQwLMUJOqk/X4xMQmMvu6S6GI1alY3DiOI?=
 =?us-ascii?Q?fI27Ja2cRHtQJvY16KKoM2rXROhNy7WMGCkAq0GiMB99DJ0iVPMPsuxmKTGz?=
 =?us-ascii?Q?RjpLlf87OOPm/tk/z+Yej7VmrSbm/McuDBwRJuhh9+f/UappZEhBC444toJa?=
 =?us-ascii?Q?mYsaWGF4if8FzvGPkYU7mr08eMPoKLkr4drj0GpppV2kNLhi3ziE+/PO3Rwg?=
 =?us-ascii?Q?zQdGabnnV0+AcXiVcC8r/ojCjg+kLCiVtzSDS3LHkKgytJSvpLeLvqQ8v0ep?=
 =?us-ascii?Q?3wV1nP1Fi3D9EK40XfQqZA6i8TXtsBrpUyvrnM1yRhK7nGoFRNyysC7pE0+C?=
 =?us-ascii?Q?0LOnyKGp2YNvMocjzRq+mzRYz/5rYiEfpnwjwc+usQKAeYVzxEXZSFIQlxMK?=
 =?us-ascii?Q?XTwVe2XcTyJNzFfHLFTc7tlI3xE/jY8G2dZUMUSW+iOV9x8Eua2wYFZU9GKp?=
 =?us-ascii?Q?vkGuj+BYat6pOm4MbLCWoe8Y6Kc7ckSOC/Dd5BEd0+uPYAeD3lmx4D2Urxsq?=
 =?us-ascii?Q?QSZ42Fkyn9nwkwLg8ySrvu8ebL0/nMJEYdEPHVkgQ/kOt0wA5V2YyiPJ41mb?=
 =?us-ascii?Q?wfTrCYgQmIWya0BcvC46yDHAF8NNa/DX4PKMIziyxEe775PdaD66Nr//2bPV?=
 =?us-ascii?Q?wIfJjLlb8ConMiMPfgCo6HwMHDNNQrLD4be5YrMCCQ/Vb0KOgTHdIaXMxS1h?=
 =?us-ascii?Q?gielOZuQPTgnfPtdeAH/1AV3WoXko8oI2rLKeNgDfWgf9YPpRV3ahPDVfXXq?=
 =?us-ascii?Q?64hoAmniOEWnNxyzvOTNuv4+267r2KiYuRgvASnu4Yfm3/G0d7sWCfwIqRlN?=
 =?us-ascii?Q?h6xo262ZLEv8qBem57t0k6SBybmx+VnSAcJdT8pqwoW+mN9R4USUoYJ6LBPW?=
 =?us-ascii?Q?yC8lt4DyOuuSnERioIyVVkdGk+2zbnhfW+IzVEX65rgchvNvUOm4GBeoPkA6?=
 =?us-ascii?Q?1TbfTRKyqKLO1dE7rta21Asc4DgO8h+Vb+Q7AbxaFRN6PlqTec8QX62Q6gBu?=
 =?us-ascii?Q?Ge9LaRCOhRm9JTG23LKplPTgh08qt7IX2SxpHQs4LSTD+nEO+95Fv+DZEG00?=
 =?us-ascii?Q?9ABTX1P2pAVc38GLpoutWo7FjZPM6jrEwP2usFVg2ArCkpDWgS76o7JhG75l?=
 =?us-ascii?Q?FOdvOVxloq2NpbrZ9/cm5suTRTlzCjHaLHicfFbsX7GcDZSota9ftJu80ob2?=
 =?us-ascii?Q?cY5h/XPI2jAopUWilDe5A0ZOr/eTXbHqSiTHOsHgsVJxxDv1Tt4WakRviL+c?=
 =?us-ascii?Q?ULVKEfJVkBy/6yRFCDz7HcJfTgPaycevdF996jDCZBRbTBtrk71uwEXaOx3N?=
 =?us-ascii?Q?kmVQIyIAjCMr/wCXiVGXJKDzWapt5x44rSconT8yBS0oiAtJLNPAvEt7lGOr?=
 =?us-ascii?Q?FvachEZkG/NAKEwX6uDKOt2NIAeOQdGo4SQBvRiA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716db753-3329-4f8e-01a8-08dc24539dc9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 01:01:12.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29t9YhYD8OD4HwL1HL12KIK42/Fk2z0ewQO+2xmUueJHpVDk5ItIZ/oD8tl7wANmCXaF5i/SpRBF6VCXrANaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350

On Fri, Feb 02, 2024 at 04:51:16PM -0600, Bjorn Helgaas wrote:
> [Rob to to: line]
> 
> On Fri, Feb 02, 2024 at 05:22:07PM -0500, Frank Li wrote:
> > On Fri, Feb 02, 2024 at 03:54:31PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > > > Avoid use get slot id by compared with register physical address. If there
> > > > are more than 2 slots, compared logic will become complex.
> > > > 
> > > > "linux,pci-domain" already exist at dts since commit:
> > > > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > > > 
> > > > So it is safe to remove compare basic address code:
> > > > 	...
> > > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > 		imx6_pcie->controller_id = 1;
> > > > 	...
> > > 
> > > I have no idea what this is telling me.  I guess you don't want to use
> > > IMX8MQ_PCIE2_BASE_ADDR to decide something?  That much sounds good:
> > > the *address* of some MMIO space doesn't tell us anything about the
> > > function of that space.
> > 
> > You are right. If there are more than two controller. The check logic
> > will be extremely complex.
> > 
> > There are some discussin at below thread about linux,pci-domain
> > https://lore.kernel.org/imx/20231206165953.GA717921@bhelgaas/
> 
> My response here was too low level, just about trivial syntactic and
> style issues.  I should have seen the larger issue at the time; sorry
> about that.
> 
> > https://lore.kernel.org/imx/20231217175158.GF6748@thinkpad/
> 
> That's a good response from Mani, but again not relevant to my point.
> 
> My point here is that "compatible" should tell the driver how to
> operate the device, i.e., the driver knows what registers are present
> and how they work.
> 
> If you have two variant devices that both implement a register that
> can be used to distinguish them, a single "compatible" string might be
> enough because the driver can use that register to tell the
> difference.
> 
> If the driver can't tell the difference by looking at the hardware
> itself, I think you need a separate "compatible" string for it.  Of
> course I'm far from a DT expert, so please correct this if necessary,
> Rob, et al.
> 
> > > I expect the "compatible" string to tell the driver what the
> > > programming model of the device is.
> > > 
> > > > +	/* Using linux,pci-domain as PCI slot id */
> > > > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > > > +	/*
> > > > +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> > > > +	 * controller is available.
> > > > +	 */
> > > > +	if (imx6_pcie->controller_id == -EINVAL)
> > > > +		imx6_pcie->controller_id = 0;
> > > > +	else if (imx6_pcie->controller_id < 0)
> > > > +		return dev_err_probe(dev, imx6_pcie->controller_id,
> > > > +				     "linux,pci-domain have wrong value\n");
> > > 
> > > Maybe I'm missing something here.  It looks like this driver uses
> > > controller_id to distinguish between hardware variants or maybe
> > > between two Root Ports (slots?) in the same SoC?
> > 
> > Yes!
> > 
> > >   imx6_pcie_grp_offset
> > >     return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> > > 
> > >   imx6_pcie_configure_type
> > >     id = imx6_pcie->controller_id
> > >     if (!drvdata->mode_mask[id])         # <-- looks unsafe
> > 
> > I can add safe check here.
> > 
> > >       id = 0;
> > >     regmap_update_bits(drvdata->mode_off[id], ...)
> > > 
> > > (This "mode_mask[id]" looks like it will reference garbage if the DT
> > > supplies "linux,pci-domain = <2>".  A bogus DT shouldn't be able to
> > > cause a driver to misbehave like that.)
> > 
> > Suppose I can use dt-bind doc to force to 0,1 and safe check here.
> 
> Nope.  The driver must protect itself from garbage in the DT.
> 
> > > That doesn't seem related to "linux,pci-domain" at all.
> > 
> > I added comments about
> > /* Using linux,pci-domain as PCI slot id */
> 
> That doesn't make it related :)

Okay, linux,pci-domain is not good method for this. Anyways, previous
implement is wrong.

Let me skip it and think a better method to fix this problem later.

Frank 
> 
> > We may add new property about controller-id, but there already have common
> > one "linux,pci-domain", which value in upstreamed dts exactly match our
> > expection, I also found other platform use it as slot id in kernel tree.
> > 
> > Any way, we can continue discuss the better solution here. But I hope
> > it was not block whole 16 patches. we can skip this one firstly.
> > 
> > I still have more than 10 clean up patches my local tree.
> > 
> > > 
> > > Bjorn

