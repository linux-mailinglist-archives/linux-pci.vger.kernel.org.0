Return-Path: <linux-pci+bounces-30816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC67AEA597
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33ED563489
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C5D2EE61B;
	Thu, 26 Jun 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EdU9xbAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC82EE606;
	Thu, 26 Jun 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963493; cv=fail; b=HqW4Z/c76uJm9ptxWP3AOAYZKNMmTQI2CLHYrjCCj3bOjuIOpowW5I2ECZvt+cE4d0rjJoDiEdCwqYSRrV1WkreQ7IDSZtRN0GBSCByDv0pL2TJ9WlheSFkmPsLsEsFupldJantfLGojiBT+IQGDO6fSn+GicJe9+nwZMKE5XAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963493; c=relaxed/simple;
	bh=9qAXQx7Te6CByCH4OXluZ0u9iRWCdhHdgi9dmGWiWx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DrF+o1Z6b2aQ068O0yVGXIu22AtMfsrz2rfPJvIOthhy7aWFrHGBWTrVSgc+9aI6x9MULzhcKVLVbDBZi0Zck0f0OAeqtJI3WhbCs0F70M5DIvOh8sOull1MIEDD4EhsL6HJ6uNyM3RwX2H5xNCHYYyBMMFQ4PGWuQeg0xufUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EdU9xbAB; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmy8G/Qs91yzzWUKCxSGEDCYJohPaBHLoxEnUy9aAXWe1lRx3JAzI2cdZER4iDa0fIemMbIFVKg2+v4TBc2s37uiigjGdhWtC74LYv+GIHd+pIq8bsmZGc1ht4r0iRRPJiXiz5Wnx+nqbWKLekvjaHbr+2zBLXy12RemX/fUM8Bc4o3fRtDHi2m01RkRjBIrQQog0+LcJhiPfOlzw4ahCCkS/ZTnW48ND57XWDZRczhbJx4K6S3wqVSpCNAberTwZxT2Egw3kbVc7iSE8kWIyb+5YZ0FpTrPITBeWOvFUpupi4UUMl8k3Zb9SZnRO74QZeCqjFGoKaqgN+B38lWU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q9giic9TSLfC2kZAlI8jyg6MWkyn2EAdIKLBXlWG8A=;
 b=UPDO1SrdietD6HzAeWeWd6f0HILeKkwgBJU80Ie9kL/ELKWD9xIdZZB1ZvjZ8HJ/5v7D87PNm7Azs2rDIhtwDZXpyzrT3yoINvsUariZyuA8kovChHVp4ClUS7acAVry/CE6rgR8zEbPFyJdZPOYLyTnSWJA0P0R73bcB7wk6Jf/aPqUxeoJ4otNyGf33cF/i85EInJQdNjCjAZJDozNCJrl8YPAN5Ol6G/6ASoEaBRgrMYnDCuTdja+Zh0hPEcK02L+BE9VmahiKObRE1WsPVNeJXm/WeCCSGBmc/JBDsEc4FQP3fG+TiPikQLAj1WGRUeTawlNL679l1RL+BEclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q9giic9TSLfC2kZAlI8jyg6MWkyn2EAdIKLBXlWG8A=;
 b=EdU9xbABIlOBZaal8IeC+PrSzbi9PIY7QpR0X+eDHTyIzCryeCRswZ4EBzwxWRTflJMBNj4wXpG8s/ZtprgVlNBTKMbkcNanNMuNa7ofIY0cgH2pg+7hIM3qgoqQHmiNfbIq7Ttc9xuqxuBitlsfmYjqScDCEhNQ02EaLvCoXY3VQCNSAHy8pPC27uYL61E2WxBboO3NMwfT97pw9PeF5gtg+/OpqawOlHmzaq5dAQ5UbG2scMzZaxkxLYrhTWInZzZ5VU5ygkLC8/b2YtSpB+2tAoXdWu+XeMUmKVMfAr8zznbcuRRcukCs2K8Nww3E8zAk0d1skxF6LXEy1uxC3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11445.eurprd04.prod.outlook.com (2603:10a6:150:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 18:44:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 18:44:46 +0000
Date: Thu, 26 Jun 2025 14:44:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add external reference clock mode
 support
Message-ID: <aF2VGNojndeg3v8L@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11445:EE_
X-MS-Office365-Filtering-Correlation-Id: 47423269-fb3a-4ee6-b7e8-08ddb4e185a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJlwR6Wd9lDB1mLDcdCz5bHIRhjfbv2tEgA3qNRDz1FMPwTVW7E3yRM9xX/n?=
 =?us-ascii?Q?xhUOOVSM+qR43tRg5P7pJGXQXG+shP1neTEOVly1Pue5qD74QKWW7fUduwes?=
 =?us-ascii?Q?jmfqnRMSoQW6R/4xz4+82XUpdKn+FvYYyZZdJfuTJAubE0cPeH9kFBgFD8eg?=
 =?us-ascii?Q?6BCk2v3uH5CXn2eHtWZLPaDPbM8s+k4tlDUL6qdheSgUBrY8ESdZdwjlAKp8?=
 =?us-ascii?Q?Dmw6Lh0bcPWzH67gsTeRXaJcBiILaNUaGexZ6xMZ3/w54c91C/sQPCfoveVL?=
 =?us-ascii?Q?V46LJSvMtzNbLrYEJRHR3PHZkSEPj0rNWiVc/mYlppwoWk01H+boF5e+lUDP?=
 =?us-ascii?Q?QazUR5fNcPXasF6iWvVCXFegfiir3asE5iwn0NhK/LW6jPWADPnVsPQWWSAH?=
 =?us-ascii?Q?LaDy1v+CHxSEWjQ31V8XIyR3ueKt9mSDbMHQCG5HtSKH/eXtnEGCy0DA/BJz?=
 =?us-ascii?Q?C4B8of+uaQemTcU16TjowJmofV65PAawRA6Lv1W9LSf7aqrfIoWl+ZGkIhC/?=
 =?us-ascii?Q?VFz3u2QYo5yBnHvxuifJkMSV/F2jxx1BJJoDIXB00/369tNxzp0YDGBbQ6co?=
 =?us-ascii?Q?QvFM9UHdXrT1oN/vvKKpJDlU2zugegDeUwXaa5CZ63vicjpoTHzttJggY9Rk?=
 =?us-ascii?Q?gmca5Dah1Fv/uh7i49o/S3Y6MqoSw24ArrYbl0K8F0kaHDB/xXSgNGrGla8N?=
 =?us-ascii?Q?4NXjn5nb4fd0ySTB/+/kws8UBbcr9KKHjbTuWieAeZgqnF89c/XvWRvbhDy5?=
 =?us-ascii?Q?yeIGv2sFjMDpdPZ9KlIKlaSPGnD3CEf7eRhmVwD9hUKmXtZZDJxTKedOvJmd?=
 =?us-ascii?Q?GDzx96xEGw0egPNrU56fb4LZoXwxsNxGQtIRcesSc2RHn6sHSlyLjyLCZdX4?=
 =?us-ascii?Q?eIn7Axk3UG2ws1uXmBM2+06X2Yf6TXSaObiyHiAPRdgDGzWbLUAaFc5OJjXa?=
 =?us-ascii?Q?JPNZGt/sEGrmyUoA+eesvuncl3TqsNIFyhtEVINAqLO9Uaq6Umo7YpDbs83P?=
 =?us-ascii?Q?HUJFHRQWtMD4zQ6AGcoGD2CWzjiXh6a2ZripGddbTaIZNMQ92I9c231n0gpQ?=
 =?us-ascii?Q?uTbVCuDPEQY6JKgawa+5uHL/o4fOFuS4j1+/omvZOfTIP05WnrIySsOlDRwP?=
 =?us-ascii?Q?HLYJ/aXTUrEnF6WQTkLTi4OubcYbws9JvQG7e3D98+5uamNakzsYJ3oZav5q?=
 =?us-ascii?Q?BLWJeCLbIGSft2zeRAW9pqtYiYDsoFrIlmnd9/LOilHwodedp0jQNAVVhfDt?=
 =?us-ascii?Q?VwemuxAFmT/zs9qoT8IlzS2BVIa2nTqiVix59DQCL6H7MyLsU/rIlKPan5Kz?=
 =?us-ascii?Q?l3Y9J5byrzKMSO0/UOjeQd4/tG76CfSLhxo9AF3OBFi9vW1QbAzXzcGnlS8W?=
 =?us-ascii?Q?hzbh0/fB103dXfqKplY62SfXKdKcmXdVcjiC4dvkr21zqzYe3D+EaahUraXX?=
 =?us-ascii?Q?36n04I4pSBeMwyxFYWl6UzAOLTZMsOb0jLTrxltcUfCmzhhI9ZcAWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELJ7W59dq7f1TyBQg0/e0uwtFumUmwX4l7n3yzlHVdxm48HLTuaq6W1pQ8Ub?=
 =?us-ascii?Q?ce1HoO+gSCodWe7e/c+ZDOrjBN7HdxTfi8S3z3jIc5tAg/uRt6U4DXPP1Q4R?=
 =?us-ascii?Q?acKHLWdZZww8dJ4kl0tCyfdl/ycPX8LlIgEuay7sX266yuBxlpAsTwNLH7HW?=
 =?us-ascii?Q?8i6wTFXrgL7C+S18aPDsnZt2pta9QuyIvuUjM5rKPSLAUKmUq8rntdNFka3N?=
 =?us-ascii?Q?WILt/4Rpbpx7an4HF5RjQmeogNcERxXuk+Qtx9dhhs2UCUEGIatOozVJlQ2n?=
 =?us-ascii?Q?3hAtIS1qJssMVBzYEqodsDJ8DejHnt8k0qa5BrBNnQ+KZ6HnhojGS8itIAgB?=
 =?us-ascii?Q?StzaptP3llSbzQIXBQ0b8uh7Q1T4bDH3GYQWy5dIoqIGELeOPXZUa/j5Mo++?=
 =?us-ascii?Q?xQBXkRzqLWketqHsy/KQpFWxvN6o0qguLYOm8Hc9jN5HU3D/vrV9zRBehRnH?=
 =?us-ascii?Q?ocsewvz9PyqfW96nbudYHToNtqFeU1evu247euXPaLEGiGSt8g/LtdC68CgU?=
 =?us-ascii?Q?TulwpnAULvIWMbKP9AmS9w1Sz4Tinhzna0++04FnpBUaRZR+YD9MWx98+HKi?=
 =?us-ascii?Q?CzlLRZRVJaGAR4WMiwAbqFCMbG/LTYgJNBam37Xdmv42ztRA4cvj9oaoxqz7?=
 =?us-ascii?Q?o4z5NzyaXE2mBW6w0wuAuSsOr8wSALU/vU+73EOuEqmHDP9XH8Nl0Hor/rRo?=
 =?us-ascii?Q?7F3egHXPrcabaJmtKT0dAUE4VNX3nC7i64eR7R/Ydl2v6WSsqee6kJKKG7kU?=
 =?us-ascii?Q?8NtZ0yKG5CfYfPN5IEhmL6Cr2l63m4R1Gknm+LUy/PlHgFleABKKohp1m137?=
 =?us-ascii?Q?jJeic64ZRySURrgZSCXECHi99KwjC3B+tKGqvxzwSIigeBfmVeZlF/Uyb5Ds?=
 =?us-ascii?Q?pd0Cm0MUCSpTE0yXOs//rnliSxv/QKw04QJC5Vf9I/oGp75uZKhZZ5vlGRdZ?=
 =?us-ascii?Q?pLBYMYiRAe2Te52CznOzH/w8af4JBD0P1obFqDBn3eU+fi0uiwGUBdYYqV2i?=
 =?us-ascii?Q?BttpQ/Ya8dXAhhQSgY8hDCgTjm5CsdOMZoIm5pdSJ25GYdh4UJpqbvffvSAx?=
 =?us-ascii?Q?zS8IFEHNAhArze0IAjl4MKBAcdhMPpCnZ3g5g0LxGaLR1dvo7Umt3Krqe7wZ?=
 =?us-ascii?Q?TMiEukscAF5NvkpxNY+/hz5ewYBL8ytZ4rfXkZJ2rY/4dMUIGNUOJleeKUp5?=
 =?us-ascii?Q?SxSZKGs7KfmWJT1PesY4MdBpfLIDu6g0xY9FDn0xmRhLbxbjjIqsZ5Gko/9O?=
 =?us-ascii?Q?sAPjdjobFmFd80QYCmPmi3p1h2bhP1mX9ZbCutuDYt6h8zi1ItPes2IEgSz8?=
 =?us-ascii?Q?2CG5YhUeh+PgI789X1Z0j8Gst2lIilf3F771XBN7pkeL3OSzbWwxI7s0yfq1?=
 =?us-ascii?Q?hQx6wIjHXlhYzi/bLW9jUIhd1kwdaTq4BB9lq1ptWK0WBVsmXD+1RLZ0hJvU?=
 =?us-ascii?Q?g9DuZ5oNNJkDSoHZ6SU5CnfWCAdDDq+DVLdr9LGSNVst28deGgMmCnOtlL45?=
 =?us-ascii?Q?pCYMK5l3bqjWzqa8foGp5ap5SFLhpv3plehUsFtUIdCug1FvD+2FXe0hMRvN?=
 =?us-ascii?Q?c8bKR9T4qXu7G88resJAzQU1/BIxeTDuIRcIM8GW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47423269-fb3a-4ee6-b7e8-08ddb4e185a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 18:44:46.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/z42HFkxhl8vCPYEdK2XC8YWrOSRQTaZRgJ8z66uEubMb0iqaP2FKcEmqUbjnRaQjCy9I5+Ly6ehFvFIUh8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11445

On Thu, Jun 26, 2025 at 03:38:04PM +0800, Richard Zhu wrote:
> The PCI Express reference clock of i.MX9 PCIes might come from external
> clock source. Add the external reference clock mode support.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..9309959874c0 100644
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
> @@ -1651,6 +1653,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (imx_pcie->num_clks < 0)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
> +	imx_pcie->enable_ext_refclk = true;
> +	for (i = 0; i < imx_pcie->num_clks; i++)
> +		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
> +			imx_pcie->enable_ext_refclk = false;
>
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
>  		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> --
> 2.37.1
>

