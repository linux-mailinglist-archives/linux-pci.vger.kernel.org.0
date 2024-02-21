Return-Path: <linux-pci+bounces-3833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03E85E15C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42320285BE3
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69448062A;
	Wed, 21 Feb 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KuakUa3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDA7F47A;
	Wed, 21 Feb 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529792; cv=fail; b=ophdwsW1RqbPOi0/BVRFFyWiBild693LtLSb1hnEaAd4uibIqpCWTy+ky5ouoPQXNTmjs8CQGBfx8Pv2LTpkjRwvmLYyxJPMgod7YzcM/AaT2ElxIevdqf38P/W6nWdScHmFEgJ9JIs81a3X3erf6ck/INjxVoxrGfg16oPQU54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529792; c=relaxed/simple;
	bh=M9jQPbLoMwW0y+hLaXwTczDlOHhO8xzvC708sxWCJ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eqVehDlOCL6j2/+dHQvMvzJjtGrptmowTd4tE9rAi2t7PD7QBBNSWcP0X0hMbrXriw5WZBwDer/oEOOcTBIK3dK4g0bmcE98ke/H0/3zV69xd/KhhgO1tbs07NEXkSpYTYHGx3gzI9JPRp5kMiVfw+PUgJInG/9abBnQjqzxM2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KuakUa3z; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBGKLAA/CKUbHqDcS9gawN2ow9FBkM1QDNqgQYTt9dYKOgYjFn2fl2yPrLhe51O1pmKoa4RcZA3rFgFzeiV+qDvwp3+DqXU2JwJ3lwdE74XBTFAdXNy/Ypn3oL66O06SWVdoh6ZcIQ1SwPrb2r5sAjG2TY0DnWm5AJjdZll4AzLKJrdAGCtGV4m+WNGrf5GsYL+i+2KhZdFmVzPgVoOBNgbExQgjRlL36RpxaP/xn6isqZ18te2dZfgHwK9j6Z2itTkypUV6++kgIUvGDIIVKxP+jgJXrjm2d8EvOB7E7MTk0tgWRKYPHI8jzJhRIOzDrCe7Z49yCuOYhBLIa0JIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJSVlN1Fi2jxMYNhaORTT/xRxDlO0baz1lGpah1M6jU=;
 b=hcBisimFOjWQ08ENnAKvBomzRcsX0IRcBj1IKv1PQoFn/AcSz4r+W2vUbJG6JEjPO00hJTsMHk+WEOtAQLJ92gP86wM3LWn/5XaVyaFwm569OTpfSmDOuVvGctC24DYsuXabVbFN2neYjwiu575FK2KKEL2i0bI+MQCm88V9CbPfGo+bPrZJWb8I9HNVKWl3GKGvLvrF8zUZ/rkB/nwp/1+9vTvyWMUHl8IvtH4v000VcuBBGOYP2xZhJnbimBIzBkY9CnqhVop3QRCPEbLJ2LbuPSDVDsdmBMShHPdN4ncX6DTgscpRE2zWD7Iy3ZdkearyBrEdw+BARIVFSoND8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJSVlN1Fi2jxMYNhaORTT/xRxDlO0baz1lGpah1M6jU=;
 b=KuakUa3zA9MtrSWzdmxOU/DwhXWzHSywBCB2sI2s19VeuPQt4FRxwWSdQtN0wkKmp1f8zxj5QDIP3ZcotWqCGGMxc3snmNkf6vkznmB6+sqPwdxceB9IlNHWODOnc9WB8og+MB4oo6KeDsVpE2HoFPwH+FhNIiHs2wQ1+zxv5GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 15:36:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:36:26 +0000
