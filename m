Return-Path: <linux-pci+bounces-13449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D988A9848B5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0CB226B4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C212B169;
	Tue, 24 Sep 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MAicsZSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2F1AB537;
	Tue, 24 Sep 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191822; cv=fail; b=AXs3K2G4g2pv7LwRUAbm0FOEhjkSm1btwSCjVDtkTlh+TuOnD5x2eX9qe/ZCDP20c9kc23QsIiIlNP5Ayjj4A2tSYXX6dYJo4wDQQbolgWebS//HPUuowCuDMWxd0VuKCmTMbqCGSQsOKiSyhMCC1SGeCW+PRxFf1qQNrycAvi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191822; c=relaxed/simple;
	bh=mlLiRtxpXykacdnDt1bGpxGfbfE40xSj9b//2IkYORQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rl4MickPhmqctC5a9S+xjqmB+iruMCwnNSDY+SWLHzJXtBpAM4cd6bVXOAAEMGwqlmxALsrP/bpQFhidQQaTSNsxxuB8G1ny/7YMc6wk6s/kq7s6q44L2zdIgKGan4AYSZPGvv04wAOjJpRnkQtS74/DfEkDQfgVZpA/zHWNO/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MAicsZSe; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXuB+KiZ1oqS3XCy8qm6K56LRUT02q4AKbw3saf5T27Oa4afbVoxpK6//0GYyo5jmbdJ1QXTm9j0zN6ihgL81/t/ghS2MfBETG9eLEpDoSj8S+Us+GRBrX2HNQMOL+3mh2QtBsrUI3DfWs/P9M4dKdQqtxhyDtKe9SltEyY0MjYWlXKps/n3HyikHgOKMl/bTbNDLVtAjOza6zzAdCpp1FJqLm+zC6075GV5TIYNRPh8/6Yly3nTf7ps3FEc6GZSuoAYw0Em+lko8DtI0C0nE9HabEfoUw3B8K5MwqJaacu9/+WvNrR0ZznCeYXGRoD3JZz/9f9fhB6Y9BV4Hv9nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwJPEBVznUTz8SB2dyp0NCUC9AXrdVB4GNgJ3tbxiuM=;
 b=XRdU5Uoklt60LLiNWvvSW6LOB5HnXJtTAMONactIp0njFIkfIbi8ssiEQyeJve4utFDkRkZbC2MH5IVCtunrh5AhI7yloVLJz0awelqWO6Y9H2aBUj8lgBs5ZW3HFalkGZ09Vi2lNOUxPhfxYbqfwKy+MgMagPAL5JJXy3y1hSEyPmiTZCg8vnZG+L54jaZUMtixa+CtIgJ/CK4R8+EZyCFtVSem997tJMU9epEo2h/Cq/vi/0BsPsZtpZc1RBWAOa+ktVIZ+pFsmWOiA0v+zfwiFTXOIrN/IrGtxEPfEIYrIZBUOLLq1b+PYxlYopOKGEziIXBVkY8EqZd9WT7L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwJPEBVznUTz8SB2dyp0NCUC9AXrdVB4GNgJ3tbxiuM=;
 b=MAicsZSeIkfyYjFaeRz79H5v80QmcX6dS/dZR6SLkasyAVOEto+SA5xsqC+b8KbUrdtXRlBAEoaRsHUDUwRSTMV9YdoTwnhRhTS3LeqoMNBkRlx5yy3tu4onCjY5qrhDvLTdvrW3tyfpAUiYAHiLMll/wsjyvXyTzc5Cgd+THc6p3mzrmDvXwRgFdjcsgWsMo4z/K5C0F/7Y+9Wi5Z/DcomYNrnic8NLrnT17hP+MgSR2KRhIL7nNpLuVwUF39MDX9lb/Z2sucmxUB5yM4Z0lZQ9W1iaFyK8bLz/VbQT6gQIhsLeKhKS9rtgGP+0i+uRxDdhPUbzU6ojGO9Im75P/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 15:30:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:30:10 +0000
