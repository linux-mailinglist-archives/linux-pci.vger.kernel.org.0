Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7F226157
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgGTNwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 09:52:47 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:32386
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgGTNwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jul 2020 09:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNvltTmw7Hly4zY6J3qTCQYEpsUMLxX4sTpKdZDQ34Z1pO5b7tT0LwMI9kggTZ5YxRJs0hqmVlOy3GQ/rTGfaa2RP7ILB6cG42+aKen/kAQ4nBM7pdtsALClsFIbPdtGWNz2L96TgwKKu4R66A+hJEVn+uQAfjf+e9qT32jiPa2a4VOpK/goMqlXzj908iztvQZz3m+YTMVDSd7iHz1ZLn+z8lBgqLOjkhrbv676j7Y7qNNRFDoZSvg4sLtmtvSVZfpLAb3y4oATGPyf9r/z+GwsQI0TnJePtwvDQxf+iX6mMSz1BaRHB7hvbXqsLomJJj9cCeaX7eTlxaucpKnOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAtzVCo6QcnsMZ40q+Ujvy8RLPEwmRUO0Dy0U4u+MSc=;
 b=FligP/33132Tv6NgYyMUfRN4PGDBXGWqaLPVGYq/NlDFWR29JQeN7LiQfKK/rZswgoilGxnUJfFOQvbpl5Qa9SVoP3x8vk3dOTaxlZPk/RqGioO1O9e1PD3fOQ3gRLacKiV6CnLwfWlFhzKIfdMluWS9QHKNN2PnEdSIRFN38ximwnBoNpnite4HCSWeclIssmt5Mrakty+G+u4hU5Mud6DRlkqMZZh8ehvUmc+FsXsp0w3JUsL+6dZwoVeql0z1DRWYHLApgYse7DMmwbaQFKUnpPGadkJejvM1P7atKDj1wbYoobE6CClFF0wx4xNd9FODdaf9s/zEPBXilu/IiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAtzVCo6QcnsMZ40q+Ujvy8RLPEwmRUO0Dy0U4u+MSc=;
 b=NXazUEN6BN2oOOoLGP6JBQQpeH1A6qNsPmvkPjghncsiTB6YtzV2a/Rua5uaF7Ic7w/NhMcWw0Sh1ki52yFM3UiRScUE3S/lwuWjQ6oeSYpsL4j2p1M1+OBNSssuzZKZBP0VxHgY1PxLyHqrTIBWWr/FftKHxA8TVtFtuHQ6NAY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4092.eurprd04.prod.outlook.com (2603:10a6:5:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 13:52:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 13:52:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "xiaowei.bao@nxp.com" <xiaowei.bao@nxp.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/3] reset: imx7: Support module build
Thread-Topic: [PATCH V2 1/3] reset: imx7: Support module build
Thread-Index: AQHWTihm3a2nP66YUE63bEZJQOir3KkQUjoAgABIZUA=
Date:   Mon, 20 Jul 2020 13:52:42 +0000
Message-ID: <DB3PR0402MB39169C591725C7ABAA121DCAF57B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
 <9c2d6c888817880974f850622b14905a9338b60e.camel@pengutronix.de>
