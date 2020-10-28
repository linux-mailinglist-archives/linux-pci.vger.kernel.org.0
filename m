Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23B329D335
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJ1Vlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:41:50 -0400
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com ([40.107.21.40]:27048
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgJ1Vlt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImcNZ1oi3fb7STB3V5KOtAHQxxnvD6EeF0szUNy6L9zgtkzWpwTJe7YaF/isGdtAenktdYKhlBm3R5+P7LLjiZPDDCe0/Mn/aWWCxEoKb1Woz3Hs3QdwdSjJ29/71q5icCQ088TWZ1z2qGbs4gJ8J0Dueu0YIcOTayyLVIMzkg9wLfTlSWjVTQXPaoj0AscJP1knS1mTC2Y6ObDJFAxXZ72cldxLD/7P90zESfanrFVP29DbVqJE1V7dKulm3g0T8asnW456Hv07mlbBrcuoY+Df97xsBEy/8VYBbb9Hc6Q7FQIy3Ifn0/hWGJ/RrOorsrf7oi+qUAC3123vgiw5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5haB6gIrwVUD3gFVfkoSk3H89DnYYChJFLaYOgmmRQ=;
 b=dwtVqouwMz8OvOBg+zan45+O6JQIUqM/o5bRAA8l20PPR/gRmA2JDFiN7b+ocepDJj2OaROtIOldlXL+/ral7Oajx4nmSAqxGZkmXPU6R2kp3B2D4fqQZ/wA0aPmNurIl7hd4ou7Bug1RUrfkUhNefFY3YhU3vc3Z+FB+hSAlKZ0bW0z5Q6s25pRBOULxupqv3oc9hJzBdQFRsySDNw1GfTuWGTbiqD1jnfsLHO+NlSlAU2DWpxBPRDbbPcVL4CEA+7/C4NpJCvwGDmJE70HjDWh6YCiLFNFj2kGfsYD07fDLUGkRvjQBsYCSZ4kRxZnfKTWrid0kmtvgpd9Ag0hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5haB6gIrwVUD3gFVfkoSk3H89DnYYChJFLaYOgmmRQ=;
 b=oCNOOzeGwwwnYooN7KyTFwppqlWu8rVOSqKuEUOT79yTZMHeYAGQAAcGpZTPJWBj7pP0U900CM1Wb95JEWC83/B4d0c2/O8SwA66yV1OwCDuWwzAq9K94vl7ZUAEF3Gch4ViCjSQDyoEewICPKoh5+e/Za6FvCI2X7qDePtS6hw=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7250.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 07:11:37 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 07:11:37 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Thread-Topic: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Thread-Index: AQHWrM6hrUxx3H5v+0a5i9aKIfcorqmshSIAgAABZvCAABHFAIAAAO0g
Date:   Wed, 28 Oct 2020 07:11:37 +0000
Message-ID: <AM0PR04MB49470703D53EAC2D5195FE3392170@AM0PR04MB4947.eurprd04.prod.outlook.com>
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
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5575c0eb-c141-41c1-ffaa-08d87b10b5b7
x-ms-traffictypediagnostic: AM8PR04MB7250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB72501D1DD5FCA417DE19778492170@AM8PR04MB7250.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2vET90KCoQa/oP0qiVPc0fx368Ly1NadJkLFc+5GXO/i8bKvCeD/ieshb7gHSfy9M4R2E3+eyWzCtLRRRFgW8Oh6jqMQRAsojGBOKaViEL7KpTL7rwis5U+6lhdB+Mx65Amx2QfoIR48EA5YoU+kfNwZMdyUH1v+h3LNEvNWnbyHNjjL/XlMhNReWyWBm+qd9wqAQPOfoiUyMV31I9XCXlJi9Y9ZHhrGxJjlJE/9QeF26ay2BGl8koUXE4JomDxv+mQQ/OlW2r13DAovfwMZv0/rBxi1jWou8QyK3eTaOKQgPS9GLoI0AKQw7a0iBjLy9Qp4KbEG/LPzPa+3IJu+jzoA0bHv8mVkopyq2JQtg00LpRISwkBbNgSqBwOeM8jQyxEMdNihdkToB+uViKBdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(7696005)(6916009)(33656002)(316002)(83380400001)(4326008)(71200400001)(186003)(7416002)(966005)(8676002)(44832011)(54906003)(8936002)(26005)(6506007)(45080400002)(55016002)(9686003)(86362001)(478600001)(66946007)(76116006)(64756008)(66446008)(66476007)(5660300002)(66556008)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6OKHzMgsOUuxBbFWMdDTu0o/OmZ0g8RfWdaCC9cKoUOPFeG1QbiSgKtOY8jjyYD7f9wyqcecgvkQcIR53yeLv56wN+S10kxI/ReHbJ2zukpRXRgXySQ58DhUKwsIVgIQUbSvbwU7g/HwRUKVW5P2VAVRvi5H3p8+L7x4Ez0iLMnTOQizfjsO57WofRd+qMLKk7qKcjrijVHVZDcVk657nTaeDuF0rxPV9meBFS0kK5tP/3E/qyoAzyqt0xsatx/Nov1pqLm0eeC2e6DeBSUCXv8gzaztUlJoOg/IzbXUOISaOVhnPO5Jle8wF6ucmOUCsUT68PRFD/Wn1UCVp0O2b4nT/RsMdgTV9AqNi41PbpJC64NR193lMKmDRJ9lFjxwsdNzuFlu2JEV9EeVTW5I61WN6aFZ3mW+URR39SymLY+3lOzZb7xRAKBo1OdvF3jACMBhu6SFbsUhX+GHXoM7FdOb5iXb4PF/Z4KOVTaBl3wqKOUP7fwy/GAuUXiipOcfvC/JZWaUzVt+O9piQdRu9rwbTAMmejgBuWZXMZNo5HKiUokrEXwPRlDAkeu/bafF2atc9MxnJ9TmlI9bWldOzOYDuUVzibj6D/3wCMR/tB4ZiyozGGyIC69X8lp6Jc0x4flPkK0vreU2MLyXTennNw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5575c0eb-c141-41c1-ffaa-08d87b10b5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:11:37.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7wTFZ4x9pDLVyBrzR5K0zzcTxcxNkxsd3dcHU2Tcn06hqgmWza2nzSkNsytExrjM99dSH3K1jBmhsHUdyLaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7250
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
> coherent memory
>=20
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
> > > > synchronization problem for device don't support hardware dma
> coherent.
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
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 25
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

Sure.

Best regards
Sherry

> thanks,
>=20
> greg k-h
