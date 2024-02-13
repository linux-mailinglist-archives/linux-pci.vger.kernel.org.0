Return-Path: <linux-pci+bounces-3399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B5853470
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559BF28324B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D05A7B7;
	Tue, 13 Feb 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cobq48A2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EB376F3;
	Tue, 13 Feb 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837625; cv=fail; b=MXhkmYJfsKsjLqNwu+lVKWGM7/mF1dIL+rUvGFrYYaIfgflil4lpBlk+q3i3GiDkGXx247Bkc/R1zqKiKjqAmypMkSFV85fEc4nOzE+x8UG/fdL1oqsO+lih+ktwEkVyVorwhuVrqDHZefwRagruPUvajEF87dRuHeTyxsice24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837625; c=relaxed/simple;
	bh=fRlXn1eRlgDeozt9pqAVPmEryx6lzppnE59yhkzphJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LcdQmgwtffrLImGm+BEWWmCbAF21KF2JP0jy/G9w9GOZbcCcUq6aMvbNKEKg6qR/aAgsHyheEtSxoPzeMKbNUrVzCoY4chx0olOYpB/DFsYuv8/yX3L7s1O3h2TvvdkJ3DqbIrjNBPfiRxZvuAQiwd57MY5P1eVHbRzpM8iVAhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cobq48A2; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaIrXx2jnIdwxymUfEA8eDgg6HPEDaU0VarxqeV7ocq+HEAnG5gufzft+Qd+wAxC9q8YwTB8VEBMoeZhU4/GdAHxuQ8qDEDEzUJsDf1SQi4ZOXwEtdZCUayQHU4xqvZew42HsOBfuCbHngfiHXxEI8nG/2IVJ2eurnXNroCTHSuBJehI+vrb/cVJUyFDzdjMWcixSquvCXBytLLIB8CerWxhv70uSILOjMTSQ9hEq5AE0+wHTi5XVyTzHMpPmb32U6ce73JzyaAmDrqbnvMDHMEfvZupGD/WCjMPTpLqRpK/7XEAoDGMtpNIB2WKD5eLt7qV6LAfaq0l0Nx7nPYOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBvvEdqBXLC2/oSmJ0gLNxp6JN0EqxeJoOtvgnv+tS0=;
 b=Y6kNnafim2cl/rynSe+mk707fS39uclTpPYL4Edgi9sBIAJKIklGLH8cnRN0TrlSuUA9WtR/rFO1iU+/o3p0bqHlRyoAKMlq3R4Ssx8TyEvrfjk3DCD4Ob0mf3dhARHRmno3OXdjL7p4gAfb4wlFAtFblElE/wzV9suu0azLHbR8vpEhHbsPpTiFZ5EQATZ1oNWmELVcLGC05D8W86CtG8K9hMm7+DYRCwkBoYq/Kfk+DIJCNdbuv4c6tuTHlLwzPIYBkWzz3hwevaIoTZbK8Ijj6f/Uarci70kAoyv5whKRB9dDBSGJ0Rr5x8whqOUCLye/Hg/UuFS4+Cu7p2N9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBvvEdqBXLC2/oSmJ0gLNxp6JN0EqxeJoOtvgnv+tS0=;
 b=cobq48A2rjaJDnPrMd3tD7qT5B5HrhynjMAYRvitMFP7lmkDiwI4IogKo2JCAOAkjQuU48YDpWpRORNx0mVp1ygHPxfJgmMc5StLSOLwCvGqV2TgmgpDuGnz7oDh0TI4GJnRST8WLajliILVPrAs3RNf2pMu7jL4dccVxkcKf3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 15:20:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 15:20:18 +0000
