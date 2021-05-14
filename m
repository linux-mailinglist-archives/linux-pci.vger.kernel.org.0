Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A40380556
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhENIiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:38:11 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:7614
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhENIiK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 04:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioolYyeuB5aBbufJGLv8HwaoSrbwpQL8ihVGk6vMcs5te0InwwbGsKjN3GLoFyFrZHV3LJj22s5+SEQKjr9JvU8i+tPXC0Jq+EfHY9GajSDgF/5RTULraQ13ATnAfC5qAHTjzRkIRsHHjduwmQuFcrvMUZoBeIgeve3wMrRWx4ivODC0dFQMHLauwq2aUoPEmzElLH/G6Wug+KAn/vibfvOITHT0EKw1YvVljnIbe800YolFIeLIVzzv3iEBbKuwaga7diXyBEjdswYku/69RPOwoi34QuvwkX5FwTjkSxINeMQjHsNbM7G7UemUdOq+Jo4AoNXCVOuFw56OyEX9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjGmez9VM7FEil7QmQKaQfvdtU3UBfxohCNDWJVkqcU=;
 b=aPvKb1GDiXwrehs03jNw5aq8A1m4Zzz/ILkTH4OdCvVztSvVavVRDNQ0+jVKXQy+ycE/6ceaiXHel2jd4RKbqao5enkb+iQz1zAb7Y3TZ/p0nHntaJJru+4Encg76R4Av0ELLA0TIJKgpqZdr5jUO0Rt+DxSaAp7op595uIoY2wY6V/EsAKSiXz3GtteoGVv3LZlDnUIEqXMDQw7vc/WZ3hGDX/OaDORnWpO8+aorMx0xPBggHN+rFo3xlzAbxX/60RShoiWA3hElYr3AETF8o1juOCKrGviWNNphEM3h4NM0pHRob7LJtsUJ0o7EhcGAi+LHxbe/sV7CV238eJVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjGmez9VM7FEil7QmQKaQfvdtU3UBfxohCNDWJVkqcU=;
 b=o8Cw1yAb2557KDlmbW8VHAh8BC0qE9TkI6ayRK2GvIKUXobHnFe0sAD4AgE6PL/9CZrOcGLxbBHyzk619+7lMZd1btUCSSBKjaULaRdkfTmzM19MpyXitktLzI3TAWTGKMkcb2hb9t0HNfybWgo5T50ILO/30FNXAtDnTy+9osc=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 08:36:55 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 08:36:55 +0000
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
Subject: RE: [EXT] Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie
 vph voltage is 3v3
Thread-Topic: [EXT] Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie
 vph voltage is 3v3
Thread-Index: AQHXJT3T5L+HoqbF1EaFkT83cq0lRarXLaeAgAvAJsA=
Date:   Fri, 14 May 2021 08:36:55 +0000
Message-ID: <VI1PR04MB5853B8A3C7071B8A611EF3EE8C509@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1617091701-6444-3-git-send-email-hongxing.zhu@nxp.com>
 <20210506210915.GA1435377@bjorn-Precision-5520>
