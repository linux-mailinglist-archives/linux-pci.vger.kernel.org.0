Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38519A7C7
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgDAIup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 04:50:45 -0400
Received: from mail-eopbgr1410111.outbound.protection.outlook.com ([40.107.141.111]:57312
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729703AbgDAIuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 04:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsJoO6JsyF5U/6YK8bleYiPOOzHUJ83/8UPDGZbXJ1/kR1OMoGQyP0KKf+LPANFx4a51bIW15mGpJ2Cqk+x3VkfKdgux5WMZ2LEYuvAWLRCo//g8wAXamBPV35Tc++UVs5IcwmIuUH085txnO2OYBy3hjucZ3/j/x/3IczhEC9stfjnCv8HPGxFseTJV0r7i2sBoTFixRL78euUdp1eak4iqWJoLGF+Fg48qvRtNK1MATburwv5BVu0uITd3DI4+A1fzmB73kEutgzPU1YHkQ8ceLG7hyGYSezoyvlMAzroY5UUUDViEamI2Ni1J8A3V1WniI4KIsqtPHGHgV0xg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00jYW5auIJ5cCXj5eoLk1gSD3RbBz9GpcyYMu4BjNTg=;
 b=CQDr+KdbzvNGvV4ZPd3XB7saw+f3jOQbjwGZXFJwAI7SgXsZW+YZNEZMYy21huGvPbcJnGAf20FORhkOznmzxm1RIPwRsEFconXiAakYQJBCbH27/d0qijoDB9ikWzkZpXWZbGS40xMiMWlOMMLfsbDM2eOsQGUeYuozv2ABwa3i0LUiIDHb7j7Do9E7wpc6pPgeTSzh5A5EuncWF7gV4OEA2Ppa17Xw8hi7CuVjF39nlt1zY3upB04npNcQ18lrMUqVpHDsBQfewN7neXaDhHE+cS9TzZ3nrf7WTwX2zVtsdwb/7Yv54TVupdEuMLIQVM2Q/6gz77+9wC0FRgUtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00jYW5auIJ5cCXj5eoLk1gSD3RbBz9GpcyYMu4BjNTg=;
 b=i4d76c8o1ibgOd+EcIRiZdHY0D0NYA1MHjjAZi6yfXkcY/R59uqOA9/L9D0d/nh2jjlE1XY36NYO9r3TjoJpbrEOlzsJjCqU2IYAYx8WpmyQFF+HZ8JQh2ETyURw/AeOXA/RQDWpf0j8h49DP9I6bUw/9yT9gqUrTTk9uPiVpcI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4160.jpnprd01.prod.outlook.com (20.178.139.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 08:50:40 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 08:50:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: PCIe EPF
Thread-Topic: PCIe EPF
Thread-Index: AQHV/Rm8Pc6E7UbBNUC7Q13GpqZQQKhQ9oaAgAK1PACAA1lugIAA1U4AgAaNB4CAAUQ/AIABb1+AgAATpYCAAAMegIAABzuAgAEWMpCAALlXgIAAgOqAgABzUYCAAAdw4A==
Date:   Wed, 1 Apr 2020 08:50:39 +0000
Message-ID: <TYAPR01MB4544972970249F317DEBE5AAD8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
 <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com>
 <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
 <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com>
 <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
 <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com>
In-Reply-To: <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9eeea284-0cc5-43bd-4eeb-08d7d619c12d
x-ms-traffictypediagnostic: TYAPR01MB4160:|TYAPR01MB4160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB41604546B7EBF1A96700BB84D8C90@TYAPR01MB4160.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(86362001)(6916009)(81156014)(81166006)(8676002)(66946007)(7116003)(76116006)(8936002)(2906002)(3480700007)(66446008)(478600001)(7696005)(26005)(5660300002)(33656002)(9686003)(66476007)(64756008)(186003)(54906003)(4326008)(55016002)(66556008)(52536014)(71200400001)(316002)(55236004)(6506007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWkKBIM9wBqKnLcEN/+8mFiSyP+PrDO3lUG6IB5EOFUvTM/bzvTmNECaScB90Z8Cfl/RxZcKQVYIsryrwlP5bLp8+WPWs+g+4IwNrolDDSRUuv9NhB7nTAEPpJW9SzClvqxogAcoFgKpdhZfy0Bz5k0Czoz1DgbC1y5VOk0DAeHQjqcDuxjqKcxI9B0oFrZecdsSk98H/kflEVX9UHdlO+5cDjBEN24CKQVPIBHTN+Z8dEgoKPAWzl83cwGMI/7YJlTiTL99Bd+hjbvp1qg6I1YnUpDHbSa7Cgko93bAfYnau4W6tcymJ3dYHUZaAOS4uJEexPgQNRFmah/ymdG4UtBGjmEMXL2DVWyJQJXbaEV7hkd39Rz6c4aOIi0qZNzPqypqXeJSgGVhw4gD7Sm4IQHtnyBr/wKPIGU+xq6MNwpyaKr/k+5sU9A7wUeON+xk
x-ms-exchange-antispam-messagedata: ZtG1C3R/gMaQr8rERj62cfsaQFJ2lDSSe1wCAJ3Wp1d31DgH39iqjTUEQfDtFclRzSNwxofy8DxFyFyVLRhsz9aBRoLMnaD2n3i0DQfp3xpiLIVvZM9s9WgYrhe0t6vbsZLr4247FObXSWAbdAVqkQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeea284-0cc5-43bd-4eeb-08d7d619c12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 08:50:39.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkSwnDLV0yrP/K6cdXms/GB+sy89ul/c45cqYmv32P+qyDpNlBNeIpJ5dnnuxcXblIkRgtNd2LWqHawQPnL5p2510HGgIQ5+cg1kZIfbv3lVhjc+8LenNI897wkccu02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLXNhbiwNCg0KPiBGcm9tOiBMYWQsIFByYWJoYWthciwgU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAxLCAyMDIwIDU6MDAgUE0NCjxzbmlwPg0KPiA+ID4gcm9vdEBoaWhvcGUtcnpn
Mm06fiMgcGNpdGVzdCAtciAtcyAyMTc2DQo+ID4gPHNuaXA+DQo+ID4gPiBbICA1MjguNTU2OTkx
XSBwY2ktZW5kcG9pbnQtdGVzdCAwMDAwOjAxOjAwLjA6IHBjaV9lbmRwb2ludF90ZXN0X3JlYWQN
Cj4gPiA+IGZmZmYwMDA0YjYxZjkwMDAgN2U5NTEwMDAgOTEwYzY5MGQ9OTEwYzY5MGQNCj4gPg0K
PiA+IEknZCBsaWtlIHRvIGtub3cgaG93IHRvIHByaW50IHRoZXNlIGNyYyB2YWx1ZXMuIFlvdXIg
cmVwb3J0IG9uIHRoZSBjYXNlIDENCj4gPiBtZW50aW9uZWQgb24gcGNpLWVwZi10ZXN0LmMgbGlr
ZSBiZWxvdyB0aG91Z2guDQo+ID4NCj4gPiA+ICsgICAgICAgZGV2X2VycihkZXYsICIlcyAlbGx4
ICVsbHggY3N1bTogJXggPSAleFxuIiwgX19mdW5jX18sIHJlZy0+ZHN0X2FkZHIsDQo+ID4gPiAr
ICAgICAgICAgICAgICAgcGh5c19hZGRyLCByZWctPmNoZWNrc3VtLCBjcmMzMl9sZSh+MCwgZHN0
X2FkZHIsIHJlZy0+c2l6ZSkpOw0KPiA+DQo+ID4gQWxzbywgYXMgSSBtZW50aW9uZWQgb24gcHJl
dmlvdXMgZW1haWwsIHRoaXMgaXMgcG9zc2libGUgdG8gY2F1c2UgdGltaW5nIGlzc3VlLg0KPiA+
IFNvLCBJJ2QgbGlrZSB0byB3aGVyZSB5b3UgYWRkZWQgdGhlIGhleGR1bXAgb24gcGNpX2VuZHBv
aW50X3Rlc3QuYy4NCj4gPiBQZXJoYXBzLCBjb3B5IGFuZCBwYXN0aW5nIHlvdXIgd2hvbGUgZGVi
dWcgZGlmZiBpcyB1c2VmdWwgdG8gdW5kZXJzdGFuZCBhYm91dCBpdC4NCj4gPg0KPiANCj4gRm9s
bG93aW5nIGlzIHRoZSBjb21wbGV0ZSBkaWZmOg0KDQpUaGFua3MhDQoNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jIGIvZHJpdmVycy9taXNjL3BjaV9lbmRw
b2ludF90ZXN0LmMNCj4gaW5kZXggM2M0OTUxNGI0ODEzLi5lN2JmNThhMWZlZTggMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jDQo+ICsrKyBiL2RyaXZlcnMv
bWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jDQo+IEBAIC01NjEsNiArNTYxLDIzIEBAIHN0YXRpYyBi
b29sIHBjaV9lbmRwb2ludF90ZXN0X3dyaXRlKHN0cnVjdA0KPiBwY2lfZW5kcG9pbnRfdGVzdCAq
dGVzdCwNCj4gICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHByaW50
X2J1ZmZlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmJ1ZmZfYWRkciwgc2l6ZV90IHNpemUp
DQo+ICt7DQo+ICsgICAgc2l6ZV90IGk7DQo+ICsgICAgdTY0ICphZGRyID0gYnVmZl9hZGRyOw0K
PiArDQo+ICsgICAgZm9yKGkgPSAwOyBpIDwgc2l6ZTsgaSArPSBzaXplb2YoYWRkcikpDQo+ICsg
ICAgICAgIGRldl9lcnIoZGV2LCAiYnVmWyV6dV0gOiAlbGx4XG4iLCBpLCAqYWRkcik7DQo+ICsN
Cj4gKyAgICBmb3IoaSA9IDA7IGkgPCBzaXplOyBpICs9MSkgew0KPiArICAgICAgICBpZiAoMHg5
MTBjNjkwZCA9PSBjcmMzMl9sZSh+MCwgYnVmZl9hZGRyLCBpKSkNCj4gKyAgICAgICAgICAgIGRl
dl9lcnIoZGV2LCAiJXhcbiIsDQo+ICsgICAgICAgICAgICAgICAgY3JjMzJfbGUofjAsIGJ1ZmZf
YWRkciwgaSkpOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGRldl9lcnIoZGV2LCAiXG5cblxuXG4i
KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGJvb2wgcGNpX2VuZHBvaW50X3Rlc3RfcmVhZChzdHJ1
Y3QgcGNpX2VuZHBvaW50X3Rlc3QgKnRlc3QsDQo+ICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBhcmcpDQo+ICB7DQo+IEBAIC02MDgsNyArNjI1LDcgQEAgc3RhdGljIGJvb2wgcGNp
X2VuZHBvaW50X3Rlc3RfcmVhZChzdHJ1Y3QNCj4gcGNpX2VuZHBvaW50X3Rlc3QgKnRlc3QsDQo+
ICAgICAgfQ0KDQpJJ2QgbGlrZSB0byBhbGxvY2F0ZSB0ZW1wb3JhcnkgYnVmZmVyIGhlcmUgdG8g
Y29weSBkYXRhIGxhdGVyLi4uDQoJdm9pZCAqdG1wOw0KCS4uLg0KCXRtcCA9IGt6YWxsb2Moc2l6
ZSArIGFsaWdubWVudCwgR0ZQX0tFUk5FTCk7DQoNCj4gICAgICBvcmlnX3BoeXNfYWRkciA9IGRt
YV9tYXBfc2luZ2xlKGRldiwgb3JpZ19hZGRyLCBzaXplICsgYWxpZ25tZW50LA0KPiAtICAgICAg
ICAgICAgICAgICAgICBETUFfRlJPTV9ERVZJQ0UpOw0KPiArICAgICAgICAgICAgICAgICAgICBE
TUFfQklESVJFQ1RJT05BTCk7DQo+ICAgICAgaWYgKGRtYV9tYXBwaW5nX2Vycm9yKGRldiwgb3Jp
Z19waHlzX2FkZHIpKSB7DQo+ICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIG1hcCBz
b3VyY2UgYnVmZmVyIGFkZHJlc3NcbiIpOw0KPiAgICAgICAgICByZXQgPSBmYWxzZTsNCj4gQEAg
LTY0MCwxMiArNjU3LDE3IEBAIHN0YXRpYyBib29sIHBjaV9lbmRwb2ludF90ZXN0X3JlYWQoc3Ry
dWN0DQo+IHBjaV9lbmRwb2ludF90ZXN0ICp0ZXN0LA0KPiAgICAgIHdhaXRfZm9yX2NvbXBsZXRp
b24oJnRlc3QtPmlycV9yYWlzZWQpOw0KPiANCj4gICAgICBkbWFfdW5tYXBfc2luZ2xlKGRldiwg
b3JpZ19waHlzX2FkZHIsIHNpemUgKyBhbGlnbm1lbnQsDQo+IC0gICAgICAgICAgICAgRE1BX0ZS
T01fREVWSUNFKTsNCj4gKyAgICAgICAgICAgICBETUFfQklESVJFQ1RJT05BTCk7DQoNCkFuZCB0
aGVuLCBJJ2QgbGlrZSB0byBjb3B5IGFkZHIgYnVmZmVyIHRvIHRoZSB0bXAgaGVyZS4NCgltZW1j
cHkodG1wLCBhZGRyLCBzaXplKTsNCg0KPiAgICAgIGNyYzMyID0gY3JjMzJfbGUofjAsIGFkZHIs
IHNpemUpOw0KDQpBbmQgYWRkciBpcyByZXBsYWNlZCB3aXRoIHRtcDsNCg0KPiAgICAgIGlmIChj
cmMzMiA9PSBwY2lfZW5kcG9pbnRfdGVzdF9yZWFkbCh0ZXN0LCBQQ0lfRU5EUE9JTlRfVEVTVF9D
SEVDS1NVTSkpDQo+ICAgICAgICAgIHJldCA9IHRydWU7DQo+IA0KPiArICAgIHByaW50X2J1ZmZl
cihkZXYsIGFkZHIsIHNpemUpOw0KDQpUaGlzIGFkZHIgaXMgYWxzbyByZXBsYWNlZCB3aXRoIHRt
cDsNCg0KPiArICAgIGRldl9lcnIoZGV2LCAiJXMgJXB4ICVsbHggJXg9JXhcbiIsIF9fZnVuY19f
LCBvcmlnX2FkZHIsDQo+ICsgICAgICAgIG9yaWdfcGh5c19hZGRyLCBjcmMzMiwNCj4gKyAgICAg
ICAgcGNpX2VuZHBvaW50X3Rlc3RfcmVhZGwodGVzdCwgUENJX0VORFBPSU5UX1RFU1RfQ0hFQ0tT
VU0pKTsNCg0KVGhlIGNyYzMyIHZhbHVlIHdhcyBjYWxjdWxhdGVkIGJlZm9yZSBwcmludCB0aGUg
YnVmZmVyLg0KVGhpcyBtZWFucyB0aGF0IHRpbWluZyBpcyBkaWZmZXJlbmNlIGJldHdlZW4gY3Jj
MzJfbGUoYWRkcikgYW5kIHByaW50X2J1ZmZlcihhZGRyKS4NClNvLCBJJ2QgbGlrZSB0byBjb3B5
IHRoZSBhZGRyIGJ1ZmZlciB0byB0bXAgYW5kIHVzZSB0aGUgdG1wIGZvciBjcmMzMl9sZSgpIGFu
ZCBwcmludF9idWZmZXIoKS4NCg0KPiArDQo+ICBlcnJfcGh5c19hZGRyOg0KPiAgICAgIGtmcmVl
KG9yaWdfYWRkcik7DQo+ICBlcnI6DQo+IA0KPiBOb3RlOiBJIGhhdmUgYWRkZWQgRE1BX0JJRElS
RUNUSU9OQUwgdGhhdCBpcyBiZWNhdXNlIEkgYW0gYWxzbw0KPiBwcmludGluZyB0aGUgYnVmZmVy
IG9uIGVwDQo+IGFuZCBjYWx1bGF0aW5nIHRoZSBjcmMNCj4gDQo+ID4gPiBSRUFEICggICAyMTc2
IGJ5dGVzKTogICAgICAgICAgIE9LQVkNCj4gPiA+IHJvb3RAaGlob3BlLXJ6ZzJtOn4jIHBjaXRl
c3QgLXIgLXMgMjE3Ng0KPiA+IDxzbmlwPg0KPiA+ID4gWyAgNTMzLjQ1NzkyMV0gcGNpLWVuZHBv
aW50LXRlc3QgMDAwMDowMTowMC4wOiBwY2lfZW5kcG9pbnRfdGVzdF9yZWFkDQo+ID4gPiBmZmZm
MDAwNGI2MWY5MDAwIDdlOTU5ODAwICBjZTUzNTAzOT05MTBjNjkwZA0KPiA+ID4gUkVBRCAoICAg
MjE3NiBieXRlcyk6ICAgICAgICAgICBOT1QgT0tBWQ0KPiA+ID4NCj4gPiA+IE5vdGU6IGZvciBm
YWlsdXJlIGNhc2UgdGhlIGNyYyBpcyBhbHdheXMgY2U1MzUwMzkNCj4gPg0KPiA+IFRoZSB2YWx1
ZSBvZiBjZTUzNTAzOSBpcyBmcm9tIHBjaV9lbmRwb2ludF90ZXN0X3JlYWRsKHRlc3QsIFBDSV9F
TkRQT0lOVF9URVNUX0NIRUNLU1VNKT8NCj4gPiBJZiBzbywgaXQncyBzdHJhbmdlIGJlY2F1c2Ug
YWxsIDB4ZGYgdmFsdWVzIHdpdGggMjE3NiBieXRlcyBzaG91bGQgYmUgOTEwYzY5MGQgYnkgY3Jj
MzJfbGUoKS4NCj4gPg0KPiBUaGUgdmFsdWUgY2U1MzUwMzkgaXMgdGhlIG9uZSB3aGljaCBpcyBj
YWxjdWxhdGVkIGZyb20gdGhlIGJ1ZmZlciBhbmQNCj4gdmFsdWUgOTEwYzY5MGQgaXMgdGhlIG9u
ZQ0KPiB3aGljaCBpcyBwYXNzZWQgZnJvbSB0aGUgQkFSIG1lbW9yeSB3aGljaCBpcyBjb3JyZWN0
Lg0KDQpJIGdvdCBpdC4gSWYgbXkgZ3Vlc3MgaXMgY29ycmVjdCwgdXNpbmcgdGhlIHRtcCBidWZm
ZXIgYWJvdmUgY2FuIHByaW50DQp0aGUgYnVmZmVyIHdpdGggd3JvbmcgdmFsdWUocykuDQoNCg0K
QnkgdGhlIHdheSwgeW91ciBQQ0llIGhvc3QgZW52aXJvbm1lbnQgKFJaL0cyTikgb3V0cHV0IHRo
ZSBmb2xsb3dpbmcgbG9nPw0KDQpbICAgIDAuMDAwMDAwXSBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBl
ZCBbbWVtIDB4N2JmZmYwMDAtMHg3ZmZmZjAwMF0gKDY0TUIpDQoNCklmIHNvLCBJIGd1ZXNzIHRo
aXMgaXNzdWUgaXMgcmVsYXRlZCB0byB0aGlzIHNvZnR3YXJlIElPIFRMQiBiZWhhdmlvci4NCklJ
VUMsIGlmIHdlIHVzZSBjb2hlcmVudCBidWZmZXIgb3IgR1BGX0RNQSBidWZmZXIsIHRoZSBrZXJu
ZWwgd2lsbCBub3QNCnVzZSBzb2Z0d2FyZSBJTyBUTEIgZm9yIHRoZXNlIGJ1ZmZlcnMuDQoNCkJl
c3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gQ2hlZXJzLA0KPiAtLVByYWJoYWth
cg0K
