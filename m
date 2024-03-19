Return-Path: <linux-pci+bounces-4908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66334880236
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0210B24EAD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F68594D;
	Tue, 19 Mar 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KeohA///"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3208287C;
	Tue, 19 Mar 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865385; cv=fail; b=mMU3O5BZHPpwKPLJ7GYHfUk7WrTHh/W8ao253il0oaWI5gcki4JYh4NDCebSCczr2UsG2jw4Y/YeY2O+OrxRUwLDCQ+fiwYC1uyWvGiC7Nn9LoXrl1aWnSpcnlpUHePDgjuf8bwj1AwbG6udtcqSoLMfWe7uh06SfL1CnGreH+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865385; c=relaxed/simple;
	bh=rpgsL+rID3pr44STmdJrAj1rGp2VEmwyFZlPt/lu/3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uh1eSgtBgHjIv4AAJ9jWwr8PffU7lzFzK2zPLrVlPWH6p7MUPpN35QkbvwBCurHsc8jiO5e+lPs6NiCE0U8iEkZWS2JhmPcepKDvIxirRItFYDv4sfIESg2N8NBvWflzKEPr8xsAFSzR5BDjCWFhLRcHec7Dma2s85cYwNleCzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KeohA///; arc=fail smtp.client-ip=40.107.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anD54fRmvNYpM6aHhVn4nl/pqTvECgOd+r+V/0CN1wHd2tH2famrEKH/0GXEcza8Cubw8hqAXGz3RLjbICudr2ovYvAhBjaj+gz5VngN6MX27lNz0faHtybq8bAV54yeg6D1EZPESOBwwlMz/Ui2QhTzuGdu1Z52dnvFINcW/m2CX+2EDnWOoDqDeBURZ03ZF2wbXfhncobBm3hSmWRaiJ1+pr7jgkC5ckfurJg7VqWUtLV4LNUM/+RoNY7KLkT8m+RpcTXmOgQuHFsPijDiQaHX0MuHNKO6a/s6IHV0jKeP0MBt4FA9HFjIOEKqWuuZ2YOkFOZPvdOLP+c/xMZGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qbIXjLq2Z91+0q2l2MmdMVF7cmMMhg12CLE9S7GmcQ=;
 b=FTGM44rj8NGGY5zuIL25J9ac8XeFEXi+VNuae4wrSfqL3hGAya+z7WJGYf+06pnykqded5r14uTXMsZFV/2xbrdFrtSKy+V3ACaJBlJi4cm+UhVcJP7jzLeAsONVSA4k2V1Rg9QiSOZrlkh5EZex6gadU2osCfBr9sgb1mQFxufsoi+7gLFICcPMe7nyDIr4Nu4qhAA2bk0CAYR12ELXo4P7Ue/5Zty+PaXfIEq1WZgH9bVjUGWgrtO09j3+g9DbXi5Vq/Zg60UCZ9BTieAL0NvZsqE0hYA3JWVU0Dxh4BineQmubBugBRtz7vF+H6oV+DIvUVXIzin1IqS5+IxqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qbIXjLq2Z91+0q2l2MmdMVF7cmMMhg12CLE9S7GmcQ=;
 b=KeohA///g5P8QvicvEWJKc9D0zjPuYxhJvVMISd2xgQmwt/qS/jqXBDWiGl/EZ9Lmi3N2Mq1AKUOxLRPGcFgRe7V/rKot6/hTx52REKAJUANyiWL4K/yO4HI59AI/hOIFtBpTbVH6CHrsMVba7P7S17QLvt/G+1vH7R5gFI5Mt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8097.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 16:23:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:23:00 +0000
Date: Tue, 19 Mar 2024 12:22:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: imx6: rename\clean up and add lut
 information for imx95
