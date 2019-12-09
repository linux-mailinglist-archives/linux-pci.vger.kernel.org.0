Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9651E11674C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 08:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfLIHDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 02:03:23 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:7564
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfLIHDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 02:03:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGgm7uEyXNGNLNw5CwBucEBMZElK9hs8SuRBkmWU3c7dRR6FZ8QYDdSf5iDFSqV8NPCUENBvnTZM0sFshYRS23mcF8Cy2PummLIfmdtKE42MKcEE4CIxLLCCPSwFJ13qErcXASZjpaqRa90e78ZzBJDGsKMgpMgZQk9od9F+J5foH1bwk2+gRy1aSOjwv2yilWCk0hv0BeneNlQpIbxXdYcMYHr7JrS/LWie8xNewjwzpc9ukRua9dKLoidoEbErGNWqojHaQo7+mIZcqJkLNqUYvkaPD4QhoXUwUMADIz4DeQcjJBX/cde1nV+v3bY7qiICVNPMsTWv5WzdhAFR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8OawPnNTQf7VsXnUocLKILZlE77g5PGerT2bOivbnc=;
 b=FVV4rQkUAwKS+vCjCSPJuLjYO9DyS1qYGMYnm/C0tfPHfDQ3M3OenhQ2GY5YADqKWwMlsLUQthco+uGQnnASGcw2Bqwtbv6tsAiBbmWVtkt+atFdPMYbdd6CAotnT+Sz43EaVSQldLmUn/5jTUGSDcLZvKaGSJqCtMXoZenq2A5y1fW3h32C46Sizr2vkTP6MgcsIHQ8SnDrypLC3G11YuDalLZDE/g4ctwcfnTd4AVGoIthILLt28CUQV6GdGUD0ifPCTo51TiQFArOH/0ja4J9QOEU0xW/tlBEzniPJpZCyr3MNqvWbSIe4YJx6e9aJ3Bq1noZ9T+4tAZAMx+L8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8OawPnNTQf7VsXnUocLKILZlE77g5PGerT2bOivbnc=;
 b=JaeZoh7qjgxyqrD1Whw1YblTUA6Xi0LqAlHyjhQ6wwBPtlso1PadxtdQc2aZZcMPcbeGMl8Rd5raq7ZFFpE5Dpc6iSA0UJBzzV8hryBV5gmjCRzr1E+6wPTYNO40OEaasF80O5l2I2uh0Irfd0+PmP18wyrFo1N+rleDeqwdlsM=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3025.eurprd04.prod.outlook.com (10.173.254.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 9 Dec 2019 07:03:17 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 07:03:17 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marc Zyngier <maz@misterjones.org>
CC:     Roy Zang <roy.zang@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Topic: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Index: AQHVqP2nw3AoM5GAtUqPe+h1Ib8VVaemy2EAgADUbVCAA8AoAIAGCskg
Date:   Mon, 9 Dec 2019 07:03:17 +0000
Message-ID: <AM5PR04MB3299C3A0DCCCE86250BBC696F5580@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <VI1PR04MB5134FEB9AF2952E84E4C1179EC5C0@VI1PR04MB5134.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5134FEB9AF2952E84E4C1179EC5C0@VI1PR04MB5134.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a901e769-403a-43da-1b38-08d77c75de51
x-ms-traffictypediagnostic: AM5PR04MB3025:|AM5PR04MB3025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3025BDE6C5464C3AFEFDFF79F5580@AM5PR04MB3025.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(43544003)(189003)(13464003)(9686003)(561944003)(478600001)(8936002)(74316002)(33656002)(8676002)(71200400001)(81156014)(71190400001)(81166006)(7696005)(5660300002)(44832011)(55016002)(966005)(76176011)(305945005)(2906002)(316002)(99286004)(53546011)(6506007)(26005)(66476007)(102836004)(66446008)(64756008)(66556008)(76116006)(52536014)(186003)(66946007)(86362001)(4326008)(54906003)(110136005)(7416002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3025;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQB2Z9sZszySHGShHWiYz5zhczD6c4pO14IYtg4dmEVJJvHbaLUVZXApcEdKT6MaWXK0L04YfXDb5ZY9wpDyWyCG60bKsPhoTbwrm7HEII4TVO7o2rj5CF9Ot/KsNrDU3j8yHo8V6kZAow7m8tCFjLg7Fpiuq1clm3trA950u3SsdGqrYeX3+/Bh+sOZ47H0O2upeSjOxjUoRoUgQ2s4j2ZNlWAkZCU/hcddHsuYG53alp5SIYDJR2vOSHxGxW5gsEi/3o8m1Lvvayg8NilADjGvFjRTOxG/sOl20f8fkDAp80yBpEyYyppS8PVi2yXzasL+XhNapKI1QYy+GcsAjzObNtymRRc49oWRK8LTIQDzyP0mhGJ66h7UgUV67ChNzPjC/tTtAqHuU6+R/Fgb7+ToUwXrJ5HiZJxBv5nXTGbdZ4c9RSYosjpi9M7dLFBX36zgNHERNpnl5azTBzOqtOcvlxOxFJB8vjO/vGHY2MTIh3+EERmxtkNMGa0hKkZhk+9m7OOizD5JTna1ndgh2fAj9idyzR1z9OLneWl/PeCCXuybnfqPAGtSsJhIfM44
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a901e769-403a-43da-1b38-08d77c75de51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 07:03:17.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7B3QzX8qbVvGu5ATYHWhy4mptJ3sjkt+Jza12trXvXGMjf7o6Jk832Jof57Smi0UtVx1C80jriK+aSsDjYmYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3025
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudGl1IFR1ZG9y
IDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4gU2VudDogMjAxOeW5tDEy5pyINeaXpSAxODo0
NQ0KPiBUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+OyBNYXJjIFp5bmdpZXIN
Cj4gPG1hekBtaXN0ZXJqb25lcy5vcmc+DQo+IENjOiBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBaLnEuIEhvdQ0KPiA8emhpcWlhbmcuaG91
QG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNLmguIExpYW4NCj4gPG1p
bmdodWFuLmxpYW5AbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBhbmRyZXcu
bXVycmF5QGFybS5jb207IGZyb3dhbmQubGlzdEBnbWFpbC5jb207IE1pbmdrYWkgSHUNCj4gPG1p
bmdrYWkuaHVAbnhwLmNvbT47IERpYW5hIE1hZGFsaW5hIENyYWNpdW4gPGRpYW5hLmNyYWNpdW5A
bnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gUENJOiBsYXllcnNjYXBlOiBBZGQgdGhl
IFNSSU9WIHN1cHBvcnQgaW4gaG9zdCBzaWRlDQo+IA0KPiBIaSBYaWFvd2VpLA0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGxpbnV4LWFybS1rZXJuZWwgPGxp
bnV4LWFybS1rZXJuZWwtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnPg0KPiA+IE9uIEJlaGFs
ZiBPZiBYaWFvd2VpIEJhbw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogTWFyYyBaeW5naWVyIDxtYXpAbWlzdGVyam9uZXMub3JnPg0KPiA+ID4gU2Vu
dDogMjAxOeW5tDEy5pyIMuaXpSAyMDo0OA0KPiA+ID4gVG86IFhpYW93ZWkgQmFvIDx4aWFvd2Vp
LmJhb0BueHAuY29tPg0KPiA+ID4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgZnJvd2FuZC5saXN0
QGdtYWlsLmNvbTsgTS5oLiBMaWFuDQo+ID4gPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWlu
Z2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95DQo+IFphbmcNCj4gPiA+IDxyb3kuemFu
Z0BueHAuY29tPjsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gPiA+IGFuZHJldy5tdXJy
YXlAYXJtLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiA+ID4gWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSF0gUENJOiBsYXllcnNjYXBlOiBBZGQgdGhlIFNSSU9WIHN1cHBvcnQgaW4gaG9zdA0K
PiA+ID4gc2lkZQ0KPiA+ID4NCj4gPiA+IE9uIDIwMTktMTItMDIgMTA6NDUsIFhpYW93ZWkgQmFv
IHdyb3RlOg0KPiA+ID4gPiBHSUMgZ2V0IHRoZSBtYXAgcmVsYXRpb25zIG9mIGRldmlkIGFuZCBz
dHJlYW0gaWQgZnJvbSB0aGUgbXNpLW1hcA0KPiA+ID4gPiBwcm9wZXJ0eSBvZiBEVFMsIG91ciBw
bGF0Zm9ybSBhZGQgdGhpcyBwcm9wZXJ0eSBpbiB1LWJvb3QgYmFzZSBvbg0KPiA+ID4gPiB0aGUg
UENJZSBkZXZpY2UgaW4gdGhlIGJ1cywgYnV0IGlmIGVuYWJsZSB0aGUgdmYgZGV2aWNlIGluIGtl
cm5lbCwNCj4gPiA+ID4gdGhlIHZmIGRldmljZSBtc2ktbWFwIHdpbGwgbm90IHNldCwgc28gdGhl
IHZmIGRldmljZSBjYW4ndCB3b3JrLA0KPiA+ID4gPiB0aGlzIHBhdGNoIHB1cnBvc2UgaXMgdGhh
dCBtYW5hZ2UgdGhlIHN0cmVhbSBpZCBhbmQgZGV2aWNlIGlkIG1hcA0KPiA+ID4gPiByZWxhdGlv
bnMgZHluYW1pY2FsbHkgaW4ga2VybmVsLCBhbmQgbWFrZSB0aGUgbmV3IFBDSWUgZGV2aWNlIHdv
cmsgaW4NCj4ga2VybmVsLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2Vp
IEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L29mL2lycS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrDQo+ID4gPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jIHwgOTQNCj4gPiA+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIGRyaXZlcnMvcGNpL3Byb2Jl
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKw0KPiA+ID4gPiAgZHJpdmVycy9wY2kv
cmVtb3ZlLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4gPiA+ICA0IGZpbGVz
IGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL29mL2lycS5jIGIvZHJpdmVycy9vZi9pcnEuYyBpbmRleA0KPiA+ID4gPiBhMjk2
ZWFmLi43OTFlNjA5IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL29mL2lycS5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvb2YvaXJxLmMNCj4gPiA+ID4gQEAgLTU3Niw2ICs1NzYsMTEgQEAg
dm9pZCBfX2luaXQgb2ZfaXJxX2luaXQoY29uc3Qgc3RydWN0DQo+ID4gPiA+IG9mX2RldmljZV9p
ZA0KPiA+ID4gPiAqbWF0Y2hlcykNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+
ID4gPiA+ICt1MzIgX193ZWFrIGxzX3BjaWVfc3RyZWFtaWRfZml4KHN0cnVjdCBkZXZpY2UgKmRl
diwgdTMyIHJpZCkgew0KPiA+ID4gPiArCXJldHVybiByaWQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+
ICsNCj4gPiA+ID4gIHN0YXRpYyB1MzIgX19vZl9tc2lfbWFwX3JpZChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdA0KPiA+ID4gPiBkZXZpY2Vfbm9kZSAqKm5wLA0KPiA+ID4gPiAgCQkJICAgIHUz
MiByaWRfaW4pDQo+ID4gPiA+ICB7DQo+ID4gPiA+IEBAIC01OTAsNiArNTk1LDEwIEBAIHN0YXRp
YyB1MzIgX19vZl9tc2lfbWFwX3JpZChzdHJ1Y3QgZGV2aWNlDQo+ID4gPiA+ICpkZXYsIHN0cnVj
dCBkZXZpY2Vfbm9kZSAqKm5wLA0KPiA+ID4gPiAgCQlpZiAoIW9mX21hcF9yaWQocGFyZW50X2Rl
di0+b2Zfbm9kZSwgcmlkX2luLCAibXNpLW1hcCIsDQo+ID4gPiA+ICAJCQkJIm1zaS1tYXAtbWFz
ayIsIG5wLCAmcmlkX291dCkpDQo+ID4gPiA+ICAJCQlicmVhazsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCWlmIChyaWRfb3V0ID09IHJpZF9pbikNCj4gPiA+ID4gKwkJcmlkX291dCA9IGxzX3BjaWVf
c3RyZWFtaWRfZml4KHBhcmVudF9kZXYsIHJpZF9pbik7DQo+ID4gPg0KPiA+ID4gT3ZlciBteSBk
ZWFkIGJvZHkuIEdldCB5b3VyIGZpcm13YXJlIHRvIHByb3Blcmx5IHByb2dyYW0gdGhlIExVVCBz
bw0KPiA+ID4gdGhhdA0KPiA+IGl0DQo+ID4gPiBwcmVzZW50cyB0aGUgSVRTIHdpdGggYSByZWFz
b25hYmxlIHRvcG9sb2d5LiBUaGVyZSBpcyBhYnNvbHV0ZWx5IG5vDQo+ID4gPiB3YXkNCj4gPiB0
aGlzDQo+ID4gPiBraW5kIG9mIGNoYW5nZSBtYWtlcyBpdCBpbnRvIHRoZSBrZXJuZWwuDQo+ID4N
Cj4gPiBTb3JyeSBmb3IgdGhpcywgSSBrbm93IGl0IGlzIG5vdCByZWFzb25hYmxlLCBidXQgSSBo
YXZlIG5vIG90aGVyIHdheSwNCj4gPiBhcyBJIGtub3csIEFSTSBnZXQgdGhlIG1hcHBpbmcgb2Yg
c3RyZWFtIElEIHRvIHJlcXVlc3QgSUQgZnJvbSB0aGUNCj4gPiBtc2ktbWFwIHByb3BlcnR5IG9m
IERUUywgaWYgYWRkIGEgbmV3IGRldmljZSB3aGljaCBuZWVkIHRoZSBzdHJlYW0gSUQNCj4gPiBh
bmQgdHJ5IHRvIGdldCBpdCBmcm9tIHRoZSBtc2ktIG1hcCBvZiBEVFMsIGl0IHdpbGwgZmFpbGVk
IGFuZCBub3QNCj4gPiB3b3JrLCB5ZXM/IFNvIGNvdWxkIHlvdSBnaXZlIG1lIGEgYmV0dGVyIGFk
dmljZSB0byBmaXggdGhpcyBpc3N1ZSwgSQ0KPiA+IHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIGFu
eSBjb21tZW50cyBvciBzdWdnZXN0aW9ucywgdGhhbmtzIGEgbG90Lg0KPiA+DQo+IA0KPiBJIGFn
cmVlIHdpdGggdGhlIGNvbW11bml0eSB0aGF0IHRoaXMgc2hvdWxkIGJlIHRhY2tsZWQgaW4gZmly
bXdhcmUuIEkgYWN0dWFsbHkNCj4gc3VibWl0dGVkIChieSBtaXN0YWtlLCBidXQgbGV0J3MgZGlz
cmVnYXJkIHRoYXQgOi0pKSBhIHNpbXBsZSBwcm9wb3NhbCBpbiB1LWJvb3QNCj4gWzFdIHRoYXQg
c2hvdWxkIHRha2UgY2FyZSBvZiBpdC4gV2UgY2FuIGRpc2N1c3MgZnVydGhlciBvbiBpdCwgaWYg
eW91IHdpc2guDQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8x
MDMzNDY2Lw0KDQoNCkkgd2lsbCBkbyBhIGV4cGVyaW1lbnQgdG8gdmVyaWZ5IHdoZXRoZXIgYWxs
IFBDSWUgcmVxdWVzdCBJRCBtYXAgb25lIHN0cmVhbSBJRCwNCmFuZCBJIHdpbGwgc2hvdyB0aGUg
cmVzdWx0IHdoZW4gSSBjb21wbGV0ZSB0aGUgZXhwZXJpbWVudC4NCg0KVGhhbmtzIA0KWGlhb3dl
aQ0KDQo+IA0KPiAtLS0NCj4gQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUNCg==
