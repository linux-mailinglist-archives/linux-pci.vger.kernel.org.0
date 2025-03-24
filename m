Return-Path: <linux-pci+bounces-24567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F9A6E369
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8727C1889154
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5C1925AB;
	Mon, 24 Mar 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BdB8Sdw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4E171C9;
	Mon, 24 Mar 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844139; cv=fail; b=VZj6Cj0YOcn+qEXAZRTPHj5G7bTMygkxxZc0bbVmroxpnfc/XWDZdQh+pDC9D/H0rKA9G6F8Wxv2/7kGOuQeULvmuein704LgU92GYw+Cnj/0JF+Aq3WPo2t8jxI1X2EmYDSZWIUf9qzAc3hQ3HDgFmZOMkBaXfgAIe2WqZuRaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844139; c=relaxed/simple;
	bh=F7v6zQRrziA0jXKlAcerT41dJqO4Ni8GA6kNN6qBKoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghWyS89okiBeUlTnnTernKH1LWK8zLGkmgKPyTYQZMCd6Q8hei/GZyI/OZwjm8f2bdA3VRgsXxiJAn+Zn/6S2sLgg0u4EsY4pOTDjf3KbZp6eB3oPGFXUagGUIuWEpkzJR8TpZyOv/YwuzcDKBQagDFJgS42FWZLDOflkg5EvQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BdB8Sdw0; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4IFA1mJy2jUSU+oZ/Qy1O2Uf0ol1cfcobOUvcQP737Ef8hfciL4sbK4v+jEGVJwmv+97rUUMtR4MlvIK3SPPb/giFhkSVocTG1Yfuuc9ff+Kpb0Ur7BGUQ5UU5qtO/DYmzIqVxANaDU3JSFw+JILDh4pZf/km7rvhsXUpPlzYK6dPX8mBKcyeMyIloUSVd0z4LHgFR6dt7IgCq2R+PeKrh7s7n/pnEIKT69CZgGZQYJlZjluwArF5BnpzaLRgWB20gR0EWUlPvtyVz7nFzA32gufo1y4hzI0S7hXMtKb+nHxfQslIoMz7YoaqhLNKcyXm2I4lnVTiCH5aJ0DUFD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V997GXh3CreCi3LAWuOJLivPnXB0t97orwBojTM4oag=;
 b=UGFDeCMw9c3g/AwRy+fbC0ohpPxOJh9scJ3p1zzHrddlpfn/mT8xAXYJisjM6kPqiwiZo5hcxrzSHwIAGR4O2iCXXAl7msncO7PNA1QmtFOruhSOKIBeDZw+VKrZ0SUfKLWnsX+J6ofWKVHYMqkUPYnj/vixtvizGz8LTygxYDayRIfdzFKUtlEW2qErd+WTM1T0Gz6HJ462LN8W5oxnLmn01yFd58kP1gkSHnnMrHTvrYE9xL9AUbmxfv4bl9tVTv65HZpetoveVwDscJ3c8U9Dyv/QtFVmhk2RvtuY8Po0/z+bF3yPnx3JEcZVu/dZ9GraH81cUHxG6l7a1D2iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V997GXh3CreCi3LAWuOJLivPnXB0t97orwBojTM4oag=;
 b=BdB8Sdw0WDOpCjpuJXmvJgvNuwFIgWEGi+UO6lzVzRV0kKWwEa9MQt/16jENV2okjc8WJpcOouBH/lMLmAXzFHl90nG6VXWJEzMyzooMVYXD3tRsApvyYyGvkVSmDEXyehB0rl2RhHQf8XVzUgEDkVtckdPKO/xKVvQ6i2i3MaYfvJaX/VFVwl/lyfIKcKGaXvTyHhACeQppg5+u26FxbsjP6ws374/sP81IVMkwhcpJ4P7noVtvHcLoEUGKarIrZ9Y0ZwvaAngRXnL1gMrPtB//06Hgq5bgKjGaWg/ImZHOhVaNWeQLPlXVK7sLjdCIovrP6dF7X4YgcUZ9UaBaqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:22:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:22:15 +0000
Date: Mon, 24 Mar 2025 15:22:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] PCI: imx6: Save and restore the LUT setting for
 i.MX95 PCIe
