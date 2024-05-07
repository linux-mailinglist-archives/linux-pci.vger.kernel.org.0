Return-Path: <linux-pci+bounces-7194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C68BEC88
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAE91C236C0
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826916DECF;
	Tue,  7 May 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvNowXeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE016D9BC;
	Tue,  7 May 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109772; cv=fail; b=juNV2n+zWS0CG6oSvTp8wTIUuagGGyTZlNM7cFRFc4PlZ8n379yOx1rDEouJTNJEMD4D0Sbofb4CNnI0svk81n0fjk2MuXDk76ijagX4OJb994chgnPsjYexBfX8EHUBQKv92ms9jMN0Tgxcrr9Xeb+kIcBPZOzT9XFOEKDj+p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109772; c=relaxed/simple;
	bh=iZTXBOjSett8kqVNXkIPncZQsEXyngZBd6C+nPStJyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apYkM313iX5U28SZ3GpP6CaDj16X5e8oL9PVyDr0OvOZFsuyFvzWLjvy3y1zL/o7deGWnoK0Lj/UhpfqW6Ao5eBmgyIJLEKWAZRTue7YI7EOHgbsv2HafEPyUV/6Y9PBVVtgmIBNzokv+PZs4E7sw4dfbj4XJoEpFA+zhcG62j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvNowXeD; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cre5xAfeynLZqxjm79JUBaGKLrr7OaQhVAr4VPENxTVwhLnMJvG4osH4i05wJCBKSYRAc8SipQ8zB9I01fQfffgwo86wdTNEGkP26r4dpQqD2zcYMvtaDhh9GWz7StLDdwfCvowL4PnwVeFfG1aXYJloAHmzf4sjd3oxS+exueZk6a5fy/01gkgO0aEM+eJ8Ek+RGAdvJKCxnJr4hpGnhOX5FZaJrSWC3JaQGZA8QrWI5v2zk1+DUkeDDYtJUIY4hdOaTH4YOcU6Evs0u63f9Eg0yQcYFEUH0m4Ql2l1pcOz1zLccDGlQhn+2CG65nnt3VK6YrereI0QXGbT4q/guA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JRYekvafAkFsK+ewCfN7nzNDf9LkDH0Bxxo9KPvwtc=;
 b=JyNa5CSwOf7rcnX/VnAhocQF8yHujt39dJAm85Ur2Ex9eZ3HB6CkZYTKGQ0EALpuXT33mzxkGIAd+ivmM4Ny5yVKoxFQBfNG81oNFPz2h+UCL482NoiAeaKUbyZhra7aAZ0wvyra58CkGBlj2ul/z4hrUe4xoFnN2wQqLEcd7nL0/It4lUDfXuLbnoXQ+rKEY9e16N+mWxwxaabzpWpStIOYegJ/JNXdTM52TMTyxw+RqTbNuYTadqcKyJUyQTDrr9EO0kTKVuc/j41D4k4TMTlPdmCOdhnvsJCPXOPZVsVlyAwknCPiAFU7XsqkXHFVvwUWdn1EvpkmP2Av8ByEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JRYekvafAkFsK+ewCfN7nzNDf9LkDH0Bxxo9KPvwtc=;
 b=TvNowXeDUaKfIZR+PcfKkzX6cEcc7QBia2FNwCjxQTS0Mi94z+Kg3zxSLvsYAwaoFmf4GI+nnc/BUZcQknOf57OdofwrYztu3aW/XGW6vCWNlJj4hAGtzl0POpy9a3PcdZ/PimUGf4fkfyVADhY+qR2mXsasNC9khM6nHwTwHRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8785.eurprd04.prod.outlook.com (2603:10a6:20b:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 19:22:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:22:45 +0000
Date: Tue, 7 May 2024 15:22:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 4/5] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <Zjp/eTITvtTG8bBL@lizhi-Precision-Tower-5810>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
 <20240506142142.4042810-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506142142.4042810-5-andriy.shevchenko@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de290e8-cb74-4f59-55c3-08dc6ecb1320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP0e7g2haWoqj7fKp+3/kkYAHDGeTtJaegYjIzddy4SqZs5C9rcsRZ5/pE5j?=
 =?us-ascii?Q?vzJZWaokNLCZOO72ts1zpuoDkk0vYsavz/sKUjKEMrBYxke2AUypvsKrP2FO?=
 =?us-ascii?Q?hSE6iYb7JrgIEZHeOpQR1c9LjljrTVvC5hLWjstO/JUMddX4hLgwrURb2eXX?=
 =?us-ascii?Q?wUF6En+9al7aNRJhAMc2k0/+lWhWb9ENUnRebLQ3yLnvwIWpoN9BbAUE5Tv+?=
 =?us-ascii?Q?m6+mNRXNBXAizZ6W7XjdkhnAOUghsyzCziciQrll5yUEE/gVaENhiFKyYMUQ?=
 =?us-ascii?Q?d3TUn0H72lM7b0oLIv+22AZ8qPa1FoiCcvWZKVc9kIgBCHPJZYB5VdmQh/N0?=
 =?us-ascii?Q?obRX0gdeVY5ukmu3XfBSCtiAzQys8BClIA+W+3tkSDiRlabLBJGibi+dm7GZ?=
 =?us-ascii?Q?3wiNK04uYRw2YrCOEFRT67DqkvJh8NlTKuvlEkrocDLpvYJYcQYOQJ9oqq2Z?=
 =?us-ascii?Q?jRQZhKHFA+EwGiZwLDTSLhxXz1vXWHc332ufHDNUaA/KcX/r4j+8J/phtAjD?=
 =?us-ascii?Q?3EX0UR8s2QYgg1Q7pcWhhvupUqicyEGloYmqzot5Gczcq4BXc9YVh4x4j09P?=
 =?us-ascii?Q?XN+oGT8BwqeBxgUhGF0VzKyCKVayxVKWHd9Xudyw8dLh88YT8+0jT4aa1d5y?=
 =?us-ascii?Q?Sql+VeqB1MNv3XRJF+bv15g852xmq5rp2RWgXHl8Ftr+xyUwqcYX2ka4uBkz?=
 =?us-ascii?Q?uvDq/dsoKlFYPiIPmPxQ1EFMVy+wp0YmPS0FN+VZQN2Mm5C6gsMk15ET5FWn?=
 =?us-ascii?Q?k9tX3mBUBouGLiwuq84iawWetd81m01DJp8JbH2t7TVedSHTGDr26NA+cBDp?=
 =?us-ascii?Q?LU5F0oiT4Mc6SBpwTwMnFxCW39t8k0GwZw4qnnhG4zTLpGKO5ofq7/pwbZld?=
 =?us-ascii?Q?w2MThZ/ogZdQ13tV/+Ldwc9+pPd995w3ISbEUpxUzEVgGyN1w5YmMrNtYAGR?=
 =?us-ascii?Q?tZhdzP0YDJ5ckZ5mkW9cTvkj03WYvcaie6JdRhElhTi55Bih4G7pWv/KTEwB?=
 =?us-ascii?Q?CV0MHh+J5bffgSw1y4WhFmx7XFAcEefBEhxl5OYK3Affx0V9DgRHObTZX1EP?=
 =?us-ascii?Q?taSE76APY1ex+u+3JxjtoLBhtg/AK5vT4AS4gLz54i0LRERhZjnXAR0BT/ab?=
 =?us-ascii?Q?Ra9zVIrORIeuQS52W5UFV2hPrqVIoVcFrqLsNGZs7NchXE82E/FSwqVT+vTK?=
 =?us-ascii?Q?fhHU3E3ovBy0ULK9JIU+AhFD66GqZ1FhNZH0/Cei3pFy6IWcHtwxu8V0kGHm?=
 =?us-ascii?Q?7XbwxVqhrkn+oT1WNBzynUnuVQNkIoKIteKsSIKhrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVSUFJpCCxnhUy9On/PuB0lev0fxURNHnOTIZgDiTtPCzf2QcVTQ9mfUyBzj?=
 =?us-ascii?Q?CwtndArE/H/enKpfKQfQpM+n6R/1g0PDPmF+HqWCb11hjlIsrAkwQ4I2Oqdr?=
 =?us-ascii?Q?qMt3hZDETwWtqHUxtxJT6P+4hdiSzD4tUl19YLCadgVzZ43xpZtmm8dpytVv?=
 =?us-ascii?Q?ZwGSW0mdmBamfHLV3xb0X7LhkMqUk2JTNZ1CnCdBB9A8BaXSH2U485pvkBVv?=
 =?us-ascii?Q?Uwg2JQfYyYM6BfQa35hR8G3xB4Tqjd46LoOhFOfR2v4mx1Dt1ktz6O9QnoGv?=
 =?us-ascii?Q?izIuq485WsN0ROBicwfFCbGpiKbFyfIyRFIZxsL8obtkOiTftVoQRClpHOwL?=
 =?us-ascii?Q?49qqzluF1tfe4eRdFuVtul4fGY3NMgkiVf8Q3xveobFb725CpzCVkhQhJWqR?=
 =?us-ascii?Q?TSXQKUT6AuG608BnoMlT6YI+IDNSuL1ygDCtc/7AWSRbETDh7Xx1RmsHyC/M?=
 =?us-ascii?Q?5U661X96f0JEDhBDkkjEBd1eKDQ88ab3HSt5rGD1F4/HShERpcV3i4/QRtkV?=
 =?us-ascii?Q?WNMx409vF437Jh1ZwJnSvYVwKAF7k97nKAhy0TPeC2CbS1+9j+572MhGls90?=
 =?us-ascii?Q?Gb4WWJPSk9vA/Ciy0Fdy0fbdLQunDRwRBeGvZD1acNuX3LSEvyjh9fC9MRTC?=
 =?us-ascii?Q?hwszHKHqgbMZq/7YMtonZUjeTJxrUbKFRQsMr4FPO4kzVqF6CqWqaSZGnZA+?=
 =?us-ascii?Q?dxDSmqbXDZMYKGThQ1+6xVPXbrKSN8Iuaf63iwdG+nIk0xG7DTaWv9YdnRlq?=
 =?us-ascii?Q?/9S9ACPQje5QBOBta+DA/pyv3+VULl+DvAbsOZ4XtCv4D6IiOVzuNF9g5xfI?=
 =?us-ascii?Q?fl/X36T9yKZkTO2Y0l4RjNxZEE5/93H/el595uF1R9fDN8Ptwe7kFkxf9l92?=
 =?us-ascii?Q?JyxlOZYiiP1Q9k1DJffAp2Pr7TxEGJqyjcHsfdP3dKxjDRkj6MoIUWkAfBLd?=
 =?us-ascii?Q?1Jw31booup7kd6pCaUi311Gsf6c0SVPQNnK5QKm0xYSFhycJ8v2NBcCTrntR?=
 =?us-ascii?Q?s0+F3XwXd+heUl+5u+s2fuuHsfI2rTDq+9WjF/mXMAz9UCNbACa66VJCmS/L?=
 =?us-ascii?Q?AJ8i3szpgTXzzNIcqEx9QzdFbHo58igd5bSOtV4/pEcNz1f03F5Ste2pUOn6?=
 =?us-ascii?Q?ROEeivvH36zp7IIfm88QaqLox023S52LV3jK1ZxZsDVK9oQn4j7fYKGanevq?=
 =?us-ascii?Q?kI7q1lXsG/5Gm+Nim21yzkOKKS9AOlWw4j8HCN67WHpTmD9rjfVgX+3qY7UC?=
 =?us-ascii?Q?OMZSrrJQSLODtTIlSsFLbhAObn4w2d6iVMeT6p49hZBRPXTYiPFm5XV+mBiS?=
 =?us-ascii?Q?fFNaNYWXdGoTu6fXovrOcqp6oG7ARRkUGf71Vf/19PH+0Y9piyg6VbeUIIPo?=
 =?us-ascii?Q?PZiQ3n6zAoOD6WwpA1GcMqAuFh1gUaSxmLTfi5cAse1SLIC+hX2RvemKHobQ?=
 =?us-ascii?Q?WIRf2ECbZAWDr6SoV0ZrtItzfK4DVJ9+qx9MG3x/dx0/KO4LkVhyCtdzJT3c?=
 =?us-ascii?Q?HwKYOEd/hu/2m3LPURsPowflthjOU9CCqzdofCrh1GLsAHyCsent3Ybfhzt1?=
 =?us-ascii?Q?Xk/jjXZHHVyAD/dcarFvHYqIKnNB9dm+7EovzZ+M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de290e8-cb74-4f59-55c3-08dc6ecb1320
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:22:45.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQpxN1R6HGpaMCb0b0Y/2A4XtPD1z2J59DmS2qkcRcfCKfTofhp96Ma7smkcdXkz4SOaY5ZRbpl7IbKtc/5W7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785

