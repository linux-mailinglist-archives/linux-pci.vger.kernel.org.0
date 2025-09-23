Return-Path: <linux-pci+bounces-36805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80140B97679
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B61B22186
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2D305E3A;
	Tue, 23 Sep 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSxFfaBX"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE213303A2A;
	Tue, 23 Sep 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656853; cv=fail; b=Z3zneHTPi91AMc8hJUlRZOwyurHt9cZTE9+zKi3mabqVU9yyVIoxBI2dj802+G40uwL831jWh9EZQjse58mhmvTv0Sd0AZFiGNrTqWnSQ7HtbLClSvSG6r3XfD4mm13Sw7jMAavtPKCvD79xHas0U0wMEnQ3wqOD7bsxZs6wjOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656853; c=relaxed/simple;
	bh=yEm8wcoZDoPx22rq0Pselif3ENrLNSDxuIMUqkbh/YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ds8brcTe5gB4bIPhqFxp9A60KEXk0e/K7lnjs0/WAk9M1EbtVb8nA2zU4uP/J4SSe8316F/onFHayIXFGxFRvLGQVhChmWaxUdak98xUiEYwgYIdZRMFe2nZo12fPvDUl2w4Wujn4cgzEf0YHpERabVAqpXcuVG8oxYXoDylgh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bSxFfaBX; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUevHH6K5Ze+ecOF9158xxt6elvsDP8JxG8HIarQrnRSeKoZpmlCX22LR+S/vc8+UIvUPQE8LYzzKluIHZzcbHFf9LiQJTK5K41Qj6BJCkqJZxalL7MRgl2V0/vyLxFye2M1+uTMk1DDMPUXF5eeUNmgoyXCvtVxVrJb9ifi/WFQZxL0sK8tYDMXsf09jskhfhRxdY6WulYDoW5QXVyxJ2R5qH6Tc9JvDKgCxIYueBs4xgNBqmsk/XPZMomc7q8wGUqejZDXv+FigRGngBcQ5aQJL3BmbRi6nm4N1Zwrgf+R9GbQxOG0jaF8P2LqIrog/AUs4wsbjjlZZMI4bFm0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lucVpkL6HYRi3VBB/xPXa0OmszIrosyw4hgA0/zekBk=;
 b=xJfw4WUeQHXFe/fD/jpON9YB+x8vXg9zwU5bLrU55DoMdFcsCzFuY/293nT8ZbqsTVuQCeGACw3Q3uqARR/fhF5+aqaQXY0ZeGVy3Y0YsfC6vW5P2hQwGUjo01W7zNPo3LfFs3neX8FUfoagcddNrCsQQAdyEa+Z8hlMV9IgLyfykIjbeloJmIWHYY1Nfg5sCEV9HsnTgCAyVpbBt0CGukwMnWwtB/KCUiG6hWsi+14BvoL4uxsUMQQKwqM1HzdpmmiPokIvmbbmp9v2yLW5DM9upDYpVxIzfbQvDDeW5rwBY2MDBhvfmNtZ/Dd47xg8qpWoIwYYjfaE7gKtJSnJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lucVpkL6HYRi3VBB/xPXa0OmszIrosyw4hgA0/zekBk=;
 b=bSxFfaBX9RbOvtBFGsHlgGBECBE2hJRAdx3eEIn2SaJSj2uz1v/8K9KKoiJ2h2LEXCKw+YLYoVGLH9ub0pxyGlFl0Bsp7JGAsu4/eN81Z/VfmeS0Io1DxsWlPmqT32oNZMvYZnmhXTciPKhrb/9JMXKwUCx6u7zy8SOtUtZy5Iz3m9bVywal2hjH2fc7ksLwaxH6C31MLp28v4GcwavkiyFMd9RqQNEqC4TKsGcjDqi2MmmfzZDVhmqlyCF/LoC1fr7oa+qS+V2SC1mrga7pgv+b95yseycRt6EofKTnLzMPNePtNV0CgUR4va5Unq2x1n9T/a2Y/hYWMArqcHezaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 19:47:27 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:47:26 +0000