Date: Tue, 24 Sep 2024 11:30:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
Message-ID: <ZvLa+Xhsg9tWY4GH@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-3-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5a9e03-57af-482b-39ee-08dcdcadc701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XqVtPZn0k3uNNUE+uiQlHGm9f1+krO1xty1RQ7c1xThUhRFhzJY5JOba+Se8?=
 =?us-ascii?Q?nilBl8uw0fUSz75bAjgN1Uw0djZoYgB6P8wTfkK1pG/FdvhsZWeXAPvfqJtf?=
 =?us-ascii?Q?tGRz+KYk21bMNV9NCz9lE3NDPazC4Ro5FKWSX3BwlKgcgwJw/YQKJXlwY8yq?=
 =?us-ascii?Q?6LJ9urvZ+Z2g/gMlSJiZLg/s10yOdBIYh9uaYPod70onuRHQZff61TB+xYrh?=
 =?us-ascii?Q?Jv+9BLOki4/ihMES/2THqXbDDPjteTACGSer8KB+aSPeqBAHn2sDdqLpk4jw?=
 =?us-ascii?Q?OU+2Iq/Z7qm33V1WU3Dzbmk+1el3/y+P4wsYLrJ0AVy+6zsiki7CI40ZUCpG?=
 =?us-ascii?Q?7cUmOs5gtDnlD6cNb2C19Xk8X2vPCElk1XLzg4fAZ2coR0yVmSv101+GoTwN?=
 =?us-ascii?Q?HZ4SRmPyyG3Ob5INCd7uti8ZQ0ga1Nh6ZnCG4V9Vnrs1kWaasDm/6t35aK3m?=
 =?us-ascii?Q?E48mG3T44oTkoioIlRmjHaILl7yKQ3BuyXsvR6JrVf05Z667Pk/7TeY25FxW?=
 =?us-ascii?Q?IjKbMe0VGx+3YfDKfePuAGBEBiKagywsHZ/SBBdSAbyvJfmnPeaGpgTRSTHv?=
 =?us-ascii?Q?skuPivte3PLHA82OGCtd7GhWYAO/kUmqCTc3Q+WgwXOy0JaZ01GOMRck+RcU?=
 =?us-ascii?Q?CmSAPZpTMLVTedbU8y/IZTn6MJ48RVo4bs17ODOYhWZE7RkqHx5kJsBAnCtj?=
 =?us-ascii?Q?otqhyvsPSEhMKBmlwUBUjlcrkIypwosvWdz1nClVu0DAx4CYXYEyySeEVdYR?=
 =?us-ascii?Q?01Hq9QP3MoYdIN7tY+T/qBOfDNQS0QGtVVS9L6e4s69vmlnUA9q124mbdrTl?=
 =?us-ascii?Q?qwHWddKYv7bzTEY/MMtyd1yPI8hSXXTAVdZHjuxdE9E7NeYDPKASltAq7snE?=
 =?us-ascii?Q?2Awtm5KyJLvYu+d5k1cV2GynUL74McT7uiu+3x2d1ADTGcITJu+WHaKuXN3B?=
 =?us-ascii?Q?j66l+0TnSX1ebRtQh6LaKw6KuHWJGUF9mvUf/M6Dfg3f3fidopnj/dFEbzx+?=
 =?us-ascii?Q?FLN3VFbfS8E6XaEn5Lzp1ejHYiVwWZ3KmIjWQaY9mxbWZ6fQd941QIX0FhVv?=
 =?us-ascii?Q?NGEyiPoC6ulXI4MAOEiHoKxlZOB3jdxewDzZQHDuCPA8QqL1jnNRmw4HD7cz?=
 =?us-ascii?Q?qibsLlcQl2z5re8gvG2ZKmf95VG6Z8m2afVDVRrNtyftCQntMgXIcNsPuC53?=
 =?us-ascii?Q?ywGmXLQxTNHjZ+Xh1VoRTCcbcAho+oFPi8CO8hmC2T2DMDx9I7OjA7S42rnr?=
 =?us-ascii?Q?/24lVnEA4FjY5bF5O2kyADeVH27aPiYddA78BMtsfkb0piEUA0xJw9wM9Q/e?=
 =?us-ascii?Q?FY9SC3/q/0njoIealyL4PkzEyOpnrDjhIrS4CQw490s4GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0zWZBzUPv4bPbHhe4R6hNxq6M0RjJtg3E/LeyU6nKYT0GZF3onGccTemE65?=
 =?us-ascii?Q?JZnbh/hhyPJVzmBhSLuaNcDmPEySW+Sklv1wp+/5UkrtEuNI29tp+ZkGjJng?=
 =?us-ascii?Q?FdivhBvusNskW2wlCRdtCjoreehM9t1zVonQHeRRndZWYqFTzLUll+IdZ5NB?=
 =?us-ascii?Q?5YHKng9OE2ShsLu5vmAojNeEfPNkznuVdyubPJbeWNwHGpUR+dPUKB1w7WI+?=
 =?us-ascii?Q?NqMRa2xukzLZrBqVqphPuoXjKKl12I54i6hXN3CI7VIE6vLoDlnoZ522CIJw?=
 =?us-ascii?Q?6WE6OoaQ0MNXoyzfA/MMRFVJ3XbWdmOJuZ11hIKT7V7eCnG8H9jKKNg1NJHy?=
 =?us-ascii?Q?ut0T+OFbXYAjgwRLrr5ktzQgqh9cAuRse6j3r7jvlyBqf0PQUYZDYH7aQsuD?=
 =?us-ascii?Q?80hzDjzqVVN2GTqROUavJHrcdoGO4yXWjOkup6odN60aMfurAtTijyAnxal1?=
 =?us-ascii?Q?NlUbsoF2XpzC9s/J/mhga8chpjEziC4oZl7KRoBWiBUJXGNaLdMWhySLtwYa?=
 =?us-ascii?Q?Bg6FEmzNh9y28Er0HX1r7msXKpTXZBr1w3KlK5Oh7a8p30ZC2Huimveezk+b?=
 =?us-ascii?Q?mKsLNz1QO3VxVkdL0zv/j6U0Nvc0wT7WypjfcQiFVJU8qVCjWcet+m5GNSDQ?=
 =?us-ascii?Q?C4+Q3ouCOfWn5MJM09tF0FOjaljTcY2NqNDaOs1Ywzkdrc9YEYodq9EIkAV+?=
 =?us-ascii?Q?HP2jQ7Y1sY9Rn0bwBcWH+/c34GEmYE4fIRHBQMBC+ynxywN6cSyW3DlB9yO7?=
 =?us-ascii?Q?6jtgstL4yqu+/Z20uZc+utFA5TbwsmvWrMmdY4GN2D5NguLWmM/dxyk+VHG3?=
 =?us-ascii?Q?IssgRuy/05NKs4svhS+zTqFdMtt/B8YuugfNyxNmTgktjC2X0ZM42MacmYpc?=
 =?us-ascii?Q?gDB9TA7+yePfsDEI/rk9KNCp5x2nI9I+sTmlJpZp/eQqMpet99Mi1vMJUXVW?=
 =?us-ascii?Q?87sryVkab2Yu9d4LhJ7m6hD5Z7fEHVdyFItBAVucNSWO3CszB1qMF7hDnHL9?=
 =?us-ascii?Q?a2Ov+2b7r+4hGxfHgHB+jEu6mDosk/9OXYaqM/ryxHAOX7LkmpgxYxcyyIiv?=
 =?us-ascii?Q?jdxHngJtNdxkwoG1EuRheJ3MFhQB70pt/sQLiJHopMSYc+JPzPhvB4bc7pFB?=
 =?us-ascii?Q?/anQJHzFW3jzOmqPk1YRKYWt1p9zm7w/MBW6Rit0CYz4eRSDx3Cb1uitSwF/?=
 =?us-ascii?Q?R7FXfjFpvIRT55YS7O9+1UiLyEJZP5gBRgPIK/aILweU69jp2Vjh7Hae4KTN?=
 =?us-ascii?Q?gVwfod4pot7AAqzZS3fAZNeB9ZyXl74Tn6iD3ceNPdiW+x75SL6Vu3rZMRBL?=
 =?us-ascii?Q?8DJeakAJgbVPCzc7C+zX8mRous1ZelYUaq68v1vkLJwLJojDHTgQ0cNljbff?=
 =?us-ascii?Q?94PhUHUPUUMoZ4OlKBl/9ETgsvsIheqxlwSw8H0///egT9MjmE2b1Hfce1O2?=
 =?us-ascii?Q?vkDSUKFx4eBJsb+oaFkcAvPfbHLKyeOVwZ67cb6Kau/Q5R9vRma5Szwq1D7J?=
 =?us-ascii?Q?LXhNzBtRrO46jlR/SSowM7WNrciNm6OE1wDzIKzqFVSbbR7G0zDpIfB9KAgQ?=
 =?us-ascii?Q?z1cLAU6yhy5JnpXgZMc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a9e03-57af-482b-39ee-08dcdcadc701
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:30:10.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyESehOKBok6jmfay7DRLAHtTyCRWrsPHDQ1dV/eZHqF8YmqlTNG3fMTR8Qz2aGFpNey4AGuhZ4fmCfimsG9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968

On Tue, Sep 24, 2024 at 11:27:37AM +0800, Richard Zhu wrote:
> Add "ref" clock to enable reference clock.
>
> If use external clock, ref clock should point to external reference.
>
> If use internal clock, CREF_EN in LAST_TO_REG controls reference output,
> which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0dbc333adcff..2aa02674c817 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1480,6 +1480,7 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
>  static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
>  static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
>  static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
> +static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
>
>  static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
> @@ -1593,8 +1594,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX95] = {
>  		.variant = IMX95,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> -		.clk_names = imx8mq_clks,
> -		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.clk_names = imx95_clks,
> +		.clks_cnt = ARRAY_SIZE(imx95_clks),
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> --
> 2.37.1
>

