Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10346379C2E
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEKBlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 21:41:44 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:63073
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230383AbhEKBln (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 21:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op2DaCzEQMoFrcMLomBuUihu1x7lAQf/Qv/JKAzXOWgxYQSD4QvntOiBKz6sNWP4wgsTRzkDvrbJup/cBOwlgpCypMtNc8j4At0H3kiCoPIt6WRjZr1WbzW7zCW830D+T3xt9tiBQV3iCnK6nIXD18A5MxLTQqa3z7xWr3rjig9UGOwk7UxKleWJ+ftFkOAipLXl2X44SZc8CthbngsRB72rghcdGJMrN09GZMyIY4Q+qdWs/zY1P3s89NESwo3eBBw+DCwbamqos1Z339z2vTw0KSfHgEJRhIeMPtkXM1FFPc+Un0nXrNmKEJSBm9H0p8YErAw7KaAS+YYEQxuBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzwmHyYQJKxXE+WifBudjxwOLX/ynfv7E8Sb1007aT8=;
 b=m1S1WDWCIT6Ot4487L6Qlw/X6zQ3jnuuhn1e6cD2VJfXK0mOeygNgRiKTKVZUbZAs7IhSyF776DkTCyjXDgaaOALRBQVrt6Tt7RtZgIOObBt3JMecuZw5taQ+0bbk4t5sXj/80Ve2pa1U8AWUqGOEyPSY4wm4W45+3brAOLyu5h8vS5f9b54KlAAv1coZFbeDtQb1WyMaeSgMRv0zuwLxtpIsha6N2tHcuBnDyC1VqG/UzFzosp7oa78f8IsgmsP5OajWQrG9RynFwunhDZFR6DD8Gwh+fDInvAismX80k62U3Yuy+1T1puDg5zbWkCWgUStYGZRmO64kPxz5cCNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzwmHyYQJKxXE+WifBudjxwOLX/ynfv7E8Sb1007aT8=;
 b=WGmnacCxn90NPEn9JHUdJcRYPjFBGYgOPw7yFAOAskrJSRSjHxJ6M38wOOlp1wykgySdPkRg+c67RSdakAuCkDDCyzIgn6sOw1JhjDmJ4FayMC49Jow7L99EP5S3j/lupZ9KJl/RIyL+aLb3iK4VnYmp66mECbn8F090d5F52Zk=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5502.eurprd04.prod.outlook.com (2603:10a6:803:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 01:40:33 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:40:33 +0000
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
Thread-Index: AddGBh+rBT7zQRgnQbipbiJmCWzw2Q==
Date:   Tue, 11 May 2021 01:40:33 +0000
Message-ID: <VI1PR04MB5853847BC25015AFA47073B38C539@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccf02cd4-02b3-489e-09c8-08d9141dc49d
x-ms-traffictypediagnostic: VI1PR04MB5502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5502C571F4C0BC202ADD0ACF8C539@VI1PR04MB5502.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUtKlrq/F2/WUcmkJxo32AaJbkIcwILEbUcdexxHp7OEcm/t6RXcGB/YhuzgvFE709ARCB0LKExCJ03K2D9/ftEmaKMYVQR4JBGgs0POibgYsY8O7w78LkxrQ9Oob6DRmuf5LWuILG1Il3xbR8iMFI+pNm195SfhYtvIMooL79St5ffXaRCmLk+Pr0MHI7fOkDUqvaQ1thfoCC6Pqkw4uAFMrTsmcrKBoo0SZk+AiTPPRmDGXMNgoTBFWnTqxxD5oVZO9MiMOqYRRuR98ouaPHlUTv2eGhgmUETLkV4H2yMAZkxR2z6JvSaZG+tBzVZjXJVDhqUv2XEZ8BvHx0ofVAJF3skCu77JMEMe7QCHrHzm6/rKstJK2Z+dC86plTE1eCRfmAigzKiBbu5X4fS+43RvEF5wXAvKFXqmK8I0moyKG+9iDrZuzRrYZL1ofz6Cuczi14+NOIcjmArRIqLZr+5REvrtosh0Jf1283BGa1luuZ2XuNl/kA/4OhjanoMm2op+QWaxBp1WpyODU4oYXWJ8EI690jUJFPBrAEbg4DsqtsFBkSZQ4rfFsKgUCU5l9BiTI675q2JD18hqZeZyTegjteW80we0ZbrIxEXEA9nJC3kUO27uxCP7eL+W+/AEPNHsi1KPm7tnLqluT8XcQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(122000001)(76116006)(64756008)(33656002)(9686003)(66946007)(38100700002)(8676002)(478600001)(66556008)(186003)(66446008)(66476007)(110136005)(8936002)(54906003)(4326008)(6506007)(7696005)(7416002)(26005)(316002)(71200400001)(52536014)(83380400001)(55016002)(86362001)(5660300002)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FoX9ix5D/SD2OxfL0N5M0RYBwWVlG3LttYXjWLM9XDq4WjTejjTccV1erkfV?=
 =?us-ascii?Q?/Gmb8ZiLicngDWJv4Y5mVbDnwMlIDX+GW36CeJmhcyg0Io5h2Sob+Dfk8q9u?=
 =?us-ascii?Q?Y4IykGYByQUFOrB4fMnQ5y3y1FfPVYND6ZHB5A+TwHBHvT+fzdXfW5svTYg9?=
 =?us-ascii?Q?rBWO3fMEqsMK/uFAxwR72Okji5cnCysSFeOUI94Yn9OEsILIcjUmh1CAOAGj?=
 =?us-ascii?Q?ZbiVCuedJfOf8vAH+XzrMNI3/0/UcHSKdhs5NOUgHiIdkRWLEIFqknkyrhvA?=
 =?us-ascii?Q?wj7CH+rNk6/XxuNKJ7PBJ3l8ny9wUTuMPkilFbm4Pj3f6Dz7jXrcWS/ZYV2o?=
 =?us-ascii?Q?h7LBpayDGYZFKQKzDVxckT4dOI6fX8ITWAJby+AgcB1u4q9kTPzoqcfRFLCp?=
 =?us-ascii?Q?z5HY9KpAVuHMCMFlCDiTrba7nqSisfwvV4U/DxjQSA9Wyt97RY16v1YHVU9A?=
 =?us-ascii?Q?jhc39BBWarHNhQ+euL48jm/2oWCkii+tiJPGo2rQXbwxeSC6GiBsCyzRoHUK?=
 =?us-ascii?Q?uXkQO3GZ3i1LXOFUHp6JKLwGIMDgCelDAPenWFf3QBetT2EAPQdWAQjuqIVw?=
 =?us-ascii?Q?rS/lFp3eUk4QUahGYEA/29x+3b5lihMxdO8JeqKrXFx1NDDjBN+1UgF5AhGQ?=
 =?us-ascii?Q?qwIPJCd35yxw0ujpn1NhmPxSbk74ERrigfOQWhfAFu3pKp9hGZN2F3hmE3CA?=
 =?us-ascii?Q?xvOUdn8JEsiA4Ri36p9y6VVG3CsHL6sYZPgspItXbNjvoTXGdZWw/GSUbGmQ?=
 =?us-ascii?Q?80CebkHvxHjJlnkzkZOoXXBUxkfOxDq+2LlKqYNw5ZPNDE3r7ZtTqXqtOR1K?=
 =?us-ascii?Q?8t1jD+TzIEA0i5yBAc4CMoV3cvWhovIS4UZ+uGR7gOw6f6Jpf2LlFovfUpPs?=
 =?us-ascii?Q?DJQgmYqSmMUllFthET2LVyPSBFW4aDFxt+J3MooDds7rQ496SQmQCpaNVw40?=
 =?us-ascii?Q?D7WI6PGQ9WoRgjZrSX3OQrv8nzIyeoZzsNP6xk6THvJoeIBG3uVwKfGjU8Ln?=
 =?us-ascii?Q?nGWkv4I0hLhQ+6+swbywdkoNiKuhsJSXzQCzAxjDBz5uwK1h/fcC+0bvfBoI?=
 =?us-ascii?Q?tEHVoPMHtZCn2meB9Xzu3TUAY10DveyJ9OMvb3md1X1JRSMUAiLFbhspqwd4?=
 =?us-ascii?Q?oLysGpKZJM4htF2OQxN2+gYI6/Rg4DdODhjOAQRef4S5swpjnzHfly8MVJr2?=
 =?us-ascii?Q?JB6mmkc2WdNB9LGD1m3jQhXWwjUrNPOcPjtSOWathxn0AcSFJbZT+f5a6o3V?=
 =?us-ascii?Q?xr+SDXa57MHJ/erMoQ34EzhfZBYb9rk+z0A0wRftYKV2FJ0c9zTpJ22BJY/Y?=
 =?us-ascii?Q?RnY+r/4Ff7HwMQ1VkNPA32ah?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf02cd4-02b3-489e-09c8-08d9141dc49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 01:40:33.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZyK3Tjvf2DM2QxyIPjuNwkxY4KSyoypkAMUjM27f5wLkL/wTSGOj35L/XNU9B1HbFsKDPYhH8aqGf37wx5IOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5502
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
>=20
[Richard Zhu] There are three power supplies in total required by the PHY.
- vp: PHY analog and digital supply
- vptxN: PHY transmit supply
-vph: High-voltage power supply.
Only vph is handled by SW here.

BR
Richard

> > >  Additional required properties for imx6sx-pcie:
> > >  - clock names: Must include the following additional entries:
