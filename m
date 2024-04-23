Return-Path: <linux-pci+bounces-6594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDB8AF7DA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 22:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F686B2192B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5012142640;
	Tue, 23 Apr 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O9JKKnWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161195B1E3;
	Tue, 23 Apr 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903414; cv=fail; b=DGHB/Udzjw7o77mWXFSoBIYQhQ2RPy2HLh6WecDjsfqcI3/ioNN9FdE1PrceW7bjEKVdnj2qj3Z4qKJdsYvC8wC0NaS9tapEUsQHjLLULRmrLOAK+Odl581ZhzVSuWeRxQ+Nl4bap8WCaD6rGuEx/fNvLNgzsOEVALEZRjF4kGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903414; c=relaxed/simple;
	bh=9PmmtD9YJbEL+dITXOLmTurSZ8XS1LaPk9bqvwgs8+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M9VPXoeCZSVv09tCW0EKroX5o7LZ7hPlRPQJSlAGn0sZXrLRm+TLIc60KpOI8EZisykkgEaQYj2TvYwRMiYWg3a3ezuHZWA1TWHaIYU5OxHJsP1iEdSzD3YwM78MUU1QU+EfjX1BHUzfcMpflC2/asYa6XsD8RxQV8n4Ju2F8Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O9JKKnWQ; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro8jA9zWLUUI7LhVBIBHnV8qvuae3K9Z/WCr/rmcHt/ddfdDsONKq8TD2c8upmEeVaBRIM49GU0Odj1zAQEVCIGrR/WP3u7p9mXDU7+YGnhM9LS+QWISnV0aFhvBdpxmAbC0cPu0ThdRsUJx+gQqS00hL99VEP3ObSOSaKmqwtwU6fdnRG0NFd6QLfsHeV9hnwrYjGUicodp/xgTfK/lQjsnpx+KIJH0yIbFUS1GOfOEvOV11yJfXF/7gFYZqKNmfJpCTy76cylQiW3+N6q/Nk71oI+TZQyjPYXyaflfvrgGDavfxOXhf2sGKKLhkVbbi8+S3O0sMjGCIA1DDQCjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7QyoMIElxsbh8Zl5Q274z9fuaJ92JlGX+NXewDMV1w=;
 b=iYAzh6rjAp8uOhpnFLSlps8n/4AInKCPhGtcfQnYvDlGegtueoJ8iajnmBwRGzW1AN3f3gSjHrfJK1WEhLFmJXMyrnDKXlNTjzEIBAHnKTbKN4NBZcCekR1N8iWyZ5i/2Kc+3f24JgvucLTYP1CQS3i5HVWWkkj3x9+OpR3K4gnTgXnUZgnJdjRE5Bg0ugzGrEEXtKjANY17JMYDObmSbeFI26ZqmmaAucAp6/LG5tP0tz0kMvCevo6bduypXnWbLKItlZDpIBjQYOWayHR0ttbo70jnm6CqS0F8yuhPNleFxHBSVju1dDQtaUQlr7Oh9HZ1fpyuzKKA/8CB6wCjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7QyoMIElxsbh8Zl5Q274z9fuaJ92JlGX+NXewDMV1w=;
 b=O9JKKnWQbtnRkF8GWqpS4zlAPkHijqzFZgQoovEyG+84j2qiJbcs+25niOkfX8FfmnHT0hASL83vQ63uXx0bi2G5xEQpmCLf/w3cRPmFo3Af4HikLTkLVujwX9+PZimGZLe0DNN/EeM+rbBj+/+3dWh/Z/gbLXQ08icn9JjVDlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 20:16:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 20:16:49 +0000
