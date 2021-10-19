Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13285433000
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhJSHsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:48:03 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:25729
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230207AbhJSHsC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOVT+hAWVtjrZ9kvODH2fMZVoesTbcB0KwwCSkGRPIk1kGrOi4kmR8sSzCsmWnRTdE80fISX0GbzorvFB0sGsEh3x/REVjFrDXdOE1jV8hBboL7luCSe6YwOBvO2eOpQXSHPSSLAj0i2Fwp+CvJAZqbQYfpUOMzlJO0+FVEqEH7Rh5Y++byhA8zg1bIu2UbpkXfIMA2297EwEvsf+bemJUpzl+8vd2ZMgYhd+wkkJVCkHpDUshKYfXLKbY3tcQiVOQYoL/m/ObCTSqkxnt4Ug1CpL/YiAXl8HsArvI3C+8Ug6KUCbl6sIkhvoinvgj+TfaC/Q2D4gU18aPetEd24yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDAF1wZXKkeEbJy5m9RE+J4t1wAlbgGqWm30KkbC0Ls=;
 b=DFhBKr9RisEKqXqnK+RjFYBpKT3sw7yua5bJLTFMDej4l9n0veuQ27LobPfZDhzCwsBLr1dLvpCHa0yxeeO5b3jWvYH9TNDlju1F9cBxvxmJoowrKYRW3c8cTtwXPM/baAZs+qNRKgG02bI+SUsh3A+NK0wqAhVYY2o51tlCvinLimvQdyOHy8zDNLjWu8IfmQzY20sjfhCclLJbEqCm6Wzt/+HITwcWOFhCE7J7Zw2pbYX58WbwQ1mbwhpjgg8mIG7cHTUvJ8WYKIn2h/3uM3yvA11Yktq883kYpT6WUiqMruIuUAj5hFzc3xGvdmKP5pIf0hC33I7aEHlGulLL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDAF1wZXKkeEbJy5m9RE+J4t1wAlbgGqWm30KkbC0Ls=;
 b=Cyya3vWZ0mhzpWxlQwThLmnYrpQXLOMRXiCZfmICLJbPC+voluQ+VVbQkfrpn7k6zveNi53+scIHnHNjL3SkpRP8FKSXtnIHklJt7+aFbupV+3Hy/2u4HyCRaBzK+6Weu8jkVo4ck+qpThOC3MZD84QcYhaDghWlXmuDrpwy0+Q=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:45:48 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:45:48 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAWPdUA=
Date:   Tue, 19 Oct 2021 07:45:48 +0000
Message-ID: <AS8PR04MB86761BC77B442F8BB604FB898CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-5-git-send-email-hongxing.zhu@nxp.com>
 <20211015184943.GA2139079@bhelgaas>
