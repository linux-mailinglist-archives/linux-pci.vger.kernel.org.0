Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DACB27E29C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3Ha1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 03:30:27 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:20832
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3Ha0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 03:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl3uFYR6EmtgPIlR7rGWpiXJbkkVOI+j0GrCr6wY0u0zfLZYmNKgHfziKZgTYgxnGd8AFe3b79apBb10OkB7sNPAp1JkUfxt/WepkczL7uV3LfZbgMBTF6KfM86xkdrCN9bzTWxdsjk3fX3TQ/kFL9VL0bd7z5GveWNHIPmt2SHKi64i0Kb6liQPTeWULpQicDnbjddRIjvPEFpJ59a+mdWB81pN/Ngn+6xwlyT9e9D6hFByzRSPiqNOHKUW2lj2X5MKYau9qc822C7OHS2BkQ30zZIjax4XG4MSG2u5cFMcyxRpZQBI+t9p6oekSfRq9pZY5x6ho54FvRLHS9b32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA8RTjNUqmW/UhACYCj3+XUHPprdwOGIGPK5iWNfYVU=;
 b=A76uHzSyFvNpz9RvEPURjIBjCMtgZm894l3j9L4plW6bRLT3vtdRh8NDzVEz2sSS6ZKw32mDKcBE+AwnTlAEakNO9Ps3r/P3iMgkwu7DNR0PTpAkWVSewBk9hsCwiSwHDIY0j0c/IzuJm79FTs/IrwEPwfcKYSI3xxfsymqzrUV1vMFwiyChUJo+yiz2gpxiZ+p5GGioNbPNQTKy/lBpXhRnrx0iYeRSA4UeDbpKk65hptK0FNZ8a6Yn0g2DenrFRqWqlxRM4PbIbYZXdwgoSO/wncPgajBSXC2+6J1+o1W0XdZxM64hX4ICz8lzPUexnDETXJ3XfTRB6DAH7LS4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA8RTjNUqmW/UhACYCj3+XUHPprdwOGIGPK5iWNfYVU=;
 b=Z0aALsXVtJj/ZmmNrRWwqpQaYjz1pQpNhxQlMQJkdG7bd7G5cSBd8bL9qyBCupdB6Pva0hAgdGS4fdy/XoMAQZWLeRAPg3wrofPaTSHix8dHbd3/s0zYD4e3wFqT4oZg2LlmzmM4kmTW/HHBg7Sel9//yqoxgCui6yy64vQkm8k=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6191.eurprd04.prod.outlook.com (2603:10a6:803:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Wed, 30 Sep
 2020 07:30:21 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 07:30:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Topic: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Index: AQHWljz3j2hLyZbXKkSFG46wUuvQYal/aZOAgAArmQCAAFZhAIAA2CMA
Date:   Wed, 30 Sep 2020 07:30:21 +0000
Message-ID: <VI1PR04MB4960288477F1DA7AB56D4ECC92330@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-4-sherry.sun@nxp.com>
 <20200929102643.GC7784@infradead.org>
 <VI1PR04MB4960A4E7D6A72C2CDEAC47CE92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200929181156.GA7516@infradead.org>
