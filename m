Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC97154296
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBFLEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:04:39 -0500
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:55222
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgBFLEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:04:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmFycW3Rh/QxGNqjvHY+vh/hgY83Uc/BuHDcalZAW7lYC/hOYODrb8rZNHkUnPAvP8lpIVwI5+avOlllnu6ZdyIfixaXaOhQxJmtewi1H9yn7OuEpQSataSX5wwwEqS+OASM8IWU7ZICt2g/siX9s/ec4AW8LJUt1jgVwIkmDSU4vr9ef2z+DWgLQtkk6YosdFAORlIabx4kv6mWz2wR6ys04DKd8b5dSDdmpViuQocgc3lfZYote/tZWRCKCVvr5vVkkbbnMUzkYY2i1+DkiRG3BT2mz7UjJUhZD17pQ9Oul4G3jBxhpMXBdHktdngtDsT5zPDerI+cSX+vZLv+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI7yCuJGhw54e6Yr8YeMGKgQ/SEBgnw+RHtb2xfZIoU=;
 b=fBRHVgZwPQXdbk7uFagL18q/9AITXKzPOlINxX/KPHt7ag/T4NAh2v0t21Ooh+8dC3qab7PGlzVFBrAr+juIJjA5r65rd9q5fw0ubuKfG8PXdGqGhZbDmSHkqLjf1wzg+PnN+lAk1krOj6KAVpjhZn/ZOwMCkQjQ0RwWjzMlDWWwda0eer+/1k37fXdaNq9zVIOsrNPjMcKKs8xb0B+Y4reH4AGWlPOkxfJ/QyvJG3MsgOUfdcTLk/u/nMpghohdnMo74zPtVhNKYWdjFIKeJGUbKlCG0STvqR+dVcOQb4foMSdL9Gd4c3s/0dNwexXNsqvcifEHtmbL1dM9tDTarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI7yCuJGhw54e6Yr8YeMGKgQ/SEBgnw+RHtb2xfZIoU=;
 b=nQcT4plydgYWgt4J2PmnfYvFDxeAXQ9X404tLLo94/2zwBwxog3JxgjBz4mBMTY/lM5QTPmAqLaM562wW08A6NiNGhTi8ntAQ+tFemSbFTFV5BZAEbLo5V9X2/4x1cdrzwwSfGQmMOYkbGuwQFOx53ZUzs//kqPHwTCEyj/6uC0=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7100.eurprd04.prod.outlook.com (52.135.61.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 11:04:30 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 11:04:29 +0000
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
Subject: RE: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
Thread-Topic: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
Thread-Index: AQHVn1TwFR8APo0fq0uUrHwI6ZwoQafotHCAgCRFK0A=
Date:   Thu, 6 Feb 2020 11:04:29 +0000
Message-ID: <DB8PR04MB67476FE40D1396B2F61F5683841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-2-Zhiqiang.Hou@nxp.com>
 <20200113100931.GG42593@e119886-lin.cambridge.arm.com>
