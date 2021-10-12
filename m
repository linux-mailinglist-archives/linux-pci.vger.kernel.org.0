Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30C8429FD3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhJLIbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 04:31:36 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:42525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234549AbhJLIbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 04:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQWXE/lb8hk+ZKcjmh2payF7hPQgf2mztF8oqvgKByJFjsx+NFPDfHQG+zLAmPxaBlpS1d44hXQqYhqQAzMDwAnmC6tsSiJnC6nGoRHUH6OEGXPGJDJkFLjy7gX/RUpdW/8JJCUf4sZulw9YqWWIrWI7vGS/NCjFpEZ7Z+889o9LucK3n2+bFREYNbH/zFsSI4zRu0j3xiTCP2k92EPfgwcWCHF9rcFfSiy59O9olkTU+1hEIY2WloEx8WJs5R9xFKlBNG9SviBsPXqUhM52+vTu1GY4gmpEjM4RUmlpSWG+iLCqUmnFx28y4hH1wG3vAVVL22tkZRHbQ/8q4Op5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epjkbmIIhkl2yxbGEvfEILltIavqxX2X2JLqKjrjZKU=;
 b=SDf6yiAXXpTizHie17eTQ3QdJkywyNwNWUWODOHiYpMVr4bOm5pUy1BZEx9VgChoxEyz1MmbMvun+ZWHnLG8CIpQeEeVCTzI3m5oA1Bki8pvJw18thLZA+55IXEdGhEtP3DDqUWDr3DiMbR63mm5j5pzen/iVluwl1N96UCdiozNQZ3xownEoiYwly/WJwROyS/wm4uEY1Nfn9OfQpnBfn7epeuu0tjIkHKFBH80uekIvY2LFGhtL2u4WriS5TPdZxePcvV60YyfImPat8ge/gmESUfxHa2QQvT7SsREIJCR66hM+m9YWkNcuv3t5IH0sntDlMMQYgPRadIp42918Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epjkbmIIhkl2yxbGEvfEILltIavqxX2X2JLqKjrjZKU=;
 b=KGpaiXopNlY9Yir804o0zbIvfoW3IwrV9f6w0MezQ1JHqe/nJqn7vZld8YKiEB8RACM2aZRBzNpdiegL3nHB0K0shqJee/A41hOJkANEPuaMxP/Ef03IRLX6kYRzvtkMBNrSS8jiiWl6WRjwzPRXCJ29BaJDRPAJYarCnX4mzQ4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 08:29:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587%3]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:29:30 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Adam Ford <aford173@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
Thread-Index: AQHXhIed1aByXd/Pa0GD1Q7Hp2a0Y6tauTPAgBunrICAV8w/AIAAAWKAgAAx+gCAAKNrgA==
Date:   Tue, 12 Oct 2021 08:29:30 +0000
Message-ID: <AS8PR04MB8676E06CA5642DC75B2E8FA78CB69@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
 <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
 <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
 <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
 <CAHCN7xLC1ob_nxRsZezgYQ9p-me7hNd+1MNFQt2wtcRqU+z9Sw@mail.gmail.com>
 <2eee557db84087acca4665603ba3d2716199f842.camel@pengutronix.de>
 <CAJ+vNU2MCV9oVru5wPqCMJUwAxHtS8ANv=K2kW4TryOGQXxybA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2MCV9oVru5wPqCMJUwAxHtS8ANv=K2kW4TryOGQXxybA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gateworks.com; dkim=none (message not signed)
 header.d=none;gateworks.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e56559ba-6ffe-4ab3-147e-08d98d5a6947
