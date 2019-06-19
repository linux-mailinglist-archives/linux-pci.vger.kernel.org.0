Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CC4B4E2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfFSJ0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:26:46 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:19984
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbfFSJ0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 05:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9ItmWQDiJJHa5+DkLVqUuosoE98FzbN8YNeUQ7WMOc=;
 b=kDDWaVlYCvxnuRWaONM/6CTMGsDJtCKVyMNCiHCXI9I8y8Je+D3fkBT302q+VmjTRIKIcOuMapWvkIYuc+ziE1pOW3FZRuXSkC6r4GR9Xj2KQKyCa5lgiiOwNjF2CghhjyX//cpIUoqWBcNj/WmfXlSSUsAW5iif/zkNz5rLzqY=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1226.namprd12.prod.outlook.com (10.168.237.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 09:26:42 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 09:26:42 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVENrAIbhQsiyOFUOZb1bo56N8nKaiClGAgAADNICAADIUgIAAoOGA
Date:   Wed, 19 Jun 2019 09:26:42 +0000
Message-ID: <49c98e2d-1daf-426c-5ccb-0ee3ab3f89c6@amd.com>
References: <20190522201252.2997-1-logang@deltatee.com>
 <20190618204007.GB110859@google.com>
 <69724119-5037-000c-a711-856703c60429@deltatee.com>
 <71daf07c-f1a4-806c-a24d-80e97aef19d0@deltatee.com>
