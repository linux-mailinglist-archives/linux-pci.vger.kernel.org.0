Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97915453A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 14:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBFNpj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 08:45:39 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:54078
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbgBFNpi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 08:45:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJk5DxdufctyaraGWrVPFmIiGIN/e0Aa7d8WQRtLK4JMRe4tGgujmsvTJY1d/AopG1TwiDm4tsA18ZtS/7SEsG7SjZS6g6B4YL1IczqcgXZluG2TOyySTQTKjTCnH32DElDg2ew9jPh5iSXeAk8G6kNv3s9SWKcnlkB+hBGx2X6KfGMSY/WAdI3/wBOXcWpZ1BUiE9agRHJjH1C0d/EMGuGgqw0EmYZYS3nc3dEWYlsoDrqDBjUMqWp1AjHoWVA/+bayD/1k+WWbUTyOCaGn/CHGJr97rf8rigtkrvgelcr/nl3v7dvTS3AS21iFfxYZBfSVV+ki5mTW8ESR+nk9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twv5rjXQHapHuLk7+cf1XMq8HsajBQKIPIT4Edec2/E=;
 b=DAX5/qjWQevCB0DeJU4RJDkcZTXa0v527a10iaVhu1QdoTtbGirk0HOxE0DD1EiGBd8Ii/3asLN3tPrYBZh58P26M7Gi5x7PJ729TMpWyQWQoTOgLG9RAUXVnurdU2k4/y45bUnM7dUtqWRsUfStFJufdJScvOXXcppqALDzgMd0SyA6hZn9PXWhxgFlQIrUTTJkKRN6nFMbJ1TnGm7pv6uHYIyRNqIsBg6xdjhnhoQfGhUy/OTWVHd86FJwX8XCgrJvhGndCLNMnYGiNovFR2sJaLW7PJ8laGBK5qsZmFzk45ZoAA3Z7lnvJmFCZdrygqu+va8VD9mcQ1YPYQNNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twv5rjXQHapHuLk7+cf1XMq8HsajBQKIPIT4Edec2/E=;
 b=DoIm3XTNY9NzTYAURUlpbl/vc395BujgHHSfdIIs2I6uPZEKp8uizOxGpqLOuC399G2rrHxEvOTknlCi/ncqEZQ/8KhcMYzx2CFffbT6q7hhFxS2gl0vJTJ862NRDvmb1DkuwqY6tsLEOI0aVVKJ/Kh87zVepzkD2CFTotUW09Y=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6748.eurprd04.prod.outlook.com (20.179.251.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 13:45:31 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 13:45:31 +0000
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
Subject: RE: [PATCHv9 08/12] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Topic: [PATCHv9 08/12] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Index: AQHVn1UM/CwMe5ZZnEiSNfgmt9Cx/qfoy1uAgCRZKrA=
Date:   Thu, 6 Feb 2020 13:45:31 +0000
Message-ID: <DB8PR04MB6747B7D93859C92276B493B9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-9-Zhiqiang.Hou@nxp.com>
 <20200113113135.GN42593@e119886-lin.cambridge.arm.com>
In-Reply-To: <20200113113135.GN42593@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46510d77-e63f-48b4-878c-08d7ab0ad594
x-ms-traffictypediagnostic: DB8PR04MB6748:|DB8PR04MB6748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB674875A8D034FB910C0A1833841D0@DB8PR04MB6748.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(55016002)(478600001)(4326008)(8936002)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(9686003)(5660300002)(52536014)(86362001)(33656002)(7416002)(6916009)(316002)(26005)(54906003)(71200400001)(186003)(81166006)(7696005)(2906002)(6506007)(53546011)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6748;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KT+YOm4Y6Wp+YdXnMIO4rGN6gb/kk9aCPyjzbZYzcj/bx7WVqd1jVeWncmmEE61+ixlgffGCUmDyE91LP3VfYFoQ1mo44jp6BxkDJteKTl1Dh//bi8ocr8L75PylbUV8Od11Jw860/tWU8jxqt6TerO/i2KrGORUiaGIVcbDYcs9HCUdzG0k6ne3fG/o7eWbq6jKfZfcT9FDzF5BSRYi6RDIR0TxV8lyT9PycTr19aZ/JzL3bMWcbb9MRm4s+nxcP659U8AOh+mDCBdvkqJTEPrGj2gTvWFLoFe51DlPWtVbW8Hdh5CJqTMd2zehF9aq4CjMgLc3eSQa7b9hXhuZoK0zaG8RhbNKpQCmsbkn2h6t7000cLVzDeR5UXaX9gZFQDOIKc6S1/n8pQ6fWRGZ7kPsw2DyUYu6Ige0Ae3cBUOt3RHx7JQ2Donoe52rxv/y
x-ms-exchange-antispam-messagedata: EH8GTHAjnbVJbgpmWaf2PieryDRGWy/zlrCZO2kJxIhaDihFtloco26b4OSAf6CwxBuS9GUK0S4cC18Zw1SKCn7ZwGxcrxizHu8fuOsmQTdEnItNFy7FrMBYWDp+/v5E4cch3bBkxasz1ZNFh6/zTQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46510d77-e63f-48b4-878c-08d7ab0ad594
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:45:31.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+RgWw+3gnaapKNosRwrZZXbsBePEdLnsscYYSNFyRmQUB7MK+vbni9ia9cc+Z+GhzZohNOBue0T9EZi6xSQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6748
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJh
eUBhcm0uY29tPg0KPiBTZW50OiAyMDIwxOox1MIxM8jVIDE5OjMyDQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcu
bGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1
QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFv
DQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjkgMDgvMTJd
IFBDSTogbW9iaXZlaWw6IEFkZCA4LWJpdCBhbmQgMTYtYml0IENTUiByZWdpc3Rlcg0KPiBhY2Nl
c3NvcnMNCj4gDQo+IE9uIFdlZCwgTm92IDIwLCAyMDE5IGF0IDAzOjQ2OjEwQU0gKzAwMDAsIFou
cS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4NCj4gPiBUaGVyZSBhcmUgc29tZSA4LWJpdCBhbmQgMTYtYml0IHJlZ2lzdGVycyBp
biBQQ0llIGNvbmZpZ3VyYXRpb24gc3BhY2UsDQo+ID4gc28gYWRkIHRoZXNlIGFjY2Vzc29ycyBh
Y2NvcmRpbmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlh
bmcuSG91QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFu
LkxpYW5AbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU3VicmFobWFueWEgTGluZ2FwcGEgPGwu
c3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQo+ID4gLS0tDQo+ID4gVjk6DQo+ID4gIC0gTm8g
Y2hhbmdlDQo+ID4NCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZl
aWwuaCAgIHwgMjMNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiA+IGluZGV4IDM3MTE2YzJhMTlmZS4uNzUw
YTdmZDk1YmMxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiBAQCAtMTgyLDEwICsxODIsMzMgQEAgc3RhdGljIGlu
bGluZSB1MzIgbW9iaXZlaWxfY3NyX3JlYWRsKHN0cnVjdA0KPiBtb2JpdmVpbF9wY2llICpwY2ll
LCB1MzIgb2ZmKQ0KPiA+ICAJcmV0dXJuIG1vYml2ZWlsX2Nzcl9yZWFkKHBjaWUsIG9mZiwgMHg0
KTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHUzMiBtb2JpdmVpbF9jc3JfcmVhZHcoc3Ry
dWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUzMg0KPiA+ICtvZmYpIHsNCj4gPiArCXJldHVybiBt
b2JpdmVpbF9jc3JfcmVhZChwY2llLCBvZmYsIDB4Mik7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bmxpbmUgdTMyIG1vYml2ZWlsX2Nzcl9yZWFkYihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwg
dTMyDQo+ID4gK29mZikgew0KPiA+ICsJcmV0dXJuIG1vYml2ZWlsX2Nzcl9yZWFkKHBjaWUsIG9m
ZiwgMHgxKTsgfQ0KPiANCj4gRG8geW91IHRoaW5rIHRoZSBhYm92ZSB0d28gcmV0dXJuIHR5cGVz
IHNob3VsZCByZWZsZWN0IHRoZSBzaXplIG9mIHRoZSBhY2Nlc3M/DQoNCldpbGwgY2hhbmdlIGlu
IHYxMC4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQW5kcmV3
IE11cnJheQ0KPiANCj4gPiArDQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgbW9iaXZl
aWxfY3NyX3dyaXRlbChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZhbCwNCj4gPiAg
CQkJCSAgICAgICB1MzIgb2ZmKQ0KPiA+ICB7DQo+ID4gIAltb2JpdmVpbF9jc3Jfd3JpdGUocGNp
ZSwgdmFsLCBvZmYsIDB4NCk7ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIG1vYml2
ZWlsX2Nzcl93cml0ZXcoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUzMiB2YWwsDQo+ID4g
KwkJCQkgICAgICAgdTMyIG9mZikNCj4gPiArew0KPiA+ICsJbW9iaXZlaWxfY3NyX3dyaXRlKHBj
aWUsIHZhbCwgb2ZmLCAweDIpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgbW9i
aXZlaWxfY3NyX3dyaXRlYihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZhbCwNCj4g
PiArCQkJCSAgICAgICB1MzIgb2ZmKQ0KPiA+ICt7DQo+ID4gKwltb2JpdmVpbF9jc3Jfd3JpdGUo
cGNpZSwgdmFsLCBvZmYsIDB4MSk7IH0NCj4gPiArDQo+ID4gICNlbmRpZiAvKiBfUENJRV9NT0JJ
VkVJTF9IICovDQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
