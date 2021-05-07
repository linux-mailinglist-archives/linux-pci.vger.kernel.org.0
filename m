Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B656375FE4
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 07:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhEGF5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 01:57:39 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:34437
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234286AbhEGF5j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 01:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0j7PBYnIDy0PDXhqkvb2MZSqsUwpR7QAN3MvZHjRCnXORxvx053yQLMlYxDITAKdagDFgLrkCRXv2lAEqI+hNgtxin2xwlTMy5k3HkKPXinR97cIPpKc0575rc1QFARPVuJ5xxz/igidoGFgWamzqJ0FWa5wGNyxU4Tf8UK0t0wzwfv4WrxuCLjlaD87vFzh7OK/LIUGHxIAB6G4KT6YuII6SfNdjAi48zJRd5WA/h7t+W7Zj4mTqDnV0NvBMwZjZWbCkt4ZuraNQ1O7FBE/cGacvnWgJoFvln8+9ydKrO40eMAQsDXtAGFiAV6zXdcHRlOK2LwOY3nP6TKFAjITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kykRkJ/uJCepv7YF+6QktzYcQwZyyt+zx1ITQ3lJQBU=;
 b=G75234C6Ti5mg0iggx3kr/vU1qNpC1khfnziIg/UBtNfY8UU6I6314ykqSTQia6pcufjEjBFBIroVUibmdwwcuGsR+hnLGn7sUPG5kEwgXZfRV2mNDFwElORdOnT9A4kds5a8sJ1dMDy/1S/EfuBmRrVZPc6WRYwsmdAr25vUsa1Z/mujRHjBv1y+QwfJDrqJx4iiK9KTgbeoynjsYNSn/DHiSn//QVXI667dGz5bGQtb3u94dT35EEYGG+AmpBt2xXlGx7TxYlqWwCb/qY50w0qwfF60VBm7vEjj99pXd5QaKDpiyITPcA7Errh3O+4cGN8nYonzsqatc7rrtl76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kykRkJ/uJCepv7YF+6QktzYcQwZyyt+zx1ITQ3lJQBU=;
 b=mluKrBUCjUxao9zedeEAtlChKJnyq3DpsUGQDcmiJ6dZ8FlQtq6UMLe+9q+qIdDhw9bGyTpcvLuks6leMo3oZBakCr6I57hhF1iFpSSt1KwzEYuu411EEUXtHQ/BME0XdW0bbEu94vFGTt7EqJ2kAv+Xpm8YJ2Pao+URut6kMcE=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5502.eurprd04.prod.outlook.com (2603:10a6:803:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 05:56:37 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 05:56:37 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>
Subject: RE: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Topic: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Index: AddDBHDZpAHyzF/RSbu9bRln4UIDkA==
Date:   Fri, 7 May 2021 05:56:37 +0000
Message-ID: <VI1PR04MB585323D08A483C47E7DDE93E8C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f51e8541-23d6-4ef8-4fa6-08d9111ce09b
x-ms-traffictypediagnostic: VI1PR04MB5502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB55024C955892FE3E9739474C8C579@VI1PR04MB5502.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQsujdE0FXJL5j4lqzhB7W3boV3B3oKBIWHX7vyj6QuD+TDWbLAkyzUTUOkKc7Am6MTy/36fuWgQA04LvHZdSYOd+bJAhGFqBo7O97fDEupLtCGCRo1mimDB7/w3p0BPJAeCSr2YcBg9SStGAyEijfWZOcef6PZQOOo+gnXiDX/GKYYymRhYopzmomY2khdzP/h+oVVpaCAW/rLgsX2a7wUYu8GlhFI+R2NqQkRORy4biiBoWo9zN/0pjhO7SvQy9lUI7mih4laj9nKWpvXILwplJOK1Mk7A+Ad6CSwm+tFBDF5R1NS45ygrl/3HvpAOWXhwHjV43S+W2n7+iuPwhKrTjt+Gi7j6oZGzQJ2GDYC/rJ73fnulldLAxOSM3n6eftLq6Zilm7Us3JR/oa8bHqIrROe4gy6Z0T1qdtIYqQV5spao8b6O7FkU1r+l25dIEmIdYxMlN2hrvboDmYhiW8aI5qjulNNEK2akOgsX5U1LUsG2eN+IJk0G+Ks/tqzooD2gJ2Eon6egHw7+xQmzqxzuPjiXS7lZB38O7a6moPrWxOGUL0PgK51AdQ+UAnHrIqvYPD2vbtT3CkMFjRAnxzSkpjVYB8scxNgQgNKqhS5yfajcYqELOhiwRiCyPgLfOYEmtbbNNEyvz5OYs2Iglg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(86362001)(54906003)(8676002)(2906002)(316002)(110136005)(186003)(4326008)(5660300002)(26005)(66476007)(478600001)(66946007)(7416002)(8936002)(122000001)(76116006)(66446008)(33656002)(52536014)(55016002)(6506007)(64756008)(83380400001)(9686003)(38100700002)(66556008)(71200400001)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?krHBSfon4fZBc90CdA64I4dDZFw39O/PK2fvJz/Oj/31IHqz7V4Stqs1/TUe?=
 =?us-ascii?Q?oloULXRq7zGANRczFvQhBFG/p4NwWU7452880BPuzWm5bRZddhEmbw+nOz3S?=
 =?us-ascii?Q?vjEhRc7FUbYk8eLs+psM0Ph6b/otziCu2zyVwtGy1GGZGU8NKj5n1UpDMBSN?=
 =?us-ascii?Q?JLztGtnZqVghtbz+B9L3cqavWGFnDL5k7fKliCT2fIo+CgEQPL4ltmRVAAEZ?=
 =?us-ascii?Q?7AdPe8mhaWiwmU1ujB/STWTDu4XWEQobnRM037kwG48IvrQR+K42Rj0JQ87Z?=
 =?us-ascii?Q?knJeuvaRfUC6UNJC5F9NWXBSXwcHrIUDtWljZev6M+WccRbxobb/xB9F8cHu?=
 =?us-ascii?Q?WH7xToOcXGcp4ENEPFOauiBfPiON+7UHroGgn81TFiGloUdXQGmU+ZkEXig3?=
 =?us-ascii?Q?SCjp1+0a0Rnr0k0Aq6rmmFg6jFK+VJ+JXaHBlgm2vyGkjrRI2ZKfnyccCV4x?=
 =?us-ascii?Q?zrgWgR7JNkdnScjHuerSsk362+1MrgBhCTWOU+EtSr1WlMWC87Wcqftu7aal?=
 =?us-ascii?Q?fOHJmS7RycuZGjxqXHjZREAB7hn3PF62wuHKJTr6pPa41K5vLD4lkuO7U6Zl?=
 =?us-ascii?Q?iWPPj8es0kYjeysWbDBA6R+8smxegeYGoD8zx+6vtIRHw2+XzB6r43F3FmS1?=
 =?us-ascii?Q?k2/QUskZZlP9vliZvjV3BEe0f2JHsTp3rr3hhMv0xSJfE4bdPJ5cOTmdUL6Y?=
 =?us-ascii?Q?02OBu4X4wTuwG1TkjmqbpIpF7uN+BKhyQGTk7d5xMdn8XmrtMRCxpJ5bBXfI?=
 =?us-ascii?Q?YCU7yoSQDvt4E7MmHauFObeIaVlWk5rP4B4UK1QSjiOkg4YImV/RjiyzpT6V?=
 =?us-ascii?Q?iWHX/Wej6d/qRHkfUeQvvqmiQ8Hezhr8OpE8JXukQFmKTklnXIFngNppAnSJ?=
 =?us-ascii?Q?8+IsSirlqELS0WGphQGF0qYQXlZz/I3IF/LXHbradKhnCWxoYNlpf+SJUGJI?=
 =?us-ascii?Q?9zBZWeBIoYl8qSluZc//BnBnhyulPH1QIpo91Z4lhpZQCmPe4L+OJoNiiNAE?=
 =?us-ascii?Q?zULu8afruPbMi3veSo1UFmbVkVTjxHJPP5RhWyKoPc/ojMwnskliE433Ivbz?=
 =?us-ascii?Q?HAgQwV+VoP+57JD7O8qW+KH0Y6yKZCfXkzWnrCNYMzCblBQNqcGmTSTyUVrI?=
 =?us-ascii?Q?3/R9WUfOGGA1JVlO3m4JAU+3LEcOU9CE+g4tfhIqgVcFxzTtfT6kF1Z+6AOS?=
 =?us-ascii?Q?6CM+5aoAqhuANhc2KkoqGUORwp4puNT2uFrl7Djm/8IkJ0HhgKrUkgDrI5jw?=
 =?us-ascii?Q?hCvzAD26u/XqApAj/KRqfolECXzuRiBcYMwNC3bFh2cEx6rVfN+yV6EczOsv?=
 =?us-ascii?Q?EdQbisnrf0Prv5fIggVOKcdj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51e8541-23d6-4ef8-4fa6-08d9111ce09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 05:56:37.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjXpKACsbG0NpiD1GRcbkPK+FVo7zIOOM3ZSuAq7Ba7+2z2FmX1PY9dDT2HouuZwORFAdFbTziwa29yh0gdLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5502
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Subject: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one
> regulator used to power up pcie phy
> On Thu, May 06, 2021 at 06:08:24PM +0200, Lucas Stach wrote:
> > Hi Lorenzo,
> >
> > have those two patches fallen through some crack? AFAICS they are gone
> > from patchwork, but I also can't find them in any branch in the usual
> > git repos.
>=20
> They were marked "accepted" in patchwork but must have fallen through the
> cracks.  I reset them to "new" and assigned to Lorenzo.
[Richard Zhu] Thanks for your help.

>=20
> Neither one follows the subject line capitalization conventions.
>=20
> The subject line of this patch (1/2) doesn't really make sense.  I
> *think* this adds a property ("vph-supply") to indicate which regulator s=
upplys
> power to the PHY.
>=20
> > Am Dienstag, dem 30.03.2021 um 16:08 +0800 schrieb Richard Zhu:
> > > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to
> > > data sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic
> > > design, the VREG_BYPASS bits of GPR registers should be cleared from
> > > default value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator
> > > would be turned on.
>=20
> This commit log doesn't describe the patch, either.  Maybe something like
> this:
>=20
>   dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
>=20
>   The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
>   Add a "vph-supply" property to indicate which regulator supplies
>   power for the PHY.
>=20
[Richard Zhu] Okay, will be changed as this way.

> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > index de4b2baf91e8..d8971ab99274 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > @@ -38,6 +38,9 @@ Optional properties:
> > >    The regulator will be enabled when initializing the PCIe host and
> > >    disabled either as part of the init process or when shutting down =
the
> > >    host.
> > > +- vph-supply: Should specify the regulator in charge of VPH one of
> > > +the three
> > > +  PCIe PHY powers. This regulator can be supplied by both 1.8v and
> > > +3.3v voltage
> > > +  supplies.
>=20
> Just going by examples for other drivers, I think this should say somethi=
ng like
> this:
>=20
>   - vph-supply: Regulator for i.MX8MQ PCIe PHY.  May supply either
>     1.8V or 3.3V.
>=20
> You mentioned "one of the three PCIe PHY powers"; I don't know what that
> means, so I don't know whether it's important to include.
>=20
> I also don't know what "vph" means; if the "ph" is part of "phy", it'd be=
 nicer
> to include the "y", so it would be "vphy-supply".
[Richard Zhu] There are three power supplies in total required by the PHY.
- vp: PHY analog and digital supply
- vptxN: PHY transmit supply
-vph: High-voltage power supply.
Only vph is handled by SW here.

BR
Richard
>=20
> > >  Additional required properties for imx6sx-pcie:
> > >  - clock names: Must include the following additional entries:
