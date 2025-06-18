Return-Path: <linux-pci+bounces-30092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36981ADF2D7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785AA189BDF5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72F2ED15B;
	Wed, 18 Jun 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UG8PMd8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC02EA726;
	Wed, 18 Jun 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265141; cv=fail; b=g/zlF9oLlkEgn+zIleSJM3s8L0LeJanxbrCRVAsyVvUuhdU2ifLvLMGycnBO+Gi0WOD4+JyZq/OHzqcPFYWt6W+kao8bK+tj9VsKaZjLdLaTT2Hsan/uLFYD4Q0Viqmkrwi0rxMYssPtYzioPkcbqgVNnSTombMst1xOW3iHiWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265141; c=relaxed/simple;
	bh=LjPeI3UP/+NdSMxFUGarPq4FpBFLxB6iJI98ojvpF8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9pUPGLqODaXmBNoIXdaepGFMkU+n9h221JzV1AEcjWie8W7/+IUEF99BLMoFILdcSrqmGCeDp9Umy9EMvLcGqBMnTctSYa1oEfaj6sxQIG54SunCVI55UiM2H6WjLff31BLwNf2evMVB9C94xPSJz4DeZR1cH8zsHEewTZsJ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UG8PMd8K; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5oB1xygrjz6NKK1I7BeFrrWzkOXvyPbdM7v5DJLCqJCcEGnv4L05BDzCwabTL9L3NbC2EliR5aHLur5VAsWacrUbEltAgbG43+0JiprlDDZ06QxKmrPT7/5RZplE1a14HuIj18DxcpkEqnbL8Cbtp0UNffjpP4AsHwtQz/JzFPsTktB1OJUadIink94a66yUmJFWxk+NGgTYT/ZURk+fU1+pforiEE5w/7Zc1ipoqkPjTLNPNqdRe8QOXrBDzn1KYGm02BRPDh75Y5oQtOPlhWYTagvhr2DVDdxrW8nlStbbHH2OT3GosKvrVzyzIrpvrLnNYmmVbGTkt7RKFNbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHSn/H9DrD3KLF9l+LyvfrDQmM4X2IOZzerHWU/UHsQ=;
 b=MIC/LRyD1kN5PgSnRG5mal3NdjCCa+eWuHmtlkwUwpgH3ERbPkPENuDeWjXRecqDRUsFYCX8iywT5m2iIzbCrLrzJ2pmpSnZwe98FTKGDRfZBLdar0XrzIYeggDSLiPasiUIRmHo7SP5NJG8CktMOxodegXaP7sMUmjgzr4uhz9uRMlvcAgk3Zk3oGjowX3vkCZyyqN0OGSkQBDrMVQYT6xeuVNiaNg+fFvMb2gmp1EWFV26uPdjZgJD5tecS2xQytV09m/447MnuTf00RHXSyz2AA/yPfqcVPLYXoRQ7BcEH67Gvzc8RPg9qSx1+o0dk9GegVKWA7ROpQBuvgBDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHSn/H9DrD3KLF9l+LyvfrDQmM4X2IOZzerHWU/UHsQ=;
 b=UG8PMd8KX2kjC38tEiB6X91KReowMhrETCTLew7M1yyJkk7gAdJVUTzi8DPKivfPalYjuFxTfwn294bRGA+YjhjpALiTr3cKQ6/R9FBg4jtuDeXt2sXQcovLBFLcTvnsCbrdBsLCT63Bl/I2Imj8OVEMzRdCVmeh03bX07kr0hZop+L1MaVrJf/Y88kbACbjMAS0zhpuVvXcuK3IBihByxRCRNMazeyJy/u92Vj6OR3CCAPVahZF7wTJvulfPOA29WC15Q3uZwrIHCWGK92LZ3buy1+nOUhlUXPoHHD17mKU+Et7H7/orQ/IV814XwPKslKHJTE70QCI0JPU/BvCWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 16:45:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:45:34 +0000
Date: Wed, 18 Jun 2025 12:45:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add external reference clock mode
 support
