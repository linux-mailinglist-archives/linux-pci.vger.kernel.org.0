Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D562158718
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0QaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 12:30:02 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:6088
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfF0QaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 12:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUTlgfdID2iRtFCZgVweDp5Qtf+mItNdaN0x/fMGgZs=;
 b=FCgEsLalfRXB4rv9hD0QxS/nthmGlfplI0uu4eJ3CMBFkQ2Bd7YzkRdW+p8gRpkMeGC6OBSQ+POJ9MTepzuc/+EAKH5OnVqI+whx+h24Qw+Rid2rrtIUW6utO9CLzdEdxlI04SsmqIMg8KUBIH0lq9fYbPyWXqFd7/WcsOHb/Fc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6032.eurprd05.prod.outlook.com (20.178.127.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:29:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:29:59 +0000
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
Subject: Re: [PATCH 24/25] mm: remove the HMM config option
Thread-Topic: [PATCH 24/25] mm: remove the HMM config option
Thread-Index: AQHVLBqsRKRxj5FxGkevpNmecZGFtKavsuOA
Date:   Thu, 27 Jun 2019 16:29:59 +0000
Message-ID: <20190627162953.GF9499@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-25-hch@lst.de>
In-Reply-To: <20190626122724.13313-25-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0151b4b8-c186-417a-5d94-08d6fb1cb28f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6032;
x-ms-traffictypediagnostic: VI1PR05MB6032:
x-microsoft-antispam-prvs: <VI1PR05MB603205C1A7792960EECA583DCFFD0@VI1PR05MB6032.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(6512007)(102836004)(5660300002)(7736002)(305945005)(6116002)(486006)(478600001)(476003)(81156014)(256004)(386003)(11346002)(53936002)(76176011)(3846002)(2616005)(52116002)(446003)(81166006)(6436002)(8936002)(68736007)(66066001)(6246003)(316002)(2906002)(54906003)(229853002)(99286004)(36756003)(6486002)(26005)(6506007)(186003)(64756008)(6916009)(8676002)(7416002)(66946007)(4744005)(1076003)(66476007)(14454004)(4326008)(86362001)(66556008)(66446008)(73956011)(71190400001)(71200400001)(25786009)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6032;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9A6iNgq7ZRD14y7lsHP8UnKnqhIiFdeKgjWYA1jatzb8GnGnHiDhk19p0NkDyNq/Gcat5H/okmisOy6TJt9eUby66lOVVov9OqQOHhZrCb7iavtLvtwZQD9yD+Kc87mvHoGEH3mzdRnL4QVIJ2AUVshzNBbsSQNOFogrQebge8LavQESGjw8P2EBLmdflurGmw8JERlr2w/ZGRWw0QDUgxgBEMu+rk/mJEfk6O7kGOoQME52DOYMbaibXgt9vHEGeTbCa092EHjSVLfNGYpX0mRLb4w5ljwewWgyFyYANaYbtuj0yQaTgafTijlOAiwof9ioolGafwfyp901ymvyYNMoAOAHyLw1vTwe/ZKuE+qIso6zWpzkOzkrfPUJsDHzlwk3k7d35w08WNYILJzNFScDslN3Qm7b/nwPZmzkFUo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F6F5CD4C0A7BBA40A1967D61F8AD76F1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0151b4b8-c186-417a-5d94-08d6fb1cb28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:29:59.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6032
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:23PM +0200, Christoph Hellwig wrote:
> All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
> depend on it instead of the mix of a dummy dependency symbol plus the
> actually selected one.  Drop various odd dependencies, as the code is
> pretty portable.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/Kconfig |  3 +--
>  include/linux/hmm.h             |  5 +----
>  include/linux/mm_types.h        |  2 +-
>  mm/Kconfig                      | 27 ++++-----------------------
>  mm/Makefile                     |  2 +-
>  mm/hmm.c                        |  2 --
>  6 files changed, 8 insertions(+), 33 deletions(-)

Makes more sense to me too

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
