Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F615052B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfFXJIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:08:15 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:15694
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfFXJIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 05:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuF7NkuPeoZUFLSWNgYJ6HJBGNKvrZ3ZqHCDffh01e0=;
 b=rAa4zgWZ+oL49lp5HM4M1n/a7Pea9KtztsIQejiQtm8H5COzrgKyOR+z8ox8VXfvszieHqSz/Ma+ipI1DHaEetEpiNaksCdOtKazjtdTmLh5gfXxmbcPaV48VMQ9V+dv6B+F8pflfuDejeyEWf+83FjZt9934IWtC5/oYf3NljM=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1420.namprd12.prod.outlook.com (10.168.239.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:08:11 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:08:11 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Topic: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Index: AQHVKkUW/DbjAREBykOqVpf3qUW28qaqfO+AgAABiACAAAWqAA==
Date:   Mon, 24 Jun 2019 09:08:11 +0000
Message-ID: <f4cb8429-a32d-d3af-dee0-0bae1935cb47@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
 <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
 <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
In-Reply-To: <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR0P264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::35) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6c5dc1-1c77-4d53-82d4-08d6f8837b6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1420;
x-ms-traffictypediagnostic: DM5PR12MB1420:
x-microsoft-antispam-prvs: <DM5PR12MB14207A9EC61C7AC2B554FD2683E00@DM5PR12MB1420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(54534003)(4326008)(256004)(66946007)(53936002)(186003)(76176011)(6512007)(73956011)(54906003)(229853002)(31696002)(316002)(64126003)(81156014)(72206003)(8936002)(25786009)(6116002)(66556008)(71190400001)(6436002)(6486002)(36756003)(5660300002)(58126008)(64756008)(71200400001)(66476007)(66446008)(11346002)(446003)(476003)(2616005)(65806001)(65956001)(65826007)(102836004)(46003)(6916009)(478600001)(6506007)(386003)(68736007)(6246003)(81166006)(8676002)(52116002)(86362001)(305945005)(99286004)(7736002)(31686004)(2906002)(486006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1420;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HMxtRgHpC3/35rAlR7AS6pDklCeaN6FmiCQjorags2NGAaVYk66ZHQkWAdnT40IqPuv5t3YVkC/TUEqShcEho4MULFnWCI8UwUlz6unE0yDIbdNT1NRCqbZKaZiSPhBwjQmIFwoKAsgae4UIJ/ueuYEW/NpTCPJZGGl8ir1krrvtCYwIZiXW0MiO4G/z20tcNlF74Jfk2D7GqAFD9ULkM9Ni/LX0y+53lD9Ze04Dpob9zUUtZmKL1NMQtEfwTTyZs/Sut7DBntzmP8oLgkbKx73GH+9C6rby2c/3i6L4pLnisvCfrynnKmrAF4aj0RYjh/kHzBLQhCqYUraWUv35GMryzGkb8WFJhgBpVN33PlcZAEkhc4oW2sb4310MUpJKVOE43pI0bov7JzJN/5VnRFGX5QvXoLqkpfOdBbn2wM0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0739AA918617FA4ABB6CD32893115667@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6c5dc1-1c77-4d53-82d4-08d6f8837b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:08:11.7639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjQuMDYuMTkgdW0gMTA6NDcgc2NocmllYiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0Og0KPiBP
biBNb24sIDIwMTktMDYtMjQgYXQgMDg6NDIgKzAwMDAsIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3Rl
Og0KPj4gVGhlbiB3ZSByZXNpemUgdGhlIFZSQU0gQkFSIGJ5IGNhbGxpbmcgcGNpX3Jlc2l6ZV9y
ZXNvdXJjZSgpLiBUaGF0IGluDQo+PiB0dXJuIHRyaWVzIHRvIHJlc2l6ZSBhbmQgc2h1ZmZsZSBh
cm91bmQgdGhlIHBhcmVudCBicmlkZ2UgcmVzb3VyY2VzDQo+PiB1c2luZyBwY2lfcmVhc3NpZ25f
YnJpZGdlX3Jlc291cmNlcygpLg0KPj4NCj4+IEJ1dCBwY2lfcmVhc3NpZ25fYnJpZGdlX3Jlc291
cmNlcygpIGRvZXMgbm90IGFzc2lnbiBhbnkgZGV2aWNlDQo+PiByZXNvdXJjZXMsIGl0IGp1c3Qg
dHJpZXMgdG8gbWFrZSBzdXJlIHRoZSB1cHN0cmVhbSBicmlkZ2VzIGhhdmUgZW5vdWdoDQo+PiBz
cGFjZSB0byBmaXQgZXZlcnl0aGluZyBpbi4NCj4+DQo+PiBJbmRlcGVuZGVudCBpZiB3ZSBzdWNj
ZWVkZWQgb3IgZmFpbGVkIHdpdGggaGFuZGxpbmcgdGhlIGJyaWRnZShzKSB3ZQ0KPj4gY2FsbCBw
Y2lfYXNzaWduX3VuYXNzaWduZWRfYnVzX3Jlc291cmNlcygpIHRvIHJlLWFzc2lnbiB0aGUgcHJl
dmlvdXNseQ0KPj4gZnJlZWQgdXAgVlJBTSBhbmQgZG9vcmJlbGwgQkFScy4NCj4+DQo+PiBTbyB5
ZWFoLCB0aGlzIGRlZmluaXRlbHkgbmVjZXNzYXJ5LCBvciBvdGhlcndpc2UgdGhlIGRyaXZlciB3
b3VsZCBjcmFzaA0KPj4gc29vbiBhZnRlciBiZWNhdXNlIHRoZSByZXNvdXJjZXMgYXJlIG5vdCBh
c3NpZ25lZCBhZ2Fpbi4NCj4gT2gsIEkgbWlzc2VkIHRoYXQgcGNpX3JlYXNzaWduX2JyaWRnZV9y
ZXNvdXJjZXMoKSBkaWRuJ3QgcmVhc3NpZ24gdGhlDQo+IHJlc291cmNlcyB1bmRlciB0aGUgYnJp
ZGdlLi4uIHVnaC4uLiB0aGF0IGNvZGUgaXMgYSBibG9vZHkgbWVzcy4NCj4NCj4gV2UgaGF2ZSA0
IG9yIDUgImFzc2lnbiBidXMgcmVzb3VyY2VzIiBmdW5jdGlvbnMsIGFsbCBzdWJ0bHkgZGlmZmVy
ZW50DQo+IGZvciBubyBjbGVhciByZWFzb25zICh0aGUgaGlzdG9yaWNhbCBjaGFuZ2Vsb2dzIGZy
b20gWWluZ2hhaSBtYXkgYXMNCj4gd2VsbCBkb24ndCBleGlzdCwgdGhleSBhcmUgYmFzaWNhbGx5
IGVuY3J5cHRlZCksIGFuZCBpbiBtb3N0IGNhc2UgZm9yDQo+IG5vIGdvb2QgcmVhc29ucy4uLi4N
Cg0KWWVhaCwgY2FuJ3QgYWdyZWUgbW9yZSA6KSBJdCB3YXMgb25lIG9mIHRoZSBtYWluIGNoYWxs
ZW5nZXMgaW1wbGVtZW50aW5nIA0KdGhlIHJlc2l6aW5nIHN1cHBvcnQuDQoNCklmIHlvdSB3YW50
IHRvIGNsZWFuIHRoaXMgdXAgZmVlbCBmcmVlIHRvIENDIG1lIGFuZCBJIGNhbiB0YWtlIGEgbG9v
ayBhcyANCndlbGwuIEJ1dCBob25lc3RseSBJIHdhcyBzY2FyZWQgb2YgdG91Y2hpbmcgaXQgd2hl
biBJIHdvcmtlZCBvbiB0aGlzLCANCmJlY2F1c2Ugb2YgYWxsIHRoZSBsaXR0bGUgY29ybmVyIGNh
c2VzIHlvdSBoYXZlIGluIFBDSS4NCg0KPiBRdWVzdGlvbjogRG8geW91IGV2ZXIgbmVlZCB0byBh
c3NpZ24gYW55dGhpbmcgb3RoZXIgdGhhbiB0aGF0IG9uZQ0KPiBkZXZpY2UgdGhvdWdoID8gSW4g
bXkgYnJhbmNoLCBJJ3ZlIGFkZGVkIHRoaXMgdHlwaWNhbGx5IGZvciB0aGUgY2FzZQ0KPiB3aGVy
ZSBhIHNpbmdsZSBkZXZpY2UgbmVlZHMgdG8gYmUgcmVhc3NpZ25lZDoNCj4NCj4gK3ZvaWQgcGNp
X2Rldl9hc3NpZ25fcmVzb3VyY2VzKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICt7DQo+ICsJTElT
VF9IRUFEKGhlYWQpOw0KPiArDQo+ICsJLyogQXNzaWduIG5vbi1maXhlZCByZXNvdXJjZXMgKi8N
Cj4gKwlfX2Rldl9zb3J0X3Jlc291cmNlcyhkZXYsICZoZWFkKTsNCj4gKwlfX2Fzc2lnbl9yZXNv
dXJjZXNfc29ydGVkKCZoZWFkLCBOVUxMLCBOVUxMKTsNCj4gKw0KPiArCS8qIEFzc2lnbiBmaXhl
ZCBvbmVzIGlmIGFueSAqLw0KPiArCXBkZXZfYXNzaWduX2ZpeGVkX3Jlc291cmNlcyhkZXYpOw0K
PiArfQ0KPiArRVhQT1JUX1NZTUJPTChwY2lfZGV2X2Fzc2lnbl9yZXNvdXJjZXMpOw0KPg0KPiBX
b3VsZCB0aGF0IHdvcmsgZm9yIHlvdSA/DQoNClRoYXQgc2hvdWxkIHdvcmsgcGVyZmVjdGx5IGZp
bmUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gSWYgeWVzLCBJJ2xsIHJlcGxhY2Ug
cGNpX2Fzc2lnbl91bmFzc2lnbmVkX2J1c19yZXNvdXJjZXMoKS4gSSdkIGxpa2UgdG8NCj4gZXZl
bnR1YWxseSBraWxsIGl0Li4NCj4NCj4gQ2hlZXJzLA0KPiBCZW4uDQo+DQo+DQoNCg==
