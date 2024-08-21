Return-Path: <linux-pci+bounces-11964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD695A32F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 18:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2091C21145
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA414E2EF;
	Wed, 21 Aug 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YGH1L0iV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29B15886A;
	Wed, 21 Aug 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259087; cv=fail; b=W+gDDhTZdgLMN0aoaoSdZEf8JT/2tGK+GGmb4PAEvI6/46Ruvb5cg064e2AA+MR2Kx6fpskYSF6xj09Lxfze1xF9jyCbstR586YSeEKfpCA3S4syCGgO4/a8KzdHallo/6Nv6rS6gg5riuH0Whp3r/BFX2BnsCzuXTc5lxKF/fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259087; c=relaxed/simple;
	bh=XADm5B9G5ugL+MMBaQPeqlVkR/7MnykzeguQqlg60is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbmek3BK5BCQOq1nVpbHiDB9fPTE/f4olmQkqJ+6wxPYYqyktdqcB7pCtktljgkwUO4F9o1XIry1ToYv0IBCiZ9bVRT0WXwsvIyy+7LFFuudhMmlQOcb3CRZh6ufvwPEFLI8JtMGbpZcOBq7RGqDoyJFqsj4q1SI+giGRW2RogY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YGH1L0iV; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoz5r/MLsH7HhgcLVyv/sW/COhmDLFxP00F29zHbOQl2vR5jjxgr9CbnweQpEzMCRM3I5XFdAc8dvQ9UZEbiirR0LqWAeh9Qoh6dRymYjgWgijpiBIIQqCyJyW3jDZagIryYYDInFLYTR3Be3UEV0BfB4PsY5vE7k/mbUzAxWxCHeRYAtpM+SbQ9PShQQfp59IIT85qb76JfyxgaOUa1gnomfnlx+M78wFFEmsCQoR214w2gOrXuh6DxQddJRkvtOrHkeslIfkHAPAdwb+gQWdp3+mBTonzXeyiduw86/OjtHdNSIGqy4k0f2+aFvZH4+ajVGrCsff3lOwK1oH6u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUzt+s8RdKpjphGq/xS6SycuT+SzvDWv1ik/oOiS36k=;
 b=zJKyHKg9hCAYl5sVZDZcbSEXc462JYSiR0552nJCkK6GcS774miObkZCtmKPnWdkiI8MsgHNV1fnDXnW6nTLoWMbsJbkQ7k8+ZkBF8sCCeL6Fsrsz3py9ejODZHRwOfp1sBPpxVGViV35znJY4Lf0pxsB50Xqp7LlFmYhnKixp11J/EIBxpo+y8+wJPky8lVqF0w0s1e3PBdwuDFzjR5z0oiy/qKJUIq1iYwfDEVOXvSxb3ihwiXRke5OEj1z1w3CCidv1kY60v6uKCmsWYGdM16eG+fK+rCTr0QV28ccvSoNgaOjjHiuliokvcr6mgHaw8HqF6kmOIecmQOO80C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUzt+s8RdKpjphGq/xS6SycuT+SzvDWv1ik/oOiS36k=;
 b=YGH1L0iVHbZr6EVD8Nno5DJ++TixT+CHtzb+vYzzmzEVoVWJeI+iybjVFqDiXh4pykEjXeE3uoSidI4ufnB4z9YI6ibz3q5RFPicgBUcMBpV9Lrta9Ql1XdbRVzNixY89D67lhYpKsIO2cjHJg4aZdSL5J8nlS9Ebq5BHHzY6ziPJRgufzWLUNX4XU4GcFlwzadh4ezavA4M/6YTwsJNXvzzCoGqmkhJIVxK5ITVMoLoe/e2WS6mAKiRXZIxS7cNqd7UVMcQIVVnRuNkJOokag4w/Tq+em+GUlbGqDPszx2yKD/HKvWbhs4bo3ye0Kz4oOB5LHZbLsDJjgrzwu/GRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 16:51:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:51:20 +0000
