Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0029E106
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgJ2Bwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:52:44 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:37634
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733095AbgJ2Bvy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 21:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQezyjCv4UoTgprWrp/W5lSnddKEGxR3tpQwQqmGz7M4P1h4f2Bo07pAOOYZlKVVaWA8+mq6GLWRp/Xmi72hP6yG7rGpazrDauLDivohMjHicoVtu3EKFaV6vecBcOlrgOZKIftnbj3DnD2o0CM0F5upAXTUDHnFtBaFfPhYfXwakqhvvuJZTSN3v1NB17IN6yn+PQ7twCD1XyvL+Cj9sC1Hntv8EootZjW+EEgkVyHBjHdGRv98/dRYx7NHHw0j6u5NjXUFB4KrN/q1Y3Kp6Zzu9Iv8DVCyDYHvBo2UHVny+wpO+/wU6Zv5wdaTVIDDcrsBWZbnGqLcJRuaFDZqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASmOhrScRLlNbsmT2Vlo2mBqUOegJ3Gd52S8G0PENSU=;
 b=AcrBop/xYZmz7w6Dtmdf7+S5Vah7/phEaksqLb6UCxypjenzE5398f2R2sl61+e6JMS8JgOTPgQAUwo4vu7bpXX6TIe/7r6/OpIYFqOBIrS2787muQYEzRYhl8PrIcNwE1tpaNUIPrAA1g5/fcqQZFEaLPOVK+M7IyEHkdrRezfzsXLZSPbYGHUlO51v7ueqDooloa5igpYoPXaImNV3+UhbWsW/X+Ti+8BndbjqFmuFkbOFyX136Imle+VPwi2hKgZiGCCmtdtTaVdAfkVjsVL9KNUZYr/19EQKqSJTl4o8pv+kO5Vop0M9MmTEgsMVSB9eOhBCIq8sTJ4YoUn2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASmOhrScRLlNbsmT2Vlo2mBqUOegJ3Gd52S8G0PENSU=;
 b=Dep7hIhWw161bsOCHIjeLwjr78DSGlzx/r3rFWAGIJ5watzJ/aG6jrlDVct559/JiQybSGa2WESGSktQjMHZoPrXlTPSyix0nX2/LysoWjh8YpYoaoP8gUsNp2Y1KeVZrgbkTUG8PaWO5mpgLNmF1QzrIfWFWcVqqBbibrchL+o=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3103.eurprd04.prod.outlook.com (2603:10a6:802:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 29 Oct
 2020 01:51:51 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3499.024; Thu, 29 Oct 2020
 01:51:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Duan <fugang.duan@nxp.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal memory to
 dma coherent memory
Thread-Topic: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal memory to
 dma coherent memory
Thread-Index: AQHWrM6hrUxx3H5v+0a5i9aKIfcorqmshSIAgAABZvCAABHFAIAANTaAgAAPs4CAAEJVgIAACJcAgACm5aA=
Date:   Thu, 29 Oct 2020 01:51:50 +0000
Message-ID: <VI1PR04MB49608E4DE25847CC3019A40092140@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
 <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <20201028070712.GA1649838@kroah.com>
 <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
 <20201028111351.GA1964851@kroah.com>
 <AM8PR04MB731570801A528203647FAD0AFF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
 <20201028154200.GB2780014@kroah.com>
In-Reply-To: <20201028154200.GB2780014@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19caefcc-ca5f-4ba4-d444-08d87bad346c
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB310338DC96C004206760745F92140@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHG2mgrzPiWU0i0CstcJjLhWatI4tzaVs7rL+/tFpl6KsY1OrIkGw6Q4rr7f6JWxCQeuOf6CYhv50Fn04iscpn06yaFP+tlB0EyY8Qrh3nlfRHYP6a7x0Sm/dCCnzP24rw6yBpzCm574MKb7TGO+V1HPK8K7OuhGIMTkWK639MEmCbukpmUVTLZjnTyaGGE3NhmqsYABpHBH84MSlAWAUVb6msFj24d8N37s2fXpVsKhoZR7FWjsxRB/d2NKu2YGYa928nYdfqzzBZOf6pFBysdJwrviq1/b3HZZBtVY+fwVCKYX0e1i5cckQNiic+7Dg+qHfq6uzAsKOftllVm7302RV8R2YNTCHSqCnlSVrM6Z07b5oeJHpfQ4JtCnEbx/1QNuXDhMyXp0MBkJvSAL6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(6636002)(76116006)(83380400001)(7416002)(19627235002)(966005)(2906002)(8676002)(5660300002)(54906003)(44832011)(110136005)(6506007)(316002)(66476007)(45080400002)(52536014)(26005)(66946007)(66556008)(33656002)(64756008)(66446008)(9686003)(478600001)(71200400001)(4326008)(55016002)(86362001)(186003)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 38CCv1FqsPn32bVo3hy9QcZ63QzXMvTtFChKdsNMxXRZcTFPfz3eBi/gCUwmBTlGTL23xEvNdNB8qU/vonYIwl31Kxi7FiXGmNXcdG9NakuP05kTIDpn/3cBlcd7ZTW+xK1j2pcgTvuqRbSxl+HPizI3rcKD4GXDW1ejlKCM/2qlA83ZFbyUZbrto40DKO9NtwX5UQix+CzYqmrHsFaQCKr/b00pKTcYgR80gse1l0GuZt/adjqWgzOtcocvUvumBMG3Rtt3Ds89u4+oP6NNrKGlxmy8c+z0GoYo17GUbQWE2PSGirQIx7NF5NqjeGcqLUiZuU+EBXU4un/p7GhWdOtV1dfs3qE2TnmqNCyDdIsjsu/Nuvx2qcBPl6PsVBjvxfS2RbnvPt1UPQUOfzSNvuS0tnihgTqkQ+o9r5Z8hDhaog72CT9PueSMmeftJuQ0RTGUtX+mGL/y+UpLd0UBpphOXAE0ngVfrbisw3PE+7h6Y7+xM4GZdsSryzIxvOV7ciaDk674esQoj+HpFUPDXY7nZ0YvGp8XJgdiyoL2nACrRkaiYZDFtBQkuxpL8TdsmtYM1tpFfPwqxF52eRZrqrPUYewdK/lRODG1WcXePg+b37fCoQGqBdr9uYFc7wmrjVp8XjYKTiGbbyD/sc11wQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19caefcc-ca5f-4ba4-d444-08d87bad346c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 01:51:51.1351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBGrBdjvMPIhKOeQ4p/ygdk4faIGPcwimG2awWxqgHKNYEKXM4ttjoTgQkyWVbOPaVhU/V3CcJzv/QPQi3ztkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

> Subject: Re: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal
> memory to dma coherent memory
>=20
> On Wed, Oct 28, 2020 at 03:11:15PM +0000, Andy Duan wrote:
> > From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday, October
> > 28, 2020 7:14 PM
> > > On Wed, Oct 28, 2020 at 10:17:39AM +0000, Andy Duan wrote:
> > > > From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday,
> > > > October 28, 2020 3:07 PM
> > > > > On Wed, Oct 28, 2020 at 06:05:28AM +0000, Sherry Sun wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > > Subject: Re: [PATCH V5 0/2] Change vring space from nomal
> > > > > > > memory to dma coherent memory
> > > > > > >
> > > > > > > On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > > > > > > > Changes in V5:
> > > > > > > > 1. Reorganize the vop_mmap function code in patch 1, which
> > > > > > > > is done by
> > > > > > > Christoph.
> > > > > > > > 2. Completely remove the unnecessary code related to
> > > > > > > > reassign the used ring for card in patch 2.
> > > > > > > >
> > > > > > > > The original vop driver only supports dma coherent device,
> > > > > > > > as it allocates and maps vring by _get_free_pages and
> > > > > > > > dma_map_single, but not use dma_sync_single_for_cpu/device
> > > > > > > > to sync the updates of device_page/vring between EP and
> > > > > > > > RC, which will cause memory synchronization problem for
> > > > > > > > device don't support
> > > hardware dma coherent.
> > > > > > > >
> > > > > > > > And allocate vrings use dma_alloc_coherent is a common way
> > > > > > > > in kernel, as the memory interacted between two systems
> > > > > > > > should use consistent memory to avoid caching effects. So
> > > > > > > > here add noncoherent platform
> > > > > > > support for vop driver.
> > > > > > > > Also add some related dma changes to make sure noncoherent
> > > > > > > > platform works well.
> > > > > > > >
> > > > > > > > Sherry Sun (2):
> > > > > > > >   misc: vop: change the way of allocating vrings and device=
 page
> > > > > > > >   misc: vop: do not allocate and reassign the used ring
> > > > > > > >
> > > > > > > >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> > > > > > > >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> > > > > > > >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> > > > > > > >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> > > > > > > >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> > > > > > > >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------=
------
> ------
> > > > > > > >  include/uapi/linux/mic_common.h    |   9 +-
> > > > > > > >  7 files changed, 85 insertions(+), 218 deletions(-)
> > > > > > >
> > > > > > > Have you all seen:
> > > > > > >
> > > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A
> > > > > > > %2F%25
> > > > > > > 25
> > > > > > >
> > > > >
> > >
> 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> > > > > > >
> > > > >
> > >
> 03854416.git.sudeep.dutt%40intel.com&amp;data=3D04%7C01%7Csherry.sun%
> > > > > > >
> > > > >
> > >
> 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> > > > > > >
> > > > >
> > >
> a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> > > > > > >
> > > > >
> > >
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > > > > >
> > > > >
> > >
> VCI6Mn0%3D%7C1000&amp;sdata=3DZq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> > > > > > > 9zDyv4NVN4TpC%2FU%3D&amp;reserved=3D0
> > > > > > >
> > > > > > > Looks like this code is asking to just be deleted, is that ok=
 with you?
> > > > > >
> > > > > > Yes, I saw that patch. I'm ok with it.
> > > > >
> > > > > Great, can you please provide a "Reviewed-by:" or "Acked-by:" for=
 it?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Sherry took much effort on the features support on i.MX series
> > > > like
> > > i.MX8QM/i.MX8QXP/i.MX8MM.
> > > >
> > > > Now it is a pity to delete the vop code.
> > > >
> > > > One question,
> > > > can we resubmit vop code by clean up, now only for i.MX series as
> > > > Dutt's
> > > suggestion ?
> > > > Or we have to drop the design and switch to select other solutions =
?
> > >
> >
> > Okay, we plan to switch to NTB solution.
>=20
> What is a "NTB solution" exactly?

The driver located at drivers/ntb/, it also can setup a point-to-point PCI-=
E bus connecting between two systems.
But we haven't got a deep look of this driver yet, so we are not sure wheth=
er it can replace the vop framework.

>=20
> >
> > > If this whole subsystem is being deleted because it is not used and
> > > never shipped, yes, please use a different solution.
> > >
> > > I don't understand why you were trying to piggy-back on this
> > > codebase if the hardware was totally different, for some reason I
> > > thought this was the same hardware.  What exactly is this?
> >
> > Not the whole codebase, just the vop framework.
>=20
> That didn't answer the question at all, what are you all trying to do her=
e, with
> what hardware, that the VOP code seemed like a good fit?

Vop is a common framework which is independent of the Intel MIC hardware.
We planed to reuse vop framework on two arm64 architecture devices, to setu=
p the connection between two systems based on virtio over PCIE.

Best regards
Sherry

>=20
> thanks,
>=20
> greg k-h