Message-ID: <Z+Gw3g0FfytALdRo@lizhi-Precision-Tower-5810>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-6-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324062647.1891896-6-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c6b9d8-f315-4d02-81f1-08dd6b092f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZzWDdo8Bd/HUNeA9iD8gMPrhPmkL8RvLcVk84ltv7sbrmo5Yx4qH5d4C582?=
 =?us-ascii?Q?3x449XmXAtzy0lElq1jFWxYqZYFtv3HkiLhKiWfgM2WaN4PUFUAHNtjZ/ze1?=
 =?us-ascii?Q?VQKphHL2Eizy5SMEoJzxZyIwxBRIvJNEChes9BH+eV/Zj7MyelG97XDT4Rxp?=
 =?us-ascii?Q?oLLFd5EQLomWRyBBD7h+wibZ5LqJjNsGuacss8OkTV+vk4Th8OwQMIhYxSza?=
 =?us-ascii?Q?EvM1y/S/0xGonI3EReuCzpMMxX3WXAKHTM0AuhfmTX62C62WAavOisQXrrmZ?=
 =?us-ascii?Q?ucGKfgA4PQRaiJ80RmbEWq4eqAMQ5YcreMKQhe5TEZxkZ+xjlSU+6omw1Hly?=
 =?us-ascii?Q?mUj5czKPTjv/aKq4Hk6UIvW1yW+42WIzPkPpYbUHRt3e6ss5PasK0hKz9JN7?=
 =?us-ascii?Q?iIdnTMRj/+pJ+R4mIn7EeUl7TP0f6LOujx5aX9v3yY1wDy3ZL2+DOfXlnYZ2?=
 =?us-ascii?Q?rO2GhWTcDEkJFeb+Icp/mRx/OS1ZzAF+L0e/oH9oErdRQC2K9hokqF0KlTqR?=
 =?us-ascii?Q?jDMubn3W7zkpgJlA/X0fM2fmfPEL0sXHniuwmmvD8OUIcUtcPG1eApFgdGWF?=
 =?us-ascii?Q?oL1bfJv/+57VcWn5o9ME6FhUr5iTtKPQl4dEX76hg/UAtdSoWfeUQZuGdkuS?=
 =?us-ascii?Q?109W/bs+w2yyuph/PNl2QUTE4AurKRHqNAsrZiHRpt2W0hijVfBvw6lkC4Ve?=
 =?us-ascii?Q?sMnfJ2VnMIAHsAjmAbONpn91yo/Vlv+4bNyodEViF51NDGZFKf4+E5YvZtJe?=
 =?us-ascii?Q?rM8r0xZHGZfLBwaSIL4tIKwpP/E2hiXWRMpBQ0TN/cEeniRszgAm5z86rDBQ?=
 =?us-ascii?Q?LDGHtrDQMGNArJJWIGuLh2QL9TeRgbCh2PjgqThJ0CJhxmFQPJQJ5c/V/58R?=
 =?us-ascii?Q?ztwyiLVx80sv1H71u7vDns8Ok7TkllJvafpCLqH2Jph8bsvHS1b83eV1qU0j?=
 =?us-ascii?Q?CKhipD+z0pbx3Qy/dQowP5mJ1visOOV8gIuIvYgKDT5hk8baeD+17KmzTdTf?=
 =?us-ascii?Q?j8dnrp1Y80Bia+QJRRXg7vPTWIyRpUrSUCDje6kzFfDH/cetJas/NL/q+xp7?=
 =?us-ascii?Q?/bBy3/KoIb7MwLCwsjSZx5XINRmsC9d4ZSFCnDYpuhW/KlaQjRBqB+Z69MDe?=
 =?us-ascii?Q?TedIfaL27TNc2OrvEnXQQj6QWNLcWAqy1LteKNBswPnHYGiO9wvULLsMngLd?=
 =?us-ascii?Q?9XUi8l30y9P2bUpRdO3j0r3tughA3uJ/Z3By4XTxd4NU/UfsiRtrTQf4bqFW?=
 =?us-ascii?Q?qlUQvIStS83k9/HCXRlbOKEFyYq3m4WXiMoUcYEWSLMnz+Ca+2TkFXhSUk59?=
 =?us-ascii?Q?MgFYg2B74qH8I7H8RsrQIEpv+JBd0HYU61SzN4w5sunNK3g0lFRGlTHV4CvO?=
 =?us-ascii?Q?wZdiWoSsYVUbsfSeTIIXtKdvGh1mpzx4aiYJekwsvRfEmQmzMwzb8eG1Ew3h?=
 =?us-ascii?Q?qd8SkxMeWgHWpr5D6c7dwoQTyA7RiG7JCzGcKzeBUTRcJosynH5KiwLDRw1c?=
 =?us-ascii?Q?YgZ0K6fbb3RVjaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQjMG74HD7DRjaLOE21rsGsV8LRSImR/+sfMSWeadepTjRaTJzzwY5lLgrAM?=
 =?us-ascii?Q?jfcRPcgyPJCBEhTwXrM17g0TybSN7WQ0MygRpISgwFnbAjaG4yrbs6vV8EIB?=
 =?us-ascii?Q?xhJoP7s2QGw6PKwvMGZ6Vibs/Ne/wylVWu0yebVyV7tGUXlVvBUq7mRZr8r3?=
 =?us-ascii?Q?ERN5hkWehLV1DNQOBlDXHJl/TdKMT3gXBNNqMqXyospa2uEKkWfH5Y5cuZSR?=
 =?us-ascii?Q?8OQx1BWvpD6gUmzqEXwzDE0QZylDadkUcEMmChHY5YrvxEFo+mQ8lDZ5XKGh?=
 =?us-ascii?Q?BiE8cnOga88QsGJ2j8E59r17ZUSGLXNcLJ9zzDlDtk6+HC38EUMFriTHRrcQ?=
 =?us-ascii?Q?sJAJkJjVoEO+0/HEAqX6IIBBdqcddixCJtNxjPdPCBBS4vy+BgUz97vKtuDm?=
 =?us-ascii?Q?EFr7rvvySOBfYP34prX7pXQf/oLLiPDno9cdhAgjCksAJ1clrGZ1XQ7Va/gE?=
 =?us-ascii?Q?yHTetiA1NLdz/KQX20ulczASQu2hbbzaTPtAHYIa7993ZQc7PKV3TLf0JOg2?=
 =?us-ascii?Q?p3ZfYJEdnsykK7XiSPVYZfMR1XSRgX5mr6FpYSJipuY6WPeGJ9b39LzLxwfy?=
 =?us-ascii?Q?dLo0aMg6P0vjULg53SdFcNdxhws/Ci7AgSDnlCjHkAegtvZNgqv+cgA5tNId?=
 =?us-ascii?Q?lU42s/Ll5+L2W9qZffezHpWd9FV1+CS+1JIqcVmzzL/vrAZIbKqGjs86PZUV?=
 =?us-ascii?Q?pFtJ+qO7dS+2P8bvBpZUQueI5RAtQ3VkkJNApJFo4Auomc/KOt61u7Mv+smt?=
 =?us-ascii?Q?mXKOMzzMmlYYMHB/G+TWHPmRjv4+8B5/ucL8CkShXtTa28l25T5KEbYTIzMX?=
 =?us-ascii?Q?DD/gxReoaz2dXSYrWO5tV6/LMQt0tT/VH5UKpPFVSB8xKTR5G/1iaokmf/NW?=
 =?us-ascii?Q?OaoK3s6DqkSqBMtHW3Z7hA7Gl0aykZzSyF+RfemXPRslayAyudIYTDktASXm?=
 =?us-ascii?Q?f3kN3I/2U9m2ae5URAZE954JgZPFKIn/zetKJOsgRZqJn2JUZsoJuVs+s9V1?=
 =?us-ascii?Q?AUIlK2/Dro/XlTSxfT2P8OwuozfRBRG2Oy4yYeL5Li3lX2TRwiy5cgrGq0Na?=
 =?us-ascii?Q?/zK9gay79oNK8JQ4CcVjfwetIB0L3OSJlL79Cxybti5Zx76R6O8LJOgljQxp?=
 =?us-ascii?Q?MCAuqxT7HzDeN6x4r4nsyWCpS+lhz2rV8kzO009lOWhU1LvJZ2heOuULetyi?=
 =?us-ascii?Q?TQxQ7tzmA5fY3S53k6RFA+aP2CeucptC2+2WUvZVQ9Eh9v9btWSXAHsMZ1Qm?=
 =?us-ascii?Q?Kikuvt7O68uwKmGLV+9SWYTjMXlhHy7WbFLRXSkeqx997eI8WX4iOhhAXP9O?=
 =?us-ascii?Q?hbe9GjOzxdNeLvyc2UD1VkK8F4h/KmpfH/CD8s70Dp25ztO0wMb3bt3L+ZsA?=
 =?us-ascii?Q?1Rn/42p4+1C+wVWdTC8aUT+2g5nUNO3BsvKKsy7GvOgIA5mztktwp7E7+bJ0?=
 =?us-ascii?Q?E5avk8W6xRePN2l6ISf8ftjn80EPVnyRrVV9K6qw8LQErF1rMfg8ZlyDVnut?=
 =?us-ascii?Q?wgtTyIa40usEVvboPQDv+nEOKDBKzDA6Grhkr0kgFFfft4kyTQltg8/wiGYm?=
 =?us-ascii?Q?x443DmIR2cMdip8gjG43utzCunBcGcDDkR65vLM1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c6b9d8-f315-4d02-81f1-08dd6b092f5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:22:15.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVASY57LpsuOeaBSiThzdG/ncrwXwrgGDp7H51q1kmeCCYArDWIFbXV/JeXP0KerpQCRBEHqYpQOV5rM0jM7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