Date: Wed, 21 Aug 2024 12:51:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: imx6: reset link after suspend/resume
Message-ID: <ZsYbAMR72/TsnxoA@lizhi-Precision-Tower-5810>
References: <20240819090428.17349-1-eichest@gmail.com>
 <ZsNXDq/kidZdyhvD@lizhi-Precision-Tower-5810>
 <ZsQ9OWdCS5o96VN2@eichest-laptop>
 <ZsYKjFXHDVr8tz9K@eichest-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYKjFXHDVr8tz9K@eichest-laptop>
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b06ccd-e1e3-4d35-ebbe-08dcc2017bb6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?6Al2RW9R8ZeuW5MIkd5PAfhZMt2IHzivCFzeoV5tIt2cApuidwa+sMqJmxcZ?=
 =?us-ascii?Q?xgEyKTfs74rja9u1gme5IHy629bwnyyqOnSGLQx1rZu1Gr3NKT3MDlFr/8+1?=
 =?us-ascii?Q?TiQkK++vaseZkqb7KDza1yxYl3/CTABtTs+SuNE3KqzXkowapTIn2xcbSwpw?=
 =?us-ascii?Q?ZXVKJGmeA2L1FfzfxGROH8BcfDgDTCk5AfBjv+udqh2PWqbOEtIVeSJYxja0?=
 =?us-ascii?Q?pfC79+qLKGD2873sb7Umt05KCqSE7mN7mq+oM2hwKqoyES5P+/DStkasFnzS?=
 =?us-ascii?Q?Z+nikq1F1Ne9SR+Tqd+KXGvwbAhwhndNHG1gTQG3OmhSs7nHzkdg9SySiOxM?=
 =?us-ascii?Q?6t68/AacRK2f0PYl4qOI3ZnE7dvIMN0LXA2wnNII2/ol/cIqEoDLME6JOlsm?=
 =?us-ascii?Q?358nB0wpg1uQYDuivLa2ra1qwGylnFEe1QwIAxsgEsxOugMhC2a4MJXxdOis?=
 =?us-ascii?Q?8znwitSd18+Hyjn9JSUliIiAXecRfohf7i9FErLp6gd1gwrJVGPhQbcU+riR?=
 =?us-ascii?Q?H+YBeD31WnAHfBs2TKyLvLxbntVHZMjjUuVBL+89NSyxD6J0Vk9qbB26KFso?=
 =?us-ascii?Q?0wzCansWBE9YCCNgfiw0r/Q6E/lkpXDLhTjoss80yzbg/YnmSdO3YYQNcJoQ?=
 =?us-ascii?Q?9a3QZ6RyxQbwJ6uArySLoJGIgVLbu2uETAQQ84BzK8CuWPZmoInYFYg4LLo+?=
 =?us-ascii?Q?IhblC0VLy7L7ItbM+fPOQai8KymjOTWd1kaC9CGQt4z/7extMUwlpF2oPItE?=
 =?us-ascii?Q?7XGBTdCEmfu0Ia9QlH/m1Zd8nGU670j6FE+9r0NRKN7hNmBNCwXox+giEMMO?=
 =?us-ascii?Q?JlwhsE191nVS5BmnWiG6FcF5Db6Y0emfizuhdANu6CJGziIwqV03hAfMtVw2?=
 =?us-ascii?Q?nF4Cq2kTQR785IElgUUUS3+ezfUXhEEJeGiyMRDh1Y7X9WJOTQgfa/kSQLyW?=
 =?us-ascii?Q?dAtUs7GZqg1hB6Gdxh36ee64+pN5Tq3pwequJwxgE7eBIywztSorHbPtvkPj?=
 =?us-ascii?Q?VqiDsjE4RqAwB+NR1CfhEoAnuVOOAC/f3ywUUyqcQMj0IhGcSqYCQlOsGnT7?=
 =?us-ascii?Q?S6VCbMyXWTdLg9AJ1EVqxj6hET4j8jk2kod+YtgI5g3XyMw/pL3UnOubPbRV?=
 =?us-ascii?Q?ygHmkqY4p44tjCxb0ZwXtDS0sU84r987/D/PhoLPb6uQFBVU4wJkjNHUkTln?=
 =?us-ascii?Q?mFkLBYNt+yS7zzVCnkrrmf5ABiFexgfSfgFS0CPkH6Akky3kHTj07/WQiEea?=
 =?us-ascii?Q?F3hAy+RXaAr3Mkxui+B7LztYRZIH9uknmYQZJjSuiHhGvP8EPxSshoKlAAq2?=
 =?us-ascii?Q?wB5QhKmhd454a0pyZTrdMlAcVEGg0BXZ3/3rNdyrEV76fPUZXf1XZVKtdVsF?=
 =?us-ascii?Q?xMGWDlw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?F5aRlLjxd/FR2+49axLjqyhPgxHBhX9zsOuVZ32ztChTlrRW3kwcdnwPtTsg?=
 =?us-ascii?Q?EObDDj1KTpAGO4ll012QmYxlJREScU/FOtlDDiQKdBYcRwmd4hgE7w01W4UD?=
 =?us-ascii?Q?HgPXcGj5JDtP7G3E9S4sASwK5bsTbPKnotkbivUKlkO/HAn5FAAbdWB0wkiq?=
 =?us-ascii?Q?UsZsJH0jrbG4NODAg/2CnWbCLJK19DBI6HVKn2UaN4YIIYDi8z+T14m8vau/?=
 =?us-ascii?Q?sOeJKSYxmzF33AdTfZfwUiywzy43oN++x4Xt0c+3iRpctAXGHd+Ur/EsEJLA?=
 =?us-ascii?Q?LCEu/eRD0/LRD5feCjxvw5559zl4X7kNmx0cYweKL++dGhtnec6bmrGCGXxM?=
 =?us-ascii?Q?4iWSz/nbPYelw5wmbBclZ4dvgnZSL0IRgioVspSbHU7B5emKk14suGcVve1y?=
 =?us-ascii?Q?nhlYxCvPUbNilkh4cLi07J720yW25GH5z+nTaESwzc70/7rg5wgn1Il69l2Y?=
 =?us-ascii?Q?rFAXr7yvsJi7l+m/xZ472GwRynyklWWBxZYehxEVG4Ji6LpBF+Ze+lwvTNVd?=
 =?us-ascii?Q?mMwwV3dxnCCO55ObIiP0UPDuvmWgTu/at6k1g23hDvqWv/w3D3F4lZGMu98U?=
 =?us-ascii?Q?kqR/cRC2Q6IMORI7XZpIK++by1R2SPDEtEnG0jh8moQsSHqUPK0yabenJPjH?=
 =?us-ascii?Q?B3BdqNZu4m6VOsNGmQkAgKHOuJuOoXdAEmibdc9gFDFoaSq689amViJrWTUA?=
 =?us-ascii?Q?lbI8zLEBcT4W7wJbIqinh95WKqgIE6VKVhSPjKECVCajNsi/+MitMhSbV25i?=
 =?us-ascii?Q?/kyLqzc/Zio0mbGIKF1AXZmhl1WAcoDZy9wbo9AtEbKLa9OQS5fDg9VmiaJF?=
 =?us-ascii?Q?2LWFOMT70SKO3iI59mv6siN4lRl7I8lxfzd8ZGz4gpWvA51+UYqUxBtSgoWB?=
 =?us-ascii?Q?W/Y0sNsw9M3n83Z5gGdUNcWhI4pBNdi+lnhc/Q6iD8iwMPkKvTzUuUgjxhkc?=
 =?us-ascii?Q?0Xe/w+FhnZaW/wBpLivfcHuVcluyf5bckMVnskdRkdpuZYst50uGjHkN2aMI?=
 =?us-ascii?Q?IuAtHmqn+A+8fjp4Qf3pPTSyFlfIrGLuZVhxC+nPv5QvNYN3tSWu+GRvmwEw?=
 =?us-ascii?Q?Vb1DEAN/1eLLwwk1mGZ/uqQC/ILgzr4OuNJPKZNZMMoq8lICVDSCtnSdr9wI?=
 =?us-ascii?Q?IysUNO4ohJeB2zJZL5f+JVKYne0DO/npt+3BgMd64kCj1XAEo4uUMBvo6j9l?=
 =?us-ascii?Q?hmha4K16qBFuI+luH+VGWZybQ1YuAUzDKiKhC2hRcMDQtt130No6VuKoRu2v?=
 =?us-ascii?Q?js3n8/0FxIYogrYnaMz+FLDm3Fdu9ii8oxYSEJMzcGUUdaJuSF6+pkhqK9Wv?=
 =?us-ascii?Q?rrT/4twEHii9rz+fs8Di1m+iI6C0lIcaouYPgVDNqJbErbKJNLSETaOGGRe2?=
 =?us-ascii?Q?UTe30FiIlQyYVtUvUqe9NFWkvIACo/thMSlDSVuwZT+bsjlnaaPTZdXX+DS0?=
 =?us-ascii?Q?u/TCtSyR0x7/q4pHaagXSzKSgPtZ7cEEXEg/6xh+ru0qka8otHINR5bEhVHc?=
 =?us-ascii?Q?JUAR/qHYPEJzHHFd8bhjAIXN328CZqpO8gTkgXCWrgeFKx71GbCJyTROS3Wm?=
 =?us-ascii?Q?ZukP+kTcSJZdJm4xWwLAWOODgwjwQbqCN+qYwKYX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b06ccd-e1e3-4d35-ebbe-08dcc2017bb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:51:20.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmfxVxKVs/xkCjUjlFc/CKaDjjSpSpunReh2zyXpcHvDr82tw+BOdaOR0BQ0p4BewEHDkvehULe4nZxBLF7upg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