In-Reply-To: <20200113100931.GG42593@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68a0769f-343a-433c-cf03-08d7aaf456b5
x-ms-traffictypediagnostic: DB8PR04MB7100:|DB8PR04MB7100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7100D9BC47E072B6151FAB6B841D0@DB8PR04MB7100.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(26005)(30864003)(54906003)(55016002)(5660300002)(478600001)(2906002)(8936002)(8676002)(81166006)(6506007)(53546011)(316002)(81156014)(66556008)(66446008)(66476007)(66946007)(33656002)(64756008)(7696005)(86362001)(4326008)(186003)(76116006)(7416002)(9686003)(52536014)(6916009)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7100;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VB7h84l08sO+qDIeCrwZs5h+VpbSMPBiQN1vr8NF7stD3XOngB6x4+Qh1lDIS5YK5jJyO2YvgXnP5ECMTdKiVCf13A28sJVjj8Vq3O0bqgtrXaVYUPtMuSlX9ykh7r63eoVqGpjYJA4HjbubutBBWc/AkM7kswPZYGTBEpwV6+4uNdiXJ6ipv7jem0wNcgiTLfcVc5wXfZDrTSJIjBZhVprNVuiKed6KNYwPjTdh7PPUo0cguDh6kijsMzAliOdW43X6ct4HnbreVHsjXHTHdNXTesMncubF+a48h/wfxwZ6JMI6DwLtwMoaYbBte2B6zY4McaiOrjzTqGHhZ8LIQds9tiJsvXt+hoh7Qnq/GLkydj1ykX6h+2KCYip92HW/8pZeulR/GbsuQtV5dWL5YNV6jzLzHXuWA7ttwpjb3lEN8dQDVyYv4QbT8Sxo+kr
x-ms-exchange-antispam-messagedata: FcU7jMY0yolMF0b5pXc6gGuFPFp14JfflNUi9jVmb/Pb/jK79S/KfXxLjO+b48WfjCDMQ/0B8oYQ4/T+CkctK/cN1MQ455w9tFmFjLOqBc6TQFKyig7mYb3hDAOga9vCC0hdgHAKSom/TS7rk7xYKA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0769f-343a-433c-cf03-08d7aaf456b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 11:04:29.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hd5xyFgMkNWEr4obDnaUfX/roUoZvahI0Z4uUVfgrWlAJLozEgxQKfSZ+YW0gg7/de5DLpLA33hAb6DqnOgazA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQpTb3JyeSBmb3Ig
bXkgZGVsYXkgcmVzcG9uZCENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBBbmRyZXcgTXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+DQo+IFNlbnQ6IDIwMjDE6jHU
wjEzyNUgMTg6MTANCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsg
YXJuZEBhcm5kYi5kZTsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGwuc3VicmFobWFueWFAbW9i
aXZlaWwuY28uaW47DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG0ua2FydGhpa2V5YW5AbW9iaXZl
aWwuY28uaW47IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5j
b207IE1pbmdrYWkgSHUNCj4gPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1
YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8NCj4gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0h2OSAwMS8xMl0gUENJOiBtb2JpdmVpbDogUmUtYWJzdHJhY3Qg
dGhlIHByaXZhdGUgc3RydWN0dXJlDQo+IA0KPiBPbiBXZWQsIE5vdiAyMCwgMjAxOSBhdCAwMzo0
NToyM0FNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIE1vYml2ZWlsIFBDSWUgY29udHJvbGxl
ciBjYW4gd29yayBpbiBlaXRoZXIgUm9vdCBDb21wbGV4IG1vZGUgb3INCj4gPiBFbmRwb2ludCBt
b2RlLiBTbyBpbnRyb2R1Y2UgYSBuZXcgc3RydWN0dXJlIHJvb3RfcG9ydCwgYW5kIGFic3RyYWN0
DQo+ID4gdGhlIFJDIHJlbGF0ZWQgbWVtYmVycyBpbnRvIGl0Lg0KPiANCj4gVGhlIGZpcnN0IHNl
bnRlbmNlIGV4cGxhaW5zIHRoZSB0cmlnZ2VyIGZvciB0aGlzIHdvcmssIHRoZSBzZWNvbmQgZXhw
bGFpbnMgd2hhdA0KPiB5b3UgYXJlIGNoYW5naW5nLCBpdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGFs
c28gZGVzY3JpYmUgd2h5IHlvdSBuZWVkIHRvIG1ha2UNCj4gdGhpcyBjaGFuZ2UuIFlvdSBjb3Vs
ZCBkbyB0aGlzIGJ5IGV4dGVuZGluZyB0aGUgbGFzdCBzZW50ZW5jZSwgZS5nLg0KPiANCj4gIlNv
IGludHJvZHVjZSBhIG5ldyBzdHJ1Y3R1cmUgcm9vdF9wb3J0LCBhbmQgYWJzdHJhY3QgdGhlIFJD
ICByZWxhdGVkDQo+IG1lbWJlcnMgaW50byBpdCBzdWNoIHRoYXQgaXQgY2FuIGJlIHVzZWQgYnkg
Ym90aCAuLi4iDQo+IA0KPiBBcyB0aGlzIHNlcmllcyBkb2Vzbid0IGFjdHVhbGx5IGFkZCBhIEVQ
IGRyaXZlciwgdGhpcyBhYnN0cmFjdGlvbiBpc24ndCBuZWVkZWQNCj4gbm93IC0gYnV0IGl0IGlz
IG5pY2UgdG8gaGF2ZSAtIGl0IG1heSBiZSBoZWxwZnVsIHRvIGV4cGxhaW4gdGhpcy4NCj4gDQo+
IFRoZSBlbWFpbCBzdWJqZWN0IGNvdWxkIGFsc28gbW9yZSBwcmVjaXNlbHkgZXhwbGFpbiB3aGF0
IHRoaXMgcGF0Y2ggZG9lcy4NCg0KVGhhbmtzIGZvciB0aGUgZ29vZCBzdWdnZXN0aW9ucyEgV2ls
bCBjaGFuZ2UgaW4gdjEwLg0KDQo+IA0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gVjk6DQo+ID4gIC0g
TmV3IHBhdGNoIHNwbGl0ZWQgZnJvbSB0aGUgIzEgb2YgVjggcGF0Y2hlcyB0byBtYWtlIGl0IGVh
c3kgdG8gcmV2aWV3Lg0KPiANCj4gSW5kZWVkLCBpdCdzIG11Y2ggbmljZXIgdG8gcmV2aWV3IC0g
dGhhbmtzLg0KPiANCj4gDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMgfCA5OQ0KPiA+ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBpbmRleCAzYTY5NmNh
NDViZmEuLjVmZDI2ZTM3NmFmMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tb2JpdmVpbC5jDQo+ID4gQEAgLTMsNyArMywxMCBAQA0KPiA+ICAgKiBQQ0llIGhvc3QgY29u
dHJvbGxlciBkcml2ZXIgZm9yIE1vYml2ZWlsIFBDSWUgSG9zdCBjb250cm9sbGVyDQo+ID4gICAq
DQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAxOCBNb2JpdmVpbCBJbmMuDQo+ID4gKyAqIENvcHly
aWdodCAyMDE5IE5YUA0KPiA+ICsgKg0KPiA+ICAgKiBBdXRob3I6IFN1YnJhaG1hbnlhIExpbmdh
cHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiA+ICsgKiBSZWNvZGU6IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IA0KPiBBcyBwZXIgbXkgcHJldmlvdXMg
ZmVlZGJhY2ssIEknbSBub3Qgc3VyZSB0aGUgdmFsdWUgb2YgdXNpbmcgdGhlIHRlcm0gcmVmYWN0
b3INCj4gb3IgYSBzeW5vbnltIG9mIGl0LiBBbmQgSSBjZXJ0YWludGx5IGRvbid0IHdhbnQgdG8g
ZW5jb3VyYWdlIGFueW9uZSB0aGF0DQo+IG1vZGlmaWVzIHRoaXMgZmlsZSB0byBhZGQgYSBzaW1p
bGFyIHRhZyB3aGVuIHRoZSBpbmZvcm1hdGlvbiBpcyBlYXNpbHkgdmlzaWJsZSB2aWENCj4gR0lU
IGFuZCB0aGUgZ2V0X21haW50YWluZXJzIHNjcmlwdC4NCg0KV2lsbCByZW1vdmUgdGhlIHJlY29k
ZSB0YWcgaW4gdjEwLg0KDQo+IA0KPiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4NCj4gPiBAQCAtMTM4LDIyICsxNDEsMjcgQEAgc3RydWN0IG1vYml2ZWlsX21zaSB7
CQkJLyogTVNJDQo+IGluZm9ybWF0aW9uICovDQo+ID4gIAlERUNMQVJFX0JJVE1BUChtc2lfaXJx
X2luX3VzZSwgUENJX05VTV9NU0kpOyAgfTsNCj4gPg0KPiA+ICtzdHJ1Y3Qgcm9vdF9wb3J0IHsN
Cj4gPiArCWNoYXIgcm9vdF9idXNfbnI7DQo+ID4gKwl2b2lkIF9faW9tZW0gKmNvbmZpZ19heGlf
c2xhdmVfYmFzZTsJLyogZW5kcG9pbnQgY29uZmlnIGJhc2UgKi8NCj4gPiArCXN0cnVjdCByZXNv
dXJjZSAqb2JfaW9fcmVzOw0KPiA+ICsJaW50IGlycTsNCj4gPiArCXJhd19zcGlubG9ja190IGlu
dHhfbWFza19sb2NrOw0KPiA+ICsJc3RydWN0IGlycV9kb21haW4gKmludHhfZG9tYWluOw0KPiA+
ICsJc3RydWN0IG1vYml2ZWlsX21zaSBtc2k7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdl
ICpicmlkZ2U7DQo+ID4gK307DQo+IA0KPiBQbGVhc2UgcHJlZml4IHdpdGggbW9iaXZlaWwgZ2l2
ZW4gd2UgaGF2ZSBtb2JpdmVpbCByZWxhdGVkIHN0cnVjdHVyZXMgaW5zaWRlIGl0Lg0KDQpEbyB5
b3UgbWVhbiBzL3Jvb3RfcG9ydC9tb2JpdmVpbF9yb290X3BvcnQvID8NCg0KVGhhbmtzLA0KWmhp
cWlhbmcNCg0KPiANCj4gKEFsc28gb24geW91ciByZXNwaW4sIHBsZWFzZSByZWJhc2UgYXMgcGVy
IE9sb2YncyBmZWVkYmFjaykuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBBbmRyZXcgTXVycmF5DQo+
IA0KPiA+ICsNCj4gPiAgc3RydWN0IG1vYml2ZWlsX3BjaWUgew0KPiA+ICAJc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldjsNCj4gPiAtCXZvaWQgX19pb21lbSAqY29uZmlnX2F4aV9zbGF2ZV9i
YXNlOwkvKiBlbmRwb2ludCBjb25maWcgYmFzZSAqLw0KPiA+ICAJdm9pZCBfX2lvbWVtICpjc3Jf
YXhpX3NsYXZlX2Jhc2U7CS8qIHJvb3QgcG9ydCBjb25maWcgYmFzZSAqLw0KPiA+ICAJdm9pZCBf
X2lvbWVtICphcGJfY3NyX2Jhc2U7CS8qIE1TSSByZWdpc3RlciBiYXNlICovDQo+ID4gIAlwaHlz
X2FkZHJfdCBwY2llX3JlZ19iYXNlOwkvKiBQaHlzaWNhbCBQQ0llIENvbnRyb2xsZXIgQmFzZSAq
Lw0KPiA+IC0Jc3RydWN0IGlycV9kb21haW4gKmludHhfZG9tYWluOw0KPiA+IC0JcmF3X3NwaW5s
b2NrX3QgaW50eF9tYXNrX2xvY2s7DQo+ID4gLQlpbnQgaXJxOw0KPiA+ICAJaW50IGFwaW9fd2lu
czsNCj4gPiAgCWludCBwcGlvX3dpbnM7DQo+ID4gIAlpbnQgb2Jfd2luc19jb25maWd1cmVkOwkJ
LyogY29uZmlndXJlZCBvdXRib3VuZCB3aW5kb3dzICovDQo+ID4gIAlpbnQgaWJfd2luc19jb25m
aWd1cmVkOwkJLyogY29uZmlndXJlZCBpbmJvdW5kIHdpbmRvd3MgKi8NCj4gPiAtCXN0cnVjdCBy
ZXNvdXJjZSAqb2JfaW9fcmVzOw0KPiA+IC0JY2hhciByb290X2J1c19ucjsNCj4gPiAtCXN0cnVj
dCBtb2JpdmVpbF9tc2kgbXNpOw0KPiA+ICsJc3RydWN0IHJvb3RfcG9ydCBycDsNCj4gPiAgfTsN
Cj4gPg0KPiA+ICAvKg0KPiA+IEBAIC0yODEsMTYgKzI4OSwxNyBAQCBzdGF0aWMgYm9vbCBtb2Jp
dmVpbF9wY2llX2xpbmtfdXAoc3RydWN0DQo+ID4gbW9iaXZlaWxfcGNpZSAqcGNpZSkgIHN0YXRp
YyBib29sIG1vYml2ZWlsX3BjaWVfdmFsaWRfZGV2aWNlKHN0cnVjdA0KPiA+IHBjaV9idXMgKmJ1
cywgdW5zaWduZWQgaW50IGRldmZuKSAgew0KPiA+ICAJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBj
aWUgPSBidXMtPnN5c2RhdGE7DQo+ID4gKwlzdHJ1Y3Qgcm9vdF9wb3J0ICpycCA9ICZwY2llLT5y
cDsNCj4gPg0KPiA+ICAJLyogT25seSBvbmUgZGV2aWNlIGRvd24gb24gZWFjaCByb290IHBvcnQg
Ki8NCj4gPiAtCWlmICgoYnVzLT5udW1iZXIgPT0gcGNpZS0+cm9vdF9idXNfbnIpICYmIChkZXZm
biA+IDApKQ0KPiA+ICsJaWYgKChidXMtPm51bWJlciA9PSBycC0+cm9vdF9idXNfbnIpICYmIChk
ZXZmbiA+IDApKQ0KPiA+ICAJCXJldHVybiBmYWxzZTsNCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAq
IERvIG5vdCByZWFkIG1vcmUgdGhhbiBvbmUgZGV2aWNlIG9uIHRoZSBidXMgZGlyZWN0bHkNCj4g
PiAgCSAqIGF0dGFjaGVkIHRvIFJDDQo+ID4gIAkgKi8NCj4gPiAtCWlmICgoYnVzLT5wcmltYXJ5
ID09IHBjaWUtPnJvb3RfYnVzX25yKSAmJiAoUENJX1NMT1QoZGV2Zm4pID4gMCkpDQo+ID4gKwlp
ZiAoKGJ1cy0+cHJpbWFyeSA9PSBycC0+cm9vdF9idXNfbnIpICYmIChQQ0lfU0xPVChkZXZmbikg
PiAwKSkNCj4gPiAgCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgCXJldHVybiB0cnVlOw0KPiA+
IEBAIC0zMDQsMTMgKzMxMywxNCBAQCBzdGF0aWMgdm9pZCBfX2lvbWVtDQo+ICptb2JpdmVpbF9w
Y2llX21hcF9idXMoc3RydWN0IHBjaV9idXMgKmJ1cywNCj4gPiAgCQkJCQkgICB1bnNpZ25lZCBp
bnQgZGV2Zm4sIGludCB3aGVyZSkgIHsNCj4gPiAgCXN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2ll
ID0gYnVzLT5zeXNkYXRhOw0KPiA+ICsJc3RydWN0IHJvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7
DQo+ID4gIAl1MzIgdmFsdWU7DQo+ID4NCj4gPiAgCWlmICghbW9iaXZlaWxfcGNpZV92YWxpZF9k
ZXZpY2UoYnVzLCBkZXZmbikpDQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4NCj4gPiAgCS8qIFJD
IGNvbmZpZyBhY2Nlc3MgKi8NCj4gPiAtCWlmIChidXMtPm51bWJlciA9PSBwY2llLT5yb290X2J1
c19ucikNCj4gPiArCWlmIChidXMtPm51bWJlciA9PSBycC0+cm9vdF9idXNfbnIpDQo+ID4gIAkJ
cmV0dXJuIHBjaWUtPmNzcl9heGlfc2xhdmVfYmFzZSArIHdoZXJlOw0KPiA+DQo+ID4gIAkvKg0K
PiA+IEBAIC0zMjUsNyArMzM1LDcgQEAgc3RhdGljIHZvaWQgX19pb21lbQ0KPiAqbW9iaXZlaWxf
cGNpZV9tYXBfYnVzKHN0cnVjdA0KPiA+IHBjaV9idXMgKmJ1cywNCj4gPg0KPiA+ICAJbW9iaXZl
aWxfY3NyX3dyaXRlbChwY2llLCB2YWx1ZSwNCj4gUEFCX0FYSV9BTUFQX1BFWF9XSU5fTChXSU5f
TlVNXzApKTsNCj4gPg0KPiA+IC0JcmV0dXJuIHBjaWUtPmNvbmZpZ19heGlfc2xhdmVfYmFzZSAr
IHdoZXJlOw0KPiA+ICsJcmV0dXJuIHJwLT5jb25maWdfYXhpX3NsYXZlX2Jhc2UgKyB3aGVyZTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGNpX29wcyBtb2JpdmVpbF9wY2llX29w
cyA9IHsgQEAgLTMzOSw3ICszNDksOCBAQA0KPiA+IHN0YXRpYyB2b2lkIG1vYml2ZWlsX3BjaWVf
aXNyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gPiAgCXN0cnVjdCBpcnFfY2hpcCAqY2hpcCA9
IGlycV9kZXNjX2dldF9jaGlwKGRlc2MpOw0KPiA+ICAJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBj
aWUgPSBpcnFfZGVzY19nZXRfaGFuZGxlcl9kYXRhKGRlc2MpOw0KPiA+ICAJc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBjaWUtPnBkZXYtPmRldjsNCj4gPiAtCXN0cnVjdCBtb2JpdmVpbF9tc2kgKm1z
aSA9ICZwY2llLT5tc2k7DQo+ID4gKwlzdHJ1Y3Qgcm9vdF9wb3J0ICpycCA9ICZwY2llLT5ycDsN
Cj4gPiArCXN0cnVjdCBtb2JpdmVpbF9tc2kgKm1zaSA9ICZycC0+bXNpOw0KPiA+ICAJdTMyIG1z
aV9kYXRhLCBtc2lfYWRkcl9sbywgbXNpX2FkZHJfaGk7DQo+ID4gIAl1MzIgaW50cl9zdGF0dXMs
IG1zaV9zdGF0dXM7DQo+ID4gIAl1bnNpZ25lZCBsb25nIHNoaWZ0ZWRfc3RhdHVzOw0KPiA+IEBA
IC0zNjUsNyArMzc2LDcgQEAgc3RhdGljIHZvaWQgbW9iaXZlaWxfcGNpZV9pc3Ioc3RydWN0IGly
cV9kZXNjICpkZXNjKQ0KPiA+ICAJCXNoaWZ0ZWRfc3RhdHVzID4+PSBQQUJfSU5UWF9TVEFSVDsN
Cj4gPiAgCQlkbyB7DQo+ID4gIAkJCWZvcl9lYWNoX3NldF9iaXQoYml0LCAmc2hpZnRlZF9zdGF0
dXMsIFBDSV9OVU1fSU5UWCkgew0KPiA+IC0JCQkJdmlycSA9IGlycV9maW5kX21hcHBpbmcocGNp
ZS0+aW50eF9kb21haW4sDQo+ID4gKwkJCQl2aXJxID0gaXJxX2ZpbmRfbWFwcGluZyhycC0+aW50
eF9kb21haW4sDQo+ID4gIAkJCQkJCQliaXQgKyAxKTsNCj4gPiAgCQkJCWlmICh2aXJxKQ0KPiA+
ICAJCQkJCWdlbmVyaWNfaGFuZGxlX2lycSh2aXJxKTsNCj4gPiBAQCAtNDI0LDE1ICs0MzUsMTYg
QEAgc3RhdGljIGludCBtb2JpdmVpbF9wY2llX3BhcnNlX2R0KHN0cnVjdA0KPiBtb2JpdmVpbF9w
Y2llICpwY2llKQ0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBjaWUtPnBkZXYtPmRldjsN
Cj4gPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBwY2llLT5wZGV2Ow0KPiA+ICAJ
c3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+ICsJc3RydWN0IHJv
b3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4g
Pg0KPiA+ICAJLyogbWFwIGNvbmZpZyByZXNvdXJjZSAqLw0KPiA+ICAJcmVzID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwNCj4gPiAgCQkJCQkgICAi
Y29uZmlnX2F4aV9zbGF2ZSIpOw0KPiA+IC0JcGNpZS0+Y29uZmlnX2F4aV9zbGF2ZV9iYXNlID0g
ZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiAtCWlmIChJU19FUlIo
cGNpZS0+Y29uZmlnX2F4aV9zbGF2ZV9iYXNlKSkNCj4gPiAtCQlyZXR1cm4gUFRSX0VSUihwY2ll
LT5jb25maWdfYXhpX3NsYXZlX2Jhc2UpOw0KPiA+IC0JcGNpZS0+b2JfaW9fcmVzID0gcmVzOw0K
PiA+ICsJcnAtPmNvbmZpZ19heGlfc2xhdmVfYmFzZSA9IGRldm1fcGNpX3JlbWFwX2NmZ19yZXNv
dXJjZShkZXYsIHJlcyk7DQo+ID4gKwlpZiAoSVNfRVJSKHJwLT5jb25maWdfYXhpX3NsYXZlX2Jh
c2UpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKHJwLT5jb25maWdfYXhpX3NsYXZlX2Jhc2UpOw0K
PiA+ICsJcnAtPm9iX2lvX3JlcyA9IHJlczsNCj4gPg0KPiA+ICAJLyogbWFwIGNzciByZXNvdXJj
ZSAqLw0KPiA+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgQEANCj4gLTQ1NSw5DQo+ID4gKzQ2Nyw5IEBAIHN0YXRpYyBpbnQgbW9iaXZl
aWxfcGNpZV9wYXJzZV9kdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCj4gPiAgCWlmIChv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAicHBpby13aW5zIiwgJnBjaWUtPnBwaW9fd2lucykp
DQo+ID4gIAkJcGNpZS0+cHBpb193aW5zID0gTUFYX1BJT19XSU5ET1dTOw0KPiA+DQo+ID4gLQlw
Y2llLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+IC0JaWYgKHBjaWUtPmly
cSA8PSAwKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gbWFwIElSUTogJWRcbiIs
IHBjaWUtPmlycSk7DQo+ID4gKwlycC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsN
Cj4gPiArCWlmIChycC0+aXJxIDw9IDApIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0
byBtYXAgSVJROiAlZFxuIiwgcnAtPmlycSk7DQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4g
IAl9DQo+ID4NCj4gPiBAQCAtNTY0LDkgKzU3Niw5IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfYnJp
bmd1cF9saW5rKHN0cnVjdA0KPiA+IG1vYml2ZWlsX3BjaWUgKnBjaWUpICBzdGF0aWMgdm9pZCBt
b2JpdmVpbF9wY2llX2VuYWJsZV9tc2koc3RydWN0DQo+ID4gbW9iaXZlaWxfcGNpZSAqcGNpZSkg
IHsNCj4gPiAgCXBoeXNfYWRkcl90IG1zZ19hZGRyID0gcGNpZS0+cGNpZV9yZWdfYmFzZTsNCj4g
PiAtCXN0cnVjdCBtb2JpdmVpbF9tc2kgKm1zaSA9ICZwY2llLT5tc2k7DQo+ID4gKwlzdHJ1Y3Qg
bW9iaXZlaWxfbXNpICptc2kgPSAmcGNpZS0+cnAubXNpOw0KPiA+DQo+ID4gLQlwY2llLT5tc2ku
bnVtX29mX3ZlY3RvcnMgPSBQQ0lfTlVNX01TSTsNCj4gPiArCW1zaS0+bnVtX29mX3ZlY3RvcnMg
PSBQQ0lfTlVNX01TSTsNCj4gPiAgCW1zaS0+bXNpX3BhZ2VzX3BoeXMgPSAocGh5c19hZGRyX3Qp
bXNnX2FkZHI7DQo+ID4NCj4gPiAgCXdyaXRlbF9yZWxheGVkKGxvd2VyXzMyX2JpdHMobXNnX2Fk
ZHIpLA0KPiA+IEBAIC01NzksNyArNTkxLDggQEAgc3RhdGljIHZvaWQgbW9iaXZlaWxfcGNpZV9l
bmFibGVfbXNpKHN0cnVjdA0KPiA+IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+ID4NCj4gPiAgc3Rh
dGljIGludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpICB7
DQo+ID4gLQlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBwY2lfaG9zdF9icmlkZ2Vf
ZnJvbV9wcml2KHBjaWUpOw0KPiA+ICsJc3RydWN0IHJvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7
DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBycC0+YnJpZGdlOw0KPiA+
ICAJdTMyIHZhbHVlLCBwYWJfY3RybCwgdHlwZTsNCj4gPiAgCXN0cnVjdCByZXNvdXJjZV9lbnRy
eSAqd2luOw0KPiA+DQo+ID4gQEAgLTYyOSw4ICs2NDIsOCBAQCBzdGF0aWMgaW50IG1vYml2ZWls
X2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZQ0KPiAqcGNpZSkNCj4gPiAgCSAqLw0KPiA+
DQo+ID4gIAkvKiBjb25maWcgb3V0Ym91bmQgdHJhbnNsYXRpb24gd2luZG93ICovDQo+ID4gLQlw
cm9ncmFtX29iX3dpbmRvd3MocGNpZSwgV0lOX05VTV8wLCBwY2llLT5vYl9pb19yZXMtPnN0YXJ0
LCAwLA0KPiA+IC0JCQkgICBDRkdfV0lORE9XX1RZUEUsIHJlc291cmNlX3NpemUocGNpZS0+b2Jf
aW9fcmVzKSk7DQo+ID4gKwlwcm9ncmFtX29iX3dpbmRvd3MocGNpZSwgV0lOX05VTV8wLCBycC0+
b2JfaW9fcmVzLT5zdGFydCwgMCwNCj4gPiArCQkJICAgQ0ZHX1dJTkRPV19UWVBFLCByZXNvdXJj
ZV9zaXplKHJwLT5vYl9pb19yZXMpKTsNCj4gPg0KPiA+ICAJLyogbWVtb3J5IGluYm91bmQgdHJh
bnNsYXRpb24gd2luZG93ICovDQo+ID4gIAlwcm9ncmFtX2liX3dpbmRvd3MocGNpZSwgV0lOX05V
TV8wLCAwLCAwLCBNRU1fV0lORE9XX1RZUEUsDQo+ID4gSUJfV0lOX1NJWkUpOyBAQCAtNjY3LDMy
ICs2ODAsMzYgQEAgc3RhdGljIHZvaWQNCj4gPiBtb2JpdmVpbF9tYXNrX2ludHhfaXJxKHN0cnVj
dCBpcnFfZGF0YSAqZGF0YSkgIHsNCj4gPiAgCXN0cnVjdCBpcnFfZGVzYyAqZGVzYyA9IGlycV90
b19kZXNjKGRhdGEtPmlycSk7DQo+ID4gIAlzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZTsNCj4g
PiArCXN0cnVjdCByb290X3BvcnQgKnJwOw0KPiA+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
PiAgCXUzMiBtYXNrLCBzaGlmdGVkX3ZhbDsNCj4gPg0KPiA+ICAJcGNpZSA9IGlycV9kZXNjX2dl
dF9jaGlwX2RhdGEoZGVzYyk7DQo+ID4gKwlycCA9ICZwY2llLT5ycDsNCj4gPiAgCW1hc2sgPSAx
IDw8ICgoZGF0YS0+aHdpcnEgKyBQQUJfSU5UWF9TVEFSVCkgLSAxKTsNCj4gPiAtCXJhd19zcGlu
X2xvY2tfaXJxc2F2ZSgmcGNpZS0+aW50eF9tYXNrX2xvY2ssIGZsYWdzKTsNCj4gPiArCXJhd19z
cGluX2xvY2tfaXJxc2F2ZSgmcnAtPmludHhfbWFza19sb2NrLCBmbGFncyk7DQo+ID4gIAlzaGlm
dGVkX3ZhbCA9IG1vYml2ZWlsX2Nzcl9yZWFkbChwY2llLCBQQUJfSU5UUF9BTUJBX01JU0NfRU5C
KTsNCj4gPiAgCXNoaWZ0ZWRfdmFsICY9IH5tYXNrOw0KPiA+ICAJbW9iaXZlaWxfY3NyX3dyaXRl
bChwY2llLCBzaGlmdGVkX3ZhbCwgUEFCX0lOVFBfQU1CQV9NSVNDX0VOQik7DQo+ID4gLQlyYXdf
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGNpZS0+aW50eF9tYXNrX2xvY2ssIGZsYWdzKTsNCj4g
PiArCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZycC0+aW50eF9tYXNrX2xvY2ssIGZsYWdz
KTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIG1vYml2ZWlsX3VubWFza19pbnR4X2ly
cShzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpICB7DQo+ID4gIAlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2Mg
PSBpcnFfdG9fZGVzYyhkYXRhLT5pcnEpOw0KPiA+ICAJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBj
aWU7DQo+ID4gKwlzdHJ1Y3Qgcm9vdF9wb3J0ICpycDsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQo+ID4gIAl1MzIgc2hpZnRlZF92YWwsIG1hc2s7DQo+ID4NCj4gPiAgCXBjaWUgPSBpcnFf
ZGVzY19nZXRfY2hpcF9kYXRhKGRlc2MpOw0KPiA+ICsJcnAgPSAmcGNpZS0+cnA7DQo+ID4gIAlt
YXNrID0gMSA8PCAoKGRhdGEtPmh3aXJxICsgUEFCX0lOVFhfU1RBUlQpIC0gMSk7DQo+ID4gLQly
YXdfc3Bpbl9sb2NrX2lycXNhdmUoJnBjaWUtPmludHhfbWFza19sb2NrLCBmbGFncyk7DQo+ID4g
KwlyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJnJwLT5pbnR4X21hc2tfbG9jaywgZmxhZ3MpOw0KPiA+
ICAJc2hpZnRlZF92YWwgPSBtb2JpdmVpbF9jc3JfcmVhZGwocGNpZSwgUEFCX0lOVFBfQU1CQV9N
SVNDX0VOQik7DQo+ID4gIAlzaGlmdGVkX3ZhbCB8PSBtYXNrOw0KPiA+ICAJbW9iaXZlaWxfY3Ny
X3dyaXRlbChwY2llLCBzaGlmdGVkX3ZhbCwgUEFCX0lOVFBfQU1CQV9NSVNDX0VOQik7DQo+ID4g
LQlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGNpZS0+aW50eF9tYXNrX2xvY2ssIGZsYWdz
KTsNCj4gPiArCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZycC0+aW50eF9tYXNrX2xvY2ss
IGZsYWdzKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgaW50eF9p
cnFfY2hpcCA9IHsgQEAgLTc2MCw3ICs3NzcsNyBAQCBzdGF0aWMNCj4gPiBpbnQgbW9iaXZlaWxf
aXJxX21zaV9kb21haW5fYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwNCj4gPiAgCQkJ
CQkgdW5zaWduZWQgaW50IG5yX2lycXMsIHZvaWQgKmFyZ3MpICB7DQo+ID4gIAlzdHJ1Y3QgbW9i
aXZlaWxfcGNpZSAqcGNpZSA9IGRvbWFpbi0+aG9zdF9kYXRhOw0KPiA+IC0Jc3RydWN0IG1vYml2
ZWlsX21zaSAqbXNpID0gJnBjaWUtPm1zaTsNCj4gPiArCXN0cnVjdCBtb2JpdmVpbF9tc2kgKm1z
aSA9ICZwY2llLT5ycC5tc2k7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGJpdDsNCj4gPg0KPiA+ICAJ
V0FSTl9PTihucl9pcnFzICE9IDEpOw0KPiA+IEBAIC03ODcsNyArODA0LDcgQEAgc3RhdGljIHZv
aWQgbW9iaXZlaWxfaXJxX21zaV9kb21haW5fZnJlZShzdHJ1Y3QNCj4gPiBpcnFfZG9tYWluICpk
b21haW4sICB7DQo+ID4gIAlzdHJ1Y3QgaXJxX2RhdGEgKmQgPSBpcnFfZG9tYWluX2dldF9pcnFf
ZGF0YShkb21haW4sIHZpcnEpOw0KPiA+ICAJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUgPSBp
cnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsNCj4gPiAtCXN0cnVjdCBtb2JpdmVpbF9tc2kg
Km1zaSA9ICZwY2llLT5tc2k7DQo+ID4gKwlzdHJ1Y3QgbW9iaXZlaWxfbXNpICptc2kgPSAmcGNp
ZS0+cnAubXNpOw0KPiA+DQo+ID4gIAltdXRleF9sb2NrKCZtc2ktPmxvY2spOw0KPiA+DQo+ID4g
QEAgLTgwOCw5ICs4MjUsOSBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2FsbG9jYXRlX21zaV9kb21h
aW5zKHN0cnVjdA0KPiA+IG1vYml2ZWlsX3BjaWUgKnBjaWUpICB7DQo+ID4gIAlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcGNpZS0+cGRldi0+ZGV2Ow0KPiA+ICAJc3RydWN0IGZ3bm9kZV9oYW5kbGUg
KmZ3bm9kZSA9IG9mX25vZGVfdG9fZndub2RlKGRldi0+b2Zfbm9kZSk7DQo+ID4gLQlzdHJ1Y3Qg
bW9iaXZlaWxfbXNpICptc2kgPSAmcGNpZS0+bXNpOw0KPiA+ICsJc3RydWN0IG1vYml2ZWlsX21z
aSAqbXNpID0gJnBjaWUtPnJwLm1zaTsNCj4gPg0KPiA+IC0JbXV0ZXhfaW5pdCgmcGNpZS0+bXNp
LmxvY2spOw0KPiA+ICsJbXV0ZXhfaW5pdCgmbXNpLT5sb2NrKTsNCj4gPiAgCW1zaS0+ZGV2X2Rv
bWFpbiA9IGlycV9kb21haW5fYWRkX2xpbmVhcihOVUxMLA0KPiBtc2ktPm51bV9vZl92ZWN0b3Jz
LA0KPiA+ICAJCQkJCQkmbXNpX2RvbWFpbl9vcHMsIHBjaWUpOw0KPiA+ICAJaWYgKCFtc2ktPmRl
dl9kb21haW4pIHsNCj4gPiBAQCAtODM0LDE4ICs4NTEsMTkgQEAgc3RhdGljIGludCBtb2JpdmVp
bF9wY2llX2luaXRfaXJxX2RvbWFpbihzdHJ1Y3QNCj4gPiBtb2JpdmVpbF9wY2llICpwY2llKSAg
ew0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBjaWUtPnBkZXYtPmRldjsNCj4gPiAgCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiArCXN0cnVjdCByb290
X3BvcnQgKnJwID0gJnBjaWUtPnJwOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICAJLyogc2V0
dXAgSU5UeCAqLw0KPiA+IC0JcGNpZS0+aW50eF9kb21haW4gPSBpcnFfZG9tYWluX2FkZF9saW5l
YXIobm9kZSwgUENJX05VTV9JTlRYLA0KPiA+IC0JCQkJCQkgICZpbnR4X2RvbWFpbl9vcHMsIHBj
aWUpOw0KPiA+ICsJcnAtPmludHhfZG9tYWluID0gaXJxX2RvbWFpbl9hZGRfbGluZWFyKG5vZGUs
IFBDSV9OVU1fSU5UWCwNCj4gPiArCQkJCQkJJmludHhfZG9tYWluX29wcywgcGNpZSk7DQo+ID4N
Cj4gPiAtCWlmICghcGNpZS0+aW50eF9kb21haW4pIHsNCj4gPiArCWlmICghcnAtPmludHhfZG9t
YWluKSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGEgSU5UeCBJUlEgZG9t
YWluXG4iKTsNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JcmF3
X3NwaW5fbG9ja19pbml0KCZwY2llLT5pbnR4X21hc2tfbG9jayk7DQo+ID4gKwlyYXdfc3Bpbl9s
b2NrX2luaXQoJnJwLT5pbnR4X21hc2tfbG9jayk7DQo+ID4NCj4gPiAgCS8qIHNldHVwIE1TSSAq
Lw0KPiA+ICAJcmV0ID0gbW9iaXZlaWxfYWxsb2NhdGVfbXNpX2RvbWFpbnMocGNpZSk7DQo+ID4g
QEAgLTg2Miw2ICs4ODAsNyBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXN0cnVjdCBwY2lfYnVzICpjaGlsZDsN
Cj4gPiAgCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZTsNCj4gPiAgCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3Qgcm9vdF9wb3J0ICpycDsNCj4gPiAg
CWludCByZXQ7DQo+ID4NCj4gPiAgCS8qIGFsbG9jYXRlIHRoZSBQQ0llIHBvcnQgKi8NCj4gPiBA
QCAtODcwLDYgKzg4OSw4IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QN
Cj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+
ID4gIAlwY2llID0gcGNpX2hvc3RfYnJpZGdlX3ByaXYoYnJpZGdlKTsNCj4gPiArCXJwID0gJnBj
aWUtPnJwOw0KPiA+ICsJcnAtPmJyaWRnZSA9IGJyaWRnZTsNCj4gPg0KPiA+ICAJcGNpZS0+cGRl
diA9IHBkZXY7DQo+ID4NCj4gPiBAQCAtOTA0LDEyICs5MjUsMTIgQEAgc3RhdGljIGludCBtb2Jp
dmVpbF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJ
cmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJf
YW5kX2RhdGEocGNpZS0+aXJxLCBtb2JpdmVpbF9wY2llX2lzciwgcGNpZSk7DQo+ID4gKwlpcnFf
c2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YShycC0+aXJxLCBtb2JpdmVpbF9wY2llX2lzciwg
cGNpZSk7DQo+ID4NCj4gPiAgCS8qIEluaXRpYWxpemUgYnJpZGdlICovDQo+ID4gIAlicmlkZ2Ut
PmRldi5wYXJlbnQgPSBkZXY7DQo+ID4gIAlicmlkZ2UtPnN5c2RhdGEgPSBwY2llOw0KPiA+IC0J
YnJpZGdlLT5idXNuciA9IHBjaWUtPnJvb3RfYnVzX25yOw0KPiA+ICsJYnJpZGdlLT5idXNuciA9
IHJwLT5yb290X2J1c19ucjsNCj4gPiAgCWJyaWRnZS0+b3BzID0gJm1vYml2ZWlsX3BjaWVfb3Bz
Ow0KPiA+ICAJYnJpZGdlLT5tYXBfaXJxID0gb2ZfaXJxX3BhcnNlX2FuZF9tYXBfcGNpOw0KPiA+
ICAJYnJpZGdlLT5zd2l6emxlX2lycSA9IHBjaV9jb21tb25fc3dpenpsZTsNCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KPiA+DQo=
