Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5C43858
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfFMPFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:05:18 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:29637
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732455AbfFMOQf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 10:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRCtqGzjhJOBLRtVX0V/ZgSTkU8/jdLSuxxED8NJUIc=;
 b=TvGnXbEcjU6Lo/7/fJyphO+gcrunapqxGdLz+M17V8Za/VtKbSX2UybpfN/j0jOX9sC6Lm2xBxEh49cE0w5ymm9p5MQ2sS9TfXQk7dgCrfXyzRlkaSiH5uYLLNWjzlj4HWhvmzR09mBLA4vwuj9bks2IyeyCyk+IavPI2sL/+T0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4783.eurprd05.prod.outlook.com (20.176.4.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 14:16:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 14:16:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups
Thread-Topic: dev_pagemap related cleanups
Thread-Index: AQHVIcx5DdVrUhs/HUiF5V2FmmsvzKaZoY4A
Date:   Thu, 13 Jun 2019 14:16:27 +0000
Message-ID: <20190613141622.GE22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce498060-eaaa-4cfc-43b2-08d6f009b931
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4783;
x-ms-traffictypediagnostic: VI1PR05MB4783:
x-microsoft-antispam-prvs: <VI1PR05MB47836CBE2730DE9B4A14468FCFEF0@VI1PR05MB4783.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(26005)(53936002)(81166006)(99286004)(52116002)(6486002)(7736002)(36756003)(305945005)(33656002)(6116002)(2906002)(6512007)(6436002)(229853002)(6506007)(478600001)(14454004)(3846002)(81156014)(8676002)(316002)(386003)(186003)(102836004)(76176011)(66446008)(486006)(2616005)(66556008)(476003)(86362001)(68736007)(54906003)(446003)(7416002)(11346002)(64756008)(1076003)(8936002)(5660300002)(71190400001)(6916009)(7116003)(71200400001)(66066001)(4326008)(66476007)(6246003)(73956011)(66946007)(256004)(25786009)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4783;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V7MYS+Xi0yuEwrWiqQdFEyNmIo52ph6edRuO4tk6AgYuo0b1aNnoJUgJdJqY5OPp4z215xdSTIlif805KjTtwoDOCuQP1/9ok+E9ptw226a2wqHVsoDym8cU0BN91wSMfVOXKRek3zPXyZb9qhv022St0teR3Q7xiN1Ey+EgDtjktRjj7eyfPmSIEEQlR/j2pU5iBJDYEbJPX5zNx/rHf3Y9mW0Tfxat4lpIjDoEtlWlW6ETGh76wNSMBwBD+DPQwBTiiBueMm/wuC1Fj+LteWMELDHyIfiZDpZfwJ10/BIGmUIvXpKK5oEPjUqMazcbnVtK340VjdMxLPoD9di01Ku0wuSQafzVeLQ3c31x5f5B8aNtFynOUa4Gx3J12rS/WpKzcwm/1VF+kS/8oMXw9oAdlXksbr9nZCIzWk7EdFA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F56F1D2ECF2EA44ADBAB2BD95ADFE6F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce498060-eaaa-4cfc-43b2-08d6f009b931
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 14:16:27.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4783
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMTE6NDM6MDNBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+IEhpIERhbiwgSsOpcsO0bWUgYW5kIEphc29uLA0KPiANCj4gYmVsb3cgaXMg
YSBzZXJpZXMgdGhhdCBjbGVhbnMgdXAgdGhlIGRldl9wYWdlbWFwIGludGVyZmFjZSBzbyB0aGF0
DQo+IGl0IGlzIG1vcmUgZWFzaWx5IHVzYWJsZSwgd2hpY2ggcmVtb3ZlcyB0aGUgbmVlZCB0byB3
cmFwIGl0IGluIGhtbQ0KPiBhbmQgdGh1cyBhbGxvd2luZyB0byBraWxsIGEgbG90IG9mIGNvZGUN
Cg0KRG8geW91IHdhbnQgc29tZSBvZiB0aGlzIHRvIHJ1biB0aHJvdWdoIGhtbS5naXQ/IEkgc2Vl
IG1hbnkgcGF0Y2hlcw0KdGhhdCBkb24ndCBzZWVtIHRvIGhhdmUgaW50ZXItZGVwZW5kZW5jaWVz
Li4NCg0KVGhhbmtzLA0KSmFzb24NCg==
