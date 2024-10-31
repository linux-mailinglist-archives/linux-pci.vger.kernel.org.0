Return-Path: <linux-pci+bounces-15723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC719B7FA1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F471F21582
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168411A3BD7;
	Thu, 31 Oct 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckeyLuvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80D1A08BC;
	Thu, 31 Oct 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390787; cv=fail; b=LVd050l+KFKu0SIm+XFUq9IE8PXt3zPfURrawtx/WB+9xjrudZ6lhRtDdCU+swYveO6si5rzq5Q6verJpvh9+iNp2SbNNKhF51Iyu52aR6mY6M0pY3WzeTRax1mLwluZL6Q2A5UEdlz2QYE7wr/54hSMVh5OXGsPUJAxzh9SvPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390787; c=relaxed/simple;
	bh=3EvOqpsDoMklYvVD77dSDNhKOkks+FHWfqNpI4gVA/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQeQmbqX10IpaKEw1JYCtbyc+Y/dMaTHn51GbQ9jIDMXR+Hh84RGHl+GWbUVVXphC+ljNlTBcrXagdJxD0HXlK4ZGULw1tgKV3MrmMO0i5mw2Kb5Bc+omRW/K5Ea4toO/7pruE0KUx1raUiZL9x5a3qguPaHXnPlPUtCx2nL7Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ckeyLuvh; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buVTE4qhM2XWSNBvd2AtV7s7rpqCM9Xr6sRbBlk++DtdOn39AucSMi5MMY9vFrfIG9Lj81a3eZ/HmuM2EXFaoqWdKrJBYAnTjES5ZELeoYASErKzrtq6+aOSOS6tXlMx+0HeshE+Wy4YWwydu1XbaugcHOEUjZvdSXqL79T1ejdktXc8PxHWsBLUO+i8fNKMPKyJyx9y0naRZwGekxFXvnoUTQ2FF6Lfe60X6lz6W7xwiYrpokRBuB/D5loc6xxr+Oi3FQvVA3pfJco121JFDLhHiqbuv0yKQVq3NMLT7yk6VPRVeO0JVqW3vgCa0LD1PWcQhJP+x4ii8ZwgzWhyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1qYkgBVG1y5mHB+S915qnWna6ZLcDart7cxwK+YZGU=;
 b=GeS5cF6iHHnrkJWugNTZMbIEu1IMRjpy3/CtQ3qmn3zek/3QQG4IkUxtjQZchzgg9XdoMsfugOCNinASwgTzGRHbwbUq2yWn5Aw9GrgkAdbtJFymqRB5L20/VNe2jCT1QDBJPP+YD27a56pyH7fOlRcdK4BCy05VwHEOjw1L6R5SfyrquRKh6Dy97WVObSwDUniRM9XM+Ob/dYl/tsy935/eF2yaVqHOKDvipc//K0Atn0I+aR4S2pkHLqf8mcNhYr/JP7RvjvXobmKqMoFbpVZ3Umo4BxwqMnhKLr7A+znDS+wZQtBtzfffaKbLlqRSvIilFz1SnXVAL217SJhHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1qYkgBVG1y5mHB+S915qnWna6ZLcDart7cxwK+YZGU=;
 b=ckeyLuvhT7fV2uJ/KeNGrgdADPuNcD22JfzhhNYKVEgv2Z7Hm/RSkGkaIdaT0vb5OgZgaEYYU55O14CUEmbHJIN2A1oCh4lHiQ+BRRsNIWOpibM83DKnJJbbmqfjQx2yDZcari1lSf769xc6qyD1wCPAtwhImxUf+YPGSh+0J9V5qXssH+JirvyKEXGRJGDMVE1Fd50A8R2cA1Z9lSxZL6Yd3qJTu8JQZZ0fuMW/0YeA9tLbCfU+wmT7ajwv4VfifpsXm9lzqKuoWneMFoPdDjR4WxFsctAPxlimKrdEeNfK7XdHjugR0r2180cCC0aaDiGRaA2CE+y0SO4Ww3HD2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6772.eurprd04.prod.outlook.com (2603:10a6:208:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:06:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:06:19 +0000
Date: Thu, 31 Oct 2024 12:06:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Message-ID: <ZyOq8hnQ6zXNM8VW@lizhi-Precision-Tower-5810>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
 <20241031080655.3879139-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031080655.3879139-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fa9b35-d501-4803-896a-08dcf9c5f4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zj7z7ga+Sx8dzpz94L1iiX01AzoJ0qWgA7zgDUQ8mFDpIr8iYFQk1uIRopx+?=
 =?us-ascii?Q?YzZ+gGtG/D4XoMtCy5B1mi2RsS6b/5Wol5p3ZPSgeuk5pfYCTDJPlZjdfpqB?=
 =?us-ascii?Q?fJpSbVYbbDluEM5S2nfitUYIN4SgdCiZ6spLbWMzwswKOjUiydtp3X0FVs6E?=
 =?us-ascii?Q?YxJf8nMlOefzItHOz61T5r9IadWsUYof+LyJBkx1Etbbv+kS1yKfgw2CwRHA?=
 =?us-ascii?Q?KiYQsQKc6tYOkyZBftLSXSCAFsuJPIlkFTBhl14URSngkNLDHzmLMiuBaTGp?=
 =?us-ascii?Q?g1H4U5PsxpY0JE8JgHGTWeB8E6jkKkabCzIAJ3yb5gXQLelpqFTRUbA0DkQk?=
 =?us-ascii?Q?oiGhZ1lijQBb0t4DZ6/w9Ec6/dzWu2slJFIyv/HUd0RmvFdPzlyG6rhy68nH?=
 =?us-ascii?Q?gXB7rzNKaht5+Zf+WR7g7l2/pEC5l++6PaSFmDslOEIGqNnrFS+Yzp9iU82A?=
 =?us-ascii?Q?BKgdZoT/1XEQIHDCb1yjC9Y2CRn9N3jST7VKs7GWQFbRCGPLM1LXQLtWPTGK?=
 =?us-ascii?Q?L+gps8RGWZOrLfFjDOTynWC7fD+ye271yPt440Ija/JRHZ2XfHBsKyPnXY4P?=
 =?us-ascii?Q?zuCguElp36g1FmdNeF7eYzemWPjwav9AcQIBZSspRBT7z2yL8PPIZzt5P/7b?=
 =?us-ascii?Q?UYuiocacH6X88QKcs2xVHAJCmLO6mXGHhsai3R/wAWT7XML1jT9hy5M6ixKC?=
 =?us-ascii?Q?poRikPhbpr9RGPcH+1MAvIlAeTOVXzsBUdJxUvvT73z3u/AdNEHHbQzeh/v2?=
 =?us-ascii?Q?colbNOFio1MLGNDcz3N5OBIY8px3iBx6FFzDViczaI4KnO8kwRUASPfNtQuM?=
 =?us-ascii?Q?J/DN3lfOcVERmeGX+P44ossOl+jGWwRfnN3OPEs689RKDu2Muq/0KmmG+KBA?=
 =?us-ascii?Q?dzRyy1YTrzId9fDQVNX3WQqYY7vp/fTAEoBS5sWccxDwx4nS8fKON5mVWzw6?=
 =?us-ascii?Q?9kG9RoJf9OiNoEAbRkYeT4iXXt2uor64oEqqnoNk/OueklJsV/0NtRVZAtq6?=
 =?us-ascii?Q?S9cicU8cAJNW/CGiK0pqvtTosS7EqBrLX4/05LL+lUO22gcJxXDxYCVT4XKI?=
 =?us-ascii?Q?Te7a8OwbkHGVtyJXU49Pw5Rj0D3dTKVeDOKaThgby9zMH22EvOv4AlRjAklM?=
 =?us-ascii?Q?yw5fhODp7vwXvFXA2vRdDLYHl+Sp7FcQwr6fXiewcYSbpy2mUe24zEpSvdAI?=
 =?us-ascii?Q?DJchB5bgfTYjNInbVoodFcjZMiA67eLivLGdgzbnxcyvhgENp0yPnSyugtAr?=
 =?us-ascii?Q?WieDW7Xh9OzFSyDo5CBiXxSipM0oTG3fmCM78mLKHN27uiMoDtDFZUG+pMCw?=
 =?us-ascii?Q?DS8B6oweePAl1QZ8Kpa800FxcqAKjZYmcpfl8nZSmhRDY/srs0pGAFX5lKPT?=
 =?us-ascii?Q?6BayRjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hbdyy9JgsOP+SghFI8FvQwGKt0eE88DmDNRzutv4K0rel11crcCa05erNvMg?=
 =?us-ascii?Q?ZGG9cwP1bIgZ+Mmq2Avh3q9oPbIFN7zu9/XW9vy2BRgHxPC1rb9tdDPfMw9I?=
 =?us-ascii?Q?9BaUVnd4WqvRzm5lBxBMXnL0T6SMbr2HNroXNnlfRbW0IslsLbLinCKRAn7+?=
 =?us-ascii?Q?5m3a+kHT9+RY/AZ7LZSRk4MjVPTIpwa1KgOMLFyBdS/+YTYI+ULKvbL4wd/0?=
 =?us-ascii?Q?+23ls7MxeuFs0xoqg8EV8Ni4FDN75xMiza1WqxrFYwM0Mx1lRXkNqk1G4EQ2?=
 =?us-ascii?Q?d0MuWlH8LlHuz0f5wowf+n/fmBYLkoCOhOsVDAqyzi+T6kELU/q7g/8Thjn7?=
 =?us-ascii?Q?mWx7vCrWa4Qv+/Z5v7dMAtDMMo+pjTL1lkEnaPMqMX/PILLqXwgoagX2hOZk?=
 =?us-ascii?Q?ilOlP9gqxweq9RW+KcAHBaltmnV+lFcHR0qiNE/rXnu61ul30wqsxBVlqp11?=
 =?us-ascii?Q?O62P0zutdHGIkGLkT+PJ1+HSUoR5yFGS4wkkt4NQWPlw9gV+qMoYscKqWbeX?=
 =?us-ascii?Q?9XnX9lHdYc+KGaiIUDucqs7gXmGyCiZ8l2oVnmlD2uguYCpM9Dlt661AgMiZ?=
 =?us-ascii?Q?AfNg6gXBPfltCHhYhnh6pEDxCaNBTsX3T5GMWu1OjRzH/jFYOS5xYJR8VJ4e?=
 =?us-ascii?Q?AXFxjbGPBEn+PwKya7ZRYOhQDyAlu7JjrumeCp47+vsIkHZ99R5O5o5k1Mqa?=
 =?us-ascii?Q?07K0AJ0KGbw+R9Rsnf1zE7v3zHPa/+W57Iqe7KsIhIAP8O9f9OeZ/uhjJTrQ?=
 =?us-ascii?Q?GZfT7gruH/RF+ON0983w0lz9dMUqr4CkiRf9a7pPMnrSrr4nR199JdLpOllP?=
 =?us-ascii?Q?6cM9TKOeVP7HG2B3hfZXgpJYc4ZTRg1ye7XwkJFmAGYvGrIz6YJ0o6Q81ppa?=
 =?us-ascii?Q?w0B5PmzbRwBvXHK56kLUfNUxIdL3UtF8tbayIvC7x/BeOROMxzOfsDsm2nG9?=
 =?us-ascii?Q?lT8MbAHqSJa/NWbZYTpJtjO8nmvlhYFOCrcDUjFHTB0JMNCdPuB6aXyhOqMW?=
 =?us-ascii?Q?MrhDGXLZ36X8Oe3F4QsqznIQcJwIoMxnfskQ0JdQXYlq5MGg5UbXu+kgzA2S?=
 =?us-ascii?Q?dHsXCHdzEwM431hTCHdcmTZmPA60Hv/GR2tnovMk94DafowbyGOKxfOQ96Ds?=
 =?us-ascii?Q?A6GR2ECHjbZ1eoUnjpdnZxE1MJ3vVVzF0w3KjNbMi2+6Aau4JmAOfaUck7lX?=
 =?us-ascii?Q?wBpmogdogt1Gd/jbLKq2UOHoKcNNUYDR4tjgb2uYaP/tUZwRlt6QsSsfyUVJ?=
 =?us-ascii?Q?/sfXJlzAcaigAz1bWUu5zzMwvSIlFqqg9UY09leq49YQ0SyhbyLhEnEnCsXg?=
 =?us-ascii?Q?X1RzXC+fFf//D55nM+7f9KmO+S/p110fkjzVEDl0OGJaZPGRsSCa5WEcGQAY?=
 =?us-ascii?Q?cB66lt+7FxESC23ZXaprkbIdbWTUDl1iMF3irQhngU7qePqrCVxOXQL9lEFf?=
 =?us-ascii?Q?ZbgD0x84u1LLzqHyhjbitooKrrvTMIGykokMBtBvOE02kw6lNw3uGf65+0ms?=
 =?us-ascii?Q?Q17p9TrlttlXR5UHcHlyBx3+wl1BWak8xwHzhJ/PMHu9iV6PYbmiaxS0kJjF?=
 =?us-ascii?Q?HXSVHvlv6DYBab/xSh8GReGnhYUJLoZIXgb3+uER?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fa9b35-d501-4803-896a-08dcf9c5f4f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:06:19.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEGGCc3nxZIZdDEmeJEVzUT5Xf900ahuFScXiEld+UQzaHFN+pDmV0jPCdwT6GQmob2mU4Q8jqH0BZLwuZt6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6772

On Thu, Oct 31, 2024 at 04:06:48PM +0800, Richard Zhu wrote:
> Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and iATU
> base addresses from DT directly, and remove the useless codes.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Need declear not compatible broken for upstreams' dts because not dts
enable EP function in upstream tree.

>  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 73cb69ba8933..d21f7d2e79dc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1114,7 +1114,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  			   struct platform_device *pdev)
>  {
>  	int ret;
> -	unsigned int pcie_dbi2_offset;
>  	struct dw_pcie_ep *ep;
>  	struct dw_pcie *pci = imx_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> @@ -1124,25 +1123,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX8MQ_EP:
> -	case IMX8MM_EP:
> -	case IMX8MP_EP:
> -		pcie_dbi2_offset = SZ_1M;
> -		break;
> -	default:
> -		pcie_dbi2_offset = SZ_4K;
> -		break;
> -	}
> -
> -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> -
> -	/*
> -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
> -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
> -	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
> -	 * above "dbi_base2" setting should be removed.
> -	 */
>  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
>  		pci->dbi_base2 = NULL;
>
> --
> 2.37.1
>

