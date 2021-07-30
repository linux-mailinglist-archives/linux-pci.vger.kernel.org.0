Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86C3DB0A0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 03:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhG3B2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 21:28:05 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:21221
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229667AbhG3B2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 21:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBtaJdbpYT6VK2EwqaHdTrj+nqQ/dzldw9E2wbTmm1546EViyEViLROTi5oGUCrDcfu85bURbLgtrFLdlQvCFoue6ltMFSJYWBvjbtOyuyJn4wTaExz7HQGs4JfAeCqW6jFyb9rF6CvmuXKjQv0Er2lodAPi6nnP4BtwymHu+MWkbYfFaRQituWFSYpidx1YNio/pjt+QFwITJiNSCyO7O2yOf+JhvpMisvtJb+p88sk3CZcIU7+7JhkVOAwiJW8DZUhK/t9TwqVMrcrasoD7Xe932Kqc5LGMrgGmYqB1u0KwIqXF33whpZFZpfrCJNB8TCdL1zxZnccm+izDaGvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AHGVZpPCm11Sun4BmLUjjMFYt7Pf6Y/7YBgjYrusFY=;
 b=DhqIVrflV6sr8ZeP/FNynQCCWRoOBg6VWlXsTJeR3VGu6MWfGx913HJhtjSWH7brNETPNZnOEdL/IykunMiBjSqv6KYB62oKS+kcXUVQvSItUAdyqSTvZ8vbHnfukZ+ipzGJ9VV0HXAYzdgCn6/3eUCnu4kz0SK5jw20zY8X5b4dlSNYMBJOrkOHOx7IN+zsxLLUXEDiUKM2ctxOHAaQom6vLXdSSJnZbCGItecEA3Gnhh6W454dSBSeQ7oyxVO0V17tIOg87xJrTlOnCEdEUcAz7Llr8MIG6++7eCEzxYnh+8o7bhLFFb4citIQE5lftMDQ7F8tcnxPqN7qkqbtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AHGVZpPCm11Sun4BmLUjjMFYt7Pf6Y/7YBgjYrusFY=;
 b=slrCTTzViJ2ieLu6FAH8cjTN7FCfNmQ776SECxoMytJqz1A3KThxuSi/J63Pt8IUUDh27w2niJ60oF/8G/AHn6z0+MzODEq8g35JFmgKE4ttKSoiw/6IHdLD8oJX6lZ/AuLG25HiBqDwKRqJv6zJ8HeBHHvOQo9beeb2Yc9ldUk=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB4221.eurprd04.prod.outlook.com (2603:10a6:803:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 01:27:57 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 01:27:57 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH 0/6] Add IMX8M Mini PCI support
Thread-Topic: [PATCH 0/6] Add IMX8M Mini PCI support
Thread-Index: AQHXhIed1aByXd/Pa0GD1Q7Hp2a0Y6tauTPA
Date:   Fri, 30 Jul 2021 01:27:57 +0000
Message-ID: <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
 <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