Message-ID: <aFLtJriFlGbbcjFm@lizhi-Precision-Tower-5810>
References: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
 <20250618074848.3898532-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618074848.3898532-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 62acd22c-b753-4347-9414-08ddae878bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCu7VmivBIaOKtJyp5mqRo4ipAa1jnONgmSKn0/MV+gL333N5oRVQHDSZBT8?=
 =?us-ascii?Q?3sh18lzSzVBme29xXbnRM9kvzygiUiNlvpARaA6ccohJa4LRq+5CXS9e3ELb?=
 =?us-ascii?Q?SNACAmxmRpUN6JsnbC7CoUUbo+VtBHDsv2CdROSOLXauBa7npJ6HLXC8Rq0X?=
 =?us-ascii?Q?zu7N8jwQF0w+k1Eiy0PtqRYPm3QzuPMtWwjrBICW7ept9U6PvAVAYQfxxMk8?=
 =?us-ascii?Q?SJTLMDeSlq1l/Rvh/aUBjwwMuoIU4HFXQ9jZdIPnkfhp7D+5nZ0uoq0oPC+F?=
 =?us-ascii?Q?s7ZdereAibgmiUoc8hpm/DVuM9Qw5LrQRIu55xxP3ZS6aNedwt6oaRIGwmNi?=
 =?us-ascii?Q?m3ZfNC/NkOQAIpJtcdDBb2tuPQeh/1PDV//NZpT8/UKslM/8NNSTOX44EAcA?=
 =?us-ascii?Q?xNAaVz/vr6qygsOsOElEpECDJyWSrUi4XxjFEx/LwZtClwaFR05U15+L+xsM?=
 =?us-ascii?Q?CyIUMGYLpmhkvogBCXDPqNkLTVnSnqZTwpk4PQAwwdH20VdYn+7NCFL2vHMJ?=
 =?us-ascii?Q?+cB7Whg4UO5gWjduv8PtvvSHuO3bYa+wTY+FdRqHryhCNTq9FO92NokDR/0g?=
 =?us-ascii?Q?mk1VRf4tJx7hF5kScmOfz5yq7sC0KaqMXpZud8lOIlfV4q0o0fiCT+Xs3HAQ?=
 =?us-ascii?Q?XU/D6yF+C9dIKPo3KPVADhuRTyw33jR6hUmuDwOlLa+3/pe8Q6hUrUa5pa/q?=
 =?us-ascii?Q?6DEi1M7GOuxg/eKhvdi419UG8P9WtZ4t1S+pqYjFqcVT4x1aLCuBmKmSVH4Y?=
 =?us-ascii?Q?vwiy5EabC+T1MUnmRlmakdRg4Wo0kKqSZ8Q5lEDK3vxcYVITZaRhlNdL4GYq?=
 =?us-ascii?Q?D/NM92uQjNLOAkCKQDQuXnMY8aDwzFAha49BYlrwKr7HuWIc3OLcBat5LeZR?=
 =?us-ascii?Q?FmiEVCa+xWLV735x5uhkyORqNi3Wg3v1+kHU8OLJbLOKDTyxNevuyxLE10zm?=
 =?us-ascii?Q?9kLrYtJLl/BMDNLLAej+Dt5ysGChYFCeBwVBNQgYGgf4ikfnU+IhcPYJTgh+?=
 =?us-ascii?Q?bQmYpThNVtt9l4IzrHh/dQts7+GNab67Hplf6oFS4WaBk8d/oPR5Go6Z2ide?=
 =?us-ascii?Q?6M3xA48v6Nd5mugpN8iQJFNdrB3PoAUG8okS/kbJSVueEC4w5qRyzmKSc8Mc?=
 =?us-ascii?Q?WdvDBh5mLuFas58YfnH1nmyxE41crnWcuPfv9TGk2NeTBSFSxI5PUIBtr0mY?=
 =?us-ascii?Q?JyjSkbCi0XbCEAVSFXxH12R5sySpdXIWTGYsdwGUbhX+0HDoH8FMwmpGHYto?=
 =?us-ascii?Q?mqAzbDUp1ADFSrHHuX7LJiVaAPlRe/J05dst+GiBfGEBkJQbAl7OmktuURpf?=
 =?us-ascii?Q?zZOhZGtvJxN0IwiPlaMX4OSobj4VAkCLdTOrhKSk96hWrpYVcnT2Swr4sPdK?=
 =?us-ascii?Q?3oOMNP95deZgFYUxRT3bRh3l1FJtrLv3NyIJKl8iEf4crIHPUbaC9O7ic7Wm?=
 =?us-ascii?Q?6aNcASlYIZ+CNCU8/qO9Gs8/1uzhW+PsaefrJ716p5b4aDJvPjaogg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvjEWVmoqlF8rL2/nef+MKL0kpML1Lz1nbDqL8fkIdEPuaO29uZpw/dxlA17?=
 =?us-ascii?Q?Qse9n8KDRO/92VaXMR5je0d2VMvNcdp3BYy0XCywccE2/iMkN/ZcLtRSyR/c?=
 =?us-ascii?Q?LRqfPxuVkP+iHoSmNnZuUO0kjolgbXtXBR4XYyEQLzSJC9mLcxAOElol6xVM?=
 =?us-ascii?Q?KfY2YpKphKFRo0se91khPkflVPPGlAa/kV6U+ShZp4zzjSd5FTn3a40z8vS5?=
 =?us-ascii?Q?86Xmhhe2GJ9OcSUHesBolzKDmW8ok4j9Boc7Ir0V8h3TVYGy1TFbRU8Tq9S9?=
 =?us-ascii?Q?vNLLDEs2QihacXhtg0RUlJE+osH6yfY0ROnskUbn5YjJDQsNVnEUQFJa3SBv?=
 =?us-ascii?Q?O5NiIt1RiYevMhmgKOYUC8Qss9LtkHGszHobD3i5W6LTqlstT3kJL/pw7O2A?=
 =?us-ascii?Q?X2DqSkXxWzfhbYdG0lODsH6PuqzsWqIO/vPgqcKTjCMAHYblTMdoIFQhbsfb?=
 =?us-ascii?Q?4zSeJ5ktdkYAyLj8iUIGM3i49ZVf1S2kq5QxHSI02Ajyc7Aoi6axZNEpfV5x?=
 =?us-ascii?Q?cyIMdWQrWgOujOXkdxDKIzX/u5FutAmBeY491UM6Q5CcwDgB04c6/bSZeWi8?=
 =?us-ascii?Q?r04uquRgqLrRv7bIdlXFEg+aUPjLLTNDm23sdHA/wRr3Qpo5USY9dWlq+q+R?=
 =?us-ascii?Q?GscIdom1h7qu7oGijiP08fzyj++Jt6uvbwT8E0xzH8p+Kzq7BCsyEz+z/tlI?=
 =?us-ascii?Q?oQ3u+u0ZDuDI3VLQGzU+05DYeOGy97W3K74FyCZJTETYI9BGiHS6dMP7Zmcd?=
 =?us-ascii?Q?0AbvoZQF9W2SVWoDpYkDG0nRGxIMqsi8b+Wjxj86tFvogDdK1ahdUOlA/WDE?=
 =?us-ascii?Q?yZBdupW0owWHjc5gMBAOOI3KhcUCuU33QSzv+dRkS2NP5DkwB8br7M3RnvX6?=
 =?us-ascii?Q?n2/5mKBw0glGEx8wSTP/191mhZ7CS2PmhmTa1E9VHxZaInnu8JB4XstvpCRH?=
 =?us-ascii?Q?+tlT9gWus8pvKGIn9DSidKMlU2pdKEZ4Q8o9VxZS3ks7BNlsA/yLOP6uRtkk?=
 =?us-ascii?Q?fBPfsf3rhdGVT0IRGqfAMu23ezIIePI+lms4dlGXzXSzNcGKD5nC/n4R7PZh?=
 =?us-ascii?Q?XW5+crnx4DWJQKU0WN/+btFZQz7IerwVboF7M8kUpJFGNyWsYfELMpCw/55l?=
 =?us-ascii?Q?1GANq1hsYKtvUkZXX5ExKP4sRxARLcsN9WvgEeJjerdvZi9ijLDi+RYFPTrX?=
 =?us-ascii?Q?uEaMMQIEQjP1V7os9go/7n3qX2HL/YHpwV6v1cEbNsL7kKNAxXEM0+9MXyP6?=
 =?us-ascii?Q?1jSdUaZw4ZMBy+jnLq3tStcmI8If7kBknh6p009SjTvaFbuODh5Sx75sQM7Y?=
 =?us-ascii?Q?Zc+VxGwccoOstola46m4qU8V91P8iZejE5zV5Iw488DTBnQrP1KuTbma288Y?=
 =?us-ascii?Q?pwnAqSPCk/mY4qRgS5/k9aVNUBsS7h+4SEWuFiy7iYKIQZ3wwN9yY1Nc6dnC?=
 =?us-ascii?Q?rny86DoDGWNZGGbuQnmw3bAlp6kcdIcv8/uQC9OcGSPtMrQM5lTr3pVYMxvG?=
 =?us-ascii?Q?mBP9lMqI4b4xt5s0wO2GhvKfXfVnX3OSDFigg6cCOJ0CzLAWHiW6U/rcxDpN?=
 =?us-ascii?Q?66+L3fWZ5P7q//Eq4/A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62acd22c-b753-4347-9414-08ddae878bae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:45:34.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvACA5P5No1tSfZrtwLdrJecOLRmGwKp7AWTj5q/fH39R9zP23CbETLJpqWjLDBNqxor7cFSP/71OvsFPLMCWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344

