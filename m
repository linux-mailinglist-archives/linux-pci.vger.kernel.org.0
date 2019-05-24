Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B629831
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfEXMlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 08:41:00 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:50914
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391025AbfEXMlA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVObh2EP5WQMcOAeNpirKUMrs6ETdvF/vMx/VyJjMQo=;
 b=J6GaCZaaQHP2IObog9lyQw4z0CvBPo+PCEkiK9BHG2XKMOG0M5cooSOUPeziaRQkjYj+xr2UPcU3EdBa2Vodl/JnUZSJbytO5ExcxhUMa/ButdK3/3BUfXGMHpei+nOq4/I08Ey0V5a2gqi8EamNzcuH5NOxZeoHnlhH1X4ULsY=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1643.namprd12.prod.outlook.com (10.172.40.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 24 May 2019 12:40:57 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5%7]) with mapi id 15.20.1922.018; Fri, 24 May 2019
 12:40:57 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVEN0qInr5CdI4G0a9LdC26elwGqZ3m6wAgADBDACAABl5AIAAAXQAgAAAqoCAAGVngIAAAYgAgAFa3oA=
Date:   Fri, 24 May 2019 12:40:57 +0000
Message-ID: <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
 <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
 <20190523155922.GA21552@lst.de>
In-Reply-To: <20190523155922.GA21552@lst.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de33ebab-37fd-4c91-a37b-08d6e0451169
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1643;
x-ms-traffictypediagnostic: DM5PR12MB1643:
x-microsoft-antispam-prvs: <DM5PR12MB1643E56A90FF8720582BB5A283020@DM5PR12MB1643.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(486006)(6436002)(65826007)(229853002)(71200400001)(71190400001)(6486002)(14454004)(53936002)(68736007)(99286004)(186003)(52116002)(2616005)(65806001)(66476007)(25786009)(66946007)(73956011)(72206003)(476003)(65956001)(64756008)(66446008)(66556008)(86362001)(11346002)(478600001)(31696002)(64126003)(316002)(46003)(58126008)(446003)(8676002)(4326008)(7736002)(36756003)(8936002)(81156014)(305945005)(386003)(6116002)(110136005)(31686004)(76176011)(5660300002)(6246003)(81166006)(54906003)(6506007)(102836004)(6512007)(256004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1643;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0yBQxrQgdbZWdsMH1Ujr3CC4v3PPhGZZ1A0nQr9FgYrTxdeMSsXGptbXcfubBGIYL3AGODtjrzLSPNleZtsXL9O6YTmQnHODYGvTuDrePv6YzrOusIvmjTD1P5kE3B4xUx59IyHHg45jy0ZxURxKZReE2ieLXDOMhAYSqNGBknpFrjf0J1GGyF7klo5Ew69RkMJcp/2TwTMDMxSR2LRcZGI6WDDKlu7UVDqlxpM6h3IUjvbYp7hmJg8bWZ6ZNKC0pWJiDQgsMW3KRhu6kIqS8Yvdmp/jl9IH3C+bEOuMeBvoSsBN9hKw1azZB/aWqvAnKTj8cZ5wd/uqFLwQ4dexkUegarO5q6b9BRoB7npZs+Q7wJY4oHWcu4mWmc8hkVz6wuTxdqjZPeV/TSncQpvuxZ4F0STEwxNAEFuVKkusX3o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BA6C33C1E836045A7AAE848979F50DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de33ebab-37fd-4c91-a37b-08d6e0451169
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 12:40:57.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjMuMDUuMTkgdW0gMTc6NTkgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gW0NBVVRJ
T046IEV4dGVybmFsIEVtYWlsXQ0KPg0KPiBPbiBUaHUsIE1heSAyMywgMjAxOSBhdCAwOTo1Mzo1
M0FNIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gVGhlIHByb2JsZW0gc2hvd3Mg
dXAgaWYgcGNpX2J1c19hZGRyZXNzKCkgcmV0dXJucyBhIGRpZmZlcmVudCBhZGRyZXNzDQo+Pj4g
dGhhbiBwY2lfcmVzb3VyY2Vfc3RhcnQoKSwgc2hvdWxkIGJlIGVhc3kgdG8gY2hlY2sgaWYgdGhh
dCBoYXBwZW5zLg0KPj4+IElJUkMgaXQgaXMgc29tZXRoaW5nIG1vc3RseSBzZWVuIG9uIGVtYmVk
ZGVkIFNPQ3MuDQo+Pj4NCj4+IEkgdGhpbmsgaXQncyBhIGJpdCBtb3JlIGNvbXBsaWNhdGVkIHRo
ZW4gdGhhdDogSWYgeW91J3JlIGNhbGxpbmcNCj4+IGRtYV9tYXBfcmVzb3VyY2UoKSB0byBwcm9n
cmFtIHRoZSBJT01NVSB0aGVuIEknbSBwcmV0dHkgc3VyZSB5b3UnZCB3YW50DQo+PiB0byB1c2Ug
dGhlIHBjaV9yZXNvdXJjZV9zdGFydCgpIGFkZHJlc3MgYXMgdGhlIHBoeXNfYWRkcl90LiBJZiB5
b3UncmUNCj4+IGJ5cGFzc2luZyB0aGUgcm9vdCBjb21wbGV4IChsaWtlIHRoZSBjdXJyZW50IHAy
cGRtYSBjb2RlIGVuZm9yY2VzKSwgdGhlbg0KPj4geW91J2Qgc2ltcGx5IHVzZSBhIHBjaV9idXNf
YWRkcmVzcygpIGRpcmVjdGx5IGFzIHRoZSBkbWFfYWRkciBhbmQgd291bGQNCj4+IG5vdCBwcm9n
cmFtIHRoZSBJT01NVSBhdCBhbGwgc2VlaW5nIGl0J3Mgbm90IGludm9sdmVkICh3aGljaCBpcyB3
aGF0IGlzDQo+PiBjdXJyZW50bHkgZG9uZSkuDQo+IFRydWUuICBXaGF0IHdlIG5lZWQgaXM6DQo+
DQo+ICAgaWYgKGJvdGggZGV2aWNlIGFyZSBiZWhpbmQgdGhlIHNhbWUgcm9vdCBwb3J0ICh1c2lu
ZyBhIHN3aXRjaCkpIHsNCj4gICAgICAgICAgdXNlIHRoZSBjdXJyZW50IGRpcmVjdCBtYXAgKyBv
ZmZzZXQgY29kZQ0KPiAgIH0gZWxzZSB7DQo+ICAgICAgICAgIGNhbGwgLT5tYXBfcmVzb3VyY2Uo
KQ0KPiAgIH0NCg0KU291bmRzIHNhbmUgdG8gbWUgYXMgd2VsbC4NCg0KQnV0IHNpbmNlIEkgZG9u
J3QgaGF2ZSBhIHN0cnVjdCBwYWdlcyBiYWNraW5nIG15IFBDSSBCQVIgSSB3b24ndCBiZSBhYmxl
IA0KdG8gdXNlIHBjaV9wMnBkbWFfbWFwX3NnLg0KDQpIb3cgc2hvdWxkIHdlIHdvcmsgYXJvdW5k
IHRoYXQ/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQo=