In-Reply-To: <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3d0fbae-368b-4aae-f0ab-08d952f942e0
x-ms-traffictypediagnostic: VI1PR04MB4221:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4221A2EEA22D2C3908087DCA8CEC9@VI1PR04MB4221.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eU56uub9HUteywGPWQQWbu4R//Vtkh1LoEzXASmTMZ+DcAUat2SwqZgohIkzMcLGL7wkV4Y3Ub6Kwnbq59rQdvX0d9zh1DX1CMNC1jwccjLfE+WQhFQNpNke93RnrQutANaGcOhKL+czwxXzJ5sazuAzGcXPUqLNSsShnZnoQoQ4D8GGTVSjOQkikjEChCPttV3xplAGNADsUqGJC515I8IsB8Mv5HJlctCWQR8jVstpgjJ0b3UJPHyyxF8PmjcIcVJVy1YeCeA+WzNSZArn9TGqiT+rX9pxmbIYZ2BciEfH9pwlhwSjhiuVNmMRwQOSjoiarFB/SkI+4Hnn0l1eCUc80B/nqbwWT9ZpZYlWQ5M2nbMS/xHIqSjvE7/oQ5Lu7zJaO3V5e8p94Q3GmBzSfLCUjXB05zMVzo9wviQcP7r5U5R9zUZAndF3V/GYURXQGhcC2saFXX7sk1MOAeNWXDcsH2zb494o58saDcdAWBjrBA//o7GoEvw6aEp7L6ttTTyDytr+cJWQQ5DeTL2dO/XJH9I+XVeb3F1H9R70tQgQsrGkPB6KaqvkNsEGv3gNwK6hZA0u3o4wUCqJXTlNz/AqNKo4XAewn2kmxyTzFH5eF4E9kNcKXvkU78zjRVo/w0YXllAdx+6/LDOxKiuAbNqOwn/Rq97jMhNjdTAvat6UxrxVSB6lvxrZtVvC5RH0sWfD19WVYeP9o3+CqYMYoDKunKXNjRZdWnY3gzddf6hTf/m5zZSFefXLvdplj0LAh/twmRUPbWKlqe4u+Gi7XHKX3y1nzG2q8dTBhedQTfFUmlGn8xzsDiulCBpO3OZ1vvY9P+6moFlXfedrAIaiDNj/fg9XK5O8OzlYbSeYAeTe0iQTzQxr+aLvcyJwAnqv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(366004)(376002)(136003)(396003)(45080400002)(66446008)(64756008)(52536014)(26005)(8676002)(110136005)(86362001)(122000001)(38070700005)(71200400001)(38100700002)(76116006)(53546011)(5660300002)(7696005)(966005)(66946007)(478600001)(2906002)(66476007)(6506007)(921005)(8936002)(66556008)(186003)(316002)(33656002)(7416002)(9686003)(83380400001)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?nfso2gC1J9tCKr5YVa3ooFZYrP6uDbtQ2t8wWASYYdkL+XrEO/T5UCx9Hz?=
 =?iso-8859-2?Q?IYgJ04SjQGuAko1D52F7KaHfv90sOx/6Ks23WA1E1DOdSzFtCK1Qjd8VQY?=
 =?iso-8859-2?Q?Q/i3dqnfj0NvL5p5vXAkdMxzengUztYO5kD02ccm6Y73KxkYbki8J4r86V?=
 =?iso-8859-2?Q?S3RYkIckAg89jf3vxLnK7BHNKlE1OLQt2wcWv15OJe1wOnDm7VFKTuy2lp?=
 =?iso-8859-2?Q?5+PLUtbrWwf377NEqM8eqA0kKgQWbuYG/9pVxEeVTprTukGUYz8tos7BGi?=
 =?iso-8859-2?Q?yY8v2PwHvJsnhHkkXt7k6ZswO4zr2WKGnF7cZ8GoBatHjxHgEGwnLrNrtg?=
 =?iso-8859-2?Q?GgArTRhgx3C2embPdByiLeA40MHRPfzt4iLoC3eGr5gvIVRMeeO1H+RI7c?=
 =?iso-8859-2?Q?Ss847z+74jWnNkiOdXTjp+uyoHvOOBokwR9xk8RSqQbkUzok6eqJO1TBfO?=
 =?iso-8859-2?Q?UTFD9LwdYSzi2l0pkjrJ/1jKfWEkVc/1fFdnI38D9ApkPky3kQl8KHfTJ1?=
 =?iso-8859-2?Q?TOcDwK82iSTUR9SGkYHeZUWuRP9ajJ5C0uH+bmWmjU8yqAixdjkCBmt265?=
 =?iso-8859-2?Q?5VDzjRLHXKURaJIX0FFi9Pno20kSNrSXBNw/Mx0pEUnJHUo5Az9pegez/z?=
 =?iso-8859-2?Q?3MGrnPdUBUdCcn9QfBEtgR0lRYT+9c7Yn2H1zotIL2WvZyGTxTvtRlksyk?=
 =?iso-8859-2?Q?qwS5yshUvsbwccrcRBpgSgkwzgQsYBxvLLYTR4Sxr63wellvx57VMfly99?=
 =?iso-8859-2?Q?vdf0Jsv74tPZj7cIJBsUJEtp4pHhcdjthNgClwFbtppFLF9J0EL7N+ptpv?=
 =?iso-8859-2?Q?LjcayYm6ZFNKpigVKLi2V7eHpRJSIij42tvjLDk0YvYN2i7AlcMH/0vElA?=
 =?iso-8859-2?Q?P63N1CWwsrvyHDwgLWQwNUg2ByQdB6KrpteLUT+it0I4Gn8Z4wdmH3cnW2?=
 =?iso-8859-2?Q?1E0hyvD8OaDEXcb/ei3P+nRH3DKgfB4wTCOWNkwQ1XpmBftxn53OgigW3Z?=
 =?iso-8859-2?Q?CVMFvRctRhdL+WMkdqgHs17ztg1URdVCTkuNQS/LJGrQmH7VGpmepdL3sZ?=
 =?iso-8859-2?Q?JnsxSwsCwHs2aTWjmjA3gwpCFT5Ujtyap8tlCEXgGgEjpwZ31oxaMznSXZ?=
 =?iso-8859-2?Q?6Nn9GOILrIwNK3q5uA5Y41TZb7iNpzyNTMNcwUjuw7dLXUixH1PXJrOfbO?=
 =?iso-8859-2?Q?bkmyvYknhv7ZcbC5s98W4NLyeAy33OR8znDnT8hVW12l4Pdy+ILQqoVvS+?=
 =?iso-8859-2?Q?OSiP6hq7OtAeRtnfE+vSSHkkBrm7t6MC0mfroohWFMHKEvLiphLX9Ra+Zd?=
 =?iso-8859-2?Q?kf7qKAdq6S7yYbpkmGW9B8umK7yU2OESTFpPSeSWHxKHSvH8Ct4SDiAvMW?=
 =?iso-8859-2?Q?vjRaZaBjxh?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0fbae-368b-4aae-f0ab-08d952f942e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 01:27:57.0788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vn9pAu+9T2mkjx9eUCxVEnuO7boxj5TZNqbcCv+7Qypxg0g4b6QmETpwY0bH5e4KQU3+yn5mxn/B16iu+cDtPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4221
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tim:
Just as Ahmad mentioned, Lucas had issue one patch-set to support i.MX8MM P=
CIe.
Some comments in the review cycle.
- One separate PHY driver should be used for i.MX8MM PCIe driver.
- Schema file should be used I think, otherwise the .txt file in the dt-bin=
ding.

