Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACC29E194
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 03:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgJ1VtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:49:08 -0400
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:21761
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbgJ1VtH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:49:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrTJuUa99tyKXxOiiBTiFWTNeM/+8Py4MZoRzmENdTDiLGcYjnhTfQHxzsPuVcGMvlwMGlUsUF6/jQlxIPodS91PGxl9mdZE+t10wKrLGMscSGSeZiuS6lDbW6asexoq3rIxX/kZv695JZVZ+p4m0AaQwuJwnbpS+ij1fCaaODNdJl7uRENBhE8pJGcQWksw+PhL+aUWn6Jbo3nvhE8H+FSORG0EJvyokvD7DnJzTly/bhUORgHZN/XP2xOq3AHyQu1r4sF2KzsN+zxBNbgmmbjmOc9/H4bnz/Y4mCdLLEVQJKbFEIpzfKB83llXpMLow3TZk7eh82cq/Kcc7FqzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DldRBvyxsoE8DJnm1oHGrGgZs2G90UsDATlscallSnQ=;
 b=beAPvx26u9U6GLUtBD2NXAuAXqoparv+O810qNlIMJ4wLbd0phCiDFz9+YIliQn8j013hfyX1yPXCnsVM1h2UJX0Lt8d/RSb6kUyE30OjDMweItJUIHtI/y9TAAVExP3uhGVNazK/kMI280G0A/eAWNOOU0JS+pylOsNqT/vixl15YJot/NE2v8M8QKpj6WVBtPbsMA5U2S3CQqXNBQASFpCs8S86bi+pbpzPXYJ75P57Lbm5dqdpOsvrPSVb1XUOoH/z8Hcn/TkLaQKiCVN2O32JZ7i8vfpSoaHjmLlOa/Oxs+HuuOOhb5MDfJ89LYeXlk3qh1dbk7gfsx+Vl/Jrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DldRBvyxsoE8DJnm1oHGrGgZs2G90UsDATlscallSnQ=;
 b=Pl7zo0gdsD3DV0HCZBSZipRX+AG4IeDH5xGdNtsaBMx1XKoX+OAN5Yd/G33tLUCTAaqW85kwCy31ZLFnzecVSghUWH9ppr4rGof7MQAXn9DL5FbCMDdR6SCXxsBBd6gfkdA8LAtrLriu2ufPNp+cRaze5J3R2Eq+OKRw6KHx57U=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 10:17:39 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 10:17:39 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sherry Sun <sherry.sun@nxp.com>
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
Thread-Index: AQHWrPBWlkaK3Q/in0Cw78FI6wskoqmsmAkAgAAzuWA=
Date:   Wed, 28 Oct 2020 10:17:39 +0000
Message-ID: <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
 <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <20201028070712.GA1649838@kroah.com>
