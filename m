Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A76277BA
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfEWIMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 04:12:22 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:27713
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfEWIMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 04:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox1Olqo2wH12CS1agPlKZPH000DxlZu3F1E2w+bl8pI=;
 b=jDvfvpOdGaEWb2yGnuMo/k/jURGpUMay5H2q2J/20c32RxQ0eOZ08PSCwsb1HTtcu/5mjPKjzKv+/yMFGTYBwjTqlXegnnx3nIavnFSfcv+npDDo/Sbr6+Zo7ueq5IPxdzG5aJuzjFsuWXxg3FgVZQNjJ2WQ8cJxBqucUrj2scM=
Received: from CY4PR12MB1543.namprd12.prod.outlook.com (10.172.70.20) by
 CY4PR12MB1751.namprd12.prod.outlook.com (10.175.62.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 08:12:19 +0000
Received: from CY4PR12MB1543.namprd12.prod.outlook.com
 ([fe80::c43a:8684:a852:2124]) by CY4PR12MB1543.namprd12.prod.outlook.com
 ([fe80::c43a:8684:a852:2124%7]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 08:12:19 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVEN0qInr5CdI4G0a9LdC26elwGqZ3m6wAgADBDAA=
Date:   Thu, 23 May 2019 08:12:18 +0000
Message-ID: <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
In-Reply-To: <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P192CA0007.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::20) To CY4PR12MB1543.namprd12.prod.outlook.com
 (2603:10b6:910:c::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35b33058-dc9f-4b3f-e127-08d6df565fbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1751;
x-ms-traffictypediagnostic: CY4PR12MB1751:
x-microsoft-antispam-prvs: <CY4PR12MB175109FB7ED91279D0EE0B9483010@CY4PR12MB1751.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(316002)(64126003)(52116002)(305945005)(86362001)(7736002)(76176011)(2906002)(53936002)(54906003)(14444005)(31686004)(486006)(6116002)(5660300002)(53546011)(256004)(8676002)(65956001)(31696002)(386003)(81156014)(81166006)(110136005)(99286004)(58126008)(8936002)(65806001)(6506007)(73956011)(66946007)(25786009)(446003)(66476007)(4326008)(229853002)(11346002)(102836004)(186003)(66446008)(64756008)(66556008)(46003)(6486002)(71190400001)(6246003)(36756003)(2616005)(6436002)(65826007)(68736007)(6512007)(14454004)(71200400001)(476003)(72206003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1751;H:CY4PR12MB1543.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tBpGvKItlj4d1MFnLjh5v+bHtV/ZyDn6LaowlsbOFuH/MoGf/llWqLCt1+8uA2xYKm015m3IkeW4bU2iapAJOvMoLZ4cvwk2IxBsdoHqvalRMKrV6FV+9DDUvO1F0xW5HqzA1PSocBTLqrJwX87IQZ7v5mv8UDXjMT6+UHH+XJUstV+gVP50wkrl9ViD8/bPkdQqxcAAAWMaIYqIHPq+qkfxRBIbrQOwu8kvmfhZtHHYOryl8cOKNKvpi4/aud4AgeEcYh4AHZI9vO3827yBXDf1GncPeo4KX2njfPjSfyGxV23VTWkh7NWBbsQkwAmB3jC+V4gH6XIq3UPc4GzhElfpqShwgrZMf8hh835cXnuuJ+9A/793c+MmFB8/GkuVHEbkxCFYAAQOSk123Dif1skP9rbvOthDQYbS0mOKyOs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29996BA9CD17E24EB741804BF2BEB5DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b33058-dc9f-4b3f-e127-08d6df565fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 08:12:18.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjIuMDUuMTkgdW0gMjI6NDEgc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+IFtDQVVUSU9O
OiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4gT24gMjAxOS0wNS0yMiAyOjMwIHAubS4sIEtvZW5pZywg
Q2hyaXN0aWFuIHdyb3RlOg0KPj4gSGkgTG9nYW4sDQo+Pg0KPj4gQW0gMjIuMDUuMjAxOSAyMjox
MiBzY2hyaWViIExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT46DQo+Pg0KPj4g
wqDCoMKgIFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4+DQo+PiDCoMKgwqAgUHJlc2VudGx5
LCB0aGVyZSBpcyBubyBwYXRoIHRvIERNQSBtYXAgUDJQRE1BIG1lbW9yeSwgc28gaWYgYSBUTFAN
Cj4+IMKgwqDCoCB0YXJnZXRpbmcgdGhpcyBtZW1vcnkgaGl0cyB0aGUgcm9vdCBjb21wbGV4IGFu
ZCBhbiBJT01NVSBpcyBwcmVzZW50LA0KPj4gwqDCoMKgIHRoZSBJT01NVSB3aWxsIHJlamVjdCB0
aGUgdHJhbnNhY3Rpb24sIGV2ZW4gaWYgdGhlIFJDIHdvdWxkIHN1cHBvcnQNCj4+IMKgwqDCoCBQ
MlBETUEuDQo+Pg0KPj4gwqDCoMKgIFNvIHVudGlsIHRoZSBrZXJuZWwga25vd3MgdG8gbWFwIHRo
ZXNlIERNQSBhZGRyZXNzZXMgaW4gdGhlIElPTU1VLA0KPj4gwqDCoMKgIHdlIHNob3VsZCBub3Qg
ZW5hYmxlIHRoZSB3aGl0ZWxpc3Qgd2hlbiBhbiBJT01NVSBpcyBwcmVzZW50Lg0KPj4NCj4+DQo+
PiBXZWxsIE5BSywgY2F1c2UgdGhhdCBpcyBleGFjdGx5IHdoYXQgd2UgYXJlIGRvaW5nLg0KPg0K
PiBBcmUgeW91IERNQS1tYXBwaW5nIHRoZSBhZGRyZXNzZXMgb3V0c2lkZSB0aGUgUDJQRE1BIGNv
ZGU/IElmIHNvIHRoZXJlJ3MNCj4gYSBodWdlIG1pc21hdGNoIHdpdGggdGhlIGV4aXN0aW5nIHVz
ZXJzIG9mIFAyUERNQSAobnZtZS1mYWJyaWNzKS4gSWYNCj4geW91J3JlIG5vdCBkbWEtbWFwcGlu
ZyB0aGVuIEkgY2FuJ3Qgc2VlIGhvdyBpdCBjb3VsZCB3b3JrIGJlY2F1c2UgdGhlDQo+IElPTU1V
IHNob3VsZCByZWplY3QgYW55IHJlcXVlc3RzIHRvIGFjY2VzcyB0aG9zZSBhZGRyZXNzZXMuDQoN
CldlbGwsIHdlIGFyZSB1c2luZyB0aGUgRE1BIEFQSSAoZG1hX21hcF9yZXNvdXJjZSkgZm9yIHRo
aXMuIElmIHRoZSBQMlAgDQpjb2RlIGlzIG5vdCB1c2luZyB0aGlzIHRoZW4gSSB3b3VsZCByYXRo
ZXIgc2F5IHRoYXQgdGhlIFAyUCBjb2RlIGlzIA0KYWN0dWFsbHkgYnJva2VuLg0KDQpBZGRpbmcg
Q2hyaXN0b3BoIGFzIHdlbGwsIGNhdXNlIGhlIGlzIHVzdWFsbHkgdGhlIG9uZSBkaXNjdXNzaW9u
IHN0dWZmIA0KbGlrZSB0aGF0IHdpdGggbWUuDQoNCj4gQnkgYWRkaW5nIHRoZSB3aGl0ZWxpc3Qg
aW4gdGhpcyB3YXkgeW91IHdpbGwgYnJlYWsgYW55IHVzZXIgdGhhdA0KPiBhdHRlbXB0cyB0byB1
c2UgUDJQIGluIG52bWUtZmFicmljcyBvbiB3aGl0ZWxpc3RlZCBSQ3Mgd2l0aCBhbiBJT01NVQ0K
PiBlbmFibGVkLg0KPg0KPiBDdXJyZW50bHksIHRoZSB1c2VycyBvZiBQMlBETUEgdXNlIHBjaV9w
MnBkbWFfbWFwX3NnKCkgd2hpY2ggb25seQ0KPiByZXR1cm5zIHRoZSBQQ0kgYnVzIGFkZHJlc3Mu
IElmIFAyUERNQSB0cmFuc2FjdGlvbnMgY2FuIG5vdyBnbyB0aHJvdWdoDQo+IGFuIElPTU1VLCB0
aGVuIHRoaXMgaXMgd3JvbmcgYW5kIGJyb2tlbi4NCj4NCj4gV2UgbmVlZCB0byBlbnN1cmUgdGhh
dCBhbGwgdXNlcnMgb2YgUDJQRE1BIG1hcCB0aGlzIG1lbW9yeSBpbiB0aGUgc2FtZQ0KPiB3YXku
IFdoaWNoIG1lYW5zLCBpZiB0aGUgVExQcyB3aWxsIGdvIHRocm91Z2ggYW4gSU9NTVUgdGhleSBn
ZXQNCj4gZG1hLW1hcCdkIGFuZCwgaWYgdGhleSBkb24ndCwgdGhleSB1c2UgdGhlIFBDSSBCdXMg
YWRkcmVzcyAoYXMgdGhlDQo+IGN1cnJlbnQgY29kZSBkb2VzKS4NCg0KV2VsbCB0aGF0IGlzIGV4
YWN0bHkgd2hhdCBkbWFfbWFwX3Jlc291cmNlKCkgYWxyZWFkeSBkb2VzLCBzbyB3ZSBzaG91bGQg
DQpwcm9iYWJseSBqdXN0IG1ha2UgdXNpbmcgdGhlIERNQSBBUEkgbWFuZGF0b3J5Lg0KDQo+IFdp
dGhvdXQgdGhlIGNoYW5nZSBwcm9wb3NlZCBpbiB0aGlzIHBhdGNoLCBJIGhhdmUgdG8gcmV0cmFj
dCBteSByZXZpZXcNCj4gYW5kIE5BSyB5b3VyIHBhdGNoIHVudGlsIHdlIGNhbiBzb3J0IG91dCB0
aGUgbWFwcGluZyBpc3N1ZXMuDQoNClllYWgsIGNvbXBsZXRlbHkgYWdyZWUgd2UgY2FuJ3QgZG8g
dGhhdCByaWdodCBub3cuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4NCj4gTG9nYW4N
Cg0K