On Wed, Aug 21, 2024 at 05:41:00PM +0200, Stefan Eichenberger wrote:
> Hi Frank,
>
> On Tue, Aug 20, 2024 at 08:52:41AM +0200, Stefan Eichenberger wrote:
> > On Mon, Aug 19, 2024 at 10:30:38AM -0400, Frank Li wrote:
> > > On Mon, Aug 19, 2024 at 11:03:16AM +0200, Stefan Eichenberger wrote:
> > > > On the i.MX6Quad (not QuadPlus), the PCIe link does not work after a
> > > > suspend/resume cycle. Worse, the PCIe memory mapped I/O isn't accessible
> > > > at all, so the system freezes when a PCIe driver tries to access its I/O
> > > > space. The only way to get resume working again is to reset the PCIe
> > > > link, similar to what is done on devices that support suspend/resume.
> > > > Through trial and error, we found that something about the PCIe
> > > > reference clock does not work as expected after a resume. We could not
> > > > figure out if it is disabled (even though the registers still say it is
> > > > enabled), or if it is somehow unstable or has some hiccups. With the
> > > > workaround introduced in this patch series, we were able to fully resume
> > > > a Compex WLE900VX (ath10k) miniPCIe Wifi module and an Intel AX200 M.2
> > > > Wifi module. If there is a better way or other ideas on how to fix this
> > > > problem, please let us know. We are aware that resetting the link should
> > > > not be necessary, but we could not find a better solution. More
> > > > interestingly, even the SoCs that support suspend/resume according to
> > > > the i.MX erratas seem to reset the link on resume in
> > > > imx6_pcie_host_init, so we hope this might be a valid workaround.
> > > >
> > > > Stefan Eichenberger (3):
> > > >   PCI: imx6: Add a function to deassert the reset gpio
> > > >   PCI: imx6: move the wait for clock stabilization to enable ref clk
> > > >   PCI: imx6: reset link on resume
> > >
> > > Thanks you for your patch, but it may have conflict with
> > > https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#t
> > >
> >
> > Thanks a lot for the hint. I will have a look at the series and see if I
> > can adapt my changes including your suggestions.
>
> I did some more tests with your series applied. Everything works as
> expected on an i.MX8M Plus. However, the i.MX6Quad PCIe link still does
> not work after a resume. I could trace the issues back to the following
> functions, besides that we could use the same suspend/resume function as
> for the other i.MX SoCs.

