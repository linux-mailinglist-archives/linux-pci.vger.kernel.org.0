Return-Path: <linux-pci+bounces-6596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC078AF7F1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 22:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430991C2298E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFE142658;
	Tue, 23 Apr 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yt3hXkHe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AF1422D4;
	Tue, 23 Apr 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903823; cv=fail; b=mxaAnATLZJB5haXJD31kykO/mVLpZysvrvjtpjhL/sq6z+v3f/I6P8yOViVwE8mEA1b1/8BaQU0oMNkyHTTIhlmqXQpKCdRNxtCsM3FPvjCVqnqyw8sBQLDwhyfghqIM2pU96001/GXmqN36W70txMeRQUsbBgVjLge9QREjWAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903823; c=relaxed/simple;
	bh=an/TOhL7pUB+lrpojGg9hnMakXSMAoH/2NFRqr5loLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMO0GDFsdto996tv1cbXp4tPBRnLRLLnjuYDsmOxqK7f6HN6za2XfFmB2ynG22X3IuV6yhSixkqeyL1/L5Mw7UUNa73PiQjl3AY+c4/XvOnyFzRf1qX/yxKAy8VwtFMUtC2Zqg12LdVTxFepHoeicsyRInCjtB7+mz9bZ92STBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yt3hXkHe; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la4cMJVwnN9PppJFaYEy089LlDDTdD5sXHWUN0ghzsTt60fWmLPH3nWkSm7wbKaDpf/gum9PUGMtzPP6Zj7onC8L+F/LD2I6d+lTs2UN+WfLui2p7sIuG2wuwvUfukT4W/+Dy2vfdqW/0gfut6Bu6J1RigMx4moPY9ceJArmek8PYPYERKHP7FwV5FQXzOQRh4v0o41XW4zjmbvlreYRoxd0Unp4dtk00frzJLL5bfo/3hk5c+BT/3pGhIAij0mj8CN6ZtrGHMd1irtx6vcZuEuRYfJwocppq69MJzlRasFAPAGR7o7g7SL9tMAbhLVClUp9VDBLUi9dWO49HWtmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a+Js7elHfVkkwA5LmfROcELMrGjeCLb2qiC5suCJTY=;
 b=jxIjdmy/HqMH0wyjGnjIA3zh8M33qStMjscm6mL+pCLvC26tirRRuoHbI8ECQJm4isn+VIEv+ww7Zc2gO6K3k0Cib/innRa8bxGSlrKxeUrxNDemT0dUXktiCJa0FAzaLnywgU32CiQ/C2vyovS0GktbAne4iCDI4LZilJo9nHKMGTTSXCA3ypQUme3vVS/D7MqDjM0wBKRvr+j5q9px7xQjJIaYaI+4/LiwNDXfqEh9zmp1u78GdeJxUwtpBBSOTSo2mv8knR0j5J2fV50FLnu/UGiM4ay09ZWS0WgOkkc6clgaYPzjIxI0g9KYu22jBWCMtnhLL/QvXE2jxrIi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a+Js7elHfVkkwA5LmfROcELMrGjeCLb2qiC5suCJTY=;
 b=Yt3hXkHeuvv/4tHMGEgGIln1dWSH/1npmXCJcS6F5YIi/GcUWx+g2lyr7XFzAZLGIjWg7kSIMW39mj5Vv1yFw5i7QVLef1H04FTKgTXHyQDqhLOk9EfxjCL0OfJJv7PSKEDdAK2EzYw6AEFzAduQA/G1YnveHOS9p/Qi3vZb4QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10169.eurprd04.prod.outlook.com (2603:10a6:102:465::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 23 Apr
 2024 20:23:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 20:23:18 +0000
Date: Tue, 23 Apr 2024 16:23:06 -0400
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
Message-ID: <ZigYqtyn4BTbWgRu@lizhi-Precision-Tower-5810>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
 <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
 <ZigUL7exXBSbWDIR@smile.fi.intel.com>
 <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10169:EE_
X-MS-Office365-Filtering-Correlation-Id: b64f75f9-a092-45f4-26f5-08dc63d3367b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yiShEKiyqqkUtcMv+qMciDg7kemd2oIZTMPYmmHG1/rtYkAoNqc0fF4IiIv?=
 =?us-ascii?Q?dmi1P0/gJpe/SMNK/vDn+oYFbgBZHmf3/oHdKD2rJx7piGtR2JYzqamvZWzT?=
 =?us-ascii?Q?D4NxIW6YsB4qRup09Gwv5ofRTjcCxqrb/1EUk3VSAgFCzVRzPShEoL8KOX/h?=
 =?us-ascii?Q?nWPxbmonhdMCiADLflBCBezX2LJJYxK7SvsbASDCjQirHGy6VdVuEVhxx8aV?=
 =?us-ascii?Q?sst7KjV8Vp5rtF/cG61j1SiLEL5gvoghhcRxhBXw05kSoJlhV1/DB28W/wtG?=
 =?us-ascii?Q?0YlmjNO5jw+o0764YtBGfGedGvdmK2/EiXR9IndqQJ9qv44BKxVuj53aRCZd?=
 =?us-ascii?Q?MHjbj+gc6wsRCLv7ZrvyB/ADRVABVi8lK0eiF6sSRui+BgbcvKDZh8tPt4Q1?=
 =?us-ascii?Q?GtZS7i5xQnw+EYMbWnYVcrsrIjBy3Fj8i0bN/3mQ6gFA80tFMlHx6b8iTtMI?=
 =?us-ascii?Q?PFEKBPTmw9G+hGZ8ZphAjJ0gb5yoeIAh8EATLiJQVqPPQsTL+sK3WdOH8Wrd?=
 =?us-ascii?Q?mB5k+xR0eycqHYllk/Hwe1juu/8U2w+dPKGh7/e6dEZsvSi1CiDjspShNWn6?=
 =?us-ascii?Q?Bh6bgRVipA5r6jZcmxvgq0Aptx63ceq1H9H78GVtxxxjif0NOqyp+oAtd1Rk?=
 =?us-ascii?Q?5YgrtuP8c7n5mu69Z/4UpphfLdhQyecZxQ9SSx9jCgfsk73CpGOjxCi4pmJX?=
 =?us-ascii?Q?dKbQaU78F4YXO3CYgy4vxNmOTcaPNPLVjo/+N92p3NIMhxB4UbKO1MLd+8jE?=
 =?us-ascii?Q?SDEGyrcHql7+bzWrBA0F0DiWZaigzEM8W3xOTCVV+4VPiFlZ0xR2PokaNx10?=
 =?us-ascii?Q?xxFKwIC3EUFdUKamLzSuK18IIQEYhkfKGnrNLE/9f3bkuXoQFuyQY3MTQbGa?=
 =?us-ascii?Q?fh+Y4JT7jhbl6xYHBOWbKWXhchUqIlsTdHsY9P/IB9cKSXTD4olNZNWjkD0T?=
 =?us-ascii?Q?I1AALPtSxp9cAccALWE6boR40KCzFObq7+odh6s/k7t1AqQukgqXfq1bFKDv?=
 =?us-ascii?Q?2dKDaFpBEsgaT+JGk9dhzr1mKGnc0reQ5LR9y44xXV3Ffn1IDQnsCBv/WlwR?=
 =?us-ascii?Q?oAyj5wmv6G5EqbE04CAhpKdFs9ejflZKCYcyEtgEqjYejNex6voNrOXkurUg?=
 =?us-ascii?Q?6xSEOlkL99KG/jUvqZvqP5yOJsNhLXcGz4rc0FSwHcW8gWurSTdBHmtTefg0?=
 =?us-ascii?Q?mvKJh8hA0nVeVLA6xvgqcidkfni7pxD1BXkvYbzVHflatfkL908Y7ClW+A8e?=
 =?us-ascii?Q?tTzLea4ggngFLiO8KvRR7KZTK/8w3vlp+nsRSnSpYG4nazJtQSQKlror5ByY?=
 =?us-ascii?Q?9ZB56ypBDy413lA6IDyk9iL6zwRwssiSxlnQCAhZ8hgcCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3T4Wpt/g/Y5f1wZ25LCK8fqTUkl/jJt+frZcf/rKPvIC+wWisSPVKrW+Pg6?=
 =?us-ascii?Q?DnfhsZJUSp7vJr0mYjE8aTLVnnLdeq9m+UhczihiIG8Nciqj5eaWoJYKdQnw?=
 =?us-ascii?Q?4wNLcCWxe0Wn1aR7K3mAEX0dchVImAC2cMq/cLTfywYuPqmERe1r/s0dQ3mt?=
 =?us-ascii?Q?V2WTlWi9V4tiW7UGqWeExjO6ojTW6pMFybUvxK29wYn9iRGKZ9nMB1XW6FHK?=
 =?us-ascii?Q?BMo+28ku+7MDtOlUIPlLVmzIfBBKehpPdeYmXR9JQp/crZSgbXs3Tsvoaj3m?=
 =?us-ascii?Q?ZoIhcEiFRILEeuh5tnJpdX5gZLbEusLqit/QuQ+mE8KxRlELgRMIRFavjgt9?=
 =?us-ascii?Q?bb02zTbi7SQFIoQmBPQKZZ73gYO8t243XpHIMol7NN/3Qb05CjiawAjpZWaz?=
 =?us-ascii?Q?f2uwEgTePgeU3XFtGo5QyAwAqwZ+Pn6d3xpRGAkKhhwHxjoHqcQUoGz0EYK6?=
 =?us-ascii?Q?H8AlzPOmNtfR6L89m6ttGciUmtZPcd5vDiIV8SPojZmwvu/DyIgK5P9FZWGy?=
 =?us-ascii?Q?PNSSumTyOFtBZWebIE2BHvFNxD0SWXePlZ/S0QsqQAHnIf5dwUKUy6qIw2uT?=
 =?us-ascii?Q?OqEIgF+9r3/ofCEZ4zYI/7nidZdL8kRbBuh1Y1sNwLt8LuMumU+DlQFAmN0/?=
 =?us-ascii?Q?y8PpgRFWE7WBulBbFx3WdP027yIwn5sFx+ZlF4+TUxZUe6T/79OKPpZ2FgTT?=
 =?us-ascii?Q?7hRWoaqe2EEPpmVEytpJ8y3Gu224lRhWxmRU/7x2XHUwpIvAeNvrHzQjmypM?=
 =?us-ascii?Q?Zm0t+/MQZgEjTRPs81FlDKyJ4RqDRS2ipYujlisq5qWOPBQpmzsKJCqCRyaY?=
 =?us-ascii?Q?2dDYQM+SoyHbTJ+mTc5Q0w1tGZYlE/oNBhC2ZTSprbWkvfqc1G+JxYpF4hs/?=
 =?us-ascii?Q?x75q6tPQBCUPgs9YcEJn645PDzBkSCuFJGqnBjM7+jUCdPDe0+yaf0JTswS1?=
 =?us-ascii?Q?mJQxEaKYkg6r3XCI1C4Rg4cNE+rKb8PcPT4tNkxAE8s76YWGJPPr6LMMN61+?=
 =?us-ascii?Q?rYxql4wGejH/FlMkc83JzMbjzdW6rK04p344iOaUfnGSNWfV5FEAhEsGAOau?=
 =?us-ascii?Q?CH5IATTVeBQHkriNI41I7HkyzFpa6l6oIgZsZCmBoTWQXDkyyP8s/fiUMRle?=
 =?us-ascii?Q?9/3Dy24S7p12XGZV6HAM5lP6l2Pyt54azsduy3Zt/2UDR66rFCAcfos9TO6+?=
 =?us-ascii?Q?C5Q90Bjrdd5vDT8EPbk49b4n6n3lNRkpGmOUtXJB4Z7VMK4jhcrUbk1Rfsfa?=
 =?us-ascii?Q?stAQGshZLdwarLYTa4m3zlanUmUeDaUFtKY2r/XGQCaC2gUwpRorKAm20Zka?=
 =?us-ascii?Q?UWc65MclVOiD8yi6DVag9Ps3gab4lPpzDFBab853L7BraKUJm06NjHuIKVWy?=
 =?us-ascii?Q?szQgQf9KvHdqApuGK7vSsuXtnEYp4fAHfxdFASVfR/HvfYdJAVdhAfKRX+HC?=
 =?us-ascii?Q?jERadBedpndCTNaeLijLh7/jflfGZ7Husg7EjLk3u1hZOv8aBGfp5ctfS4eC?=
 =?us-ascii?Q?eKsS+9Krm9hIlMkUkj4B0oZzbg8eNRnMZ8Kn094acVheU6E+UzW0OnABE4M2?=
 =?us-ascii?Q?yoVRNR0M9J68JEuj1DRCr6NLYYv1/iUoRJFiR2+Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f75f9-a092-45f4-26f5-08dc63d3367b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 20:23:18.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTx85ekG1/Rq6NQFinYUq8AUqIOVahBwkxIH9KZq1gz4DunP1A9QcR65w3bi1iKmBJqaBdoB/bhDgKhyp04Stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10169

On Tue, Apr 23, 2024 at 04:16:36PM -0400, Frank Li wrote:
> On Tue, Apr 23, 2024 at 11:03:59PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 03:56:56PM -0400, Frank Li wrote:
> > > On Tue, Apr 23, 2024 at 08:19:06PM +0300, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > > +	imx6_pcie->reset_gpiod =
> > > > +		devm_gpiod_get_optional(dev, "reset",
> > > > +			imx6_pcie->gpio_active_high ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > > > +	if (IS_ERR(imx6_pcie->reset_gpiod))
> > > > +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
> > > > +				     "unable to get reset gpio\n");
> > > 
> > > Small problem here. err message "unable to get reset gpio\n" will print
> > > when -EPROBE_DEFER happen. EPROBE_DEFER is quite common when use i2c
> > > expand gpio chip.
> > 
> > I'm not sure how you come to this conclusion. Can you elaborate, please?
> > P.S> I do not see a problem as described.
> 
> If i2c gpio-expander driver have not load when imx6_pcie probe, I supposed
> devm_gpiod_get_optional() will return -EPROBE_DEFER, 
> 
> if (IS_ERR(imx6_pcie->reset_gpiod)) should be true. then dev_err_probe()
> will run and print "unable to get reset gpio\n" with error code
> -EPROBE_DEFER.

Sorry for that. dev_err_probe() already consider this. Please forget my
comments.

dev_err_probe() 
{
	if (err != -EPROBE_DEFER) {
		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	}
}

So:

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> driver framework will retry imx6_pcie probe again when a new device appear.
> it may retry sevial times utill i2c gpio-expander driver probe success or
> timeout.
> 
> Frank
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 

