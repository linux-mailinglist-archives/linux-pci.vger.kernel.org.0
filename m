Return-Path: <linux-pci+bounces-24562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA5A6E301
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D6017249E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5902266F17;
	Mon, 24 Mar 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cU3by8aA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5289171C9;
	Mon, 24 Mar 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842871; cv=fail; b=K07d5Za66aSJQMglo8qZa5IaNtLv7XKkkRHcLlxoryUlw2KLnceMfFIqT/dWb2DH7v5NCOmK5YaqHdksTuaVg34Oaz/oRLgdCN3HC0biNq3aYzutsu/XbleEne9jboft6TxdMz3AJoQyX/8Z1EwmQyMXtTQDRGFqz0bmA7iCkAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842871; c=relaxed/simple;
	bh=5RZ+lhXZMmlRUnqx+GOl4TCV/lrMohCoav13lf+IRdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oLR5hbtQ6//fe4+NJ2Q3uIhzB2f8KdGDoT2A96TyQzYkS3qW0IU9bI6c1BliWtu7S5QwWeCqgNB27mgfBdV0cz+GAJaNE1uihuAGaxWkviKUJ7AudfxYX8+vZQOmkgiWAJX4OMpIDzMQ/vHkV9yjoiYMViT2ckjImVfx6JZnee0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cU3by8aA; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoNUUp+aarE7LdnUyPdCyubYpiJES/qzpEVUdNT55wT+xBjrjIufmRAri+8qeTLfr7lgUtru7MuUUVziliLe5HWM0Nmclk/PJGTfOC9n3gPpYjrzpboLD9rahNC8sAKEZkFbsA0o61g05Azl1aU8DGEhlyKKpgOQXHDj+MYxyjFre6lbwfTVTMvWf4XOdkKk5bBAA4KZl8m74iO42c8XZZ3nFgaYSyWHjJr5aPAarFv5Z+5QzjsBERpyRHEasuH6ORzklP1/ZkSRmGhXMJR4n2x1R/oIuN0OGf84DdWjIzc0It+N/8dVCjzcapNqLSh/t6GNM44iNlNtYEs60jo+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8k9dIw6po+UE+bm1w4luATbvjym1FQEu0PVRNiWHqg=;
 b=J1FVFAb+E8ISVNIwZBroQ84V6p3Jh3GlA5Tp5T5acIL8ogJKzC4rD7yLy+CU/p9YgZENDZNVzpSMXF/O4VW5gsXSIeMOnG6Pgf5ctKjaDCIfx54/vjB6SHOfGcvE+cydqmxBRsPEKoAj1n1ZYl0+y7qdY/bHiYAGhQdcWFNTJOsvJ00qYkoy12vjvQSlmsOF0JA5K3m7v4G7w2My4ksz5Z30y3Al4P+crXFHD34N7q0z5/y+OPD6QO12lBsybn/qtDdN6MCByM9gl2InZBWaDIrslsxySqI1ebK6U+lp8akcyNYbRil1uhu3dJEWYLA0KQKO+MzoqaZ0aaJXmZdP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8k9dIw6po+UE+bm1w4luATbvjym1FQEu0PVRNiWHqg=;
 b=cU3by8aAg2kzRC/3S1fn8ihfvXRevbER0gLyZY8OjMDToTE9iVsAYg8HT4EALFxvsOO9T2kvFrqqLe9/IkvXPu35ZnHASdiHI56wt4Rx9FTb/WEUUAn17nNsqnINc7nQmIqwDDasUbmpvgS4bVBvswt7E5z6mjvAQwJkSuzPs6u79xYPzaDUChNRrjaA1K3pvCtMyR7ziB067lU2IcYOUmnT/kBFnnblNY0/iAgpDlQKbcerHQV1dQt3ZLJ4nNEcWKAt4yQbgYcoEXIYMo2mcgs1SJXdvX35sofUpYHpRXa+cGaB+RT7QYT7njwJfdEnD/pp35n0S2e5eZwGGUzO+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:01:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:01:06 +0000