On Wed, Jun 18, 2025 at 03:48:48PM +0800, Richard Zhu wrote:
> The PCI Express reference clock of i.MX9 PCIes might come from external
> clock source. Add the external reference clock mode support.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 34 ++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..04c720377546 100644
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
> @@ -259,13 +260,24 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD, 0);
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_SS_RW_REG_0,
> -			   IMX95_PCIE_REF_CLKEN,
> -			   IMX95_PCIE_REF_CLKEN);
> +	if (imx_pcie->enable_ext_refclk) {
> +		/* External clock is used as reference clock */
> +		regmap_update_bits(imx_pcie->iomuxc_gpr,
> +				   IMX95_PCIE_PHY_GEN_CTRL,
> +				   IMX95_PCIE_REF_USE_PAD,
> +				   IMX95_PCIE_REF_USE_PAD);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr,
> +				   IMX95_PCIE_SS_RW_REG_0,
> +				   IMX95_PCIE_REF_CLKEN, 0);
> +	} else {
> +		regmap_update_bits(imx_pcie->iomuxc_gpr,
> +				   IMX95_PCIE_PHY_GEN_CTRL,
> +				   IMX95_PCIE_REF_USE_PAD, 0);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr,
> +				   IMX95_PCIE_SS_RW_REG_0,
> +				   IMX95_PCIE_REF_CLKEN,
> +				   IMX95_PCIE_REF_CLKEN);

bool ext = imx_pcie->enable_ext_refclk;

regmap_update_bits(....
                   ext ? IMX95_PCIE_REF_USE_PAD: 0);

regmap_update_bits(...
		   ext ? 0: IMX95_PCIE_REF_CLKEN);

Frank

> +	}
>
>  	return 0;
>  }
> @@ -1600,7 +1612,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct imx_pcie *imx_pcie;
>  	struct device_node *np;
>  	struct device_node *node = dev->of_node;
> -	int ret, domain;
> +	int i, ret, domain;
>  	u16 val;
>
>  	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
> @@ -1651,6 +1663,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (imx_pcie->num_clks < 0)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
> +	for (i = 0; i < imx_pcie->num_clks; i++) {
> +		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
> +			imx_pcie->enable_ext_refclk = false;
> +		else
> +			imx_pcie->enable_ext_refclk = true;
> +	}
>
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
>  		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> --
> 2.37.1
>

