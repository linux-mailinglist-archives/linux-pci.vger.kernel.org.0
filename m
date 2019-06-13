Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD28544B91
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFMTFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:05:13 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:3442
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfFMTFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 15:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H89jYFJH+O3gOi+KgnHMurO79Cv4aZ07rELsB946Xc=;
 b=YWGmvPnBhCruH1hC4ENOlDT/9NFEkEL0a4q9Qa4NpxuZS5nl20d1v1o2AyB8KY0mRuUpO8MBZVt3w70ES3mNbWfW9rSrolUHDrlUOb11mpH1sv6dZFgWg/bmYjRlTeKxzVQizkp6CPOcq2N0Zz+3+5aKzaCjOTaUlVQ+9iGoHDk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4928.eurprd05.prod.outlook.com (20.177.51.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 19:05:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:05:08 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
Thread-Topic: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
Thread-Index: AQHVIcx9tYJr+8Mn7kqAMQYMKR1ZDqaZ8jSA
Date:   Thu, 13 Jun 2019 19:05:07 +0000
Message-ID: <20190613190501.GQ22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-5-hch@lst.de>
In-Reply-To: <20190613094326.24093-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf803f6-efcc-4d94-d47b-08d6f0320cfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4928;
x-ms-traffictypediagnostic: VI1PR05MB4928:
x-microsoft-antispam-prvs: <VI1PR05MB4928F4B1BDE805C1E9FF8777CFEF0@VI1PR05MB4928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(7736002)(81156014)(36756003)(14444005)(476003)(2616005)(6486002)(6436002)(256004)(486006)(33656002)(446003)(99286004)(54906003)(11346002)(305945005)(66446008)(66066001)(6246003)(26005)(66476007)(8676002)(229853002)(73956011)(6916009)(66556008)(7416002)(186003)(53936002)(81166006)(316002)(66946007)(64756008)(6512007)(3846002)(102836004)(5660300002)(8936002)(1076003)(76176011)(14454004)(386003)(52116002)(6506007)(4326008)(71200400001)(71190400001)(478600001)(86362001)(2906002)(25786009)(6116002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4928;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6FABMmmx3sbXSt/4QuBhcr7/YtvHD9s/olWKQHhWI0mA8kSlXMrWKF0QZilfQlXKDGbNvyqHgaxtSNIRDHWheLvlaQg7ETFB5Cjnsj3e6AzZTE/LzV1r/NXF4RPFKajt7Lf0Zt3MLCVPMv6Py9/mIUvHGARY4lqJVy9Ty8iRrJAEPZH0ZBM9D1K5rtlvMnz+WJYUeaF4YLccPfAELIPq0IFDLQouavshf+v9LfjaFE4GF5kD2gQSIkznPLEr5clvmds52YnLYX7mLmyaXddlqJBiuppL2rqQ4yHc0l15YlH27wU+91x31a2e5aTrSJ20Jta1x+D2p7zY9S4bBcgIW15iFdf19CgvOtpiNVk+iUV7/GLUbJt6PuRULdtVYopy1ZL0GfFk9W9ORII8qhp1t7aYrw6saeClZmC8MzyF26Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7BF6B23DFB21B24C9129FD14A4ED8C15@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf803f6-efcc-4d94-d47b-08d6f0320cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:05:07.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4928
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:07AM +0200, Christoph Hellwig wrote:
> ->mapping isn't even used by HMM users, and the field at the same offset
> in the zone_device part of the union is declared as pad.  (Which btw is
> rather confusing, as DAX uses ->pgmap and ->mapping from two different
> sides of the union, but DAX doesn't use hmm_devmem_free).
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 2 --
>  1 file changed, 2 deletions(-)

Hurm, is hmm following this comment from mm_types.h?

 * If you allocate the page using alloc_pages(), you can use some of the
 * space in struct page for your own purposes.  The five words in the main
 * union are available, except for bit 0 of the first word which must be
 * kept clear.  Many users use this word to store a pointer to an object
 * which is guaranteed to be aligned.  If you use the same storage as
 * page->mapping, you must restore it to NULL before freeing the page.

Maybe the assumption was that a driver is using ->mapping ?

However, nouveau is the only driver that uses this path, and it never
touches page->mapping either (nor in -next).

It looks like if a driver were to start using mapping then the driver
should be responsible to set it back to NULL before being done with
the page.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
