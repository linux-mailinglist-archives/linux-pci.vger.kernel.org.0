Return-Path: <linux-pci+bounces-13453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312E98497E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49F2B235E4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE31AB6E2;
	Tue, 24 Sep 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/KFY93s"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F5D531;
	Tue, 24 Sep 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195056; cv=fail; b=ZhREXM62YapS4818ns1g2Ecr2zrBcYdJzFaG6n3HVmdLE0/mRcRDlBPSeSebk5R3LewWqxRnZZt/Cdw7+i9qVTuwH+cF8dNmvEizObUCNyaLNJrzyGLVPWi6i9Naa0O9B5L7PXgV3BZ9Pl+Q+1St+F0B44eKZFfCij3X5jiDE7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195056; c=relaxed/simple;
	bh=f8p2ZC3aD4udA0g3yp6VJ/0jpWi/qLwAYFafGAiqSkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnYA4bbGO6+MAnLVtsX0/t5X2yySNJuSJTY/DAvl/RN8fPiMdxBrMdAxOuhqCOoygi8yMGCDzGu9OWTQMSLlo7JFOXPmlUxeq1R0Om4UR9lWJqv0MAR9S/1YWlqJeba5sTl/IQFEuIS0IUC+y2HQUdNI2a2975egcx2ialvI3Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/KFY93s; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuLHb/o28pNED3DpzAFzZoEvL7W9NRnLTA7lmMyMm9LYh5RLoJVrslCptRsJFf8cvAnogTXjRySJIhK9wO/bSyrrNpv/Tbpqv0cKIIVfrJO5iJ16B/TJzwBlnNlxmyK1plY4MIZKUvPoJ6tIqT7Reosak+fsyTd7Zl3I3Ep/gCJ+Nhcn0AKI0r2MXKsIDL6Nd2m1ZxQ3JtyMZ04qTrrC6k1uxp3k8xixAA/hOhgUwLGouQrVr/kU8VsWP9t96hTZJo0XmvzA9e/M7XhJCeDz9DAYRC/C/2gKCyk8mnKyQknIRz1ewk8IVXgNJO0gXWUZGS5Mj4kvC7yx5ijrqWkUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qmhw2ruavklJMYKC4mWMqvSJdwn8xPONbampSnLaXs=;
 b=TUqUCwML7meiOEH95fw2aAdde9y2q8seRZP9qzJYyghOfCWQmIeMbthi/ShlcrwX1u9r0hLSv4IU/0CCFOGeCi9neNMFUgSdv+qgOKR2XJrUHkJjRilvoCl30H5k/C1z6xAvOTRcjUGwoyNYiSQgFwjd716bLVlXIrLFB9tKgjTLA1797m88oi4xNGL7g4F9qK6n5uUZ0MWY2u1Ke+fEOW+/Z3grKKgKHEw2jhy3zFlvSKNQ9KBMSYoU2VCL448vtwSYlIQP7K/kU7eljC/A/vvcwY2qz1sLXNd8O8DVOZxevJRo0vW3LuJeG11cduR+1pYHGXckJmciGl+6kcnhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qmhw2ruavklJMYKC4mWMqvSJdwn8xPONbampSnLaXs=;
 b=D/KFY93skDdlarZWr72g/KSlXzFH9pY3FOfTTrzQlSnv6O+dWpot5y7kKBlMH3y/7SG8XRyfbK/NR7ayZj1uvOnKO/IoBevE8gqK8HtmqABl9qHujQRyt8bBV66nZpos6eQEn8h+xmWAu4RKlz/GvcK4Q59GY12WjWPCP2Wker/zlrHLHur3bq+Rsm6Wjs1yjlHA9NvKyyXXAcrjYXRnypiMQmcET6oUW7Bee1+ihuKtl8A1HIp/b5jIQO8FCpgf2bnOrIQNaGOiPieKt9Fi5fTNjzRmyYEPVQeuioNJOzizwwZFXn5Ode4O/peQfsqe3DbTeNVIGkDE6mZp4qFjfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10127.eurprd04.prod.outlook.com (2603:10a6:150:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 16:24:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:24:06 +0000
Date: Tue, 24 Sep 2024 12:23:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 5/9] PCI: imx6: Make core reset assertion deassertion
 symmetric