In-Reply-To: <20201028070712.GA1649838@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b58ec37d-33b7-4339-e1b7-08d87b2ab2e3
x-ms-traffictypediagnostic: AM8PR04MB7331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB733190F469EFA4F5D9D3B584FF170@AM8PR04MB7331.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ooHSj+abD4TYMeuiBnLbCbPyA9/I7AHg4AoudanYs6IX/2wJLeiITxmTPPZ7vwQnExRpyJY0+bvOYg0WEHHC5K0phXLgrrYmwV2gAxQrHOhjGu3eSa5xqO6q3Ztlkb0f9TA39avi7hkGSd/7uXtSUM3Gj2qHr6/LIKDRbY43akqM++wzzsjeB4dTOtbVkmReqRQeSPx5JsP5cJnKv1WrBUkbwcaeNozIjKStAHsC8OTAOqpAA5igtAjgTnaWcqWqcO8Vv/J/9xC5Ycg0tYAoB53yc1CphxSjZhLHggrjiou0KE5x4SPGzQYG35KBsCti2L2UKxfQBLdFF93sjeW9U3SH93Y4t/qbCjI5QWgx+MVIp+m0FkX7XLUd1eocTYJUmfXaQoWXlRjTJI7TtEzBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(83380400001)(52536014)(5660300002)(86362001)(110136005)(54906003)(316002)(71200400001)(19627235002)(33656002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(966005)(7696005)(45080400002)(6636002)(6506007)(478600001)(186003)(26005)(9686003)(55016002)(8676002)(2906002)(8936002)(4326008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: H8jkmq+TUrFiXb6jKdgS3dc1pxfHpJeaWvP2HWWdbT1frtchugUadS7FqiIqK22XVdtgO0MLLx5TwlQ7wTOlinKm/jsIR1Zgb0MpBA5qmjZn3+cvQYNhcO9ULbmoG8H6ZYtH5oNwfCIXUJpquhnxk3OlKFOH0Ge1PcWtD7HMzLj0jh8ak5xBTggBmGer2IoAKXZLvnNy5DKGnWj8ANw73zKsrHJwpg9+upoVq+6Wx2qcuFvSK4gwLZ+xSt1igE/nk4Vlj3bxTfPO58Dajb9tdh9PEoDVgUGh9vuZznUwjZ0ydi3BnEYQ8unvchRkjkecXiK+qRAFgaXjWxbvRLfk2YPajZMPqh+8JklY/muNFJlYY5bWOytLrc85aP6VM6vr8EmBl4D8c5L0N/xu/sbk83d+q53DC8oMSLlBtZiSDqTm0jylOBIqyEtIOp3EJVOaiHCLY0qFj35O4rIzAONWlqTXzke7VKmEDA/AZU1SX3QQpWGVX/RM/4hxNJM1q5IjNygGr8OUgqmPwoJE6IJrdDQaolLiLX4W6jNAcvD4RWTi0HpeD1xVDj2gd2Gfek55Cma6Kx8/IEmu/sI2F0yqZPRWNaycll+QF1TWsPC7dDxb9nKg//LbF9UUcsC4KeIDjz5P0KlyZ5daDsv79c76HQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58ec37d-33b7-4339-e1b7-08d87b2ab2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 10:17:39.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYwpUAm3DF1uJGSKZJFjEEgViDXpNGfIJhB6xgRKp8Vo+sQGZ2owBW91I08o9B1RzcpVgP9LdJ2jDl+8Aa0KrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday, October 28, 202=
0 3:07 PM
> On Wed, Oct 28, 2020 at 06:05:28AM +0000, Sherry Sun wrote:
> > Hi Greg,
> >
> > > Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to
> > > dma coherent memory
> > >
> > > On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > > > Changes in V5:
> > > > 1. Reorganize the vop_mmap function code in patch 1, which is done
> > > > by
> > > Christoph.
> > > > 2. Completely remove the unnecessary code related to reassign the
> > > > used ring for card in patch 2.
> > > >
> > > > The original vop driver only supports dma coherent device, as it
> > > > allocates and maps vring by _get_free_pages and dma_map_single,
> > > > but not use dma_sync_single_for_cpu/device to sync the updates of
> > > > device_page/vring between EP and RC, which will cause memory
> > > > synchronization problem for device don't support hardware dma coher=
ent.
> > > >
> > > > And allocate vrings use dma_alloc_coherent is a common way in
> > > > kernel, as the memory interacted between two systems should use
> > > > consistent memory to avoid caching effects. So here add
> > > > noncoherent platform
> > > support for vop driver.
> > > > Also add some related dma changes to make sure noncoherent
> > > > platform works well.
> > > >
> > > > Sherry Sun (2):
> > > >   misc: vop: change the way of allocating vrings and device page
> > > >   misc: vop: do not allocate and reassign the used ring
> > > >
> > > >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> > > >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> > > >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> > > >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> > > >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> > > >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++---------------=
----
> > > >  include/uapi/linux/mic_common.h    |   9 +-
> > > >  7 files changed, 85 insertions(+), 218 deletions(-)
> > >
> > > Have you all seen:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%25
> > >
> 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> > >
> 03854416.git.sudeep.dutt%40intel.com&amp;data=3D04%7C01%7Csherry.sun%
> > >
> 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> > >
> a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> > >
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > >
> VCI6Mn0%3D%7C1000&amp;sdata=3DZq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> > > 9zDyv4NVN4TpC%2FU%3D&amp;reserved=3D0
> > >
> > > Looks like this code is asking to just be deleted, is that ok with yo=
u?
> >
> > Yes, I saw that patch. I'm ok with it.
>=20
> Great, can you please provide a "Reviewed-by:" or "Acked-by:" for it?
>=20
> thanks,
>=20
> greg k-h

Sherry took much effort on the features support on i.MX series like i.MX8QM=
/i.MX8QXP/i.MX8MM.

Now it is a pity to delete the vop code.

One question,=20
can we resubmit vop code by clean up, now only for i.MX series as Dutt's su=
ggestion ?
Or we have to drop the design and switch to select other solutions ?

Thanks,
Andy
