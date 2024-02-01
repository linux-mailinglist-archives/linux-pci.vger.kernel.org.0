Return-Path: <linux-pci+bounces-2960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BA846107
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232E11C22BD7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68427C6C1;
	Thu,  1 Feb 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EKTok//Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C06D39;
	Thu,  1 Feb 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816090; cv=fail; b=Z3WgZDfQlYEdvgJ+ygvYdZ2tF79Suug6D9CalajeMch5Jx5oGYuTCRhJtcNKklzsvvs8Wza/sSbXkFGhbsk5BMGHu9hjoa9cKD50Oes7aefUD9Bwak3BKHbbZPi+I6ItjZ8QqSWRIb/w2wjJ17d5OyAVtyWDHElkJDdCd4RiSuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816090; c=relaxed/simple;
	bh=xnRIoJ6AiZS10gWuN67w/G+gNgc9zxTSQEKl1D69blg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejKIbdHNXDBEO3pyJMGU+qGGEGSA2pTsMIvlkum75BNXR9QmXD+TWdo/eQV/iODp2Js+fXj3HCiBiDMbEcdpH20dexXeuHRt5WtJMI0rPNakA3yaiqUTQd5dfGtWtoTEtZqeMwA+Zy1N4JNcPH4cKzBxONSJixCnnJihc/En94U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EKTok//Z; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGJe13h0ZseK8CZz20jJLRUIi05chbDtXp5KzHBJzRylgPZgXz7HlkeybRG7tZ2QAVbabTHDMHVc0b/Uf3mZjX+AcGRQ5dwb4usjuYWOB0xtsiRxLbUOiB64ETuTfJuDEp7S2Bua2O6QzS5RLq0DSGV2MY0ytwkmFErSiN6XMWe0HPCvwHPSsvn0xGBEGLZbF+XyDF3VX6nTrVOVlz73a+PAZDYPmpGJwemVROJWvw0/o1QlcOaq8WisY7xp+pE5JmCh1lEg2YAUMvohWpB7T+Wro6InUvcS5j1EmZiYlCO14wsXFdIUdQgvn8pCE2ZIlrpqJQ9XrPpKM/cdAMo43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWebouwHUeRue3naTcBsbGG+L+tUDNNpwmttNC1hFEs=;
 b=Qul5H7CgzEOJc0dRxcH60FVIyULsVUDYu1STMlYCR/vNnaeJfKfFfqxKKQn3nUzc58Vzx7FNiYoVSy/Vcf01C/OPZuUnfKNom0lOPNFL4sD8QDeBUAIpAPGVkFRq9gwDI4WbDLB1VP9ClMyUEyH53+ZYsInkNpBWGa8Q6Ni5vf9roE7AdBC3jAbzFmJahCF+bW1U5H4KVhKZ/94JhdBUotxcGYGCjHva0BVWNoxvZeI3Q3Se+loAataHOaFrNP1r/+7fnmXvXDNsBe3C2Ci2MXWWSQJ4SmXN11OuN8gieA1e3LPgwXr1J45UOHNEXeJkwe0dzR6R33IgAppHSxDRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWebouwHUeRue3naTcBsbGG+L+tUDNNpwmttNC1hFEs=;
 b=EKTok//ZOA5sBfijJmRXTq/Tzwo8xXVkt+ELF5AYtHKZiFUm7YeMwLbEFOBCQ/m0OwwZm2XOZtjFpKQ70P4biyZfIyQksx275ghcjVcsqtuhtMedXDDaqYCTAQEJjNv5KCdP+xLCGu7Ybd1QMj0kZZrPcwwz60qAzDUxsOhhnMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7748.eurprd04.prod.outlook.com (2603:10a6:20b:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 19:34:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 19:34:44 +0000
