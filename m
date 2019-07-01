Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B766B54DE3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfFYLoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 07:44:34 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:23750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfFYLod (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 07:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5g/kXs53cyAU/0l6biTfPEBGQO4pWzyaBiiFsCrnwQ=;
 b=P5BHz3RmliJy0oSxBWbLono/6B0JZ4yTq07dKrkzyH4DvRzC+vmRuo7ABmDLYuzmqYGIBgNnOwUlJ6V9IMczIyKB3vaZiwSEfc/D54nWznYH6/jgYg9Wg4YL7dyQk9TOqxPHWDqccjKJ3LGRtUW2TQPLsgoWWADBUC01t4IHTRI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6429.eurprd05.prod.outlook.com (20.179.27.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 11:44:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 11:44:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
Thread-Index: AQHVIcyVeqgMzBs0VkumwilsEzSkhqak+JsAgAcTLYCAAEdIAA==
Date:   Tue, 25 Jun 2019 11:44:28 +0000
Message-ID: <20190625114422.GA3118@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190620192648.GI12083@dhcp22.suse.cz>
 <20190625072915.GD30350@lst.de>
In-Reply-To: <20190625072915.GD30350@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:208:134::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [209.213.91.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e4dfbc-5b01-4b89-e89c-08d6f9627a81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6429;
x-ms-traffictypediagnostic: VI1PR05MB6429:
x-microsoft-antispam-prvs: <VI1PR05MB6429E15F0940959724D7B61CCFE30@VI1PR05MB6429.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(2906002)(52116002)(54906003)(8676002)(53936002)(5660300002)(11346002)(81166006)(81156014)(68736007)(66446008)(66946007)(71200400001)(478600001)(305945005)(66476007)(3846002)(6116002)(14454004)(36756003)(73956011)(1076003)(256004)(71190400001)(446003)(76176011)(486006)(316002)(7416002)(6512007)(66556008)(7736002)(64756008)(33656002)(86362001)(4326008)(6246003)(476003)(186003)(2616005)(8936002)(102836004)(26005)(6486002)(66066001)(386003)(6506007)(6436002)(229853002)(6916009)(25786009)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6429;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KvSArAdb6oF3ia/u73x5Rm05QnQCPBHemQrCRtpJGi8yD5h29saYmk9PT1xbrEAZJ9dPKmR+komLg+x3ZVv13yfbRnfb/cwtQ6ECdT6g5lhognBgTrUp3dW/dJMkl647bq2tpjh/ons35mu7BhmlmYoqCkfNz5XAdd7veZBiiWMwA54isp3xfz1ynXyrTmeoXcyWM4WksZzPetHcj3BtpHWkCYpxcBA3Hx3W8PMYKy1DAIveWea2oz4yjrnhztNCOPDAGng0NdfI7wuv0SBA1iZ4bf6l/58enmEryLl4O/byyEqMPxpoI0P3xJt9UMgOCwm0Qt8WR9FftnHAdcP92IdBa4mKsSsvO9UGTWsWapNf8KPFJK+ZiYGjddLsEtodSeB8kv9lcKcF4R+hXZfuNErpQPQNV62z/y1X1PA7qis=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9099450B868E3548B355AC3B0AFD1F5E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e4dfbc-5b01-4b89-e89c-08d6f9627a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 11:44:28.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6429
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 09:29:15AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 20, 2019 at 09:26:48PM +0200, Michal Hocko wrote:
> > On Thu 13-06-19 11:43:21, Christoph Hellwig wrote:
> > > The code hasn't been used since it was added to the tree, and doesn't
> > > appear to actually be usable.  Mark it as BROKEN until either a user
> > > comes along or we finally give up on it.
> >=20
> > I would go even further and simply remove all the DEVICE_PUBLIC code.
>=20
> I looked into that as I now got the feedback twice.  It would
> create a conflict with another tree cleaning things up around the
> is_device_private defintion, but otherwise I'd be glad to just remove
> it.
>=20
> Jason, as this goes through your tree, do you mind the additional
> conflict?

Which tree and what does the resolution look like?

Also, I don't want to be making the decision if we should keep/remove
DEVICE_PUBLIC, so let's get an Ack from Andrew/etc?

My main reluctance is that I know there is HW out there that can do
coherent, and I want to believe they are coming with patches, just
too slowly. But I'd also rather those people defend themselves :P

Thanks,
Jason
