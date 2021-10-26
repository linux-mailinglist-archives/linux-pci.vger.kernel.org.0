Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2943AA0C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 03:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhJZCAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 22:00:14 -0400
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:50241
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230160AbhJZCAO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 22:00:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guAv7+KtgKYeefRYKJOZVBxXQCNFgPA12XdqQKeHdugwIhMVSQD6/n7aXUXTvwfHUmerCZFmK+63s/WPbBCqQoc/kf7ex85BSA7IuFNKw6zzhMYM8Bp+c0Muz7P5KDhp2AOUYYQZDA2wWDa8qpdgrnvM3VbAOHRDJY49xbN5TuESOsaf/gVyJEneTt0yShv9R97Tk4Z1jyBTB8md8hq8m45BXUNAAodYUMTOXqBPrVXxNMKl85dQ1DBHwaIBE1rX3y7eaPxHrdEiIAmnBaYIiwgpU780jo6cpQjMMv9L4kmgNBoxDxqk614ehNGcKywCP+rSxYYqCukPT6c4ZIrOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Km9k4FJLJ7pcXAeezT31k+zoN0W5HEXpTqg+9AP7eM=;
 b=IzsyzUhdEDeCdsFu+GuY2TNsSzTj9F7p0XHIN2S+UXdWIcAhM/Ojcvl1poy+UGOaoVuLOKDMOr2uCWpU2QHq3StmhON8mZt1FXUKv+N2ftbBRfhb2NWc0xadNi7lUge3dMeXg1EvovY4Zmv/08vccLj07dMjZY4i2b/V0cQgYMLqxTw+MZOjvBJWlGl/MFL4PTkBRGrkhk4oHcLW0ecIIsETzqqDyOQMSc3ovbq7AnyVy+90gO0qDZh/53EneWvyS7g+255dg9okTfepTXmeYJZ8lhhY4HsYpAQOWa04VgpnUKG1qYAvV8dMOll4QM6sRYYE4bZBi7GHl/X6nQh+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Km9k4FJLJ7pcXAeezT31k+zoN0W5HEXpTqg+9AP7eM=;
 b=oP4m2MXXw1cRHip0/SJvadiAY2hrlgNDqhU2Xc21WRnhF7FcFeVfRFUyz48NoebtgJKW+MbRxMM/toVcw0/Z/RJxGbmUagWU1eUAc7l1RtOGRXjgZtCNAIKuiNiUNI10BgtoPY2XZzrntRBzEV7iTe/lNAFGagqrhulGgOhGmfU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 01:57:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 01:57:48 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAD26KA=
