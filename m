Return-Path: <linux-pci+bounces-4029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D711867C16
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB31C233E0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D474605AD;
	Mon, 26 Feb 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrdQzsW6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381A604A7;
	Mon, 26 Feb 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965178; cv=fail; b=ilCD+4ODx/rBF2uANXs9uodvFvuzsADvD/f3DeBcAWnnL3I+Ul9GvfmVPEBIgySY6OnfH3cu80pJjIZAD/t1o7Nq3TGTBqNE2ggKWaSrxbC3a+JFSNYM4rLeR4OIdXBoWn4mfYY6nvPDuqJIWrPkQgEsNeZt0Jgl2eh/C4bt5WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965178; c=relaxed/simple;
	bh=h892gGm9n92VfkoepLAXoDYtxmClr+gyPmuHYO2HTDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jv415623yHXnerMei6GnOWAjqVmHZnBe6528z0GBANSF3bPazqY4s677HATc/op2nJiBiUZo1kpa57AHeVoSU5oiD5WsQx/a/OM0AQkAXUSSJV1f2QzUk+byxJzx4UAay4EBLzc6RtKCZRp8WM7VZogRKriO175oerugw10FMec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrdQzsW6; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gapsajyw90IFGK0NJf0MgFyiTZ3H+R9OPtNnoW5KIKDbEi7ykRB8Cfo42YoD2kqmXP59K3B7U+x5EwrOgtqfsefM1OZucZHWO0Q2jR97tEx05Tjut6dbA1BQHVymqbPcOSCWzPFmNoxExJlqYlnwyrU8+TnD1lhhjF//g/uOKTaPy1pHQIHL7EvX8w5XtH7awgp7r2Wv5aeOwHtjWSyPQYMDtNuxSA7c/nPF+n9L7RU6Lk5qYXIJS1vE/jvfXyAkvcKtJu+rD0NS/AW54yCu1+DNpctMMK4KUtnn/Oxci47an6weqYFQSOn1e8kq6cjO/m/pju1rc/vHr7MFSaSJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/pT8ZGgY2hbmZ21P3q84iK/+kQgF8Ji5zXdLnMZmpQ=;
 b=TVQoCNkq4Qo/rk31ic4tjycD2EHiKj96LIaxE4fvNJOIhBwsKKGkQWP96d+s0fYT43uADR2JSdmnR8K3TMhLEbXS+kpIdaUr1wOc90m+p/dtTNkRyANRY3TotTMxKcO+xSZwgCVAlRVI12HROfiew0rFlFJ1Voi7HuVHdq3xDx4L8+NWlJxKD54m7k3jDRYS9v+UYHWkEc7ZdlEn1LsgmBooE1lmEGFGV5ysujsJQ6ztcTw/+g2HTIuDgRmlI+R3xaf/SH0UdefHTd0uLIsBNqR4dwBzqx78P4QsJlB0JuNyuQs1/hKj9nm9cns1+hQrXwSG6HqIq58X9w2RE8RYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/pT8ZGgY2hbmZ21P3q84iK/+kQgF8Ji5zXdLnMZmpQ=;
 b=ZrdQzsW6v2lntIYPgp4EMJ7Yo5D47kDbU2RJaouzCz4BlwDAFa9w8E4WmBP6RrDLjC9NCkzkJNUJ1RIjf4hrR9SaZSiFxgnalH2pK4TIDdNDYL9XkIaKcLtV2i0/YRVnWCFIqn3qUkf7913FlpkbRYG540bDYo/XWSgG1iKrX/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8444.eurprd04.prod.outlook.com (2603:10a6:102:1db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 16:32:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:32:53 +0000
Date: Mon, 26 Feb 2024 11:32:38 -0500
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
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 4/5] PCI: qcom-ep: Add HDMA support for SA8775P SoC
Message-ID: <Zdy9JpjXRo1rJ0IG@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-4-cfcb8171fc24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-4-cfcb8171fc24@linaro.org>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a2c13a-89f5-435b-701f-08dc36e894a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mUm71ERtOAFRq+nj7MO34EvjcWiGEAKYdzfe0qzsReWm9nY2A/eeNpGFcJo5dNVEHjGtTFr4w85UxuC4+/vLBUGWrn869+XO3xZrXXR7Ujn4/Woc9zT9QLe2Aa2ScK2LsnkPEgor4u20pmD59K5gjMmcuMnheknDTq4E6h7+NX1KxwogwE34wnkm7QusXDqOYpIC3K5sXJxBpcn+jzuydFWqGVXOuWlOdmfi4q8aaxnx1rcMHeEu0tSQwxXEiOHCKi3ajw5gJPiFIVb+605BCfnO3geWOrpPJT20XOcScJbyph/JFlGkuPnpYq2EF6JP5oacknkHjGLvLIJrRZBVPJMApLMfqQjXCmnOW/yWE8ecfLV46dIkIJlv0uyWjMqrSDvp9vy/Md5C4v8OWQOb9v4lXuW7OQseLd1t1P9FY1r76MojonRDYQ3E8l0oycggYeaHvud78KbZKmRHwJl0ZYeicujhXgT900jv1Wg2YelEDlQvfk2AwMiPAHfKXKL1HegEAztoAxZdIV71LT2goP86xP1sJ8OZvF3rJllJ3mW57YOs4mzhQG2GRSAyUMJf03pCTv9Z+xVeHofVkCLOPebSMF3aEnxYBBd47diJjUeht3MX2iEf6Vst5MCTrzCH670odWUU/FdqX7Yzy8eCZaMJ9n8hTVvWHpHDH+Dcfmq9hPmaNFgvb+0qSATouwOeNo8qVB+vYXP1C22iUm4U11McRJl+HrnGuBKyVA/poO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60PP4InPpuIbyb8erMlr9SHrIfJrbZNhNuGlGLJdCeY17MLdeCouVyyUAhH5?=
 =?us-ascii?Q?8mNW9RKcwAmAhbUtZL/frhMm9UJnYCQZbZcUf5nIILBWHJJulLqlVM2ol1cq?=
 =?us-ascii?Q?WkICdRs+WmLbE4nm4JAJhZrx/yAtBVRXf/N2iJlu5qOdIP7tf8qD2LKBMFyI?=
 =?us-ascii?Q?YSnEkz9STfcS3C7RQtKNdUqz0UB1OPg/5Ng6fxA9vekancluaLevCbdz4fQu?=
 =?us-ascii?Q?uU7m36AlOQ2rlpLA68BlnlzALYR3pKcsYBFUJH7jxqcCIKIZqC3oPzck574e?=
 =?us-ascii?Q?dT9ev/j2OpuTKvAPDu7GabNX9BcTr9oIJR23qo70PEtj2vghb2HYEkpkPAqz?=
 =?us-ascii?Q?YRhc0i4mYwxvyrpe8aKL9rjro/kfzpE3oSchm8lHwUF66W9CVv/6olUcVNOp?=
 =?us-ascii?Q?s9ai4wuKgskeuH1NGLl4AIZ6KHt+p6n7z3nkuJGoMmYGYZzcks2Q2wkye85N?=
 =?us-ascii?Q?zetY2rTGAM2FaiGf1cuIveiNi6qoDXLuRqVF852l4hu+sE3UF1pn0f4RUey+?=
 =?us-ascii?Q?DIsoBCcLtSQvTVOLYbuqiBPPh4i2uew6reyoNe97miF0YTmxRYKxdsmWE+0T?=
 =?us-ascii?Q?HKIJGq5vODDm21IK3R+oOxm/HentLYOeYAZaniGNHnFXrzKuihxTlV4gTpxT?=
 =?us-ascii?Q?FWcowqiZ0GWmd3+VnCXw6msvnV2YPFtA+aibhGbir70t4fIVQGxiNBKG0TUN?=
 =?us-ascii?Q?iitPLFswP8GvmOOHmPTaPGTTPzSEuRN00UDipy5AhrlDOS9xZ/Pecku7o3GY?=
 =?us-ascii?Q?aXaZQUcGRkY340aAFv2yzn5VNdtioL5YBLgCEek3df6EOkrAyLXBL/iTSCyF?=
 =?us-ascii?Q?Hs2rKJUQoTl75f2dqfyxyKN3NhmyvnJ1HRgSx60lVW1AkWpjNhsFyZmdOerZ?=
 =?us-ascii?Q?cZ2YF9HajHHNG+3uqk5p2F2nHhG+dum5XQgLLaUux9pDtyeZHi3Vn8kjx28N?=
 =?us-ascii?Q?ncEP8N9k7LnVwCyLn/aOx13fGJ07FT5YPd/QNHPAWTZ2eUfwJB9U2pF7REWG?=
 =?us-ascii?Q?YlTIebx13B+tUzuMSV2Ztrz2cUTNvtK5kLP/Xsd7LrfOg17qO5ZZqfGj/Pbd?=
 =?us-ascii?Q?1BZd0Ni8OgGAezuEFGrDw/GgkZBVO+9K8yPCZITtW/T1dLudPnLv97kk1swu?=
 =?us-ascii?Q?7Rv4GV8IOPVGMEdmgJRRktQFXursEfljXBDAYSuwQoPYq4hg9FkiQaWeNHB+?=
 =?us-ascii?Q?aNfm4NNT+DRrEKxRgMgoeFYWUEIkNFZV9RXHsDDDqdKWG8gGumE8kLQfSoXX?=
 =?us-ascii?Q?wkNw9zeZCtLKOIe+Cn0ojT9QP1FXp4AETd5kVPOFdYoc+/onkNpDnUz9KHOw?=
 =?us-ascii?Q?5hYm7DLhn0H9l1ZDDFwJi85d8FpBgdCHSiWyDxmpeJJqpqJevlY1eObBvvRi?=
 =?us-ascii?Q?NYGGWujoptNincOvEVMjT5CK1c7rt9g0JybqzQCVm1kEdDGN+SsFdxs5Zi1C?=
 =?us-ascii?Q?3nFVwHzjXuEIHW2mIz5D5lOQOCAFkWqze23cru0+5BMfiVNXde27WceuWlGv?=
 =?us-ascii?Q?VbjOdDPD0phwWOA+5tlpaT+zPHpUkiBh2FCPGb7GyKOPJu6uVZlWf52tVHlv?=
 =?us-ascii?Q?8sHQFBmEDfi2xKYM3H8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2c13a-89f5-435b-701f-08dc36e894a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:32:53.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShBghN4HLK5Tu6CY1+YWrrVOkCSyZpuyE9t1jgnpvoffgLvXUnNmUy35+e/Ifch9YCe7bIIvBGNZu/mOf2RMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8444

