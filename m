Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1601659F0B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF1Pij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 11:38:39 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:6795
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfF1Pij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 11:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=YWrf81ldmjTWhNIf2o5s+PxDhoRgg/hguBJQA7mOcQPdLgoNe0m90BeaGC0LPXBfH4B7RtXeCieoC4HL2XNsHsIAwynBC4REa5SthMaY38EJiXds+PiaaTVIFFsi8kEkOCPWhec98uI6+U5+RD3h3X/23SyfikLOuNe2a4/paSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLku6ir24rZW4tVJUVeMvnBtyIoSP0XnsnDssJoRSYk=;
 b=wG6ObGU35Hyfhhn/CuTGFTNWTFIuXqRepQniXecRutpjrqQJblAoQn+dwMZkCd6UqanEfIbTNeCGpQQO9uWM6Uf41UYN6z7aUUQhoV3Fa4Xa79Zu+ZBNak+pCg+kBaIQjxVYaLtIi3OebOVA0J9vAR/3HbWpPLKIiyyEdpqwJ5w=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLku6ir24rZW4tVJUVeMvnBtyIoSP0XnsnDssJoRSYk=;
 b=DnAA2swC4elRI3KiIRukzdPV/k9Q24g7eikbNVlDNZk9dlUMIOgAgecRYBldwUguw+YTQzuDDJPEVGkvHSB3w4hI1PY3/ii4XS4u/0znjRgxr0EC26T+yiLfR1csWMf4O4AtXg7yshHI4AtF/yX9u7UbKtPorGjbfRVZjFIU+kI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5936.eurprd05.prod.outlook.com (20.178.126.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:38:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 15:38:34 +0000
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
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Topic: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Index: AQHVLBqgvimki3zmIk2l4xtSxGbkyKaxNtmA
Date:   Fri, 28 Jun 2019 15:38:33 +0000
Message-ID: <20190628153827.GA5373@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
In-Reply-To: <20190626122724.13313-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [38.88.19.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05d4fcbc-8ab9-4069-84fc-08d6fbdeadd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5936;
x-ms-traffictypediagnostic: VI1PR05MB5936:
x-microsoft-antispam-prvs: <VI1PR05MB59360B8AC12BA66BC72FEE4ECFFC0@VI1PR05MB5936.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(68736007)(99286004)(476003)(81166006)(8936002)(86362001)(64756008)(71190400001)(6246003)(478600001)(81156014)(66946007)(6512007)(8676002)(6436002)(3846002)(6506007)(53936002)(73956011)(4744005)(33656002)(102836004)(4326008)(36756003)(6486002)(5660300002)(6116002)(2616005)(71200400001)(316002)(1076003)(26005)(386003)(66476007)(25786009)(7416002)(66556008)(76176011)(66446008)(229853002)(186003)(54906003)(2906002)(305945005)(6916009)(256004)(7736002)(14454004)(446003)(66066001)(52116002)(486006)(11346002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5936;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aVxtYRA0vip7hM1WU5QuKAiStkC5K6vc2eNm/k3hRyZi/nbuMukNzRui1mmIH3vhTFVAfGYY0ZFdAfKTTKKkjqkUP8qEexEP+issJMtLRASJmVe4Jn2H12ReEsuZOtzOKpwlhytDORudx7Mc0br9a0Hqthy1N8osOox2QNGAxUXDgDMplUJ8yXBjSUPb7ydz88in5Spy5QtdUsqvrDrx+FJF80EurzTDrI4CewXKNGneNRXyyYhZ5Z45TM4dsptN0726IU53ImZ3FqF0W0/viCwF6USMFz4KJICqPuoajx55kM5BFFHNZ9PgqyrUlQ94vuZMoXYBfFdGOHd3k8WFG+Wwwi2BW4MXFsIE5x/XGfK8DkPBCIoEsZbdhWrBgCdzpIhvKvD9JfCOPWTh55sqVbuyKk1ymPHwjjZXYTVCt90=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8C444E0EC453B1428BA516BB657C6928@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d4fcbc-8ab9-4069-84fc-08d6fbdeadd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:38:33.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5936
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> The functionality is identical to the one currently open coded in
> device-dax.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/dax/dax-private.h |  4 ----
>  drivers/dax/device.c      | 43 ---------------------------------------
>  2 files changed, 47 deletions(-)

DanW: I think this series has reached enough review, did you want
to ack/test any further?

This needs to land in hmm.git soon to make the merge window.

Thanks,
Jason
