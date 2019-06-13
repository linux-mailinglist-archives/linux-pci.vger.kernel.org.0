Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E044BFE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFMTSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:18:40 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:61678
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfFMTSk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 15:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn0XRHQHsCKYYQ7MbFb4+orPe8vwTjckiXF1+JOZDCI=;
 b=JE2ZAoEvKjfR8HiDlxRBnqpf44FucC6/Ut0TOrVfWTFT7Li85DVE4y3CPsTOdE+VgemGpQSSB0Nr8x3zW9S7AL4siG9nHIvDBbbF9diHhAgdny9jlPfnjZAp1hg7R1rWDeb3JtgFIRfmVfpbAeaaMOrEz6F312C7bzLapp/cUEM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6431.eurprd05.prod.outlook.com (20.179.27.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 19:18:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:18:36 +0000
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
Subject: Re: [PATCH 07/22] memremap: move dev_pagemap callbacks into a
 separate structure
Thread-Topic: [PATCH 07/22] memremap: move dev_pagemap callbacks into a
 separate structure
Thread-Index: AQHVIcyDw9xwI/Mm4EyaKLgP+NlRp6aZ9fgA
Date:   Thu, 13 Jun 2019 19:18:36 +0000
Message-ID: <20190613191830.GS22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-8-hch@lst.de>
In-Reply-To: <20190613094326.24093-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5665e8b-42b6-483f-4da2-08d6f033ee8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6431;
x-ms-traffictypediagnostic: VI1PR05MB6431:
x-microsoft-antispam-prvs: <VI1PR05MB643182491356C4DBAF72DD47CFEF0@VI1PR05MB6431.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(71190400001)(186003)(36756003)(11346002)(446003)(71200400001)(14454004)(305945005)(66066001)(6506007)(478600001)(76176011)(53936002)(52116002)(316002)(386003)(81166006)(54906003)(476003)(99286004)(2616005)(102836004)(8936002)(486006)(3846002)(86362001)(6116002)(1076003)(8676002)(558084003)(4326008)(81156014)(66556008)(7736002)(7416002)(66476007)(6916009)(25786009)(2906002)(66946007)(73956011)(66446008)(5660300002)(229853002)(6486002)(26005)(6246003)(64756008)(33656002)(256004)(68736007)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6431;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iWI5spS7w2QJSos+Acyk0mhUS4x786Nzmhq9nBWZJfIgq5mZ00pPuEhRM1QrPO0/A5zugseKUQTlJDUrW2/+LT7LeSgHzpgN5+7ZCWtvzIbO2NhaqLzU+tUqVe3ZsUtbQYbNc27ibTqNCB9tYAo45UYiW+cFlUfB4hdPoZbymAbiACKH3gxd8bKNnswT0IFqMbvSXQkGTbm/QWYVpODtXoMlMy5JLjXgRQxg+6WOTHQmnHTeL+F31uB8QglOIKmDDaKALJaDM1P+2ZEoxcWdlkNLR2+YgB5EdioE4E8qajCC5xLyn5amDP/+anCm9tLY74LjyO9b51ZTQlTBBhzBsk5vV1zsGWXapz3GHeUepGUAEpEaSs/PAy4P4Z9BsTASRcJwDjjou5eaax2Ad3kMg5nguEXxlG1ynhhU1B0IOc4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B5D9BF5FD8C3BF4E8DFA048B14902A45@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5665e8b-42b6-483f-4da2-08d6f033ee8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:18:36.1185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6431
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:10AM +0200, Christoph Hellwig wrote:
> The dev_pagemap is a growing too many callbacks.  Move them into a
> separate ops structure so that they are not duplicated for multiple
> instances, and an attacker can't easily overwrite them.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