Date: Tue, 13 Feb 2024 10:20:07 -0500
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
Subject: Re: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
Message-ID: <ZcuIp3qlEYCePr8Y@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <20240205173335.1120469-4-Frank.Li@nxp.com>
 <ZctVVjjHYVczweta@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctVVjjHYVczweta@lpieralisi>
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8758acd3-6371-4f7e-53a4-08dc2ca7494b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kh35rjHVcA51zyvc2uPaa3iYrq6dUMTXE391UtdFaWCL9QejFj6qCIcDJQOMNoKtZCWQEVXfursCfCW/SnNA+BPt0B6yoz5XNwNC0GF2xvetHxf7chcmFVdTpp+kE0voxTlNhXwdETfkRh22tOV83sLoLlva1nm1AiQQzR6O6crdmIN8DHls7Ku/KyqqGsobQ0jNFE/lars0G1x5T1Hbslxs+Hqmc2MBkvvvHYxCl/pbNsSO/Lqb/4CuTXLvo5yLq5q4BEMn0M2wHEpEiWSZxrK1ImPGr0CClTqhkIF2nLLeIkG/gkd+oELeKWd9qinPgIZ/8NXsyyIJvGCn8769SfKG/oa6F/tv11K6RQ+6Vejj66qO304Jo/TLakgMHX7Xxkx2p4IkcM804SXB4SpcQ4U8IdusCfldWzPCuU3du6USbZUC3Pmm+9TiNRMFLWHxCIssYupB1CXXHfQ6rzxTgOucxo9ucI39qxZp4O/RgLz/LQX5H//fay4XYghBOLdv89mssg7i3SORWvhwiK9E7E0gMa3VTpnz77R5kJUKoRwaSur5Je+KZkHiAgD5Vs5ucNrCI9GOi81rqK/DZk9/my270LsVmKXOXjaiB5PE3Oo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8676002)(4326008)(5660300002)(8936002)(7416002)(2906002)(83380400001)(26005)(38100700002)(86362001)(38350700005)(33716001)(316002)(66946007)(6916009)(66476007)(66556008)(6506007)(6666004)(52116002)(6512007)(6486002)(478600001)(966005)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVNXYjWcT4WqqxH3JjrreceMrYmgGW9/9svtm5LG33M0smuT/1nahFnaOEac?=
 =?us-ascii?Q?P4zZl8HCJAzgsqKRRgGJ+IEUbPLG2LK9O1o+/gMzYe0X+MXz540zcDll+da2?=
 =?us-ascii?Q?bBXhPQJLxM6X1A2irbL6yNNenoBT/1MX01L+UkuUkzAz1JieIf3H4PhLMCSY?=
 =?us-ascii?Q?Ym8BYk/WVfA1xTlO2VqPuvn9ZMaQ60Lpahpz96EJTU7BfzX/jJnOgJE4z4HH?=
 =?us-ascii?Q?hyS0ZEFfR9+VjGwZIyGmqhgwJQDc4nA+VJDVWbkb4OAqLAkODontJC1UrShh?=
 =?us-ascii?Q?eHDOLpH5BGVjo5n4i17d9KsWBL110psuV5F4aUroHxoRaAgAmWnq0pF+PhSd?=
 =?us-ascii?Q?VLc2qhuDULTfadVfnbXp52NlYha4LihmpfLhiwQNsMwtNSpdNOI6qxLqGTOa?=
 =?us-ascii?Q?zZnjKa/s/4RQPD3QS4thhtVfSGei42Ay5G7VJ5IIWoTZ+534hVzfacXi96T9?=
 =?us-ascii?Q?L1BHTqVyZYrHaNWH/iuPQppEVdYWM8PbFZh8zOihs+41mvcs1BfwHhdtZq6W?=
 =?us-ascii?Q?7nM+mhRbJE0fFtuyiGRNiDhUhsuSKWQ095CICpxLu3erXNe8vlwl+vgX68pi?=
 =?us-ascii?Q?h5dTNoXENvcfTJUHCh/bZC2t+jYOvTWsACweyaH1hVvZXsw69bJw/7BPHm3N?=
 =?us-ascii?Q?wPejeg9NDUfxvGyJqPSXDAlZJ98c4eWiW7n6dTIqShlfNnm0b+DJA7zd7mZD?=
 =?us-ascii?Q?kVsxucZf9nTmq7uKUGDZXH1De3M7YET5Ct0IxJenjL7E4UwwNYJhYdIsRdg4?=
 =?us-ascii?Q?kKUgUf5IH1v/3Ff1wALPSQQcTQEax1OmC97v1PkxkRte0r8saUYqPhm9WrX3?=
 =?us-ascii?Q?LiTRZuMZHfUHGokJUBchnedhBCsXqpc6wYWOabqbu3xePZt6tycnlz52/iQP?=
 =?us-ascii?Q?lmzDP5Kjo1+Kt9SPG+b+vwrEEhjHkEt/B7iKeZ3dnmjwtHiZdarndJpyujI9?=
 =?us-ascii?Q?B4UaGXYyJtKv/4JQ/veDXyFRALUqDn5vpkiKTZP4K0m8JYLVKehE96n/4nkd?=
 =?us-ascii?Q?LAbR3WEdnzWBE4GZhVUMvh6Hp37z6IeSfA6njAO6xEjFnIZ3EYoovYG9A9r0?=
 =?us-ascii?Q?UMxU8d7KDDfeZJTRTOe4/OS+A/Diw6o+m3HRH+As0T9QXkPWEkLT58xutVfk?=
 =?us-ascii?Q?B+lBKzx5RiT70lS6eJHtfngymlaOHSs6zxzMHOSm9trRjiGRXIj76Mg2AzSH?=
 =?us-ascii?Q?3i+1I93Yw3T7KydaZ+XkKq6EpY7AyQFCCNFNiVLgULzp9cyWocjMuP2Thtvo?=
 =?us-ascii?Q?CvUw0WdMwZfKimCPrsq9ocr8O0/TjC4UzG4a79cQDsBMX1NUWXVVY4+hrOu+?=
 =?us-ascii?Q?HTWoN9qvDHgSyrdEmj5KozUrDsSkftvY/uLZH69SbvH4TJsy2v2RQW5vEKae?=
 =?us-ascii?Q?oA6sN26nswObt05lXVY2dgFgBaYNHSxMwdpr3X9e/35LdTVST3OgT3oXK+UN?=
 =?us-ascii?Q?U8aQuwmY2RJGT6NEeMK0cMKFTyo6s/WDlZxkcrZ4MwwQxW4T+KnMSzRmkeay?=
 =?us-ascii?Q?ycOw9JpqJG+UBhW6VpM61/Gqn5ACjYIbEBBTE7hejTMW2xt7aDV3UEgObxuY?=
 =?us-ascii?Q?4yujMzPxWlda0PfEw5s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8758acd3-6371-4f7e-53a4-08dc2ca7494b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:20:18.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZNzs5jYKZsWxFMQcvLL/OSIFKKrjaOTx1Cit9Elu0BKsIehSMvKJpAMvdq3VN5kZhSLwyuuOVUmCx2ooSzQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979

