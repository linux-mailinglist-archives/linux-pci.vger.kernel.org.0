Return-Path: <linux-pci+bounces-2180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A874082E0EA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 20:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC124B20A50
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E818E1A;
	Mon, 15 Jan 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jAZGf4vf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF318E1D;
	Mon, 15 Jan 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjpQ3ijf7WiB2OVOO7W4t2UvlHCzwaCZvTn6RZ9f2Ri7DdqoHVZgtd+QUFlkWwWG+wneDDawc+R6MGGgYbBA3pBMUmppWxigXwGUWSAYj5ShBFYGi4Pyk+vvPn9WGzNp1SHuOhfXVSpzMgG9ULuB4OF0Gg5fqlUtCoR42xQEDbVE/Pp+PoqT6zb+eQR/6xKIdSwJJGDn85/UAsOi1f8yctu+coW50zAy1H91C0qQ1sCaJQ6QChxqNuGTGbx1flqG5bbsand3fTsaq9WFg6HjJsUxGF50ioVJabqoEPsqUqZdQpJagt1ogc6Qye6HNHQ522vWsj4GdknYKBU3g2rRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxq+otVah8Teg7kLbc9Ha1w96sI48h60tR+nIhWNVAE=;
 b=aRK3AYwGEldEHprO2+bIqMnvpcZ+WTF4CwQWilfFaE4h7DyvZtTQoBhnYSkh27KaAQ65NW3+hkJqBtc8zN5CyC4BKkv43Zv5sb0bkzfbo940d/o5MG+DdTgDOqOgt/rAoUcsU+x0xk1gBuPXfBvuFHOcgzQ1YrQtEsbOVUjMG3OUZfPQn6TMgcicYGpKqMLimuVHYayMcxbVeq1SwhcPQYUWtaKsr+8bkLy2wwVNddDz+grP3qnoNiaWsrMYkGYb763oSN78F6sUH6rCM5ifaoZPXI0Gur6UivysV/z1XnPjCfJdPb3jNNktgu+l/eFXTD2jrGOecf4um3w5wZBkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxq+otVah8Teg7kLbc9Ha1w96sI48h60tR+nIhWNVAE=;
 b=jAZGf4vfC3B86ir18C24774EBbCG6lzxWOp2K/17pIRZXZkLyxPy22mzAPcrEPqKr53ismctzgx/gHxNoiZT8W4VZEZPnjTZQF3dDw9o+Y8Rx2XiYd+OXhT4gcIVf3rTHMAHaR6YblYU9ToZqEQ7V9SUIsGG2/tIp0NjQtEH2HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 19:47:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:47:53 +0000
