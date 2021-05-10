Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC73779AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEJBQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 21:16:48 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:52549
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhEJBQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 May 2021 21:16:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1j+pijJrJh0wDXq+hMXZZ7sOBp/QgeqpxKHLuiSCYBr4sieVpyrr5uARMYP/wfZRmDJzuiV5THYb9qTOhjCy9iIjOR7ndisbBUzAE5IaX6aMepl7zHtwnxn0Ey5I87/ECHzPZ46HjcsNG8inWt3qqk74dthcXUchaiPH0CmlXae6hP3Ulbb7xtuvHdEKiqwOR72a3Iblc62zyommEWs0BBeUsQ39nLIfonA5YERKg2C6yckfET75AVkjajkWEodX7DJQn15mmh6JRonL+0/bLPgdSpxlwHOBjVyyAJeC7GTbsnSlrVfTB9tM5OimqnH6hwOvUDVMAZZnjDmcNQCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtcJJ7GzBqeDvJfBPORvnrKFQdcQEkyMD626ZGvQPeE=;
 b=NYE4u3Ojpxr75VysXLuoBda1VEErs3QKZRdkO0HlGr0gMps+KF7rzNIEe7yoyE3GnimsdjQvZrL8MFB/FNYbodWVB3Xy83OOsI088cqR1+1gcMCqebgFDSPqCyGA3UJcvjxFCOHjMCZJPv1JSMaXSwhxCD7qUlP/X2iJ8lnufmV6VhnlYosN9l9PqWgZbSxIvGH48mGmi+AD2nRbmBF2+hwUI2ZGfr8dwfAEODFzBm9qGxMskyimnXW1r4K7CCymNJZ1hq27EaelWuUXjGdfpAu+aHyBiS9yJINoatQae6g0hmusd7B98TdRa4L1wsF3snTS3/2k2H9akw6KQsS4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtcJJ7GzBqeDvJfBPORvnrKFQdcQEkyMD626ZGvQPeE=;
 b=a9515JnaaT12kGfPu/smH75lhCsWQh72opn+xN8kNUinGf0BvvROrMlmhKIczTqLoj6i3nyn5wE/wRh1XZGHnijfPLSmoqKxipZ1xF5Eu3vNvkc/9QANC+ASkDi3c+OHhLlLJ7eEduizKWFnwyuZZOheoY8Mr3vGVS3SkQaWUz8=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Mon, 10 May
 2021 01:15:42 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 01:15:42 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Topic: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Index: AddDBtp7Y9XPRmfJSiqTAl+6KfDoQACMvJjg