I'm preparing one patch-set, but it's relied on the yaml file exchanges and=
 power-domain changes(block control and so on).
Up to now, I only walking on the first step, trying to exchange the dt-bind=
ing files to schema yaml file.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Thursday, July 29, 2021 10:40 PM
> To: tharvey@gateworks.com; Richard Zhu <hongxing.zhu@nxp.com>; Lucas
> Stach <l.stach@pengutronix.de>; Bjorn Helgaas <bhelgaas@google.com>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Krzysztof Wilczy=F1ski <kw@linux.com>; Lore=
nzo
> Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
>=20
> Hello Tim,
>=20
> On 23.07.21 22:49, Tim Harvey wrote:
> > The IMX8M Mini PCI controller shares much in common with the existing
> > SoC's supported by the pci-imx6 driver.
> >
> > This series adds support for it. Driver changes came from the NXP
> > downstream vendor kernel [1]
> >
> > This series depends on Lucas Stach's i.MX8MM GPC improvements and
> > BLK_CTRL driver and is based on top of his v2 submission [2]
>=20
> Are you aware of Lucas' patch series and Rob's remarks there?
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flinux-pci%2F20210510141509.929120-7-l.stach%40pengutronix.
> de%2F&amp;data=3D04%7C01%7Chongxing.zhu%40nxp.com%7C21a3e2ba936
> c443581ea08d9529ebf65%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C637631664036013517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> mp;sdata=3Dblnp2JkmGAZ2w5JHZHJQoZJSuY1646KAT8cccaI5n%2Fw%3D&amp;
> reserved=3D0
>=20
> Cheers,
> Ahmad
>=20
> >
> > The final patch adds PCIe support to the Tim [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
r
> >
> ce.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2F&amp;data=3D04%7C0
> 1%7Ch
> >
> ongxing.zhu%40nxp.com%7C21a3e2ba936c443581ea08d9529ebf65%7C686e
> a1d3bc2
> >
> b4c6fa92cd99c5c301635%7C0%7C0%7C637631664036013517%7CUnknown
> %7CTWFpbGZ
> >
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3
> >
> D%7C1000&amp;sdata=3D5IiG4fnzWkcsV2JPnQJ8gAgMhZSuZypTOixD4lV%2BTf
> g%3D&am
> > p;reserved=3D0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fseries%3D51
> 9
> >
> 251&amp;data=3D04%7C01%7Chongxing.zhu%40nxp.com%7C21a3e2ba936c44
> 3581ea08
> >
> d9529ebf65%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63763
> 166403601
> >
> 3517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBT
> >
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DM6%2FzPsxRPv%2Fv7a
> ad7uqjDQY
> > 8LhHOX%2B%2FLzxnuW1UrVgE%3D&amp;reserved=3D0
> >
> > Tim Harvey (6):
> >   dt-bindings: imx6q-pcie: add compatible for IMX8MM support
> >   dt-bindings: reset: imx8mq: add pcie reset
> >   PCI: imx6: add IMX8MM support
> >   reset: imx7: add resets for PCIe
> >   arm64: dts: imx8mm: add PCIe support
> >   arm64: dts: imx8mm: add gpc iomux compatible
> >
> >  .../bindings/pci/fsl,imx6q-pcie.txt           |   4 +-
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  38 ++++++-
> >  drivers/pci/controller/dwc/pci-imx6.c         | 103
> +++++++++++++++++-
> >  drivers/reset/reset-imx7.c                    |   3 +
> >  include/dt-bindings/reset/imx8mq-reset.h      |   3 +-
> >  5 files changed, 147 insertions(+), 4 deletions(-)
> >
>=20
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu%40nxp.com%7C21
> a3e2ba936c443581ea08d9529ebf65%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637631664036013517%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=3DjynjjRJZyvooJFXwvz45OU9YB0xr5wA2y%2FkoweEtUq
> U%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