Date: Wed, 21 Feb 2024 10:36:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: bhelgaas@google.com, cassel@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v11 10/14] PCI: imx6: Add iMX95 PCIe Root Complex support
Message-ID: <ZdYYcf2fOkwl3oiM@lizhi-Precision-Tower-5810>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
 <20240220161924.3871774-11-Frank.Li@nxp.com>
 <ZdXTof/fSOuBw4MW@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdXTof/fSOuBw4MW@lpieralisi>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9f06c4-4d49-439f-172f-08dc32f2ddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gn7kzCstWdrAISj21AIfHGLy0gaYwPHZFRmFvSN19+cyPBfmmO8nVyCLJA0pwMW0F9J4a1quyFNNKxwbP6L6GD0aZPIznCpvwKR/Akg4vVTv13iNHiOM9pTI4Tgwy98EmfxKm24dHPN+jh0fSSQoD0axNEPvz1/cQFZTbff5XSc0YxngdPUtaLeYvsAEYnfr/Eyq5zb9LoXsjYZkbOAa/QJfQxBtojeW5PcP6DG8AuxswZDaPRFSjHJ4doFfTiF4dE2rbZ0A+lmWgrSydBEre+I+KZLNEQScxU98xfJIbpCgyCT/9OkQznJhgd4P7mOy0lEXuFy6c9iRKJPOcMtp0e+wb9mjQpKWbaX3HzeUPdZPS+dWR3H6zb+0DlQ5aDJkBfyMSDTN7S60JTB/Pfj0gJjt37WsnF2RlOgadKEhDvoF9sPM/ArzI/0HoEOvxPeuon7L9o54CcnjH4mg8DnZssz4v7t6cUGQgvX8g6/WVtFLYI/DOTOfULT9LLmTwxz+CltrDgwUYQYgZD02Moj0pmtfWaC1OPzTlX6GTE7S8ukUXo9d6Kr8VS5HyCKeoVRlEFR0Y2hf8qLod1xpoLI9mHL8ecLqP1V+7FsQmgzOV/6sxLHfNYt0dwqgVO/yxamJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/vBq8RVuimawASyP2KNcpEJgzMFz118gW0jOTWfAYMOOGcse3ssYgaGwLt3?=
 =?us-ascii?Q?sdcAjIMC6yvGgOhDEp2ZWbSSN1gerl4mG33NpK4ZXOIrHxWMfOzPD5P2LMJ/?=
 =?us-ascii?Q?c8NZtSKdKE92OSHFoOZOtdx5UvFUuQEZSE4aH2nIxo/pGkZKVV1SEzCNcrIN?=
 =?us-ascii?Q?4oOuJZGuJjAKScWTPFLdvx54tYp8FgwsmEvesh57R+lKzIBtHhWDIrDRJu4H?=
 =?us-ascii?Q?6chbPe2G+Y7sVvv/x7j8OD6CsXrkrNMnez8DAUMLNyB4BNV9IGEMK4UjojD7?=
 =?us-ascii?Q?lHie2IYGCjGkwc+5Z1uxNigIHNorcOL2vSkwjbQ6ia6iWpI0lHxyQPIMAgUX?=
 =?us-ascii?Q?diZb8ydP+ouzy57XaQ5qQ2qDEDBvZCHLQse4CZEs9NQJPI6blZQDcyzlNs17?=
 =?us-ascii?Q?lLYVNWoaPWI5+nFw1JQ1TYhXTzIXjD5BQT7HfKlaFmT72VG77oeqlTB3UIy+?=
 =?us-ascii?Q?AT6jd8FibyBGPv+z3jIK9NYUBoU52wHuaBM9rhzWznPuIxTvR9J6jbhXDfW/?=
 =?us-ascii?Q?WLc2Xq5nVek3DclArFQ1/CDlPVHSDxkVwhmpZc6HV5ureTigdLeHpSLDScKW?=
 =?us-ascii?Q?mSntbqQBM+mhTe0bUxIkThJ0rZMJaUC5q8kKeUXA5wuANMmsjAmp0/0M8aAR?=
 =?us-ascii?Q?l0JcABdxymwCFbmxF/hiZqN4ipvmbVmhK+Y2xa0T0UzqPNNRnZ1I5T25orUS?=
 =?us-ascii?Q?IE2hF4OxFFJIjmikYflt2LKOfNmXRpofz13i65W4e6fKzwKilzUAcr9WHYou?=
 =?us-ascii?Q?9aDhIbj64VoKJX3tcXAFvgYw+PNDrU2JFIIRJ40RD1s8N60UyifRcqK3vaJe?=
 =?us-ascii?Q?Npi0l/aSHal0fpAwlKsC1SnADur1mhJEiKm/k9ttoKQIf+keew8tlypbQZIY?=
 =?us-ascii?Q?JV4VAcyAW/rkjR4rjthKRyvlZtEjepl8f+MB5YzT78m/Xv38g8UI4D63x34L?=
 =?us-ascii?Q?9K73pIUqM/Xyn3F6ggFcXm/UxRcnP5GM9I5lPwkmbfimGAMUuBYIBZxQdWo6?=
 =?us-ascii?Q?ahH83xMIMFefDMFJvXUOT0MRl7Ml+42UW2Dld/smchoSW7MwGrcR6jtkZOde?=
 =?us-ascii?Q?dHez1nomp6KRiAUX5K8i9WMzWUQ4ndOM8ZTShOxO+601xG/KTFSzQGetE5fC?=
 =?us-ascii?Q?VNX4rzr2Dz8S2E8goHtTpzUP+3diLmLgosUpGxbA76j/fsEMmQHhxFgGFUNA?=
 =?us-ascii?Q?T+kh7KGmJUzzS909RBN2lkkpD+QIIKXCUQn3BjzqEId903ZUTMyNAHd8JaB2?=
 =?us-ascii?Q?TkphBGLOOuYLlhM6lPELg49K56RUQsREv0ZipO6IBJeWecC3B0Nt6x1809V0?=
 =?us-ascii?Q?G/XX26unoyuf2UPeWmRwKrwI38fUkFy07s7UJtBUUKtX6qCkc6w4fx4nkBDt?=
 =?us-ascii?Q?QZVb+/1NjdrJMxJfqXHJyz21l3JlRidIJflJ3cupMkLCCaK5CKllz2ORNNeq?=
 =?us-ascii?Q?USBmd0pZ0U9VtZ9ai81UeimeRU1dPe63yZzyYNVd0Bw54NDxVIL3YOI4xj+J?=
 =?us-ascii?Q?VU0UuE55T5X8VO+Y1NZw5azynLkE6yQsSEz8pTgIJ1sKmLnaJD6jjOMfXhWL?=
 =?us-ascii?Q?bQXFIkqjv2ZvwAyebeF+ncROLm8Y+X9zulbr0IkM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9f06c4-4d49-439f-172f-08dc32f2ddd2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:36:26.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMdPW6kt+FyCYlkaoO2nYsICCmJMnivqBvMgZ7scP1aIfIYL6rszoFoCJFv4e9vSsF7eqUbVL2Ys050mytxe1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9628