Date:   Mon, 10 May 2021 01:15:41 +0000
Message-ID: <VI1PR04MB58532F417B4A5F65ED00F2FA8C549@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <VI1PR04MB5853B8F4928D85D1490C05A48C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5853B8F4928D85D1490C05A48C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81fdfba4-268e-46ee-a118-08d91351213d
x-ms-traffictypediagnostic: VI1PR0402MB3550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB35501E7359F74B6EB33EFEED8C549@VI1PR0402MB3550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEmvT8z6anU390rsRmJ3kpaaL0Mvt5OGlK+jmrYGqYtBAx+KZCzFIsxr+nbAE6FgmaQLW0eJWvEb9lMaYH+vL0VijTcjL2o00SRFgLlKzuwMUTokgaEnoyBkeh9ZM0pAWQGqicZKFpVTaHvQoEMmUgDvIkg8OlGzFj5PurF5zhS6+THISaMJiKtrlgiJ+sSIHU29TQZzQGPey0ofD6iFxMTbCOMkUzF3j7iwDZrXWyMCGKNLGmVgSzAL3UIeV9h34VYEFTcnHUxff7EEjyBIICCt5/Vk3swhbwKczvwbgJBaB/z8sL/c5TgXxQAHk6C3JLyG8FGkmuO+C4p5BN6QTFmroxKeoy4pnjUOhTCMogCuYB6jOBmG4Wt8ujDXtkS+hZV0oJx+nSxfhVLI8WEObx5wMKSEQJL2i/0gFhF+3chG2JOzgGgf55hHFGvCBkbf7nZ5meMkZ/BtAPXTmh9KVhZ6urLU5RvexxVa6OQSZugB3PMKNzXVperzAHu89W61E6KgPEvNWNGDticY3YHPXIoXDwkmcsfAwi80jbYJYxk9b8x145ID4SF3kNlMuq1LiLyOsL1HgWPtPFDnt9P3YmtzHzk9dFhCYPe55twYT0g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(4326008)(8936002)(9686003)(38100700002)(33656002)(53546011)(52536014)(122000001)(7696005)(76116006)(83380400001)(55016002)(316002)(71200400001)(6506007)(186003)(66476007)(2906002)(478600001)(66446008)(26005)(86362001)(8676002)(66556008)(64756008)(66946007)(5660300002)(7416002)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MI38jJo1veY3NkNF/hGuLyj/v+AuxJv93oI+9ESFe3prtG0twgOm/TFrvahx?=
 =?us-ascii?Q?zyOWM2IxU7u7MDmZaHLXrk3PFLk9WIRKIZpusO5lCVuSjL6QzlPBGEbbw1lQ?=
 =?us-ascii?Q?SvsOHTPsFBwRd6HH0DBOeGNl6jq6tc7ZvemtESH+hmxAMq6e91bx/J/e8Q4/?=
 =?us-ascii?Q?vnBNjnR7kHO7UrUkXNTknE3m5K4NQ2sihQ4suEk0L/yxmopACUZe6a5nTLoq?=
 =?us-ascii?Q?b1981FBugrLNFnIjZGFsBDRHN1vNB5ZgKs6XZY58JtIRFZi0RyOy05y2stsN?=
 =?us-ascii?Q?BItAERo45KTzVwfwsQiSeZu5qQLU4z/BPXEkH34NfmHUQWWCNHBQ7FSM6xuv?=
 =?us-ascii?Q?7EntEdv/8Ra0KkFaguloO3K6da4jNwWlykCbW0n9FHwXMeKtCwV5KZS8QP1O?=
 =?us-ascii?Q?v6SDMPqJSm0B5yN32QRp92j0j0/F8Jy05c/hX0DVBhe3GFwN4WeBVdxSZrx1?=
 =?us-ascii?Q?34FaOPssx6CD7/YbdEcsVbDnGSv9fOGuGdI9KC+1WyBFo8c5S88nQ4EjMat7?=
 =?us-ascii?Q?XGq08j7S6PuONW+NCn0Df1eJKeVVs3+ImNndI1TjUpEK/qZ8Zm2pqx+OaeEj?=
 =?us-ascii?Q?hhJAJZw1Dtj5b/8AWVaaSB0/+ZJvpbmp1qwp6ayppcaDGojoQ5deN37VBVZY?=
 =?us-ascii?Q?OAZZaOeeQ7TV+2VMLDUYfRzvEOxCC2g7OO63NOzdHvpF9jhojXdib3RbiKM9?=
 =?us-ascii?Q?baoPqG8PX2sPE0Bz+HxTMcNiMvVjc0NB+gJq6eVyzuA+Iaw7FTg38JFPw2vl?=
 =?us-ascii?Q?wjdJv42BcrZTZhc9nCq6F/CLZ4hGcDdqEYWlDrpZum3mn5KrCAIATGUlvs9g?=
 =?us-ascii?Q?lVZCykww18gnEFRsp30FK0bnb56m2UqRiNnqFBKLop8dP1MKne3kSbsAwgAR?=
 =?us-ascii?Q?ok4ANmDjLqrTab0p6osNha977F9zFojM0prkSCS6zUkoy94sqDO9J9PIpfti?=
 =?us-ascii?Q?5gNN/VLCTSXUtgwArRdPDMWcwyVA2kaSnGvT+mATpr4B8cZE1LPBCqJlMEAZ?=
 =?us-ascii?Q?XAMs6Fs6WVzFrY3xYC5naBWTMuUHRWQnQZgVuVO49AvnpGfB2J8rV04XX08L?=
 =?us-ascii?Q?Gn4cW9qTS6G7Kx4Qbf8sQ9ttnicwKf/Wj/NkBK5W8V4E8xSuJpsm2QX0GNsw?=
 =?us-ascii?Q?eJ+XI2RQ+xCFh7dOS5hAfUsKQcWq6sAPeL4OVXzRqmkUXMe4++Mf2c+4NEhu?=
 =?us-ascii?Q?Jk6S/szRwAUsXaaKJbSASW7p+jLKwR2A6UOZsRmw0SWqImmBG8JZmQruMIYk?=
 =?us-ascii?Q?N7q7Xd++9rtOeMLXBoMc/En74TBvjfAmwsEVnrW36M7HAxRDCSPi7GLoUZFc?=
 =?us-ascii?Q?XTQlZpxMk7/olj5aFqh8ecE2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fdfba4-268e-46ee-a118-08d91351213d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 01:15:41.9372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFOs23nLLlOBgnii2FOAo8yfZlmEhvNKCxGhH9aWLwYVhcUOyUoNj8BiNFjz/Ripg9Q1usMEGWrlTVW3NSWoFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi:
