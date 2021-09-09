Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF97540438D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 04:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhIIC1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 22:27:45 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:62087
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231898AbhIIC1o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 22:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/XivPscLPj4kuCXx4UUkgKHg54C5WghBcZM6TgIpqkJVyQ6hEF6mVsP+tenl7kQQ/knpuSvSCelXsxTG0TeRlNurroQdUdi5mHdmy49ZoKcqj9CRAjjvRQ/9/n2nnFFtukZyTN3ZjExaiKQV314UJrylm9f+IZBBxC+f7YjJBE0wj3XzAJzKMTMgAms6YOLzTPGkXWhV3hRuNqVDvK8LIu3YuIrpQmm9zjeSoZ+ykbNLqlCXwGiuMw+hbag6ZpyMj5d2Ib9cjaRKGGfZwCGFeavevOrdXz8JP/YHX9WIHoUlNXq9/Wdvw36FFgekhzcNxEIOVlbwJh5j0zt81/GdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Far/LnK7LOWwTfLPXHH9HnS5iwEkxPGL/jvRgqiFoI4=;
 b=L3XadrXTSrQXz3rwQnQKEBsI5G5SGOmk6QkFtsovuQf017YSiRfMhq6Yaqfl0GnF3Tmeibg6TU7HQAvFEqVlRg9bZo3y4JY+oClsS2U1Eb/b0Ugy93d4uxAmn7KML48c5vwM0XJ+Mqj8TVVK0FjzChbOwC1LPBTFPjQA2zVDbzdITo4vrEO/U1pD2r55Aay3dKZ/lcUlICT1v/VQQvpp8odEVZkQVgt5Ewyh0eX23+/6yl38gOLL7+wsAmanA2hbceTbkSyfF5YZ0XbzJqAnBYE97o8nHrer5zcGwV+le0JBEn12j2qdzKWsZ/KTsHbWJ1O6bkBi9rwIJm2E3M9dQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Far/LnK7LOWwTfLPXHH9HnS5iwEkxPGL/jvRgqiFoI4=;
 b=Y6HyjUuJSibO6n0xqVTUINNr2MlfUxqudp626dTYjyM+gG35EyepZt7d6l0cS/RmIBt/I3AXQAEotHKESF+cItq2IsTIR4PIC5SVdTiPb7i5hztKUBysvEpdGTwlHfPBk/a67HVoxec44sKbc+caXwmzrl601Fuj4U5t4Q2bMHE=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 02:26:33 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef%5]) with mapi id 15.20.4457.025; Thu, 9 Sep 2021
 02:26:33 +0000
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
Subject: RE: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
Thread-Topic: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
Thread-Index: AQHXpIJDyY2p633pJ0mWNxSzi2/g/auaPr2AgAC5ZVA=
Date:   Thu, 9 Sep 2021 02:26:33 +0000
Message-ID: <VI1PR04MB5853C007B43C936B648FD4C18CD59@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
 <20210908151203.GA866207@bjorn-Precision-5520>
