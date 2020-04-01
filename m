Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12B19A345
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 03:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgDABZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 21:25:53 -0400
Received: from mail-eopbgr1400099.outbound.protection.outlook.com ([40.107.140.99]:40384
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731509AbgDABZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 21:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZlvY3f85+Rxmwc+kZ/z5BfXI9LXJyfDn4gDQKLju2p2DPGEIOOmjVlvUEQDDW8VmUANrfVwy6Qc0sUWilHhuCM2BrOMIQYDsaJ7ZWOKG3X0u79o9l/HwHjfgZRwo5Qcoy9kdIr9uHcAfH0upJ2/cHVtTwf34eiQxL4nMSiJOaaLzuR9tx0z9KQV8AuiAwp4OW8PylGEZfvvpMln2zuVvHhNNrg3RrRcrRaEizT/vNeyKvKcBBk1cLZM18PYSZMzXto9hrF7XcrZpq4kKW8LwaeW5qz5JRWjEi24jqDPCInZfEjgPdS5HpSHaH8/Sb3vw9wAxzbXyqAHhN1u3mMjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UBRpV0i5RQG8FwY6GmNIJhKzx281vh1Xg2yw4fbLIo=;
 b=ghg/acBLOxHhYVBnrRp6NCAKK17Dv23HSTyPhuJnjEJnCunW8O6ZKCXqPGi/O/IYY2TLDsqO0IQER4J+stemk3Tb5f5hI3S68D1pd/4XjCFsogZn/jAiaRSWMp1rE6ZV5rnI3QsGxz5YeQItvRDvmwDy6n1p7ZcLU3TNGBGUra0Rdqo/dCnVyc1AXYvshd06ekOTSb8b480lRTdk8/ml0bGkdQxEsPFhMG5VdWDC64JC9yLNOH2qUFIPty2bSuXlQqjuljdgJvAO7Ev2C26ar+YQpOiFq06sqra3Dm9RXaoqAqnZqAIX29tjP4gRCzR9onQe2skINaycpg7+c/rSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UBRpV0i5RQG8FwY6GmNIJhKzx281vh1Xg2yw4fbLIo=;
 b=QIFMuSRn+oiWdx2neuGa0YkmFBPd6ejZuoMqgRfFca0BI6nGirO51UMiYPygOdNvZ9NulUW+seG5wuQ63r8LE8/bQPm/0wuQC2w9hOqrGZ9X2wf452Dx7ZMFiMOjLSK0a2LPhtMgy7HLGeCJO51/ltvjGmsszC4GTP+NgPb//8M=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5008.jpnprd01.prod.outlook.com (20.179.186.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 01:25:49 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 01:25:48 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: PCIe EPF
Thread-Topic: PCIe EPF
Thread-Index: AQHV/Rm8Pc6E7UbBNUC7Q13GpqZQQKhQ9oaAgAK1PACAA1lugIAA1U4AgAaNB4CAAUQ/AIABb1+AgAATpYCAAAMegIAABzuAgAEWMpCAALlXgIAAgOqA
Date:   Wed, 1 Apr 2020 01:25:48 +0000
Message-ID: <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
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
In-Reply-To: <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28e86e69-8f6d-4b73-6743-08d7d5db9c1b
x-ms-traffictypediagnostic: TYAPR01MB5008:|TYAPR01MB5008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5008C4FBA34B7A62F23536FAD8C90@TYAPR01MB5008.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(7116003)(76116006)(9686003)(186003)(52536014)(8676002)(81156014)(8936002)(81166006)(86362001)(5660300002)(2906002)(7696005)(55016002)(54906003)(110136005)(33656002)(26005)(4326008)(316002)(6506007)(66476007)(64756008)(66556008)(66446008)(478600001)(3480700007)(55236004)(66946007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FI+nHO4Av1f1a/6nvbNkRQOTvoVHXE0zDknEZscGY/DMVxsJrRQw7TJ/ORsC24HIp5cAyZTihioP26xmM31T5Scp6/79WBwbxE0IkTwwsl79qxRMBZoQnRkc5mbnUvWeNq45SN9w7DgJs2J9FmidSG7GHvnCuGiD4DlXKUGO5khV46U6skO4SoP/gieNPNkczHBJe+QAamHMUzGIx9hsOIqUkfAF3D6W5yLCRnWLNeL3+q79q4oF9c1a8pwijBcn+IzHUMIObJiFb+F9fzP4ecWnH8Rdwl0UgfF/VFaC/UT06DTbnxcPEn4OE3s19/x4rxTKUfD3tIw7pifDXF04wP8jLc/CMwuaJz/m+Cy4HX0ATrerl74B2z3oht31LTXQnNk95AqEXg7y5eFQE567IdhO6/dkhKN7mjZv2a+tcjO5925l1JFfmK/fTIG44q3a
x-ms-exchange-antispam-messagedata: PEsXFuUgKv9SSmoOg8059kkEowyxw0uJbWd+pUlAXGXXqJHoKhrqu7iIwP34528JJDcP6lOGqVxtnMbFlrwswy8229BtkGTX9kJDRKVILCwRh9RDgXVKMHDEs4oI5ai0qqrJ9dt718rqc71cExjzqg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e86e69-8f6d-4b73-6743-08d7d5db9c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 01:25:48.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvKFDh63wWeunhp7nmKUV+03GOw9E/6zjR/+8ApE9wCnfJGEt/dAh1gJCV7yxwpGO0j+4/rWe4JXRBwZq8Cvm7/6n3cTpim2uWdR38IikuSl87qkzGrSgBKKq1vm5KGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5008
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLXNhbiwNCg0KPiBGcm9tOiBMYWQsIFByYWJoYWthciwgU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAxLCAyMDIwIDI6MjYgQU0NCjxzbmlwPg0KPiA+ID4gPiBEaWQgeW91IHRyeSB0
byBwcm9iZSB0aGUgZmFpbHVyZSBmdXJ0aGVyIGJ5IGNvbXBhcmluZyB0aGUgaGV4ZHVtcHM/IFdo
ZXJlIGRvZXMNCj4gPiA+ID4gdGhlIG1pc21hdGNoIGhhcHBlbj8NCj4gPiA+ID4NCj4gPiA+IEkg
c2hhbGwgZHVtcCB0aGUgbWVtb3J5IGFuZCBjaGVjayB0aGUgdmFsdWVzLCBidXQgYmFzaWNhbGx5
IGNyYyBpcyBmYWlsaW5nLg0KPiA+DQo+ID4gSSdtIGFsc28gaW50ZXJlc3RpbmcgYWJvdXQgY29t
cGFyaW5nIHRoZSBoZXhkdW1wIGJldHdlZW4gaG9zdCBhbmQgZXAuDQo+ID4gVGhpcyBpcyBteSBn
dXQgZmVlbGluZyB0aG91Z2gsIEknbSBndWVzc2luZyB0aGlzIGlzIGEgdGltaW5nIGlzc3VlDQo+
ID4gYmVjYXVzZSB1c2luZyBjb2hlcmVudCBtZW1vcnkgQVBJIHdpbGwgYmUgb24gbm9uLWNhY2hl
IGV2ZW4gaWYgQ1BVIGFjY2VzcywNCj4gPiBidXQgdXNpbmcgc3RlYW1pbmcgRE1BIEFQSSB3aWxs
IGJlIG9uIGNhY2hlIGlmIENQVSBhY2Nlc3MgYnkNCj4gPiBkbWFfdW5tYXBfc2luZ2xlKERNQV9G
Uk9NX0RFVklDRSkgYW5kIGdldF9yYW5kb21fYnl0ZXMoKSBpbiBwY2lfZW5kcG9pbnRfdGVzdF93
cml0ZSgpLg0KPiA+DQo+ID4gSWYgbXkgZ3Vlc3MgaXMgY29ycmVjdCwgYWxtb3N0IGFsbCBoZXhk
dW1wcyBhcmUgdGhlIHNhbWUsIGJ1dCBsYXN0DQo+ID4gc29tZSBieXRlcyAoSSdtIG5vdCBzdXJl
IGhvdyBtdWNoIGJ5dGVzIHRob3VnaCkgYXJlIG5vdCBtYXRjaC4NCj4gPg0KPiBTbyBJIGRpZCBz
b21lIGV4cGVyaW1lbnRzIG9ubHkgZm9jdXNpbmcgb24gcmVhZCBvcGVyYXRpb24gZm9yIG5vdw0K
PiANCj4gMTogIEkgdHJpZWQgcHJpbnRpbmcgdGhlIGNyYyB2YWx1ZSBpbiBwY2lfZXBmX3Rlc3Rf
d3JpdGUoKSBmdW5jdGlvbg0KPiB3aXRoIGJlbG93IGNvZGUgc25pcHBldDoNCj4gDQo+IEBAIC00
NzIsNiArNDc0LDkgQEAgc3RhdGljIGludCBwY2lfZXBmX3Rlc3Rfd3JpdGUoc3RydWN0IHBjaV9l
cGZfdGVzdCAqZXBmX3Rlc3QpDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgdXNsZWVwX3Jhbmdl
KDEwMDAsIDIwMDApOw0KPiANCj4gKyAgICAgICBkZXZfZXJyKGRldiwgIiVzICVsbHggJWxseCBj
c3VtOiAleCA9ICV4XG4iLCBfX2Z1bmNfXywgcmVnLT5kc3RfYWRkciwNCj4gKyAgICAgICAgICAg
ICAgIHBoeXNfYWRkciwgcmVnLT5jaGVja3N1bSwgY3JjMzJfbGUofjAsIGRzdF9hZGRyLCByZWct
PnNpemUpKTsNCj4gKw0KPiAgZXJyX2RtYV9tYXA6DQo+ICAgICAgICAga2ZyZWUoYnVmKTsNCj4g
DQo+IEJ1dCB3aXRoIHRoaXMgSSBnZXQgOg0KDQpJIGRvbid0IGtub3cgd2h5IHRoaXMgaGFwcGVu
IGZvciBub3cuDQoNCjxzbmlwPg0KPiAyOiBJbnN0ZWFkIG9mIGdldF9yYW5kb21fYnl0ZXMoKSBp
biBwY2lfZXBmX3Rlc3Rfd3JpdGUoKSBJIHVzZWQNCj4gbWVtc2V0KCkgd2l0aCB0aGUgZml4ZWQg
dmFsdWUNCjxzbmlwPg0KPiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNp
LWVwZi10ZXN0LmMNCj4gQEAgLTQzMSw2ICs0MzEsOCBAQCBzdGF0aWMgaW50IHBjaV9lcGZfdGVz
dF93cml0ZShzdHJ1Y3QgcGNpX2VwZl90ZXN0ICplcGZfdGVzdCkNCj4gICAgICAgICB9DQo+IA0K
PiAgICAgICAgIGdldF9yYW5kb21fYnl0ZXMoYnVmLCByZWctPnNpemUpOw0KPiArICAgICAgIG1l
bXNldChidWYsIDB4REYsIHJlZy0+c2l6ZSk7DQo+ICAgICAgICAgcmVnLT5jaGVja3N1bSA9IGNy
YzMyX2xlKH4wLCBidWYsIHJlZy0+c2l6ZSk7DQo+IA0KPiBBbmQgbGF0ZXIgZm9yIHRoZSBkc3Qg
YnVmZmVyIEkgZGlkIG1lbXNldCBmb3IgZHN0X2J1ZmZlcg0KPiANCj4gQEAgLTQ3Miw2ICs0NzQs
MTAgQEAgc3RhdGljIGludCBwY2lfZXBmX3Rlc3Rfd3JpdGUoc3RydWN0IHBjaV9lcGZfdGVzdA0K
PiAqZXBmX3Rlc3QpDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAs
IDIwMDApOw0KPiANCj4gKyAgICAgICBtZW1zZXQoZHN0X2FkZHIsIDB4REYsIHJlZy0+c2l6ZSk7
DQoNCkkgdGhpbmsgdGhpcyBtZW1zZXQgaXMgbm90IG5lZWRlZCBiZWNhdXNlIHRoaXMgZnVuY3Rp
b24gY2FsbHMgbWVtY3B5X3RvaW8oZHN0X2FkZHIsIGJ1ZiwuLikuDQoNCj4gKyAgICAgICBkZXZf
ZXJyKGRldiwgIiVzICVsbHggJWxseCBjc3VtOiAleFxuIiwgX19mdW5jX18sIHJlZy0+ZHN0X2Fk
ZHIsDQo+ICsgICAgICAgICAgICAgICBwaHlzX2FkZHIsIHJlZy0+Y2hlY2tzdW0pOw0KPiArDQo+
ICBlcnJfZG1hX21hcDoNCj4gICAgICAgICBrZnJlZShidWYpOw0KPiANCj4gQnV0IHdpdGggdGhp
cyBJIGdldCBzaW1pbGFyIGlzc3VlIGFzIGFib3ZlOg0KDQpJIGRvbid0IGtub3cgd2h5IGxpa2Ug
dGhlIGNhc2UgMSBmb3Igbm93Li4uDQoNCjxzbmlwPg0KPiANCj4gMzogQWZ0ZXIgbWFraW5nIHN1
cmUgLXMgd2FzIGFsaWduZWQgdG8gMTI4IGJ5dGVzIG1lbXNldCBhbmQgY3JjMzJfbGUNCj4gaW4g
cGNpX2VwZl90ZXN0X3dyaXRlKCkgZGlkbnQgaGl0IGFib3ZlIGlzc3VlcywNCj4gIGFuZCBub3cg
d2hlbiBJIGNvbXBhcmVkIHRoZSBjcmMgdmFsdWUgb2YgYm90aCB0aGUgYnVmZmVycyB0aGlzDQo+
IG1hdGNoZWQgb24gZW5kcG9pbnQhDQoNCk9LLg0KDQo+IDQ6IE5vdyBmb2N1c2luZyBtb3JlIGlu
IHJvb3RkZXZpY2UsIEkgYWRkZWQgbWVtc2V0KGJ1ZiwgMHhERiwNCj4gcmVnLT5zaXplKTsgaW4g
cGNpX2VwZl90ZXN0X3dyaXRlKCkgZnVuY3Rpb24NCj4gYW5kIHdhcyBkdW1waW5nIHRoZSBjb250
ZW50cyBvZiBidWZmZXIgaW4gcGNpX2VuZHBvaW50X3Rlc3RfcmVhZCgpDQo+IHdpdGggYmVsb3cg
ZnVuY3Rpb246DQo+IA0KPiBzdGF0aWMgdm9pZCBwcmludF9idWZmZXIoc3RydWN0IGRldmljZSAq
ZGV2LCB2b2lkICpidWZmX2FkZHIsIHNpemVfdCBzaXplKQ0KPiB7DQo+ICAgICBzaXplX3QgaTsN
Cj4gICAgIHU2NCAqYWRkciA9IGJ1ZmZfYWRkcjsNCj4gDQo+ICAgICBmb3IoaSA9IDA7IGkgPCBz
aXplOyBpICs9IHNpemVvZihhZGRyKSkNCj4gICAgICAgICBkZXZfZXJyKGRldiwgImJ1ZlslenVd
IDogJWxseFxuIiwgaSwgKmFkZHIpOw0KPiANCj4gICAgIGRldl9lcnIoZGV2LCAiXG5cblxuXG4i
KTsNCj4gfQ0KPiANCj4gQmVsb3cgaXMgdGhlIGR1bXAgZnJvbSBwY2lfZW5kcG9pbnRfdGVzdF9y
ZWFkKCkgb2Ygb25lIHBhc3NpbmcgY2FzZQ0KPiBhbmQgb3RoZXIgbm8tcGFzc2luZyBjYXNlOg0K
PiBUaGUgY29udGVudHMgb2YgYnVmZmVyIG1hdGNoIGFzIGV4cGVjdGVkLCBidXQgdGhlIGNyYzMy
X2xlIGlzDQo+IGRpZmZlcnJlbnQgYW5kIEkgYW0gY2x1ZS1sZXNzIHdoeSBpcyB0aGlzDQo+IGJl
aW5nIGNhdXNlZCB3aGVuIHVzaW5nIG5vbi1jb2hlcmVudCBtZW1vcnkuDQo+IA0KPiByb290QGhp
aG9wZS1yemcybTp+IyBwY2l0ZXN0IC1yIC1zIDIxNzYNCjxzbmlwPg0KPiBbICA1MjguNTU2OTkx
XSBwY2ktZW5kcG9pbnQtdGVzdCAwMDAwOjAxOjAwLjA6IHBjaV9lbmRwb2ludF90ZXN0X3JlYWQN
Cj4gZmZmZjAwMDRiNjFmOTAwMCA3ZTk1MTAwMCA5MTBjNjkwZD05MTBjNjkwZA0KDQpJJ2QgbGlr
ZSB0byBrbm93IGhvdyB0byBwcmludCB0aGVzZSBjcmMgdmFsdWVzLiBZb3VyIHJlcG9ydCBvbiB0
aGUgY2FzZSAxDQptZW50aW9uZWQgb24gcGNpLWVwZi10ZXN0LmMgbGlrZSBiZWxvdyB0aG91Z2gu
DQoNCj4gKyAgICAgICBkZXZfZXJyKGRldiwgIiVzICVsbHggJWxseCBjc3VtOiAleCA9ICV4XG4i
LCBfX2Z1bmNfXywgcmVnLT5kc3RfYWRkciwNCj4gKyAgICAgICAgICAgICAgIHBoeXNfYWRkciwg
cmVnLT5jaGVja3N1bSwgY3JjMzJfbGUofjAsIGRzdF9hZGRyLCByZWctPnNpemUpKTsNCg0KQWxz
bywgYXMgSSBtZW50aW9uZWQgb24gcHJldmlvdXMgZW1haWwsIHRoaXMgaXMgcG9zc2libGUgdG8g
Y2F1c2UgdGltaW5nIGlzc3VlLg0KU28sIEknZCBsaWtlIHRvIHdoZXJlIHlvdSBhZGRlZCB0aGUg
aGV4ZHVtcCBvbiBwY2lfZW5kcG9pbnRfdGVzdC5jLg0KUGVyaGFwcywgY29weSBhbmQgcGFzdGlu
ZyB5b3VyIHdob2xlIGRlYnVnIGRpZmYgaXMgdXNlZnVsIHRvIHVuZGVyc3RhbmQgYWJvdXQgaXQu
DQoNCj4gUkVBRCAoICAgMjE3NiBieXRlcyk6ICAgICAgICAgICBPS0FZDQo+IHJvb3RAaGlob3Bl
LXJ6ZzJtOn4jIHBjaXRlc3QgLXIgLXMgMjE3Ng0KPHNuaXA+DQo+IFsgIDUzMy40NTc5MjFdIHBj
aS1lbmRwb2ludC10ZXN0IDAwMDA6MDE6MDAuMDogcGNpX2VuZHBvaW50X3Rlc3RfcmVhZA0KPiBm
ZmZmMDAwNGI2MWY5MDAwIDdlOTU5ODAwICBjZTUzNTAzOT05MTBjNjkwZA0KPiBSRUFEICggICAy
MTc2IGJ5dGVzKTogICAgICAgICAgIE5PVCBPS0FZDQo+IA0KPiBOb3RlOiBmb3IgZmFpbHVyZSBj
YXNlIHRoZSBjcmMgaXMgYWx3YXlzIGNlNTM1MDM5DQoNClRoZSB2YWx1ZSBvZiBjZTUzNTAzOSBp
cyBmcm9tIHBjaV9lbmRwb2ludF90ZXN0X3JlYWRsKHRlc3QsIFBDSV9FTkRQT0lOVF9URVNUX0NI
RUNLU1VNKT8NCklmIHNvLCBpdCdzIHN0cmFuZ2UgYmVjYXVzZSBhbGwgMHhkZiB2YWx1ZXMgd2l0
aCAyMTc2IGJ5dGVzIHNob3VsZCBiZSA5MTBjNjkwZCBieSBjcmMzMl9sZSgpLg0KDQpCZXN0IHJl
Z2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
