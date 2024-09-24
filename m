Return-Path: <linux-pci+bounces-13450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D49848BB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D699E1F22749
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CBC1A7AE4;
	Tue, 24 Sep 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWCqPYDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BD1E4AD;
	Tue, 24 Sep 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191894; cv=fail; b=aTjQ1EdQK8fEc5tlLYWcMBHuvuNgjevK5SP9taCdSi94xBwoim69pFPhncCTbn5v3UCnixqR/UcY5dJ7FackecLtjp1MzgcxXV4828a22SdnOuS5bE6os5kc5X823MlbRPREmkfzy6+94HF8hsRATP13oq6oxjU6Pbe2Qy6xl2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191894; c=relaxed/simple;
	bh=542gAlcZJM931X2j7L5yvEcGx1c+0hnp+F3AmK7Zq+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qp3tTjQFIhmYeqYNIqXZzKzEQ0A5HhPiK0+Fu2w03FFoFQv+TaGWO7+uysF5QPatILrN+1eutJIe4PPoBPVktCngvR1T9KikPO8zTRQMnSY0lhacjNgCFOXl3B9QFngg+LCwM2z5FJ6KMxRrJw1R3IX2mAFjsMJarbMHoLaZ38Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nWCqPYDV; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBNw5XEkSSibDQvKwCMgC4g01bppBBmP3c+Izsq3sC7c7uZbECoVKIPMllQV+t/RU2tyMPIWOh3eNcpONA8CuJ948pr+8bSjZTDUSeqWh5HL5va+FmZWkKltQ7tBYJps8qd6KfULA/mivVk5a1VL0BZRzmsQmFsFR3sCN3Tsdm008xya0tzY1NdiTXL2BBF1C/CpjdQoSzUPlHscA8PGGtEIzDivy23xhG3byYr0X5VUlhDzjDRFTBDz0nmkQL8OPlDeZt9lXPage25nZQV/fTuDTlV3X6XOeciy8K39WYhUKVwVcvMwsmjubAyoAdnbyCBzeBfyoF8mSxcHqzhShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz4dyhieRhC+bn6TrQZvpfvSYq5k4yCkI8GppKGA4H4=;
 b=nUgPZt9gTIm/Sit/dnoS5GAunQYuCY9MSMG9IFrAH2dWUcGbRhoFNARLHR9H7tRcO4IxUF6FYkZlYj6UkmdGgWT+C5ALlNolMZuN4uBpA7JimpLNSUP2PTEU2X3Nq6bX88M8wSLPm9tDTa+4hpdUmQgkLMGMPJfpMaE8nxyeVNm2lbapeHQCmQ8NbRxM89neB0pHPmZd/icUj5tjpBH04tc3Wx/p+QZbYgKer9yft5ywUi9P5Lo3dE+2FeZHZYtxiiWRrEp8yjZwaLE4q2ec9p/JqwH9SdvoeOLoElR69qwjFBPbs9Ocw9m1vpRoGY3B7Y9cTfAZ3JL45Hu8iZU1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz4dyhieRhC+bn6TrQZvpfvSYq5k4yCkI8GppKGA4H4=;
 b=nWCqPYDV4AlX52XDzAsiMakX2/PZF38BNue2UbHIeNN0eEMpd1w80RjIPE52TUaO7wkujno4ovBMZ1FRQPWoGAtb1dcfPOGez7hFruIybQyhhnF4RSQEzm8WB3DGu3AnGg29WZAhSNG0vJzGIFlA5beSeJp459oQbs2ynqRWLctbXXE0PyCBOKI7FZ6bBPoRQThLbhFgn7EvytCO3c67RKtNt/TKQGGrkwtfln3bZcWvJZDNAs0vNdihncYK0JWTkn72HEPI/ff/Px0e38W0vZAGmmCHYG38vk1pH1/Cz+EIfWPxkcKajAqFrWYmezO1Bho+3153JnpGhQ01yUyvLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 15:31:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:31:29 +0000
Date: Tue, 24 Sep 2024 11:31:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 4/9] PCI: imx6: Correct controller_id generation logic
 for i.MX7D
