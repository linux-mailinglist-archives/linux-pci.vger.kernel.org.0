Return-Path: <linux-pci+bounces-1739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3535B8260B2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9281C20F55
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB18820;
	Sat,  6 Jan 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z043RiT0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC68495;
	Sat,  6 Jan 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwNxNP4c+tx3XgPRivoEJHHOaSPJPAYwlGvJAvsu5S55/i4ta/EO1AHjyxHR1/dAFXcP6wzZmtCgacCn3y4tIU4u/b0sZ50Y9ghQNyMN5FDOS0QpIxUFqRuk7z2cJ/59BDDB4gPAb3+gdpxUnJXcphumAzgYlb2DcABKohteq5qLSlAHnCy0wia4KcxTH5OR3tH79yrcfyg5zcDGdjDrwhz9PYSOJwWeO7xpDFFellAH7wqM4J3581NJKtLrgrE9BUCHFSlZ2jTzzMjPWEieRVIuQhNSBx/RRwQCXHixQ4OV/TSy8GQzMF1bRRRzmXWBfGxTyoPhYsb2lJbDW2W4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djT/2ArV1NVeObskytQ0tgqY6b/N93M6RD2cMVPkE4g=;
 b=Gf7ITErQowNJBTw+n6HgK7NKWIrdKklpVRiPEpZADTkzxuwxC4Nz7jrWZWZ/yUhZAt5bLw82qHbzD0lXkrWhdTsuFSkQ1HiEEqOu3KvrJ0ixIsADlpgO1lEQmulZU67/uJzymT68s9d8wP5jG4j/GhJlO3fRi8cCEZ5p7su3GGKj33LiqPaesjrjxBd1LuBH8Lws1W+oV0TP9fv9cxCWmwNVajZMWLulHm1NO2INgZPMkgLpylmyMavo6mkk4/I3a4Z/w6JVVavDcob+23lauyTUGAAdgKkSsuK2OpznSNG5YFd67e47nzUEr5iumTYS6C3LDap3NV1euxrQKzny3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djT/2ArV1NVeObskytQ0tgqY6b/N93M6RD2cMVPkE4g=;
 b=Z043RiT08bvm8pyjEBrowwty+8FAFsU7Rkh34OjV6IbaoPT7lWghDtL6h18+SOXQE5bFoqVnGRITmHcueh5hzLvW2bnciFoQD2b/IRBuAU0ZmV/L1kRAsKU0d/zK19TKVz9btnMR+rLe+WOPXSY1BQVZCfBMGPAX8oD7neVU20E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DU2PR04MB8598.eurprd04.prod.outlook.com (2603:10a6:10:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 16:50:39 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 16:50:39 +0000
Date: Sat, 6 Jan 2024 11:50:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 02/16] PCI: imx6: Simplify phy handling by using by
 using IMX6_PCIE_FLAG_HAS_PHY
