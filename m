Return-Path: <linux-pci+bounces-6592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873548AF7A7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7041C220B1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77757142623;
	Tue, 23 Apr 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHd4VnZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD21420B6;
	Tue, 23 Apr 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902234; cv=fail; b=fQzk2/N/pmw32QKewuEnuTA+QkbWQtiQM96Cc5SuQMm05/ce5sU3QGbR1hCD6QwehfWKmZOfEQZcnlv+pTiLJZWAigR4BSW8jpZrfFuL06uiRC903t0sQc1/bkmyD6BKZHz5M0afrtj8+e66WMKQJTmgGFy9oy7zWJGQ+G9mNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902234; c=relaxed/simple;
	bh=0rQqM5eF4t0B3fnxqpTq7B4bZyOl0eoFI9GPhySi5qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pa6nCCTseZcGVoI0SvXouADn/2rL+NoPLkOJacRXWEKE2UtRegr9pdHty4ClyxG8SLCO1iA5SuoOLWDTDBcN1x+zut+eB7pWgQ0U00YSEHX8tXMtH0rEw07LUltID8rTEvMCS1VIUeFeKqEdkeoIZsklRiBFvx7kLk8B04N1Ub8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHd4VnZ6; arc=fail smtp.client-ip=40.107.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htgr8AJ7JodW/q/ipaBowo+aNiJn/IYHJeqU/0MqibFlJqfl90ehbhqp7DpxieoU9orHbfmEGjDyZJK0rqL+XLEllNlMwMoRID21ESyKi0f5azAjMa5Eg0v0sPB6HT+aIYEIVbEOp3wefLPPr9AzL/dGS0Ya3RY0ZvS+GbfwA7ahlSQcaE5CN/t8ycliKFbB2HPsrnklXiI1JZMLRSPF5NW66kXVm5RdKdyTLV0R+Dm8xr4aopCatYtfIdIcH5rB8iIuzAZz5fx7DV7/WaCkzcGO14PEHpZYutu0SsaevHpv8PVB4XlaTCCEUQ5YE4ri7vcs/taWTmXjx72S6SsUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoQnRcB2msEP6VEf3ytWxy2WIM3vJg1G4G2FWlMtOVw=;
 b=a+AhlJUIVZjhglZNM2G0Gq4hsNYvSxYGAA3q9hRFlORNdyCMMnY7msHy2ZWsZbVtovTPql6WnjaK/m9vBdf18wKhwoV664O2rS1hTwdVfSP8Javq/AvEafO7q4MyDiKwfeFsAUpOU3pifF3f9E2ZTT5UXpddpmp+bamxvwH514ZTZswcaf0o/+OrHK4PJOBgRRMTOygEZ+ikNibbNtO/lWzwWk9XboDyCZH3yO+je7w+sopCQYLGTZWHpxJaTlCvH2lxr55oc1M9lrd8wZSum6BU7u2+kKl/pHY9mS9IaRijqyqDOBUNS/SridEvq/MOKd6aGw1G/a3NT5dtuwnrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoQnRcB2msEP6VEf3ytWxy2WIM3vJg1G4G2FWlMtOVw=;
 b=eHd4VnZ65J/43jDVyLL0c+j6Uct20X1KNWeG9X4quC8ohfYZjcoH2Efl/fPqbLBAnYinkWwOOSdjoVJYNNGEbS2Wei67MuYbYftEoEQMPrUvBaA3QKyqzjr+79Dv0v5ECmVPQTu3iGe3r5Vow/Lt/znH3eeXoE/8C4fTh08At4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:57:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:57:09 +0000
Date: Tue, 23 Apr 2024 15:56:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
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
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a2ce6e-3be1-4bf9-911a-08dc63cf8f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBBg2XY20IgJ0EpdzHhRhdONHdCH0SmFhi35luqGsHdZ52BkyZrBwjEiuJhy?=
 =?us-ascii?Q?o17wZFxuKMCQ8PF95vTxR5EPbiOGMIXVsPIydYbekwCCWXPC3ROvmLGv7WoU?=
 =?us-ascii?Q?aOScWbf49qeeQW9VMXI3YPNeEJBKBKN5ZerdfRLWHVYEvfeLsW+RXvVvXKTS?=
 =?us-ascii?Q?fIS6/NPHUURmyUzEpvBM0rg8rbw4dkoN30PsTTut9lEjLwo7g0or8z66V+dh?=
 =?us-ascii?Q?e4/qHQI9bC0sNbFXo0t30go/InO9OCI7WHjGNkw9lytYYYqKvRJG0gj4gY5m?=
 =?us-ascii?Q?41BcZIInfJpeZKkkOM0huVxKLDIMrflCse+5qbsfy1qcloSvzQ1iPiGgpWdq?=
 =?us-ascii?Q?8Vg1mWpt0O7yuww3sIrgWmm35gPB2GjS2JZXexw540Jz9oYLLQnFQoEt3vTH?=
 =?us-ascii?Q?ZF5AHt5tX/Ue8v4Q2mvSOnGEzRmPHcaBK2HaYvhCuDVSdJ0FLkBmL0d/pspi?=
 =?us-ascii?Q?tcgnOvEcX6R/IkGa6L0uEwIWbKLsfvTKqp0cHnj6nmnvMk5qxIr5xxMOxrAl?=
 =?us-ascii?Q?gT9ZZ9+CT2W/pBIVoRr1uQVqFnOF/24GkBrnijXcdBgIThohzHn+Cwc2LPxj?=
 =?us-ascii?Q?5nrN+XoVz2wUtX5Qi8mKz8QLGImZVtkgNeA00X2CAadirxyZWiw2b4CqlYGW?=
 =?us-ascii?Q?pPaQVAsc0T8wALAPZAli43JaYm2rb+XOrUO1JQvfK268CNhDrMkjeUszVMAE?=
 =?us-ascii?Q?xjdN7TxPPfMglAWTIT3BtXGij67vHtJnT/DGlNB60XwVEryNDrcgwQXDGxNd?=
 =?us-ascii?Q?dF+62VPMqVL958vY/bOOUNHjop6wavh5pIj2JYquQSDupk4WN0EBPcHP8wYa?=
 =?us-ascii?Q?mF3zzUcV5A+45+YeXtZQ8kJ5QByDmY1s7Oot9GRw/1Gw+J/X6lOrUzKnueGY?=
 =?us-ascii?Q?2aQvUVw1hJCTvr0xForOkumpjtO61YCV1wM8kUMQrrSoFo5VMvqfqUpAR8FF?=
 =?us-ascii?Q?f7LLDtrurVnHsG3tkPJirOtuyYw6M3SEVuSm73M7NU1Mr20V3DVAjwuRVL3J?=
 =?us-ascii?Q?2SlUu8c77m8dF3uFO6BuEE2o8GeAJbmVYpAgYf1bZql7V2qbszszI3CVVQyD?=
 =?us-ascii?Q?YT3P5/t29gUNIeiYnugRRdDZKL6gnOQCTxl23UNqXUVrNkKNN6CDtnMvvqfl?=
 =?us-ascii?Q?YPPVK47/hOhrnnCV2APhakAD3yEnco6jW+GZXHfydlEtDCknEAjHaMYQOKk2?=
 =?us-ascii?Q?5fhFUyX1UHRdyJyBA3bY+KfigcXHALijMfiGgmKLKJM/EZbMruRHmHu/ltN8?=
 =?us-ascii?Q?LKZhSXRQ2fbjDYHm3+MGI3lFHDlj1djeS02aTHELaEWBZoOZ4Tumy8ak5cV6?=
 =?us-ascii?Q?pvdRNdfmGaTbkn7bBh/8XWsu8d6CyAbnduwwRAqoPHsfSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MCdC1B5PQrjeleI7y0jckqqbkzlYlQkuW+5g8YsvlbxsLBALYvg2HpZXUzsK?=
 =?us-ascii?Q?8+CneFb3LR0anitBjBjKHQq7j7v9hr0Me6fjzTWyBa97X4h6tKWEDkEHr77Y?=
 =?us-ascii?Q?L9RXLVS0pvkxFxBdfmpYqd3hPhxWpI5G8sAuJOQXPdqoPmkPr6kERo6+lfs1?=
 =?us-ascii?Q?HO/es70zwEKUUcvNbUYgTMVd4YioholXcF+vqkD/uBsJlTLhBRnHcusybakh?=
 =?us-ascii?Q?jFu4tKVeTrPLP1ovgamzFdcRzrFaTuYVB7VhFaxLfyNyDFxSGALkYahzquzr?=
 =?us-ascii?Q?6fP9QSQ+YHhLw9Qq3s19lb/UQz4BQccdo0hgcYUFuQBtzuMjo+XTRtiJZ99r?=
 =?us-ascii?Q?A9ocJLWMiKetCdqnFn6JZ1jJcNiqdjvWEAqEGjJIdk2HJYZo1mI27+CsnCa2?=
 =?us-ascii?Q?/iuvQ4k0BoMVT/EmLjW2exswP9ufvX5rAK7asGqoFRc9ORC1+r6ODwDWykAS?=
 =?us-ascii?Q?v5M5ZiZopV2v85MLoYaLzp94OIMs7k0QW0ZyxKQNNKWz0EmFAAAM03W/62Zs?=
 =?us-ascii?Q?aISHGedOvkiApKyemnx2jWn0hjqWUjbCeQvCztNJsk+En9FnDp0kPAGQ6sdc?=
 =?us-ascii?Q?RqeUrAJBTq9GiRPjjFE+3JB6DzKRWqKKxH5qVpjpzS/Hw3Bq9er9IjuJQSvQ?=
 =?us-ascii?Q?YPaTqbEeUMI3Vo91Ua8GqueOy2GCjme304kiMYC/D6XmTf7C3TrAKEkYW4Ig?=
 =?us-ascii?Q?cgnQ4JMkbjB++qlEfC4hOaVKtX3ArOUQeWxY89TdZov1tqvTBdz96SwhqFyr?=
 =?us-ascii?Q?LNQrB7tXl6DjWc3nzM30rrckEjRS+nD5UhukeJl3vjgxsKg8sbvRQaUoM865?=
 =?us-ascii?Q?a1Yp2sKzI6TWNHIAGu4tSJasjlr7L1AyAgSHIj4TfNZFx54WmVHUaY04x+k3?=
 =?us-ascii?Q?FtWlCaViaStpKWXHbn4YNXz/+vlDhrwE6ky3OowzEzBB4dW4IFaGAejvv4gW?=
 =?us-ascii?Q?kEfA4NhjKv5MfZFl4pZwxw0xpTodiamMe9YQuEhCWGZNbtq0ng6OPP7ovdZD?=
 =?us-ascii?Q?P3nfoqv4NPxu+MfIZ57UQgtKv5BO9Ad1e/9O0VeXdrOp3wexs6cxYns4fAuH?=
 =?us-ascii?Q?dRkUC2u3smeXEmY+9AMy02S+XY4i58mgFyCdDJQPaBk4b4aURAKYt1NN9PgN?=
 =?us-ascii?Q?8vm7Qjj23HMJQyqie3OiwJXVwzVOxHsbRxTklcJQ98LIpCuT6UFW12ztNdQ1?=
 =?us-ascii?Q?WQP6xciq8JDAIAI3CgxONgibZYXi7uzSiXKUxzzPfB69jOPKQNnOKaLIzxs9?=
 =?us-ascii?Q?K8BAukSb6bPLo3nmypX0/X81ubKr4PiNJWAfuvfNQQFm4cwu/7iEni7JMthw?=
 =?us-ascii?Q?AkXVIoZRkajHC89pAhInycYr8ODCs/HdgCQ/867N0E60qMaeE6FSrQBwLw8E?=
 =?us-ascii?Q?XVF8hOrJMpWAWLQsM/2YWYzPAsAeIHWkALnb98FTtxTsFnPXW390Ncjc7GPz?=
 =?us-ascii?Q?J/6BjKUClgdLTZCgwqFrVuxJ6ubfkj3yjf/C6CY2BItSCeOJ21DDZgK8oqIH?=
 =?us-ascii?Q?zjmO3A4eeREN1nMxgNaaTd+dQ+WisVs6J0WS70OU2erCRAq4V0SPHpWYlKZG?=
 =?us-ascii?Q?/DjvMGcGLKipwBSX4iU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2ce6e-3be1-4bf9-911a-08dc63cf8f44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:57:09.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZE2iZmU5m02DqKsAokM+PGDdsovzyHjsWCucO+LPJS8/os30IobokzQ5FZqDdwXmZsyNzd74JihAo1fmouk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

