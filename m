Return-Path: <linux-pci+bounces-2551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DAB83C69B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F4E28E895
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C66EB6A;
	Thu, 25 Jan 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijNHiB46"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5973160;
	Thu, 25 Jan 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196677; cv=fail; b=UI0GHBm8gn6ulajjS2ar2RfRZouYi11QLNz/EjMxgyM0jaG7MAI32Sls561mTY7SG6XVrHRT11IdBh2uLjsXB+UI1IzgOVLtpAv+cQE/u0UlX0lEhnSNrKVIc+rA7o3eD1yStzRoH6D7n7ysGIHlBzqPMqHJE0QlW18tubEIEXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196677; c=relaxed/simple;
	bh=E95Hl7N5eLEw4PmDTbEsfKwYVZwr9QT36k92cjo1khw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkPshStFBJeOVLnAx0yZ1ree/VLs2w6QOtmtU0yyvQOUEASkF0MZfoAhZIRxnUmukoXU9i8y0J6qwoZFGM0heExAIHJz2uNzfiUNereGAAXwmXH6LdMdvTVvqI+lX6hLwHYsQPc5j7/eex/2iyRE8G62nKrb1LXamx4ItKxt59Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ijNHiB46; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4/KleVyGWJWyoddy5jLK07ymEmdqeNI14FXvsLrg4L+UMGkF2ztR28wIjA1h8nYlxLzKrl3KYrO3w3nWhCoee3rpEml3pnGbY29EFD6s+q17141t9AOxpgH1fuMiXqaHaJLJxMe87fvcMV04fpQ6yk+SrOSgm3e9pQF0jgbhLEGTdsnh+wM4JC5uBquHzoT6TfiM1XsZne9q2VeucDEqggi0UQMjA5/OOhRClyb2ZUXIylUh6xNRUlH1Us3gqcjn2AzdS99CvORGsCQdFHnEd27hbJNAdT9rDQ8hs20bjazz4hQHztwsF06zpQsoptyOPr9z0EUdb19P2F0rIoiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuK+sVzB8Zi28Icf0Hx5lsUjWE4gViG8lvMZqWp93KE=;
 b=Vz1ryrP3vAROkTsamGPw6IYky+32Dr6JwOLdjpgFZpAT9rw0UrClcLjnZvdoNvnOYGA/lrHL2cRuuEGbMml8u9BU8DocX49/qpMDoektQxSJ8HuYYEextC7n4XQAzkl9HIGKOty1bjXtixcjqZrrdwGSO2HP2Sp5QzdqyfX/sB3jd8bST8VkJM4OqPM4RNG9fyy2jFAvvlhjuLUfYjNaDGyfz/z23mmNPB+vLcQhPrdOeM1EqDafZeoDkEt8t3tmwdxcIWjd5HbufELCE3YQJnHRhwDnXWwSGnfysykkwgYiy8CKO0b98TY1UVunWRC3rNhA9vs2RjajcHX9Tij3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuK+sVzB8Zi28Icf0Hx5lsUjWE4gViG8lvMZqWp93KE=;
 b=ijNHiB46Jk4PCuBtzSxhIKqUY3V6QjrZKtUIr457hdVQPZtcyJgYUyBsfoNbU2tWr4XMtK6d4FmqRAEOa9TQwNEYYHVNz8fhqvnKCw+2Fs+krEIY1YrO4Px6WRUwuGEegZpRY7ncDNg8HQZ9hgROKOR36qCVeVPfY0StkVLK17Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10033.eurprd04.prod.outlook.com (2603:10a6:10:4ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Thu, 25 Jan
 2024 15:31:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 15:31:10 +0000
Date: Thu, 25 Jan 2024 10:31:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: lpieralisi@kernel.org
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 00/16] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZbJ+tFPn3aOYHCwf@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: d8605673-200c-4f41-f85a-08dc1dbaa81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zGmV+A4bdVCcAF6Kx2pSWCu56Qlpw8xqjGdRRYgIPygGNiNdwINuj28Etx534UXe03jueJqDcx+JV46fsmDeoRxyDDNvP6EtXtEGRw/7fKr1IIKZzQS8uZD2WQfB5dU+FUN95W9m8R2UrMGUzWIXJzWvMz2ZhfW894A4wBGGY/HdEr4nAiv7JdJB37glv0UuSU303qOl5CBfa1KMWmfoZcVmwHdKMZn8yQRbRDzBUtkLrhGgHhIEwmx3wpDiqRMbDAm3ULTZPzZ9vvxeIKDseicWkSqtJsx8NbXGOQT6F+TJe54QJuV+4CwN3WeWq72uIDBcpkKpW32lvvynSEOhbcPLLGBGrmitzTIo8/cyAGBonO5ZrBLN2G+aZDBBeDC7TY0aCznb07+LM4JZzZPKhN3j6U2xcf2C87lbZmm0GXcjxJMsbjhptqRyUaM17adW1BTFnWZpbE52qgXRXgKKMH4bo2DoArOlS0U+UjNsxfNw4MN2Qdbyju4/MeLFEShP2vTISc60krsbTPPEezvZge7/fbNLcRRcWp1M/T9DI94YXqSHCyGpheO7dZzCOhEx00L0/1k2EcRxhHuBbZEIWgdYtE59ZTXl5ngtHssDvV9tlvGqRd7oOG9oLs7TL4XdWFHONFkrOyx6LOTUAFKe4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(6506007)(6666004)(52116002)(86362001)(41300700001)(38100700002)(33716001)(83380400001)(6916009)(8936002)(66476007)(4326008)(478600001)(26005)(6512007)(2906002)(66946007)(6486002)(316002)(7416002)(9686003)(66556008)(8676002)(38350700005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kivEgaLCE/VjxEnwqFJbv1jTUXm1uv5JOK0HKkdM28i7yIDpqhh5+jay1Krd?=
 =?us-ascii?Q?j0VjS1qiuR2kVz0PfwIPB96/J9ytST5sl+A+Kvh9iT2w89RJwtT64vZXEj7u?=
 =?us-ascii?Q?oRuv9l2Vdv0wzIaXlzVGnPDGIgo0+LwkKmUA64MgyoiwyyBiQniafHonxwPt?=
 =?us-ascii?Q?W/aQRucj6a/i13L9TYK8tlla79CkUbxTM01mZHlvoY36AYzQBgl1rOW7217Q?=
 =?us-ascii?Q?7goIfAiO5FkqRQyQ7xzuTclZCcMW7gP1Vnxbo3NpAW0+58D+M9wrezQnsxlw?=
 =?us-ascii?Q?6O19k6dki26v+/1rh7JNX9tyTGhuEMuuLX8VmfvtOhVxt9Ch8WO51qlDtfEX?=
 =?us-ascii?Q?OVoubpYTQW+CMDoar5HM/m6+mMhdKP+HZW/TyCfU6umpkxqCcykq5vyyfCrK?=
 =?us-ascii?Q?hkV+he+IIz988X+1YzEGGqT4xHLlvBL8P2V1KhLmogE/xg4DinunAgi8iZ5Q?=
 =?us-ascii?Q?r1l+6VhSxgF+lcMXWiVNxBkum9MKNJNpu3ewXQpXzjK6+F63Q5yRZDaz4In+?=
 =?us-ascii?Q?F3Ba1xoZ/kHgcJhiYJUfy2J/ylT/G6NHaahf1yGb+qp4hN23MHBLJroocfp9?=
 =?us-ascii?Q?p1ahm31nVeNNDOm0uGOIMPsvP36/vx2V8GHns8Mtx/v4S6BZ0NrzKRPVthDD?=
 =?us-ascii?Q?P6mwkqoQAY05+2DfmEcREvUreLjV8incxIURmhbzzgmJL6L9Wp6jZwVQnbn9?=
 =?us-ascii?Q?r7AY0Cr23vcOIP+KUwhfW7e37ouUpb6fiqd9Ll1Tx/AJuEZT/0AoDfPLtRTq?=
 =?us-ascii?Q?MbYJE9egPyuf8/UmTxvx3H+wT33GHkeqXc+BdPb8gWILfGhwwX6QMxCYdXOT?=
 =?us-ascii?Q?0Ug3jmqvBTvILhRxM6sMb98wZHD4Gs39QBz+55d4g9V0PFPpHW23BFEyxOGd?=
 =?us-ascii?Q?avbxTX6sNkgbdNR7QgVa2bABsp5k691vutrrPWSVTVuCB9ahh8FvV7Ov4SWW?=
 =?us-ascii?Q?KwFXm5ciH5jJ9WB7rSnZsVp6nXcaOJ5nDJrePr0psSMRW7OoK+cJsoKkQW/U?=
 =?us-ascii?Q?GScb9AYrNWnURN0Ru+XoZBKoGjNPuAX1vJ/DmQhhczCllwxbRqdcYnz8dc06?=
 =?us-ascii?Q?+/fmYDewqfrxscbUJdpE6no/MVVr5I4Ia8+2/EfBDowAWr/Hzh6XpKwyGbzy?=
 =?us-ascii?Q?RR8LzdCE8DWDdSNYwBN+8btzs/t796PlDYYvq1OrW4XYTKqiEOT7+Fw0mzII?=
 =?us-ascii?Q?jKrPhqxqE1Ansl9sEEokK0yeivv2gaoSRNsTcyN6jtk8FZoOViD/TCsZnlha?=
 =?us-ascii?Q?Byavlk4Mcr0E+bagAFvTsW3LCD1KfK/1uFthzI296KM8EB37UTqgKiyLufT8?=
 =?us-ascii?Q?f8fzzj+TAC+b92fYM57xM89BpsIPurDJarUu/jWlxrYFveRsjHNxpGv3Tesw?=
 =?us-ascii?Q?wPsIrjPv35tN7o6LEiYDcpNewrv2auGJICBChA/e/xX/JKrXojGg9Gj7Xdrw?=
 =?us-ascii?Q?BsDYLTW3zvQYmbycUfCvgVdaSoS66U2wVX+lLxDA1mVBXKnisJK9tjmCjTQA?=
 =?us-ascii?Q?LwD/rQNmXBbO9FezIu4FFyoeO1n+TA2EZLgDXZt19tsHw3epJd4BXXMxdvEz?=
 =?us-ascii?Q?KDGe/7oGmAT8Tz2Hv9LuPaQxw/jFrZm5EAYOVXtJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8605673-200c-4f41-f85a-08dc1dbaa81c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:31:10.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7qhRlEYX3cHZxoB6CF5udOF4mDowYw1IwE2ZH5NHLieANJr97WxArsgA5bZSttVAX27b4mzCQ8OGK8SsImoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10033

On Fri, Jan 19, 2024 at 12:11:06PM -0500, Frank Li wrote:
> first 6 patches use drvdata: flags to simplify some switch-case code.
> Improve maintaince and easy to read code.

@lpieralisi:

	Could you please pick up these patches? All already reviewed by
Mani. dt-binding part acked by rob/krzysztof. Add it only impact freecale
imx platform.

Frank

> 
> Then add imx95 basic pci host function.
> 
> follow two patch do endpoint code clean up.
> Then add imx95 basic endpont function.
> 
> Compared with v2, added EP function support and some fixes,  please change
> notes at each patches.
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
> Frank Li (15):
>   PCI: imx6: Simplify clock handling by using clk_bulk*() function
>   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
>   PCI: imx6: Simplify reset handling by using by using
>     *_FLAG_HAS_*_RESET
>   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
>   PCI: imx6: Using "linux,pci-domain" as slot ID
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
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  28 +-
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  57 +-
>  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 640 ++++++++++--------
>  4 files changed, 462 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 

