Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C918044C87
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFMToi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:44:38 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:44263
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfFMToh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 15:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvLGFdjYPSk5owAJMGCDMH03XFP7/53cVwVq6hBPuFo=;
 b=Ed2cJ/+YMNQ3gMgiL3hYsSLPcHfBcQYG5pSN5f6NxLHXfl3Kshr/DJnditakIoT/ustedGYwn3//KKVkqICj+Pd0TRdwHct9MtBrzsWRsbfQawdAu8Kyy5FT+mgxeiSwElMrMLFDN0jKOqHS050xEntjV2cZiWJtmqmx4VPiS6s=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5006.eurprd05.prod.outlook.com (20.177.52.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:44:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:44:34 +0000
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
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Topic: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Index: AQHVIcyVeqgMzBs0VkumwilsEzSkhqaZ/TwA
Date:   Thu, 13 Jun 2019 19:44:34 +0000
Message-ID: <20190613194430.GY22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de>
In-Reply-To: <20190613094326.24093-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7181fa22-98f5-48dc-e792-08d6f0378f5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5006;
x-ms-traffictypediagnostic: VI1PR05MB5006:
x-microsoft-antispam-prvs: <VI1PR05MB500620CDF68041957CED00D4CFEF0@VI1PR05MB5006.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(11346002)(33656002)(52116002)(486006)(99286004)(76176011)(7416002)(386003)(229853002)(2906002)(66066001)(102836004)(6506007)(54906003)(3846002)(6512007)(6916009)(6436002)(6486002)(186003)(26005)(476003)(446003)(2616005)(6116002)(36756003)(305945005)(64756008)(316002)(66446008)(8676002)(66556008)(66476007)(25786009)(68736007)(73956011)(5660300002)(66946007)(4326008)(81166006)(86362001)(7736002)(81156014)(14454004)(6246003)(8936002)(71200400001)(53936002)(478600001)(71190400001)(256004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5006;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8o9AX6DKSupLoEBQPmNIAeDs0XsDzxWMu1ammaJCRZ4m0UtQkAp+mB9y3YXFw/KeMRqnlGJbmEkNS4Y1L55k+k28Axlvfg0OrC4JK371fZPUrZryDeShbLSLDLA7Oc5N8TWLi5lVvi120e+sDYIcCAPG+nMAqZ6OU0JcG6hpi4WpHdKfyZGHr2AMLp6V4ujTgRGRdotEDx/rdKJ3YC3pPwR6003PEgwgxKGyhVRsc3am/dDh/AO1Sy9weZniqKAdm+jfIU1lCdDFZdZyt1n75f1xwPd0uxiB335X0DZ7IcVL5VXGr2wPd12e/cGHxrRzso9KQMQs5neAeUu0/EdtT471kVIGagmjFgO/zeNLmx4RLbLPtKJEniKqapVzgxA16XfDryJb8ZhUt+0n7Lz7IV9KbJik/jVSlbJOjAPSopg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D44695B53F740940B0050C945B58AD6F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7181fa22-98f5-48dc-e792-08d6f0378f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:44:34.1111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5006
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:21AM +0200, Christoph Hellwig wrote:
> The code hasn't been used since it was added to the tree, and doesn't
> appear to actually be usable.  Mark it as BROKEN until either a user
> comes along or we finally give up on it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0d2ba7e1f43e..406fa45e9ecc 100644
> +++ b/mm/Kconfig
> @@ -721,6 +721,7 @@ config DEVICE_PRIVATE
>  config DEVICE_PUBLIC
>  	bool "Addressable device memory (like GPU memory)"
>  	depends on ARCH_HAS_HMM
> +	depends on BROKEN
>  	select HMM
>  	select DEV_PAGEMAP_OPS

This seems a bit harsh, we do have another kconfig that selects this
one today:

config DRM_NOUVEAU_SVM
        bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
        depends on ARCH_HAS_HMM
        depends on DRM_NOUVEAU
        depends on STAGING
        select HMM_MIRROR
        select DEVICE_PRIVATE
        default n
        help
          Say Y here if you want to enable experimental support for
          Shared Virtual Memory (SVM).

Maybe it should be depends on STAGING not broken?

or maybe nouveau_svm doesn't actually need DEVICE_PRIVATE?

Jason
