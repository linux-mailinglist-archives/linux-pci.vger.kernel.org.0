Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA2139F52
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 03:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgANCHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 21:07:46 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29292 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgANCHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 21:07:45 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Kelvin.Cao@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Kelvin.Cao@microchip.com";
  x-sender="Kelvin.Cao@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Kelvin.Cao@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Kelvin.Cao@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0ULtDtXnycbAaobBiV/tZL9BvLzh2g9zL3ruYFF2K18ixyyCJdnawzl8VZLRvoOHmgQZBjGuIa
 pE6VVSa8eK9hb5PdoQmRbtNelbdmwdMWnH0GXS6bHhCCrTyKO60eqRC2axqaygUhqUomYw9wM6
 QMrDxm2J0TXxYvOBqMeWwxrY61werGmDOjz2NeCpY5JkpikXXVBum04EJG985ko+4K4M8HtLTC
 vl7YxinX4lo46wUXyyt+6nCjZP8t26ihR+fk/JOkhZFYePKSOr35jsWOpzjQE2OoI3kD1Rc30e
 SaA=
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="62514124"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 19:07:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 19:07:42 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jan 2020 19:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv233fqZzqErdbk87XMZ8Rhwc8ByOwNeDO3faLuHaZmpHweBw4/E2ogeQwXcGeKhw41encVLxetGw8QsxbD3m6CLMBOWoteiW1wVH3PakQAsVgfOfRkMNPJjt9Nyz5j2tbCHmU0dQRLomcg7mlmarAodIgfA7mQ+lBZs8pAEataCf8lHsu8f/EHjCvG/cux1O3JsmxQTP9BcmKLgriuKFji1QPZ4FvtTAjgZPlmFzBoRCSP0SSNp4/xay4MOWxzwQ4d65+CpmTaF5O4m91xDPRfBJvoQsTYAbCnM/hJxiUUw9ptX5kyI9bsVcbyjsTe1RGqCVVm/7U7CH2f9L9r4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPegoCrVsmC7tQZ5qKqQNmOoAEYlMjZ0fKruR3mvgyQ=;
 b=khrI3yj8jgyrDoARMhjxxLVkK3Ij1MLbG5THy+NWdFlAiJoVTlKWtQXm4BtP0YU6f3z1LAHECsjK1yKtICw+Gna33Aex5EduxU6D1H4nCW/cQ+ZjUXgiOhFX/dbHyOF7XwOVZC8ERFofqF/LfC2QfqXPjN40e4lUakyepsgCzQy6jFAchlENdpukscRTHH9sXTQV7oB42XT9ISadJovantqoR3xCIFC6w/0LxDv90UA4tI1vj4T3vtVnLuby4aVAkk8aH9Edsd0w4o3IIrexWnSfZrsKTaYGzta2rnBQmNzbFYOgWbmJKJJ4+/DfdvlcGXMHN05nv354twrHaYjwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPegoCrVsmC7tQZ5qKqQNmOoAEYlMjZ0fKruR3mvgyQ=;
 b=pI9aN+RGRKWBYhc5pqPvHYpUw6o68Rpy7hJUcOIEpREIuhfMnyW6XSK48wlyc20NyOWyLN2GEleBLq2scug0Xw+qAYWi88SpkX6LZAG5R2X4vgTu0gJnfGLTZwW28EZX6D27CWctjBTsrk4DJU5Cu8MH4GoK+eKye8AuNb2oOTg=
