Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B9379C33
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEKBoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 21:44:10 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:54497
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230422AbhEKBoJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 21:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZIbWqwWjrJFtbp6Mcl/s1garVz1A8kROmlyKTEHX5nzz5/x7/RLjXeHuIFQ4qTF8CiL+f8iOAPRJDQxtXEt4PUDdUhZKwzVUfP7kJy1mXOyb6C+KRNgOnwuN+f63KimhnqBTf4vLh1eBJF7boyWoDPFCGSSqsMWXF2qlGlZJlfMKhFAu6M/TH1GEV7bcNUm08B1bbOFP7pJNxK8xNfAjnm6gp2EX94IACmrELj2BZOSy4M0M4eMI1ZiHtMjHCdrGfIpLaicw43dQbOgNVJ7u7L971Nox0FhwJ7oaQXWeKd7fIk0U7reEN1Nc3bECfErrGr5YuML4Xc3I6dGy2Ryvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voBiJkojl7diEVf2SeU27/mVR5TTY4geXjj9ge+G41I=;
 b=oIgPzS7h5irfVt502+jKTWunovmMcvfcoy7IdCVmCt9v3jr/U5KH0fSzRHjUz8uY+0HzP3kKxsMoYJ5jweG+rt/O+YSyzQYGxamXnu/CzTx2X20BqaxIF6/SrLMx/CCOlZ6rwQvW+uHmEX1hxm1PfLecIkzfZCk9Pj6GONof7x5l8zgebi+xc47KLJiSBUj/6fnni2wS2//yT484qTcOgv/b3peVkEnsQOoeJwVkFxy67q+1Gu0ttFoZ3nSQN4YqSws0a2LxDLmSyPII49pEPGq2xlYrlvLodKJY+NxLJVZsx5Xi9m8/k0rS+tJZu9euXDs7Dl07qXA7jNPdi844hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voBiJkojl7diEVf2SeU27/mVR5TTY4geXjj9ge+G41I=;
 b=Bz/syoQnLulcnKpqyWUUIGGapN3x5Znmib6VSK9LupG3FncLLmthKwSUmVoOluC9g0vDyQ28Im+45U1VxH7Un7ntRf38r5sx5kF6LOcHnmGdZLKyQyzZzeunrUY0HNEk27ItEefCv710UIFa8Pys6IUWY9fKjtWNqUwTJXG8I4Y=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 01:43:01 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:43:01 +0000
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
Subject: RE:  Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Topic: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Index: AddGBtI0mvenQ67aQuSaGp0K+HXk/w==
Date:   Tue, 11 May 2021 01:43:00 +0000
Message-ID: <VI1PR04MB5853DE4B5F394ED486FCD08B8C539@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 707f5510-4f66-4825-4e77-08d9141e1c98
x-ms-traffictypediagnostic: VE1PR04MB7343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7343169B773810E1A4DE2D218C539@VE1PR04MB7343.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAxIGe6b2J6LyIB67dVr0PHqyUDNh+8tHi0ikFjxYrXlQCA9tpOgtt84LvK4Qx6HqHmd4UMpk54JaLyjatG0MPXUGcz9F40VlK7k6Y+qs4SHc+JrGd7jxbPMNw/ED494JiRU5iko3xLJhD2Z8NxAQNMXq1Jo+FaBOcWhGv0lu9KLiKiABHO0BSARPE6jKrWOtwNVq7y9sVviuTkgaO28GTuiCwXt9E3hpV0W5GZNUYrWsTF/d1YjrRYpKBGlazHgv4hsEwPN4Zyn6DfZxNuUiB7c3KWIJRi7Cuu9tINznxd3SxfN7WB/eLwPsOvDhIYMQbUWlQalXdxgGybvWhtq4ZN3CCWHgrMv2+mzRd7oBS3yIHkvO91N+ynPML+TIul9T7unrBfcWWkHvev/8NvyLtl5V3cqkSlFxXJukam2+c+1yQtEokEBYYxFi8rLUD6ngYWCmxmj97xKd/QwkoYyWWcJcgLe2RZOT7LubGbbPQmCiusESh12Sy90O3EBJneeOu9W/vSVFWvK504oH7FxL9qBfrKyrAm7eAdDloAPlm/guiDPf6QS4l+Cj5AwzquXPJ3qgGcybNsuIQQkjWrhcxC1F9fVRHVHo4ya5U1CmBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39830400003)(366004)(66946007)(9686003)(76116006)(26005)(316002)(7416002)(4326008)(8676002)(54906003)(33656002)(478600001)(52536014)(64756008)(55016002)(66556008)(66446008)(83380400001)(8936002)(6916009)(6506007)(2906002)(71200400001)(66476007)(122000001)(86362001)(38100700002)(5660300002)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?a2iynWHAdCcw222COk3MIhd7Ozyfu2E5p3HuR/QptGp0Y6u+Pd4y1Ohcbt3N?=
 =?us-ascii?Q?2MTrspzbKiFYFtPmTpI/IqRwV9yetff2OmVb5HwKY9txmBHtdoavE+XCRCHR?=
 =?us-ascii?Q?gawSzX3vkzxfsw+BSsaSkDDn18bghr5L5KMnTPkj749MqoOrkT+VFVFV+KLG?=
 =?us-ascii?Q?PK+Sy+jwDM0c69XwFpfKxRoL3sW0LvWZc8GkfGoE1wiQZiB8QzJTsFkRvYiW?=
 =?us-ascii?Q?+KLq4KR/Klxj8vMHmA++onSVmssS/zDQJnI1CKPjI50i15DkwWUx1EbW+/oP?=
 =?us-ascii?Q?QtG8J60RtVXbXRKvfQne8NUPXRGvcejPYTnh97uykPwC1gELxl8AfMA5OY8k?=
 =?us-ascii?Q?XNLX70GBfRiRRR5q5Lm1F9e97t4ZhFMJqxxbQxiijPCTsT7oiTky9zInoQQk?=
 =?us-ascii?Q?GaS2ybOhVqHTHsaFPiwCII3R9xb0dmfXA56hcuvdsJdBI47DxIsJ24dDbnwJ?=
 =?us-ascii?Q?0UtuMhAPQHez6yw7IaxZ184WjkiVeLQ2d9L5vCGVDdccVQhjPrmxBw5mmHsp?=
 =?us-ascii?Q?MZ89arXyu7uzREzONHADa77MwRxj58BYe8YBxlONON5YnIUSXE6WpiI1WoDi?=
 =?us-ascii?Q?gGaHdEYtmF9PysNVUtlM/dTadhHywgWGb7W6hbYZaR7L7dxsPfJzfmhCNdYO?=
 =?us-ascii?Q?g8jzQrl5GEjuFmBBGsOXiMpewH6gdk4gY0exm32XLsBe/OUQXCiREQy5qDZf?=
 =?us-ascii?Q?XNC+nF6fYE+obdnRyBQMAebhtXsQ7m/gpa1GgtDvSm5VRYPa0NTdQHxY2omA?=
 =?us-ascii?Q?aGbZWgukyYOPrdXMcEHMlbVQdM3BUwWK1e0NOze32ZCzTKYnOtWlSyXiuB+U?=
 =?us-ascii?Q?jfcDyccSGsC1WFz+306DiKn+y+bZHhVpYaM/frKSyhzmJpsWsAHT0hZ6Oc7B?=
 =?us-ascii?Q?tVT1lnqlXvKa9ppK+mNBOrHtF9Xrq3DbetfTBKVKTAEchnE7ZH/eY3WCLL9h?=
 =?us-ascii?Q?0V9IXHTpzAxWBxtMR1pIxYa4m0eWWAoq4BBs7gwJbpqIJnamD3Q94hSGQGn9?=
 =?us-ascii?Q?6hYOSK6ISnkGbb+j3YORtf0ac02wOB2t0c/AFtpOCzTf5yXRQmqopM9oEZOg?=
 =?us-ascii?Q?dKTewKf+8q/YNNeB3JPsh5r3oWpH84gk2HBd+cqrYuDgKYV41M7seLnC52wo?=
 =?us-ascii?Q?YPeHKEhwfnEkBrkDlsbYpkoGH7lkvJQZBja0BWcYt7oMFSoqHPF4TF6YiMwN?=
 =?us-ascii?Q?I6MSITU8FEmM//Zb4SyNqXrS6TiK+EzhqsDZQdaPrgXSWK/abyFJUE5NOz4b?=
 =?us-ascii?Q?Nw5dMuTGKQ7J5N1Yn1cMrPj299cI+2Dn5U0sobu0d1opPa0KsUg77E/ImWB9?=
 =?us-ascii?Q?64OG3Z+BFgB1AwjWD5Pyu0Ho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707f5510-4f66-4825-4e77-08d9141e1c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 01:43:00.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpiZAORpf8QjSTx7IIpReunqyE0tVB5a1wQaYdzNenfDcu9xNs1b5uZwO1uC32iBIeO+g5V9jAo8gLU4/DTKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn:
It seems that the email I replied on May07, is missing.
Re-send it.

Best Regards
Richard Zhu

> -----Original Message-----
<...>
> Subject:  Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
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
