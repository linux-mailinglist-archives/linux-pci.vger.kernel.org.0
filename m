Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B965DA54
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfGCBIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:08:34 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:20397
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGCBId (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYH8NoUBbuO2DOp2zCSNKmlTWAV3O/N7vZgO68ZXz/0=;
 b=XPpTI/dvpyr+KQdeVAbwUKBph62vq391kwQ9z8vUhHMjQELdyP2iVsuCI8V3ojKcwRycOSwBRa0cazWesE+wGLDs5A719Gw5wn0NidA7BnveoZaIU1uT97hcXtNLBJZmkCZhUoBuJVr2zyHN7bKMDy4j0+0ME2BA8zmaHzz82NM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6190.eurprd05.prod.outlook.com (20.178.123.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 01:08:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 01:08:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v4
Thread-Topic: dev_pagemap related cleanups v4
Thread-Index: AQHVL9UU5cGGdRKLlkyPcV6XfRMxZaa1bVyAgAI+pYCAAE0OAIAAHuWA
Date:   Wed, 3 Jul 2019 01:08:27 +0000
Message-ID: <20190703010823.GB11833@mellanox.com>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701082517.GA22461@lst.de> <20190702184201.GO31718@mellanox.com>
 <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
In-Reply-To: <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666e2153-d0c6-48b5-99ee-08d6ff52f414
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6190;
x-ms-traffictypediagnostic: VI1PR05MB6190:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB61903AF6C1A65E8369742AA3CFFB0@VI1PR05MB6190.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(199004)(189003)(36756003)(4326008)(33656002)(26005)(2616005)(81156014)(305945005)(86362001)(6506007)(966005)(53936002)(486006)(186003)(102836004)(446003)(14454004)(386003)(6916009)(6486002)(316002)(476003)(478600001)(81166006)(53546011)(11346002)(8676002)(68736007)(25786009)(8936002)(7416002)(5660300002)(66476007)(6246003)(6306002)(71200400001)(2906002)(64756008)(6512007)(66946007)(66556008)(66446008)(1076003)(73956011)(52116002)(6436002)(3846002)(229853002)(66066001)(76176011)(7736002)(99286004)(54906003)(14444005)(256004)(6116002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6190;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tDKuuIfgR9oX45s9hP9f7523FVZuj/Cp4IDBxNigMSr5WEC2agQIzrEXUBuNboGMSlvz67S1Uv6KuO5ZVoYd5GYuM2F54yxs2sTTMi7FCmrslBqo7dj9at7q74+TdPen4Ou5eFR3mxXkZfyOMYDWnkaLgqzNL/2If2wmF9amG3XbUzJrrF2i9Y4zdvEfxHk9R6qJRkf1ORCx28U/T4g+NZc4f1kuljqQ7WijxNpAVCogMYiR2X1Bk/db8lPDR/VAJvnU79i6YYQsywnUHwhH1zw+GXfs5OX1quMtO1UbEOoC10CfEL+pXw4pjtS9lPIj4b+ktBwFtMnKhYrF4qAXJUgVjOMvu9C0TEJuKee9QFswmucNkvOOYZpnw8ASNXTTpgYjkkaU87VUc1nZzBDTTlMhEbysA2yhWNye1T9POjE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9433B9982DD5FE40BE697C702241BE2B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e2153-d0c6-48b5-99ee-08d6ff52f414
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 01:08:27.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6190
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 04:17:48PM -0700, Dan Williams wrote:
> On Tue, Jul 2, 2019 at 11:42 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> > > And I've demonstrated that I can't send patch series..  While this
> > > has all the right patches, it also has the extra patches already
> > > in the hmm tree, and four extra patches I wanted to send once
> > > this series is merged.  I'll give up for now, please use the git
> > > url for anything serious, as it contains the right thing.
> >
> > Okay, I sorted it all out and temporarily put it here:
> >
> > https://github.com/jgunthorpe/linux/commits/hmm
> >
> > Bit involved job:
> > - Took Ira's v4 patch into hmm.git and confirmed it matches what
> >   Andrew has in linux-next after all the fixups
> > - Checked your github v4 and the v3 that hit the mailing list were
> >   substantially similar (I never did get a clean v4) and largely
> >   went with the github version
> > - Based CH's v4 series on -rc7 and put back the removal hunk in swap.c
> >   so it compiles
> > - Merge'd CH's series to hmm.git and fixed all the conflicts with Ira
> >   and Ralph's patches (such that swap.c remains unchanged)
> > - Added Dan's ack's and tested-by's
>=20
> Looks good. Test merge (with some collisions, see below) also passes
> my test suite.

Okay, published toward linux-next now

> >
> > I think this fairly closely follows what was posted to the mailing
> > list.
> >
> > As it was more than a simple 'git am', I'll let it sit on github until
> > I hear OK's then I'll move it to kernel.org's hmm.git and it will hit
> > linux-next. 0-day should also run on this whole thing from my github.
> >
> > What I know is outstanding:
> >  - The conflicting ARM patches, I understand Andrew will handle these
> >    post-linux-next
> >  - The conflict with AMD GPU in -next, I am waiting to hear from AMD
>=20
> Just a heads up that this also collides with the "sub-section" patches
> in Andrew's tree. The resolution is straightforward, mostly just
> colliding updates to arch_{add,remove}_memory() call sites in
> kernel/memremap.c and collisions with pgmap_altmap() usage.

Okay, thanks

Jason