Message-ID: <ZZmE1NV6ShVBm5FU@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-3-Frank.Li@nxp.com>
 <20240106153323.GE2512@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106153323.GE2512@thinkpad>
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a1e80c-5c31-4d49-67d7-08dc0ed79ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DeYAsw/7AeO3qtLjEMTEyz8PfEzjGj8pFpDGyRfItnh+GEjbwmVH4qqiXxniXW1dPWmH4c3ITDDTe5vYfspkkY0cdXZ1bSj/Eat0vdfn+8kdKrJQ1ekSMhlycvgByg1AbXYisLmrxJ6k7fWhBwtyxoC5DrS5hYzRNHH0AV6AN9yb7vmGPZIxPBLq2GUTIYHblzWFNf7uCScW8/Zq4wMFW+RqUZ7pqSF4ZaAiqTc1Thnd5qpUDbbv4LXZkHmtT/sFRitva8s3YkDQYTARdRcP7vbgUVpcrQIULdETdVxvUph8iml0POnsaoC+Kp9D258ruMAlaZKc/HoDYXU8tnEcFKHSLDHoNJfJIuQ0rxfyse5MDNPKjHSHV956KEq+EjmZI5bVppa3los8S6YGulFJO6w/CXhPSkcBicES3d+rrFAIujbBR70yn2b+ncE0u0HamMKt1tAomhdJJTp5MaG+TuNlbRxoy/YXgeRhrPFREgWVzmoyFGqTHBnYhYU5AG63wolNoF0Bm8godl4aprLNlxKQlwP6KR5Y1tHCShYGhfjpT4hroDp0sNWkLuszfJbCfeUmDv5/XXHd7KZNwYcoEFrxpMs+T8qgy/Gx68pdeprHYAiRK/IqjLBLXZxdkgP6aHRqzTSwJeagciMwp+GaQdVFQkNGbPWAOUZ6Qy4goDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(346002)(39850400004)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(6486002)(52116002)(26005)(9686003)(478600001)(6506007)(6512007)(6666004)(83380400001)(5660300002)(2906002)(7416002)(41300700001)(33716001)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8936002)(8676002)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODV0OURxL1FmaG1LeTcvWjI0M25ZUEdyUnRvd21ueVgrT1dFV0dnMFlzNFdR?=
 =?utf-8?B?NlpEWmwxVUg2RWRlMEdNQ01nTGY2WWxTbUZpaGtuOGNCZndHbGRERGdscFJ6?=
 =?utf-8?B?SDQ1NDZ6ampGRmlvMmRBVVcvR0RKbDlYOStQdzRDMEhtaEU3STRmdy9TNnVR?=
 =?utf-8?B?MzFKRzJuNlBPK1UxRkhFWm45VHM3VnYwTkVpdEFDeVB5ZUlxWDNMRnpUYytO?=
 =?utf-8?B?U0FkQUEydk1FdmhmQmtKVWZKRDh0NHQzaGZkMFduQ3RrK1owcTRrMEM2eDAw?=
 =?utf-8?B?cGZsaENxV3dVLzNMNjZDN3AyTVBFaUhvYnV0ZHRxQ0grUnFCZSt2RWRSbmpK?=
 =?utf-8?B?NUdiQmI3VXprZWc4eklRbWIrWm5SNm5IdU1HYkNaamxvVytjcVM3QUZyeEFD?=
 =?utf-8?B?TVpZK0xLM0RCeE5iWWc0U0hmVzdUYUJXcXlVWEVzaFFCZFRvVHdoSGYyU0lI?=
 =?utf-8?B?ZVBidzRNeTJpcXV2L3NweUxZeC91aDl2dm9sMTBLMTltaHB6VHBaZm1YelAy?=
 =?utf-8?B?M3JKR1ZHY2FkOHRZSWRPU01BdHFvSjJJeG1LOXRydWJ1RUFKbnpZNDBiNTRT?=
 =?utf-8?B?dEFJT2J5WExDWFlEZlBEOHR0WWpvNS9uWmNQVFdvQjJLUFp1YjdyWWdkTzg3?=
 =?utf-8?B?WlJQZWxCRmovV0w0VjRwbkRvYzVaUDFzd3JpUlU0R3hMeC90cHRiV2RBa2ht?=
 =?utf-8?B?ZDZjS2FndDZZTzhKY2FlL1JMOTRrZXp5RVRLTVJEM1BManhaOHl5clFUWHdj?=
 =?utf-8?B?bTY2UVVkZDIvTnVKc2VxVmN4dlhPektJUnlmSmFPcTF6NE5wNGU2aVduTDUw?=
 =?utf-8?B?aFRnV01PK3JhTmJSbHJ4YVZJK3ZJMnZkV2xwbUpLQXFheFhodXRKNkdQTW5S?=
 =?utf-8?B?dGdPU3N3RDNUTk8weG11Tnowcmh0RnFqNzkyd3NsSVNmdkhRbGt3R0hWSkR6?=
 =?utf-8?B?SlVqUitjWnJPaXcySGV1M0F2cEhsc0h2Mm03RjRBQURRTkxWRU5BQnFCeTg0?=
 =?utf-8?B?a09UbFU1a2IrWUtnd0grblNVZnJsbGQ3bzFBTHBaN2YxK1BuSmdzUDdlRXZJ?=
 =?utf-8?B?dFgwQ0xiNzJEd2JQU2VwRjNpRHNNRzVrL1Y4dUorMGNmazlHKy9ZQVVsUVlY?=
 =?utf-8?B?bUdrUHJNdkRoRGxubXdLdk5hU2w5cWJiNC93d1o2SEpuYkxQQWp5Z2hOdWtr?=
 =?utf-8?B?dVJsbUovNk5ZWWpkeS9BUmhiQUI3NlEwWDN3YXBrOU9FVGhPZWtCMnRxcE15?=
 =?utf-8?B?eGlyNWNRSSthZjF4dkVIMS96T01zQmE1VWMrY2c5U0MvdWlmRGxxajVHWVZr?=
 =?utf-8?B?TzdoclUrb3dIamswT2NVNEN2dGQvdVo3YnFGOVU0ZHJGbzFvbXJ2L0hyNnVl?=
 =?utf-8?B?L1NoVlpBbFdnNTRhdFhrZFRKNEZ6MWd2ZGpiRC9pYW5Iamgvb0ZOYmxtSVhw?=
 =?utf-8?B?WW9hRFN6NXRrdXhLeS83V2N0cHRyRDRNdmtDSng5clZRWUZqSU1RQmJKVDJ1?=
 =?utf-8?B?aVR5Rko2cmI4blRPeHpGQjVPMDVJMWhyNGczSmtKVUR6QkJkMzdveTkyOTRY?=
 =?utf-8?B?MlN4d0hmWENZZ0pWZ1U4bVlaUDBhSXVtenczS1BmdE4wekxkNjJhNFNtcVY3?=
 =?utf-8?B?T05Uck50MmJIK3dJbW1XLzlVWk1WU2ZSdTZXVEhvc2RoZzhnMHk3STY3Wity?=
 =?utf-8?B?UmhzWTBpdlkxREFZanhMbGhRSmgwWmxaNkJyRzJQYUJXMlFJRVU5WGVTZDZY?=
 =?utf-8?B?REhsbkpsN1RsSWxGZmdUa2xST1lZblFSTUZ5TDJFU0JnM25wT285T0hEVXBs?=
 =?utf-8?B?TjI0TnF3MHZmemxXV3MwdGl3MmlVcEU5YXcxYnBmayszVHBoSkQ1U3lsNGFm?=
 =?utf-8?B?eGVJRWJtL0h3ditNZEZ4VlZkV3VYd1FBRFVqTEZ3bkkvL1pqZ0o5ajRsUi9x?=
 =?utf-8?B?Vnova09paDJBOVhlT241djdScXg3bWFYMWNYQ0dHQldaRzBWdGhLZGU4RzMz?=
 =?utf-8?B?T1NmaW9zL1pnaTRaS2RBZ0hEaHJ5S2hCaFlSUDBLWXJ5WmFNM05vODBoRXNz?=
 =?utf-8?B?Y0o1cnEyRVlCbmw0UnU3VFZDbTh6ZC9ENDlKQ3FvbjA4Rmd6UFRTcWs2YUFz?=
 =?utf-8?Q?W+ak=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a1e80c-5c31-4d49-67d7-08dc0ed79ca5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:50:38.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw8HiBb3Sx+ZvQXtqcZNdg6UGKWWjNgGdwnRfs4hrDX2txjvuldcvRS+cMAR7XtmFpC60AP3oxftRkRBLizXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598