Date: Mon, 15 Jan 2024 14:47:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v8 00/16] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZaWL4QPNwjaeCenJ@lizhi-Precision-Tower-5810>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c6eae4-1fe7-498e-d73b-08dc1602dcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mGElLIlG8lDyk1w6nA1S6FOuiUb7GWddPJM5HCdh5cJghC7KT0e5fpfUrsijaHzlffaq9qXyx3ezc8sPFMiP/yXMYbJ/e3veUubuZzIPo1xwgfl6tVJ219P5KpT7h6Khg8mOSOJYrp/E/koY1pAtlkyBbuepCsihKbpCfCqbTzWPnlwDPIn+NfTYqAo8xWh7N7JhcMlaib1ZZMsA5lhTAdbDVEYNyrsEX4PrjLD4skHfvdBiuCZqLAe5GJMQ/T2mGg580bNBl19rNepxOnLbc/gvIgGpECfMuLF3kp4ctnk1YqDMVmEa45IG8AWMDyGQeNW1+BLllhnFPea9ED0GEf35qKkPunMaSDf3vBpEGIj9jqU08WMUtFQlOmIvsEMJKVYU4M+6Duy40795YSLjlVKfHsSkFERM98FEn2QOjOiccQNTB9kD/oqFb8h/M2z3BEhdj3IE/EYhe1rKrDzvg6iW23R8e2yI5qUK/zd0ZRREKmicfnGpJWdMkAO7il3jvuJs0COU4MPTRPGw7A/TDcvpfdliCdgJ9NPQtoe+O3nnKPQlDn/HpXAl215vy6eoQpw5/il7N6boFKqlFW0acJEVIQ2FUwdrNryJ1y8WUCN7jxTfNJmX9AOhvxis/7VG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(86362001)(52116002)(9686003)(6666004)(83380400001)(6512007)(38100700002)(38350700005)(6916009)(5660300002)(7416002)(4326008)(6506007)(2906002)(66946007)(66556008)(66476007)(8936002)(316002)(41300700001)(478600001)(33716001)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cEx7eL8xWGkKJbUg9S2q01OazDlSxnsAOKiaaJo4XPW5gZoy7ryjs5wRzLGy?=
 =?us-ascii?Q?V2UGDva2N2K8HfAp5wnrgPPuj+fWv/JSmbK1pv8KyrhiBDtk6B68PKKql5mt?=
 =?us-ascii?Q?KS9jHnlirF+syqyVH4EF8NsI7g2llsifTsfW6KUwYi+yuUoWglIvKdMRXRDd?=
 =?us-ascii?Q?SZl2e5JHZoaWG7MCQasrwbxQ/2CXWEuJuhGguiVsSsJzEuxvrPcPGlvEriNE?=
 =?us-ascii?Q?N7gAVL7M630causnlnAwCP4+0oNd7XU/NU3Z+ATPcIRit8TQXNtV01ldllJ5?=
 =?us-ascii?Q?c5eAN5721CFuKnTGpxo6NFCmna1CqonNtNCfZcUH6iGU9tJSTj7UFF4jJZyO?=
 =?us-ascii?Q?+qLK6DaaN4gr0AWJBXe29QIjJlBkroJcfSZHU3nyLR2gXjDI30oGV1oxKAn/?=
 =?us-ascii?Q?FadUQYRo3KHF9SzvTng3vrgHOhMxpQP5lejZBcDM0vbFad+nXetykaDhRHOx?=
 =?us-ascii?Q?950ovRt3LoliFDd4nWBflhNzf4N5ulC+9SVayaVkXGZhcAfirGxsP25yigNv?=
 =?us-ascii?Q?5uepXpu9PsBWLZQc6yP8S0/+kP1ul1LEVCkowEeou0utN+GgQO4rPbj+AJLt?=
 =?us-ascii?Q?qjR4jgD4fK+wCgeR/jy9xndPBnt3xXcIaOaIC82vmMU/cr76xJFkojbqC0fF?=
 =?us-ascii?Q?kq+NTxtkh9fAk6FL+AIyLU0TZTfoTxn+BlpjmRx0twTnLJAtLd1x2Zh40lTw?=
 =?us-ascii?Q?fV5DTeE29HUF9s+ihI2o9hwUaZp4EoqXSp17Luqav38rgBULmH7LU9a31sQw?=
 =?us-ascii?Q?mZCh+f0bxjW3+E8l2tIFpitC1jSdMSH+IMfRjZdLRt8/E8kRxOdkG6ScdQ/6?=
 =?us-ascii?Q?xsKT+KnvohwZjqII+xFvr2L2KtdHdzLwohpyrrAp6Uxz0JJqIe8v5U/vWF6W?=
 =?us-ascii?Q?cfJwPO5vGiv+eRl5uGOfy8Rr2FzfFL97kdGAHJ1mv0dfhGDaZJ+G+H08xTPl?=
 =?us-ascii?Q?M0508qqrkejK4uCRRHWeu6z3WQTMWaKwVDIgDYI/57QSa5wBUJwYHhph/XNL?=
 =?us-ascii?Q?oK2SbZLXNBIDaAW22xpZgXogZRiQYww6dcJKjZFtKucJJRuT5cfTTdpVW4nk?=
 =?us-ascii?Q?o6QDrhAbnFeapxNyu6k7aW2Ckat2zJKN6eEyXDyM0ZbilJPs+k1k+W1cxx34?=
 =?us-ascii?Q?xhqt+2Y8giwNKVKizTxkhe2bHzH4dJ5I0R+eoZzCiYTdh+vWW4gmst6+z5NI?=
 =?us-ascii?Q?etCA7den3u4739AJG/WszDsoSZA9Qwa6nr0KWdFeiY6IoG+bh7vRmrfmYRCE?=
 =?us-ascii?Q?h1IPyFael2hQk7dev/RyqrCNJP9yfqVNCYPOHqt+ZVrIbKfchpIOOLfDwv8n?=
 =?us-ascii?Q?mj727F1Sp/OjiFK2hHJihkU4qya85tIelN5SWut13rz3ws/T5Stmj/VbW3u/?=
 =?us-ascii?Q?vrcFCXElTyPx88EVf4OeI0czrxH1QVr/T6oxOWa93Sf5zqF6vbMQ+AqBoTMF?=
 =?us-ascii?Q?VmZF65tufNmhUiH60HbDfQU2BlIBTCdmd2E6yUPdSS2LTYxs6Z8QfPOyXtf8?=
 =?us-ascii?Q?FP8cRWKhhUuyNR9FRZEStzrF8dyAOINPGRiJJrjShBTzebxPGP4lJN7iqEWd?=
 =?us-ascii?Q?mYW9FIvT7ro61DhNErU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c6eae4-1fe7-498e-d73b-08dc1602dcfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:47:53.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvcSQ/9y+QuPpteioQo14Zmb087x6uSkdlP7sudUOI8P7SF9gET2mhZutkDGcFmj0mRAKHCiWRIGqPCfS3mOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200

On Mon, Jan 08, 2024 at 06:21:29PM -0500, Frank Li wrote:
> first 6 patches use drvdata: flags to simplify some switch-case code.
> Improve maintaince and easy to read code.

@manivannan:
	Could you help review these? most of these patch have gotten your
review tag. 

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
>   dt-bindings: imx6q-pcie: restruct reg and reg-name
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
>  drivers/pci/controller/dwc/pci-imx6.c         | 643 ++++++++++--------
>  4 files changed, 465 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 