Date: Tue, 23 Apr 2024 16:16:36 -0400
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
Message-ID: <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
 <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
 <ZigUL7exXBSbWDIR@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZigUL7exXBSbWDIR@smile.fi.intel.com>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: fda70e91-29bc-438c-668c-08dc63d24e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63f5h6wHyXRAaiExdrEt+EyjQrEDAi4xXVCJ9xeXOVni4V3iWFmSLM+cVecu?=
 =?us-ascii?Q?isu8Ufdkw5NXsh7J5M7qzuGupnzKS9iAqNZhifLNc2nQyRTfgT/0mzlsMJEc?=
 =?us-ascii?Q?GD8VdAH5fo7ZRcksvoOKYisEiAI+f/LnlGJIpXvPTWU4zOkcJvYBI7iI8ovo?=
 =?us-ascii?Q?XJWwNLyzo8CSpeJfaUkWRSCzzk8OIXL15Z5cdIamU4OfkYnNJPXFQDtGmdfE?=
 =?us-ascii?Q?N6nyI61C3WbZIWMbbKVmmBhugs/DWoBf45gH4mWzPMITF9JvE/CqPNsrlfjK?=
 =?us-ascii?Q?oGGvajTLDHWxfhMnut/bfyJlY6Ra+LdAPWM9pXy8XDjMKwtSDHfDqpYqNqRk?=
 =?us-ascii?Q?CHKwNuYbs1FfkucqGUZJHen0Ig7rNOE88wWXd91o9M2JsRtHioolUMu6+rsE?=
 =?us-ascii?Q?YBlsS141VZNzee1Xb3/gLCcYt6YJtwFUMrWKyyIv7x10fdfJrDUgdGt/kRhk?=
 =?us-ascii?Q?Yu7L9Xku7LDljQ3wMdq2e9kOwQv/iucv4w2jBY+o+xArMTtAwNigq6zRS3oE?=
 =?us-ascii?Q?abTEADQuhqksXBXWJdIzgk2YcBhyiiRrMoZxU3tIEH7P1kSrLleOXmIEMXu8?=
 =?us-ascii?Q?9BxEmLk5HRHjCZlS3qRHHqerYwYRmC0IrGg1SIFPRXVN7/VIJmyjnsNHYORY?=
 =?us-ascii?Q?Pnq5Vm3iBpP20VYO6f6xlzwQUVfrS3sKpo+shfP5Ghu6qPR5lVlUm7nSY2vH?=
 =?us-ascii?Q?eGoyepLacpTG4QAfmB1PeExDV+TB0DYBzmfAu0gB21JfVTm0aVQ9uOxgSwOG?=
 =?us-ascii?Q?DkeQ6LRgqqDd74aEf8SeVh6W8gMUFK4wbeUAszHMF/MDZ3ivcWm3eKpcOqTT?=
 =?us-ascii?Q?u1yN8CINJCAQ1UbzoO/7fLOh7j8fgfpJ9geQ9MiHT+DajlddiJ3AlHdhrJfK?=
 =?us-ascii?Q?OUfWkld68ETXOJA0E+KKwpMu0cnwCZywbU7LQIOGAIA9psyrYQq1Pnqox5/M?=
 =?us-ascii?Q?eFZJm7t2SyiGq8w1VgTH6oNwS6EKdkfUGxG0ZMd7UQ9GBiMCIR5VLASd1MFq?=
 =?us-ascii?Q?acE6UVL5cyftCeR4KzNiAjOt9P56z+sDuxfAF+PkNRcIeISK5UCoT4oyoHpA?=
 =?us-ascii?Q?Si6/Szym0wjl8pFuG2FEh8FYXnDLK1FmX2LGsamXSZoIk18j88CdJZm+PaNx?=
 =?us-ascii?Q?WBpbF3d7TCpXFb+HbY2hakQXVJYdDqwR6OyfyGJ5IHU442b9OpxqYDPHXnqb?=
 =?us-ascii?Q?FEsH72eGdH9fqTTt+xhiOy0w7eXrMkmlhJHEomevsNY7i1IxRSU6xu1GwOD+?=
 =?us-ascii?Q?Oi2YadCQXal2NpwWDfsh9KIalmSDk6DQNLG0dqGrspMKd19WRqdOCTug8Zwn?=
 =?us-ascii?Q?70QZ9sAYSt4lT3bS/QZuy2e6dWn13jnrZx7fhAEtn0myUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/alq3jYTDmY662v9+Ke6OpyP4VqoAEAV2I9uUyv0nCCDpBOuGbX38MLZBdZ?=
 =?us-ascii?Q?aw6jg4OSDMr0y//Ulu9zWJ9+W+gbOl4E2r7r5fGYR+zQcBh9koGGoKItiNDd?=
 =?us-ascii?Q?VQxEfcl1lVOzzQqml5l/bP70ZQ/6EXTILatrU6N2Jh5KFkSG/V4051N+Gafa?=
 =?us-ascii?Q?VmGoQWZxQheopGglNf8VhE7evbxoo00B5yG1yMybNxlPtNMQ9gVuzePl7xUy?=
 =?us-ascii?Q?bqZyt1spuaA+gMO+JbwgqQ5inYogOv6xIMKv43TZ05AAyy7YWe39mNGdXHgk?=
 =?us-ascii?Q?AYtSABAgB2jTTbpCzpl5n3tN2gIsoYZUYAiWh6LE5au07C5XE14c6z6Lb+Bk?=
 =?us-ascii?Q?YSxiDjhe+lauqABn6um914RRuZnEHQor4/Hn0ZMUwh9mAKe3mvwBqTyZepy4?=
 =?us-ascii?Q?F0cifpbtGarP1vzY2MVbsCYY4P82qodzZLtvNvU7waglvrrT6CusxylCD35r?=
 =?us-ascii?Q?b2cljfAns90hNefY5clBGpB7xV+SrfDshI3XGpsG1FTLW+JHJcgmoDF1U8Uc?=
 =?us-ascii?Q?f5tOKfe13Pd4w/cA4y/Pi8AJJQTCakPbcIiyOMADqdsDZKhLG7MPPgsmk8Md?=
 =?us-ascii?Q?LFSW83Dy8f7xJ2Q6QSJM3iYajs8V2lbLzOh5Mn/PWlKfaHkP/u9drBAtEBTG?=
 =?us-ascii?Q?KvK4MiA4K+3Mw6oF9v2Vq0rgV23ZuuJE0CiHVcmGFq1h1fV8fMTvw0OLyLoe?=
 =?us-ascii?Q?5YsrlLSpDvGWsFyTrgaNxQ+oZPucWSn2ny/TMeQqKuHD4LZEhPTiQsq0gEq8?=
 =?us-ascii?Q?Xklas0kmLtxJcpMgOZ3CEFSejwZM2LNaeD14GWcVSWCnVz60BoqCpTdxGThi?=
 =?us-ascii?Q?KpNJep+K9w+uPrzpZXZ/n/MuV8goqUbOS9LNuy2sCKBv81UhSBYkOmYQ7lwD?=
 =?us-ascii?Q?FAiWA/zUWMSAdcmlFCrguCZ7dKZUHTSTu2bkVEXQiAJkF92kueQ2d2bvvB4a?=
 =?us-ascii?Q?v0CqXttQoBnMVMJKg3u5ONpOmRiNzZItt0Lse11r4S6krAP83v2niNFybF8G?=
 =?us-ascii?Q?bMMBs8JVoPW1SJwA/YABPFi74OA/UO+q+IjM2rmkdvsza4enzx/xFHvm+Yor?=
 =?us-ascii?Q?LKO7eyvwHgN65pJPPMbZtlQ/mYKiuzCKovj7cspsnoEkbTps6Eh6uvaROyNN?=
 =?us-ascii?Q?IokaqAyE8EDkRS5FLFillw/qkhEALC6bdk+CbaIPHAxiOs0rgyZwn36fo/iG?=
 =?us-ascii?Q?OLz/ivMblicuNoUbHy2ABAO8NQEXJXykSP7iLQ4NtkGZMaMYHeCbWwCsDKDo?=
 =?us-ascii?Q?VgCNjukgghMMeCOcimaBcA38ZESXIRJamvxHJIB1yLfzQ5TXqbEja/It64Ka?=
 =?us-ascii?Q?Jt0G+tLwsQg2ZvxULWCveyl7XCXEGRCYPZgTslH+pZ8N1mQF15EnJOHFWdlr?=
 =?us-ascii?Q?Qy9ne9+wEfaC/6KOcR1W4bb0SkkggwPpzErI680Lo6gtTc05K6HF4Zs9eNHA?=
 =?us-ascii?Q?QVLPDiGS6YxpnXjgalH79KIn4IAgH8i1YU8QHzkjI9Ms1ytLfW56ooC1WVOU?=
 =?us-ascii?Q?HXWeLY6a6J0Bn0E8tgc7MJTrK6t65hPfrmUGbX0pLOCBMckv0WMftkoFuZFH?=
 =?us-ascii?Q?f6uGZfzmKb9n/h1/8GfeM9cGZEkbVOHX4pluVhXt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda70e91-29bc-438c-668c-08dc63d24e62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 20:16:48.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+l9MjkGn/knoIHUprvkIyAW0InSfQc4WoDdbEIrhB4VRfHZhbE4C2j54VxCU1BxRSnNqFv1cykZUndLCAdrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615

