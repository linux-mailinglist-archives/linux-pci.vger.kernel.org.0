Return-Path: <linux-pci+bounces-30193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C02AE0959
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAB95A779B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134A2288F7;
	Thu, 19 Jun 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cHavFHxB"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A780226520;
	Thu, 19 Jun 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344886; cv=fail; b=AcqsE43URwOfpMMYh623Teu1jB1gF2xIbhd05/GGUkHmn5DXuZnuYbQKLvkveI3p9y3x7XAo+HILleSL4ZOaIplQ/TOTNQbdKQxPaRdMGIib/gRTzIhPv4gDj13brO0SEO/olITXpE77aa5MHFnAJPR+TqWEhKo+9ToUi1WbL9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344886; c=relaxed/simple;
	bh=ARHtHj/h9Mn+t7DI/DscnJeD9uWEqVTevdtD1OHoCSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U+R6R8m+KP+xQOpOIUaq0OcCZGrm7j8EVUSdiWFhimAQ3Kz42PwQ3hmuK4vww/4FXIPmdpKalS499xkp+qbwng7YvHRaB2U6BQDBgTxBbFVQjWh6C1UzIMueqgIZPbjL7oNv/jObm+/H77FHU4JRaJp2lK1qTlJepWKlVlvLN7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cHavFHxB; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlXNWu+UOGjOCAFZOpgBBALlTXc0/4+F8DR+U9qWIUDXGlTH3boWUx1F9t2rngh4ZCmxbxolTLsmrUkQwDg+0TLZiX6DZ6jKaGx8qIDctLIbOU9uQ4fEG5wokT4Rl80X1JQmd+kdTvsnkbsplCcBfeHS0kN6Ge6Li0LxCr/3nMd3HXmU4GPgqewDHNeg1XV4XF0X/9pKQI4XtsI2D6/l4DaW3pIteHL16IvQs5coJZUvM5k6k9PR7YVpjRuJzkcZ98fMr6rUGFrlYpkB8WMS3j7gkGSRMfkqDU/Sr0OCFdau5uIryjVyqT0zT9dwvedvvgWLQXybgaycxCbZZi+uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJj/Rce4Fw8we64+DXLYr7eJug6akF/DBAlPLdpeVDA=;
 b=Oe8BoDv/xueBA2rmbwMC0UIFVjHoVrslHzn4mfxCCw3RKT/JUeIvVjeg1gyOzw2bDNYz7usAjQR3IvPta5SHXvbkD1DnzK6S7eEdOEo5rxjGNDoLwSVAw2sLC3xk9k4xnIyODcFvoxMpottw2VsOOkcDO55Ro/kVqT8xSqjfHDtXQ4afDYk1vXpoCubQoWDbojbUD/y9Rd2KMa2f02hWYHaVZBgS3e1k1lQxcPgeTT+lcSSEaAM//EY/Coi1RujTknML9vIekAIAwUsKsRBfRkm/I2yN7rgJc9xfmMiU1hz2CESlxCHp9zhJCToY0ZCaiTQ2n9c1q5kJ3a4dUcy6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJj/Rce4Fw8we64+DXLYr7eJug6akF/DBAlPLdpeVDA=;
 b=cHavFHxBGfJnTHoKqrcpkgESznKAO8E51PHBheQwo5bs2V1n0bJWe6PwTIjEZsHUeCeB4THfMyRJV11GYWyP0lvp7o/3gjXFDhuA2SthAPBdTDGwKo4A5kH1Z7r70O5KvTCIhHxzNweAy95NCD0gfBLLYooJXw9N7groJ6HdqpTbh/hrzcRTCkm5Sy6ZQlEAHV4/mVlj8IbpqHHChGeAibVlPLPBdiddNysqzmoJXZxYD3PjB67ulItytXV/GvAUV1JKtlSertMHZ+/4u8LNTEBbx+z1wgmHroTgBi3ebiHoXRYTYH+lzgjUKi4Ai3l22qttPQiVX+mksBzq/Er2RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 14:54:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:54:38 +0000