On Sat, Jan 06, 2024 at 09:03:23PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 01:27:13PM -0500, Frank Li wrote:
> > Refactors the phy handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling phy.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v4 to v5:
> >     - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
> >     require phy suppport.
> >     
> >     Change from v1 to v3:
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 50d9faaa17f71..4d620249f3d52 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -60,6 +60,9 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > +#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
> 
> Every PCIe setup requires PHY for its operation. Perhaps you are referring to
> external PHY? If so, please rename this to IMX6_PCIE_FLAG_HAS_EXT_PHY.

Actually, it means use phy driver. How about using IMX6_PCIE_HAS_PHYDRV?

> 
> > +
> > +#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> >  #define IMX6_PCIE_MAX_CLKS       6
> >  
> > @@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
> 
> IMO, we would not need these kind of checks in the driver if the DT binding is
> properly validated using schema. But folks always want to validate "broken DT"
> in the drivers :(
> 
> But I'm fine with this check for now since not everyone agree with above.
> 
> - Mani
> 
> > +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > +		if (IS_ERR(imx6_pcie->phy))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > +					     "failed to get pcie phy\n");
> > +	}
> > +
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > @@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> >  					     "failed to get pcie apps reset control\n");
> >  
> > -		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > -		if (IS_ERR(imx6_pcie->phy))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > -					     "failed to get pcie phy\n");
> > -
> >  		break;
> >  	default:
> >  		break;
> > @@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_PHY,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_PHY,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> > @@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