Date:   Tue, 26 Oct 2021 01:57:48 +0000
Message-ID: <AS8PR04MB8676B0F9480337E211268DBF8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
In-Reply-To: <20211025111312.GA31419@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c120c06f-603e-41f1-26be-08d998240337
x-ms-traffictypediagnostic: AS8PR04MB8500:
x-microsoft-antispam-prvs: <AS8PR04MB850029FAB5AAE8105AE898A18C849@AS8PR04MB8500.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QV+iZPt6BVCYhuRT2NcV+maks3SKlRybhMKNs2TKXHDMYzRzKRHpbCdFJ3O7N/8ntyQAN4D42rlCMvST9yZuysyKCvG58wQGK5wA2aQMiu0acA8P29Ol7CvCMngC8oKehKgY3PZFKe2Oxtngcsov0eYg7x83X09yQh6+A5xvKJqMrhWIsYCT+V2CHuCCXYmJsOLZcvtIN66Ew2EB7wcZ3F4lD1U2vLFkZmF/YN5lRqhUhC4YAiOoU3v5BFGL/vEusLhwA7BMZbiWBL3TT1GDsWBZiJmE5nbrIP+uXzyPJTKwAIurRzIZUdNOSZoRSK9SRnWEPKI7Y/i7P5jSCnUkcoyIEI6evwmtFyLCqmnAOoqSafNggkQmjZjgGyTql7RqnW06B8tSEsD1A4R9jgLskXRVXJOVXjpz8b7bW21bIzQY12M76YH+2d5TpYWUZ0nugmP4ce5uzEaxrbME3QY60GTeRX8AufolEjTL5NyFOL6rGZpOYFbaoLShXei0TfUqDHOkHGpafEUcyKlBXhi6P8dhtbusFtMas9BCsBRwxCHmd6ylSeqrP2FhJ5iFVE1zEZrgSlfKU9mLVNHmZMkSkq42G0yPATfujulkRTMQGEreN3mmo1SMzKRjIdeGhIVC3dXCNkgmrd3eLlemCKPZ8lTFwBwcQzzSRqUVVCZqmrmJRL8X5F9zJ48v9nPsTb4p50oDRLpT+YjlE3ypiXIAJbnYeObgXpNP4Uy1lWgOXJiyb1MbR+gTQMLpfBUQ17uXzORaVOzCeOGe5LSHDe0wQ5wZCSVE+VxU6vp5TQbrKB/UyDNZiMDXJk7n8VBuOW/55ms6uz/E46jdZgxpZEqe5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(508600001)(6916009)(966005)(4326008)(5660300002)(6506007)(83380400001)(53546011)(316002)(55016002)(54906003)(9686003)(45080400002)(8676002)(8936002)(66946007)(66446008)(66476007)(66556008)(7416002)(64756008)(122000001)(52536014)(186003)(71200400001)(33656002)(86362001)(7696005)(38100700002)(2906002)(76116006)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?be5N/LuSFBz6bTKnThbf4OP7ferYV0AKOrzDoEIHiiT1pNS2u+3GFX7pjIS5?=
 =?us-ascii?Q?XetsLVFExmA1QlIbLUPQoBAYuDvkAQY1lED7vQr0RqIpJcU+PmQYDQ1LOD7E?=
 =?us-ascii?Q?GePJ13fS7wgallrKh5LiS4evaBR0Vxjbrf+XrZlt15b+/HIScrSMbahM25q/?=
 =?us-ascii?Q?fZMkrsXEaaNGLOsfHfJrbKjDw0UqxGAwOfTUYsh9vVjhH29TXOiCOPL342Eh?=
 =?us-ascii?Q?4l2uOOpZtwcljNJfhZdOdeyq9HFKB4hbadQdx6WA2f/ABYr+qpK+RKQYDOuI?=
 =?us-ascii?Q?0B/XGu312iA/wU/iyirCnEy5fn7oJMQvcsJ74xeiUv2lwJfedMKWr2iidnSq?=
 =?us-ascii?Q?j1fpgaGvcMqlwnsLI+FfbBGceblhTbFpB8cKdDOsP9OL4F8+v2JJm8tV5ZJl?=
 =?us-ascii?Q?kxDyX4dr+y6pBQ1Cj4gZklhjvL/kOqy74CTp4b3kcS73lBVqhbjb5Zlwad/4?=
 =?us-ascii?Q?MJfJmkk67G5/kZNAZ26/Bl56w5q/7cONNFnHc3ufXHGDljZtdYLoHeTZXUCi?=
 =?us-ascii?Q?fpOsCnP2WDqHQsKPk6IfXrmXvhbKkRoL5xoxgRHG+Z0UczXe3I1jbK23uASG?=
 =?us-ascii?Q?7ZH+rumd//0vTcO8n6RpdIJlLS+suz5DgJ5UeEz04snyeXKH0xRn/uMvPbpA?=
 =?us-ascii?Q?DoIgVZQ50aLEaeoP7fdTf55X9t9+Ekwq+z63tjJDagdAO6Vs4mvb/syCfVSH?=
 =?us-ascii?Q?U1i0TdXwdd0BUsvzHwDe0PE1+Dtd2691FI64E5xoIkkyggzwVtLJXJwwxjgr?=
 =?us-ascii?Q?zh+rF1uGBcHzUy9F1/4vhZ5Cufn6hv6ArBCG3NEyYE+GAfk0o6vIhPiAgCmj?=
 =?us-ascii?Q?xFr+EaeO/P5wCVF2SSU3R6x+yzh3c7AiNKbJXvWL+6mlexBpGHwlmgNyVQwk?=
 =?us-ascii?Q?OLsJ1MfZ4/IZ/xNNknDqRjWwSmp1Ysz38WyKTjnZ0HXw5pixTO4pfWzQCqv9?=
 =?us-ascii?Q?j5Afq5l2V7OVhYet1mtAgN+bEjmrWzbLcDVDLuSrsJZgpkXrySI6AKb/F3Dh?=
 =?us-ascii?Q?YVAqz0zqeMAmX1wU5CcRGFBoRuhju0JwJNKb7I0d0v7W1Hz2w+Np5NuvP9gt?=
 =?us-ascii?Q?YHbi6PYy5mb0UnuuC3J6K2EqjaMWvlj/MHmTMHTY44pj1VaFpY5T7D4z2Snf?=
 =?us-ascii?Q?41zNgIO1DNiumhKe/TLJ2Sh7fd9Q7DV1VYOI49lywGLkCBPAoXCQ9L0OtpkG?=
 =?us-ascii?Q?sUrHDaELMvDV0YXpXunlt5MF4s8dMhihuw8k16ZzNRpXRsQjkng+fnN89ENn?=
 =?us-ascii?Q?l01nYfkFHhvchCcwraIoCYafHEer0N/TDTtpV1pv848wLma2BqQMfvmeQkYH?=
 =?us-ascii?Q?YSqrcCRbKNa2Z0r+0p9nUQQhpYxSPFz5NHJeAbSqFoWRtUcymlSCu/uMmu0f?=
 =?us-ascii?Q?hi0w+3/s4kD/TVBl825edS0hvyB8QzH7DyE9JysQWXIinIEx1U0XzP8kFuC7?=
 =?us-ascii?Q?a1h1cdMI0zwfNpn84r+tcjYOLCnKnaF1MxRGdVnxb8huvWuSoQjWZGhJSFMd?=
 =?us-ascii?Q?pPkje3ZN1aveqTMySOPYNA0YkgZkUSgl0n+z5ojJnGvyuOeGaxYsB3PDIDEG?=
 =?us-ascii?Q?tDtdqVf0/zCFZvqClVvCvkY/qEnkMUgr6hEDTyrYpk8bzgeJnXszGbrBcwNI?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c120c06f-603e-41f1-26be-08d998240337
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 01:57:48.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAj7+b4DHoMlLcdWb8OotCAluyFEresKsxEYgLbbz1t9M/DwEKgINbCt8gbM2Zkm6sVSYaVzY14UmgDfM9lQPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8500
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> Sent: Monday, October 25, 2021 7:13 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Mark Brown <broonie@kernel.org>
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link n=
ever
> came up
>=20
> Hello Richard,
> please see this comment from Mark,
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Fall%2FYXaGve1ZJq0DGZ9l%40sirena.org.uk%2F&amp;data=3D04%7
> C01%7Chongxing.zhu%40nxp.com%7C27ddf15a4ef34496eff708d997a87097
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637707571965246
> 405%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DnLZcGoLwXWEr
> HR14ZLg8prtPuotNWHBrQb8J99HiNT0%3D&amp;reserved=3D0.
>=20
> Francesco
[Richard Zhu] Got that, thanks for your reminder.

