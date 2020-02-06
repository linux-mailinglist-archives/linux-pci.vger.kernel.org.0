Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3461542C6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBFLO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:14:26 -0500
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:2978
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbgBFLO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:14:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvWeYX20jxGINhbr9j4qRn6LZ5TWy1/DOoPQYqf2fJ29lii1iW0qnAPvVF32vWVw2E+blKaq6ATMGi3QJTtOcYkeLD4zCYc4WERmDkUPgBzePBB+yjR2+qnGHMDViKz13r2CTfBkWksbRDyl8beXM3HsyVr9RM4XpCh6N4nPWW2hkEC8zFCQon/IjRgw2fPi9RSYfdR4eKozSe8vFs7cQmm7OcF51QYelM5/DIFqcDuNaNaaLoIrQxXzUK9uHCP1DZrGh/RtUQw+Rmpt1DwqebwwcgvML3yUhZy6vkhth3UunsqsyciGS6ViMRPa1wwMY1OQ+2G6wCnSH1xBRsW1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNBuk4MGy0uXSfRU75NF2AeEqyXrAyPLFaHBRm0Uue4=;
 b=BaC5A/I9YJPix+gijo80UyB3gEXLPxXaG7W/UAAxKcJ3XhRFXZdbeTigYlwfODD35wqdfABwUbEMa5HzyCdwVYZCY4i7NSqvmM2FMOZlXnf1Wg0Y14rVRBc7yUNssYyTKTUcKmi7gh/MLFI29RlbPJ9/TxNR1zD4KlLM9FGQ6IbbVQCoUD1kKCkbHN2d9jaf2/GEibxOTCT7lFYPMNlOEoqxDY4AYpR5QZRr0Nf/dw4JzmAC70jR9I+aQ3K4QbBnfladExi5Xan3Ut4IBf/TYifASSosvb/kCXsjExDWbNGjSsZPeH8X9bhtmOmFuC5t3qn60ogs9AzXt8M2+Uevzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNBuk4MGy0uXSfRU75NF2AeEqyXrAyPLFaHBRm0Uue4=;
 b=OW7cZD0mfgmBdJcxQ59XeYRMAPaRGy0FEwLseevY/d7J7eot9eKhSgQvyA7wesMY81h2JinjHPzh9Z/Xy9dVfyBYg1vXvck3p3o3q7mlSG5xpOjkmY01kFhilm3QMBwJjnQOt6kCpsWey70Ys3DTMxRLuK4Jba+3MeoxuVXd8Qo=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5755.eurprd04.prod.outlook.com (20.179.11.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 6 Feb 2020 11:14:21 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 11:14:21 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv9 02/12] PCI: mobiveil: Move the host initialization into
 a routine
Thread-Topic: [PATCHv9 02/12] PCI: mobiveil: Move the host initialization into
 a routine
Thread-Index: AQHVn1T0j1qfl+edyE6Gq9MkhB5hBKfotyIAgCQ7HmA=
Date:   Thu, 6 Feb 2020 11:14:21 +0000
Message-ID: <DB8PR04MB674737224E5914240BE2BC62841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-3-Zhiqiang.Hou@nxp.com>
 <20200113101912.GH42593@e119886-lin.cambridge.arm.com>