Date: Thu, 19 Jun 2025 10:54:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: imx6: Add external reference clock mode
 support
Message-ID: <aFQkqS4k4ZAcV/Md@lizhi-Precision-Tower-5810>
References: <20250619091004.338419-1-hongxing.zhu@nxp.com>
 <20250619091004.338419-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619091004.338419-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AM8P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efe819a-2b2c-4fb5-e559-08ddaf4136e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaIKzWBiHVjPeR4ReH/w3lGp4R/X3P87+3o0HbZ0N53xh/dpLXXfskrYJeXa?=
 =?us-ascii?Q?xwZC6Q9D3hJKglrk+l4EouAVi1G2Q6kLoCnaxJeBcbyYvwrI7VQxWSjYAsc/?=
 =?us-ascii?Q?4IisWo5v4lF2BTouoERhLOIzbApLA5O49ymZKbGCSAIKJUqKwwLgo3plKBVF?=
 =?us-ascii?Q?v0Eu7TNdBDvITpnVZIm/lzzbY5t2uyoYlPkUs9mqxqJOVllB4owLBxEi/uQD?=
 =?us-ascii?Q?92ZtC+0oCLVXZ0WkuYizNNZkdN/d8Pmjlgesk+b1KCxYpdl34DUlhTq+/vRL?=
 =?us-ascii?Q?TdzKOykMUO7fmR2Mq1F9MGJhWW96mFUyVOo1x8HHcUBaxdQsObAcX1s12Qwb?=
 =?us-ascii?Q?DrzhD/ByK8sLhTg2SiNsojiiFnBGX/sC4HirnAQwGOYU6LFovBgmJJ0p00TA?=
 =?us-ascii?Q?NrS1x4Au/ah8BVcNEEVrBqMVR/5MJ5/3N40FDyrojZXLHKu6Qzxk6vgW9AoS?=
 =?us-ascii?Q?NkYfjSvPr48N5RIlFZxoont3m8i5Msot8zgNTlt0CVT/RTSebjhUmLVXi2Xd?=
 =?us-ascii?Q?TNB40PNcL/he8ZDIAsxccaTNtXe9Tig6+EuLpz89No2HRaI3zeM5lLvIS4jH?=
 =?us-ascii?Q?G1TPsPRpBmwZ+QZ4dtXT6/9/aH/5+B/F9+C8U+C96Ax5cFQsgf2RHEA8kXtE?=
 =?us-ascii?Q?DQfCH9zWo75sL86KLZR61GM0AmKM8kWrPWKUv7YdM9ULJDL5bcV7OUsRSDcK?=
 =?us-ascii?Q?feobHbCC0GTNyY2fnoDsHE9VNsCLI98v+xKYO5ccwaP1OQAkKJTFjBCxvh5H?=
 =?us-ascii?Q?W08O1M45SmaUt7HYeTSe1+lsD/vzQrYbN5Zzm0ktjAbxVwjjt6kFhDabAyjT?=
 =?us-ascii?Q?6h885wunqqPhqPHZAemDAziYqO2n04CGLITwMcmK6Ikyc1+uLMZkjbaznFkc?=
 =?us-ascii?Q?+cdyrey6FZSbapMtFV78NjWkzuIr/pKhKGDY3F5PAbijMdib7F80HGf1dJzn?=
 =?us-ascii?Q?zCGUKSClFL34482aRBSVhATDiicJHKtNmy4ftYx0yLeT7v7URrEgOUk5972x?=
 =?us-ascii?Q?b+U8bHOMEEpulV1HLZQqx82dCWFjkx3st31ksuuP+WOFiUjMpgQpgHwUezWV?=
 =?us-ascii?Q?ekjRLSPSvZcNRbvYgviFIQLgOjlcEfhxIL8NzEKbWNuIyOkOFvouC1OvcXIE?=
 =?us-ascii?Q?og+SAY1qkv3YN9DYxt9xu8V6HTU8G/H8Y+NIQYqYUW8F/ftvW+gc3DJNBbit?=
 =?us-ascii?Q?icNrwldVXhMT1S2Mm/oa7RneEAAjHd3kHVVw8qc+hBL8GuFDmuvhR8lSm5P+?=
 =?us-ascii?Q?k5q7cC97LD5bsOGWZ+ECZg7yxZv3Ohk3z+kl+3bkpVFPI3lduMIylQu3llqW?=
 =?us-ascii?Q?CiWxOoXMZdPQcX6RbOJBX55Y8E8jVRVOfQFs5UIAP3NWYSx2KW3hmR5jW8YR?=
 =?us-ascii?Q?GaIeyTmW1t/SKZ0UDVUliIV7SYLBPcU4w1HHFqWVDuNg6XdM6W4v56jf+eRn?=
 =?us-ascii?Q?cJZu+WUPjdxH0FyAiKtTMqn+z9eeQlgcno7h+52T1ddz67SGbm24DXzIUSOB?=
 =?us-ascii?Q?8vgGUw9f+HtJNTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omvuYjMx6URbE4u3SMhGcYcEIstVEP4GZrNme+xfBfVLYp5t4mJXXW8JcSna?=
 =?us-ascii?Q?roq17BUx0XQ3/wW3XHKqOoM7/XLCjVkTbtcNEVwfVJb130Yn8dGkVNwRQTXd?=
 =?us-ascii?Q?sTaZAB76IN8UO8UKtmZwWn24puOH7FB2RbMRWyNXA9cnEKXAHdKn3dMdKwtH?=
 =?us-ascii?Q?ZHzVzGUUiRqd0AVD7axkMxo4/nV1VLeM9TRh39kKxjFtwkWg3MRQKdDsYxdo?=
 =?us-ascii?Q?FuFE+Y8oDAy3oZHRywzUEgubBsa864EjLTeiAYLNYTWjufKKBY4i8vSPTKU2?=
 =?us-ascii?Q?Nzco7goEdunvhT8Fxf2JK2vY8tzVW3c2laeTJu5+aZWX3xDBCbJGbYz4J3+W?=
 =?us-ascii?Q?HZsVs1eue02ayd0WQQntZa7YeAG/Q+r5lehzOx6FSVscEWtML2hz0VAjWjqZ?=
 =?us-ascii?Q?on/v+foSSebHFuRBzGMuPeE0VLwUZP1k3ebXSCbB9DVO4r3Rz+415NARrrqT?=
 =?us-ascii?Q?fMxyCHj/DaY1lijV0LKotL9CEgEZlxyBCSGR8Bpe9g3chtp9motTsnG0yMuG?=
 =?us-ascii?Q?JZhN4lCMW+1G6Ej2j0LKEW13Fne7Tp6p/UD1ZKC7rvzR6uPOHW7C62GNPzfU?=
 =?us-ascii?Q?u7DvbQeVQ1U9PmVY7sD9FVeHWsW/Z2foRKxA6x4SdNGXBo5Vnht5r9DRGt5c?=
 =?us-ascii?Q?Y0iq8mNxqDuXc6Do6UrFO44+MdrnssRtvtqOLz5yiWgdxbBHzPoZohbvK3FM?=
 =?us-ascii?Q?epkivcJFBFYiwncsvU/+A9wj8jbf0PFsGLHBatTlcJ7RCoSpWiO5owDd2+ki?=
 =?us-ascii?Q?wxnUvg8m13Y3QwQ0bDLpP5JBwnMvkvnZsdTamJYu/vB9zYP9XhGLuoKZbQJA?=
 =?us-ascii?Q?PwOIZ7PDXzh5ekcbOIjp4VmfbvysJ7TjQ6zFKj4yRPknusUopduJHqWkLy3M?=
 =?us-ascii?Q?WbfHVO9+5ZlSEjOy90tzISlLAIddRKG9ps9uTMMLJPnKSHgsRfAj7YxHV0CH?=
 =?us-ascii?Q?K5f2OomKI2zgqXfGYm6RpH62J0uWo4DAwx3oKWl+v+rr6jx8IDuBKz2ytHnl?=
 =?us-ascii?Q?udJbnwIqOOCwYcy0dCi4clRvjI1byvUcFGH0wZ1Vtr2PutkZSshJyk7juqkT?=
 =?us-ascii?Q?++fQ7TloT+9nzOly4DymSes+PZEZHLQMeZRMcETm4YGllhDA81udLwYktbHk?=
 =?us-ascii?Q?BSRFExGIO/a18ygvc7jux+JdRwSPOu7OuY5FYzSzPgoAJ+tSsYB0R5eszT56?=
 =?us-ascii?Q?WLhhN592K9tm8/Lb4uEx53tmEIS1dIE47yjpd2O9yfNpVBws7J6hDZsN51d+?=
 =?us-ascii?Q?opvCB7jW+pMsolGYCchNhP9JbqUPFY6U310dkm1o/UvyKnRspwJw83wMXiy/?=
 =?us-ascii?Q?/oEMt8g8OshooT+vUGlkwgcIb0prgr+NsCLIWKC2U4stilcCkapyiAdv/3a8?=
 =?us-ascii?Q?2lg7KdeljBvYnw9PeBOlyGcfv62rMJIEEiSMYKrPzLMxRi1mPnHT7Om/YreP?=
 =?us-ascii?Q?IY7v6Ul8eohfSy2kkR+NWz0+ReghwpEByVvUKjeKb9wsVlcGWCM6btF4HXzS?=
 =?us-ascii?Q?WZfgcCCv2ZW+B51Cjr5eFkw5H3rZnTuF8yyBOrmhnzUD7LhlJbmByIOkGw1G?=
 =?us-ascii?Q?o1301XscCf8uaiQ7juRNAUgxWZBNcgPKoLXC1iti?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efe819a-2b2c-4fb5-e559-08ddaf4136e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:54:38.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC6bYRWN0mFeos8p00MIYp2mrH6emP68/BnbXRfSdolfqfiMsOAIbJE5kNhhV/hWqKtdvs0xe2OeNe93xZT03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

