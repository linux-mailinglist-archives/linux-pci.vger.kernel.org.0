Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84C2DAF85
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439927AbfJQOOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 10:14:07 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:34237
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439928AbfJQOOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 10:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2fB4K9deKzhlv0bmsZt55f2UNPFjMZ2gR54tu9KGLXHxVLZhDoyaKFpZ20b4r/fXKvXhJOSlWEqFbLfHIRCXL7wZDYIAkplWVqiyimnjHw63ykbIig0k4THvqZwZ0PkTDVPSKhQg5W+7h0OoBZLi9bYxHjph/1Esxey+1PLHMtqYT89hTzbXHl6mEPckpd1CXYLNgndtbybGYJC7dqDcIXFw/9M4OMmMVcBsaGyOiUE59JqQJPDDw13ucw4TISiPrV65ifdN2QocxVOutlewuay2I7HxQdg44s8Hqp+aYY8kdoQGcB6iFnYrIc327/sG6/yhPZJmLkrAjBo0gqO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZsZl4v2qo31RfY3p3HBHf6q5kqa02bswGzWbZMIlGA=;
 b=TsYfR8WhPgnuQ6FkeFx9SlSSw1W7UO/0d+Ccy6wAMDG5Yw0pYrAKKlBGBmkD0VDA4qEOupFcQ0IpJidQb2YdtJbrD1jQK4TtLUSFg9ueai0mhMzuwS0cxKJfNva7RwwUtbQR/IsGClR2kbnL0UPsmR7bNxFEo+sFu/cpy7kWqdyL2qQ4lVMfnU8K4HASOuT3e3XIs3pqiuLxJ/hr4UPO24b35lDz9E56zWo7aGZBgMzCln7SDs8O5K+ujmC9pEZilyNwyUoAv1LVDhK13sRjzMR6p7K3xrFUmoHYca74N8bIb3rpgkHHugAqodDn4JgIdgjL7WQY6Fb6etUNFxHZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verimatrix.com; dmarc=pass action=none
 header.from=verimatrix.com; dkim=pass header.d=verimatrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZsZl4v2qo31RfY3p3HBHf6q5kqa02bswGzWbZMIlGA=;
 b=RBdva+2RXCgoQqmR8aOuhwhj8V9rlsZ7d+aSmU0QSgk7TCGs8BCr6BDQui8qk3vivPchEh3qrd4ygYY/tDF3vRPjfAE8ZiWsvX92p1fOZsBSQVrLR22YA/ZzAM939DDGsuaOel6tD9NlVj6AwJLtkycn5KR0ID+nL+LIjwKQzMU=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.86) by
 MN2PR20MB2574.namprd20.prod.outlook.com (20.179.145.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 14:14:04 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::b986:4f02:3206:31e4]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::b986:4f02:3206:31e4%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 14:14:03 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Thread-Topic: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Thread-Index: AQHVd4jdTWYvsvdMgECIJvWMP+Nud6de2q1ggAAZLICAAAWwsA==
Date:   Thu, 17 Oct 2019 14:14:03 +0000
Message-ID: <MN2PR20MB29736FBE530B603C71F99AD6CA6D0@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20190930121520.1388317-1-arnd@arndb.de>
 <20190930121520.1388317-3-arnd@arndb.de>
 <MN2PR20MB2973D14C38B7BC7E081A73A9CA6D0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAK8P3a3+UrqS0nQxcG7UuMt4s5FDnowFq-C5-K5XU-CKpciM8g@mail.gmail.com>