Date: Thu, 1 Feb 2024 14:34:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: lpieralisi@kernel.org
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v9 00/16] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZbvySvCoeNbBxYjW@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <ZbJ+tFPn3aOYHCwf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbJ+tFPn3aOYHCwf@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY5PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:a03:167::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d67b7-d0cd-47f2-47cb-08dc235cd7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1WPaoQR5Y8GTG+3FB2NdrYHTSTuJYnR74DWBth3GDVtk+6+D3W+VKdP3dkKuew9BkegnY8xTzfFXl3iY1p2GKpgY5cwvlh79auoAYbQexX4h0J60Z+JPGk8dwzTSZwhurd/s4Y4L+vt5Du0r1+ybxynsAyxh4PrNwGaw7xGJ+kAoknOTc9YzaPza8ehJMB+BfD4YgEbStjsHHIdVr6Jt/3DjrAOd6UIXTxFsE5T8gH0uhp0Yo5RL1o470PNz/X8euXAnVlyST8v2YPDpcB79g357jladdtYl0yDZQxQTO1Hd5VyzZLYE2ILhw2LqO2olwLcBpkAXTW0aoI4dfXhThXfzWonG58RdyvONDzHe2W2dSMgJKon8FiSPFmzkCqfPMsGzRjfioTkKf66psjbf3hw8uP/kwU1acCQ7fmRCr7VOnMUt5uwPuo4D4x8L1ct6PhLgVobeBo7tkgPT2c/+dUTRj+JVEERaopcNNKGMPf8X+DOZucOzmG+/X8jD6Pygy0Qe5Amlw8SqtTqxPHgiadLSO2vZNablLfC+D+3F96fMCr1ggghxPZCZJDjxI8g5oJpap8KCZPpcf68qG3NbC7rWHmqgSqskR9gautYhGqwrFkLQiYA2e6ufhf5XPzAI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6512007)(9686003)(33716001)(26005)(38100700002)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(478600001)(6486002)(6506007)(52116002)(6666004)(66476007)(66556008)(66946007)(6916009)(316002)(38350700005)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mtu1h8UfM8moQ0VznFEr2luoPGF7ewG4/3iXH10q/ol2YrxlY+OyZtovflzW?=
 =?us-ascii?Q?ozn6hdBovtLk9odqoRub9gU12NK2IvWXb8XRRH9MXqSfbbdZSHX3FbPLemEP?=
 =?us-ascii?Q?f5DbCDCx228MZeA7JChLu9Z0m7p/9oUb2O0OffMKMKFsDzEvzca/hn6QjXG9?=
 =?us-ascii?Q?UIIll23saton3a5SNLLT9EiHjteQhTMDZuVNjvRaadx51ieMXlYSASlCMSkf?=
 =?us-ascii?Q?JbZdoK8GdZqOyw3/e2XQNwtAZPHVawHP824PKyxUjbZcXgeTBqNTkXBBF2t9?=
 =?us-ascii?Q?TQqRJXqBFnbPme6sMygNAqpZhBljCuMQ6t6f8fTWaRmsqOdYt3HGbB9FE48K?=
 =?us-ascii?Q?zfPumSvNbF9uQavVnyD3lGVDsdAh7xZAX1h84qStdMAJBM/BQdrJM92YR2x2?=
 =?us-ascii?Q?pZEpkLqgV2IzFLiw2n6ijAAFV6/NntnSgOwjLv1iKSN4U4SQDo2oYlxIc7/B?=
 =?us-ascii?Q?y2oJhcKuwKW2D97oIQUJ7ihz1WbqU85/aZNEe90cedN4kyPph1bgRR7l5nR7?=
 =?us-ascii?Q?Dp/LxEij+4wbZbSGOduuOZb6mhCFG/faJ9qd3bxFNgot+f8RE7kpwhhjCBdU?=
 =?us-ascii?Q?BX0onx9bEcJ0p/6Tq1FFDE6iXdPLbrAdt2RDrG1q/EeCAEbENdMcHy9iLAnj?=
 =?us-ascii?Q?Bkiw8iQPqYhGPxi/wUWKxqH1tiwFfhlEsL/dXELiDzrlDV6xXp66sgqQDfp/?=
 =?us-ascii?Q?fna3CAonHFU0l0/WQIy8EWc1t6UT3PjLIzxLOzoyBC2G6ydBeTGaIwsK2zHu?=
 =?us-ascii?Q?NgYPfOlMd30gRCBFO3lRe3sE+wl60fYFFC3Wt0MBNxf+zAodzSWUMhjzEaSb?=
 =?us-ascii?Q?wLKQ/4lWGcId8GzrNjAg78wHfQBBbmWdcJwRqab0dKCAjf3sDdxp3Be83CEF?=
 =?us-ascii?Q?ujhANpR+tBYcJ75ISMm5Tk73x9U/hmDONgMahquRrUxN+GeQWqGfGlIDmqgh?=
 =?us-ascii?Q?1exnV6Oh1a9wroNG5rPX8shgdSxHr273irudIsQa4ay89m8LCV75w08F87WO?=
 =?us-ascii?Q?LuVoHi6/4aODyNH3YT5nhUHIltyLyAXzIKbl8muTaR68dJxVgmn0aFLyqXD9?=
 =?us-ascii?Q?VFt2TCdSJEGNOYWnPw0+s8fjZEK4Qlo4olbAy41ffGDLXZU+A4kGd9QOJvIg?=
 =?us-ascii?Q?QRO8QSBzpexUdS38OGUFLpWHQR8/Lo/JMyX3CJrIVvKPcCH/IPJCagZaiQmE?=
 =?us-ascii?Q?YZEFX2R0Yama+1eV5OOf8LFR8UpPck76ZA1EofPOMFo1qWW2kZhT8cWRqkXF?=
 =?us-ascii?Q?dNNxZqHFHwkfjV2dSispukDhu5NkXuWqelt5rguprR2brVMrWUWwOM9fbrHk?=
 =?us-ascii?Q?EOMbq37vnvvlavjypHVSQ5dXV+a99VOa3sJPLyq3MmqmoymTTYOnEQnezAvl?=
 =?us-ascii?Q?db7Gvw1kRulGAeDsDvRct5hVEGt1DZBdKXpB+Toeb/X9E0THPDC9CSd5Lwdv?=
 =?us-ascii?Q?09IYP1fhQDTcLXRXy/rZABBJRjyzgK9Vnhz5f3UjAaNJis/pcz7KFuGlPtN0?=
 =?us-ascii?Q?5oKTcVCfKBucVi1BD0Rp+TeYq0GmbaI4jh8P5APr1Z0DFmS5BfM/KxxNdl01?=
 =?us-ascii?Q?2TPd9+QHUiwZnFSqkso=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d67b7-d0cd-47f2-47cb-08dc235cd7a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 19:34:44.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeMTILa/WjMGeC98K+Ho+qPc63lpArOYQNIkdtLaVRX0ftcFhB9OsGpCKobA0nhk/Cs5tMZG9/eiKsy9Kf1U2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7748

