Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C17279AB
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEWJso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 05:48:44 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:20300
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbfEWJso (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 05:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFCyPuju4hzAuvf426SzEEOJj47oH3JGvO0EuNojX8E=;
 b=IjiDUZyt1wRR7g+6actgPFe3OyvsLZ4rOTRZrtYq8wCEHV9zmzV8d6VpTHnwEMZ8myfAsFjqviYpPb6uu2VzKJEJ3uGRcJx98h7swcpcz91HmmyJ9VyeUQrkTvwfrVCV6a0Ev/Ct/qVbA7pVAIh6CyKNLFNqVOP+3Hrf6uuKM8A=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2567.namprd12.prod.outlook.com (52.132.141.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 23 May 2019 09:48:41 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5%7]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 09:48:41 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVEN0qInr5CdI4G0a9LdC26elwGqZ3m6wAgADBDACAABl5AIAAAXQA
Date:   Thu, 23 May 2019 09:48:40 +0000
Message-ID: <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
In-Reply-To: <20190523094322.GA14986@lst.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P192CA0080.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::21) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dceca71-21b9-4e72-4542-08d6df63d626
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2567;
x-ms-traffictypediagnostic: DM5PR12MB2567:
x-microsoft-antispam-prvs: <DM5PR12MB2567A897774CB8126BE8261F83010@DM5PR12MB2567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(39860400002)(346002)(199004)(189003)(65826007)(81156014)(486006)(14454004)(68736007)(36756003)(73956011)(8676002)(4326008)(81166006)(476003)(2616005)(66446008)(64756008)(66556008)(66476007)(102836004)(66946007)(8936002)(65806001)(386003)(6506007)(58126008)(6436002)(316002)(53936002)(5660300002)(25786009)(65956001)(64126003)(305945005)(6486002)(31696002)(46003)(31686004)(54906003)(6916009)(86362001)(76176011)(6246003)(99286004)(229853002)(446003)(7736002)(2906002)(6116002)(52116002)(11346002)(71200400001)(71190400001)(72206003)(478600001)(6512007)(14444005)(186003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2567;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j/13GBDJ6sC6YO49q5T/L2EVVfBRSZmuMTW+FQhhigion58cAitsy8w27Gou0NbkLviTbIvAuyL5mFXXLywK1FfEjO4GAE+RGnBvM4iAV/lt5ba/iQ0fkY0sbrGHS3qzOSstYB1a5ADGQOwXFoWwreBJguaiMl7ul0SJhaIDa0Zy4lk6Hz4TlkIVdhTrS2MnlH6Qx+KhDKmaGpeNmePSRQwpscead2jEmiOQo1BqvvDHrURrYi8ansPRybKRji6KxI1ry77gbUfUbsz8PUvMLNiHA26hn11H4XfEF5sJR44Vsj2sWzLtq2Y1/D3U+Q2gLcF+/hN5+iHKlDq6M0CWFAi2hVlak6nIM/DZQtLvFNEpRJROiQlqB8acT8EV5ySUogetm+vtN/zoUzZ9YYPpbtbScWuLRxKWbKcwt66cpA4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCDA9B9FF61123498773337A932FE07A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dceca71-21b9-4e72-4542-08d6df63d626
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 09:48:40.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjMuMDUuMTkgdW0gMTE6NDMgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gW0NBVVRJ
T046IEV4dGVybmFsIEVtYWlsXQ0KPg0KPiBPbiBUaHUsIE1heSAyMywgMjAxOSBhdCAwODoxMjox
OEFNICswMDAwLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+PiBBcmUgeW91IERNQS1tYXBw
aW5nIHRoZSBhZGRyZXNzZXMgb3V0c2lkZSB0aGUgUDJQRE1BIGNvZGU/IElmIHNvIHRoZXJlJ3MN
Cj4+PiBhIGh1Z2UgbWlzbWF0Y2ggd2l0aCB0aGUgZXhpc3RpbmcgdXNlcnMgb2YgUDJQRE1BIChu
dm1lLWZhYnJpY3MpLiBJZg0KPj4+IHlvdSdyZSBub3QgZG1hLW1hcHBpbmcgdGhlbiBJIGNhbid0
IHNlZSBob3cgaXQgY291bGQgd29yayBiZWNhdXNlIHRoZQ0KPj4+IElPTU1VIHNob3VsZCByZWpl
Y3QgYW55IHJlcXVlc3RzIHRvIGFjY2VzcyB0aG9zZSBhZGRyZXNzZXMuDQo+PiBXZWxsLCB3ZSBh
cmUgdXNpbmcgdGhlIERNQSBBUEkgKGRtYV9tYXBfcmVzb3VyY2UpIGZvciB0aGlzLiBJZiB0aGUg
UDJQDQo+PiBjb2RlIGlzIG5vdCB1c2luZyB0aGlzIHRoZW4gSSB3b3VsZCByYXRoZXIgc2F5IHRo
YXQgdGhlIFAyUCBjb2RlIGlzDQo+PiBhY3R1YWxseSBicm9rZW4uDQo+Pg0KPj4gQWRkaW5nIENo
cmlzdG9waCBhcyB3ZWxsLCBjYXVzZSBoZSBpcyB1c3VhbGx5IHRoZSBvbmUgZGlzY3Vzc2lvbiBz
dHVmZg0KPj4gbGlrZSB0aGF0IHdpdGggbWUuDQo+IEhlaC4gIEFjdHVhbGx5IGRtYV9tYXBfcmVz
b3VyY2UtaXNoIEFQSXMgYXJlIHRoZSByaWdodCB0aGluZyB0byBkbywNCj4gYnV0IEknbSBub3Qg
c3VyZSBob3cgeW91IG1hbmFnZWQgdG8gYmUgYWJsZSB0byB1c2UgaXQgZm9yIFBDSWUgUDJQDQo+
IHlldCwgYXMgaXQgZmFpbHMgdG8gYWNjb3VudCBmb3IgYW55IGRpZmZlcmVuY2UgaW4gdGhlIFBD
SWUgbGV2ZWwNCj4gInBoeXNpY2FsIiBhZGRyZXNzIHdpdGggdGhlIGhvc3RzIHZpZXcgb2YgInBo
eXNpY2FsIiBhZGRyZXNzZXMuDQo+DQo+IERvIHRoZXNlIG9mZnNldHMgbm93IGhvdyB1cCBvbiBB
TUQgcGxhdGZvcm1zPyAgRG8geW91IGFkanVzdCBmb3IgdGhlbQ0KPiBlbHNld2hlcmU/DQoNCkkg
ZG9uJ3QgYWRqdXN0IHRoZSBhZGRyZXNzIG1hbnVhbGx5IGFueXdoZXJlLiBJIGp1c3QgY2FsbCAN
CmRtYV9tYXBfcmVzb3VyY2UoKSBhbmQgdXNlIHRoZSByZXN1bHRpbmcgRE1BIGFkZHJlc3MgdG8g
YWNjZXNzIHRoZSBvdGhlciANCmRldmljZXMgUENJIEJBUi4NCg0KQXQgbGVhc3Qgb24gbXkgdGVz
dCBzeXN0ZW0gKEFNRCBDUFUgKyBBTUQgR1BVcykgdGhpcyBzZWVtcyB0byB3b3JrIA0KdG90YWxs
eSBmaW5lLiBDdXJyZW50bHkgdHJ5aW5nIHRvIGZpbmQgdGltZSBhbmQgYW4gSW50ZWwgYm94IHRv
IHRlc3QgaXQgDQp0aGVyZSBhcyB3ZWxsLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0K
