Return-Path: <linux-pci+bounces-11209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738F946488
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B5A1C20FC8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28484535A3;
	Fri,  2 Aug 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UqB/Wq+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A101ABEA7;
	Fri,  2 Aug 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631491; cv=fail; b=c7FnewkfwL7fVXMXdE7UIWKqJeNatTZElxo+8FrbwuusfnMHd9V4Cxl1LLRtCDsqYqkJ2H6jktPRqdvXuBqW5n5thehJVUvBw0LbxzYfAfmHg73cLXdOooLtuP9ocQSY6jAFa7D65mFZEZyyjXWX7JUrczkoTz2Cs93q/Ux6IN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631491; c=relaxed/simple;
	bh=pdIyuJ4LKzYmbSTMQKDhzJFW/w7aE+LlX0N3kQgSAwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCQ1Qr99yTibj3YM8VOXZKRSL5JVxUgr1b1qYCRFhqJiI7alwdKajf81BjTrNLjXZEMNqVXyjmzkh/OFHyr0N2+l2F5yeH/fnJoOtuiA7oOAqW7pJxKUDZJTnt2ZaEwxZ7nKevj47cD4fvNK87lx1oX6v3gp4UoeSpXbsa9dX9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UqB/Wq+C; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY0gm2nRBpQDB9scLRuUtJgIFBIHELZFZQUbSdZEZjT7pQm2zXqzXMYWSj/bRtTDs2EssJuwSGFkq6j8G3y4Ap07okTp6rpslsV+NQuWMT2u7HLB4R240rnmzaNX+v1RpOdyKT22hU/nA49bY/9ZY8E4oDzOuNxM45jwWBGGgqeceZKmA7L094pbH1FRINhVNlOunAlb8jMDQqHnpmHN2wT8OYPGEGYffVhPb9BTLQYRi3+URu/f38cEePgx6ybAi14QRH+yhB7hw+wd4SZYKilCK7tg5XOIDlJ7x5cpaONdjV0sXQKv+zQxrUHZjtSPsOnK9wb5n7ov2OpWy+VlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN5troQt37Vp1gWSAEth6u/gfu1rvJBAfbxefSjYOu8=;
 b=LPsn3lOeZzCuKC2Yiua2B8AACmZnJFVt6OFK68zguZSbDDCY12RFhN7kdyY4mpcg1H90iCxjt/KGvVbKAfG7Qft0njyQ6mOBpbAf/2uJnf5my8SvsS1CLgvGTaYodhv+7FAbScMHgFPRltbDuUySgkqZd5az9ysykUT5ZWWLoFhuKK94ZfU/4TtbnJ2HDVyb7z0qySrH5+IyRe8M/QafHLMXZadkRyE7vfcZ4ApC538pcfe1++fQXlsJraZF3SwK4bUHET4Ujk1VHzvzfpzW9+4cSE25LGq9u23VA2lSU6atre0OCU+t25QfG1B3T2RjuhPaxLiZzqkrMT32fjlLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN5troQt37Vp1gWSAEth6u/gfu1rvJBAfbxefSjYOu8=;
 b=UqB/Wq+CmBpcCP7bczlcurlr3235QZR8usn2DBOFU1rcPpxqrwK4PmMap25sBV3DEyxntxRBuVc289WbQCkktgNLPDDFtGHScs4nIxxRbInumUj2JIRvsjCsxahTx5elGyDFWrX3PW5zNDIbHMWRyj36UJsS0Q+wi5BoOQLL+H+GPprmcEabCNosLPYHt5mLdrlEm4jBY9Xq7L/KymXIq4KRW8DzJHXPCqzZYOaEgGOc+k9eSxG5IzwUEZY272SXfqVJk5W8lvR0FwuaIfSKt4UW49baVK1sToA4X67q93/u5+J+irI1Zj3o9PqEOa7q/oCuXa3WmGs+FK4CjORqQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:44:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:44:46 +0000