On Wed, Feb 21, 2024 at 11:42:41AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Feb 20, 2024 at 11:19:20AM -0500, Frank Li wrote:
> > Add iMX95 PCIe Root Complex support.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v8 to v9
> >     - Add mani's review tag
> >     
> >     Change from v7 to v8
> >     - Update commit subject
> >     - add const from regmap
> >     - remove unnessary logic in imx6_pcie_deassert_core_reset()
> >     
> >     Change from v4 to v7
> >     - none
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++++++++++--
> >  1 file changed, 77 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 71ce6b7ac1de0..582ba00d628a1 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -42,6 +42,25 @@
> >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> >  #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> >  
> > +#define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > +#define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > +
> > +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> > +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
> 
> These two defines are unused, I will remove them.
> 
> > +#define IMX95_PCIE_SS_RW_REG_0			0xf0
> > +#define IMX95_PCIE_REF_CLKEN			BIT(23)
> > +#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> > +
> > +#define IMX95_PE0_GEN_CTRL_1			0x1050
> > +#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> > +
> > +#define IMX95_PE0_GEN_CTRL_3			0x1058
> > +#define IMX95_PCIE_LTSSM_EN			BIT(0)
> > +
> > +#define IMX95_PE0_PM_STS			0x1064
> > +#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)
> 
> These two defines are unused. I will remove them.

Thanks.
let me know if need me send out revised patches.

Frank

> 
> > +
> >  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
> >  
> >  enum imx6_pcie_variants {
> > @@ -52,6 +71,7 @@ enum imx6_pcie_variants {
> >  	IMX8MQ,
> >  	IMX8MM,
> >  	IMX8MP,
> > +	IMX95,
> >  	IMX8MQ_EP,
> >  	IMX8MM_EP,
> >  	IMX8MP_EP,
> > @@ -63,6 +83,7 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
> >  #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> >  #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> > +#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  
> >  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> >  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> >  }
> >  
> > +static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> > +{
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > +			IMX95_PCIE_SS_RW_REG_0,
> > +			IMX95_PCIE_PHY_CR_PARA_SEL,
> > +			IMX95_PCIE_PHY_CR_PARA_SEL);
> > +
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > +			   IMX95_PCIE_PHY_GEN_CTRL,
> > +			   IMX95_PCIE_REF_USE_PAD, 0);
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > +			   IMX95_PCIE_SS_RW_REG_0,
> > +			   IMX95_PCIE_REF_CLKEN,
> > +			   IMX95_PCIE_REF_CLKEN);
> > +
> > +	return 0;
> > +}
> > +
> >  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> >  {
> >  	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> > @@ -575,6 +614,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> >  		break;
> >  	case IMX7D:
> > +	case IMX95:
> >  		break;
> >  	case IMX8MM:
> >  	case IMX8MM_EP:
> > @@ -1279,12 +1319,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return PTR_ERR(imx6_pcie->turnoff_reset);
> >  	}
> >  
> > +	if (imx6_pcie->drvdata->gpr) {
> >  	/* Grab GPR config register range */
> > -	imx6_pcie->iomuxc_gpr =
> > -		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> > -	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> > -		dev_err(dev, "unable to find iomuxc registers\n");
> > -		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> > +		imx6_pcie->iomuxc_gpr =
> > +			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> > +		if (IS_ERR(imx6_pcie->iomuxc_gpr))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
> > +					     "unable to find iomuxc registers\n");
> > +	}
> > +
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
> > +		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
> > +
> > +		if (IS_ERR(off))
> > +			return dev_err_probe(dev, PTR_ERR(off),
> > +					     "unable to find serdes registers\n");
> > +
> > +		static const struct regmap_config regmap_config = {
> > +			.reg_bits = 32,
> > +			.val_bits = 32,
> > +			.reg_stride = 4,
> > +		};
> > +
> > +		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
> > +		if (IS_ERR(imx6_pcie->iomuxc_gpr))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
> > +					     "unable to find iomuxc registers\n");
> >  	}
> >  
> >  	/* Grab PCIe PHY Tx Settings */
> > @@ -1457,6 +1517,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> > +	[IMX95] = {
> > +		.variant = IMX95,
> > +		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
> > +		.clk_names = imx8mq_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> > +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> > +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> > +		.init_phy = imx95_pcie_init_phy,
> > +	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> >  		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > @@ -1501,6 +1572,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
> >  	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
> >  	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
> >  	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
> > +	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
> >  	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
> >  	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
> >  	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> > -- 
> > 2.34.1
> > 

