Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345FC44C2F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfFMTeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:34:36 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:28547
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfFMTeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 15:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHKRMNw9g2ihF+kxFu2QxbCGLLD+Dv1zpejuy8kLLZA=;
 b=iUpnm6J9uAc2yjehlZggxWFZYnKjETahRTv9czZSJmRWPzW0c51V9hOVdRyMTHee9htECLtgsjxbSbXXTMK9Qo8zztfp4DzvDNdvYkG9j5XEA3xndXD0rPc3xF4w+ErYDv17IJNFO1S+2JDvJIZa+4wCOKDxz2p2P1kLyObkgUk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4703.eurprd05.prod.outlook.com (20.176.4.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:34:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:34:31 +0000
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
Subject: Re: [PATCH 09/22] memremap: lift the devmap_enable manipulation into
 devm_memremap_pages
Thread-Topic: [PATCH 09/22] memremap: lift the devmap_enable manipulation into
 devm_memremap_pages
Thread-Index: AQHVIcyGh+LZVhNi2EuUux9FsS41VqaZ+m2A
Date:   Thu, 13 Jun 2019 19:34:31 +0000
Message-ID: <20190613193427.GU22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-10-hch@lst.de>
In-Reply-To: <20190613094326.24093-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2344bec2-d78c-4486-b0bc-08d6f0362814
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4703;
x-ms-traffictypediagnostic: VI1PR05MB4703:
x-microsoft-antispam-prvs: <VI1PR05MB4703615FBFE57552FC7A5F3ECFEF0@VI1PR05MB4703.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(43544003)(25786009)(71190400001)(2616005)(316002)(256004)(446003)(71200400001)(68736007)(476003)(11346002)(26005)(99286004)(76176011)(386003)(229853002)(52116002)(66066001)(6116002)(53936002)(3846002)(66946007)(2906002)(6916009)(6506007)(102836004)(6246003)(6436002)(54906003)(66446008)(66556008)(486006)(64756008)(66476007)(14454004)(6486002)(478600001)(73956011)(86362001)(81166006)(305945005)(81156014)(7736002)(8936002)(186003)(5660300002)(7416002)(1076003)(36756003)(4326008)(4744005)(6512007)(8676002)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4703;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2nSk9n4j3C4hJek/u+dZ6x7dV3tjTsGkUY3UXBXRkHKaWJqXhdg8ZS34cQZL7GwgyF5/MSzAJhv2aUAjjtk8CRvLzUVGNduiTuQkZy3Kv+MZPwfJIT90IFGBZ/ZsH3qZoh/CPWzTLkRl4wuE3WtmH20XC331wtkLzLWek4XEe0R+LNOkx+Hp/SCi2uxUbb7ts65BsfUxQNVpaOPGaYiTXZ2cklEw1b8NCzBt7dR1vWFs9sxDlNJ47eMYM+Bo+bdfGOd5g+9egoEaH5hhoSSUEnB25YzaoPWpks/1OJjOwTG1qouPEkgHuHQomu5+xxWhDy/fHuXrTHWkWiYva0Hxy3ILfkB1RQoRgbijiJvrA35MkyYBW3WSRajPXlSEBpJNXi4TzI+dMNkmRB5ftUjxHXdrJM09OJwhUKDw/JKjuRo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2494E1C39D43164DA0596E93A4038E37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2344bec2-d78c-4486-b0bc-08d6f0362814
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:34:31.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4703
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:12AM +0200, Christoph Hellwig wrote:
> Just check if there is a ->page_free operation set and take care of the
> static key enable, as well as the put using device managed resources.
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c76a1b5defda..6dc769feb2e1 100644
> +++ b/mm/hmm.c
> @@ -1378,8 +1378,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_=
devmem_ops *ops,
>  	void *result;
>  	int ret;
> =20
> -	dev_pagemap_get_ops();
> -

Where was the matching dev_pagemap_put_ops() for this hmm case? This
is a bug fix too?

The nouveau driver is the only one to actually call this hmm function
and it does it as part of a probe function.=20

Seems reasonable, however, in the unlikely event that it fails to init
'dmem' the driver will retain a dev_pagemap_get_ops until it unloads.
This imbalance doesn't seem worth worrying about.

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jason