In-Reply-To: <20200929181156.GA7516@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 308ecef2-963d-419f-9b89-08d86512b078
x-ms-traffictypediagnostic: VI1PR04MB6191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB61912B64DC7E4B9C7489418C92330@VI1PR04MB6191.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWj0nFr+cD9j4ggqsSNlYPSQkgaaxLAqjKpQcu6m23tQ1JpnZA0YkhPb6d2WeLGU/nlGuo6vv0nt/afz70JZxzoWR82m9wymKZh8cCqgbxQzhKkJDDCg1DoU7Q43Cj7+DzXHwWOK6+E2+X5UVM+lMvdWIl5gRdrihy8e+r/+tfIPKkKEfkC8nhOvErEvhs9DXN7AxLvDf1z+tp1pqKvJAsqwnjaNPgBdvHe6zUe6bRJpzH9EIi31GI3sU4ZTCfhlZbWQvDAjqfPlOXZhEJwA6VHvg73t+tAqrZAFGmT/dNuMdJkm9u0M/ri9UwfZQctaQuOtKn04/vDwRtXvDgNAAbaAFJaFlqF6lzw7vckG4ancWsMHBBK7/S85MeeQGwY4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(55016002)(6506007)(26005)(9686003)(186003)(76116006)(66946007)(33656002)(2906002)(5660300002)(44832011)(71200400001)(4326008)(316002)(478600001)(7696005)(54906003)(8676002)(6916009)(52536014)(66556008)(64756008)(8936002)(86362001)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AnyOEOdK7yEfr/3u1EHzuYlnCghMqfEM8vHtRYc4JIOH07Lz/0SnmD/0r1CItNkMvLY5f7xW+cMfODhSaUYt7EgdFo8qS5zfmZBcBGhjBB1x13SbHKwE+8aAfkqQsJaQ2W7SbLhC3umSV/Xh2mcO0uyLfu41RzdUHM2pMFMw6wylCY4Rd505DBSU+63sVYJIJpHlKE18Br0HBLfar4QeJpFT0HmBbCgGqeiYhNMRUoYm+sU3GJrQeKdu5oqblhf1t9Oq4VvRQsCBDs+oVODgNJmGql1Vto53k8KVuJabgrxUEy/ppfKm24IVxe03woQ+UD5H+hOykWeMyOihXjtayBTejzS6tEOeN0P9gxMfhyk2VBmdlTAF0ys0f9JvNNU7H0O0Atqu2i8IWBWn69iNug3bKjprskWYm1NGA+B2gsPurqQ80/TJTvehQcc1y7f9+J97PFbapbaI7p1rpn4J71fHaVlbFNFPWmo/FiHnIEiL80fsMSM+I1xo+9zAX85UQSY5cahCzx4+Z8xDjxT+9KuX5i/4G5jnCSiezPtEQbGqjIHlC0xVAlyR2dsGnKHjmXn/sBBWmJFZTmBBuZdfYLSGcj7OUDzPMzFNo3vQd+U7HHx9Eq6Wq4hem1IuZPDWqaYd3ZTc1k+VP4iXLoiakw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308ecef2-963d-419f-9b89-08d86512b078
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:30:21.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dryp+9SoiC4ivP/7PzPBw4stOBRhbWRz8pPcvugpxVxWrdS15V2A6kX5UbPqcb1jx3aMufrJoA8CEgGkiSPqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6191
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> On Tue, Sep 29, 2020 at 01:10:12PM +0000, Sherry Sun wrote:
> > > >  	if (!offset) {
> > > > -		*pa =3D virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> > > > +		if (vpdev->hw_ops->get_dp_dma)
> > > > +			*pa =3D vpdev->hw_ops->get_dp_dma(vpdev);
> > > > +		else {
> > > > +			dev_err(vop_dev(vdev), "can't get device page
> > > physical address\n");
> > > > +			return -EINVAL;
> > > > +		}
> > >
> > > I don't think we need the NULL check here.  Wouldn't it also make
> > > sense to return the virtual and DMA address from ->get_dp instead of
> > > adding another method?
> >
> > Do you mean that we should only change the original ->get_dp callback
> > to return virtual and DMA address at the same time, instead of adding t=
he -
> >get_dp_dma callback?
>=20
> That was my intention when writing it, yes.  But it seems like most other
> callers don't care.  Maybe move the invocation of dma_mmap_coherent into
> a new ->mmap helper, that way it seems like the calling code doesn't need=
 to
> know about the dma_addr_t at all.
>=20
> That being said the layering in the code keeps puzzling me.  As far as I =
can tell
> only a single instance of struct vop_driver even exists, so we might be a=
ble to
> kill all the indirections entirely.

There may be some misunderstandings here.
For ->get_dp_dma callback, it is used to get the device page dma address,
which is allocated by MIC layer instead of vop layer.=20
For Intel mic, it still use kzalloc and dma_map_single apis, although we
recommended and we did use dma_alloc_coherent to get consistent device
page memory on our i.MX platform, but we didn't change the original impleme=
ntation
method of Intel mic till now, as our main goal is to change the vop code to=
 make it
more generic.

Which is means that the device page may use different allocate methods for
different platform, and now it is transparent to the vop layer.
So I think here use ->get_dp_dma callback to get device page dma address
is the most simple and convenient way.

We change to use dma_alloc_coherent in patch 1 to allocate vrings memory, a=
s it is
the main job that the vop layer is responsible for.
So I still suggest to use ->get_dp or ->get_dp_dma callback for device page=
 here, what do you think?

Regards
Sherry