On Thu, Jan 25, 2024 at 10:31:00AM -0500, Frank Li wrote:
> On Fri, Jan 19, 2024 at 12:11:06PM -0500, Frank Li wrote:
> > first 6 patches use drvdata: flags to simplify some switch-case code.
> > Improve maintaince and easy to read code.
> 
> @lpieralisi:
> 
> 	Could you please pick up these patches? All already reviewed by
> Mani. dt-binding part acked by rob/krzysztof. Add it only impact freecale
> imx platform.
> 
> Frank

@lpieralisi@kernel.org

Ping!

Frank

> 
> > 
> > Then add imx95 basic pci host function.
> > 
> > follow two patch do endpoint code clean up.
> > Then add imx95 basic endpont function.
> > 
> > Compared with v2, added EP function support and some fixes,  please change
> > notes at each patches.
> > 
> > dt-binding pass pcie node:
> > 
> > pcie0: pcie@4c300000 {
> >                         compatible = "fsl,imx95-pcie";
> >                         reg = <0 0x4c300000 0 0x40000>,
> >                                 <0 0x4c360000 0 0x10000>,
> >                                 <0 0x4c340000 0 0x20000>,
> >                                 <0 0x60100000 0 0xfe00000>;
> >                         reg-names = "dbi", "atu", "app", "config";
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> >                         device_type = "pci";
> >                         linux,pci-domain = <0>;
> >                         bus-range = <0x00 0xff>;
> >                         ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
> >                                  <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
> >                         num-lanes = <1>;
> >                         num-viewport = <8>;
> >                         interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "msi";
> >                         #interrupt-cells = <1>;
> >                         interrupt-map-mask = <0 0 0 0x7>;
> >                         interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> >                         fsl,max-link-speed = <3>;
> >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> >                         assigned-clock-parents = <0>, <0>,
> >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> >                         /* 0x30~0x37 stream id for pci0 */
> >                         /*
> >                          * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
> >                          * <0x100 &apps_smmu 0x31 0x1>;
> >                          */
> >                         status = "disabled";
> >                 };
> > 
> > pcie1: pcie-ep@4c380000 {
> >                         compatible = "fsl,imx95-pcie-ep";
> >                         reg = <0 0x4c380000 0 0x20000>,
> >                               <0 0x4c3e0000 0 0x1000>,
> >                               <0 0x4c3a0000 0 0x1000>,
> >                               <0 0x4c3c0000 0 0x10000>,
> >                               <0 0x4c3f0000 0 0x10000>,
> >                               <0xa 0 1 0>;
> >                         reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> >                         interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "dma";
> >                         fsl,max-link-speed = <3>;
> >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> >                         assigned-clock-parents = <0>, <0>,
> >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> >                         status = "disabled";
> >                 };
> > 
> > Frank Li (15):
> >   PCI: imx6: Simplify clock handling by using clk_bulk*() function
> >   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
> >   PCI: imx6: Simplify reset handling by using by using
> >     *_FLAG_HAS_*_RESET
> >   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
> >   PCI: imx6: Using "linux,pci-domain" as slot ID
> >   PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
> >   PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
> >   PCI: imx6: Simplify switch-case logic by involve init_phy callback
> >   dt-bindings: imx6q-pcie: Clean up irrationality clocks check
> >   dt-bindings: imx6q-pcie: Restruct reg and reg-name
> >   PCI: imx6: Add iMX95 PCIe Root Complex support
> >   PCI: imx6: Clean up get addr_space code
> >   PCI: imx6: Add epc_features in imx6_pcie_drvdata
> >   dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
> >   PCI: imx6: Add iMX95 Endpoint (EP) support
> > 
> > Richard Zhu (1):
> >   dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  28 +-
> >  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  57 +-
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         | 640 ++++++++++--------
> >  4 files changed, 462 insertions(+), 312 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 

