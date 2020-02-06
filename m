Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0E154313
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgBFLah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:30:37 -0500
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:12228
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbgBFLah (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:30:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpo+vDAMaTztZR0ckxKEcOoEMw1ne9sUvql3iUn1nWUom5hyjhZQy9KjWs227YcZE7q/lDrbyWwU/3viPeWtbEpX2XCjAtrXJuyARWbODalKHgGsDyb5HpPkZR797v/hmiLJ9fUPGbr4AAoGB2KJWKjYD6Og/hSXyT2Ki51zj9MyafcRZdvdEg5jM10KHDU9ggk45PHgQ7yQnpS3MkCF3rEe8sV9aGWKH5/ytOwhT3RjnHp4QepgkDbKjwdIylpfWVvSyoCxDSRQtHbBLyZTAvd/mAW66XfZ9D9lUI1gJy/qiT70vi+VANYTkxXb3zs84T4Hu4VBuVZrlDAfOsVesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Io4TX6LAKmK0W+1EE0p4CWbvyuONhhsXTJr/ANKSU=;
 b=FYdB8AHh6vES4gpRHB0Y90qeYGXzU9co+cS6lh7jMQZ+jJkbF/Ot0KCGH4HZRRXZKmjZqr+dCXnYNufBlrZ7kwLT/zkEimD1ZgzpvV7TKLy84r55vt/fSxYsnAde/zrsbbs+W8X7eTRBg3kb40dLLItvgotH1Hs+ZPlRS34TiABYDH6tfqHF2uJluBgojeC0m0ZDlRxp/se56U707XubupZItETPVmweMZIWfURslm2zT6owS/wTE4awXpylyIu/OV8Ts0pFzeE6tdDkXHsx8UAksoKQpTiIsFYPCRBfPvr2J8G+abTu/Ab7YTt4T/9qdruNjmmaG/bFqSUDLoWPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Io4TX6LAKmK0W+1EE0p4CWbvyuONhhsXTJr/ANKSU=;
 b=ZBUbLZRhpnhxWHJRPS/5HMjv13K0XcFWixOt5nERgbA52cPYH4kc46kvTHhDapgY/fWrT/XPm1eiCNOdVSrsOsiVDT8cpkEL94HI2j1RGPaaQQOQJSLq5D5Hb7lp8IfQp5KaEJDCx0KAF5q97sNrbWGVYUZl2P64qHN3L8rcCkQ=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6553.eurprd04.prod.outlook.com (20.179.251.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Thu, 6 Feb 2020 11:30:26 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 11:30:26 +0000
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
Subject: RE: [PATCHv9 03/12] PCI: mobiveil: Collect the interrupt related
 operations into a routine
Thread-Topic: [PATCHv9 03/12] PCI: mobiveil: Collect the interrupt related
 operations into a routine
Thread-Index: AQHVn1T4QPVpuPxbfUOAcnzZ5mJ3hqfou2sAgCRdAeA=
Date:   Thu, 6 Feb 2020 11:30:26 +0000
Message-ID: <DB8PR04MB6747A8CA819635359CDC73B1841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-4-Zhiqiang.Hou@nxp.com>
 <20200113103431.GI42593@e119886-lin.cambridge.arm.com>
In-Reply-To: <20200113103431.GI42593@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e6429e6-2f5f-4430-4402-08d7aaf7f69a
x-ms-traffictypediagnostic: DB8PR04MB6553:|DB8PR04MB6553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB65533DDB7EA0131FC43D8EB5841D0@DB8PR04MB6553.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(86362001)(52536014)(54906003)(66946007)(76116006)(316002)(33656002)(66476007)(66556008)(64756008)(66446008)(478600001)(7416002)(6916009)(55016002)(5660300002)(4326008)(9686003)(7696005)(71200400001)(186003)(8936002)(81166006)(8676002)(2906002)(81156014)(53546011)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6553;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuwsSekDOrhWgZT1+8dtsNbQB5F3GF1kVssznF1QuluZIRs/rUthWha7yEJfryvSqJPwM3MK0Pui4u4+yn+BNMKlWgakdR1oUjFof4GgAbdo+9gPCecyLoaVkjiUJnLz595xwnL0i6TJagNY+maSnqZkEBJ8rzpF8X+nJjBAclvJ4Qv5yVnTOJ5hVDbm3Go7gHh48E00DIcpNrimDjpBE5Z6XP4rpaHMz+CJmUjUzBY2+91ZgyY/OHYdAg9OhmvkiIJJ6YbU72sywTh/rKSWGuPuco7hVSHhoTYou2tIH+K9xEXDbYNQQEXNeN7rJFaBOkQTfZ5QJzL/ASvnqUzQN5NS6LNoHlv4zdibT3rpFTcA4+fMT8qaSEVSqXPyRK1CRwARn3Z9A6p5rR3Cg+L5QbIwW/gLZSThofU6ozRErk/PgEqeNafLCLbnGtsE9MeP
x-ms-exchange-antispam-messagedata: s+9LKBsSvhVfO2MSEpVfX50/KrvXdGM6iAXogjZTCJTGL8d+HTFHUt4uihBeAh2F09Wlqk997RJ0fUY8SgbAfdzfi22BrnWWDMEAja2Xg7LHWvUYjiqnk43j3eMj40HTaWWEWCHhU20Ie868avKR8w==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6429e6-2f5f-4430-4402-08d7aaf7f69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 11:30:26.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9iEtvvylHyUd6PpcJNu4BxxrFvT11ILTFVYLxN0aOmg/3eKxr6YsItThAYk0NkeDRmSJuDTAT6dFRtbZ+yi4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6553
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJh
eUBhcm0uY29tPg0KPiBTZW50OiAyMDIwxOox1MIxM8jVIDE4OjM1DQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcu
bGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1
QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFv
DQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjkgMDMvMTJd
IFBDSTogbW9iaXZlaWw6IENvbGxlY3QgdGhlIGludGVycnVwdCByZWxhdGVkDQo+IG9wZXJhdGlv
bnMgaW50byBhIHJvdXRpbmUNCj4gDQo+IE9uIFdlZCwgTm92IDIwLCAyMDE5IGF0IDAzOjQ1OjM3
QU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlh
bmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBDb2xsZWN0IHRoZSBpbnRlcnJ1cHQgaW5pdGlhbGl6
YXRpb24gcmVsYXRlZCBvcGVyYXRpb25zIGludG8gYSBuZXcNCj4gPiByb3V0aW5lIHRvIG1ha2Ug
aXQgbW9yZSByZWFkYWJsZS4NCj4gDQo+IEkgcHJlZmVyIHRoZSB3b3JkICdmdW5jdGlvbicgaW5z
dGVhZCBvZiByb3V0aW5lLiBBbHNvIGluZGljYXRlIHdoeSwgbm90IG9ubHkgaXMgaXQNCj4gbmlj
ZXIgYnV0IGl0IGlzIGluIHByZXBhcmF0aW9uIGZvciBFUCBzdXBwb3J0Lg0KDQpXaWxsIHJlcGxh
Y2UgdGhlICdyb3V0aW5lJyB3aXRoICdmdW5jdGlvbicsIGl0IGlzIG9ubHkgdXNlZCBpbiBSQyBt
b2RlLCBub3QgdXNlZCBpbiBFUCBtb2RlLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBWOToNCj4g
PiAgLSBOZXcgcGF0Y2ggc3BsaXRlZCBmcm9tIHRoZSAjMSBvZiBWOCBwYXRjaGVzIHRvIG1ha2Ug
aXQgZWFzeSB0byByZXZpZXcuDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LW1vYml2ZWlsLmMgfCA2NQ0KPiA+ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBpbmRleCA5N2Y2
ODJjYTdjN2EuLjUxMmIyN2EwNTM2ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tb2JpdmVpbC5jDQo+ID4gQEAgLTQ1NCwxMiArNDU0LDYgQEAgc3RhdGljIGludCBtb2Jp
dmVpbF9wY2llX3BhcnNlX2R0KHN0cnVjdA0KPiBtb2JpdmVpbF9wY2llICpwY2llKQ0KPiA+ICAJ
CXJldHVybiBQVFJfRVJSKHBjaWUtPmNzcl9heGlfc2xhdmVfYmFzZSk7DQo+ID4gIAlwY2llLT5w
Y2llX3JlZ19iYXNlID0gcmVzLT5zdGFydDsNCj4gPg0KPiA+IC0JLyogbWFwIE1TSSBjb25maWcg
cmVzb3VyY2UgKi8NCj4gPiAtCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRl
diwgSU9SRVNPVVJDRV9NRU0sDQo+ICJhcGJfY3NyIik7DQo+ID4gLQlwY2llLT5hcGJfY3NyX2Jh
c2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+IC0JaWYgKElT
X0VSUihwY2llLT5hcGJfY3NyX2Jhc2UpKQ0KPiA+IC0JCXJldHVybiBQVFJfRVJSKHBjaWUtPmFw
Yl9jc3JfYmFzZSk7DQo+ID4gLQ0KPiA+ICAJLyogcmVhZCB0aGUgbnVtYmVyIG9mIHdpbmRvd3Mg
cmVxdWVzdGVkICovDQo+ID4gIAlpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgImFwaW8t
d2lucyIsICZwY2llLT5hcGlvX3dpbnMpKQ0KPiA+ICAJCXBjaWUtPmFwaW9fd2lucyA9IE1BWF9Q
SU9fV0lORE9XUzsNCj4gPiBAQCAtNDY3LDEyICs0NjEsNiBAQCBzdGF0aWMgaW50IG1vYml2ZWls
X3BjaWVfcGFyc2VfZHQoc3RydWN0DQo+IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+ID4gIAlpZiAo
b2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInBwaW8td2lucyIsICZwY2llLT5wcGlvX3dpbnMp
KQ0KPiA+ICAJCXBjaWUtPnBwaW9fd2lucyA9IE1BWF9QSU9fV0lORE9XUzsNCj4gPg0KPiA+IC0J
cnAtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gLQlpZiAocnAtPmlycSA8
PSAwKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gbWFwIElSUTogJWRcbiIsIHJw
LT5pcnEpOw0KPiA+IC0JCXJldHVybiAtRU5PREVWOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgCXJl
dHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtNjE4LDkgKzYwNiw2IEBAIHN0YXRpYyBpbnQg
bW9iaXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llDQo+ICpwY2llKQ0KPiA+ICAJ
cGFiX2N0cmwgfD0gKDEgPDwgQU1CQV9QSU9fRU5BQkxFX1NISUZUKSB8ICgxIDw8DQo+IFBFWF9Q
SU9fRU5BQkxFX1NISUZUKTsNCj4gPiAgCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgcGFiX2N0
cmwsIFBBQl9DVFJMKTsNCj4gPg0KPiA+IC0JbW9iaXZlaWxfY3NyX3dyaXRlbChwY2llLCAoUEFC
X0lOVFBfSU5UWF9NQVNLIHwNCj4gUEFCX0lOVFBfTVNJX01BU0spLA0KPiA+IC0JCQkgICAgUEFC
X0lOVFBfQU1CQV9NSVNDX0VOQik7DQo+ID4gLQ0KPiA+ICAJLyoNCj4gPiAgCSAqIHByb2dyYW0g
UElPIEVuYWJsZSBCaXQgdG8gMSBhbmQgQ29uZmlnIFdpbmRvdyBFbmFibGUgQml0IHRvIDEgaW4N
Cj4gPiAgCSAqIFBBQl9BWElfUElPX0NUUkwgUmVnaXN0ZXINCj4gPiBAQCAtNjcwLDkgKzY1NSw2
IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llDQo+
ICpwY2llKQ0KPiA+ICAJdmFsdWUgfD0gKFBDSV9DTEFTU19CUklER0VfUENJIDw8IDE2KTsNCj4g
PiAgCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgdmFsdWUsIFBBQl9JTlRQX0FYSV9QSU9fQ0xB
U1MpOw0KPiA+DQo+ID4gLQkvKiBzZXR1cCBNU0kgaGFyZHdhcmUgcmVnaXN0ZXJzICovDQo+ID4g
LQltb2JpdmVpbF9wY2llX2VuYWJsZV9tc2kocGNpZSk7DQo+ID4gLQ0KPiA+ICAJcmV0dXJuIDA7
DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC04NzMsNiArODU1LDQ2IEBAIHN0YXRpYyBpbnQgbW9iaXZl
aWxfcGNpZV9pbml0X2lycV9kb21haW4oc3RydWN0DQo+IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+
ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgbW9iaXZlaWxfcGNp
ZV9pbnRlcnJ1cHRfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkgew0KPiA+ICsJc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHBjaWUtPnBkZXY7DQo+ID4gKwlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IHJvb3RfcG9ydCAqcnAgPSAmcGNp
ZS0+cnA7DQo+ID4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiArCWludCByZXQ7DQo+ID4g
Kw0KPiA+ICsJLyogbWFwIE1TSSBjb25maWcgcmVzb3VyY2UgKi8NCj4gPiArCXJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJhcGJfY3Ny
Iik7DQo+ID4gKwlwY2llLT5hcGJfY3NyX2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3Vy
Y2UoZGV2LCByZXMpOw0KPiA+ICsJaWYgKElTX0VSUihwY2llLT5hcGJfY3NyX2Jhc2UpKQ0KPiA+
ICsJCXJldHVybiBQVFJfRVJSKHBjaWUtPmFwYl9jc3JfYmFzZSk7DQo+ID4gKw0KPiA+ICsJLyog
c2V0dXAgTVNJIGhhcmR3YXJlIHJlZ2lzdGVycyAqLw0KPiA+ICsJbW9iaXZlaWxfcGNpZV9lbmFi
bGVfbXNpKHBjaWUpOw0KPiANCj4gRG9lcyB0aGlzIG5lZWQgdG8gY29tZSBhZnRlciBtb2JpdmVp
bF9wY2llX2luaXRfaXJxX2RvbWFpbiAtIGdpdmVuIHRoYXQgdGhpcw0KPiBmdW5jdGlvbiBzZXRz
IHVwIHRoZSBpcnEgZG9tYWluIGZvciBNU0k/DQoNCk5vLCBJIGRvbid0IHRoaW5rIHNvLCBiZWNh
dXNlIEkgZGlkbid0IGNoYW5nZSB0aGUgcmVsYXRpdmUgb3JkZXIgb2YgdGhlIDIgZnVuY3Rpb25z
DQp5b3UgbWVudGlvbmVkLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBBbmRyZXcgTXVycmF5DQo+IA0KPiA+ICsNCj4gPiArCXJwLT5pcnEgPSBwbGF0Zm9ybV9n
ZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsJaWYgKHJwLT5pcnEgPD0gMCkgew0KPiA+ICsJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIG1hcCBJUlE6ICVkXG4iLCBycC0+aXJxKTsNCj4gPiArCQlyZXR1
cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBpbml0aWFsaXplIHRoZSBJUlEg
ZG9tYWlucyAqLw0KPiA+ICsJcmV0ID0gbW9iaXZlaWxfcGNpZV9pbml0X2lycV9kb21haW4ocGNp
ZSk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJGYWlsZWQgY3JlYXRp
bmcgSVJRIERvbWFpblxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YShycC0+aXJxLCBtb2JpdmVpbF9w
Y2llX2lzciwgcGNpZSk7DQo+ID4gKw0KPiA+ICsJLyogRW5hYmxlIGludGVycnVwdHMgKi8NCj4g
PiArCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgKFBBQl9JTlRQX0lOVFhfTUFTSyB8DQo+IFBB
Ql9JTlRQX01TSV9NQVNLKSwNCj4gPiArCQkJICAgIFBBQl9JTlRQX0FNQkFfTUlTQ19FTkIpOw0K
PiA+ICsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgaW50IG1v
Yml2ZWlsX3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkgIHsNCj4g
PiAgCXN0cnVjdCByb290X3BvcnQgKnJwID0gJnBjaWUtPnJwOw0KPiA+IEBAIC05MDYsMTUgKzky
OCwxMiBAQCBpbnQgbW9iaXZlaWxfcGNpZV9ob3N0X3Byb2JlKHN0cnVjdA0KPiBtb2JpdmVpbF9w
Y2llICpwY2llKQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCS8qIGlu
aXRpYWxpemUgdGhlIElSUSBkb21haW5zICovDQo+ID4gLQlyZXQgPSBtb2JpdmVpbF9wY2llX2lu
aXRfaXJxX2RvbWFpbihwY2llKTsNCj4gPiArCXJldCA9IG1vYml2ZWlsX3BjaWVfaW50ZXJydXB0
X2luaXQocGNpZSk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJGYWls
ZWQgY3JlYXRpbmcgSVJRIERvbWFpblxuIik7DQo+ID4gKwkJZGV2X2VycihkZXYsICJJbnRlcnJ1
cHQgaW5pdCBmYWlsZWRcbiIpOw0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4NCj4g
PiAtCWlycV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKHJwLT5pcnEsIG1vYml2ZWlsX3Bj
aWVfaXNyLCBwY2llKTsNCj4gPiAtDQo+ID4gIAkvKiBJbml0aWFsaXplIGJyaWRnZSAqLw0KPiA+
ICAJYnJpZGdlLT5kZXYucGFyZW50ID0gZGV2Ow0KPiA+ICAJYnJpZGdlLT5zeXNkYXRhID0gcGNp
ZTsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