Best Regards
Richard Zhu
>=20
>=20
> On Fri, Oct 22, 2021 at 03:12:26PM +0800, Richard Zhu wrote:
> > When PCIe PHY link never came up and vpcie regulator is present, there
> > would be following dump when try to put the regulator.
> > Disable this regulator to fix this dump when link never came up.
> >
> >   imx6q-pcie 33800000.pcie: Phy link never came up
> >   imx6q-pcie: probe of 33800000.pcie failed with error -110
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256
> _regulator_put.part.0+0x14c/0x158
> >   Modules linked in:
> >   CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted
> 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
> >   Hardware name: FSL i.MX8MM EVK board (DT)
> >   Workqueue: events_unbound async_run_entry_fn
> >   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> >   pc : _regulator_put.part.0+0x14c/0x158
> >   lr : regulator_put+0x34/0x48
> >   sp : ffff8000122ebb30
> >   x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
> >   x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
> >   x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
> >   x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
> >   x17: 000000040044ffff x16: 00400032b5503510 x15:
> 0000000000000108
> >   x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
> >   x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
> >   x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
> >   x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
> >   x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
> >   Call trace:
> >    _regulator_put.part.0+0x14c/0x158
> >    regulator_put+0x34/0x48
> >    devm_regulator_release+0x10/0x18
> >    release_nodes+0x38/0x60
> >    devres_release_all+0x88/0xd0
> >    really_probe+0xd0/0x2e8
> >    __driver_probe_device+0x74/0xd8
> >    driver_probe_device+0x7c/0x108
> >    __device_attach_driver+0x8c/0xd0
> >    bus_for_each_drv+0x74/0xc0
> >    __device_attach_async_helper+0xb4/0xd8
> >    async_run_entry_fn+0x30/0x100
> >    process_one_work+0x19c/0x320
> >    worker_thread+0x48/0x418
> >    kthread+0x14c/0x158
> >    ret_from_fork+0x10/0x18
> >   ---[ end trace 3664ca4a50ce849b ]---
> >
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20201105211159.1814485-11-robh%40kernel.org&am
> p;data
> >
> =3D04%7C01%7Chongxing.zhu%40nxp.com%7C27ddf15a4ef34496eff708d997a
> 87097%7
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63770757196524640
> 5%7CUnkno
> >
> wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiL
> >
> CJXVCI6Mn0%3D%7C1000&amp;sdata=3DmJbSEVYuoGCbCOqqXdcUG00JXu74l
> 5%2BYxpzCX
> > yK96pE%3D&amp;reserved=3D0
> > Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 3372775834a2..39a485bfc676 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1180,8 +1180,12 @@ static int imx6_pcie_probe(struct
> platform_device *pdev)
> >  		return ret;
> >
> >  	ret =3D dw_pcie_host_init(&pci->pp);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		if (imx6_pcie->vpcie
> > +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> > +			regulator_disable(imx6_pcie->vpcie);
> >  		return ret;
> > +	}
> >
> >  	if (pci_msi_enabled()) {
> >  		u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flist=
s
> > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D04%
> 7C0
> >
> 1%7Chongxing.zhu%40nxp.com%7C27ddf15a4ef34496eff708d997a87097%7
> C686ea1
> >
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637707571965246405%7CUn
> known%7CTW
> >
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6
> >
> Mn0%3D%7C1000&amp;sdata=3DSHLkdzTt2F1Nht9eoefHlEH9Klsnw3%2F7KOP
> uGGeI%2Ba
> > w%3D&amp;reserved=3D0