Upstream 6q pci don't support suspend/resume.

 [IMX6Q] = {
                .variant = IMX6Q,
                .flags = IMX_PCIE_FLAG_IMX_PHY |
                         IMX_PCIE_FLAG_IMX_SPEED_CHANGE,

If you add some code, can you post your patch(mark as RFC) then let me to
check.

Frank

>
> In suspend the follwoing function is causing issues:
> imx_pcie_stop_link(imx_pcie->pci);
>
> In resume the following functions are causing issues:
> imx_pcie->drvdata->init_phy(imx_pcie); // in imx_pcie_host_init
> imx_pcie_start_link(imx_pcie->pci);
>
> I think the second one makes sense because I could not stop the link I
> should not start it again. But why is also the init_phy function
> failing? Are they required to setup the link?
>
> The messages I get when the system resumes are:
> [   50.176212] Enabling non-boot CPUs ...
> [   50.194446] CPU1 is up
> [   50.198087] CPU2 is up
> [   50.201746] CPU3 is up
> [   50.563710] imx6q-pcie 1ffc000.pcie: Read DBI address failed
>
> After the last message the system hangs. It seems this happens because
> the PCIe I/O mem is not accessible anymore.
>
> Do you have an idea what could cause imx_pcie_stop_link to break the
> link on resume? Without calling them the link is working fine after
> resuming and the drivers can access the PCIe I/O mem.
>
> Thanks,
> Stefan