On Mon, May 06, 2024 at 05:20:40PM +0300, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Can I include your patch in my imx6 pci improvement patches
https://lore.kernel.org/linux-pci/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com/T/#t

There is patch, which rename function from imx6 -> imx. That will avoid
conflict.

Frank Li


>  drivers/pci/controller/dwc/pci-imx6.c | 36 ++++++++-------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 917c69edee1d..62a4994c5501 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -11,14 +11,13 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_address.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -107,8 +106,7 @@ struct imx6_pcie_drvdata {
>  
>  struct imx6_pcie {
>  	struct dw_pcie		*pci;
> -	int			reset_gpio;
> -	bool			gpio_active_high;
> +	struct gpio_desc	*reset_gpiod;
>  	bool			link_is_up;
>  	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
>  	struct regmap		*iomuxc_gpr;
> @@ -721,9 +719,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio))
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					imx6_pcie->gpio_active_high);
> +	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
>  }
>  
>  static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> @@ -771,10 +767,9 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +	if (imx6_pcie->reset_gpiod) {
>  		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					!imx6_pcie->gpio_active_high);
> +		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
>  		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
>  		msleep(100);
>  	}
> @@ -1285,22 +1280,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pci->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
> -	imx6_pcie->gpio_active_high = of_property_read_bool(node,
> -						"reset-gpio-active-high");
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> -				imx6_pcie->gpio_active_high ?
> -					GPIOF_OUT_INIT_HIGH :
> -					GPIOF_OUT_INIT_LOW,
> -				"PCIe reset");
> -		if (ret) {
> -			dev_err(dev, "unable to get reset gpio\n");
> -			return ret;
> -		}
> -	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
> -		return imx6_pcie->reset_gpio;
> -	}
> +	imx6_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(imx6_pcie->reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
> +				     "unable to get reset gpio\n");
> +	gpiod_set_consumer_name(imx6_pcie->reset_gpiod, "PCIe reset");
>  
>  	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
>  		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