Message-ID: <ZvLnnMUcRhzGr1I6@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-6-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c8f906-f208-4b9f-bdcc-08dcdcb54f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47MRMihfFLbQdbmDeIdwNt+7lwaYkr4kjif8yqKXX1v5S1bey2Veez4Pi6im?=
 =?us-ascii?Q?TTV4pN9CBQMhZqcIycrnNY/NdzS1iHhB4z2pb1H5DcAhGSD7/dguff3VYB4Y?=
 =?us-ascii?Q?KNP7mfcGm+P/axZv39RFtHkhl/GKeBFHLQehkkze3Sqje2SCgzedF88CZHsR?=
 =?us-ascii?Q?VemocVRO1e3QlePl8n5j3iYNHLnDskxZgeWx6YPzARnP0HdZ28/T7FuwAFGm?=
 =?us-ascii?Q?TIXWwbH3ZZB/ilxA3Sa7CbibhOqXrP5tQ9XUsvBbaEC98uZ6fBiXD4QZPL9z?=
 =?us-ascii?Q?3AMWXXbDtGt0T2egf+rr2W0PeaaQTXKnTXmaAONn2YeOMf/C1kqF/ZfWCeIJ?=
 =?us-ascii?Q?+yXY040Y2uwSFzMm64Bgr6cZlYn35IrSVIsNGWuIQAcFaL3o4fB3UlUOE1C9?=
 =?us-ascii?Q?vtGpd4R2ueQA78tmgrrPz6x0NN+5KG+i7bj3XC/izkKiMpISGMi/VmMPYDoY?=
 =?us-ascii?Q?VEvQEqJGzL8OaZ2qYOM9oL16MaUzqbHhEwx6KJh41gO8jGKEwyntO7CVpxhK?=
 =?us-ascii?Q?BS6oe01QYzr6lsWhS+14bykkXyEtA9OarxKykGo6WgJtuKiFt9p6hfSwtkaW?=
 =?us-ascii?Q?YvtYRTLETns2sC7nBzrCxjawJ1I5Rg14eDQetUCrWntC4oyjXs+Vmncn58BI?=
 =?us-ascii?Q?6EIvA+RmsPL4q4c2vK2mb9NRggDitcJNFAywQy/i8OJzdhGowEJHy2gz4GEJ?=
 =?us-ascii?Q?+WK0WZvBe1kEjrBs4gNtDrBWcY5oET+8IL6/r9goeebHVjer0hD9n/orDWjF?=
 =?us-ascii?Q?YZaYsn4z01++dJ5L66EpwkcbBt3+wDqU6DdwrVOJM6P9okL00AAOen2LG5yv?=
 =?us-ascii?Q?0n1LDrU7RuX7M3GGfr/mNuB+B6msSk63E555trdF7DvzLvYZmgXRVPA0eC3E?=
 =?us-ascii?Q?WgA7I5puP49BSHKwE7CTT1OPs3pd2M95r/QbkbptncIq9/GZzo+wFx7fHdW3?=
 =?us-ascii?Q?BwBNBjhsbKb4o3bNO4yH2AKIyMLgeJsPGPpHED6zFG85trpaH1wCPbbNqqEc?=
 =?us-ascii?Q?qz19tL6C7c0Zofsg5vB48e6QaEskkMgRdMP4Wn9V7RaINwswMHd4W+0appMx?=
 =?us-ascii?Q?rTMdHRdDFbg5pbwkIGkARqZXoMCZRhZNrqNhyr7thHhMd3i3bsVZpvUjsNMg?=
 =?us-ascii?Q?Z4FK8JBiA/nWGSzrdCKMuBjj3TALMNSTs1JvJ2HMK70mVDeSeoXfpJFdvo/T?=
 =?us-ascii?Q?NVGG0DWRNpsbdYoORpBgPkaFRoxr5natpF0/hj2aRTN4dLhSvdCjz3TXuN0u?=
 =?us-ascii?Q?mv9Spp4iJLH25WXiqvOI5p1qD8U5pgn3AJeQfxrGqiUw3xjlhCdvFpu8+vis?=
 =?us-ascii?Q?fUaWfV+ykXYnNTgpP0VIpqZiR3Qt9cb6f41LoPTx32CC3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvTG7pYgKS9i+TbGXTotUpME3xQpdB0hq3ajPGBBmkuEyGB96Zb/oVowCmB3?=
 =?us-ascii?Q?spLNnO23mSWXVv1bNikg5Z3VZwM7QSdFq7uUZbEuFn5H4afkVG5NLQpEmSSR?=
 =?us-ascii?Q?bTqYC37wxc2uwiVATLwIiiGSLwMdeemFK4UMgnfO0Yv74Si5lE7hSpEKzv7c?=
 =?us-ascii?Q?EK9rgfg4eJJX/2izc02Wz3dmIDU5mDCHEgxJC6DjnNhL57aIusTrRI7e0S4V?=
 =?us-ascii?Q?gribuXu6ORKsjXLR2CUC7bnOUXFdQtupkOgGXWApG0CRLqec1HiO/ekkWM6N?=
 =?us-ascii?Q?iXf9YSuz3tcvXAOXJHNCgHRUosF+IACqVZ3IGDlj9anNQJis8h4BO4Jxgkn3?=
 =?us-ascii?Q?blZJFaoM54yEf4QlFGKYx4IxcMKBHbWOqbiTeVahPj1XMNViKFLHc2HGZJ2z?=
 =?us-ascii?Q?7wms1MqYOYtxin27jGdQAuq573f5mLZbLJzmCVKMQFXDMHBpYJS5qSPaaVxd?=
 =?us-ascii?Q?QsAlLZMiBlgrd7Oen491SuFMtY+DYxgxKHbjLmkHrx/eM8y4Y4YXV+img46D?=
 =?us-ascii?Q?mzmuXlEefYda2dtzs74PHwdiXyArNXKzttfpPt7umqIzUiZl2jACGScu+iYP?=
 =?us-ascii?Q?URnqZecwF01Q25EKSLqVOCy/dkqNmSSElNVBQKIEFle8FjfmVIPD49sYyow+?=
 =?us-ascii?Q?8Ow7BsW/suQH8wAA1rnfeDsHn+2wmgKfLJAXQSUEWBDAltZnyaclqX1sQTmk?=
 =?us-ascii?Q?vD+SXoxmn4GssSs/SEJvK3zl0x6aGeFxMG2c2viNmlqK8vOcwwN+glyV0eVZ?=
 =?us-ascii?Q?yiJcztdhSrcbUnmDvA335QOj5uc7tEfhy2m27kF1jcuJ0TjDzsiQUkkSTCT6?=
 =?us-ascii?Q?ajyv71uctCG0q0hN0n0DSJgccDHELF6/jOyuPQp9M/I8tuPeRBhG7rXawLM7?=
 =?us-ascii?Q?CJrvhua5wosjUba3ptazsLtCp5NYzEwjZ1fXw/UcFYFhasRbfGmamRcRuyVN?=
 =?us-ascii?Q?ZF9ehEZ5xXX/HQG6MrmIGCl4qdfp9qdo+UP5lJxCwvw8JX2KRKCZWEc0x+yF?=
 =?us-ascii?Q?Re7I6eY6vT3qKCan30UrdPFF6Yux/TS4oljD1mI87J1aM/hu1b5aiKMygziE?=
 =?us-ascii?Q?z492UDxbvS0HOLmpABX/ypDY5mOB7Hybj08fUzGhaZ6l1UVBAvEXKAUHQHS8?=
 =?us-ascii?Q?J/Syne3dHeIHtv6V/nmReefTTv0lMNhG66Ochy5kQyPiL5Z5kNMvDxpvy7Pe?=
 =?us-ascii?Q?YISypXP8299WRC4pRkujucX8XbuD10nR8WfwGacwU91EqWonSTPaZ5uL94C0?=
 =?us-ascii?Q?ilT2UDm+2gngqP1mItOKMsf9oyzJGLRJwTDK5OEnWsvXXUlRUmQMH4FeyRl2?=
 =?us-ascii?Q?7G2j0NUOkcOUzCWwwafWSoE+BeKcj2quK0AiE4sBi3ohHgjON0oFp2UAhvFD?=
 =?us-ascii?Q?thiD0ZfPyAgIN/fXmivIOY5JRq112wFX8xxAtvPY3QuakjXeNmSJBql5Y5N2?=
 =?us-ascii?Q?23RmZjKizKc4gVsvxjWhxJH/38g56Jj5Tdr9X7UTH1wdkIrgmi3BcFq5uDdM?=
 =?us-ascii?Q?A8UiyaZmiyakzs+4V0cZ51KFivDAJB85WPVFfNGA3TwaUFd+Z+2+kNpapdWW?=
 =?us-ascii?Q?WUSwYSlfGzpeolIy9Hk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c8f906-f208-4b9f-bdcc-08dcdcb54f5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:24:06.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7slmIYWHfrft/64uZdDJdUeUZ2LXQV3TtiEKDzeHdZkNGHTfix37cJ8cKhr6Y4C55zriuf2UGuYlpewHwLhoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10127

On Tue, Sep 24, 2024 at 11:27:40AM +0800, Richard Zhu wrote:
> Add apps_reset deassertion in the imx_pcie_deassert_core_reset().
> Let it be symmetric with imx_pcie_assert_core_reset().
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d49154dbb1bd..f306f2e9dcce 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -770,6 +770,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_deassert(imx_pcie->pciephy_reset);
> +	reset_control_deassert(imx_pcie->apps_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
> --
> 2.37.1
>