It seems that the email sent on May07, is missing.
Re-send it.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Richard Zhu
> Sent: Friday, May 7, 2021 2:18 PM
...
> Subject: RE: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vp=
h
> voltage is 3v3
>=20
>=20
> > -----Original Message-----
> > Subject: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when
> > pcie vph voltage is 3v3 On Tue, Mar 30, 2021 at 04:08:21PM +0800,
> > Richard Zhu wrote:
> > > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to
> > > data sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic
> > > design, the VREG_BYPASS bits of GPR registers should be cleared from
> > > default value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator
> > > would be turned on.
> >
> > Maybe something like this?
> >
> >   PCI: imx6: Enable PHY internal regulator when supplied >3V
> >
> >   The i.MX8MQ PCIe PHY needs 1.8V but can by supplied by either a 1.8V
> >   or a 3.3V regulator.
> >
> >   The "vph-supply" DT property tells us which external regulator
> >   supplies the PHY.  If that regulator supplies anything over 3V,
> >   enable the PHY's internal 3.3V-to-1.8V regulator.
> >
> [Richard Zhu] Hi Bjorn:
> Thanks for your comments.
> vph is the "high-voltage power supply" of the PHY.
> How do you think with the following one with some minor updates?
>=20
>    PCI: imx6: Enable PHY internal regulator when supplied >3V
>=20
>    The i.MX8MQ PCIe PHY needs 1.8V in default but can be supplied by
>    either a 1.8V or a 3.3V regulator.
>=20
>    The "vph-supply" DT property tells us which external regulator
>    supplies the PHY. If that regulator supplies anything over 3V,
>    enable the PHY's internal 3.3V-to-1.8V regulator.
> BR
> Richard
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 853ea8e82952..94b43b4ecca1 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -37,6 +37,7 @@
> > >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD          BIT(9)
> > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN  BIT(10)
> > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE     BIT(11)
> > > +#define IMX8MQ_GPR_PCIE_VREG_BYPASS          BIT(12)
> > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE  GENMASK(11,
> 8)
> > > #define IMX8MQ_PCIE2_BASE_ADDR
> > 0x33c00000
> > >
> > > @@ -80,6 +81,7 @@ struct imx6_pcie {
> > >       u32                     tx_swing_full;
> > >       u32                     tx_swing_low;
> > >       struct regulator        *vpcie;
> > > +     struct regulator        *vph;
> > >       void __iomem            *phy_base;
> > >
> > >       /* power domain for pcie */
> > > @@ -621,6 +623,17 @@ static void imx6_pcie_init_phy(struct imx6_pcie
> > *imx6_pcie)
> > >
> imx6_pcie_grp_offset(imx6_pcie),
> > >
> > IMX8MQ_GPR_PCIE_REF_USE_PAD,
> > >
> > IMX8MQ_GPR_PCIE_REF_USE_PAD);
> > > +             /*
> > > +              * Regarding the datasheet, the PCIE_VPH is suggested
> > > +              * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> > > +              * VREG_BYPASS should be cleared to zero.
> > > +              */
> > > +             if (imx6_pcie->vph &&
> > > +                 regulator_get_voltage(imx6_pcie->vph) > 3000000)
> > > +                     regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > > +
> > imx6_pcie_grp_offset(imx6_pcie),
> > > +
> > IMX8MQ_GPR_PCIE_VREG_BYPASS,
> > > +                                        0);
> > >               break;
> > >       case IMX7D:
> > >               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > IOMUXC_GPR12,
> > > @@ -1130,6 +1143,13 @@ static int imx6_pcie_probe(struct
> > platform_device *pdev)
> > >               imx6_pcie->vpcie =3D NULL;
> > >       }
> > >
> > > +     imx6_pcie->vph =3D devm_regulator_get_optional(&pdev->dev,
> > "vph");
> > > +     if (IS_ERR(imx6_pcie->vph)) {
> > > +             if (PTR_ERR(imx6_pcie->vph) !=3D -ENODEV)
> > > +                     return PTR_ERR(imx6_pcie->vph);
> > > +             imx6_pcie->vph =3D NULL;
> > > +     }
> > > +
> > >       platform_set_drvdata(pdev, imx6_pcie);
> > >
> > >       ret =3D imx6_pcie_attach_pd(dev);
> > > --
> > > 2.17.1
> > >
