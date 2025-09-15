Return-Path: <linux-pci+bounces-36166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297CB57EDA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D66189AFFA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E8324B2E;
	Mon, 15 Sep 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mCaIvOVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945430BF6D;
	Mon, 15 Sep 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946338; cv=fail; b=c4YaVZlKkshkQrmmkA4REQj5mvbC+eK7IPUGWdWYZxokisAwOxUVscmgNfSICCIw8gUIqR5p3FoAaHWiy77xYvKJ1eGOWsJu8rCCczAcDKJLi/SV6tRBGkjB0RN2+nxO58h1Dn3Mbs5Xle1RudQh7CBJTlhh8RoNQz0O+cV5GuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946338; c=relaxed/simple;
	bh=MCg+oPEaJ+zqWw8X+rb43aeo+kSFm6igUjNir+Bmf88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T/mnMd9xPLUZYgQbPYCQsn3XzPLhbDqQwRh2+87ewgNfHuYhGZzFY6Bjzqnmcmf3qMlBHvHB+EWWMslrFprx2r2BqUzvHGLUs8YseUH4oBMrotY+RzXVoCljpgoe/o09sb+2nKGeGZ8yT2p+7s7Li3tTBohPWdQ49qkPb6JmOH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mCaIvOVW; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6ecVRn5XLWgvBw5f2LJCA1UeSbA49L4viSOhPQq8JKyFdQXzqYPpA2PcAPWvFhm2w1jCRgv3VquIg+Sgxuukj4Q+skgGvqJRrCKkyZ5xXkIDVNLjJi6FbK0511zn/sGChPG3HtE6DAheBKU4/c0XU9RsO+t9xo8O8ClOtAU9ceHnoVuz1TtkjC9Cys72f9PCaMzaWsV0weFco9V4UNDpcnm3slLO9/3fKn2zj6v3gIDmC8wW5WN6ghBlFZzC/dWaYgtSYaI9qGf1JeDFcqOZq3J0x1ZiFVHUDmar9gan9OZWLK/yoVNDwiGz74OWVFVCujgTK7zr1GZGbhMctUJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xigNK625I0WU6wh+GslJ+bCKkPMqF8Fnca2KiOUET1w=;
 b=zSQZPcagTWNlgEh2/NEQHAweAXrV/KO1OENqNnfm32tdykXGBOopQqsC33767IiSq6yEjRlytEecxgdd/BF8vlZcGeaH77Sz/8ZVUdXAMytP7t7jLkIrVfeY6wgXcCP0XIiZNwU8e/GFXpbfJad8/KDOveqj3apfL1CngJe6Kh3vdI6sewfS6XxaDzCrTzL5wtPmYK4LAjjaTrhHQja0DYfpSRVlgVYkcmXHj2XZp0hR/y5XEH4bLbMd8bG08wmcqJosNOdLrl0BPRN1WaetRnSxtTtg2Dl1eRgYuRG5W8mLhJXbThza7R+Jdw5fakfogj2ssbmHhvlvDWEMEmBVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xigNK625I0WU6wh+GslJ+bCKkPMqF8Fnca2KiOUET1w=;
 b=mCaIvOVWCDSdvARegQ4xjnzV7Ny13isWgI/MtPe+QfJyH3kveulndMt5JT37V7yt13LqjNL6F59HmEFs9p2c2akzzqRztasvB/uoJDNDdcnMRxWSJfm/nqZ90xBeYOYYCQHzO6OAnDfLbE+f6/lU7WRmRDchTuXle3Rm5vf/QFe81VhEjoqjWJ99TdSS155w+GQtUAAstR5He6m5xcV0tGoBAh5jnq1vtjfKjzOodsGOjY5VdX6xCP60z0q17OCq/1N41y8MA5kFe3blOC5C3aDs3R1ON+mhUV5gc+bPY8V7TiGVc2SYKXo1L7b4/4rTtOGuy08Y2gdIXOFU9Ghsyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA1PR04MB10365.eurprd04.prod.outlook.com (2603:10a6:102:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:25:33 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 14:25:33 +0000
Date: Mon, 15 Sep 2025 10:25:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <aMgh1L/TcrNvaHtL@lizhi-Precision-Tower-5810>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
 <20250915035348.3252353-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915035348.3252353-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA1PR04MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a0c5c3-2632-4207-0763-08ddf463bae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sscOjKkvCmVTRR9LFMpMhxA7yXK2bmDiWMYC0LNSt0r9mfx16LkbAp7MsDL5?=
 =?us-ascii?Q?e79r0t8L7Dm1WkLgE1MCLoi2oH6JAxZD8AZQDWwntRiDcvIPoU1kig4SNtoh?=
 =?us-ascii?Q?8KUyuafxI5oMI7jPp0cFK0c54PBs6bbNemRxyO5vjP57mWCWtcVe8cPPYVnl?=
 =?us-ascii?Q?GZYn8R0k5/EXZ+H0deGW/+Z4eF78f9IH7AL1iTmlwzr8vA75IZVsq6qbPWUR?=
 =?us-ascii?Q?iRaVbKHiMQgbUaxt019jenXLrdW58TDk75MteX4wWL5Zo/W64I3ukraL3Gst?=
 =?us-ascii?Q?WViq5wJfPleWtdSIRlqhPtvJKb0wdWdj8v/sRPZE4wGtvxSb7gH7p/opCkUX?=
 =?us-ascii?Q?Ev4QkMwn0C53EbVsHyDPFXqIbxHMm/RDGamh29aF6h9ZbT0Y63RT2cehvb2d?=
 =?us-ascii?Q?G6XtxrzNG9XCxmW34NWXAZuLQ68TyFNqhbCDllTapwsk92NVMuyMk5LbODvb?=
 =?us-ascii?Q?JpR986aTdEbGsOxPd7utoJu2NlXai8Txrg3wqloeNdCfkzRCnDeL5NWlgHfl?=
 =?us-ascii?Q?vxJdLitCce7nbIFKp770/O1Ghu1ySMUgV2Gc/heAiljKpGybTIX7SPRBnsRZ?=
 =?us-ascii?Q?vSflrZZpvi4c4uJDvK0eFmPtGYhks4SDVXWz8kHFjHWz3OXckgopPkGHpUaf?=
 =?us-ascii?Q?+OZ4sJcLBLkw117zIvGefnI4l12ooQcSWpUg1e2rq3bWTrfVraVTDmlFpUyJ?=
 =?us-ascii?Q?Yih+GmfXlBp7PfXQ5qNW2XmwhGFgPGDzQQkTAIk/KS2lJUMuHtu0e2YjSjyK?=
 =?us-ascii?Q?orxobUcO+4+cGxQ+BjNPm9ZsUiGioXEtiqeuagPfPawXo/IEqrxqzk+kC33c?=
 =?us-ascii?Q?WVOhYh5K5CqknT+nMdPwX+lfhxcdgNDo4nd5k8hxRsheXXynLz8uZ1O1DT+P?=
 =?us-ascii?Q?7VFih+bkGqTTdGBfrfgLvlsIE8rzZoNWGGwzury/413EnFmfY8aAqww/D/S0?=
 =?us-ascii?Q?NYMfzhEYE6oK0gCqQHcCUwGNK9t9cYMO2O/Ln8hqLjVk0437OcmMoT3t3zBv?=
 =?us-ascii?Q?pMmdqnNGNxjCUxZZ/bOrfqjklKtVfVluxDytQQsVnNAFD8ug/AkMZYgV9a3Y?=
 =?us-ascii?Q?Ojb8po14eOK6+yQgJsJMlHPQKMEyicMsAsarF3ZRbjB6Uy9w0HXt10AA/Jcp?=
 =?us-ascii?Q?XuPcpfvDbh35YurvS93QfcYuqUpLN6ctJKzc1+yMQZumXmvVKT40KfwKLuWj?=
 =?us-ascii?Q?uumd63GsuKktPVLMn22RM7a7JxIrpBfuFDjXVVB9XYpWH03YJsyd5eeVKLzK?=
 =?us-ascii?Q?APDP7Dzf2FuEDITGziajXFm2Ic3kaCHWspJMo6xB9LSy1XKEkQ8Sx1qmGu8V?=
 =?us-ascii?Q?tx/SM9dgBhrxymBl/a0TZYQ8mYYth2xw9rmudBZ8vsyaSDoeEPtL/UrErZtU?=
 =?us-ascii?Q?GsFtGqtES4J312qlH10X+8nverdf5d2KYiIPoimTtIRH6mKlt39K+wka4rJk?=
 =?us-ascii?Q?lJ06ANezMvLUvRmCyqSLImvjyeAsAQV39BEyt4WVxxdCVOhi/pEb1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFRtGbUi4ACh/ob8Wm1wIuNu265nd4haOiHThBA9n6u294eNlZ+6KUT+bgBq?=
 =?us-ascii?Q?NTzMKZsR0VN/wHOH+e6xiU6NKWlBj2ctjnmhBAUnu2NL1uAZWJriWowYHTm8?=
 =?us-ascii?Q?wsvWWa641EEJokx4f1X4Za1Pe2Ciw/MSGNhgHh0enOWimfM7uN0Y+d3weGQH?=
 =?us-ascii?Q?HiLY6bIBWbhA4iAnw9cfkcNWJ1EgMrp0lNA5I6qmQUQsN97Ir9lfBwQ6wakQ?=
 =?us-ascii?Q?Bn7dBK8yZTSDsu2JHUl2ObnMFHBirJA7RNoxrODQyRhzKYWoIvy6Apu+cwXj?=
 =?us-ascii?Q?k84GivsaOHatxaKhjeXBmpdKHslOKll8Pd6xN3Vzp8s9oPU3t+UM04A0v1iu?=
 =?us-ascii?Q?kqbPnKSt+lRXw5e1Vk5Rs+8oMK78H/sDiKFqVqRx1ISQ1ykqPHg7yRFBJxkJ?=
 =?us-ascii?Q?WVpnOZAIDeUM/r/aS38vwplgOJuq9IbDoz0SnVNOEsyApwdH5cjPjuM4ZIvl?=
 =?us-ascii?Q?yhxaBtAcZEC0dgQ3GhsrbBPzyWYuh3+6rnqqcitkxmuNjNLOS5GoLBWh9CV5?=
 =?us-ascii?Q?WXhJ6ymeXw2MCeLluD5O5K/mPBHShyy0rslUHYV2SMQ7fS3yb1zgYfxncM3B?=
 =?us-ascii?Q?1tgz3n/XRj+6QZMnxMViKKOspqgjA7n1+TEGZ9aW1LEoeO6N4OARc4bgUPDE?=
 =?us-ascii?Q?sbevRpG95qf4xw38wvbjlEYkbSqa2+no5v0S07EARj3MthP3zr6n9uNgAkrX?=
 =?us-ascii?Q?TTm4iPJpgD/hgFVywwxFIhoIVyhW56elTNExVZ7Ae7SmTiHBE2kXhnZi5l2B?=
 =?us-ascii?Q?KEk2cFEUBFQXF0caEULLxdLIrCp8Nx1AkGVJVR5efQ+QAmWNBir1om76xL3I?=
 =?us-ascii?Q?mKu/Ss3E0NuQqQBDSoXkIFMKgkAlsax0IS5tzATR/+qZEoh8vMk9ftwmmyGs?=
 =?us-ascii?Q?V97BenZj8LuXMFBpoMUuPeO3pSZqFyMLONjdiLCQj1OpDeE6mMk8c+jzNFet?=
 =?us-ascii?Q?VU1YgaNwhMMJsVlilqGWJlSyYs9CCdAdIardcyPOkxgt9D7Ho9sA80dOX0od?=
 =?us-ascii?Q?4jKhA1edRXdnOlC2v2XNZ4tn6jK/Mo4zQ2KneZqLLS0Js2AUK2MSDN5JKreO?=
 =?us-ascii?Q?1rkI8yB5GI3xWox4x6TAFN/cI5gBzluj9MOyPB4cdt2bOxzxmrDvUDeejuYb?=
 =?us-ascii?Q?x+2wvY4CCGf816oub8ypFyofFpzraL/DRy13Cu2iG77a703p1KbyYiyX0xwM?=
 =?us-ascii?Q?UVLiYPdGAwac+jexIfqMvc/GZ/mprxelChKd7IqOuhYOM3/0+7J34x4CUact?=
 =?us-ascii?Q?kuqh1+Tb+/AjW4OS+u46RrfHcSSHnCPGQSSbhXAmjhqxgbFQVHrMkA5IKbkS?=
 =?us-ascii?Q?4LfjmYA4kxRvcuprYJrS/55g6bZSg+q0oOQSHN1FB/ks9awEArX62YirzSS3?=
 =?us-ascii?Q?idfImrBoMiYYfhOMjry1UWZNmKHAaaXrkCH02owrzXJJO0dtkQIv0LY4W/jS?=
 =?us-ascii?Q?vJOFfxNO//7BsvLaVgVyrMKmihsfkkRXXJ8KW8tqzHZp34PSVARGvpklTIRv?=
 =?us-ascii?Q?WVRVcit7WS7eIPy2f9FgzvgHbUbhT74REVRcn5SqM3w/RMjT8RjVGEZrOEw1?=
 =?us-ascii?Q?vYCAwe/t6P1uE5TLcj4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a0c5c3-2632-4207-0763-08ddf463bae8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:25:33.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO5RycqUexkitahsgFuS1p/znyvl31Zmd8uCKu7oGZur2ldT6IUL/XktN/Y5JmqH6lqe2AdpbCKdavycUscKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10365

On Mon, Sep 15, 2025 at 11:53:46AM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" to for a reference clock that
> comes from external crystal oscillator.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..0134a759185e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from an internal PLL, the other from an off-chip crystal
> +            oscillator. If present, 'extref' refers to a reference clock from
> +            an external oscillator.
> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> --
> 2.37.1
>