x-ms-traffictypediagnostic: AS8PR04MB9141:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB914136AFBB8C616F79B966768CB69@AS8PR04MB9141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7W3Ixn6sLN8RzDHtMLfcFjLl2funpxaCNvmKnNeNHvnsustWrTXUbii2C3KK3fv7lr5Th1SPop4yd6sW1/h5UxQq4TEw2qqMzO5c2jVgpFrUvJ9QcbOcStAfxqIuoLJzECjGr3VrMKTzK8abv+r2FZkb81GYhIkmfvvpLFsGFHKA7kBOtooimJngPxLvXJwq9YAsRfL/jzb/aoX2KwhKOckhHUR95iUbbdBJApExsehwQiI/yRy7sBLjQb4LFgTqLXXvryqZI2R6WPT0B6T6fX3SK/l0tEewL2Eeb8tJVfrG186l/VSpd4wvhCM150h33KVh0v/ygqFRle1LUUtaw94UKtWY9f8QZVvGhFqfv1fMja0UbCnsbnUr63Wf2X4DdSlCbdqVU4jK7/9l7QgGs+29rAm0FVqsVaqVzCsR1u7mEqo/sevqQj9Egtrb1RSLwocRiRjDL4RlZXHk4qkPpF54jtejwEgQrRu6qY45ppkPqzZ08pvq8xWbZA7jQQmjOBVQKn6QL+cn1pCfnGNpqNM7jMR9Z3BllzEkIpKqgLfIFtPvDua4goJtbPkdaYP+UKjrkDSCEa+QTWdAo9qi509FGNfRh36LPWAg/+aCg91TYnBSpQMIm4QLNtc1rc+Lts4JZ5j7K275GPXiEiqDAHZS5KUl0APbQwuz+vKAmELhu9HXHXXs9JUP8WjeQcZdRB0subC1F/buDP0l76WMir2iCwAVIywcX6ICiKkv0Yk3HmGT3ZSlVgbKI9gm6qNU6Nr6p1r0bhLycFFwXJ9NJhHVnXTq9S/4GVQK+VzJG0ruZak19eAeJsL3ALsarcTN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(64756008)(71200400001)(66446008)(316002)(66574015)(53546011)(26005)(54906003)(186003)(110136005)(2906002)(66476007)(6506007)(7416002)(76116006)(7696005)(38070700005)(66946007)(9686003)(4326008)(45080400002)(38100700002)(86362001)(8676002)(966005)(5660300002)(55016002)(52536014)(508600001)(122000001)(33656002)(83380400001)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?YIQZ0FeG4kCAUerTfjCPW2a+OdHs+kBn5HvS4Imb/3Hb1rKHEIkXcOyNgM?=
 =?iso-8859-2?Q?O5cV0VE/I9bJ3Qem34WyClKDHkTWuNPMXo9CvOVoREe+Iw9XKx7eqnOziD?=
 =?iso-8859-2?Q?T7grpuK/eIz3vWv+hVkBX00ibG8zA0kGUITp3oqpPyZK5Wv3lTxmhtvzVH?=
 =?iso-8859-2?Q?HDzlu5jUmJ0Q5k3IQX6tQhyBBviWMFuNHCRKfb+oa5Z0uyRyJzTidWXJZR?=
 =?iso-8859-2?Q?Zy/+GeSxMbAACWPz0V/1vzsJ+kfNsZcYtf/8gqOPEqz2FfBDUGh6qWcmtQ?=
 =?iso-8859-2?Q?Lcr+9wO8RKAfiyAjlsgTEfR5vgMyQAupkH1c+iEN8wNT96DXx8EBGdWnv9?=
 =?iso-8859-2?Q?6ZR86QniIZiDfESyxFqbqXU4fuk3wOiR8ng72nqnbeGgP4Frl7Hcv2G2Tu?=
 =?iso-8859-2?Q?2JgypdeBi4zyBXHaH7nYs1hzBaKBwFjdwSkmBWAu1vyZQhN+KrBYt9sCtN?=
 =?iso-8859-2?Q?UQUo700hS54776g8j6eWWJiqphK32pYminrVdkCNuGSlBmAsniV/AKrxI8?=
 =?iso-8859-2?Q?fjto6b4gZyy9P43T3yHTGuSuSCfJ+M9oWl6wSszSbGqNJasjhe2rjFdC1P?=
 =?iso-8859-2?Q?0w3oCkI2dEFLp+4B7zspAYhbEsFQUIumjO4AaqAbOWqgBN9p+5RC/99x0q?=
 =?iso-8859-2?Q?FxuYZLNXFXTUZXd5lFkMEqEx15MW+GbJt7tow0JfTxZC6sx69cL7MPeVZH?=
 =?iso-8859-2?Q?KLpJaIxVHQiYUfPrND/8UIBDFMNm4CY+ph5qSToMtS+RF/r0HmW+AxuAME?=
 =?iso-8859-2?Q?HnqWVbbTeDH4uahbMNh1qF2VJgQIrxrf/LVnahbbnW+yGIUAbNbUfoNTLw?=
 =?iso-8859-2?Q?S9q18BQeTjY7ObVjqShg/imdHus+E3n7nZ5CIZ0W+Nbl7YV4+H61VKv5QN?=
 =?iso-8859-2?Q?1PJi9aXLmSxREKKEv0Ursq1smYHRVwyyLEfm/VOzi1/mpwABRPm5dPGDtn?=
 =?iso-8859-2?Q?cLVmQntiS1lWEJKbnv6cePJOu9NCjiLm+CTKPVixcDFigmqVc2vQyI5ZSa?=
 =?iso-8859-2?Q?508755uovjR1vuuayCyBU+PDaYxIAJTlTeeX3nZ+faZR8mqaZQNGkfomAm?=
 =?iso-8859-2?Q?+/61UfFd8grtw1L/Y8MFzhU/TQyv7spTltj9fUJn54nZWbkXUpZRjkeazm?=
 =?iso-8859-2?Q?sAI2NA8mE1sQ2hHShz90GVPeB0qhwT+C7iPAnQi1tnQr+ysGS1faqtNxr4?=
 =?iso-8859-2?Q?7QPXoGM6fL61dS+9bjdvvPoq2TMqLFZtI4rlmkJun120F7eIh+hZvnh1pM?=
 =?iso-8859-2?Q?WAkRYjv0900oC8dy2bO6KjOwA0g36MlgTFBp7pVsEgioQPYXR//QOnAOWW?=
 =?iso-8859-2?Q?ytsA3hHsEz6CQH24L0y5UcJj/dN4g9Q/z0IEDbFaZ4cE0XOHLlupBh16cl?=
 =?iso-8859-2?Q?fLWsq3mZoj?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56559ba-6ffe-4ab3-147e-08d98d5a6947
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:29:30.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEEE9zhehlh7i+/2PPMQMJbw39lNfCtkpAqAJgSWVNfbxlW5dzHTg2mB2DIE4hnGip64aD+WtcNS1c7wB34/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Monday, October 11, 2021 11:29 PM
> To: Lucas Stach <l.stach@pengutronix.de>; Richard Zhu
> <hongxing.zhu@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>; Ahmad Fatoum
> <a.fatoum@pengutronix.de>; Bjorn Helgaas <bhelgaas@google.com>; Rob
> Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Krzysztof Wilczy=F1ski <kw@linux.com>; Lore=
nzo
> Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
>=20
> On Mon, Oct 11, 2021 at 5:30 AM Lucas Stach <l.stach@pengutronix.de>
> wrote:
> >
> > Hi Adam,
> >
> > Am Montag, dem 11.10.2021 um 07:25 -0500 schrieb Adam Ford:
> > > On Mon, Aug 16, 2021 at 10:45 AM Tim Harvey <tharvey@gateworks.com>
> wrote:
> > > >
> > > > On Thu, Jul 29, 2021 at 6:28 PM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> > > > >
> > > > > Hi Tim:
> > > > > Just as Ahmad mentioned, Lucas had issue one patch-set to support
> i.MX8MM PCIe.
> > > > > Some comments in the review cycle.
> > > > > - One separate PHY driver should be used for i.MX8MM PCIe driver.
> > > > > - Schema file should be used I think, otherwise the .txt file in =
the
> dt-binding.
> > > > >
> > > > > I'm preparing one patch-set, but it's relied on the yaml file exc=
hanges
> and power-domain changes(block control and so on).
> > > > > Up to now, I only walking on the first step, trying to exchange t=
he
> dt-binding files to schema yaml file.
> > > > >
> > > > > Best Regards
> > > > > Richard Zhu
> > > >
> > > > Richard / Ahmad,
> > > >
> > > > Thanks for your response - I did not see the series from Lucas. I
> > > > will drop this and wait for him to complete his work.
> > > >
> > >
> > > Tim,
> > >
> > > It appears that the power domain changes have been applied to
> > > Shawn's for-next branch:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > >
> t.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.
> g
> > >
> it%2Flog%2F%3Fh%3Dfor-next&amp;data=3D04%7C01%7Chongxing.zhu%40nx
> p.com
> > > %7C1e298d5c31594e5a09df08d98ccbef7a%7C686ea1d3bc2b4c6fa92cd9
> 9c5c3016
> > >
> 35%7C0%7C0%7C637695629794787625%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4w
> > >
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> mp;sd
> > >
> ata=3DPY2%2Bvr3s6K5O18lQ9SLY5YCqZHR7Fa%2F2RrbJ%2B041CBU%3D&amp;
> reserve
> > > d=3D0
> > >
> > > Is there any chance you could rebase and resend this series?
> >
> > This wasn't about the power domain series. I also tried to get i.MX8M
> > PCIe upstream, but the feedback was that we need to split out the PHY
> > functionality, Richard is currently working on this. There is no point
> > in resending this series.
> >
>=20
> Lucas,
>=20
> Thanks for the update.
>=20
> Richard - please Cc me when you submit as I have several boards to test
> IMX8MM PCI with, some with PCI bridges and some without.
[Richard Zhu] Ok, no problem. I would CC you when I issued the v3 patch-set=
 later.
Thanks.

Best Regards
Richard Zhu>=20
> Best regards,
>=20
> Tim