On Tue, Feb 13, 2024 at 12:41:10PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Feb 05, 2024 at 12:33:24PM -0500, Frank Li wrote:
> > Refactors the reset handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling reset.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v4 to v5:
> >     - Add Mani's Reviewed-by tag
> >     - Fixed MQ_EP's flags
> >     
> >     Chagne from v3 to v4:
> >     - none
> >     Change from v2 to v3:
> >     - add Philipp's Reviewed-by tag
> >     Change from v1 to v2:
> >     - remove condition check before reset_control_(de)assert() because it is
> >       none ops if a NULL pointer pass down.
> >     - still keep condition check at probe to help identify dts file mismatch
> >       problem.
> >     
> >     Change from v1 to v2:
> >     - remove condition check before reset_control_(de)assert() because it is
> >       none ops if a NULL pointer pass down.
> >     - still keep condition check at probe to help identify dts file mismatch
> >       problem.
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 105 ++++++++++----------------
> >  1 file changed, 39 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 59f117f855c26..a1653b58051b7 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -61,6 +61,8 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> >  #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
> > +#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> > +#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  
> >  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -661,18 +663,10 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >  {
> > +	reset_control_assert(imx6_pcie->pciephy_reset);
> > +	reset_control_assert(imx6_pcie->apps_reset);
> > +
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX7D:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -		reset_control_assert(imx6_pcie->pciephy_reset);
> > -		fallthrough;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		reset_control_assert(imx6_pcie->apps_reset);
> > -		break;
> >  	case IMX6SX:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> > @@ -693,6 +687,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> >  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> >  		break;
> > +	default:
> > +		break;
> >  	}
> >  
> >  	/* Some boards don't have PCIe reset GPIO. */
> > @@ -706,14 +702,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  	struct dw_pcie *pci = imx6_pcie->pci;
> >  	struct device *dev = pci->dev;
> >  
> > +	reset_control_deassert(imx6_pcie->pciephy_reset);
> > +
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -		reset_control_deassert(imx6_pcie->pciephy_reset);
> > -		break;
> >  	case IMX7D:
> > -		reset_control_deassert(imx6_pcie->pciephy_reset);
> > -
> >  		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> >  		 * oscillate, especially when cold.  This turns off "Duty-cycle
> >  		 * Corrector" and other mysterious undocumented things.
> > @@ -745,11 +737,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  
> >  		usleep_range(200, 500);
> >  		break;
> > -	case IMX6Q:		/* Nothing to do */
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > +	default:
> >  		break;
> >  	}
> >  
> > @@ -796,16 +784,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
> >  				   IMX6Q_GPR12_PCIE_CTL_2,
> >  				   IMX6Q_GPR12_PCIE_CTL_2);
> >  		break;
> > -	case IMX7D:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		reset_control_deassert(imx6_pcie->apps_reset);
> > +	default:
> >  		break;
> >  	}
> > +
> > +	reset_control_deassert(imx6_pcie->apps_reset);
> 
> You rely on the fact that passing NULL is a no-op on platforms where
> this wasn't called before (valid question for other hunks in this commit),
> correct ?
> 