In-Reply-To: <20210908151203.GA866207@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28a3ad34-93a6-49ca-a3f9-08d973393da4
x-ms-traffictypediagnostic: VE1PR04MB7327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7327AEDE19C37A193534DDA38CD59@VE1PR04MB7327.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gObkSZ6jK0HoGP2d7NoFYlqIUnfOfc4/tJxePDR9sul75DtNslVLHFxkBv0SXKsfMRdobl3uTO66gfsu2fsqHUh9v1XCHPt54GyjtDmmP0l6eSq057zjMX/78FWSHydmI5UJIOpFE3DhPeqpDvyj33p5QTuRdZCRi+f42WAv8K1DketOVApZ2VxpVYvkRU1v3iza4FqRyLZZfxWsA3dfjf0/kJkSljR6IvR3KOE5ojD4PZGLAS/0q7bwAa8YdA57o9sNN9D9JE+T1QD4C58laZi6cOf1lwmhRD0p5hesauFV9kdLKTPeMqxQTqdOKsUw9LGlRgK7mNBkW6iMuvon75re86AYevP/goMHLkKRLlWTTWEednm9UEU2YDcbTOHbJN78UzkXUdiOXSjIiH5rEF0yt4Hk0EKkas1uBPE0icLeZxbqinlPiOTFBfjvdobSpBI8CAlApYaz3j7oV9cGdiPgWc/3Go0c6xO51AkiWGkp8GhVNtEZlJLAKrldjCreIVZnA94Ht6Dd/ZIbBWSjsuLl0d09s0IhHbH+pIFR7f5RbhiU8ku/CAqwO6wt8eRCBEIu1T5gL90nE3gW8V8p2EyVsEtT8hRwPm5gHR7bU8J8uJfWJsgfvmvIZ4UGe1+37PD+N+ZhaH5ubuOeshyj9XcbpOvw/J7aKkjoq84G8mCicOA5c5Peu6itYYYeRCEXeXOye5NRU4mdS5SkxNz/Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(26005)(52536014)(86362001)(2906002)(186003)(38100700002)(9686003)(55016002)(6506007)(83380400001)(54906003)(478600001)(66446008)(66556008)(316002)(7696005)(33656002)(6916009)(38070700005)(8936002)(76116006)(53546011)(66476007)(122000001)(71200400001)(66946007)(5660300002)(8676002)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGIERVzeJlOvgXI1zqz+AFmmfmGRqqGfNHh/XzuZxdwx73L3cI9DILguklOP?=
 =?us-ascii?Q?IrWNbrH+7bTY92816rNSttnCUjy6h4/pJFuYhrWNKhwgOqBFyG747XdhdYWO?=
 =?us-ascii?Q?QNlvC3pqBXMzuuq7H95jisjlf1Z4/ZzfraMD1vKF/c104RC0YS9OoxYBVri7?=
 =?us-ascii?Q?1IIB6nUWiQXxvVe8Ywft9f4JziNQG4cKWL8Ev/S64kW+yC/x1+ZVPH+CTnCk?=
 =?us-ascii?Q?XOrKWFIwwI8oYhcBUP18viE/h9pFp/us6Ic8AI3exIKw33mWr0Wqj+eONFS4?=
 =?us-ascii?Q?33WK0Eu0YCtFkOtgFzYtpDXUQ/65B5P2AgMvs8uU5q6IDnE7XSVN2zsY7fXZ?=
 =?us-ascii?Q?4Gj9QblYLhgymfDOHmgxcSIjtydorBXeUPaGrz1AbT2L8DM5c+2P678XNWta?=
 =?us-ascii?Q?0zHsQDK5NpqMZf4yrDWEJlEY/d1nIfbCX2gEgXfWcRMddL3O02gRPUlvJcqc?=
 =?us-ascii?Q?Eymtr8gyCa1Y9U6lw3zePffsoI8SQAh9u/fGouKzZXW2jDCHo368e1uwArJ5?=
 =?us-ascii?Q?q5dNcSqTb9s/D9HhqPOF+0lEuS4pfsMHBmYbwZ05SOLHnop3Twwt09VpCCAm?=
 =?us-ascii?Q?oMHg0bAly5mqi/xxyktJsHDHlozFQFKOEJSfFQfGab5g1gbpWaCx/uE28Zeh?=
 =?us-ascii?Q?9vaBKiZ6zvgT9/9cpiVpHg0+8jRWZb+Yyr9BF/fdEN/4aaKq1eaZ+vmcGO5U?=
 =?us-ascii?Q?cUKM+5olbeyU0tcHFDRvy4drqUpGe6pxDid9Ik7yebR89fgbt8rVgFBAFqFF?=
 =?us-ascii?Q?B+ArfsKRCX2LeFr1AzB4ilTTNk7qF2U34zRCbduhYbq6zDiyGYZin830pTdv?=
 =?us-ascii?Q?EE7KeKPfj2AZ2jJp63dijbsLn/wh79oHrDW5MRgArF7YZ9zaQh3hgOS42Raz?=
 =?us-ascii?Q?IQ2mfMkPN62IV6WWdUZZ6kqBcIponKAQJa8LqRtrSk3XyJpQhH7ahLsf5rq3?=
 =?us-ascii?Q?vor4+zFYAT55e0dPskBBuVY1VXA7H6D8WPwl25pzhwloLF9w2d2atwSkgSW2?=
 =?us-ascii?Q?+fcuA/5WGNjlxrmGTx5tuD8bRh+hbsbJjp9AnjDAM2nYPGpzt0hIb0U+MnX0?=
 =?us-ascii?Q?UDDL9qUwvNDnprOBVON8jw1w6uasa5cjtz2letf4gnkGapl7MCxQKd2oxVP5?=
 =?us-ascii?Q?T1LtITur97dFZu9VQucnviW99dAWQwUIs2h/BP+TBHMV9EOyf2tewmP0e0pG?=
 =?us-ascii?Q?/P2lsRgfjrTe2kCpmEkSWj0NrWPuEK5Xd73qA3z6i9ftZKLoqRUb1iDKfuww?=
 =?us-ascii?Q?93Jy05hUoyQmI01aPQ5H37bQqT+lI1rehiuirTM5iqmb+oT/y8EXwFDUwtrh?=
 =?us-ascii?Q?WhqPlU5fOkROrUMYa2fZRaxp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a3ad34-93a6-49ca-a3f9-08d973393da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 02:26:33.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aJyMrEcpI9OUd9AFdzb8fTF8nGPYKmRm8CyFuWYgZpcQEkaaZvybYIZWkUw9jgu0a4p7UuHWobMbrVBfyp0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 8, 2021 11:12 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