Message-ID: <ZvLbSHPZvVFXcT+t@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-5-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: b006c365-8db0-4244-0347-08dcdcadf624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DI58xYDrx7LCUoSVhBw+ZQZlDq3cKDZWL/3pyzvwP1C0ZQvyUyMz1o5a83ve?=
 =?us-ascii?Q?RSOOkdfzbbfK1FzBqx+Bl5bDtb1qRHvZDaB8LWnoRAY6jpFEB0jr9th4n0BC?=
 =?us-ascii?Q?LF0j5jAEWfpmTiye3s+M/69S9MT62v9yqOQKJ1V8A5oWcQTUUNko6khtDrPp?=
 =?us-ascii?Q?X09dU1A9mWfMQoip+eJWqyNwbTgZ2X7NdYjxp026UWcMub8ePo/aT018tbGT?=
 =?us-ascii?Q?YKg0+XhL3xVWtF3Dc7d6a4tVz3FWPuMNRCKHSYj4aP4jfYNOTyYYQxyku1bG?=
 =?us-ascii?Q?8/0DdUVmt3weI8kyNW5jRpgusqWcYJLiv5hYjKmj39aoDUzmlaDrQhMaMJU/?=
 =?us-ascii?Q?WPF7CWnRQFVRNzMNk56tkOf5QL9q48dzxUyeaCWfWOQzjHKPt+cHlIJdYig/?=
 =?us-ascii?Q?i0bxQsNCdTNh5gPubTiYkARyZIQkCPhy/M6+651xFy1fiAibxdadW2P3NdRH?=
 =?us-ascii?Q?zzBX6ntTK6LVXWvq5szz/CY9hbDTQ8iBv+sCkVj/q7rSxLmVq1V42XYFyLZr?=
 =?us-ascii?Q?26wrZXq80v4V/JvQpToBxAyBeNY7hBBEy8ZHqSRPgCERqU22pf1hGtWp2LdV?=
 =?us-ascii?Q?1lbUMQ9AWLBUpuaWwD/G6lO4/VSM1dq9O7ftz6YBedYV764p5RbcMIEep1nS?=
 =?us-ascii?Q?uILv5NK19K1qTyryUr9JtV+VB+RarIRIsoBCsexhlUXA4ashO989IyQkj4RH?=
 =?us-ascii?Q?oUS84Dx+cpCjSz3mVS3UB726KONVVBJ3q/jrSwXhnd/wDGZ5t3d4b5uiVvdX?=
 =?us-ascii?Q?qFxJW6NxDZnCoxFuru3Z/DvrbqWGtM2RK5o4WSybpaKa09h2cdjAGzhR79sn?=
 =?us-ascii?Q?qy34i767sND4jEOurS4woWFaHFumKfFrgFIBU/H1N6zJ5LjW7R07t/nAbiBA?=
 =?us-ascii?Q?ZE78ZTUPDza/A6YuiGAPbGPQCMfWejvf5cmUOHKYDQqCQMf2xBbJ93nDh3SH?=
 =?us-ascii?Q?rPAp/TRvxH4Y7fCZ1VCHqobt1tfrIlKCTbdjQ/c8JNLp/8E/x2MW1WbIxaBJ?=
 =?us-ascii?Q?zWZV+vzjo2MsuQaqLBgVgXy3DELm9Ocq0HZa6ms6WjhvM6qO0L0XY9LKUz0K?=
 =?us-ascii?Q?86OhjX9IIUoW2lBE65hsrOv9/5g7FTABcr/Etin/9EL+plK8mCRYwBiZRAq5?=
 =?us-ascii?Q?TJ/tdriaWpazZtjdmRGizsFjKyTCj+DdzC/LWoBeIYssupbNVzy+MceiC8Pv?=
 =?us-ascii?Q?5sLq6vX9SFGPVVCV036qPVVjr2ptjjKGBeqM54pIDAeYhcMmOBNzfYWQTXQA?=
 =?us-ascii?Q?9GiIZrb+SJwO9xhyZoXDmyZl5KtES7ewLgwqGawoYSCwi93RZ+748nND/r8D?=
 =?us-ascii?Q?sdqsUcdakTuojDL+n+3zBeFxMiIPN12eE1grlxfh/5JNxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWbv/59//O0Uf5/kc62rIvDe4HwKS9LP2wHttlaOVXXUt7982/cWxCIQXKTo?=
 =?us-ascii?Q?bS2KTnH/LrqVAyFl2ZMiH61KhMU5fXmGd3IcyOzYBO1yjqhuhR5SwJTnIEUk?=
 =?us-ascii?Q?+KPoqOGXNoNFoZ+TDCB1poN/xpYXtFvd0zXpFQGbFsiFIfW8Q7NtMtlxC8Bk?=
 =?us-ascii?Q?4AK2HoWUQiJ25ChsjctJzGaszoXvIwVTVFxLavy48N4K0/rbmfHXgOGrgh0o?=
 =?us-ascii?Q?ZdZQ/EKXImRphMTdJSO/EwwO9/gQbWGmrgge5E9KyuTTjn4x9pRR6ivD4q9K?=
 =?us-ascii?Q?CBLCH503UOQNj4zxdT0/A+2z9vZRPenducISLZQf6jsF4c0MuA8+MsPy4iak?=
 =?us-ascii?Q?IAOW3bvdMfGBDysYNklz08NB8g5c8Rx3BifGdIk6pnbH16LOI0jJxEHuCDQa?=
 =?us-ascii?Q?Vs9a17z9ziwW/U5iB4qyRrYprHKJ2KFkxlSj2XyY3+Kr8hsn6uZLEashCrYK?=
 =?us-ascii?Q?5bSpUhytf21WmL3kMWghLIpjDk0WcHlsqKg+uMh1MDH0PGUz/z1psGz/YQ2S?=
 =?us-ascii?Q?YjsfAXTSY+THPVR+eaX17+oQ3jrPcW8zASkoch3EXeRTQ/wrIcs1sf7PEBqi?=
 =?us-ascii?Q?I52IlfmA8M0NeKbf9dFB+1lNFDQ7x19wM7RKeFgPpHt70mMsBjOMj6dUY2su?=
 =?us-ascii?Q?umfTBJNkR04b6IqMUa/qRWOaJ0wF0iU1eZT5OpmF5IQ96WQY8i7ktcZShz5X?=
 =?us-ascii?Q?0CkJI7DA0ykXQoHi720GgctM6oT8Ir0ndJa4PgfbOS0y6OJv+p8jlqnn4WAe?=
 =?us-ascii?Q?F1MhuDWk/8OK/c2f+Qnz+1fTBMkeGEGvt7HKvxnQG+Yhui1GtnJa1lBZHXFQ?=
 =?us-ascii?Q?XzO5WkGlxfK/mDK1/52OyU9EeylH3n+jbQKp/UpKgP5vHwd62jQBFqx1s7nb?=
 =?us-ascii?Q?73yvEazEmGRvVB2v+SoHQh0qv10sRMu7tgoK9ZFdyQTxtu63qzZtW3h2YYtb?=
 =?us-ascii?Q?FWEGDry4yHf2FHYUslFPCxn/llA/QCgTtdGVZYu2vvAMw36RU2SbZZ4Owt11?=
 =?us-ascii?Q?G+chE7tDjXS+4aawi+mNDNKrjJsncNKt0YaJm2ABjbox4Tx2aKqkhg/tPKab?=
 =?us-ascii?Q?oo7tQ/H8DRQbKbByNm0mMrMBeKlh63nTP1BFwmdYMaPtUGvSzeuuBKqvjGpO?=
 =?us-ascii?Q?iFYvOy/ShZQEfafgXA23wtU+hKJOkKuVjndb6/IC7vCP6j1OpzOyROHE+6PM?=
 =?us-ascii?Q?nBWi/tT/gM6/+pfwaZFYiFQYAZNEQawrlWAABc/SMryPXjc3P+brOCnEymIH?=
 =?us-ascii?Q?ES5C2rkB0ANrq6qTFuvH90GhjjF3GeGZm87U93CXH47vRhhqq1pW1xlXbFkP?=
 =?us-ascii?Q?pzqsUkpk54QGluunf2ies4q6ig/FvNbX2n8bG+VA4ZrWLe6El9CsBulSIRHl?=
 =?us-ascii?Q?/8173o+NVElSYL8llS5eqPWyKePNkX5pWjES0U401ENhysXH4ppm4CbkzXHU?=
 =?us-ascii?Q?aDocjtZHaIbb3lWTiVclUMbnryHuTiaRnCo0Hknsbc+qgylvCH2TaOcOaNNP?=
 =?us-ascii?Q?AAshrKGfvKewPQrcLh8D2NeLpz6YonwdkWp1Wvx5bL0Dlgsn+okBWg7oBOv/?=
 =?us-ascii?Q?3Wlwy3JYIWKbPpquq7o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b006c365-8db0-4244-0347-08dcdcadf624
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:31:29.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFziGdKzL4nYeLKQZa4bA1fgJUn9dbPNGESb3WENq6X02KPMI0xRG4gRUc+9nf8W4Kb3i4UeTy2u/lq5+6GTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968

On Tue, Sep 24, 2024 at 11:27:39AM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result.
> Fix by removing IMX7D from the switch case branch.

nit: wrap to 75 chars.

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e8e401729893..d49154dbb1bd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1338,7 +1338,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx_pcie->controller_id = 1;
>  		break;
> --
> 2.37.1
>