On Mon, Feb 26, 2024 at 05:07:29PM +0530, Manivannan Sadhasivam wrote:
> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> 
> SA8775P SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP.
> Let's add support for it by passing the mapping format and the number of
> read/write channels count.
> 
> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
> config struct is introduced for the sake of enabling HDMA conditionally.
> 
> It should be noted that for the eDMA support (predecessor of HDMA), there
> are no mapping format and channels count specified. That is because eDMA
> supports auto detection of both parameters, whereas HDMA doesn't.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> [mani: Reworded commit message, added kdoc, and minor cleanups]
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 45008e054e31..89d06a3e6e06 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -149,6 +149,14 @@ enum qcom_pcie_ep_link_status {
>  	QCOM_PCIE_EP_LINK_DOWN,
>  };
>  
> +/**
> + * struct qcom_pcie_ep_cfg - Per SoC config struct
> + * @hdma_support: HDMA support on this SoC
> + */
> +struct qcom_pcie_ep_cfg {
> +	bool hdma_support;
> +};
> +
>  /**
>   * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
>   * @pci: Designware PCIe controller struct
> @@ -803,6 +811,7 @@ static const struct dw_pcie_ep_ops pci_ep_ops = {
>  
>  static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  {
> +	const struct qcom_pcie_ep_cfg *cfg;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie_ep *pcie_ep;
>  	char *name;
> @@ -816,6 +825,14 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->pci.ops = &pci_ops;
>  	pcie_ep->pci.ep.ops = &pci_ep_ops;
>  	pcie_ep->pci.edma.nr_irqs = 1;
> +
> +	cfg = of_device_get_match_data(dev);
> +	if (cfg && cfg->hdma_support) {
> +		pcie_ep->pci.edma.ll_wr_cnt = 8;
> +		pcie_ep->pci.edma.ll_rd_cnt = 8;
> +		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
> +	}
> +
>  	platform_set_drvdata(pdev, pcie_ep);
>  
>  	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
> @@ -874,8 +891,12 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
>  	qcom_pcie_disable_resources(pcie_ep);
>  }
>  
> +static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
> +	.hdma_support = true,
> +};
> +
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> -	{ .compatible = "qcom,sa8775p-pcie-ep", },
> +	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
>  	{ }
> 
> -- 
> 2.25.1
> 