In-Reply-To: <71daf07c-f1a4-806c-a24d-80e97aef19d0@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR0P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::33) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75fa7098-df16-4ee3-920b-08d6f4983d34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1226;
x-ms-traffictypediagnostic: DM5PR12MB1226:
x-microsoft-antispam-prvs: <DM5PR12MB1226FB487E7752A15657439083E50@DM5PR12MB1226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(7736002)(64756008)(66476007)(2906002)(68736007)(256004)(86362001)(446003)(102836004)(386003)(31686004)(53546011)(65806001)(31696002)(2616005)(476003)(66556008)(6116002)(186003)(52116002)(99286004)(65956001)(65826007)(81156014)(486006)(81166006)(72206003)(6506007)(8676002)(478600001)(316002)(6486002)(64126003)(6436002)(76176011)(11346002)(305945005)(5660300002)(6246003)(229853002)(14454004)(58126008)(4326008)(25786009)(110136005)(71200400001)(46003)(66446008)(36756003)(53936002)(71190400001)(6512007)(66946007)(8936002)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1226;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Tx1LHpR1vCl3aku8Gi+7005jTe673EtQZBcMgekIqdRKSIXoMu1uHIBcEr+DylKZp3+PgQjVtzxz0JuHlSOv7+Pfec0fA1Sd7o4XLew9vpdxT/wCl8tpvkelDhy/EKkLH09UVU4Cr/iFgQME/LJ60mu15cIfllUm/cUkAm/ehJ9IArABUh4FqGknB1QTwfqTK/+kcgVaXBDJJUS/UPY5NlkJDsoRGY8Kh8FKcWWtkEIntWJEpcBQvjEGDo0id+uGROU/rKptWrkBls8mhKwkjwCic+N03VVlilMYkaWPS2iwTJ8T53ekCWzGCop2bUO+RxyrV0iqMz4vQkLv1f+SykvM/4PCJC/CqwP9M8kxgtmBmq7ShRqMNNb7Ens3rvIb7EqZJ7FKO24Q6/N5sZY8K9T6sIiYDH63b3yxloThFA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6388107172853D44900944A1F58B6F03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fa7098-df16-4ee3-920b-08d6f4983d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 09:26:42.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMTkuMDYuMTkgdW0gMDE6NTAgc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+DQo+IE9uIDIw
MTktMDYtMTggMjo1MSBwLm0uLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiAyMDE5LTA2
LTE4IDI6NDAgcC5tLiwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4+PiBPbiBXZWQsIE1heSAyMiwg
MjAxOSBhdCAwMjoxMjo1MlBNIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4+IFBy
ZXNlbnRseSwgdGhlcmUgaXMgbm8gcGF0aCB0byBETUEgbWFwIFAyUERNQSBtZW1vcnksIHNvIGlm
IGEgVExQDQo+Pj4+IHRhcmdldGluZyB0aGlzIG1lbW9yeSBoaXRzIHRoZSByb290IGNvbXBsZXgg
YW5kIGFuIElPTU1VIGlzIHByZXNlbnQsDQo+Pj4+IHRoZSBJT01NVSB3aWxsIHJlamVjdCB0aGUg
dHJhbnNhY3Rpb24sIGV2ZW4gaWYgdGhlIFJDIHdvdWxkIHN1cHBvcnQNCj4+Pj4gUDJQRE1BLg0K
Pj4+Pg0KPj4+PiBTbyB1bnRpbCB0aGUga2VybmVsIGtub3dzIHRvIG1hcCB0aGVzZSBETUEgYWRk
cmVzc2VzIGluIHRoZSBJT01NVSwNCj4+Pj4gd2Ugc2hvdWxkIG5vdCBlbmFibGUgdGhlIHdoaXRl
bGlzdCB3aGVuIGFuIElPTU1VIGlzIHByZXNlbnQuDQo+Pj4+DQo+Pj4+IFdoaWxlIHdlIGFyZSBh
dCBpdCwgcmVtb3ZlIHRoZSBjb21tZW50IG1lbnRpb25pbmcgZnV0dXJlIHdvcmsNCj4+Pj4gdG8g
YWRkIGEgd2hpdGUgbGlzdC4NCj4+PiBUaGVyZSB3YXMgYSBsb3Qgb2YgZGlzY3Vzc2lvbiBhYm91
dCB0aGlzLiAgRGlkIGV2ZXJ5Ym9keSBjb21lIHRvIGENCj4+PiBjb25zZW5zdXMgYWJvdXQgd2hh
dCBzaG91bGQgYmUgZG9uZT8gIENhbiB5b3UgcG9zdCBhIHBhdGNoIHdpdGgNCj4+PiByZXZpZXdl
ZC1ieSBpZiBhcHByb3ByaWF0ZT8NCj4+IEkgdGhpbmsgd2UgaGF2ZSBjb25zZW5zdXMgdGhhdCBp
dCdzIGJyb2tlbiBhbmQgbmVlZHMgdG8gYmUgZml4ZWQgZm9yIHRoZQ0KPj4gc2hvcnQgdGVybS4g
UHJlZmVyYWJseSBiZWZvcmUgNS4zLg0KDQpZZWFoLCBjb21wbGV0ZWx5IGFncmVlLg0KDQo+PiBJ
J20gbm90IHN1cmUgd2UgaGF2ZSBjb25zZW5zdXMgb24gdGhlDQo+PiBwcm9wZXIgZml4Lg0KPj4N
Cj4+IFRoZSB0d28gZWFzeSB0aGluZ3MgSSBjYW4gc2VlIHRvIGRvIGlzIHRvIGVpdGhlciByZXZl
cnQgaXQgb3IgYWRkIHRoZQ0KPj4gaW9tbXVfaXNfcHJlc2VudCgpIGNoZWNrIHRoYXQgSSBkaWQg
aW4gdGhlIGFib3ZlIHBhdGNoLg0KPj4NCj4+IEBDaHJpc3RpYW4sIHdoaWNoIGRvIHlvdSBwcmVm
ZXI/IEkgdGhpbmsgSSdkIHByZWZlciB0aGUNCj4+IGlvbW11X2lzX3ByZXNlbnQoKSByb3V0ZSBh
cyBpdCBtYWludGFpbnMgdGhlIGluZm9ybWF0aW9uIGFib3V0DQo+PiB3aGl0ZS1saXN0ZWQgZGV2
aWNlcyBhbmQgaXMgZWFzaWVyIHRvIGNoYW5nZSBvbmNlIHdlIGhhdmUgdGhlIGNvcnJlY3QNCj4+
IHNvbHV0aW9uLg0KDQpZb3VyIG9yaWdpbmFsIGlvbW11X2lzX3ByZXZlbnQoKSBwYXRjaCBzb3Vu
ZCBsaWtlIHRoZSBiZXN0IG9wdGlvbiBzbyBmYXIuDQoNCklmIHRoYXQgaGFzbid0IGNoYW5nZWQg
ZmVlbCBmcmVlIHRvIGFkZCBhIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIA0KPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gdG8gdGhhdCBvbmUuDQoNCj4+IEkgY2FuIHNlbmQgYSBwYXRj
aCB0b21vcnJvdyBvbmUgd2F5IG9yIGFub3RoZXIuDQo+IEFsc28sIGxvb2tzIGxpa2Ugb25lIG9m
IG15IGNsaWVudHMgaGFzIGFuIGludGVyZXN0IGluIHNlZWluZyB3b3JrIGxpa2UNCj4gdGhpcyBo
YXBwZW4uIFNvIEknbGwgYmUgd3JpdGluZyBzb21lIHBhdGNoZXMgaW4gdGhlIG5leHQgY291cGxl
IHdlZWtzIHRvDQo+IGRvIHRoaXMgcHJvcGVybHkuIEknbGwgdHJ5IHRvIHNlbmQgdGhlbSB0byB0
aGUgbGlzdHMgZWFybHkgbmV4dCBjeWNsZS4NCg0KT2gsIG5pY2UuDQoNCkkgd2FzIGhvcGluZyB0
byBnZXQgbXkgdXNlIGNhc2UgaW50byA1LjQgb3IgNS41LCBidXQgd2UgYXJlIHN0aWxsIHN0dWNr
IA0Kd2l0aCBzb21lIG9mIHRoZSBETUEtYnVmIHJlbGF0ZWQgcGllY2VzLg0KDQpSZWdhcmRzLA0K
Q2hyaXN0aWFuLg0KDQo+DQo+IExvZ2FuDQoNCg==
