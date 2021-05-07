Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891BE376029
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhEGGTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 02:19:16 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:7073
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233523AbhEGGTL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 02:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOR1iDV2nO9QGn0M5zshgYSSXe1LeafjUnkszzA8e2cUWlepw7AlI5AaKqUsjukRSDGbpYqHw+8oc3ZTLF9Xmk5cjHnCR13QBuZ8laTUGU5Hx2kuWLQfJLj4mab6KPZ4kSRkTEKQkiZDzjK5arBYY3LFfwY4uqM1sS4WqPvn6Ow3BCLcM1NHKUAwO3VAmhGvydwu341JO/kNki/WG2EQMoc8B6sO6TyxmUUxOoCuktssLjWd04WUyyICC3HPlp1vGv+Y/o8IJZT31l1CXol1RTaRyr1OC/eR3fOZdUmeKqjYxmytjAxfuh8GdcY8XgkCZoI5KT33s4kvhaONBt4hwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KipsQaqSYKawM+1hBh/FGUoq0X1KL8DLS9xJ6bGlbvI=;
 b=LrgwGVXBqfOxItSo8CS23o7VYIu2fSH0FFbrEzj2erZi9Yj8u+Y87FqLNCNScVSTOi4hmoqof5AZ2F5NYblhYGEL9qtTB19/nJsB7m5qWuq4q96PUTH9OslCYvlkqMCvRwBXobsPumaui3gKlndPprl5q6O/SNdNSB4OHX3j7SfIQDMAMfXCUWya6/xES5yvEOSTKsM3jP8LqK7jSZEN/jUO1DWBEnfvZ6xy41tinB5M6k9xsPo40WWt32BgfRMsm+Gj7k3o+ZMgAbhjV8T+rBVPZjKdVMypj4N5KYDCCpcuI1ijzJlo5xKsavX9BtZNufT0xM4jER6+Q3eE3ilfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KipsQaqSYKawM+1hBh/FGUoq0X1KL8DLS9xJ6bGlbvI=;
 b=rC/yUnE7s7Koa2QuVgnTO9UOEJgTpBSM/EMKZDLtgL/x5dgjKr0HLJEpFdpILe7D5UPsnxvxmVHN0k4alcL5+xwk+Vq3UdOJLBmkFfEo2n2q1yDI8sBMwNzM9GHaxXgpxK8D931C8AHgLjGFYHLK8vWImJ7WDUeeQ8OvJDk/HdA=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 06:18:09 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 06:18:08 +0000
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
Thread-Index: AddDBtp7Y9XPRmfJSiqTAl+6KfDoQA==
Date:   Fri, 7 May 2021 06:18:08 +0000
Message-ID: <VI1PR04MB5853B8F4928D85D1490C05A48C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b0a788-9c83-4f44-61a4-08d9111fe26b
x-ms-traffictypediagnostic: VI1PR04MB6942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6942B847E00D0F83C89AFDC68C579@VI1PR04MB6942.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/wv52M6KSHb5nz0h5bIDDyfEJHWVYdtPU49lBEgUYgc0rGh7TDF8RiEXomPvn+WBxk9H94MZfzfHq0YJx3YQDlgveN7GAsrWuGgK3cKOfkmQNyGTmZRy+NFHN6MM17dVtkwGS+8xEBLeGlcXEOPB8yexpEB6Sua3bVUEXcO855tEn7Sho8GU6rWzCerB50hAqdiRsmrR+thtDeETelKtbK9Rf8anXNmRj0oiOOvBkxzkyOMOR6WT80A7YYxg4PtIlfO5L3nN+M7GGMhD/GI6BPivnNaYH2yenACwZI5rTIdL+J6X0HDtfczOLQAjK8awgclzHZt/JWSnE32RGtdSIxtts/VCsXR/ItP3M1OAYsmaaaZLaK2lfFJkRIDGra4ecaIdV5nVEam+l+w2c+Mv41X9j+CB6tdJ/zctWwtWprJCoL2OLHDwJTHYY/cUieCNm8ZAOjb15M1C9t9Vi/MdyfZDnR1RBIUcQ23IFZKNBkHjH/9YOBpP9UeLXVADGz56al84Bq79KcI/hBuMiZwHxSQJFTvjxxdxnzcD01yc+WS3c9XCbQi+SYWI/Pn49Esvy+U/Oin0ASy8Tpok/EyMFFAM1WPAqJxM34bfL8V4Is=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(4326008)(55016002)(86362001)(66946007)(54906003)(52536014)(76116006)(9686003)(66556008)(6506007)(6916009)(7416002)(66476007)(66446008)(64756008)(26005)(5660300002)(38100700002)(122000001)(8936002)(83380400001)(7696005)(478600001)(186003)(8676002)(71200400001)(33656002)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K5mtLFeRx1zpR0DQZ00GKFFxI1Fr7u8rg0uVKiFIpnRpi96d4X0zH/RBmIui?=
 =?us-ascii?Q?urXMOxSN7zXwXrtEEyUPm/JGtJuvwmF2lsj1Nfl9QvF5oRIlR6bNigaOVMOZ?=
 =?us-ascii?Q?n6sJj6LIp8RBCJB7+zXrEFupszEKhbQdkdCKSSZ0qT+DABs0xaBGDLOGtveY?=
 =?us-ascii?Q?mOzrtVAzBUaiLDGNvbiHarhUoe7gz15v7Z7TCGI8Yhy5lCSGCEIPbTYyMofn?=
 =?us-ascii?Q?0AMotB1LCbM5UP+vLf7RnSiNBJFMbHxeXMEd9FRErAQkVXU5KL4rS/xbsNNP?=
 =?us-ascii?Q?vcQ5aR6uv/PRE/A3/zovm2ZTyxek4NEldGcm1BamZo3rmBNpF10eQER5XUAY?=
 =?us-ascii?Q?IBvAd+sxNIFFXZiVs7scLfEHmUfhgWJ4/gYSxx7OWgtFD0qLez8NPUdwEpw/?=
 =?us-ascii?Q?6yePIMnSY1i9o6UvhCvSmDG6SJwVApvBvJsBlHQaGYHM0SGw1mKevZQn9ANc?=
 =?us-ascii?Q?rIlgkpHEcLqSqfKmtLObvauyiJbJSdfgsuszub5qBYFOuBf9xksx3Hz+TW8E?=
 =?us-ascii?Q?pkC4tsiwHKccjC+yOKtGbYYoDZB9D6p7fvxBjoD7jmFZ9K4nshoCUoFPUkQK?=
 =?us-ascii?Q?G8ej5chGM7QOMNCUvxJC9N2ixMI5D+TCR1oFy6I72iYL+48t0O5xR1RaCBO8?=
 =?us-ascii?Q?a1prFxKkl4AxXpUM24e5sHSaTLGEXwBYPBre28Y2U5cC8fbqdiZsPjixBeD2?=
 =?us-ascii?Q?96qT98VmrEVLFYzXHUR5Ua/uckqfMk0xKIx5EB0xd2oU4atKH0IeRMQXNHtR?=
 =?us-ascii?Q?PShxFRO/JQrdQBpBbsVj/PXphZqVfHVCwnP3BS8Hjhifd0xSUduQLiuRoYJr?=
 =?us-ascii?Q?0aqACAGXXcve7CRxo48jiPRQloPQLJ3hxxnW/osV9rvug781zuCFICm29eDR?=
 =?us-ascii?Q?k780to5gp5af2gxh7kldbSyOdiGh28OFGYlvsb68uR68ozQ7Sm4jk39CT0CF?=
 =?us-ascii?Q?6sU+l/v2xfgqFlyQNx/IeIoRCOSI4siP/AFXCN6sHPStAMd99xTMv9otaRIs?=
 =?us-ascii?Q?6AkBoCQf8XRfspAHZFH+mSS4xFwyDDcgpYb3kFg2dCgZ8a3POBWEzzE04j/g?=
 =?us-ascii?Q?qd1TemuTqwk35WQ9yQ9DLJyc2PQv4lCZJyjPYZRlqRM7uZLhytglB2qbcZDS?=
 =?us-ascii?Q?jtPCGUILDVcNiuDVqQjH+hb4fehauPg0Yf9jpIDZzb1y/Q3OLmBHbGF4LNTw?=
 =?us-ascii?Q?iyMqGkKSG+z1eYDaDcmUB6xoB3RWK73pZe8HJx/kmNUdi1ur5Ca/tVq3Ny7i?=
 =?us-ascii?Q?VjxXjt3skrndK4iq/xTq4DIgcmLWnznUjcPxe8zyeNnqCyKellpmw5utXmOs?=
 =?us-ascii?Q?mzi3tJjxvtL2TOoOEGRugPO4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b0a788-9c83-4f44-61a4-08d9111fe26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 06:18:08.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVA+PJBfKPsyoARhCbierW4UVNSQnXOdK9ayS8HBIA6L0JPXWiYvg8Hs5OuIY4YG8b0ZdN7QzUreJKay9bZWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> Subject: [EXT] Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie =
vph
> voltage is 3v3
> On Tue, Mar 30, 2021 at 04:08:21PM +0800, Richard Zhu wrote:
> > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> > sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> > the VREG_BYPASS bits of GPR registers should be cleared from default
> > value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> > turned on.
>=20
> Maybe something like this?
>=20
>   PCI: imx6: Enable PHY internal regulator when supplied >3V
>=20
>   The i.MX8MQ PCIe PHY needs 1.8V but can by supplied by either a 1.8V
>   or a 3.3V regulator.
>=20
>   The "vph-supply" DT property tells us which external regulator
>   supplies the PHY.  If that regulator supplies anything over 3V,
>   enable the PHY's internal 3.3V-to-1.8V regulator.
>=20
[Richard Zhu] Hi Bjorn:
Thanks for your comments.
vph is the "high-voltage power supply" of the PHY.
How do you think with the following one with some minor updates?

   PCI: imx6: Enable PHY internal regulator when supplied >3V

   The i.MX8MQ PCIe PHY needs 1.8V in default but can be supplied by
   either a 1.8V or a 3.3V regulator.

   The "vph-supply" DT property tells us which external regulator
   supplies the PHY. If that regulator supplies anything over 3V,
   enable the PHY's internal 3.3V-to-1.8V regulator.
BR
Richard
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 853ea8e82952..94b43b4ecca1 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -37,6 +37,7 @@
> >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD          BIT(9)
> >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN  BIT(10)
> >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE     BIT(11)
> > +#define IMX8MQ_GPR_PCIE_VREG_BYPASS          BIT(12)
> >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE  GENMASK(11, 8)
> >  #define IMX8MQ_PCIE2_BASE_ADDR
> 0x33c00000
> >
> > @@ -80,6 +81,7 @@ struct imx6_pcie {
> >       u32                     tx_swing_full;
> >       u32                     tx_swing_low;
> >       struct regulator        *vpcie;
> > +     struct regulator        *vph;
> >       void __iomem            *phy_base;
> >
> >       /* power domain for pcie */
> > @@ -621,6 +623,17 @@ static void imx6_pcie_init_phy(struct imx6_pcie
> *imx6_pcie)
> >                                  imx6_pcie_grp_offset(imx6_pcie),
> >
> IMX8MQ_GPR_PCIE_REF_USE_PAD,
> >
> IMX8MQ_GPR_PCIE_REF_USE_PAD);
> > +             /*
> > +              * Regarding the datasheet, the PCIE_VPH is suggested
> > +              * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> > +              * VREG_BYPASS should be cleared to zero.
> > +              */
> > +             if (imx6_pcie->vph &&
> > +                 regulator_get_voltage(imx6_pcie->vph) > 3000000)
> > +                     regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > +
> imx6_pcie_grp_offset(imx6_pcie),
> > +
> IMX8MQ_GPR_PCIE_VREG_BYPASS,
> > +                                        0);
> >               break;
> >       case IMX7D:
> >               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> > @@ -1130,6 +1143,13 @@ static int imx6_pcie_probe(struct
> platform_device *pdev)
> >               imx6_pcie->vpcie =3D NULL;
> >       }
> >
> > +     imx6_pcie->vph =3D devm_regulator_get_optional(&pdev->dev,
> "vph");
> > +     if (IS_ERR(imx6_pcie->vph)) {
> > +             if (PTR_ERR(imx6_pcie->vph) !=3D -ENODEV)
> > +                     return PTR_ERR(imx6_pcie->vph);
> > +             imx6_pcie->vph =3D NULL;
> > +     }
> > +
> >       platform_set_drvdata(pdev, imx6_pcie);
> >
> >       ret =3D imx6_pcie_attach_pd(dev);
> > --
> > 2.17.1
> >
