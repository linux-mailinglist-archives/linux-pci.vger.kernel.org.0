Return-Path: <linux-pci+bounces-3731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88585A71B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 16:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD73DB25136
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7D383A1;
	Mon, 19 Feb 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q5aXGDt+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E002E3F7;
	Mon, 19 Feb 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355521; cv=fail; b=roLXC5i76Nr3lO9cx+C6SPSiKtCiUAB009qWQu05fq2mGgSxDKUWbOVvor/Jl+LNdGMnsCjusemqA6TwqL9fAGFMifgbGL0Sapq2GFTvHkFiW6OHGkpoPDEkNT8PRBlt3xQi4NFHt8DxERdxAHHbYecXaDNy/ogKxsTtSLC7j6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355521; c=relaxed/simple;
	bh=3LEbvWuF2bNV2CEQy/ScdVso0wRPgn4Dgj9X5w3usBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Osmt7oNNyi2B6jGTYIOZ20zSP//kH8YHLbwEr+H3a9I7BnRYUk81/tEFKYxa6Up5Y5uiz2RR0pHNsaxhKjnKMpQM+DM78i7RowXE0xSASHllgvQ6wYryfkeY2cfKpllf2U4PlndDRux3ykbrfkWMs+Xv1zrRgTmDGnaJhTn7Jhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q5aXGDt+; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzVV7lhss2gFxESTcOwYtk/u3pjKxjrXwj8zPaeqNYg6KR9lLnVLS2RoufcJkhuC/djDMxztjj1e4UgJQrmG9pHaSsWZQAxXylIre8xJIk+iZIfujRLfkI1nqCiSaRtxhyHxZGyLDZEtSil/v7lzW2HzcoxqZ659cRXIGpDn7SsT5dUiVGDDbOGAqqyzByndh+hqtFg3sbc7EYhhPQCbBCGb1OOxcfgGf++DUHKiO4xg8nv+DBtDHoftZ8nMT2J75chm6vGwSPLnCKRhkPcI7hk4ER0eR2FPm6rgD93qsAMWyDBPfYIvC8bCGl7SgDxCkM1a/LNCtvOEdZXZE8rQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkGBkSdVSZlHBgFN0DmsptamSxy34KEANA7a6+BQLb0=;
 b=JXyqN+Y70wGSQgnvIofifuvqQsCSz7YYvLmAJknEgr+QVYzuDSMpmvEOrALRwu8E6pFPI6UotV9CDj72nNRr4VLe4UPn3ifACEq+UCYys8rHQLjJ8UeLoqCfrO0dW2Mo0xao7iE840Z2LLoeJwr1oAmr5rxYNc8n5tjEjiypO24UFYLXox0hKwNUP/w4/lxtMq7eH6E4RKhSXO4rfkdFTZLEE4ys0GkgQUKBL03CiU4L76vSQG06t1fi4/J2UKUHX7x8Azmg4aPkIU1OqNEHp288ChOJecTQLkvVDpxWul+UOU4kU5rlRca7CrBZln4KCC7pkJEevIfJwTN4z7zbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkGBkSdVSZlHBgFN0DmsptamSxy34KEANA7a6+BQLb0=;
 b=Q5aXGDt+cvZTcc+lNwUUpiSeB5GoGp8t8sOeJ0HjNqJTrtxWLK6x+LWE0MoZ5SHtU9KI2BxZDgLOnSY8/neXLz7FRd2IDiANKpOAnq7OXAiqjsFUWrlV3KoVPKFWKRITXU/tcM5SDoVvDa73JhhiVJiTCwbnX0ET6aVFINItOto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8468.eurprd04.prod.outlook.com (2603:10a6:20b:34b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 15:11:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:11:55 +0000
Date: Mon, 19 Feb 2024 10:11:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: lpieralisi@kernel.org
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6acd47-9889-4a1b-9ebe-08dc315d1c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T4E6NW/V5EmjEYJ4JvWvtmCPgy8d9VxvPjyjOmqTeDtqfVugFoJp9crXitU0MOGMTU+VMKcdTyZ5T00FDHJD60JxgV2j/hY7+bwN15bL7A7wMdj5xyXCd9JKYmBYH9NFgtOXUaCK7hIczAD9yRPN9kRFGEmgo8PeIR2VIm3q0y4ztxcmJOoRfn4J1jP1nJ5+rs0jsVQHRjrrSggQTQAngc/kQvfCjGdruFVHRZEYFLmyED4s2d/KKLCnLAPIL+BWYRAhL57qFh26m+YJfIwB/6lVOqlXumlZgMc1DtflI41HPvR7aOXKfhWxILl7iPQ2xi//jYkP5LTKisqA2XQlZ6zNuID3qCx1LNr3QBbHF8Ab/GDXTLJ4CmbZnDENNnCN9KOpsIzgyS13FhW1CR+d9FCleT7Vyt2iJcFpF8gJFVCZYm+lisOn8qwC2ydMx0YTZSrJc320hOgLmQS9FvpWd2D8qPCcUEWpIEdQJXtRU07kJXlYC3l8UXQ/2M+GXwT1B63sQINVZpq2+9BeeSnbNqpWWed1nlxjeDTUj/8wtPk7RpriV6eGOB7NK5NJHGuYM4HVdBQDnbpzX8y1/1te4MlZ+eRrJTql0hS2o+I9bOJuAUC/pL56mFjhhAWmD3XR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaHrP6Y4xE+Sw4FUmHYi/sj3QMx3O5P+s185XwIcfLfRgjW5Tn2FzZMiAQMd?=
 =?us-ascii?Q?lKtjrFPc0oQqDQ1TNzGdDP+GidRrMV+5Qlew102HAy2JIPNn2CUsuw8+Wxa6?=
 =?us-ascii?Q?CJS3gGxrVjGJ9c2Tbbf5e+XB30YrO1u3fb+vZ7gPpFMBqzwQosFuHj5mNXpf?=
 =?us-ascii?Q?KxW3IXjAjC4AnqujQsbnF+oQFBI9Nriv/6NT6x9I2ke7lgsHmDS9VxCEvkuU?=
 =?us-ascii?Q?QyYqBIA9WhNagqFps7yd9l36aZHu+y9WpMYxAME2mP7YHr04zHJbwNWM5vZ3?=
 =?us-ascii?Q?fL4bARi6lzX/d3eL1+b9GDCsYhORo5Kkpk8HzJr8MGszskI+EMFBZhprmRqz?=
 =?us-ascii?Q?HNC+pF0whwC4v4eRclS/6dSbDLK+rCeplN059C36vO1drMZvzuvwxg7o0rLP?=
 =?us-ascii?Q?PxN/DUpGGKEreXiIVoIPVvkfxfDWJ5k2c0E4m598Ou7LFJsqvxmcTHdKECS0?=
 =?us-ascii?Q?omyWfU+2NE/GzwmbZkhVDlX8+HDUBcEe41tkP6626XoicqYhZ4JMY9tzkz53?=
 =?us-ascii?Q?HDvcuM/CACrtyJCMk6/Mz8f8sGVgeeg0WgWZ16tDg5vV6pvRslp6CnJ9c8i8?=
 =?us-ascii?Q?CBWVqsuvp0i24ZzI3Mxbxpl6oMPA4xVPUFfJFYUO89eoX6p7SZ6VAcyMa+q2?=
 =?us-ascii?Q?D5aw2QCmGXP+woRrbKmubLtj0tZOGB4NzSLJ2XVt4yM3chVV0ALmLBt7HbWa?=
 =?us-ascii?Q?QhTRfd+s3QsuOEsyCSIlElUnk53zM6JKOyKIOu/OMe/qu1HjRRch4YEgev2T?=
 =?us-ascii?Q?sXusnWkBHU8yUr+ynkAHM/jRDzwh/v358o+0UCpssZMNyJpfbGuYqOcEhanM?=
 =?us-ascii?Q?77yJ3qXw7VqfnKV4W6hG+Nsrt8xwGic3ctDeWqvktqgjzEm36faaTw8ywbrj?=
 =?us-ascii?Q?fvJbxkV0m4rq54ceweueZdVy9MAZhhoK4WeubH9Xxn5AkwPy2LCF8JyJ/h/h?=
 =?us-ascii?Q?g4pCdEAHmR5bYvZMUfy/pgsP6hpsgg8SGLiBCaqE1bSBGPT5Sqr5dp+XP/sH?=
 =?us-ascii?Q?upW/lez6wLSno11Y/cdJhVGn2deTFfvvXn83xiHzVkfGKTZY5h7b2rD1X9Rt?=
 =?us-ascii?Q?GVaa5WTWzegL0ZmrvgJh1hYemt/78n+DFm3UrPGrSDYSfaL60Uq+1PgnbhB9?=
 =?us-ascii?Q?Kg0MKKQznHvejolre+mCbFF1JGS9iVR+Htls/Duy2QWI+RyP3u8IRt78GmsT?=
 =?us-ascii?Q?jC3rYJfWWNeRRypo/N5elSGX+d00oOg4+hCMm6BqwEkS0a5RB/YWtF0dHQvX?=
 =?us-ascii?Q?VWO9K2u1vVCgWUbPWbvWMq9rIpMfEsZJmSK+IPpf7luXalwCTajlKuB2BLY1?=
 =?us-ascii?Q?MQsKZtA6NbJI4tR+c711P96tyvhtBj46X4mlZmdAQm2XC2EK11tXtkSNU+YR?=
 =?us-ascii?Q?PtBH10WDa3zMFtNo3eUckkzSAIe4Uwqbu0vQOHCqK2n0x5pQS/8A74/T2+Mh?=
 =?us-ascii?Q?ugMmvlcJ+FRlBs+K/DUVaL8ZS8Lpjzjztzf5/Hs38evC5va/u/PN8vfYMOEg?=
 =?us-ascii?Q?4zWx2D3YV93gKtAlesOAU4FBwBRo6KtPeDmTCDhbcWGohzY2n9AopdD+Cwkv?=
 =?us-ascii?Q?2uSm4NZSgx+FgirDNS0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6acd47-9889-4a1b-9ebe-08dc315d1c60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:11:55.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJmuWC4dfQsTf5RNNrPwnxd4CRhktmETWNlaRsX3mvlyuAqTkQTeK4y6TrLt3Tk/MP9bEXImWHk9C9exBOpcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8468

On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> first 6 patches use drvdata: flags to simplify some switch-case code.
> Improve maintaince and easy to read code.
> 

@Lorenzo Pieralisi:

	Do you have chance to look other patches?
	Mani's apply EP side change. 
	'PCI: imx6: Add iMX95 Endpoint (EP) support' need be rebased. 

Frank

> Then add imx95 basic pci host function.
> 
> follow two patch do endpoint code clean up.
> Then add imx95 basic endpont function.
> 
> Compared with v2, added EP function support and some fixes,  please change
> notes at each patches.
> 
> Change from v9 to v10
> - remove two patches:
> >   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
> >   PCI: imx6: Using "linux,pci-domain" as slot ID
> it is not good solution to fixed hardcode check to get controller id.
> Will see better solution later.
> 
> dt-binding pass pcie node:
> 
> pcie0: pcie@4c300000 {
>                         compatible = "fsl,imx95-pcie";
>                         reg = <0 0x4c300000 0 0x40000>,
>                                 <0 0x4c360000 0 0x10000>,
>                                 <0 0x4c340000 0 0x20000>,
>                                 <0 0x60100000 0 0xfe00000>;
>                         reg-names = "dbi", "atu", "app", "config";
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>                         device_type = "pci";
>                         linux,pci-domain = <0>;
>                         bus-range = <0x00 0xff>;
>                         ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
>                                  <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
>                         num-lanes = <1>;
>                         num-viewport = <8>;
>                         interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "msi";
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
>                         interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
>                                         <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
>                                         <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
>                                         <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>                         fsl,max-link-speed = <3>;
>                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
>                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
>                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
>                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
>                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>                         assigned-clock-parents = <0>, <0>,
>                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
>                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
>                         /* 0x30~0x37 stream id for pci0 */
>                         /*
>                          * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
>                          * <0x100 &apps_smmu 0x31 0x1>;
>                          */
>                         status = "disabled";
>                 };
> 
> pcie1: pcie-ep@4c380000 {
>                         compatible = "fsl,imx95-pcie-ep";
>                         reg = <0 0x4c380000 0 0x20000>,
>                               <0 0x4c3e0000 0 0x1000>,
>                               <0 0x4c3a0000 0 0x1000>,
>                               <0 0x4c3c0000 0 0x10000>,
>                               <0 0x4c3f0000 0 0x10000>,
>                               <0xa 0 1 0>;
>                         reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
>                         interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "dma";
>                         fsl,max-link-speed = <3>;
>                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
>                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
>                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
>                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
>                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>                         assigned-clock-parents = <0>, <0>,
>                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
>                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
>                         status = "disabled";
>                 };
> 
> Frank Li (13):
>   PCI: imx6: Simplify clock handling by using clk_bulk*() function
>   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
>   PCI: imx6: Simplify reset handling by using by using
>     *_FLAG_HAS_*_RESET
>   PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
>   PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
>   PCI: imx6: Simplify switch-case logic by involve init_phy callback
>   dt-bindings: imx6q-pcie: Clean up irrationality clocks check
>   dt-bindings: imx6q-pcie: Restruct reg and reg-name
>   PCI: imx6: Add iMX95 PCIe Root Complex support
>   PCI: imx6: Clean up get addr_space code
>   PCI: imx6: Add epc_features in imx6_pcie_drvdata
>   dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
>   PCI: imx6: Add iMX95 Endpoint (EP) support
> 
> Richard Zhu (1):
>   dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  46 +-
>  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 634 ++++++++++--------
>  4 files changed, 436 insertions(+), 310 deletions(-)
> 
> -- 
> 2.34.1
> 