On Mon, Mar 24, 2025 at 02:26:47PM +0800, Richard Zhu wrote:
> LUT(look up table) setting would be lost during PCIe suspend on i.MX95.
>
> To let i.MX95 PCIe PM work fine, save and restore the LUT setting in
> suspend and resume operations.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index dda3eed99bb8..a3a032cbaa3c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -135,6 +135,11 @@ struct imx_pcie_drvdata {
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> +struct imx_lut_data {
> +	u32 data1;
> +	u32 data2;
> +};
> +
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
>  	struct gpio_desc	*reset_gpiod;
> @@ -154,6 +159,8 @@ struct imx_pcie {
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> +	/* LUT data for pcie */
> +	struct imx_lut_data	luts[IMX95_MAX_LUT];
>  	/* power domain for pcie */
>  	struct device		*pd_pcie;
>  	/* power domain for pcie phy */
> @@ -1468,6 +1475,41 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  	}
>  }
>
> +static void imx_pcie_lut_save_restore(struct imx_pcie *imx_pcie, bool save)
> +{
> +	int i;
> +	u32 data1, data2;

Reverse Christmas order.

> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		if (save) {
> +			regmap_write(imx_pcie->iomuxc_gpr,
> +				     IMX95_PE0_LUT_ACSCTRL,
> +				     IMX95_PEO_LUT_RWA | i);
> +			regmap_read(imx_pcie->iomuxc_gpr,
> +				    IMX95_PE0_LUT_DATA1, &data1);
> +			regmap_read(imx_pcie->iomuxc_gpr,
> +				    IMX95_PE0_LUT_DATA2, &data2);
> +			if (data1 & IMX95_PE0_LUT_VLD) {
> +				imx_pcie->luts[i].data1 = data1;
> +				imx_pcie->luts[i].data2 = data2;
> +			} else {
> +				imx_pcie->luts[i].data1 = 0;
> +				imx_pcie->luts[i].data2 = 0;
> +			}

Almost no shared part between save and restore. Suggest use two helper
function imx_pcie_lut_save() and imx_pcie_lut_restore().

Frank

> +		} else {
> +			if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
> +				continue;
> +
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
> +				     imx_pcie->luts[i].data1);
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
> +				     imx_pcie->luts[i].data2);
> +			regmap_write(imx_pcie->iomuxc_gpr,
> +				     IMX95_PE0_LUT_ACSCTRL, i);
> +		}
> +	}
> +}
> +
>  static int imx_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> @@ -1476,6 +1518,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  		return 0;
>
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save_restore(imx_pcie, true);
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
>  		/*
>  		 * The minimum for a workaround would be to set PERST# and to
> @@ -1520,6 +1564,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  		if (ret)
>  			return ret;
>  	}
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save_restore(imx_pcie, false);
>  	imx_pcie_msi_save_restore(imx_pcie, false);
>
>  	return 0;
> --
> 2.37.1
>