On Thu, Jun 19, 2025 at 05:10:04PM +0800, Richard Zhu wrote:
> The PCI Express reference clock of i.MX9 PCIes might come from external
> clock source. Add the external reference clock mode support.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..71f318bbc254 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -149,6 +149,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			enable_ext_refclk;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	bool ext = imx_pcie->enable_ext_refclk;
> +
>  	/*
>  	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
>  	 * Through Beacon or PERST# De-assertion
> @@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD, 0);
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_SS_RW_REG_0,
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
> +			   IMX95_PCIE_REF_USE_PAD);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
> -			   IMX95_PCIE_REF_CLKEN);
> +			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
>
>  	return 0;
>  }
> @@ -1600,7 +1602,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct imx_pcie *imx_pcie;
>  	struct device_node *np;
>  	struct device_node *node = dev->of_node;
> -	int ret, domain;
> +	int i, ret, domain;
>  	u16 val;
>
>  	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
> @@ -1651,6 +1653,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (imx_pcie->num_clks < 0)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
> +	for (i = 0; i < imx_pcie->num_clks; i++) {
> +		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
> +			imx_pcie->enable_ext_refclk = false;

need break here, incase ref is not last one.

Or:

imx_pcie->enable_ext_refclk = true
for (...)
   if (...)
	 imx_pcie->enable_ext_refclk = false;


Frank

> +		else
> +			imx_pcie->enable_ext_refclk = true;
> +	}
>
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
>  		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> --
> 2.37.1
>