In-Reply-To: <CAK8P3a3+UrqS0nQxcG7UuMt4s5FDnowFq-C5-K5XU-CKpciM8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e577de48-239f-424c-254d-08d7530c43e2
x-ms-traffictypediagnostic: MN2PR20MB2574:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR20MB2574D0CA3B31C2520D652FB1CA6D0@MN2PR20MB2574.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(199004)(189003)(13464003)(5660300002)(74316002)(66556008)(7416002)(64756008)(66946007)(66476007)(55016002)(14454004)(446003)(11346002)(486006)(99286004)(476003)(66066001)(6246003)(15974865002)(4326008)(33656002)(76116006)(71200400001)(14444005)(86362001)(66446008)(71190400001)(478600001)(6436002)(256004)(9686003)(316002)(25786009)(7696005)(8936002)(76176011)(54906003)(6916009)(186003)(229853002)(6506007)(53546011)(102836004)(52536014)(2906002)(26005)(7736002)(8676002)(3846002)(6116002)(81156014)(305945005)(81166006)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB2574;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEss91tDtm7Wnn39exOpJh7VgM0N9n3t7uySH+zSTPyS6QVA9NNabOTyixBLKJQPQF/7IlJ8Gyz2rGNMp5EOlITMZ57IPQ4Bb5A9VaK3UF5koHsJOm5brLe3eFFB4WvTxBce/8mewlcrV6ndN2GB3G0xZAHy1agniLjnfwcJsLN45sux5sCKQR7Y92D4Aj05pKIIErpfWcCXyYx/K9Q9cqt0uFzu/0PNGmmV0wT7YACYPsXovuq9jPD9Q6/kr8+PMuhpsl6ZMs9KYFH8mWY8/4vYQLNOqNmImlZiG6+bDbu/ybdfwQVqQAkoQX8iwgM77/OHBI296BxLhowMt+vVa9fUtyL8zz4F0dh3nrFaz2ZD6hU9aUdE/Lvl27c8PpuAPHJpFqCN7ChSoUotl1IHVTgcm3SqYO8uA/XLyjv6r7M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e577de48-239f-424c-254d-08d7530c43e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 14:14:03.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIRG6B+Gp79Pw/znyLtpfDOjesVV47CWwD4yx1odZJxwI0oC1fCOkDCQWk5oxI4uNcuGuZupHMYn1jLNSaj+dPqjYiND2KDCnMLW9LNe36I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2574
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNywgMjAxOSAzOjQ4IFBNDQo+
IFRvOiBQYXNjYWwgVmFuIExlZXV3ZW4gPHB2YW5sZWV1d2VuQHZlcmltYXRyaXguY29tPg0KPiBD
YzogQW50b2luZSBUZW5hcnQgPGFudG9pbmUudGVuYXJ0QGJvb3RsaW4uY29tPjsgSGVyYmVydCBY
dSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZl
bUBkYXZlbWxvZnQubmV0PjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFBh
c2NhbCB2YW4gTGVldXdlbg0KPiA8cGFzY2FsdmFubEBnbWFpbC5jb20+OyBLZWxzZXkgU2t1bmJl
cmcgPHNrdW5iZXJnLmtlbHNleUBnbWFpbC5jb20+OyBsaW51eC0NCj4gY3J5cHRvQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gY3J5cHRvOiBpbnNpZGUtc2VjdXJl
IC0gUmVtb3ZlICNpZmRlZiBjaGVja3MNCj4gDQo+IE9uIFRodSwgT2N0IDE3LCAyMDE5IGF0IDM6
MjYgUE0gUGFzY2FsIFZhbiBMZWV1d2VuDQo+IDxwdmFubGVldXdlbkB2ZXJpbWF0cml4LmNvbT4g
d3JvdGU6DQo+IA0KPiA+ID4gICAgICAgLyogUmVnaXN0ZXIgUENJIGRyaXZlciAqLw0KPiA+ID4g
LSAgICAgcGNpcmVnX3JjID0gcGNpX3JlZ2lzdGVyX2RyaXZlcigmc2FmZXhjZWxfcGNpX2RyaXZl
cik7DQo+ID4gPiAtI2VuZGlmDQo+ID4gPiArICAgICByZXQgPSBwY2lfcmVnaXN0ZXJfZHJpdmVy
KCZzYWZleGNlbF9wY2lfZHJpdmVyKTsNCj4gPiA+DQo+ID4gPiAtI2lmIElTX0VOQUJMRUQoQ09O
RklHX09GKQ0KPiA+ID4gICAgICAgLyogUmVnaXN0ZXIgcGxhdGZvcm0gZHJpdmVyICovDQo+ID4g
PiAtICAgICBvZnJlZ19yYyA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmY3J5cHRvX3NhZmV4
Y2VsKTsNCj4gPiA+IC0gI2lmIElTX0VOQUJMRUQoQ09ORklHX1BDSSkNCj4gPiA+IC0gICAgIC8q
IFJldHVybiBzdWNjZXNzIGlmIGVpdGhlciBQQ0kgb3IgT0YgcmVnaXN0ZXJlZCBPSyAqLw0KPiA+
ID4gLSAgICAgcmV0dXJuIHBjaXJlZ19yYyA/IG9mcmVnX3JjIDogMDsNCj4gPiA+IC0gI2Vsc2UN
Cj4gPiA+IC0gICAgIHJldHVybiBvZnJlZ19yYzsNCj4gPiA+IC0gI2VuZGlmDQo+ID4gPiAtI2Vs
c2UNCj4gPiA+IC0gI2lmIElTX0VOQUJMRUQoQ09ORklHX1BDSSkNCj4gPiA+IC0gICAgIHJldHVy
biBwY2lyZWdfcmM7DQo+ID4gPiAtICNlbHNlDQo+ID4gPiAtICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gPiA+IC0gI2VuZGlmDQo+ID4gPiAtI2VuZGlmDQo+ID4gPiArICAgICBpZiAoSVNfRU5BQkxF
RChDT05GSUdfT0YpICYmICFyZXQpIHsNCj4gPiA+DQo+ID4gSG1tIC4uLiB0aGlzIHdvdWxkIG1h
a2UgaXQgc2tpcCB0aGUgT0YgcmVnaXN0cmF0aW9uIGlmIHRoZSBQQ0lFDQo+ID4gcmVnaXN0cmF0
aW9uIGZhaWxlZC4gTm90ZSB0aGF0IHRoZSB0eXBpY2FsIGVtYmVkZGVkICBzeXN0ZW0gd2lsbA0K
PiA+IGhhdmUgYSBQQ0lFIHN1YnN5c3RlbSAoZS5nLiBNYXJ2ZWxsIEE3Sy9BOEsgZG9lcykgYnV0
IHdpbGwgaGF2ZQ0KPiA+IHRoZSBFSVAgZW1iZWRkZWQgb24gdGhlIFNvQyBhcyBhbiBPRiBkZXZp
Y2UuDQo+ID4NCj4gPiBTbyB0aGUgcXVlc3Rpb24gaXM6IGlzIGl0IHBvc3NpYmxlIHNvbWVob3cg
dGhhdCBQQ0lFIHJlZ2lzdHJhdGlvbg0KPiA+IGZhaWxzIHdoaWxlIE9GIHJlZ2lzdHJhdGlvbiBk
b2VzIHBhc3M/IEJlY2F1c2UgaW4gdGhhdCBjYXNlLCB0aGlzDQo+ID4gY29kZSB3b3VsZCBiZSB3
cm9uZyAuLi4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGhvdyBpdCB3b3VsZCBmYWlsLiBXaGVuIENPTkZJ
R19QQ0kgaXMgZGlzYWJsZWQsDQo+IHBjaV9yZWdpc3Rlcl9kcml2ZXIoKSBkb2VzIG5vdGhpbmcs
IGFuZCB0aGUgcGNpX2RyaXZlciBhcyB3ZWxsDQo+IGFzIGV2ZXJ5dGhpbmcgcmVmZXJlbmNlZCBm
cm9tIGl0IHdpbGwgYmUgc2lsZW50bHkgZHJvcHBlZCBmcm9tDQo+IHRoZSBvYmplY3QgZmlsZS4N
Cj4gSWYgQ09ORklHX1BDSSBpcyBlbmFibGVkLCB0aGVuIHRoZSBkcml2ZXIgd2lsbCBiZSByZWdp
c3RlcmVkDQo+IHRvIHRoZSBQQ0kgc3Vic3lzdGVtLCB3YWl0aW5nIGZvciBhIGRldmljZSB0byBz
aG93IHVwLCBidXQNCj4gdGhlIGRyaXZlciByZWdpc3RyYXRpb24gZG9lcyBub3QgY2FyZSBhYm91
dCB3aGV0aGVyIHRoZXJlIGlzDQo+IHN1Y2ggYSBkZXZpY2UuDQo+IA0KSSBrbm93IGl0IGRvZXMg
bm90IGNhcmUgYWJvdXQgdGhlIGRldmljZSBiZWluZyBwcmVzZW50IG9yIG5vdC4NCkkgd2FzIGp1
c3Qgd29ycmllZCBzb21lIGlzc3VlIHdpdGggdGhlIFBDSUUgc3Vic3lzdGVtIHdvdWxkIHByb3Bh
Z2F0ZQ0KdG8gKHVucmVsYXRlZCkgT0YgZGV2aWNlIHVzZSB0aGlzIHdheS4gQnV0IEkgaGF2ZSBu
byBpZGVhIG9uIHRoZSBleGFjdA0Kd2F5cyBQQ0lFIHJlZ2lzdHJhdGlvbiBtYXkgZmFpbC4gSWYg
aXQgaXMgYmVjYXVzZSBvZiBsYWNrIG9mIG1lbW9yeSwNCkkgYXNzdW1lIHRoYXQgc3Vic2VxdWVu
dCBPRiBkZXZpY2UgcmVnaXN0cmF0aW9uIHdvdWxkIGZhaWwgYXMgd2VsbC4NClNvIG1heWJlIEkn
bSB3b3JyaWVkIGFib3V0IGFuIGlzc3VlIHRoYXQgZG9lc24ndCByZWFsbHkgZXhpc3QuDQoNCj4g
PiBPdGhlciB0aGFuIHRoYXQsIEkgZG9uJ3QgY2FyZSBtdWNoIGhvdyB0aGlzIGNvZGUgaXMgaW1w
bGVtZW50ZWQNCj4gPiBhcyBsb25nIGFzIGl0IHdvcmtzIGZvciBib3RoIG15IHVzZSBjYXNlcywg
YmVpbmcgYW4gT0YgZW1iZWRkZWQNCj4gPiBkZXZpY2UgKG9uIGEgU29DIF93aXRoXyBvciBfd2l0
aG91dF8gUENJRSBzdXBwb3J0KSBhbmQgYSBkZXZpY2UNCj4gPiBvbiBhIFBDSUUgYm9hcmQgaW4g
YSBQQ0kgKHdoaWNoIGhhcyBib3RoIFBDSUUgYW5kIE9GIHN1cHBvcnQpLg0KPiANCj4gWWVzLCB0
aGF0IHNob3VsZCBiZSBmaW5lLiBUaGVyZSBhcmUgYSBsb3Qgb2YgZHJpdmVycyB0aGF0IHN1cHBv
cnQNCj4gbXVsdGlwbGUgYnVzIGludGVyZmFjZXMsIGFuZCB0aGlzIGlzIHRoZSBub3JtYWwgd2F5
IHRvIGhhbmRsZSB0aGVtLg0KPiANCk9rLCBpZiB0aGlzIGlzIHRoZSAibm9ybWFsIHdheSB0byBo
YW5kbGUgdGhpcyIgYW5kIGEgbG90IG9mIG90aGVyDQpkcml2ZXJzIGRvIGl0IHRoZSBzYW1lIHdh
eSwgdGhlbiBJJ20gT0sgd2l0aCB0aGF0IC4uLg0KSSBhbHJlYWR5IHZlcmlmaWVkIGl0IHdvcmtz
IGNvcnJlY3RseSBmb3IgbXkgc3BlY2lmaWMgdXNlIGNhc2VzLg0KDQpUaGFua3MuDQoNCj4gICAg
IEFybmQNCg0KUmVnYXJkcywNClBhc2NhbCB2YW4gTGVldXdlbg0KU2lsaWNvbiBJUCBBcmNoaXRl
Y3QsIE11bHRpLVByb3RvY29sIEVuZ2luZXMgQCBWZXJpbWF0cml4DQp3d3cuaW5zaWRlc2VjdXJl
LmNvbQ0KDQo=
