Return-Path: <linux-pci+bounces-1631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD8823225
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 18:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A78B24465
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82051C2AF;
	Wed,  3 Jan 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNn4DdnQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A21BDF1;
	Wed,  3 Jan 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr8U3fHNBp/lKbpThYJgXOEkXGCJ8asiH6bEzP89C2Ku7Tu9gPH8afUerhXsEDeJwL4YDYjH8yOqX/3y6RC31F/XAKQeeLgwihbVwc6Dl7YDKOzk7O8w277WqqXryo97IHEEJpvnFqIeB7BqNPj/xmmMu2Xtof8OLdVV4XtMIbuaD3T0hspTDyqGSFAks0kKqjzKQqMFiNoCs8FwfZqe8gWkP+WO+3xRtPLBsFIqJd87meOWqEG3XbE69htpxwqCc9tIcnWcb9+6vtIQPvirjYq3dUdI1kbi1paogDRlapOTRVcydLwGCwpqC97bgZ4wOqw/JyE7yCtCdSVJv28Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FKcFvq++Mm7GXurLybwB4MdavLc1B1LnUAvfqfMsjQ=;
 b=i3S89mVDj9kgL/VraXJDAb0jIwm2hw7UbRdRuhqFWCGny3lWlzvDGRYIB40BaOKwkblthyZ5/GICYzt8/y/tgoEn2dvPZXFLIJmWynSqmkRMMo4BViwcJ2By37GPDZQVLN+Zx8pkctJ9bTaEvs9XYxHMppk/hgmBetC6aMH8LD8gFf6FBsMYZCmeUBpuWg3NLukXXmwTP4kKVUCLplsEmb+tiTlX9xt3D6Md3UqL1DFjtHTGJ6A48cJYnfnmQc/GdPMMTOkahpqmCwcn61HI6/RQmMW9VP2GbCGBd6haEXcF98X3FArS5by4DL1f51/37NseadvYGZFdmtR1kkO4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FKcFvq++Mm7GXurLybwB4MdavLc1B1LnUAvfqfMsjQ=;
 b=VNn4DdnQDsbCPF511KjDohheDkmscYlgR4Zgc2BGyZGNN2ld+kOLxIDIWjfi+utvK6MTHRQ0l1eUtKzNZDF+q0+Z6B/u4l6jlN5JntoET4GCjsqqnrSeLV10XfNjPKCPjMEZQS6KUEjk9jsmRhvAW5oygtHXP2iuFd2+5UTllXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7518.eurprd04.prod.outlook.com (2603:10a6:102:e4::10)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 17:03:02 +0000