Received: from BY5PR11MB4354.namprd11.prod.outlook.com (52.132.255.144) by
 BY5PR11MB3976.namprd11.prod.outlook.com (10.255.160.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 02:07:42 +0000
Received: from BY5PR11MB4354.namprd11.prod.outlook.com
 ([fe80::a020:5871:bf10:bde0]) by BY5PR11MB4354.namprd11.prod.outlook.com
 ([fe80::a020:5871:bf10:bde0%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 02:07:42 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <logang@deltatee.com>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <epilmore@gigaio.com>, <dmeyer@gigaio.com>
Subject: RE: [PATCH 03/12] PCI/switchtec: Add support for new events
Thread-Topic: [PATCH 03/12] PCI/switchtec: Add support for new events
Thread-Index: AQHVxMQVt2wmhhFHXU6uO7gBQHc6eKfhTQqAgAAD/QCACCM4IA==
Date:   Tue, 14 Jan 2020 02:07:42 +0000
Message-ID: <BY5PR11MB4354178CD58A467995EC22F88D340@BY5PR11MB4354.namprd11.prod.outlook.com>
References: <20200108213337.GA210184@google.com>
 <302aff9f-ff12-027c-80c8-2af2afca8359@deltatee.com>
In-Reply-To: <302aff9f-ff12-027c-80c8-2af2afca8359@deltatee.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [211.144.195.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f9f9754-a849-4242-c5fb-08d798968a51
x-ms-traffictypediagnostic: BY5PR11MB3976:
x-microsoft-antispam-prvs: <BY5PR11MB3976988C16376B3378D3404B8D340@BY5PR11MB3976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(33656002)(5660300002)(186003)(7696005)(26005)(71200400001)(53546011)(6506007)(4326008)(52536014)(81166006)(66556008)(9686003)(64756008)(66446008)(81156014)(316002)(8676002)(66476007)(2906002)(478600001)(110136005)(8936002)(76116006)(55016002)(66946007)(54906003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3976;H:BY5PR11MB4354.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDDJBA7MVTaBJj7RaTNdPjtO5jDKY2iWChSERE7SrUKwc9pdTNjwbGA83euf2Yt5EYoTsoindxgLc/HOR+OU2przmmRBXXwSmdbiIXv17CV6DrjqJ79ivQjUd5oBwbsy89SeiFP1e5zMaoZSLdtTxABIM2781uo5GogReZgQRmogaR/WRg7IuQaSak/y0Rl1Qk3j5ISWLPm2GVv4Vm0CaXsNE19KSrDaIaPD2bWg6SFO/1kSmh4qT2VuMCtbzuJNmIK7ZdsMsLBmt7znYZK42R8w7OeZDQQ51FkDtFhyMQBnh9JydVYijFusvSUDg9C8k/EZmqRXX3WnLFtauSNkIbmgybPN8bs7HdhXubUr/7NLhLXxUsvIFVzhQefwHN3yAfsOAvqOtXVdu8POytd9Ld+eIK15UURTSzH443zi6qEDdXpiKGAvIlmUJ+1nvUXB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9f9754-a849-4242-c5fb-08d798968a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 02:07:42.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlWGIarFXpIo1pIZmYiQKFJ1RzugmgvDoFV2JiENV5ipk13uEgLy8PWQKhegKtxhj/2QyXs/VqLzLkyf/OTu3Vw4U6Q1ANdp8GsKgruNRUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3976
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J0ludGVyQ29tbScgaXMgdGhlIHNwZWxsaW5nIGluIHRoZSBsYXRlc3QgZGF0YXNoZWV0LCBpdCdz
IHNob3J0IGZvciAiSW50ZXIgRmFicmljIE1hbmFnZXIgQ29tbXVuaWNhdGlvbiIuIFRoYW5rcy4N
Cg0KS2VsdmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb2dhbiBHdW50
aG9ycGUgW21haWx0bzpsb2dhbmdAZGVsdGF0ZWUuY29tXSANClNlbnQ6IFRodXJzZGF5LCBKYW51
YXJ5IDksIDIwMjAgNTo0OCBBTQ0KVG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9y
Zz4NCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBLZWx2aW4gQ2FvIC0gQTMxMDYwIDxLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20+OyBF
cmljIFBpbG1vcmUgPGVwaWxtb3JlQGdpZ2Fpby5jb20+OyBEb3VnIE1leWVyIDxkbWV5ZXJAZ2ln
YWlvLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDMvMTJdIFBDSS9zd2l0Y2h0ZWM6IEFkZCBz
dXBwb3J0IGZvciBuZXcgZXZlbnRzDQoNCkVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KDQpPbiAyMDIwLTAxLTA4IDI6MzMgcC5tLiwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gT24g
TW9uLCBKYW4gMDYsIDIwMjAgYXQgMTI6MDM6MjhQTSAtMDcwMCwgTG9nYW4gR3VudGhvcnBlIHdy
b3RlOg0KPj4gVGhlIGludGVyY29tbSBub3RpZnkgIGV2ZW50IHdhcyBhZGRlZCBmb3IgUEFYIHZh
cmlhbnRzIG9mIHN3aXRjaHRlYyANCj4+IGhhcmR3YXJlIGFuZCB0aGUgVUVDIFBvcnQgd2FzIGFk
ZGVkIGZvciB0aGUgTVIxIHJlbGVhc2Ugb2YgR0VOMyBmaXJtd2FyZS4NCj4NCj4gRG8gdGhleSBh
Y3R1YWxseSBzcGVsbCBpdCAiaW50ZXJjb21tIiBpbiB0aGUgZGF0YXNoZWV0PyAgU2VlbXMgbGlr
ZSANCj4gdGhlIG1vc3QgY29tbW9uIEVuZ2xpc2ggc3BlbGxpbmcgaXMgImludGVyY29tIi4NCg0K
SG1tLCBub3Qgc3VyZSBJIGRvbid0IGhhdmUgdGhpcyBldmVudCBpbiBteSBkYXRhc2hlZXQgd2hp
Y2ggaXMgYSBsaXR0bGUgb3V0IG9mIGRhdGUuIEtlbHZpbiwgd2hvc2UgQ0MnZCwgd291bGQga25v
dyBpZiB3ZSBjYW4gY2hhbmdlIHRoZSBzcGVsbGluZyBob3BlZnVsbHkgaGUgY2FuIHdlaWdoIGlu
IG9uIHRoaXMuIEFzIGZhciBhcyBJIGtub3cgdGhlIGRlZmluZSBpc24ndCB1c2VkIGFueXdoZXJl
IHlldC4NCg0KPiBJcyB0aGVyZSBzb21lIG1lYW5pbmdmdWwgZXhwYW5zaW9uIG9mICJVRUMiPw0K
DQpVcHN0cmVhbSBFcnJvciBDb250YWlubWVudCAtLSBJJ2xsIG1lbnRpb24gdGhhdCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQoNCkxvZ2FuDQoNCg0KPj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3Vu
dGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9wY2kvc3dp
dGNoL3N3aXRjaHRlYy5jICAgICAgIHwgMyArKysNCj4+ICBpbmNsdWRlL2xpbnV4L3N3aXRjaHRl
Yy5oICAgICAgICAgICAgfCA3ICsrKysrLS0NCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvc3dpdGNo
dGVjX2lvY3RsLmggfCA0ICsrKy0NCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3N3aXRj
aC9zd2l0Y2h0ZWMuYyANCj4+IGIvZHJpdmVycy9wY2kvc3dpdGNoL3N3aXRjaHRlYy5jIGluZGV4
IDljM2FkMDlkMzAyMi4uMjE4ZTY3NDI4Y2Y5IA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L3BjaS9zd2l0Y2gvc3dpdGNodGVjLmMNCj4+ICsrKyBiL2RyaXZlcnMvcGNpL3N3aXRjaC9zd2l0
Y2h0ZWMuYw0KPj4gQEAgLTc1MSwxMCArNzUxLDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXZl
bnRfcmVnIHsNCj4+ICAgICAgRVZfUEFSKFNXSVRDSFRFQ19JT0NUTF9FVkVOVF9NUlBDX0NPTVAs
IG1ycGNfY29tcF9oZHIpLA0KPj4gICAgICBFVl9QQVIoU1dJVENIVEVDX0lPQ1RMX0VWRU5UX01S
UENfQ09NUF9BU1lOQywgbXJwY19jb21wX2FzeW5jX2hkciksDQo+PiAgICAgIEVWX1BBUihTV0lU
Q0hURUNfSU9DVExfRVZFTlRfRFlOX1BBUlRfQklORF9DT01QLCANCj4+IGR5bl9iaW5kaW5nX2hk
ciksDQo+PiArICAgIEVWX1BBUihTV0lUQ0hURUNfSU9DVExfRVZFTlRfSU5URVJDT01NX1JFUV9O
T1RJRlksDQo+PiArICAgICAgICAgICBpbnRlcmNvbW1fbm90aWZ5X2hkciksDQo=
