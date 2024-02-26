Return-Path: <linux-pci+bounces-4028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6E867C01
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0814D1C24CF3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610B53E3B;
	Mon, 26 Feb 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IPFypEV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABE819;
	Mon, 26 Feb 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965029; cv=fail; b=qw+EnKyDXvZhEeAjmFOH2goqBWpd59KSYp8lc5+I3AgbJuxXudkVwVSlRU4G6wYbvJfxtg5bSYcIhXRLIGbH7JGm6fMAZW8A2LIlBmyzI9UmKUDaEF3ZFqQ8ilTEni2o3kNAuM8OA4Ep2X4KGbSzOJbZjDV9rIdeX/LIkXjqs2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965029; c=relaxed/simple;
	bh=KHtdWTX86L1aVtjJ6hFfwQ0MiaEkSZdphGRFRSkgJoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qi4wIXytKb0R3d6E9Ur6vqDhmGVzrAqAtoS+sRv28DYNRwEYQTCJLGWfTcB9J+fJBQ4rz7muSYciuF+LqDr1aPUIYeCrtvda/CuaXsr+RqfmgQq3vLgLQtnvrmlbWEED1z1vs1SjmjPYD2LuiBDkiQiv5TrNVRIJjCvUh4g4LuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IPFypEV8; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldUdruHL6OE3Zy3nqBQopc2IGCcsliwQqMCkKefDtOQvT8crycgWYnQ7dfvqQKb0e/isZAaXEzgEKdl7c+fA0YMX3jT0nP/rx8VsK9PT3Vr9GoiReE+jwPpz/4kNuMjx6yK//tw8dZ58pTVFvM+3U+ANBA0LyESV+tpuSmKjOTSu+4yQ0VYBLVsuXTWzQRsrVub2J9+p1Z2PsNJgxtDhxbD70rUE1Kr1fxUUOK3CLDqBXBmPrAYZ3b+LCtLGoj4pnQeWRp5aTT2zJnzpoMVggA4CUP+me6+XQ53sIRAewthIMAz/Kgpr1PdkWsIsqmmc5zlKuS/2YNXJ+0N+4Qgx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLPVBVM0ZqSsxV6Q+cAeBbV36ajULFmjHpOllaWnbJ8=;
 b=fRG/iG0i4aQQRRaY96pGf5FU8bpZsc6KP6ATFb8kaszaamo+uZ9HwgspMofaakO92tDJaFEyEWVLsWycA9n+PlHBVG6lAAgoNW/8eTKuiw0sUF2Vq3Y8IzmWdOvZoURe7YVa/4s0Ay6jPOFFgsqAO2roRk0J60mPt7dL10fbhMAAhZcTZViz92Dn0t8UUEjyp8jMhmKpugIcaabvgVhuPXKgMSCYm1/X7dY5qAS6dhfg1/bDEnRqavH+88YVvxVCmTUZKx4GdAFHb9tfTtpJZjSPhU5BJoy36LU93y9Nuwn7VJ+XyP4zlG/fNJG6rP5Q6PV1v9Ml+jeVuwLYlBmbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLPVBVM0ZqSsxV6Q+cAeBbV36ajULFmjHpOllaWnbJ8=;
 b=IPFypEV8p/MtlcVIpcEJW5I5wDAL/5r4PDwfELujZGXs8DETdqx+b5KB+8VEjfflBDty/uTKLNSuDEmePN0VIKSPgXRFM4ECU9ZP4p2H3wvV3S5EwzBqikrQua7hyVfsCJ0TaH9FgBRbkrTJbHzv9K0ZwhLab60z9YXoW7zphow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6831.eurprd04.prod.outlook.com (2603:10a6:803:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 16:30:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:30:23 +0000
Date: Mon, 26 Feb 2024 11:30:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a35a0e-550f-41ce-6889-08dc36e83b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCiTzO8eY11qmPIpycjbpyeUu8v5g4D7qyFegqjadKp5ldpdoQAEtSA2if6z0AE01QzidB57tZRFqCFgjZG8OAYWKoXb+Sj1JyB+4S6Zfy9a66KQH1OmMg/Vr79BqTbAtUv2rJ9SYmsX/4Srla8G4ucI6FF08pv3C7wwQJBF2yzC9XLPkYmHbv2ku7we3C9eRyaffWtgfn0lnVM99bFhRhDyY61G6Heuy/QvrsuQOderMTMA7eomMbxS2oTvs8RPkTv9AVAJU3DNlUSZvgSd4+ysFyxW1BY259MdER1O6xgioXVYYiUOL/18fr54d0s4YlJ+d2IMGBtTBeF9sMYm3hMddjzOg7zyCtAQepwKrY3wJRGg5J579m6MoxdyePhsxuvL5cIEL/eEEEcPmVFpjQYLOOzK6snHtlm4caS4RTCAvb1npZnmNAsKqO+8H9SuFPxYdvgWzGUbLBBvo01J3kdYll9ZMpMkJM6txUbjy6U8IktvILokmtajToFYjQJwxQxjnSh1PoIqaeLdt8lXVNGQ9ZiFhVS82Q1QlXTw6JFIhPeybMOUwhRLaBxsbH5DVGFTDai1FYg2uDZBL6OzKBYunKG14XwDyCmXYSk1GzwskHpskunZMPFeZrJ++4lsHwtih3OILUza+dS9q4A/egYzuwZv5OkJsZj1SN/P+MqNwRCwm+faFtocCxh4VFv7gMN+jJ7THhfjmnU0ks7JV6ikcalrWUJpwWntuNvjzDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLOMenApXHLfyQyFsgR6E/tL0D18L4iqWlDkVqmBdcBcYjzO78OCwGzZQhNd?=
 =?us-ascii?Q?7F5D27TrfjD6vzaj6InKnv5dM/5DUf1MX9aO/c3QjRnmyV1n9OO7xMHsIbHu?=
 =?us-ascii?Q?dlyJcMQajlpVG6J88fZfqqmBjGg393cYxweg19z2Po59BO5cO9WOfcM4VBJO?=
 =?us-ascii?Q?G852AS+DfEzF1NX6AOv1bJ1XqTbNEG/drcTsDEr6vawFbLJRVjJv3oyMjzBj?=
 =?us-ascii?Q?u+8uGcuFIIC8XEfpmXhQfV2Mt2ITPSnylj2IHyf2jlc2iw0uFk1PnKHR9A4x?=
 =?us-ascii?Q?aWKST5ToxFuc4STZaWhQjwFgNPKQyGfsQthoO6DbEmw5VKFJj1y2BABudvO1?=
 =?us-ascii?Q?9ksbWJ5LlT4E2CJUAKy4v9u8ZHzW1CxPAIXyEusFWxX53v1J4t57++RuXSMT?=
 =?us-ascii?Q?BzbAM2KRWtXotYN7sNGP4ig+Qjf8BMxrGhOAEq8jqIbGGyI7Hf/Hlc5S35CI?=
 =?us-ascii?Q?koVTW6wApSfyCNxxtcr3jhFBADHL68aYesPuOkWh7xx7zQaa07LV/1xrRyoV?=
 =?us-ascii?Q?p2Yp1fApcULyG6FzuuoqUGFbH/Vi6CxbldRXzVjQ6Halru2gwBoMlX/XKKOv?=
 =?us-ascii?Q?rIfCGaZBYDUd2aEsbScjS6U7k7bAZs5zZqXWJdwJ90KXYv6sqh1pAxJEgRTX?=
 =?us-ascii?Q?MVxzlNmE72LhFrC6KTSoKrdaQdbUvipgjuDPRP9Ux6380fP+Hr0x+8L1EgQ6?=
 =?us-ascii?Q?2xI0CzJewVwPv8t6LVibcCqIXz9azN/rzAigd7e8ajdhEOp78nLDsHOGsvBW?=
 =?us-ascii?Q?0nYfKGZtv/koZjfCCcYr8LgzHzpPmn7WRwntkjFV9Nq1MA2VUpthPAehaC4X?=
 =?us-ascii?Q?WG3GfmXqEzRq1TC/HS1hTXUD+BcHm/Pw4HGp9tAwg5NLlfrUEDVecEanclOz?=
 =?us-ascii?Q?PEAn79rEePaU/v3dTKBxI8hBPAXs5psbiERWEP+ntwy0auaHUVsXIFY+I/W6?=
 =?us-ascii?Q?8l5LrdQDmZQjSdx8KOVdGI/oF5Sb2ypvUycw6ziQoybRj0GpPGUMq5ZlqHR+?=
 =?us-ascii?Q?kqc2TFobup8x7LRi7JvaN0waulVB3w+QPc6DFOuCNNPv7Fy8KwNs6CFi3COz?=
 =?us-ascii?Q?WSfY14krBmvYGomwhs0BZggb7XYbLpmBqiAYIhNj7Fy8FIopfQSU3N40DPb0?=
 =?us-ascii?Q?j0qp70NqI91rR6LWOsfvqqzeSqi0MzK5wvegz7Gsc/1jwC5/qt9BGO0bo802?=
 =?us-ascii?Q?yqjRhdiGoZVOULyoeK6IHRrqwanuMdx/vmF+j9iTJGD2tR6ksCpoR1e2CnD2?=
 =?us-ascii?Q?+LzAoneJxOqPRNy4ErIzNqXPZdQoGLcxdQy+9gD0ta0ve+uPO84xr9a2NjQ/?=
 =?us-ascii?Q?BeI0YXXs645XdIv8sok2PsP5vPCLgKMVyhrULPpxDQk8Mj5dho6ANWdYpbvB?=
 =?us-ascii?Q?8XIJ5OHqmNrz719onnuLJ+rLfoqKntC+rjAwzuOftEdcIvSZGlEwXo/2F2f7?=
 =?us-ascii?Q?UUXiRMuifztyokuVVNAcW9qrCI1qNPZXYPZ+lhhkToA0rb/VfTt5WrWL9I0M?=
 =?us-ascii?Q?Olj9bC9RidIMBz1wVCvWtpsXbplVDQ2uTiQ1eLSIuCv4MkqT48CILEoAKIal?=
 =?us-ascii?Q?2sDNbLU8tftOngaOs5g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a35a0e-550f-41ce-6889-08dc36e83b04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:30:23.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLYcgFdI+hCJaR02TEWXqwHaxHg7bCHZ5FWsXIEMb25WFX3VJDvxyFEujfJKXK3897NW3YUZo3TIdIV2/LAvGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6831

On Mon, Feb 26, 2024 at 05:07:28PM +0530, Manivannan Sadhasivam wrote:
> Instead of maintaining a separate capability for glue drivers that cannot
> support auto detection of the eDMA mapping format, let's pass the mapping
> format directly from them.

Sorry, what's mapping? is it register address layout?

Frank

> 
> This will simplify the code and also allow adding HDMA support that also
> doesn't support auto detection of mapping format.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ce273c3c5421..3e90b9947a13 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> +	/*
> +	 * Bail out finding the mapping format if it is already set by the glue
> +	 * driver. Also ensure that the edma.reg_base is pointing to a valid
> +	 * memory region.
> +	 */
> +	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
> +		return pci->edma.reg_base ? 0 : -ENODEV;
> +
>  	/*
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> -	 *
> -	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> -	 * have zeros in the eDMA CTRL register even though the HW-manual
> -	 * explicitly states there must FFs if the unrolled mapping is enabled.
> -	 * For such cases the low-level drivers are supposed to manually
> -	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> +	if (dw_pcie_ver_is_ge(pci, 540A))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..995805279021 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -51,9 +51,8 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_EDMA_UNROLL		1
> -#define DW_PCIE_CAP_IATU_UNROLL		2
> -#define DW_PCIE_CAP_CDM_CHECK		3
> +#define DW_PCIE_CAP_IATU_UNROLL		1
> +#define DW_PCIE_CAP_CDM_CHECK		2
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index e9166619b1f9..3c535ef5ea91 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>  	rcar->dw.ops = &dw_pcie_ops;
>  	rcar->dw.dev = dev;
>  	rcar->pdev = pdev;
> -	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> +	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
>  	dw_pcie_cap_set(&rcar->dw, REQ_RES);
>  	platform_set_drvdata(pdev, rcar);
>  
> 
> -- 
> 2.25.1
> 