Date: Tue, 23 Sep 2025 15:47:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH v3 2/2] PCI: EIC7700: Add Eswin PCIe host controller
 driver
Message-ID: <aNL5RO77A3PuJMYy@lizhi-Precision-Tower-5810>
References: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
 <20250923121228.1255-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923121228.1255-1-zhangsenchuan@eswincomputing.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 60210087-e33e-4fd4-17c2-08ddfada05f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7m+JwOF3N2GsnwSDnJbJSqaKZi3jCsgQUOSSbbOi8M96R7nuF9f9aF+IIJR?=
 =?us-ascii?Q?kMSiYk0RWX5+ofyTuW2VtQ/nbPrVl8/379OkBINEcpjU3Hf7hXadJEACmIol?=
 =?us-ascii?Q?DQGETSFly1H2azuz1ba/EsHh/Hdws/q/TVZRfzFpGiknp1YAKpyu0Fux6UnT?=
 =?us-ascii?Q?vuEEqfROU4kHQ16dSEj+3TfVKm7MieyEyke4qAuZGui3plBi649Io+hsSZ3U?=
 =?us-ascii?Q?Y35fZuoomkDRQok6U/ijo4RZFIUL++VQv3oIxNcc+Jjl7AnzmAXlK1zgBshm?=
 =?us-ascii?Q?5aCM1kjuVKx9HF9Y32Voh0y+pdCdmb82y9vAQqTlUnE5u6mkb4iplsfa8EMm?=
 =?us-ascii?Q?H+u1tSxH1Zo2JG7bSCb8r7rmNEk8UUAWCRvv1M7vnvb0xtHSZVND9naW3rtS?=
 =?us-ascii?Q?rQhXCjQGbeCQiSRLEFp5chIRbCSABbBGkPuEflwhTp4Ol+TZMobMWazT3K5j?=
 =?us-ascii?Q?tf/qsjfTp/tUithyI6uxLIBDKAq7kk0WBGxt7wqjcc0hOo+GSWt2jarejyH+?=
 =?us-ascii?Q?LbNajAWjGMIgtkF/TvHZcSm5XQm6iL2D3oHmi5Q5D4bxu3m7z2RBCqHVQXh+?=
 =?us-ascii?Q?xe9efRZKayxHSX3MpUi6ML1oIO7GJTQmn8Im4geM46fN4vIYfIrghtfrp/Rf?=
 =?us-ascii?Q?dWvhDAKcpcQ5YgubH0sxt+ETovjpH9VS/sPrnUgTZlxbsJk6AhJl9WRRHJhe?=
 =?us-ascii?Q?MThvoWscXLmWqSrXKhQIqDqWdfnL/dF8NQWk5x6lpoMlPtPE5pmDevjRdHPT?=
 =?us-ascii?Q?8tBJAQ9WJuQT48zZXm9pjIH0PUyUsPpdoQQpL9G9BBqH7bnRVsDdoWN6DKvN?=
 =?us-ascii?Q?8xDtARg+IRolpSgIqE88s3cauId1DrvlUBLGrlJ/yxEfSAbAbvfHsT0CxwTP?=
 =?us-ascii?Q?6mqgjk8CajDDVVEaNpazEHQuaKbS/9OwK9bs8IOSNHFuJA9Dho1SaJh5PGLY?=
 =?us-ascii?Q?5LlERczrP3i6a5VOB6GUAe4O3AhfrO+NnXo8R/LNiN2DQT3nXtdHxviAIz4i?=
 =?us-ascii?Q?/JFSPGPKYCeXyWEW3cczQRA76NBDjy0l6D25UBzL/ngzRVLBIWoYRcI40TWS?=
 =?us-ascii?Q?/knZyXuxkmloM57Wj/Bjaz+4MAVOYtX5SVXwNafInO6UFHpyaTElapAy/U9K?=
 =?us-ascii?Q?dCZojB1kGbZQE8Ve1pVhzzp7Jd1kDpZ8mnhvuegt1NTdXo77E6sIlTWugPKD?=
 =?us-ascii?Q?vYs6lZgwH8hyMfPvcHMO4+P18+M4jPUkXZu9/h9rLYERmU34A+CyYVtkvWKl?=
 =?us-ascii?Q?aEUWc74z2DjvSXY2ipiZdnnNIWXcWHfCygAZhqPXiZ7tjs3uwh9cDUy/BGRq?=
 =?us-ascii?Q?4A6E55ZFUxlqGWrUOs+X1473/kgQWnmtJ5rF0kevoIOFCx8v7Itsgm597S3X?=
 =?us-ascii?Q?uf+//yMTzP/BYZughoH2gxXVhN+Md77S0CkiIBayPyIkcppyH7VOoQ64hz5E?=
 =?us-ascii?Q?N1A2UpkNgrStBeFKz/XxkvK3H4YOCVm+5eEhjUKxg+t+2wf8J+ze0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5bc6GiTf7Xcyb6e7EFUxaHyurKPPGHqezXGzYZSsWrmCdlE4Tf72ch4OYoZ?=
 =?us-ascii?Q?PSD2BC9mvJeCgl0oQg9gRN6MiJ0Ayihf+wQWO8TXvhcHaLEMxi0fe2+w4aQy?=
 =?us-ascii?Q?ALumrJYVCUoP9aPZPFJKP7NBGTfvBZJedvCFNwdlhZsvECiBwjF8SMnUweO7?=
 =?us-ascii?Q?ejuhukQ+cAgF5zRbucZNkZLIYJ1uOMVTHWctkB7ykdDAX5a8Gubxei/ZQCdB?=
 =?us-ascii?Q?jmtTaFqGmIt7tjXHdOwRFErWsXII7/S38C+HMLPX1356DVicphr5jPpcS4Fy?=
 =?us-ascii?Q?GdsQvWz2jU/iIgMbiJquZUNeTc86fDVIHhLRJCrsaCjgdOeC1fUUcZ3gAKSH?=
 =?us-ascii?Q?+2idHI7Vjc6oxA+lEpFbAHnKIToXKrrOpoh3sODOhmFJyoMPfTh3tM24zWQ8?=
 =?us-ascii?Q?r2dE0FRNa07XT+AAepsDCvQ69CH/twhdrIzEj+YRpgGCW/qHaWp83FUypwL6?=
 =?us-ascii?Q?IKy8fypni8+UZ13avF0VdtgkKLLmKkvqiDb7fglxgBFpaeXufZVtRTrp8HZF?=
 =?us-ascii?Q?vihbcB+ZQbgzVC7wIVA3STWxlV5Vf/7BzShh6rEN5M1VvwJu9MV0UMsOU9ej?=
 =?us-ascii?Q?7ETozVNgJ0Wf6MPLOUqp5q5AvZaUJ/O2UY4esDa6IR2Nx/fqr6SK7RwbEMj7?=
 =?us-ascii?Q?s/Tfx42VfPR/bvMre4f40H+4Eoh6X8OQaA/zdskaXiU/nfqM1X4OHACwoQj/?=
 =?us-ascii?Q?8x70nGoNcEaIyadVy7nRni7BJsWHMbQ5/qXgCuqyEIBFZou44n3x5XW/LQoA?=
 =?us-ascii?Q?16jL5q0El+jYpfTIjC0IB3/urI8E0LfETyimUE0YRYDWN04L+3BGP0vkPOOT?=
 =?us-ascii?Q?wZ5nDOZpIhbpA84+Kd4w9Xeh0lKCWAXGs1nDAQ9gMwXDvNhYnKRvUPbRVd7j?=
 =?us-ascii?Q?7po69wZ0y8i+qIBWirtLTe2JP0HxH+MvOFmcdj5EYndUIWnf+xbd1Xvk/6+3?=
 =?us-ascii?Q?WwNbw3b+NTS6aXE2NHQPeZ5ykgCzaOKsmAqKjhxQWblP4NEI7S0qx2yKiVEf?=
 =?us-ascii?Q?YQ82DodvBBD+cBNlMLdkOlkJT3ub5Dm8+bz0pubAgnnTggK6UN7dHgRp4KDJ?=
 =?us-ascii?Q?XbaEyLOng2JZIGHqBWUrwo/H+9OacDVmHy+GArdEu3chBr5M3cLjLzOxuFQq?=
 =?us-ascii?Q?jD6pMXilePNqGJPGdPV9tcGQyG4qlW2f9sKOT5riAfmGE0/OFajY1a2PGXQ5?=
 =?us-ascii?Q?e2+JP0FRf9FouaI+tMsp9/liMb+QzGgVlT4LrO7aOGe8fMwj3OhHRngIQMnG?=
 =?us-ascii?Q?UNElDtv2xZUayyBrXorluCMv+Zma4shu62Jowe83CO6fTHfUbo4b4cgjiW7G?=
 =?us-ascii?Q?a3ynGFCRCQSN8pF6ThfvN2wB4+APYnMfSSl9YkdiRoKsMros2KMwMbjngQpj?=
 =?us-ascii?Q?J44ljHm9KHoTRPuL9f66VoIb7YR/XxGfcdQlrtcKi+LL2NO0p1WHa4py/LYp?=
 =?us-ascii?Q?k5vfC/SedFiBoJvlyWjSiss5yvL7qCLi5DtoAdE3zNUeKVmMjQCfYdFrH7xc?=
 =?us-ascii?Q?9H0lLBSwdGScg0wpF2vHLnyj2AUzQm2hHTQMv6Aswp5yLvFy6WDIcZC3vYiB?=
 =?us-ascii?Q?I4WpzX18iLvPGA9gGdd3LBQg4U96kgef9i6YG557?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60210087-e33e-4fd4-17c2-08ddfada05f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:47:26.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sk9ZAr3XUO5V+LouKxbqZs9fevWHl/5+bzDB0ju67Edq6Ujq0ItB3uGr2AP0KuD4joeBia8m9Xlz69R/eWoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

