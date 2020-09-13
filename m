Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240E268045
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMQ2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 12:28:31 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:5805
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgIMQ2Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 12:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It//eJ1P91CpaoeClD/kul7+e4HreHsvIOzJQ3/ouHIYrbhqJnrbVoJMcILLNSf/N/R8hC7FIZYVD64EJRjBnxPjFGvD5KlTd0NCaZRdjeKMQcxi0BNgGdpPike1kcIpDKCyNoDvjsd3Dcykr37Caa5AEqkZj/rbmmjCGEfcB/WgNytgBSI7gXVpbDSRsQROGGyavo2Mq/bRrdcjqvO2+FPHpBBbcJYH4MThSKb5kMUFtEGbCmj2De13jXuKnIToLVaEHIjZl8i+7T50OTlX9VxAonrg27sQiqa0FVKZSTekYXhGAVD6Niud8ssrL6hrsOwTOvWTznh3EIF8YI3r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdBiOQzIODjGMj6ycA0AJRhMfIZH3lYWos/r555Ehdk=;
 b=Ay10n1ePJgL/Q5kU36oPTKX00/I7mY+dSzGccszbz5r4uJh5Wf3UK6heMvmlDnhp5vjV8qey1mKo+6TSLovpgJSWzReonqRMrvEziP05vGtQW5Hx8DvwHm6TukTNGgXmHbFlqZFELvzyoCQI5c+DeArh5u04/pMMZ9ii43npA9Gm+zV9jmAyO7cLbotSfj6eoiZCZE/ioRDPXFZXxzx31OlkQ9rzXWRK1/2AGlMNheF9wJALRJfpqHv5f8+uCIpHXUP5r2c85gCXCSQNTTtQgGV3nak6sowCGo8iQTD7C13TAgTdaTGDP0rQ0p6taZ87w5DU2XF+DVEcc/OtSuGohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdBiOQzIODjGMj6ycA0AJRhMfIZH3lYWos/r555Ehdk=;
 b=YYW+a+aIs0H0PotwdRyYGFSFIS5i81aZ3Y1tfBgh8EwOVKW21KkMX86nQT0DrlK4tJwRGeEepAb8wLDU1Iep6MsOwMJViUC2MkmLiwwr+33TWn22JoO9zOcdFiXDbzRGZ7Sp4wKYSBfQBqKU9Bw4wFlS02dPFO8WzW8+mk2Lz+8=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB2730.eurprd04.prod.outlook.com (2603:10a6:3:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Sun, 13 Sep
 2020 16:28:20 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.018; Sun, 13 Sep 2020
 16:28:20 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv7 02/12] PCI: designware-ep: Add the doorbell mode of
 MSI-X in EP mode
Thread-Topic: [PATCHv7 02/12] PCI: designware-ep: Add the doorbell mode of
 MSI-X in EP mode
Thread-Index: AQHWb8Z3KevupTpcJEaaUJbn6LJx9KliWE8AgASdcyA=
Date:   Sun, 13 Sep 2020 16:28:20 +0000
Message-ID: <HE1PR0402MB3371A2E50CF6206684A1C16384220@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
 <20200811095441.7636-3-Zhiqiang.Hou@nxp.com> <20200910175804.GA592152@bogus>