Date: Mon, 24 Mar 2025 15:00:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <Z+Gr6gXQWu+E+LQo@lizhi-Precision-Tower-5810>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324062647.1891896-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH1PEPF000132F2.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 906b51c7-79d3-403c-c76b-08dd6b063b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVMyhlxAs4D8kAYJOaUFkDnFh+dewWMS1ken2RLDngSdd7qHu/6TYDvCUgjG?=
 =?us-ascii?Q?GQxiYrdHnnzaI7oTBSnHxBzpZnZ8f3ld++MWa21UpNJvn0q38NuvNzpiPwL9?=
 =?us-ascii?Q?uY5wlexdZFE4ZPFpIJDq0dyZ6LYo3ISVajCJu1LRHIl7s/wbboRmvtVtgVxL?=
 =?us-ascii?Q?ByWem6EzVZDS7wQwYV/CwyFhMrDleyd8I81oPYYt9X49KkLfo9FoXTjCxHUo?=
 =?us-ascii?Q?3Vx1r4My3bcJLprR2x3EYrDDu75Rx+fRthZA78pyDqUDTD4cTBlQEfC3kptx?=
 =?us-ascii?Q?Ox8jxCRKT5/ZDDA52Cia4qcKjFIafbGMKWwhPuFAqDErTMRZBYIsmKWjT80X?=
 =?us-ascii?Q?dU+GN0ZcsOa4hXE/UswrqiFfLBhAZeklt/ptoVBTt/sDlUm+byJZFW1NvE8V?=
 =?us-ascii?Q?hmG36LDdn0dGd5dgZUoh5sA9h1Dj1vwGVxMnMqyrtXVwrGHQkViaqNimRd/O?=
 =?us-ascii?Q?BQf/BSxUSXcOjR/IMxbfsh6UhvKxM49bSpw2wAhdEVRQHiCfOn9I/jkIm3m6?=
 =?us-ascii?Q?B+pTNZpVaXkJPMtKiXHV3399FE5w9qlf7kY+0Oq/FtsU56hLscdHwjzq2F62?=
 =?us-ascii?Q?MvaCOUFbaWjK16Hz99IyK0CGTKmLxfh0GyhVAw6Adjem/JG0nLR9QaaH2DzK?=
 =?us-ascii?Q?P5+f3LLsDLMhR6A2opSEc/35HR0YCW5uOLN++zYmLThngLWaBrFlqix3XMJf?=
 =?us-ascii?Q?5i6W4ypI7jti5LlpeoymMLDjVJHiCOwHR/bn8PMeuSTg5vS6gE9Nj0HDaEmT?=
 =?us-ascii?Q?J2lfBz9Km9IgEvnDdylmUb+eRVZFF9A18utlDY9iPxdFCxP++0SCKlQZv0Dd?=
 =?us-ascii?Q?rKd8RTVclLw9HuFIJS/ZC7WQrbelLJnBGL9WHWAg40ugVFnhgMTwN5zytTdJ?=
 =?us-ascii?Q?ItvusArD1FK1GXx/kSlqKKn/anVxmi+nLKylplgdV86ZuAUzMPDGOVHrc86N?=
 =?us-ascii?Q?7B1ymw5Td1t5ovg8tDtzKgc5WNTaHEqMXbbHkAhMjcOIuogOSvLuBJ9nNEj3?=
 =?us-ascii?Q?DD4x0c4KVSkgWJ7MpATlXocT4tRB7LakNdTlLQSAmC5jygp7p8iIR29KnvDI?=
 =?us-ascii?Q?R1bAYcQOOimyJ+q/laa3QKAc5nId0QW9lMX4Gn5NS8B79uP1vgmpNLTP/+dt?=
 =?us-ascii?Q?BbGG0fJbazFpOHtnlc3PVd0MS8IjoO3Q1I65kHsYFLSTe/PryZ3pO5XOKFVG?=
 =?us-ascii?Q?Lem0aYfV4mtlAOCUBfcwvlfuo6n2HZc4qrzigtjuW3o73l1TSqXaYGeBTz+c?=
 =?us-ascii?Q?AwwNZGupHDfFC74K7gCMllJEOB1BCTJ8gjkAw5CiNK8xgi8eFAmn/Fa3UMh9?=
 =?us-ascii?Q?FzSPsNlRavwOjnDI/3EBC1mJc4jeYqa2naQfCpPBMl5zQkQURTrjCRJMgQHW?=
 =?us-ascii?Q?gUQLjhaypYP5repVbowDlfLaJCVjtfjvn9vEFAb1RedofXwZ+fo2liXNXrFp?=
 =?us-ascii?Q?j7coVHywM+WtKypBBhWsf1oAkGQpbrpd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8VdxeDXn4iGOb6X8Fr4YIC9Z0xl9MMMRdUGS616F38Nex8CeTrEQ22SPkBg?=
 =?us-ascii?Q?zCljUk0RPnTFq2nq0F1eF5u+qVbd+fR4D5vCAzof/zAdhzcHArU0BrBspBPC?=
 =?us-ascii?Q?FzwfpoM7GMyyCqXuXAKB/jNafu7fhHbTmyQ4jGKo90Ikuz0/vNx72vep5MGx?=
 =?us-ascii?Q?sSPIP6NKK6yb+O4XssFu7/mylEDqSg+t5yT4Hi4jltXWX30T3kCteBbdxEGu?=
 =?us-ascii?Q?CyVT4EpWn8EzcD2vOIEVFJOnCdj/mocIu8188ofIDikyiQzWkac23TfMueKe?=
 =?us-ascii?Q?XzvqQ38kMgdVAkts1gzt8NnLRXDI7WPQIVnnLpEbhRC/Vn+je+eegcMuiMjY?=
 =?us-ascii?Q?IrL6cvnTfgSFPwNzcwCJcLwB5KYy9oP/sfg6S6tokVKFruwtma5UMjjK2ENx?=
 =?us-ascii?Q?F/ZQOgI0Uqb+3dwb6PoEUg7cNCkqQ2tZDSwuOt4bxWy8l91pGOqnIuHkBqYG?=
 =?us-ascii?Q?dnhsAQ8wlZupIW9+J4l9dxedl/tOmouluUrWjZHiZk4zF+Cjcfkl8Ntuq8dc?=
 =?us-ascii?Q?DPakvkCiRf1jnS6FsdDkuhKnRFCIXoUEQq/ZuIWsXlxL4wIBx4mGMTtr5wKY?=
 =?us-ascii?Q?NMj5lTgJc5tHqhMqvlcscdDv1YKg+TSsjZw/Nf8zgxzWEERPQWMEtodu9oAy?=
 =?us-ascii?Q?tVhnCqmCHHzSpMd90D5RVPmgFQwr5Lm7PAxqqLSGdbGPjtdkZz9N8PeTsl41?=
 =?us-ascii?Q?8huzDbkwUdKth09UP82c6eH/rWvhPE6S+QukyRz9DSUK45JVDJHNXr7GIHdH?=
 =?us-ascii?Q?8u/NvF8/dLSbRosVOAhfK4G0eEvAvZ9NDmnnQXAcAxj54V3VjioeIPSn8q7/?=
 =?us-ascii?Q?R3fdGsb05conLlpqdTkYEaqPxlar01uZnbppCsG2y6UImt0ZKVNjXN3qC6cA?=
 =?us-ascii?Q?l66t7enXiHteGRT4yLS5q+zDBPyQTFJ3s8DENidRTc2tFXMIUEBGDgi1fnJP?=
 =?us-ascii?Q?qnThoFO9D8J6YIgpf7jfBgDjSyWnA8dvOPv520dwD46cu8pFY+8w9ALWYBp7?=
 =?us-ascii?Q?kzZoKhY4C+dA+8/WDquFbPxZvuJI0VqKhZ5QWmaEGj5R4L/5ZXZL4rv7/59F?=
 =?us-ascii?Q?Y1k7HyuuUvnKJxv2Zt924QeYr+E9PGJWqLQcS+QWTPxislmHUgk7X1rERvRE?=
 =?us-ascii?Q?4BY+m2Sunv+zXk8NV+K199bz0znSc0rn8duXgUTPy+HhofHEcyuQ/vAvG/+b?=
 =?us-ascii?Q?Nl4pnZVV4hRa4eK7Rj5IH1upDpjY3MZBBJYbLie5bnjAzuS/W/us/SUszhVd?=
 =?us-ascii?Q?S3y6oahWnwbzOgWdWgwvgsvd6pL8G739hVNW7c3f/Z1xd7UeDwFDYit4FUxi?=
 =?us-ascii?Q?RxlGg2VBrCJ93BpBWHvrTN6SqKzYsh37og9onPqMGE8REmNLc1Gwlvpwwq5B?=
 =?us-ascii?Q?oUwLXguGKF7fNCi7zi4+OAa7aV0hl3DhneQv1LzIH3VX4lDk0mj8re55vdGF?=
 =?us-ascii?Q?NVVHPo0oX1yuZTlF4Pusvbcv+H01UEAXJrSpKj0loLXpgCDBJ5Dwgy5rMl9d?=
 =?us-ascii?Q?0peA4EnW/csGxBHVo5/dfIwNyFg82/W8jt/D75xqP7TGyBeJesiMKLGWbl+c?=
 =?us-ascii?Q?j0oiZ8bFJ80dG6BKhlRIfAywJh+CsySmjsAbTXHV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906b51c7-79d3-403c-c76b-08dd6b063b18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:01:06.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o2HNp7E4JtWAaIiM0Aaq4sKUVrIhxFq/s+TLRKRH8N4yiZVzezqZ5QEwCdHHh4QcPM+g1IkT/nOeZybay/mgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363

On Mon, Mar 24, 2025 at 02:26:44PM +0800, Richard Zhu wrote:
> Beside the power-on reset, add the cold reset toggle for i.MX95 PCIe.

Add the code reset toggle for i.MX95 PCIe to align PHY's power on sequency.

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index aa5c3f235995..0f42ab63f5ad 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>
>  enum imx_pcie_variants {
> @@ -773,6 +776,32 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				   IMX95_PCIE_COLD_RST, IMX95_PCIE_COLD_RST);

regmap_set_bits()

> +		udelay(15);

udelay may not use MMIO. It cause delay time less than 15us. Need read one
register before udelay(15);

> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				   IMX95_PCIE_COLD_RST, 0);

regmap_clr_bits();

Frank

> +		udelay(10);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> @@ -1762,6 +1791,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  	},
>  	[IMX8MQ_EP] = {
> @@ -1815,6 +1845,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.init_phy = imx95_pcie_init_phy,
> +		.core_reset = imx95_pcie_core_reset,
>  		.epc_features = &imx95_pcie_epc_features,
>  		.mode = DW_PCIE_EP_TYPE,
>  	},
> --
> 2.37.1
>