In-Reply-To: <9c2d6c888817880974f850622b14905a9338b60e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c3f118-8063-4e12-7a11-08d82cb42c4f
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB40929A3C81A6D3638F9B6588F57B0@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90+zXs65R1LJLGSodbi333AjvJYTZWyFSoUGOvOsLmYEBmrgalcmjPMxMiGK2/0StWyz8T9czjKf4YoA5trSJudzwLm3TLe4WyEs8iRYikKvnK82g5Bcw5eKVirUevsxSuvilG+Y4C9EUrQ5toeO1bcddaToV5P1hhBVmkV39IuuJZFzVCMVmHptAfKi0BJxWWKUfT/AsWrXZ3mW6drLn5cr/rdr9PtPssEWBmSBdyiUQYNlZwMDeulWbZENT111V6pgaMykpGJg7MGyr5Ve3Zs06knbGLiw9JI0cIWycIk+p62m+P27Wh0QpboFf66V8YPUPa/QAccxs2sAjocwC27zdonEol554NIA09AGdUpCoFMwDwIW+t28MI8jbsnO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(9686003)(316002)(110136005)(55016002)(76116006)(71200400001)(66476007)(83380400001)(66946007)(7416002)(66556008)(4326008)(64756008)(66446008)(33656002)(186003)(2906002)(86362001)(52536014)(8936002)(44832011)(26005)(478600001)(8676002)(5660300002)(6506007)(7696005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SG7Zj3RqDrl8neqIqNKJM2VVtrXZR2x47KG51ObrU2RjwHPkNS0BbcmMeKbIZKRJS/B+TdNvUhqOhdugJU71E31vp8RyPX7FLUMHD2HcDmMtAVdIs39FA/xvEw9jUDH3EbxF41xxV+yjPicxTWq/QVv6KWat4o/b8ANHafQHHyR4vwUv0EaMbDDkuIdShGVP+Y3vqn6nbM6dcEuYSIm1sKpMI15iVS/RUswDZVfiz0PrPmc3jkRB8UsB7sphUPdsvfl5hGkOuTOdoWv+mp96eeJjHzFf2nkOv785UzgaYUuKanJe9R4i200sGEdNGrlqvvPcbjMBiSsdGFk9JRYrFSgx6ooXpo4L7WT4EyLYQC9xFp8EjG34Klryv+mwcrWfSNIFppHrRRQTB73riTenMLwpwx+MlaN2vcTQ7Gd4cxG/9S2KiD3AOrfRVk4r+lx6esu0v+Bdtki7S///GrFdEYiF9eOcpDaxCG0GnpdDh2Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c3f118-8063-4e12-7a11-08d82cb42c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:52:42.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQ3JLAuH0KZFokVqq3HmG3Uj3++WDB/PaPUX+VOAZ3q5LbXCa3TS8g4YfRLgo4/wvuycHF0G4zEsXWOvGo/1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFBoaWxpcHANCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMS8zXSByZXNldDogaW14
NzogU3VwcG9ydCBtb2R1bGUgYnVpbGQNCj4gDQo+IE9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMzow
NSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkIG1vZHVsZSBkZXZpY2UgdGFibGUs
IGF1dGhvciwgZGVzY3JpcHRpb24gYW5kIGxpY2Vuc2UgdG8gc3VwcG9ydA0KPiA+IG1vZHVsZSBi
dWlsZCwgYW5kIENPTkZJR19SRVNFVF9JTVg3IGlzIGNoYW5nZWQgdG8gZGVmYXVsdCAneScgT05M
WSBmb3INCj4gPiBpLk1YN0QsIG90aGVyIHBsYXRmb3JtcyBuZWVkIHRvIHNlbGVjdCBpdCBpbiBk
ZWZjb25maWcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+IAktIG1ha2Ug
aXQgZGVmYXVsdCAneScgZm9yIFNPQ19JTVg3RDsNCj4gPiAJLSBhZGQgbW9kdWxlIGF1dGhvciwg
ZGVzY3JpcHRpb247DQo+ID4gCS0gdXNlIGRldmljZV9pbml0Y2FsbCBpbnN0ZWFkIG9mIGJ1aWx0
aW5fcGxhdGZvcm1fZHJpdmVyKCkgdG8gc3VwcG9ydA0KPiA+IAkgIG1vZHVsZSB1bmxvYWQuDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVzZXQvS2NvbmZpZyAgICAgIHwgIDUgKysrLS0NCj4gPiAg
ZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMgfCAxNCArKysrKysrKysrKystLQ0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9LY29uZmlnIGIvZHJpdmVycy9yZXNldC9LY29uZmln
IGluZGV4DQo+ID4gZDllZmJmZC4uMTlmOTc3MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Jl
c2V0L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3Jlc2V0L0tjb25maWcNCj4gPiBAQCAtNjUs
OSArNjUsMTAgQEAgY29uZmlnIFJFU0VUX0hTREsNCj4gPiAgCSAgVGhpcyBlbmFibGVzIHRoZSBy
ZXNldCBjb250cm9sbGVyIGRyaXZlciBmb3IgSFNESyBib2FyZC4NCj4gPg0KPiA+ICBjb25maWcg
UkVTRVRfSU1YNw0KPiA+IC0JYm9vbCAiaS5NWDcvOCBSZXNldCBEcml2ZXIiIGlmIENPTVBJTEVf
VEVTVA0KPiA+ICsJdHJpc3RhdGUgImkuTVg3LzggUmVzZXQgRHJpdmVyIg0KPiA+ICAJZGVwZW5k
cyBvbiBIQVNfSU9NRU0NCj4gPiAtCWRlZmF1bHQgU09DX0lNWDdEIHx8IChBUk02NCAmJiBBUkNI
X01YQykNCj4gPiArCWRlcGVuZHMgb24gU09DX0lNWDdEIHx8IChBUk02NCAmJiBBUkNIX01YQykg
fHwgQ09NUElMRV9URVNUDQo+ID4gKwlkZWZhdWx0IHkgaWYgU09DX0lNWDdEDQo+ID4gIAlzZWxl
Y3QgTUZEX1NZU0NPTg0KPiA+ICAJaGVscA0KPiA+ICAJICBUaGlzIGVuYWJsZXMgdGhlIHJlc2V0
IGNvbnRyb2xsZXIgZHJpdmVyIGZvciBpLk1YNyBTb0NzLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jDQo+ID4g
aW5kZXggZDE3MGZlNi4uYzcxMGY3ODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9y
ZXNldC1pbXg3LmMNCj4gPiArKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYw0KPiA+IEBA
IC04LDcgKzgsNyBAQA0KPiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5
c2Nvbi5oPg0KPiA+IC0jaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9yZXNldC1jb250cm9sbGVyLmg+DQo+ID4gQEAgLTM4Niw2ICszODYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXg3X3Jlc2V0X2R0X2lkc1tdDQo+ID0gew0K
PiA+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLXNyYyIsIC5kYXRhID0gJnZhcmlhbnRf
aW14OG1wIH0sDQo+ID4gIAl7IC8qIHNlbnRpbmVsICovIH0sDQo+ID4gIH07DQo+ID4gK01PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIGlteDdfcmVzZXRfZHRfaWRzKTsNCj4gPg0KPiA+ICBzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXg3X3Jlc2V0X2RyaXZlciA9IHsNCj4gPiAgCS5wcm9i
ZQk9IGlteDdfcmVzZXRfcHJvYmUsDQo+ID4gQEAgLTM5NCw0ICszOTUsMTMgQEAgc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14N19yZXNldF9kcml2ZXIgPSB7DQo+ID4gIAkJLm9mX21h
dGNoX3RhYmxlCT0gaW14N19yZXNldF9kdF9pZHMsDQo+ID4gIAl9LA0KPiA+ICB9Ow0KPiA+IC1i
dWlsdGluX3BsYXRmb3JtX2RyaXZlcihpbXg3X3Jlc2V0X2RyaXZlcik7DQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IF9faW5pdCBpbXg3X3Jlc2V0X2luaXQodm9pZCkgew0KPiA+ICsJcmV0dXJuIHBs
YXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmaW14N19yZXNldF9kcml2ZXIpOw0KPiA+ICt9DQo+ID4g
K2RldmljZV9pbml0Y2FsbChpbXg3X3Jlc2V0X2luaXQpOw0KPiANCj4gU2hvdWxkbid0IHRoaXMg
dXNlIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIgaW5zdGVhZD8NCg0KQWdyZWVkLCBtb2R1bGVfcGxh
dGZvcm1fZHJpdmVyKCkgaXMgYmV0dGVyLCB3aWxsIGltcHJvdmUgaXQgaW4gVjMuDQoNClRoYW5r
cywNCkFuc29uDQoNCg==