On Tue, Apr 23, 2024 at 11:03:59PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 03:56:56PM -0400, Frank Li wrote:
> > On Tue, Apr 23, 2024 at 08:19:06PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > +	imx6_pcie->reset_gpiod =
> > > +		devm_gpiod_get_optional(dev, "reset",
> > > +			imx6_pcie->gpio_active_high ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > > +	if (IS_ERR(imx6_pcie->reset_gpiod))
> > > +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
> > > +				     "unable to get reset gpio\n");
> > 
> > Small problem here. err message "unable to get reset gpio\n" will print
> > when -EPROBE_DEFER happen. EPROBE_DEFER is quite common when use i2c
> > expand gpio chip.
> 
> I'm not sure how you come to this conclusion. Can you elaborate, please?
> P.S> I do not see a problem as described.

If i2c gpio-expander driver have not load when imx6_pcie probe, I supposed
devm_gpiod_get_optional() will return -EPROBE_DEFER, 

if (IS_ERR(imx6_pcie->reset_gpiod)) should be true. then dev_err_probe()
will run and print "unable to get reset gpio\n" with error code
-EPROBE_DEFER.

driver framework will retry imx6_pcie probe again when a new device appear.
it may retry sevial times utill i2c gpio-expander driver probe success or
timeout.

Frank

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