Thank you take time to review it. 
Yes, it follow Philipp's suggestion. Remove conditional check at v2.

Frank

> Just checking, it does not make things much cleaner but I am not opposed to
> this change.
> 
> Thanks,
> Lorenzo
> 
> >  }
> >  
> >  static void imx6_pcie_ltssm_disable(struct device *dev)
> > @@ -819,16 +802,11 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> >  		break;
> > -	case IMX7D:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		reset_control_assert(imx6_pcie->apps_reset);
> > +	default:
> >  		break;
> >  	}
> > +
> > +	reset_control_assert(imx6_pcie->apps_reset);
> >  }
> >  
> >  static int imx6_pcie_start_link(struct dw_pcie *pci)
> > @@ -1287,38 +1265,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  					     "failed to get pcie phy\n");
> >  	}
> >  
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
> > +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
> > +		if (IS_ERR(imx6_pcie->apps_reset))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> > +					     "failed to get pcie apps reset control\n");
> > +	}
> > +
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
> > +		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
> > +		if (IS_ERR(imx6_pcie->pciephy_reset))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
> > +					     "Failed to get PCIEPHY reset control\n");
> > +	}
> > +
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX8MQ:
> >  	case IMX8MQ_EP:
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >  			imx6_pcie->controller_id = 1;
> > -
> > -		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> > -									    "pciephy");
> > -		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> > -			dev_err(dev, "Failed to get PCIEPHY reset control\n");
> > -			return PTR_ERR(imx6_pcie->pciephy_reset);
> > -		}
> > -
> > -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> > -									 "apps");
> > -		if (IS_ERR(imx6_pcie->apps_reset)) {
> > -			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > -			return PTR_ERR(imx6_pcie->apps_reset);
> > -		}
> > -		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> > -									 "apps");
> > -		if (IS_ERR(imx6_pcie->apps_reset))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> > -					     "failed to get pcie apps reset control\n");
> > -
> > -		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -1448,13 +1414,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> >  		.clk_names = imx6q_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  		.clk_names = imx8mq_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > @@ -1471,13 +1441,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > -			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> > +			 IMX6_PCIE_FLAG_HAS_PHYDRV |
> > +			 IMX6_PCIE_FLAG_HAS_APP_RESET,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = imx8mm_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  		.clk_names = imx8mq_clks,
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