Message-ID: <Zfm720fz9NE0fD/P@lizhi-Precision-Tower-5810>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: c08ee5b4-6872-4554-87df-08dc4830d83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CO5GYmVAQuSVa/AnfJwpV84AXWQMpzkbCpkx+OsSgk3c7D+mDOscUUPEt+vXoyE5HgZnIuyjd2brbc5NHw/93EgpnCf1Rl5zLWq9G4RIM/+uMfjVoeGA8jSsV/Cu+uTIznzzutbDPuXs/RXnH1vZkPskeVU+b/e0Gw7ZLuerNWXWbr69EHlihz93BehszUA7Rwpu6dDUHrTTOjrFK55Nj2EAjgUwr/tA1LpRJkMAtuS3CQ05tyMNTYFPqLjayL08ae6o37hJtDfryA5/e+YCzugmak7ejZCME4zt/u8U1DT8msTHP370szMBOvxw8RMx9lC+4mP1KWlgrJrVXus17TluiII/MBedk4EI6RmjZbH8e05E5t9av8ceS+wDB1UC0tUBJjaZGUebq/2vUv13eVbHqc+E/gSwts+X1u/+EbRnqnaC1ySNMG/jGdlygScvwhn+YTCGMDKiz5m/qfpXNKXYEC+ZP0Y3AEY8UIPW7on6+knHfbSxcKQOhoLi6OReVkPmWZjORJgcm9TbC+VcYRu2Jj1gmXTBX5BvkWc4hXjIFfsyrjtoZI+twBETIBjS+AjcJNljgZr3kQKETsr7TFRdbEtcQ1o4r5ndY+u16Sa26OdRvWglfgJb+2kvVJscM0pH5d5qgDnwgGk2e+FLocnMHHru26h2b60V9vkSAB+QcLIPz+Vr97/ZvmY0ISlv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EENKrxG7kfQpRBIjzPe2m8mTOODnIFlGdeQEVY2kNSFR+RgmExAGbdwxB+3B?=
 =?us-ascii?Q?pZb+GIz7yGIzXJC58GLv5GynTsXRwU/8g4fPH+XBpb9INn8c4Prqq5zJDUVP?=
 =?us-ascii?Q?z51BzSqko3owQo1NfoKSPFcuoo0wrC7V0NiWbNClKdje+m6a5RZWqFJw6ayW?=
 =?us-ascii?Q?5jq51ErlnxTlO9/e6dA8qRhMycx0nSnDEllY5vs5aI9I4i/BXi7d8erX4viY?=
 =?us-ascii?Q?NorqGWpq8BokFFIDEMe7yWZrgUD39nx6+99Zz/HcGKuuP7Q/jvazM8/gkSz9?=
 =?us-ascii?Q?inCWvZzy3VptJeVRt0kP2+xM8JLRyizzN2fEL4K8z4xP93JHzsWzZ21A5W7B?=
 =?us-ascii?Q?lh1wmFhwiHPe0g4N9diQfH4p3fsCLj5ug2IxV9GN+SKPan+TeZpxONkcmKJ6?=
 =?us-ascii?Q?BOA6r3p9tw+jFp8AcxUFr8ZdJR7VcjvVmlaA/vU8gF8uyz3/o+F7G99NpYPS?=
 =?us-ascii?Q?AQbEtQeCVnJtvaXEQLtC/xFVix+a3RrK6LCdr3gsYz3xcUWrwe0ejF/E+YX5?=
 =?us-ascii?Q?BRuVBq00FZZKdJvps7YmRYqhFa3CQFZdFCEbB79hO33BKw6yCmb7zBVo1Iih?=
 =?us-ascii?Q?qsELpOrrb+WWai5NwvJV8SzEg2I7SV+mBWeTaQwXbprCUfu02eRxKR//k58N?=
 =?us-ascii?Q?+izIlwTH+xYpuNlBakPX7Nu+cSBAP5PwQp8ubZg/ikbHu009ZLJngYWaR8Bm?=
 =?us-ascii?Q?jN05RCEjNRYmSEveStcqsAmNwRdW4TlIEngQy6acDqnJTsbNkg7mOt2yVplw?=
 =?us-ascii?Q?pFr0Fuz7wn8m+kVs1vlOBeDVzXnYuI+7gUzqMDQQXBComSnt7M0zaaKbAE7M?=
 =?us-ascii?Q?BluxCI8bTUd0ihl6SMwNg7x3wnmIjYxQXOjJjo+FP44Jt0xcj8O5S2xZZuYp?=
 =?us-ascii?Q?iMaw+FE6jZNTQQ3ZV368PBK7YsU1oqm09YgC0SUrIYWqFvpsTDRs6u917Twq?=
 =?us-ascii?Q?HjmJ682PrZm0DXCO0p+Ytj2RVOUu4JNCH4hfBJpZjJhAxtXNKiTFijXUNfVi?=
 =?us-ascii?Q?8qOd7PFOeyaX76JEsXYgKQC1IHN9nPtjtgAQ2Tejf10gkNaEmSDQkohlblor?=
 =?us-ascii?Q?PhQz15x443RfLvXo69kwNcP1grEF9cIyE0YcsRilwwywRhX8S6vIpyQW+Zh6?=
 =?us-ascii?Q?SowlaGh2VY8Z/tclU7tsaZkeLT7dvfozwlncfrcgxVdTdnPWCgOKiyZy885L?=
 =?us-ascii?Q?EK2W+dyM/bzl5tI+1Hp3KfCFYohmPq1ZNnJsQLbTlYsiEfDE3dMAbsohj8Qw?=
 =?us-ascii?Q?FfLFPZqxSlYl/agdo6JpMPMhxSJ6s/m9SVHXzw6+o/28FNKpcQnJyY27C+tl?=
 =?us-ascii?Q?/3Pn6mPGwoK2UJ43Q1oVaZkmWTc5eR5dppZ/IhdJam9kF8O11yrmfMQTvCVP?=
 =?us-ascii?Q?o1dmb+BpCDNSRaGPzaeIIGItj1RMFKC5Rn6WXxP0bI+pRJ448OxBYpfuuiIy?=
 =?us-ascii?Q?cIStG+/iarsqX0N41hKmii35VsGwG3iDLiFZ+fgORGBp+L4cizzwbTNrjX85?=
 =?us-ascii?Q?sRNKeILjqix/jDad+BbHkb7nmB0l4I0PovBI9IY6/xRcJvvbXNAr5b8NZ2r1?=
 =?us-ascii?Q?Ocn06FvO3T+OTYMZlKIzebs3vPL13U2jAqXj2FUw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ee5b4-6872-4554-87df-08dc4830d83e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:23:00.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIEv5XfViNhuWlLwlMliytldMzzwMtW2pl0J1X7LkLa7kHOZBpE7vjh0w+WEtah2/L5DzeOvujH2KH3NpVOFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8097

On Mon, Mar 04, 2024 at 03:25:05PM -0500, Frank Li wrote:
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                
> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            
> 
> Base on linux-pci/controller/imx
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Add manivannan to TO list.

@mani:
	Could you please help review these patches? 

Frank

> ---
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> 
> ---
> Frank Li (6):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Rename pci-imx6.c to pcie-imx.c
>       MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
>       PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
>       PCI: imx: Simplify switch-case logic by involve core_reset callback
>       PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
> 
>  MAINTAINERS                                        |    4 +-
>  drivers/pci/controller/dwc/Makefile                |    2 +-
>  .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1115 +++++++++++---------
>  3 files changed, 647 insertions(+), 474 deletions(-)
> ---
> base-commit: 0a580c33494a7d293ff0d34cf4db4af107070ccf
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> -- 
> Frank Li <Frank.Li@nxp.com>
> 