On Tue, Sep 23, 2025 at 08:12:27PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>
> Add driver for the Eswin EIC7700 PCIe host controller,the controller is
> based on the DesignWare PCIe core, IP revision 6.00a The PCIe Gen.3
> controller supports a data rate of 8 GT/s and 4 channels, support INTX
> and MSI interrupts.
>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c | 446 ++++++++++++++++++++++
>  3 files changed, 458 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ec..8474bc6356f7 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -375,6 +375,17 @@ config PCI_EXYNOS
>  	  hardware and therefore the driver re-uses the DesignWare core
>  	  functions to implement the driver.
>
...
> +
> +static void eswin_pcie_hide_broken_msix_cap(struct dw_pcie *pci)
> +{
> +	u16 offset, val;
> +
> +	/*
> +	 * Hardware doesn't support MSI-X but it advertises MSI-X capability,
> +	 * to avoid this problem, the MSI-X capability in the PCIe capabilities
> +	 * linked-list needs to be disabled. Since the PCI Express capability
> +	 * structure's next pointer points to the MSI-X capability, and the
> +	 * MSI-X capability's next pointer is null (00H), so only the PCI
> +	 * Express capability structure's next pointer needs to be set 00H.
> +	 */
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readl_dbi(pci, offset);
> +	val &= ~PCIE_MSIX_DISABLE_MASK;

supposed PCIE_MSIX_DISABLE_MASK is standard defination for PCI_CAP_ID_EXP
register, it should be in pci.h

> +	dw_pcie_writel_dbi(pci, offset, val);
> +}
> +
> +static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = to_eswin_pcie(pci);
> +	struct eswin_pcie_port *port;
> +	u32 retries;
> +	u8 msi_cap;
> +	u32 val;
> +	int ret;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "Failed to get pcie clocks\n");
> +
> +	ret = eswin_pcie_deassert(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure root port type */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~PCIEMGMT_CTRL0_ROOT_PORT_MASK;
> +	writel_relaxed(val | PCI_EXP_TYPE_ROOT_PORT,
> +		       pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = eswin_pcie_perst_deassert(port, pcie);
> +			if (ret)
> +				goto err_perst;
> +	}
> +
> +	/* Configure app_hold_phy_rst */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~PCIEMGMT_APP_HOLD_PHY_RST;
> +	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	/* The maximum waiting time for the clock switch lock is 20ms */
> +	retries = 20;
> +	do {
> +		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +		if (!(val & PCIEMGMT_PM_SEL_AUX_CLK))
> +			break;
> +		fsleep(1000);
> +		retries--;
> +	} while (retries);

use readl_poll_timeout()

> +
> +	if (!retries) {
> +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> +		ret = -ETIMEDOUT;
> +		goto err_phy_init;
> +	}
> +
> +	/*
> +	 * Configure ESWIN VID:DID for Root Port as the default values are
> +	 * invalid.
> +	 */
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, VENDOR_ID_VALUE);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, DEVICE_ID_VALUE);
> +
> +	/* Configure support 32 MSI vectors */
> +	msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	val = dw_pcie_readw_dbi(pci, msi_cap + PCI_MSI_FLAGS);
> +	val &= ~PCI_MSI_FLAGS_QMASK;
> +	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, 5);
> +	dw_pcie_writew_dbi(pci, msi_cap + PCI_MSI_FLAGS, val);
> +
> +	/* Configure disable MSI-X cap */
> +	if (!pcie->msix_cap)
> +		eswin_pcie_hide_broken_msix_cap(pci);
> +
> +	return 0;
> +
> +err_phy_init:
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +err_perst:
> +	eswin_pcie_assert(pcie);
> +
> +	return ret;
> +}
> +
...
> +
> +static int eswin_pcie_suspend(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	struct eswin_pcie_port *port;
> +
> +	/*
> +	 * For controllers with active devices, resources are retained and
> +	 * cannot be turned off.
> +	 */
> +	if (!dw_pcie_link_up(&pcie->pci)) {
> +		list_for_each_entry(port, &pcie->ports, list)
> +			reset_control_assert(port->perst);
> +		eswin_pcie_assert(pcie);
> +		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +		pcie->suspended = true;
> +	}
> +
> +	return 0;
> +}