In-Reply-To: <20211015184943.GA2139079@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81ae795c-799a-4cf3-741e-08d992d47766
x-ms-traffictypediagnostic: AS8PR04MB8531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8531E335F3D6553C9862B94B8CBD9@AS8PR04MB8531.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrdxTXCdCfqxVs5vYjLlBRQraVZjHz0+KQbf7yN4eSHE8+DxgQyI+aW3SYTg0bvZpzNMiRfORmpNkHQ9ZRJS3TbD8IsGM22ekV0uQO6QOhJ1ntcHM3exK8rulTNRgcG7YBag81KkyLN9cWNGL2q2nCuDBLN0KQWVDDaC0RcledmFPCb69xyRYdd/aluOw89oBcrUkX7GP7Q98XsZshmUTjVeHkIbqUGGSq5bxwgoczoMqFmYAUJihhx82sGkH3q5unTvEh+oCXZNKbTRomZftePbDuSfeHaL7WCmVX5TIrIm0pN3Pl2ZRKV6S208CC/CTkNSiLM/SReBJQaozSrasTtV+RWoxCGihmMiRxRn9PiiC7ywC9k0cg5tzDeq8gkakdaSBLEYk2p6zW/jQtmgkiF6ihDAA2bRUPuZRe8MjhUMBdsdbH6kHVDYts8zH6ljoxfh/NADnWM5OpncKl9Cyfg6xBd3GOi7y210DiSql4Xyk2Zk9XUllS+Mr/vVwkE1e/4ifyl2KBJIc9ynUQGLL0mboPV3H3EwDX9RoNCdymoC5MAybAppi49hxgCjzTTFnUpw0LtvP7Izb0kjQd+rcRj3lAAJGUqd1uYCpKro5ut764T/4bfvYK+sRCK5yfzRjbxTN0N2EgXp+K3KA9EVphYca5riMFJcgGJeJOfI7cjuDwHdrJ4MjMQsAayAxUrwpKvSkDL3zKy1TDJge5P0kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(55016002)(5660300002)(9686003)(33656002)(8936002)(71200400001)(2906002)(66446008)(66556008)(122000001)(53546011)(508600001)(26005)(66946007)(4326008)(38100700002)(7696005)(316002)(186003)(8676002)(64756008)(66476007)(54906003)(6916009)(76116006)(6506007)(38070700005)(52536014)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnXQ9WaBqNHnaYlTNPyuszT0UDVJMYE2ACdmsdpAn2bu6KpU53fjVMEoVdNZ?=
 =?us-ascii?Q?6lpDJa0y8AakeH5qHGO35PhkrxFuHCvHprN4TarOHyrCHCXvq/24BVwXFdZw?=
 =?us-ascii?Q?yCkJRMM31NKmulT4M69/27/emVU6x6N3nIli09WDMK3+kGv9TriAY+QlgCgJ?=
 =?us-ascii?Q?nL3mZtWCmOF2gaGec9adNo1PlGAMstSrzhjne1M2WYp2paqGwl89yDsKULQv?=
 =?us-ascii?Q?2Vz5BHe0kUDSCA29P680vVLUHRRy7Nxgw5O6/jW8pwSwGIfmc10XMiphYMAL?=
 =?us-ascii?Q?DyPYlikEiJQNBB25mW37tCnmkUNEI1yQebBQrzta06+wBkhCRj2QQWTQBGY0?=
 =?us-ascii?Q?XFgTigOw5iR76vTljwlazTmjrdTy2DApKP9p1Wc0c4KzY4qo8ZUKFIImvk9U?=
 =?us-ascii?Q?BZtXeeCCYNwLt0QeXXDlc7yfoqDpzh3dVbSLmpTE3xPs9UnIUdZEvvr4g1jU?=
 =?us-ascii?Q?HsXZOdzTuQg6Jzl5Hr6vEeoYbGq8DaLPDe7tJ3KMh7tv85Fo2GWenMacB8DV?=
 =?us-ascii?Q?hNnulNOdc/oCPRkqlP5FyEUChJXpvAD7diC8keo1xVAe45dAnrHI1HBKuXTa?=
 =?us-ascii?Q?QoyMdxBv2E7rjz4fz2RWCNFCpAcoGMZvMWNT86zsT1n/pLd2CCMN3aCvSIFv?=
 =?us-ascii?Q?Xb2kPPmIFTveRpY1TfI4L8gUUBnpEVo0LvsowtMe0zwlSCRG80+HGOK7QkXb?=
 =?us-ascii?Q?HnykfEeiroUipwjqF87JAtyOZH67Xli0wV5IH07JbfNi0lmerAhfwiGvj2Hl?=
 =?us-ascii?Q?UqEMVRz6CdBfrXbJwZQMDxqrdYWzMI+J8Te9NXhLLOgoRBNjybNPJQSjOQwM?=
 =?us-ascii?Q?IrMUDG1DYuYhl++VsFUFD90oss/eJmIgvh1M7hlncgqqEJChixPqkoSEAXKO?=
 =?us-ascii?Q?G1iaywwqSwbfgXAxuKz0tu0DtpZasY67cxxHq1PelHvSbBjmIeJTLSmWgyPh?=
 =?us-ascii?Q?8QiKmr7MO1Yeza8URcoFnvwLz1DFTYHiXOmNmnZv18i9ODIScyqEAsbbA1L3?=
 =?us-ascii?Q?Vi2eykoyto6ahZBMcxtFOD6I7/nXMYrWGaCZh4OBZfSHlX9/M4cEVTRM6nz4?=
 =?us-ascii?Q?jtO3EQOGZBK2qrUIJ7YpOpppYMz1PkbTdQ6QN7kS/PpLKWfwl4G76Jeu2qes?=
 =?us-ascii?Q?T2ZpTpjrdcO2cg/k6BnqK4pZgXe/cdUSNMIFwKy0t+7akGiamJw4ZeNIQvGS?=
 =?us-ascii?Q?i+jniAb3HVFIlfeNK/4iq7YX1E3Z/305crJ9MHt6NbDxWElzmxXuHFV5KROp?=
 =?us-ascii?Q?dhG9168B4gV8UFtqfhz5yv3Zr85SYW2VLu8RJwZ6xbYr/YkHkfigHPe40GFH?=
 =?us-ascii?Q?XbRJnBz+Lq9OX3RKe7JRH6J7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae795c-799a-4cf3-741e-08d992d47766
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:45:48.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQZyITUxLU+WatLMoi1NeCSoWXsT7eT6dOtiMhreTFUrv/holjEnMXfQamH7zJJbYtXqne3Mxsraf5+dsZ7jxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, October 16, 2021 2:50 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
> unbalance when link never came up
>=20
> On Fri, Oct 15, 2021 at 02:05:40PM +0800, Richard Zhu wrote:
> > When link never came up, driver probe would be failed with error -110.
> > To keep usage counter balance of the clocks, disable the previous
> > enabled clocks when link is down.
> > Move definitions of the imx6_pcie_clk_disable() function to the proper
> > place. Because it wouldn't be used in imx6_pcie_suspend_noirq() only.
>=20
> Add blank line between paragraphs.
>=20
> Can you please split this into two patches:
>=20
>   1) the imx6_pcie_clk_disable() move
>   2) the actual fix
>=20
> It's hard to tell exactly where the fix is when things are mixed together=
.
>=20
[Richard Zhu] Okay, would split this patch into two patches later.
One is used for imx6_pcie_clk_disable() move, and no function changes.
The other one is the actual fix. Thanks.

