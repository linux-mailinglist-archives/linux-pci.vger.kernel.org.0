Return-Path: <linux-pci+bounces-3734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050285A771
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F40DB20DC3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153039FC5;
	Mon, 19 Feb 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DzDiphGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DD38DC7;
	Mon, 19 Feb 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356858; cv=fail; b=KvEuLLqP8j13q142Rv935S+OSsajAFlu29DQG1aRJpzWXQJsiFkKcYM3V6k/Y9J0HQd7e3dBr90dOBRRlUdoWmoS5vBZbaiTbubzfx1y7/EoTCqN7vKbM6B8A+cD97GIBVr2r02bgrduDtrHQUhqoueR45opKxoBMXkgEuGrTRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356858; c=relaxed/simple;
	bh=Vx8ZXPoAwx9r3SN3yj0Qa2bXgE9f9cvJOSjoGlTMDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RqlqfRk2rmhzgb+F03X0USyYOC/NJIZHpRJSHHlapCdmR45eQOTCDNNyMTo26ZdYvOxW5ZAlMa84+Xxd4ll+/wHvjtvclHcAMon2LSMQRVoYuZsDgJX+MvRLpMU0V0t/jxIC9V3vjHoYfX0EJoWGRp4PGRTWJkRR3D9rbfaL9e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DzDiphGh; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWjSoRs0SDkcH9HWuMEiZ+q9Wf0WyIfi4VTd+YGeT9xIsmEZ/zUZzmdyn7br2OPfYZ9qu/V4sP0mwGSa1B4QJ2L6eX0Tp29TOSO3lrX/VyKCwoC9MghrDFuNH4HA6tdDk52cxprCN4QzGu8ZlRl7fLw75MJnQZVtvjQMhKuGSBhz0/9U6x9HXTdzMyXLeFCzuCiPQUwdf0Yu6/nSr44uXdB+UHvRYnnIi4K4lewpw9ga/ShCt1ZS+qLHdo57jjQiCjhS9FpKgm06+E4ogq/pDmTj8xp12l4kmwzhTeArOrrXEzAYZxygd/oB8Cc7F9z1er3U/TMX26cOBuva9DPH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEry78DJAptEwAC4+C+9bWLzCNjPN1XbnD7x/4QNBaw=;
 b=cfN2QzWgwErRQNSdBpCSv2R/ged1rfvJt6nCQF4JR7UEZ+gNZdEX0c7Y/Un2ApDR/Q8I9WY/XhB31vtM8cumsWbLkTio8sjcI01nf8I6h8e1ylUgS8EPxiMqoBQe/mlCLJlNdEcLOrANoOMwkQE53bvZSswpiZh3ETQDslvkwKMj3paid2TYvX9o3SUZNQUEh8aAkxfTPOGaY19m+c05/zTTbCcG+r/a8Bah7JCxA+L+VQSYNNTXl8XvQhwodUTWJ/0LzT8S5hEjpQKwIU44h9NX5emBFqESPHSM14mvBMxhiqfYe9g6GHt2/AGe3SG/VgDXQWN0boDk7040tHrP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEry78DJAptEwAC4+C+9bWLzCNjPN1XbnD7x/4QNBaw=;
 b=DzDiphGhryTpeHZPgbcgbhmGMX8AJc/c7oVLPTFVoLmVW0ToaWX5zPxRD+i8tjbGt9V2TfX3HFZxlYOK3KcGLen8lM5bDFrLKQ+qTNMTrUl5imwjo2dpDYFaqM/4ByiuBBjPrsfjQgCLaf57HSUxShsgqzpU85jDQI/8sTVWG6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9979.eurprd04.prod.outlook.com (2603:10a6:800:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 15:34:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:34:13 +0000
Date: Mon, 19 Feb 2024 10:34:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
Message-ID: <ZdN06tsJH7A0o6fv@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <ZdNx9op+MhzF5FNB@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdNx9op+MhzF5FNB@lpieralisi>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: df2c534f-2686-4bb2-c705-08dc3160397d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u6zUxPpwuxWYkphyOhIe1m+tX79Fqwxw1oVN8vQbpzxVncfTp8WzB52XjauuPLyOLfEUJCQ0E3ucRFjUGphSa2GBhy5khGdRtb4rYFMNWGtbaYROdgmcB2JxVMCUpIO+GxbqSgQO1AliUfTIikqiTGdU3AVRI4Hl4A+CO9iymatzBNWgckbuJOywOyKBkxGHjB2vuCue7Op1hZ6z+RjTYtkB04ZVNjOMzGrKDoMn/wmfPH84r0I7UkzpN1gJpnF+PcJT3iJRkqR+8uCann1HmH9zIHKhNMk2BmbZ9AXIx8j2HKJeV5Y5Yf6Lr00HH+PNNJRYKd8ot1IUqm8zKau2nPJwKAfNnRNBSTSddz4TGXmkUr65y6ScgAzExWlNi+RtuoYB3nuZ/qrGaHmfEfjcKDZAuFsnP3l0o6wVrkGIxQhVj7OYiOQQlDCu7nQRclRDizQYywSZDxlBkqO2kUkUCRWen+sl/ogcSkpjYJCbO7LArzUkg399/UVCual+rruLefTN79D8xVstmwgF383BsSUKh598K6xmCMWT2RodYvJJFN99jYKvFwEhBinMEGxWnSeUAflCi5IR9/0X6EJPfIryW7hh+cfc2X5znWEjaAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mlnHmUlupXTePFReBxrcYKnSr/gRZdteDJIdA6/rxvsHd8bs/OLxuZ69Xkk/?=
 =?us-ascii?Q?o/Rh+Rpm9oHYscYYw86OD6iHUkcl2W0LlrggCR5EZHAuFufH8oD5XcB6W5l9?=
 =?us-ascii?Q?50RO72DfENJd1Bp2UTbfDm6QSdQeyWuqpubMdFfBnsws7mjQ2h7DGsASWi6o?=
 =?us-ascii?Q?Ozu5x0Jl7CoP3bPV91fjwIA3itdhkkRjvrU1a9aH9AE6PVYRonfu6s4oiCTY?=
 =?us-ascii?Q?Vsi6TsoqsTDPzpkmOEhmN8/WY5JydAEUW/ieH3KEkyGOfrDbZn8T2lPVFCM1?=
 =?us-ascii?Q?N8WJ/oT939perWKm/yufFGIzDjSr8qA+U2rypb8RwdWQNdlSQ1cuDHGxDnJV?=
 =?us-ascii?Q?c5IqcTlcUsHFRQ2dYV6t1FUQAGkvEIXIy6F9ZI83smExSm8vvP2nKGJdZGES?=
 =?us-ascii?Q?Lue3UnFvmjV9RghbuFg+BQeYvpB5S39R9h5ELM2u6AfvkZbuwHVyTQLYLFmt?=
 =?us-ascii?Q?MvRM+1HtV3cowLzNLHiSBmJlnjoe3+nOdUnLccboENmhXVD9/dSjx9PSlLzh?=
 =?us-ascii?Q?NaHAD3chj2phxmjTp94GOoggqsP60gT4dFxO6hrHXXwyWbtjkgCz1tT6HFXW?=
 =?us-ascii?Q?cJanC+8YZWOdkGY2RQtWdAVjnBcyK1bdHcuDBJTn/WopvX9Xc6P+m1ASQPRy?=
 =?us-ascii?Q?SuSRwlhYaTwkuDTPpOQ+FZXBCZ5NPNiZ48OUcMuQgk4mAO4EAFKTaxS7Bj54?=
 =?us-ascii?Q?QySPQHUvQFdm/XCejUI9jLkPqOCk52LKOQrAChvg1pS20Gg8d5+w7jnZV1Zj?=
 =?us-ascii?Q?IH1JsQ/LsI8vhhssAg5wXsTZ211dPxpwbZ79+Ofe/0iv84SO1Zc/ZnHp/X5k?=
 =?us-ascii?Q?SJUc9DYWJQXSjcmMgQnLgkLh9jRK0yRm4MR1gXK8iKEkBQT5zH05I4xy+EJy?=
 =?us-ascii?Q?ZZbT1hBetA/XYneomppM+1mmV0aZ6/fRQbpyk7iXlGvWy5sncQkUUqGx3JjP?=
 =?us-ascii?Q?WU3wdvlHLkrZ4IQZqIAtVCyzORvOSknTSrfVDSXPdF2opDJkR5LcrGG8BRw4?=
 =?us-ascii?Q?ohPrNpgSUdW/4FUBZF6EoP5mPI4uZh4P1GK8vLhdxPFTreJgJngOSGdNopjb?=
 =?us-ascii?Q?64u3QGgpYyy7pDwtOCZ6DcJuTEcpRUahNrrGfmMfUXmaVCT/o0jQOSMNAPUx?=
 =?us-ascii?Q?MWXLnq7J6n371UlaafrhTw/bX3sCjDlqLkyoiffoQ+HNA9+mOKI0bqsh1hPu?=
 =?us-ascii?Q?H38ZLVSfxTifdS/gdgF+G+r9pDuMONPu0QlEyPthm6tRKFghN7I2HMMjsd9/?=
 =?us-ascii?Q?yAkKYPa3zrl1btXGqvbNV0U/rTcv7Q1KvZEvxY4HnksvFXaev16xcM2HZTP9?=
 =?us-ascii?Q?spxZcPbd+I0u9RjE+Yo1r1mmT0dcz3MkE1ghbedXpz4xnUSAiB/pWDx0rdFR?=
 =?us-ascii?Q?iq+qHoVpoGfA/X7Yoo50hX6tS3ByxYK4rVKtnu7y/JVDJqOg/4F+RydubCY/?=
 =?us-ascii?Q?cNikBAn+BJp5YyM96/Cnb35tLErDo/empLooTJPyyTTwivucNo/N9rOphNok?=
 =?us-ascii?Q?O34goX8TvGkL016cPAkCrv8Xmsc62Ksj05gIOHdrtBld1XtIFECJh1WtXZR/?=
 =?us-ascii?Q?Ds/7oZgkKqkTxrr7rCxQ193J7JJjyS05NXwsDByj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c534f-2686-4bb2-c705-08dc3160397d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:34:13.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrGery7/FW1w2vfFz3Aip2ZLgFONizZ7MSKkSZbY421dWi5R/fDNzCzjJJi0q/0ACAXXS9yZebNjd52lNtSZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9979

On Mon, Feb 19, 2024 at 04:21:26PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > Improve maintaince and easy to read code.
> > > 
> > 
> > @Lorenzo Pieralisi:
> > 
> > 	Do you have chance to look other patches?
> 
> Yes, they are fine.
> 
> > 	Mani's apply EP side change. 
> > 	'PCI: imx6: Add iMX95 Endpoint (EP) support' need be rebased. 
> 
> What does that mean ? I think it is best to pull the series in a single
> branch if there are not any dependencies on other branches.

Two options:

Options 1:
	Merge 1-13. Left 'PCI: imx6: Add iMX95 Endpoint (EP) support'.
I will send out later with other clean up patches.

Options 2:
	I rebase to https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=endpoint
	After Bjorn Helgaas merge to next, you can pick all.

I perfer opitons 1.

Frank

> 
> Thanks,
> Lorenzo
> 
> > Frank
> > 
> > > Then add imx95 basic pci host function.
> > > 
> > > follow two patch do endpoint code clean up.
> > > Then add imx95 basic endpont function.
> > > 
> > > Compared with v2, added EP function support and some fixes,  please change
> > > notes at each patches.
> > > 
> > > Change from v9 to v10
> > > - remove two patches:
> > > >   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
> > > >   PCI: imx6: Using "linux,pci-domain" as slot ID
> > > it is not good solution to fixed hardcode check to get controller id.
> > > Will see better solution later.
> > > 
> > > dt-binding pass pcie node:
> > > 
> > > pcie0: pcie@4c300000 {
> > >                         compatible = "fsl,imx95-pcie";
> > >                         reg = <0 0x4c300000 0 0x40000>,
> > >                                 <0 0x4c360000 0 0x10000>,
> > >                                 <0 0x4c340000 0 0x20000>,
> > >                                 <0 0x60100000 0 0xfe00000>;
> > >                         reg-names = "dbi", "atu", "app", "config";
> > >                         #address-cells = <3>;
> > >                         #size-cells = <2>;
> > >                         device_type = "pci";
> > >                         linux,pci-domain = <0>;
> > >                         bus-range = <0x00 0xff>;
> > >                         ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
> > >                                  <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
> > >                         num-lanes = <1>;
> > >                         num-viewport = <8>;
> > >                         interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> > >                         interrupt-names = "msi";
> > >                         #interrupt-cells = <1>;
> > >                         interrupt-map-mask = <0 0 0 0x7>;
> > >                         interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> > >                         fsl,max-link-speed = <3>;
> > >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> > >                         assigned-clock-parents = <0>, <0>,
> > >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > >                         /* 0x30~0x37 stream id for pci0 */
> > >                         /*
> > >                          * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
> > >                          * <0x100 &apps_smmu 0x31 0x1>;
> > >                          */
> > >                         status = "disabled";
> > >                 };
> > > 
> > > pcie1: pcie-ep@4c380000 {
> > >                         compatible = "fsl,imx95-pcie-ep";
> > >                         reg = <0 0x4c380000 0 0x20000>,
> > >                               <0 0x4c3e0000 0 0x1000>,
> > >                               <0 0x4c3a0000 0 0x1000>,
> > >                               <0 0x4c3c0000 0 0x10000>,
> > >                               <0 0x4c3f0000 0 0x10000>,
> > >                               <0xa 0 1 0>;
> > >                         reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> > >                         interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
> > >                         interrupt-names = "dma";
> > >                         fsl,max-link-speed = <3>;
> > >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> > >                         assigned-clock-parents = <0>, <0>,
> > >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > >                         status = "disabled";
> > >                 };
> > > 
> > > Frank Li (13):
> > >   PCI: imx6: Simplify clock handling by using clk_bulk*() function
> > >   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
> > >   PCI: imx6: Simplify reset handling by using by using
> > >     *_FLAG_HAS_*_RESET
> > >   PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
> > >   PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
> > >   PCI: imx6: Simplify switch-case logic by involve init_phy callback
> > >   dt-bindings: imx6q-pcie: Clean up irrationality clocks check
> > >   dt-bindings: imx6q-pcie: Restruct reg and reg-name
> > >   PCI: imx6: Add iMX95 PCIe Root Complex support
> > >   PCI: imx6: Clean up get addr_space code
> > >   PCI: imx6: Add epc_features in imx6_pcie_drvdata
> > >   dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
> > >   PCI: imx6: Add iMX95 Endpoint (EP) support
> > > 
> > > Richard Zhu (1):
> > >   dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
> > > 
> > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
> > >  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  46 +-
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c         | 634 ++++++++++--------
> > >  4 files changed, 436 insertions(+), 310 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 