Date: Fri, 2 Aug 2024 16:44:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 3/5] ata: ahci_imx: AHB clock rate setting is not
 required on i.MX8QM AHCI SATA
Message-ID: <Zq1FNeUv7r1OlTUM@lizhi-Precision-Tower-5810>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722581213-15221-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: 19779a0f-3110-4b8a-7f3b-08dcb333f1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/nzGotZanaDNTHTY1etZ9MF+0yb/1FBP5Y/SoWnExHdmSQ189OYi0zjHscLW?=
 =?us-ascii?Q?SamwjFrm66L3z+Dq+T43pRNWpHZGlSsp6s82p7oer4MAPoAXynpz4S2GrSHd?=
 =?us-ascii?Q?vpSN7LgpGu/Wzl0LX7mWromW3TFHJB/ebNMZX1/fP9M7CORTI0DPJeFWFULl?=
 =?us-ascii?Q?TSIX6NWzITc6TEJ/c2Tfvoa9GStT5BCktlGPBhLL31wvMZZDdwRNsLwzGdKz?=
 =?us-ascii?Q?7OCBYC0TEWhb4Wu+RMtg7T/gUZ9zcW4oPNTOkCZwJPJiuoSd5CTd+5P5AmNg?=
 =?us-ascii?Q?nWazy6lvadrHaFgQcW1A1nVoZEgSwcd3z99uNVDVfuSvH6GN69IEv9XCsMAX?=
 =?us-ascii?Q?ERmmkPyEGnpJ5lnuIMF6hJpJ8HkUwfo785l02ebHYKecyUFvIWApnpNOgkH1?=
 =?us-ascii?Q?Y20lDsWyQ0gVeR/jmLVKqK26UxObT3ZZpv+N432WPodGRYzrp8s7dRHRshoK?=
 =?us-ascii?Q?0r+CrtlD/x2IFTHNG++A8gGSS3GELhW3f4l+lQPQ2zRQeDazaWIyBl7W41Vj?=
 =?us-ascii?Q?8payf0PNwYIPmpnmIBF7oUmFx/vk9UbnV9EYeoRseB4fAxGcyQz4XMtiEtqZ?=
 =?us-ascii?Q?ssCXuubf5ySnPGc9Yku1KfLO1qZy07VEIvRSRhz/eLpJqirEFQyOUEGTzbce?=
 =?us-ascii?Q?0LoDQAGmggclFV2sXFVZGB6yRhowjTQi7vCFzTZXupbjNxjPUdka/cX1Pmvr?=
 =?us-ascii?Q?1n44dwsQcvTkBb/ILaXWMshGbybiRvAl5uZ4Hoge/xKq7plX1gjUPOv9LLKq?=
 =?us-ascii?Q?syaDNJy7qcq6X6hGjHPs68FwH5Phhv8hW+0rciV3MopkTmUtIS8Kj0bJ8wVa?=
 =?us-ascii?Q?EHPCoWRVFYxCSTyu9lf9GLI/U4LjIPIBeoK2hcgOSGaJPEeHB46lRJhc/8KY?=
 =?us-ascii?Q?Bf2OTz7YQNdwDLmZoVPEbMgTR4i5AZq/xFU8fXE/XDLePV54FIjNzq/S6VVv?=
 =?us-ascii?Q?woW28A2zX8UuQXoXJo811sULhmdy5DcBLib1PCAH+NU2hApU1UJirn33qF/+?=
 =?us-ascii?Q?aRxk8q0rpdt1XJ6XhObDz+CivtXOROrSHS67xoZTI3DPSikM9NXC0c8oZ8jG?=
 =?us-ascii?Q?B+q1f0XPtW3n14N5mNn8zpV0rp2rzhJK7DRfvAYNyMQ6+rITa4zjUO+tz9i8?=
 =?us-ascii?Q?tIAKSqAM6KBo9TdhxpiiO/V0JCd7y2+kMd+0Qi8wBx9gQya+GuSEYbQau0RI?=
 =?us-ascii?Q?at4vCL1k7cSWt3R0aPVPWE2AtYPThOq5EQGE2WaEbOGOXfvI3P9Fnyv3AB2z?=
 =?us-ascii?Q?JPI9+vD1T0oI16FwZLrxq6GDVTwJkbv2tGl7fVsn5xmGUYlR7yFMqiWCKxJu?=
 =?us-ascii?Q?BsUtngsGJ2jSj7rZEc8u8Qcmqwz7bWp/yTxSB7HTL38KaJsgmvP9AAHvQGqV?=
 =?us-ascii?Q?yeaq8gqV61CiBtVj1J3Q82jBj9Xmjmve6V2cm05BgsGxunNhMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWIGryAldvI16WM+X4qw8ZKOIqkYVjhj6iJ+sWuRT0oUas22hQG6PS7YKqoe?=
 =?us-ascii?Q?zPoM+Kj0tytHvvR2umKIwktRo5LjqOOOscHkgp2j6UfacECcAurNA2hJiEaz?=
 =?us-ascii?Q?kDu6PRA1Vl5HB1uJ4O5YCgEKP/+HEncwLrzqhFA8OS2mhv2qD/bGUgElaagp?=
 =?us-ascii?Q?/AzixK1y23SKjvGCraNpLSOuYR98CROPSgHApnjYRdWK1oqnjmZUH58exFVC?=
 =?us-ascii?Q?+kRekNIcnilUsI3C7oGHgc3HJS70LOtXjhft+odan3d4MOH6I32uifMEgCaP?=
 =?us-ascii?Q?6B0urb/ZPJV53Z7GHdkmcxGwqzcLeBk8weQTZyYXWBmGqQY/uXUt1RRifLU2?=
 =?us-ascii?Q?M+RFuRkAeC4hdnbhooyKe/wlYWoO4l8PcpGqDgE+03zc01xvu7GNPnLyicpI?=
 =?us-ascii?Q?nk/q9FidWFYajAlepM6Cw7bT46Fk93aCechqMaED6MXMVFFOQiU3620+lWKm?=
 =?us-ascii?Q?xiXcV19EZS11auTqofg73doM2y+GMIvm+n/Z3d2dKv4cfGnvKOSuutdW9mx1?=
 =?us-ascii?Q?MMEKSBgx6aNsrtlTb0EySMuIuTOCUMGeRamy5HXpps2ovvpYePg0JjlMT6cs?=
 =?us-ascii?Q?OuszyZ60qTYccLGM0dm4xJaMvECZc6hg82pLVoEU9Gp8xVQvEAUaWI5vgJrd?=
 =?us-ascii?Q?1tB/XyYIPhz1bvDSCBIi39bxKd3O7JfNXahJ1o3vBJWnEBZGPH2eNfux+hNB?=
 =?us-ascii?Q?uuva+sEKK2d+7WLN4hmAoSU4CoSycXz8yRrByAJqZn5R5MfC/y9x4ixzxDuV?=
 =?us-ascii?Q?98K6uXDy4L+pHmNqkTvLbqalGRUhOPRhYwKpGXNw5uUouVhd0zALmpk6BuV8?=
 =?us-ascii?Q?yp4GOOGEEWVPMjI5252GI6lhjl2mCEwnno2vFL2XZgxbVTBKsqkG9f0eZLh4?=
 =?us-ascii?Q?gX//qcmCKXXmVrYTPO37X6Z/VUAr3TOx08O3oqirxvEj9UpDbHni0+/sQ7jl?=
 =?us-ascii?Q?I3iruGU/W0cHmB6hggXlZHFjp4/+sDzxZQQMuEHTbjVepXbXYAIrJ2X7tEXA?=
 =?us-ascii?Q?x+G67DIzlyRkjmUL1lMPj0IcE8s8zcFFHHKKWUfrnWNjO4csU78+lG9ZeRR7?=
 =?us-ascii?Q?7SPrqZeL5JPCqU18TZYvKX5aAXrD9CjZXM6ZL6Md1e2xl7UcSVBKlirbNf4f?=
 =?us-ascii?Q?NNDj5VsMvz1vUw5Y2e7YdyCA8kOrnmwi8AtZvkWRnpl0K1o3TUR/erDYkipf?=
 =?us-ascii?Q?YP75PbGd1046IxTijrgAJ/+KUlCyjzNu+BQcQXoRYiPRuUUWE21/E4y8a+30?=
 =?us-ascii?Q?AGBnLSOcxq8spChIhVOBTlGRy2ZYSyeYoiB86bHqrAWvyf55jXLm9BaOEfJv?=
 =?us-ascii?Q?MkQwR6s2i95WN2uPaYwCNoNe+xbBf7fcBRkrRLEepRaJDTSX2qHzyKwozRH3?=
 =?us-ascii?Q?wIzRtusULmNAxxGLEpBJBUKp6gPQRppRqxOtCY9xixoHpDGgij0ifjNz/E66?=
 =?us-ascii?Q?FLSLWM6SC9dvKfQ1nQp8YKezxqCBU+vYZIyIHW9/02bh9aBnO9QpkTtZkB4Z?=
 =?us-ascii?Q?JI3vRo7NRmVYePhd+qbGhBgAK8HubZXj60bEr7T43Kz0WU9AXwgEr17Rb9RE?=
 =?us-ascii?Q?IAWpp4XzANkQeDoIVcHkQxgPWJfyP5eqn9M6dnk1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19779a0f-3110-4b8a-7f3b-08dcb333f1a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:44:46.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhZfJar7+NoS5HkGJj9XC5zlIuFtzZ4jJWU1t7ILVC9P8Sq6E9NbLX3lah4bxKbJag+S1/TnurnPaaZifDMKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801