In-Reply-To: <20210506210915.GA1435377@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d1959f0-ee63-41d1-86cb-08d916b36e42
x-ms-traffictypediagnostic: VI1PR04MB4222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4222E72B90034C4834B6C3AC8C509@VI1PR04MB4222.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpP1SZS3+yNJ5sXFNCmPykgdnXwlv+nIaeDGYyCQxrAd4v3X/qm2nPWOWlLwLGIU9Mut9a6NUdtzQxj3trSfyVoAPjBd1x9WZypnYhlxBLLb4bN+FySmsmAHrG0JppQHg7Gwbgfl5CS85VFhoRvWamPc8eprbEzzDsyAbYY+wy7Z0kqH60OnqhSlAvLRPXKWIWjfKF3XjvTGO53mJ6wV8MKWvba2yvQBi4m2iQKSNkgtg2pOwOs4IwTaxDlzpfFjqq9ChV43JXXMVUO0J5vAFk10OB3NUkXjuZLPZVzyzQaYoU3q2ZaO3w+yrR0gjTIvgcsPZkId4Dcbqo0f+NgJWRHaj4iieaA5nbLl2ljhiajaycKv+yIc1HIlINBVOqRlmiWJZbEcZFXjEscvMLCk+rQ5MBOg5DxwIwbgcgOkfpEbhhCOfakTN61eKHt8ZNB9NnFKgjp8/8ozEl9lC7KMWvwyYKz+8okwcHaRyzH/CVL/sPSvSkUa4niSABHf3bMhE6hafkXjccIjWtxRErKSM7Y2KobMbme4bBgcgbhazcZIDxekrCeJx9WhZfc/ipJYVU4VqOaI2SRYncxrmPSZWjiSZ8N5q5bNyj8Z4NogcYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(86362001)(6506007)(2906002)(53546011)(186003)(71200400001)(6916009)(83380400001)(76116006)(8936002)(4326008)(7696005)(54906003)(5660300002)(66446008)(66556008)(316002)(38100700002)(122000001)(478600001)(9686003)(55016002)(33656002)(66946007)(64756008)(66476007)(8676002)(26005)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A/M/pf8HBaX+WFK4FhIfq199xW32vscI6V45wCx5kx4dMBOz3G4PQKrTUqtP?=
 =?us-ascii?Q?5pby0CH/regOE2zmjCqsZw6yIGGZFSmG4LiWBgTsYh7X14zVjXYXN+hSnSvm?=
 =?us-ascii?Q?lcI3hrN1sh8oJYwsC6a+YuKHDCsFGyU9Z5ovdZfsjZVGixujOQFOyLUN9Hzf?=
 =?us-ascii?Q?BxxPSBogDUDlieDyDiEdp7+QzBneXreNV7dFYMI6SY4KIOTM+LVMAtP40iRG?=
 =?us-ascii?Q?EBWvfOKp9A3RRPdD4Oj6RZskDOF2aiRM/WlMyUOjr8JzJkFDVRH6EaXRXqkK?=
 =?us-ascii?Q?8aQEK4V5s4PfMOJOxMP6GBOCMPOiIebndIza8MQGJw9ofqYK278FfV78fcr+?=
 =?us-ascii?Q?cNfwh9e14sDlzHD3kOfkRomzi9kAoO0F81Tp5Wa+NSiFfbJgkEr0zqZSLONB?=
 =?us-ascii?Q?tYB9VexIam37qszsjzK8YlYZEJIpTLwfFn93JTyZvCU4vByJQ///tCFbOXEx?=
 =?us-ascii?Q?WtjspLTMWwLjeE2XXwSakBf+vky0Ioo7LBbBmzZazOwOk+KVUzweLfzI9H6Z?=
 =?us-ascii?Q?V19bRce/pRMZgrTUCq2my60zEqRG6e/C8DmOBi9fLQlfk5LurEiI7t64+hUO?=
 =?us-ascii?Q?woBcvIDIqvCt+kRLAZGckRigZq+wvdaXsaNqNtYdIyMXjk29sx2xYEwCXLDp?=
 =?us-ascii?Q?vc4an95qmOtd7XLMs7PiNbALvKZ/KefLJUSeMcO34JPHx2FySbHdvKnAJQNk?=
 =?us-ascii?Q?frOh2+xOp9kihi7sXD77DEeJW7Qigv0Y/Hup3hAEJbDgRJGQaWJpvMPIbZzm?=
 =?us-ascii?Q?d1fgcK89QXssnLM74KUC6zSepDtyyz1So3PDjV5wcM07AcbwpmtMlJS8Ca8v?=
 =?us-ascii?Q?oP4aQrfofLODoIqsKBlX2/Y/9OZincl3u+YNEcsOmcX4fbBjQluyt4RagtfD?=
 =?us-ascii?Q?NmwAyun957u+BTISf27CxVxUZRTXRstmjFHnQkgzxvKPC9ZDbFs0gjxoU9LK?=
 =?us-ascii?Q?3mYu5Qy1JnQ6oLbIvFwH2CWnm0O+dz/4KGsi2hVfGA34p2hopm3/6Qo/SVa1?=
 =?us-ascii?Q?YXtqkHIppWuI1zTzHeRc/ZLBkUmxWTOl7fM/R9NqHT7GCL1xcpPs5mP7h3tB?=
 =?us-ascii?Q?XkmWu8VEMpJ8dO34ZVT0rwe4+0qmWRwTh9q72AHg44fhx6dojVpuNoJLug2G?=
 =?us-ascii?Q?MGpf1BbkRhxn+iSVD0mIBz9vgsU3S8R406po9tKbt6J7/Bi/it+5XvnOCZbC?=
 =?us-ascii?Q?2FJTttQSGZ0InysbRxGZ21UYqSKjgQS0ZM62amry4D63KtEKyJq8ucH48Xer?=
 =?us-ascii?Q?rxP87MnGNDWObh+1w4TyQnkjAhJQlB6rwxhnVcS7sgfxtowptIe4CVptpAww?=
 =?us-ascii?Q?l5J+QZbc4NZFVpzeedAoDKxB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1959f0-ee63-41d1-86cb-08d916b36e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 08:36:55.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jcdv7Rdi7JFClD71Q1hUga4unaO2xTBKMvIHt8pnT+bTRCMbCaJnC+hg2gs1BLo5aPMg2w84wVHbUKJcc0jmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4222
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn:
It seems that the email I replied on May07, is missing.
Re-send it.

Best Regards
Richard Zhu
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, May 7, 2021 5:09 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; andrew.smirnov@gmail.com;
> shawnguo@kernel.org; kw@linux.com; bhelgaas@google.com;
> stefan@agner.ch; lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: [EXT] Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie =
vph
> voltage is 3v3
>=20
> Caution: EXT Email
>=20
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
