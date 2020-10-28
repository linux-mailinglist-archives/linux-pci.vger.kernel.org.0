Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A512C29D383
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgJ1Vof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:44:35 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:58265
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgJ1Vod (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRG8u8pC5ggwU0JZkBjMqiR6iPFa8+7zC0cKFsvgpQXJBNCWDO/GcICT/XHsWfs6TCT/vwnQl7Wlz0HJAYoq3xQDwPzo9jPT9IrcVuSI1kH4Bfu0hPpHpms6IsLyovUFQgneNWXcPIwIo9Y2XvvCIF248mBNTAdOY68dC0YYygPPGFgLj5hJTzRmZx19IJD7tUWcP235/cuPHPuFuXeenV2wJKnUkCeZd4kJRDoF0CrLnZ3hPDQCP8hXqD4oeU//XbUOyxWz+QywcsUjtyXbxl0jDOoCIsMoi4gNM5POp62jtQFSmCaw3fPBFKgNx4tchtTzFFBTENtsp2kK96ew3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZEB8hmeTkvHNdabEBZF1I3304IbdW2CqQ2KguvSV9U=;
 b=au84gNNzoKd0ov8OTe6F7OYMOD+Xgim+9I6pjkz4aRRDVD1y40caymA2VUooKgZ/FbA4kGOuF839x3HCjQH0iDy4e4Sxeuob0tLRS0gL1BPIGvrzrgj30VolzGGW+hEyVEEGztrqkI1DYjam4hKq381pUrhbUpVufbokBevCGTST7HhZS9AFsciYn8i2QYFHtzQaeJdXV9I2SwiMUqXRfE86XXKLMYEppVTZPMJC8NnOtM/1aLqPZE2FDhCCPfBIKLarZF1oK26wA017txZf1TXrp0g/pmERTaUm70nUZSn9/5nAXMfsz5VTLkiHLb4EiR7mp7mQmOXmbNYW297Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZEB8hmeTkvHNdabEBZF1I3304IbdW2CqQ2KguvSV9U=;
 b=huOd1AmJUhq9/JqEHassGncod9zjKk3cJOkUhuMZJLCu+AL80ipz3GzsdXYx5bgOs6hQ0li4HfRW/SvFat8eb1junSziGTtnVU6SGp57Bb+TPgSaWrJDvAEJioXICTsU0XZ83l4Nk9ZrkbUghoy7eo+CSvOGovxDMtmqcsx3wXU=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR0402MB3476.eurprd04.prod.outlook.com (2603:10a6:208:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 15:11:15 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 15:11:15 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
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
Thread-Index: AQHWrPBWlkaK3Q/in0Cw78FI6wskoqmsmAkAgAAzuWCAABExgIAAQXkA
Date:   Wed, 28 Oct 2020 15:11:15 +0000
Message-ID: <AM8PR04MB731570801A528203647FAD0AFF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
 <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <20201028070712.GA1649838@kroah.com>
 <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
 <20201028111351.GA1964851@kroah.com>
In-Reply-To: <20201028111351.GA1964851@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 607eab04-b8e3-4943-af3c-08d87b53b71b
x-ms-traffictypediagnostic: AM0PR0402MB3476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB347679297B1AC38D413C4A2EFF170@AM0PR0402MB3476.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhq5A5RnsIsJdiNaDJl4PrYz1bnRMJcbpBaX1dkW3qU6r7Av+bXI6PXkZmSXu4CN0TtIeCMKs4+C+Cc+eSudcwYbNmGDDpd3Bhz2F4TbP61HyJrwAysemuQdbfTuGPy5N96v9XPuA6rHxHIDN9fOuEI3gu/FLB9vayXldp4ifCFpcv5n56Mfmj4VApfyBV365Smhg1vyTe59gpqX2Qc21xVpiO/cPZmUxIcUbgdGOLIZFT4Mai7832xjWLtSvj41kQ8JjmAuPvm6Se0zfSP8APc8TTWT/tAniOuUIsw2eIPM5hbIThtu73T1fFSzj+UrKMmEbcyonhXVyCw6HbZoVr96NpUuGsEhTaH6LXfUvlFKfqrkG1+6Xt+4AMxcpwu5LOjs/jJjpRxan8hjflDpUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(7696005)(478600001)(19627235002)(316002)(2906002)(54906003)(86362001)(8936002)(9686003)(83380400001)(966005)(66476007)(4326008)(66446008)(7416002)(5660300002)(26005)(6916009)(52536014)(6506007)(33656002)(71200400001)(64756008)(55016002)(76116006)(8676002)(66556008)(186003)(66946007)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KH0iZZ9SDsbAg0y6ZRYTLvSI6s5NZWq3l6CbshWjKMsnHWnXsYfNCCHhZvtSPvovEdlvfy78JTCZzLk0pKxzp1SNas//lcQrOGS5fOb5q/xx+/Fmh4RMP365alGmVhi2SMq6bw9yJOKfH6+z80wyUoYBHNuyiJKlJ4ez9wFH3IQgT3LQs7sIZLfAL5ORdPrvB4w7DQTGEU2zNSnQSdOFqNWZUvI+qvUeMNHU53VqOmpGxCrGbpkQV5CNo/kRMdPL/OEANlxBZ+pnfvrAAIJ+PUru0HR0gYdfU4lvGMdRO0D6JnARWvPUBXQ9lbZIr6URFwQ24OWhaWhCOH+yL76SUr5ke12uy9msYELxY+eqycOQcUxRbG1P98U0kzwHcmkRLob2l+yDrOcq6NQxICxbHLxOqridt3knbn26CMv++FePK8Vi1MrStzMFdojcBob69epXLsLo2iGOtPVnE7ZiWAHGF+TG+F24W/fGRGeMcK4Tl0pd4a5lij4v+VZDrxwn92i1aa40RhtfqV1P8zY/QjUVPLkjv43/Gdzh+WE0MKJtTE1JsWUvbdIKnCVUp/trnIsthiP2PCgd6D0i+gM20CXx4Ye2IhLCHM0PYMDF0HjBTdY/7gLmXLWtkkLP4n2e6AXHOG4cSsoftv/LedN1hQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607eab04-b8e3-4943-af3c-08d87b53b71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 15:11:15.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4kGg9TSf6pp3OYuqII71qRDDa5nl70lJacfEb7HDqUFC2PwEXvFLZ5z1g2AsVs/6qhJJGrcqFf30DsLyQGWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3476
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday, October 28, 202=
0 7:14 PM
> On Wed, Oct 28, 2020 at 10:17:39AM +0000, Andy Duan wrote:
> > From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday, October
> > 28, 2020 3:07 PM
> > > On Wed, Oct 28, 2020 at 06:05:28AM +0000, Sherry Sun wrote:
> > > > Hi Greg,
> > > >
> > > > > Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory
> > > > > to dma coherent memory
> > > > >
> > > > > On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > > > > > Changes in V5:
> > > > > > 1. Reorganize the vop_mmap function code in patch 1, which is
> > > > > > done by
> > > > > Christoph.
> > > > > > 2. Completely remove the unnecessary code related to reassign
> > > > > > the used ring for card in patch 2.
> > > > > >
> > > > > > The original vop driver only supports dma coherent device, as
> > > > > > it allocates and maps vring by _get_free_pages and
> > > > > > dma_map_single, but not use dma_sync_single_for_cpu/device to
> > > > > > sync the updates of device_page/vring between EP and RC, which
> > > > > > will cause memory synchronization problem for device don't supp=
ort
> hardware dma coherent.
> > > > > >
> > > > > > And allocate vrings use dma_alloc_coherent is a common way in
> > > > > > kernel, as the memory interacted between two systems should
> > > > > > use consistent memory to avoid caching effects. So here add
> > > > > > noncoherent platform
> > > > > support for vop driver.
> > > > > > Also add some related dma changes to make sure noncoherent
> > > > > > platform works well.
> > > > > >
> > > > > > Sherry Sun (2):
> > > > > >   misc: vop: change the way of allocating vrings and device pag=
e
> > > > > >   misc: vop: do not allocate and reassign the used ring
> > > > > >
> > > > > >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> > > > > >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> > > > > >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> > > > > >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> > > > > >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> > > > > >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-----------=
--------
> > > > > >  include/uapi/linux/mic_common.h    |   9 +-
> > > > > >  7 files changed, 85 insertions(+), 218 deletions(-)
> > > > >
> > > > > Have you all seen:
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 25
> > > > >
> > >
> 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> > > > >
> > >
> 03854416.git.sudeep.dutt%40intel.com&amp;data=3D04%7C01%7Csherry.sun%
> > > > >
> > >
> 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> > > > >
> > >
> a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> > > > >
> > >
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > > >
> > >
> VCI6Mn0%3D%7C1000&amp;sdata=3DZq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> > > > > 9zDyv4NVN4TpC%2FU%3D&amp;reserved=3D0
> > > > >
> > > > > Looks like this code is asking to just be deleted, is that ok wit=
h you?
> > > >
> > > > Yes, I saw that patch. I'm ok with it.
> > >
> > > Great, can you please provide a "Reviewed-by:" or "Acked-by:" for it?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sherry took much effort on the features support on i.MX series like
> i.MX8QM/i.MX8QXP/i.MX8MM.
> >
> > Now it is a pity to delete the vop code.
> >
> > One question,
> > can we resubmit vop code by clean up, now only for i.MX series as Dutt'=
s
> suggestion ?
> > Or we have to drop the design and switch to select other solutions ?
>

Okay, we plan to switch to NTB solution.
=20
> If this whole subsystem is being deleted because it is not used and never=
 shipped,
> yes, please use a different solution.
>=20
> I don't understand why you were trying to piggy-back on this codebase if =
the
> hardware was totally different, for some reason I thought this was the sa=
me
> hardware.  What exactly is this?

Not the whole codebase, just the vop framework.

>=20
> thanks,
>=20
> greg k-h