Received: from PA4PR04MB7518.eurprd04.prod.outlook.com
 ([fe80::5e5d:a77a:d64d:2fbc]) by PA4PR04MB7518.eurprd04.prod.outlook.com
 ([fe80::5e5d:a77a:d64d:2fbc%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 17:03:02 +0000
Date: Wed, 3 Jan 2024 12:02:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, hongxing.zhu@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
	helgaas@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	shawnguo@kernel.org, kw@linux.com, festevam@gmail.com,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org,
	l.stach@pengutronix.de
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <ZZWTIbjBJ/DdpUQi@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
 <20240102084744.tyquwp6hkb36tfxg@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102084744.tyquwp6hkb36tfxg@pengutronix.de>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7518:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa37d07-da0e-4a00-ab56-08dc0c7dca18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VKy/uVb4j7e79ZgIDokZFVcOq3YLLorX6UFnH3glr4bOcL+1IVnLJLun6xIx1d8H5BrypOdgveSm0/XACZTpHg3eYkdw4AHxM5AtME90jXqLHp02N8CquSzzLYmmUq39X4YrUUT+YgEHzbXgeB6GD7HmmDND35VyE/TSP+LuPK7RA58b9YEJZ0DuOXRhTIONJrsL4MIdbl9Xf2xaQkaYU1iBe5JJICngV4eF8V285kSLW4XqpdOg+ij4hMEYif02O1OB/cmlvEnzXqesqP4fn/veX/kPey7XPfK6axfpR2szfJkC6VMKzRhQ6m5aDKptKdR6v5Pb+LebV1WoHfkdfOV+g21ABuFsF1aSw4vGfyTQFvQHA9wEWfgHSnFt/VjaTNOK4RzgiRAZbCCmIZRB8CLUsg1y914FNDxCCx89cuSmWPywrSWEx/BwNn5cRhd5SRtqWKD6Egzqp6Bv9dLR0vP/+vjfg6AH/BZonAkiZhRxA6faIwdtUeoKfP+7F+6PbjJnLjgPHJ3xGo0tnotLb4y7yxM2NvG965vdXxSAuBKiN7ZffHjFUfIhef+4oiFPSrdkS2ak6qzV0LN/CZ6RUfCozwK/R0ja+OM4C27aWb/y0iS8yGG+pQaEXnFzAkOn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7518.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(38350700005)(86362001)(6512007)(9686003)(52116002)(6666004)(83380400001)(478600001)(4326008)(6486002)(66946007)(66476007)(66556008)(26005)(8676002)(6916009)(316002)(8936002)(6506007)(41300700001)(5660300002)(7416002)(33716001)(2906002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uaJYft3NkrGsvkwI+rnFG8WQma8KS1DTny2ufE+PvCbUKsr+b/ToDKVN3YL?=
 =?us-ascii?Q?W2hYbozPqxrkXrEmSVADuummFK5jUUMBPoh4QWcuml9XuaL4kWH/41PLKw9w?=
 =?us-ascii?Q?NrRTk/iH90v8b2hl7sUzG4nt+SKiXshHxoCShEV3a8QL5urLlj865Xmtfnr/?=
 =?us-ascii?Q?RqEouxEk7RMwYVCZyII4fYHiMkq3oEqf7z0raOtJvDDqS1S57XCKK6Miz8v4?=
 =?us-ascii?Q?is2fUpXN5YQvLHjdJgcsgd55RO2SawHzqRPnrNuSvrxxjBr3tK+WSjRFxmt2?=
 =?us-ascii?Q?floJTRSLDjbVozNvc6+ZAP6LSvDGpc5KS0Vd/zr5xGhU9JL04Q9IPjb8cWcz?=
 =?us-ascii?Q?fsB7scryPowEohsweXHqBvKiX2R7UbpL1E4/h3yezGoG4fkdxSyhdeDejvPb?=
 =?us-ascii?Q?i2FwmzNwnuS1wAydA8lb9shFS4pp56R73ykKV+t3BZge/nKnkthJC4CKWwp+?=
 =?us-ascii?Q?c501eBTbcZD2U2c96ZQ5hgolxugssx+rYTlpSf2DLblYuDRlNVh/03puJ7t0?=
 =?us-ascii?Q?R9YxghTut+6ZvTZnWxTCS1pyZ1mqpoxFwNIsAtTRg5TYd8Ykpae4HoFZiiIm?=
 =?us-ascii?Q?l18Lb1qgsD0lv7TOzM9VbyX2DJ9XSgIvX84htyVAaC39fZiM+3UsCT9ZY1sW?=
 =?us-ascii?Q?Nfu3tmKPbJO8thVFl2WJQoiC1yyzIeIH4rMhAdi4jXLIopczKBrJuBpxZx3l?=
 =?us-ascii?Q?eeQHa6lCWvsEglLC5LFzqRZaHC7nA13Rsu6qbPPf/deN/e04saPv67QtsdRF?=
 =?us-ascii?Q?h2SKVOEQkptJoRcdujjR25mkRCA4lvD6xgUJGc+o4UowX6q84US+iSy4fmxL?=
 =?us-ascii?Q?+o9OSGYNE5bjRyMolugxgZ1MJywVfdhPghc2VdZ7G45mVyHNPv678DivpWaM?=
 =?us-ascii?Q?XtyWq3JuNEqc4RJ/6l6Gug2uhB+y5knGHp0neKWcPzcBvrTVXvOpm6bPrU3r?=
 =?us-ascii?Q?couNf863/sFhXk4Y9o2Dx1NmaxA9ZepOJrA6kG+v4ZKuyQ2Er1E3FMuOSOMd?=
 =?us-ascii?Q?mvhLu27FshayVq45DSB/ty69aTEdiZH4YBH/EaBuWbSy7+rp71BJP5Quz0rm?=
 =?us-ascii?Q?KXMXnDytwbO9OeDn/bNQEQJuCI/N2bvsq8o9pqYSLoAACbLwkv4XUbeC6VVw?=
 =?us-ascii?Q?IC8kUjC9uWF9IGQBnL2ZA9f/8hA4kz0K1mgGRlXGbLsHLHlgaGogJX3raqSB?=
 =?us-ascii?Q?kixqx1iO2f7P/zWamoPeMS2u5HVBhWP5zlBujcG74sbv2Wt52FMFrgVBwBaY?=
 =?us-ascii?Q?g8+OF4N5eXXjgt3FuLcmw1M7d6nC/ibiEgR+aLInRSKhEaKa2eGZIjEMbgux?=
 =?us-ascii?Q?s4G5+7r/5IqgiJscumLZ0SHhzZySg+1pOEctGxTtfELL5Ex14VrsNWESTiZ8?=
 =?us-ascii?Q?vTWkKYhTSvBolUtwrKBps9o/A889jnKi+GWPY++GBmFXSMQT3POgAbPM5u7W?=
 =?us-ascii?Q?30CebQ1IEx4csZW+59lbUuJZE/M3fYB2Kp+7wwVFQnTu5AiU3/ujBM0WBLdB?=
 =?us-ascii?Q?moxkX90kWJM7FlXlJvBZ1NH0yvwyi+aNw5gC9rbigJaaBlM7fBgUWApsruPC?=
 =?us-ascii?Q?tnO13RDIi6j1m1vgq3Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa37d07-da0e-4a00-ab56-08dc0c7dca18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:03:01.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4ez8XKbntcEAMoDcDS4txQiXfR7sPVHn3Gx+QpuNi8LTREbilVU65lh5Dml7zTgkFToubSIt7kK9OD0rUQFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797

On Tue, Jan 02, 2024 at 09:47:44AM +0100, Marco Felsch wrote:
> Hi Frank,
> 
> On 23-12-27, Frank Li wrote:
> > Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> > Using clk_bulk*() api simplifies the code.
> 
> does this influence the clock enable/disable sequence ordering? Just
> asking to avoid regressions on older platforms which may require some
> sort of order (e.g. require clock-a before clock-b).

drvdata::clk_names is order of enble sequence. So far we have not found
the problem.

Frank Li
> 
> Regards,
>   Marco
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
> >  1 file changed, 35 insertions(+), 90 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 74703362aeec7..50d9faaa17f71 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -61,12 +61,15 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> >  
> > +#define IMX6_PCIE_MAX_CLKS       6
> > +
> >  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> >  	enum dw_pcie_device_mode mode;
> >  	u32 flags;
> >  	int dbi_length;
> >  	const char *gpr;
> > +	const char *clk_names[IMX6_PCIE_MAX_CLKS];
> >  };
> >  
> >  struct imx6_pcie {
> > @@ -74,11 +77,8 @@ struct imx6_pcie {
> >  	int			reset_gpio;
> >  	bool			gpio_active_high;
> >  	bool			link_is_up;
> > -	struct clk		*pcie_bus;
> > -	struct clk		*pcie_phy;
> > -	struct clk		*pcie_inbound_axi;
> > -	struct clk		*pcie;
> > -	struct clk		*pcie_aux;
> > +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> > +	u32			clks_cnt;
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> >  
> >  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
> >  {
> > -	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> > +	unsigned long phy_rate = 0;
> >  	int mult, div;
> >  	u16 val;
> > +	int i;
> >  
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> >  		return 0;
> >  
> > +	for (i = 0; i < imx6_pcie->clks_cnt; i++)
> > +		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
> > +			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
> > +
> >  	switch (phy_rate) {
> >  	case 125000000:
> >  		/*
> > @@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
> >  
> >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> > -	struct dw_pcie *pci = imx6_pcie->pci;
> > -	struct device *dev = pci->dev;
> >  	unsigned int offset;
> >  	int ret = 0;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6SX:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_axi clock\n");
> > -			break;
> > -		}
> > -
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> >  		break;
> > @@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  	case IMX8MQ_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_aux clock\n");
> > -			break;
> > -		}
> > -
> >  		offset = imx6_pcie_grp_offset(imx6_pcie);
> >  		/*
> >  		 * Set the over ride low and enabled
> > @@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> >  	case IMX6QP:
> >  	case IMX6Q:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > @@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> >  		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > -		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	struct device *dev = pci->dev;
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_phy clock\n");
> > +	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
> > +	if (ret)
> >  		return ret;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_bus clock\n");
> > -		goto err_pcie_bus;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie clock\n");
> > -		goto err_pcie;
> > -	}
> >  
> >  	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> >  	if (ret) {
> > @@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	return 0;
> >  
> >  err_ref_clk:
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -err_pcie:
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -err_pcie_bus:
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
> >  
> >  	return ret;
> >  }
> > @@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  {
> >  	imx6_pcie_disable_ref_clk(imx6_pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
> >  }
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > @@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return imx6_pcie->reset_gpio;
> >  	}
> >  
> > -	/* Fetch clocks */
> > -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> > -	if (IS_ERR(imx6_pcie->pcie_bus))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> > -				     "pcie_bus clock source missing or invalid\n");
> > +	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
> > +		int i = imx6_pcie->clks_cnt;
> > +
> > +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> > +		imx6_pcie->clks_cnt++;
> > +	}
> >  
> > -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> > -	if (IS_ERR(imx6_pcie->pcie))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> > -				     "pcie clock source missing or invalid\n");
> > +	/* Fetch clocks */
> > +	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
> > +	if (ret)
> > +		return ret;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> > -							   "pcie_inbound_axi");
> > -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > -					     "pcie_inbound_axi clock missing or invalid\n");
> > -		break;
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> > -		fallthrough;
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >  			imx6_pcie->controller_id = 1;
> > @@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	case IMX8MM_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> >  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> >  									 "apps");
> >  		if (IS_ERR(imx6_pcie->apps_reset))
> > @@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	default:
> >  		break;
> >  	}
> > -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > -	if (imx6_pcie->phy == NULL) {
> > -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > -		if (IS_ERR(imx6_pcie->pcie_phy))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> > -					     "pcie_phy clock source missing or invalid\n");
> > -	}
> > -
> >  
> >  	/* Grab turnoff reset */
> >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > @@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> > 
> > 