On Fri, Aug 02, 2024 at 02:46:51PM +0800, Richard Zhu wrote:
> i.MX8QM AHCI SATA doesn't need AHB clock rate to set the vendor
> specified TIMER1MS register.

i.MX8QM AHCI SATA doesn't need set AHB clock rate to config the vendor
specified TIMER1MS register.

> Do the AHB clock rate setting for i.MX53 and i.MX6Q AHCI SATA only.

Set AHB clock rate only for i.MX53 and i.MX6Q.

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/ata/ahci_imx.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 75258ed42d2ee..4dd98368f8562 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -872,12 +872,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		return PTR_ERR(imxpriv->sata_ref_clk);
>  	}
>
> -	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
> -	if (IS_ERR(imxpriv->ahb_clk)) {
> -		dev_err(dev, "can't get ahb clock.\n");
> -		return PTR_ERR(imxpriv->ahb_clk);
> -	}
> -
>  	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
>  		u32 reg_value;
>
> @@ -937,11 +931,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		goto disable_clk;
>
>  	/*
> -	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
> -	 * and IP vendor specific register IMX_TIMER1MS.
> -	 * Configure CAP_SSS (support stagered spin up).
> -	 * Implement the port0.
> -	 * Get the ahb clock rate, and configure the TIMER1MS register.
> +	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL.
> +	 * Set CAP_SSS (support stagered spin up) and Implement the port0.
>  	 */
>  	reg_val = readl(hpriv->mmio + HOST_CAP);
>  	if (!(reg_val & HOST_CAP_SSS)) {
> @@ -954,8 +945,19 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
>  	}
>
> -	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
> -	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
> +	if (imxpriv->type != AHCI_IMX8QM) {
> +		/*
> +		 * Get AHB clock rate and configure the vendor specified
> +		 * TIMER1MS register on i.MX53, i.MX6Q and i.MX6QP only.
> +		 */
> +		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
> +		if (IS_ERR(imxpriv->ahb_clk)) {
> +			dev_err(dev, "Failed to get ahb clock\n");
> +			goto disable_sata;
> +		}
> +		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
> +		writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
> +	}
>
>  	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
>  				      &ahci_platform_sht);
> --
> 2.37.1
>