In-Reply-To: <20200910175804.GA592152@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 973e4a48-1c35-4455-d4e1-08d858020740
x-ms-traffictypediagnostic: HE1PR0402MB2730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB27309168D394590756BD657C84220@HE1PR0402MB2730.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvwjmOxF2sT+tUaDtiVFrPtgcN3G9YWo7DPOSWtxtjs0f0/OJkVM9ZFmPC7IesAizS9twgVg0dLFG1BZsysMOuy75iM5aHB2D3zogix701eACZzutbO2imoV0OI+T7EJRMLij0T3wfl4u6fy8QC451wGWm1N70/GPIWqqlDzda3d5aoQDlzNYBFQb/b91ptz/t6j8PdstrWKEkJXMWB6fQBUlEPuUt94WQhQVJOb80A00wnBQbgGGFS+i42YN4yxB54LDPMhGmD1Dwwsrsi0occ4YJf7PFep++qOnMVBvbcXyHA1asNWTSMgOb94vLpo/H49TsjhxM5kH+O7POE00g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(7696005)(66946007)(55016002)(66446008)(64756008)(66556008)(66476007)(9686003)(8676002)(26005)(6916009)(71200400001)(6506007)(53546011)(8936002)(186003)(478600001)(5660300002)(52536014)(7416002)(54906003)(83380400001)(4326008)(316002)(86362001)(33656002)(76116006)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: y4G61In80A74mhQoh1rVUKF9O5gjDUffEkCjlkXdV9/hTRj/iAjGYSfEwsC5D+ABN65AVFie+bDVFXr2Hy0sETLRdbduwDs+O1uSZOEey7QsSd3ZU6jx0mwRGp4zTypAd9ByGDCSXb3wpz4QMf9oJT4irC/e6KCn3450b4ntXOYP3X45M+9Y7q2YjMamdfwXrZI01FtdYebBH19xax4pnMi9SjPBv227nHpF7IcsX7/bVxdF242lP7TVRpbs1ShGgs8AgsvdG86Umvwper5+MUfRpyTcEAUHq5UvPrjYHF0QIi1b4Qh52lRAJB5MOqny7qckF7dnQkJXeP/02k3EThJ5Xqq+9B6es4U1MTsLEjtEbST412hyRr8tmkpO9xnfUUbR4RvJSf/xF4IdE0ERLYnsDVMaP14CfL7OAXDoeaLRDMzl62CZsXUqksh2UPCiUGPomPLcWqM1VTNL3/J10gIlfZXksSBVnj+hrajw047R8ebn3tAhluww6AGirbHwZtVtGqppL6e5WXsnLssXhllVKCwsRxwdD+hGgm5GDx56aZAYeDsLYke+bRS8JyLC6iaTF80k0EwJaNyphF3NYfS3MuhpXKEfR8o/KtZ4bHwC0bYbDs7+lzIy6KEgB0q9l6Uy0l+HgpqVXboN7ILqMw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973e4a48-1c35-4455-d4e1-08d858020740
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2020 16:28:20.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEKfU2HYI1LI9xMrbcfUhF1a+OAIKgYf2yYcvdVyqO9a2MCnRt4LgWeP+foNmmq/3IgAf4QFxemK6NHQLMZjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2730
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4N
Cj4gU2VudDogMjAyMMTqOdTCMTHI1SAxOjU4DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNo
b25AdGkuY29tOyBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsNCj4gUm95IFphbmcgPHJv
eS56YW5nQG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWlsLmNvbTsNCj4gYW5kcmV3Lm11cnJheUBh
cm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1p
bmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIdjcgMDIvMTJdIFBDSTogZGVzaWdud2FyZS1lcDogQWRkIHRo
ZSBkb29yYmVsbCBtb2RlIG9mDQo+IE1TSS1YIGluIEVQIG1vZGUNCj4gDQo+IE9uIFR1ZSwgQXVn
IDExLCAyMDIwIGF0IDA1OjU0OjMxUE0gKzA4MDAsIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBG
cm9tOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCB0aGUg
ZG9vcmJlbGwgbW9kZSBvZiBNU0ktWCBpbiBEV0MgRVAgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IFY3
Og0KPiA+ICAtIFJlYmFzZSB0aGUgcGF0Y2ggd2l0aG91dCBmdW5jdGlvbmFsaXR5IGNoYW5nZS4N
Cj4gPg0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAu
YyB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oICAgIHwgMTIgKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+IGluZGV4IGU1YmQzYTVlZjM4MC4u
ZTc2YjUwNGVkNDY1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiBAQCAtNDcxLDYgKzQ3MSwyMCBAQCBpbnQgZHdf
cGNpZV9lcF9yYWlzZV9tc2lfaXJxKHN0cnVjdCBkd19wY2llX2VwDQo+ICplcCwgdTggZnVuY19u
bywNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiAraW50IGR3X3BjaWVfZXBfcmFp
c2VfbXNpeF9pcnFfZG9vcmJlbGwoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OA0KPiA+ICtmdW5j
X25vLA0KPiANCj4gcmV0dXJuIHZvaWQuIEl0IG5ldmVyIGhhcyBhbiBlcnJvci4NCj4gDQo+IEl0
IGNvdWxkIGFsc28ganVzdCBiZSBhbiBpbmxpbmUgZnVuY3Rpb24uDQoNClllcywgbWFrZSBzZW5z
ZSBhbmQgd2lsbCBjaGFuZ2UgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
DQo+IA0KPiA+ICsJCQkJICAgICAgIHUxNiBpbnRlcnJ1cHRfbnVtKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gPiArCXUzMiBt
c2dfZGF0YTsNCj4gPiArDQo+ID4gKwltc2dfZGF0YSA9IChmdW5jX25vIDw8IFBDSUVfTVNJWF9E
T09SQkVMTF9QRl9TSElGVCkgfA0KPiA+ICsJCSAgIChpbnRlcnJ1cHRfbnVtIC0gMSk7DQo+ID4g
Kw0KPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9NU0lYX0RPT1JCRUxMLCBtc2df
ZGF0YSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIGludCBk
d19wY2llX2VwX3JhaXNlX21zaXhfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19u
bywNCj4gPiAgCQkJICAgICAgdTE2IGludGVycnVwdF9udW0pDQo+ID4gIHsNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXgg
ODlmODI3MWVjNWVlLi43NDViNDkzODIyNWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC05Nyw2ICs5Nyw5IEBADQo+
ID4gICNkZWZpbmUgUENJRV9NSVNDX0NPTlRST0xfMV9PRkYJCTB4OEJDDQo+ID4gICNkZWZpbmUg
UENJRV9EQklfUk9fV1JfRU4JCUJJVCgwKQ0KPiA+DQo+ID4gKyNkZWZpbmUgUENJRV9NU0lYX0RP
T1JCRUxMCQkweDk0OA0KPiA+ICsjZGVmaW5lIFBDSUVfTVNJWF9ET09SQkVMTF9QRl9TSElGVAky
NA0KPiA+ICsNCj4gPiAgI2RlZmluZSBQQ0lFX1BMX0NIS19SRUdfQ09OVFJPTF9TVEFUVVMJCQkw
eEIyMA0KPiA+ICAjZGVmaW5lIFBDSUVfUExfQ0hLX1JFR19DSEtfUkVHX1NUQVJUCQkJQklUKDAp
DQo+ID4gICNkZWZpbmUgUENJRV9QTF9DSEtfUkVHX0NIS19SRUdfQ09OVElOVU9VUwkJQklUKDEp
DQo+ID4gQEAgLTQzNCw2ICs0MzcsOCBAQCBpbnQgZHdfcGNpZV9lcF9yYWlzZV9tc2lfaXJxKHN0
cnVjdCBkd19wY2llX2VwDQo+ICplcCwgdTggZnVuY19ubywNCj4gPiAgCQkJICAgICB1OCBpbnRl
cnJ1cHRfbnVtKTsNCj4gPiAgaW50IGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEoc3RydWN0IGR3
X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJCQkgICAgIHUxNiBpbnRlcnJ1cHRfbnVt
KTsNCj4gPiAraW50IGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnFfZG9vcmJlbGwoc3RydWN0IGR3
X3BjaWVfZXAgKmVwLCB1OA0KPiBmdW5jX25vLA0KPiA+ICsJCQkJICAgICAgIHUxNiBpbnRlcnJ1
cHRfbnVtKTsNCj4gPiAgdm9pZCBkd19wY2llX2VwX3Jlc2V0X2JhcihzdHJ1Y3QgZHdfcGNpZSAq
cGNpLCBlbnVtIHBjaV9iYXJubyBiYXIpOw0KPiA+ICNlbHNlICBzdGF0aWMgaW5saW5lIHZvaWQg
ZHdfcGNpZV9lcF9saW5rdXAoc3RydWN0IGR3X3BjaWVfZXAgKmVwKSBAQA0KPiA+IC00NzUsNiAr
NDgwLDEzIEBAIHN0YXRpYyBpbmxpbmUgaW50IGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEoc3Ry
dWN0DQo+IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBkd19wY2llX2VwX3JhaXNlX21zaXhfaXJx
X2Rvb3JiZWxsKHN0cnVjdCBkd19wY2llX2VwDQo+ICplcCwNCj4gPiArCQkJCQkJICAgICB1OCBm
dW5jX25vLA0KPiA+ICsJCQkJCQkgICAgIHUxNiBpbnRlcnJ1cHRfbnVtKQ0KPiA+ICt7DQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIGR3X3Bj
aWVfZXBfcmVzZXRfYmFyKHN0cnVjdCBkd19wY2llICpwY2ksIGVudW0NCj4gPiBwY2lfYmFybm8g
YmFyKSAgeyAgfQ0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