Best Regards
Richard Zhu

> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 47
> > ++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index cc837f8bf6d4..d6a5d99ffa52 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -514,6 +514,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie
> *imx6_pcie)
> >  	return ret;
> >  }
> >
> > +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) {
> > +	clk_disable_unprepare(imx6_pcie->pcie);
> > +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > +
> > +	switch (imx6_pcie->drvdata->variant) {
> > +	case IMX6SX:
> > +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > +		break;
> > +	case IMX7D:
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +		break;
> > +	case IMX8MQ:
> > +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie
> > *imx6_pcie)  {
> >  	u32 val;
> > @@ -853,6 +876,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci=
)
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> >  	imx6_pcie_reset_phy(imx6_pcie);
> > +	imx6_pcie_clk_disable(imx6_pcie);
> >  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> >  		regulator_disable(imx6_pcie->vpcie);
> >  	return ret;
> > @@ -941,29 +965,6 @@ static void imx6_pcie_pm_turnoff(struct
> imx6_pcie *imx6_pcie)
> >  	usleep_range(1000, 10000);
> >  }
> >
> > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) -{
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> > -	case IMX7D:
> > -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > -		break;
> > -	case IMX8MQ:
> > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > -}
> > -
> >  static int imx6_pcie_suspend_noirq(struct device *dev)  {
> >  	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> > --
> > 2.25.1
> >