In-Reply-To: <20200113101912.GH42593@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fae59b0b-a648-41d0-1c9d-08d7aaf5b771
x-ms-traffictypediagnostic: DB8PR04MB5755:|DB8PR04MB5755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5755A10D11478030FBFD7BD4841D0@DB8PR04MB5755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(66556008)(55016002)(66476007)(66946007)(71200400001)(478600001)(76116006)(4326008)(52536014)(5660300002)(64756008)(186003)(8676002)(66446008)(54906003)(2906002)(6506007)(53546011)(7416002)(8936002)(33656002)(316002)(81166006)(6916009)(86362001)(7696005)(81156014)(9686003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5755;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3f+XoxlPujMHmS8pzW9kCyV0kuFMrkLe0val+CUIEP4ZPqmfebz1MU889ksL0He3s0wQaWdvqVyAYCftiAPHUJ9aw/arZF65s9Ksm+DWUhrJVIBu7uineBhKbfmBNe+K848VtQtV6d+qjKmdpR5j9U6n5AAfxXAFotvTiK4/9XPVpnDn18zhBvAZFVI3tV3vRTH8134q6fB/GaHt+0rgzrOBakMoxLhmDj4x5c3n2NedwqAvShxqwAWehLCtTZRA6rD0tqpDyDpCyviiIF+xEgW5EHA31cbsHtUv8IVvHDymaDMkPcuDQJJm/m4UhTffidpbePVnBiemcQhRIA4dlU7K7gMQRL5YnygKa1i05thz53WiLWNZbl/+SJ6XkZD6wOIPbIv2QLeHsFRGn13WXH/T7UFao7m+g1ix15qQQUGy3L+8ENA6O6M9ys0fEbSe
x-ms-exchange-antispam-messagedata: 2Gt5233aEUcE+fGo/IfLHpr5rMUPW/UtzjMlbqhZ6OS77UKB1pcxgF+ufqqs3Lki0f/RImQmBk5Tk/6P37fmrPgxgqcskcgrDcnjoV6nTUejlY25bW9cCQuz5a+2+0biBNS8M6Ehdk16BQk1pjcMXA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae59b0b-a648-41d0-1c9d-08d7aaf5b771
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 11:14:21.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os6UVE7744Hg+wBTuOqDoId/f6rqlveFHMC60ZCmulnTpnDbfUjtFY6s8S2A4xgjMAcWAiYri+MffdAiY2IgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5755
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJh
eUBhcm0uY29tPg0KPiBTZW50OiAyMDIwxOox1MIxM8jVIDE4OjE5DQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcu
bGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1
QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFv
DQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjkgMDIvMTJd
IFBDSTogbW9iaXZlaWw6IE1vdmUgdGhlIGhvc3QgaW5pdGlhbGl6YXRpb24gaW50byBhDQo+IHJv
dXRpbmUNCj4gDQo+IE9uIFdlZCwgTm92IDIwLCAyMDE5IGF0IDAzOjQ1OjMwQU0gKzAwMDAsIFou
cS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4NCj4gPiBNb3ZlIHRoZSBob3N0IGluaXRpYWxpemF0aW9uIHJlbGF0ZWQgb3BlcmF0
aW9ucyBpbnRvIGEgbmV3IHJvdXRpbmUgdG8NCj4gPiBtYWtlIGl0IGNhbiBiZSByZXVzZWQgYnkg
b3RoZXIgaW5jb21pbmcgcGxhdGZvcm0ncw0KPiANCj4gcy90byBtYWtlL3N1Y2ggdGhhdC8NCj4g
DQo+ICdmdW5jdGlvbicgaXMgcHJvYmFibHkgYSBiZXR0ZXIgd29yZCB0aGFuICdyb3V0aW5lJy4N
Cj4gDQoNCldpbGwgY2hhbmdlIGluIHYxMC4NCg0KPiANCj4gPiBQQ0llIGhvc3QgZHJpdmVyLCBp
biB3aGljaCB0aGUgTW9iaXZlaWwgR1BFWCBpcyBpbnRlZ3JhdGVkLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiBWOToNCj4gPiAgLSBOZXcgcGF0Y2ggc3BsaXRlZCBmcm9tIHRoZSAjMSBvZiBWOCBwYXRjaGVz
IHRvIG1ha2UgaXQgZWFzeSB0byByZXZpZXcuDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgfCAzOA0KPiA+ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZl
aWwuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBp
bmRleCA1ZmQyNmUzNzZhZjIuLjk3ZjY4MmNhN2M3YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gQEAgLTg3MywyNyArODczLDE1IEBAIHN0YXRp
YyBpbnQgbW9iaXZlaWxfcGNpZV9pbml0X2lycV9kb21haW4oc3RydWN0DQo+IG1vYml2ZWlsX3Bj
aWUgKnBjaWUpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQg
bW9iaXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICtp
bnQgbW9iaXZlaWxfcGNpZV9ob3N0X3Byb2JlKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0K
PiANCj4gVGhpcyBpcyBubyBsb25nZXIgc3RhdGljIC0gYnV0IGRvIHlvdSBuZWVkIHRvIGFkZCBh
IGhlYWRlciBmaWxlIHNvbWV3aGVyZT8NCg0KVGhlIGZ1bmN0aW9uIG1vYml2ZWlsX3BjaWVfcHJv
YmUoKSBpcyBzdGlsbCBzdGF0aWMgYmVsb3csIHRoZQ0KbW9iaXZlaWxfcGNpZV9ob3N0X3Byb2Jl
KCkgaXMgbmV3IGludHJvZHVjZWQgb25lLCBpdCBpcyBub3cgb25seSB1c2VkIGluIHRoaXMNCi5j
IGZpbGUsIHNvIEknbGwgY2hhbmdlIGl0IHRvIGEgc3RhdGljIGZ1bmN0aW9uIGluIHYxMC4NCg0K
PiANCj4gDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llOw0KPiA+ICsJ
c3RydWN0IHJvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3Rf
YnJpZGdlICpicmlkZ2UgPSBycC0+YnJpZGdlOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
JnBjaWUtPnBkZXYtPmRldjsNCj4gPiAgCXN0cnVjdCBwY2lfYnVzICpidXM7DQo+ID4gIAlzdHJ1
Y3QgcGNpX2J1cyAqY2hpbGQ7DQo+ID4gLQlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2U7
DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+IC0Jc3RydWN0IHJv
b3RfcG9ydCAqcnA7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQkvKiBhbGxvY2F0ZSB0aGUg
UENJZSBwb3J0ICovDQo+ID4gLQlicmlkZ2UgPSBkZXZtX3BjaV9hbGxvY19ob3N0X2JyaWRnZShk
ZXYsIHNpemVvZigqcGNpZSkpOw0KPiA+IC0JaWYgKCFicmlkZ2UpDQo+ID4gLQkJcmV0dXJuIC1F
Tk9NRU07DQo+ID4gLQ0KPiA+IC0JcGNpZSA9IHBjaV9ob3N0X2JyaWRnZV9wcml2KGJyaWRnZSk7
DQo+ID4gLQlycCA9ICZwY2llLT5ycDsNCj4gPiAtCXJwLT5icmlkZ2UgPSBicmlkZ2U7DQo+ID4g
LQ0KPiA+IC0JcGNpZS0+cGRldiA9IHBkZXY7DQo+ID4gLQ0KPiA+ICAJcmV0ID0gbW9iaXZlaWxf
cGNpZV9wYXJzZV9kdChwY2llKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZfZXJyKGRl
diwgIlBhcnNpbmcgRFQgZmFpbGVkLCByZXQ6ICV4XG4iLCByZXQpOyBAQCAtOTU2LDYNCj4gPiAr
OTQ0LDI0IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMg
aW50IG1vYml2ZWlsX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0K
PiA+ICsJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWU7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3Rf
YnJpZGdlICpicmlkZ2U7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiA+ICsNCj4gPiArCWJyaWRnZSA9IGRldm1fcGNpX2FsbG9jX2hvc3RfYnJpZGdlKGRldiwgc2l6
ZW9mKCpwY2llKSk7DQo+IA0KPiBZb3UndmUgbG9zdCB0aGUgY29tbWVudCB0aGF0IHdhcyBhYm92
ZSB0aGlzLg0KDQpXaWxsIGFkZCBpdCBiYWNrLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBBbmRyZXcgTXVycmF5DQo+IA0KPiA+ICsJaWYgKCFicmlkZ2UpDQo+
ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJcGNpZSA9IHBjaV9ob3N0X2JyaWRn
ZV9wcml2KGJyaWRnZSk7DQo+ID4gKwlwY2llLT5ycC5icmlkZ2UgPSBicmlkZ2U7DQo+ID4gKw0K
PiA+ICsJcGNpZS0+cGRldiA9IHBkZXY7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG1vYml2ZWlsX3Bj
aWVfaG9zdF9wcm9iZShwY2llKTsgfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbW9iaXZlaWxfcGNpZV9vZl9tYXRjaFtdID0gew0KPiA+ICAJey5jb21wYXRp
YmxlID0gIm1idmwsZ3BleDQwLXBjaWUiLH0sDQo+ID4gIAl7fSwNCj4gPiAtLQ0KPiA+IDIuMTcu
MQ0KPiA+DQo=