> standalone function
>=20
> On Wed, Sep 08, 2021 at 02:59:24PM +0800, Richard Zhu wrote:
> > No function changes, just encapsulate the i.MX PCIe clocks enable
> > operations into one standalone function
>=20
> When you update this,
>=20
>   - it's helpful if you include a cover letter with a multi-patch
>     series, with the patches being replies to the cover letter, and
>=20
>   - please follow the sentence and formatting conventions for subject
>     lines and commit logs (driver name should match, capitalize
>     subject line, end sentences with periods, blank lines between
>     paragraphs, remove useless information like timestamps from log
>     messages, indent quoted material like logs by two spaces, etc).
>=20
[Richard Zhu] Ok, got that. Thanks for your kindly reminder.
Would use the cover letter, and reformat the subject lines and commit logs =
later.

Best Regards
Richard Zhu
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 82
> > +++++++++++++++++----------
> >  1 file changed, 51 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80fc98acf097..0264432e4c4a 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -143,6 +143,8 @@ struct imx6_pcie {
> >  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
> >  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
> >
> > +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
> > +
> >  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool
> > exp_val)  {
> >  	struct dw_pcie *pci =3D imx6_pcie->pci; @@ -498,33 +500,12 @@ static
> > void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  		}
> >  	}
> >
> > -	ret =3D clk_prepare_enable(imx6_pcie->pcie_phy);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_phy clock\n");
> > -		goto err_pcie_phy;
> > -	}
> > -
> > -	ret =3D clk_prepare_enable(imx6_pcie->pcie_bus);
> > +	ret =3D imx6_pcie_clk_enable(imx6_pcie);
> >  	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_bus clock\n");
> > -		goto err_pcie_bus;
> > +		dev_err(dev, "unable to enable pcie clocks\n");
> > +		goto err_clks;
> >  	}
> >
> > -	ret =3D clk_prepare_enable(imx6_pcie->pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie clock\n");
> > -		goto err_pcie;
> > -	}
> > -
> > -	ret =3D imx6_pcie_enable_ref_clk(imx6_pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie ref clock\n");
> > -		goto err_ref_clk;
> > -	}
> > -
> > -	/* allow the clocks to stabilize */
> > -	usleep_range(200, 500);
> > -
> >  	/* Some boards don't have PCIe reset GPIO. */
> >  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> >  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > @@ -578,13 +559,7 @@ static void imx6_pcie_deassert_core_reset(struct
> > imx6_pcie *imx6_pcie)
> >
> >  	return;
> >
> > -err_ref_clk:
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -err_pcie:
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -err_pcie_bus:
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > -err_pcie_phy:
> > +err_clks:
> >  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> >  		ret =3D regulator_disable(imx6_pcie->vpcie);
> >  		if (ret)
> > @@ -914,6 +889,51 @@ static void imx6_pcie_pm_turnoff(struct
> imx6_pcie *imx6_pcie)
> >  	usleep_range(1000, 10000);
> >  }
> >
> > +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie) {
> > +	struct dw_pcie *pci =3D imx6_pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	int ret;
> > +
> > +	ret =3D clk_prepare_enable(imx6_pcie->pcie_phy);
> > +	if (ret) {
> > +		dev_err(dev, "unable to enable pcie_phy clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(imx6_pcie->pcie_bus);
> > +	if (ret) {
> > +		dev_err(dev, "unable to enable pcie_bus clock\n");
> > +		goto err_pcie_bus;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(imx6_pcie->pcie);
> > +	if (ret) {
> > +		dev_err(dev, "unable to enable pcie clock\n");
> > +		goto err_pcie;
> > +	}
> > +
> > +	ret =3D imx6_pcie_enable_ref_clk(imx6_pcie);
> > +	if (ret) {
> > +		dev_err(dev, "unable to enable pcie ref clock\n");
> > +		goto err_ref_clk;
> > +	}
> > +
> > +	/* allow the clocks to stabilize */
> > +	usleep_range(200, 500);
> > +	return 0;
> > +
> > +err_ref_clk:
> > +	clk_disable_unprepare(imx6_pcie->pcie);
> > +err_pcie:
> > +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > +err_pcie_bus:
> > +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +
> > +	return ret;
> > +
> > +}
> > +
> >  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)  {
> >  	clk_disable_unprepare(imx6_pcie->pcie);
> > --
> > 2.25.1
> >