does dw_pcie_resume_noirq() work for you? If not, please update common
one.

> +
> +static int eswin_pcie_resume(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pcie->suspended)
> +		return 0;
> +
> +	ret = eswin_pcie_host_init(&pcie->pci.pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to init host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pcie->pci.pp);
> +	eswin_pcie_start_link(&pcie->pci);
> +	dw_pcie_wait_for_link(&pcie->pci);
> +
> +	pcie->suspended = false;
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops eswin_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
> +};
> +
> +static const struct eswin_pcie_data eswin_7700_data = {
> +	.msix_cap = false,
> +};
> +
> +static const struct of_device_id eswin_pcie_of_match[] = {
> +	{ .compatible = "eswin,eic7700-pcie", .data = &eswin_7700_data },
> +	{},
> +};
> +
> +static struct platform_driver eswin_pcie_driver = {
> +	.probe = eswin_pcie_probe,
> +	.driver = {
> +		.name = "eic7700-pcie",
> +		.of_match_table = eswin_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &eswin_pcie_pm_ops,
> +	},
> +};
> +builtin_platform_driver(eswin_pcie_driver);
> +
> +MODULE_DESCRIPTION("PCIe host controller driver for EIC7700 SoCs");
> +MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
> +MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
> +MODULE_AUTHOR("Yanghui Ou <ouyanghui@eswincomputing.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>

