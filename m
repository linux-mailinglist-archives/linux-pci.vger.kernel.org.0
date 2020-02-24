Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC9169DE9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 06:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBXFta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 00:49:30 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:16293
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgBXFt3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 00:49:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTAHCURwlaIxKwdi/+OSfBLmGUCEtBeZ0fLkPms+icFbhCU/cNC5q6CiPRbm2B13OMUwl3l7eYkqaw0JFOG6Y9TszrXt/e/MXDTcv28rrcLnqb8aYnzo9utfkOEsnpUbQXoHpnWQWJ3Rbyij7GpDtXQfmdfhj2UcdPHvHbWN1f/5aEHhyfUt47KBct99+gn5CDL6B6Z8S5hqcLBZCURqnc+96c90MWD0sdlefSbGQ7Zm70ynPYk/CORgnbikUnTzoez6yg4Ou1o/GDVCZrEI2vWGX7EdQHIJ07drkHxKsU8TYqQSB/SFbv6TLvD0z/VEzyDSEHaX3YmTmUAkLQtD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLLp5XWLGxSmGAS/UhGIMGA/arHDm5FDhtJ7a5T8OjY=;
 b=eoJv7eDaMFk7XfRX/ypmxgENGqzBpGe+SmmlFR/2lG3spFm3aR65hwM5uqycSENFxf37BEVmLkIim00eZqzPHknmkUYbR5Mx4TRVNUI2V8ReA4bTbs3TwgC7vU7GQF4MSC/MTiX3IlwCpLapJ0ApzDMR2xrJh8foelTpYGVB8SvF5J1chDgsNzm2B98ip+mWotLenrGyotm1BDVzxaHMhISCqOoCt/EwRegKsUpBMVpA6hhDKyDMdzAzJECFwQ5XO0l+lzkqyK2EYK+VogoKJ9x27QQ21kDQ9Rd+EITK6XEx5cohQ/84GumZAOHWAuRfGusHpFYUSd8Esg/EOq+e2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLLp5XWLGxSmGAS/UhGIMGA/arHDm5FDhtJ7a5T8OjY=;
 b=ZW1sIQuu9/yrOspSLmxjjLm5p2X8hHLzY6IctcFHUFPbXK3xid31PCk/XpAAzeN6D2szIPTVWdJHTVlRaPcrmB0fjeM5iPDGyx8Z5V+anFo8z7+aKZE4sf+Vn4yXBUAAhSUf5axp+yrhNsEZH0bu65l2jyS20iqIdZ+JA35Svio=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6539.eurprd04.prod.outlook.com (20.179.249.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Mon, 24 Feb 2020 05:49:25 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 05:49:25 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
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
Subject: RE: [PATCHv10 03/13] PCI: mobiveil: Collect the interrupt related
 operations into a function
Thread-Topic: [PATCHv10 03/13] PCI: mobiveil: Collect the interrupt related
 operations into a function
Thread-Index: AQHV4iN1Q2nuT2PtCECRZ1MyVymnnKgkYL4AgAWHGeA=
Date:   Mon, 24 Feb 2020 05:49:25 +0000
Message-ID: <DB8PR04MB674713985AC3E223F6BAEE5684EC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-4-Zhiqiang.Hou@nxp.com>
 <20200220172348.GF19388@big-machine>
In-Reply-To: <20200220172348.GF19388@big-machine>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f61eaf26-2ae9-4afd-0f19-08d7b8ed4e66
x-ms-traffictypediagnostic: DB8PR04MB6539:|DB8PR04MB6539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB653947FBE4505069CD275E9C84EC0@DB8PR04MB6539.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(6916009)(55016002)(9686003)(33656002)(2906002)(186003)(26005)(478600001)(8676002)(8936002)(53546011)(7416002)(4326008)(86362001)(66946007)(7696005)(81156014)(81166006)(76116006)(71200400001)(66556008)(66446008)(5660300002)(316002)(52536014)(54906003)(66476007)(64756008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6539;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 767K3WTREiE+wfbjl5sZVMvefCwuHxg+F2WuZtGRSPLEYY7PAuQEniweBGUyKNBNTTBxvbzaGpcpRSnVtUfP5yjqA2UiveelM1pi4o11rlzPZ+qAkgJvhrqIVYuvwea611UqDFyi10IHktc4N2DbKtNvXFpClskvl6MG8halYg+sGqBIJZBV8OeDdQkSuYdZkOBgnnfFxZhmWEPiu2mz1esoYIs6LmUFgtJl1Wvnil/wfqTQeybtnbeDMEsZJ8i8eZBv0DuCFab5lpsxX7YYjxxxoQg3L3h3j+Vn4pGK1MwcmkYaTTbmxPvNqxr/dibTZD29QWSPBJUYcSNNhlaRt93u67MV5CsPSBfgl46pdwU+VZjzJcZT6tWozEnHd/y0z8kfOJe0H7rwpgxvM4fh0wgDA5+CATXdiLscOe2O+MEYDxno9HY6AyX4MqigNIx4
x-ms-exchange-antispam-messagedata: AVRR5oAMgK4iTWt5a98PRKnq13PF5119py3A6ro5ZlVQ9dIjhrYkcvLLX2zRK1fwFPNcHEPHA3lYx1dN+2Ii7JnKvfBb0bE5saH1zYUueC8FJWs760sfW4Cr2HsHs9uXdj8LMkeVExX7emXEH//z3A==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61eaf26-2ae9-4afd-0f19-08d7b8ed4e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 05:49:25.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvfaEJ64VifUHjes//giGRl2+2UU7hpcnHbBeUYYHOk5jDoghVOggvbuXyQTYclxkgjwXG8Dvr6hkPOvfkgt0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6539
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpUaGFua3MsDQpa
aGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBN
dXJyYXkgPGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs+DQo+IFNlbnQ6IDIwMjDE6jLUwjIx
yNUgMToyNA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRy
ZXcubXVycmF5QGFybS5jb207DQo+IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBt
LmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvDQo+IDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjEwIDAzLzEzXSBQQ0k6IG1v
Yml2ZWlsOiBDb2xsZWN0IHRoZSBpbnRlcnJ1cHQgcmVsYXRlZA0KPiBvcGVyYXRpb25zIGludG8g
YSBmdW5jdGlvbg0KPiANCj4gT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMTI6MDY6MzRQTSArMDgw
MCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+ID4NCj4gPiBDb2xsZWN0IHRoZSBpbnRlcnJ1cHQgaW5pdGlhbGl6YXRp
b24gcmVsYXRlZCBvcGVyYXRpb25zIGludG8gYSBuZXcNCj4gPiBmdW5jdGlvbiBzdWNoIHRoYXQg
aXQgaXMgbW9yZSByZWFkYWJsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IE11cnJh
eSA8YW11cnJheUB0aGVnb29kcGVuZ3Vpbi5jby51az4NCj4gDQo+ID4gLS0tDQo+ID4gVjEwOg0K
PiA+ICAtIFJlZmluZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZSBsb2cuDQo+ID4NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCA2NQ0KPiA+ICsrKysrKysrKysr
KysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAy
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMNCj4gPiBpbmRleCAwMWRmMDRlYTViNDguLjk0NDk1MjhiYjE0ZiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gQEAgLTQ1NCwxMiAr
NDU0LDYgQEAgc3RhdGljIGludCBtb2JpdmVpbF9wY2llX3BhcnNlX2R0KHN0cnVjdA0KPiBtb2Jp
dmVpbF9wY2llICpwY2llKQ0KPiA+ICAJCXJldHVybiBQVFJfRVJSKHBjaWUtPmNzcl9heGlfc2xh
dmVfYmFzZSk7DQo+ID4gIAlwY2llLT5wY2llX3JlZ19iYXNlID0gcmVzLT5zdGFydDsNCj4gPg0K
PiA+IC0JLyogbWFwIE1TSSBjb25maWcgcmVzb3VyY2UgKi8NCj4gPiAtCXJlcyA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJhcGJfY3NyIik7
DQo+ID4gLQlwY2llLT5hcGJfY3NyX2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2Uo
ZGV2LCByZXMpOw0KPiA+IC0JaWYgKElTX0VSUihwY2llLT5hcGJfY3NyX2Jhc2UpKQ0KPiA+IC0J
CXJldHVybiBQVFJfRVJSKHBjaWUtPmFwYl9jc3JfYmFzZSk7DQo+ID4gLQ0KPiA+ICAJLyogcmVh
ZCB0aGUgbnVtYmVyIG9mIHdpbmRvd3MgcmVxdWVzdGVkICovDQo+ID4gIAlpZiAob2ZfcHJvcGVy
dHlfcmVhZF91MzIobm9kZSwgImFwaW8td2lucyIsICZwY2llLT5hcGlvX3dpbnMpKQ0KPiA+ICAJ
CXBjaWUtPmFwaW9fd2lucyA9IE1BWF9QSU9fV0lORE9XUzsNCj4gPiBAQCAtNDY3LDEyICs0NjEs
NiBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfcGFyc2VfZHQoc3RydWN0DQo+IG1vYml2ZWls
X3BjaWUgKnBjaWUpDQo+ID4gIAlpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInBwaW8t
d2lucyIsICZwY2llLT5wcGlvX3dpbnMpKQ0KPiA+ICAJCXBjaWUtPnBwaW9fd2lucyA9IE1BWF9Q
SU9fV0lORE9XUzsNCj4gPg0KPiA+IC0JcnAtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwg
MCk7DQo+ID4gLQlpZiAocnAtPmlycSA8PSAwKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gbWFwIElSUTogJWRcbiIsIHJwLT5pcnEpOw0KPiA+IC0JCXJldHVybiAtRU5PREVWOw0K
PiA+IC0JfQ0KPiA+IC0NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtNjE4
LDkgKzYwNiw2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVp
bF9wY2llDQo+ICpwY2llKQ0KPiA+ICAJcGFiX2N0cmwgfD0gKDEgPDwgQU1CQV9QSU9fRU5BQkxF
X1NISUZUKSB8ICgxIDw8DQo+IFBFWF9QSU9fRU5BQkxFX1NISUZUKTsNCj4gPiAgCW1vYml2ZWls
X2Nzcl93cml0ZWwocGNpZSwgcGFiX2N0cmwsIFBBQl9DVFJMKTsNCj4gPg0KPiA+IC0JbW9iaXZl
aWxfY3NyX3dyaXRlbChwY2llLCAoUEFCX0lOVFBfSU5UWF9NQVNLIHwNCj4gUEFCX0lOVFBfTVNJ
X01BU0spLA0KPiA+IC0JCQkgICAgUEFCX0lOVFBfQU1CQV9NSVNDX0VOQik7DQo+ID4gLQ0KPiA+
ICAJLyoNCj4gPiAgCSAqIHByb2dyYW0gUElPIEVuYWJsZSBCaXQgdG8gMSBhbmQgQ29uZmlnIFdp
bmRvdyBFbmFibGUgQml0IHRvIDEgaW4NCj4gPiAgCSAqIFBBQl9BWElfUElPX0NUUkwgUmVnaXN0
ZXINCj4gPiBAQCAtNjcwLDkgKzY1NSw2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0
KHN0cnVjdCBtb2JpdmVpbF9wY2llDQo+ICpwY2llKQ0KPiA+ICAJdmFsdWUgfD0gKFBDSV9DTEFT
U19CUklER0VfUENJIDw8IDE2KTsNCj4gPiAgCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgdmFs
dWUsIFBBQl9JTlRQX0FYSV9QSU9fQ0xBU1MpOw0KPiA+DQo+ID4gLQkvKiBzZXR1cCBNU0kgaGFy
ZHdhcmUgcmVnaXN0ZXJzICovDQo+ID4gLQltb2JpdmVpbF9wY2llX2VuYWJsZV9tc2kocGNpZSk7
DQo+ID4gLQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC04NzMsNiArODU1
LDQ2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9pbml0X2lycV9kb21haW4oc3RydWN0DQo+
IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4g
K3N0YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9pbnRlcnJ1cHRfaW5pdChzdHJ1Y3QgbW9iaXZlaWxf
cGNpZSAqcGNpZSkgew0KPiA+ICsJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHBjaWUt
PnBkZXY7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3Ry
dWN0IG1vYml2ZWlsX3Jvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7DQo+ID4gKwlzdHJ1Y3QgcmVz
b3VyY2UgKnJlczsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJLyogbWFwIE1TSSBjb25m
aWcgcmVzb3VyY2UgKi8NCj4gPiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUo
cGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJhcGJfY3NyIik7DQo+ID4gKwlwY2llLT5hcGJfY3Ny
X2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsJaWYg
KElTX0VSUihwY2llLT5hcGJfY3NyX2Jhc2UpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKHBjaWUt
PmFwYl9jc3JfYmFzZSk7DQo+ID4gKw0KPiA+ICsJLyogc2V0dXAgTVNJIGhhcmR3YXJlIHJlZ2lz
dGVycyAqLw0KPiA+ICsJbW9iaXZlaWxfcGNpZV9lbmFibGVfbXNpKHBjaWUpOw0KPiA+ICsNCj4g
PiArCXJwLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsJaWYgKHJwLT5p
cnEgPD0gMCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIG1hcCBJUlE6ICVkXG4i
LCBycC0+aXJxKTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwkvKiBpbml0aWFsaXplIHRoZSBJUlEgZG9tYWlucyAqLw0KPiA+ICsJcmV0ID0gbW9iaXZlaWxf
cGNpZV9pbml0X2lycV9kb21haW4ocGNpZSk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2
X2VycihkZXYsICJGYWlsZWQgY3JlYXRpbmcgSVJRIERvbWFpblxuIik7DQo+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRf
ZGF0YShycC0+aXJxLCBtb2JpdmVpbF9wY2llX2lzciwgcGNpZSk7DQo+ID4gKw0KPiA+ICsJLyog
RW5hYmxlIGludGVycnVwdHMgKi8NCj4gPiArCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgKFBB
Ql9JTlRQX0lOVFhfTUFTSyB8DQo+IFBBQl9JTlRQX01TSV9NQVNLKSwNCj4gPiArCQkJICAgIFBB
Ql9JTlRQX0FNQkFfTUlTQ19FTkIpOw0KPiA+ICsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtb2JpdmVpbF9wY2llX2hvc3RfcHJvYmUoc3Ry
dWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpICB7DQo+ID4gIAlzdHJ1Y3QgbW9iaXZlaWxfcm9vdF9w
b3J0ICpycCA9ICZwY2llLT5ycDsgQEAgLTkwNiwxNSArOTI4LDEyIEBADQo+ID4gc3RhdGljIGlu
dCBtb2JpdmVpbF9wY2llX2hvc3RfcHJvYmUoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+
ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JLyogaW5pdGlhbGl6ZSB0aGUg
SVJRIGRvbWFpbnMgKi8NCj4gPiAtCXJldCA9IG1vYml2ZWlsX3BjaWVfaW5pdF9pcnFfZG9tYWlu
KHBjaWUpOw0KPiA+ICsJcmV0ID0gbW9iaXZlaWxfcGNpZV9pbnRlcnJ1cHRfaW5pdChwY2llKTsN
Cj4gPiAgCWlmIChyZXQpIHsNCj4gPiAtCQlkZXZfZXJyKGRldiwgIkZhaWxlZCBjcmVhdGluZyBJ
UlEgRG9tYWluXG4iKTsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkludGVycnVwdCBpbml0IGZhaWxl
ZFxuIik7DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JaXJxX3NldF9j
aGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEocnAtPmlycSwgbW9iaXZlaWxfcGNpZV9pc3IsIHBjaWUp
Ow0KPiA+IC0NCj4gPiAgCS8qIEluaXRpYWxpemUgYnJpZGdlICovDQo+ID4gIAlicmlkZ2UtPmRl
di5wYXJlbnQgPSBkZXY7DQo+ID4gIAlicmlkZ2UtPnN5c2RhdGEgPSBwY2llOw0KPiA+IC0tDQo+
ID4gMi4xNy4xDQo+ID4NCg==