On Tue, Apr 23, 2024 at 08:19:06PM +0300, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++-----------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 917c69edee1d..d620f1e1a43c 100644
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
> @@ -107,7 +106,7 @@ struct imx6_pcie_drvdata {
>  
>  struct imx6_pcie {
>  	struct dw_pcie		*pci;
> -	int			reset_gpio;
> +	struct gpio_desc	*reset_gpiod;
>  	bool			gpio_active_high;
>  	bool			link_is_up;
>  	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> @@ -721,9 +720,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio))
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					imx6_pcie->gpio_active_high);
> +	gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpiod,
> +				     imx6_pcie->gpio_active_high);
>  }
>  
>  static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> @@ -771,10 +769,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +	if (imx6_pcie->reset_gpiod) {
>  		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					!imx6_pcie->gpio_active_high);
> +		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpiod,
> +					     !imx6_pcie->gpio_active_high);
>  		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
>  		msleep(100);
>  	}
> @@ -1285,22 +1283,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pci->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
>  	imx6_pcie->gpio_active_high = of_property_read_bool(node,
>  						"reset-gpio-active-high");
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
> +	imx6_pcie->reset_gpiod =
> +		devm_gpiod_get_optional(dev, "reset",
> +			imx6_pcie->gpio_active_high ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> +	if (IS_ERR(imx6_pcie->reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
> +				     "unable to get reset gpio\n");

Small problem here. err message "unable to get reset gpio\n" will print
when -EPROBE_DEFER happen. EPROBE_DEFER is quite common when use i2c
expand gpio chip.

Frank

> +	gpiod_set_consumer_name(imx6_pcie->reset_gpiod, "PCIe reset");
>  
>  	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
>  		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

