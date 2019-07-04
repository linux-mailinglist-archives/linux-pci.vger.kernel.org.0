Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4445F178
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfGDCgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 22:36:23 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:54663
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfGDCgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSTOMkBtGgQ4njuNQopKlmLys2aNez1c+RC+I1N6DnQ=;
 b=C64ZZldIq7YxV8UFHhiwDqWdvPSoyoUkex/EHHKI3iibrCGSRtjZ3Ds1zRCHI83d6mh5Pf/XoVehjLKFHr6wFCI6MwKxTEFp4dgciHLkvkvalUDVFRsAZI71Ne6q9/NfeJt3sJSyB9xPkXTofY1k4Q6EI6cwXyBMdIaRbceMpPk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7163.eurprd04.prod.outlook.com (10.141.120.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Thu, 4 Jul 2019 02:36:17 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 02:36:17 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv5 00/20] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Thread-Topic: [PATCHv5 00/20] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Thread-Index: AQHU8Qqk94Z0xb1jhECZwFnfMTeEPKa5M2CAgAEMSdA=
Date:   Thu, 4 Jul 2019 02:36:17 +0000
Message-ID: <DB8PR04MB6747061D1DBE0AD88267390284FA0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190703103319.GA26804@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190703103319.GA26804@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52746520-8b1f-498e-4510-08d700286421
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7163;
x-ms-traffictypediagnostic: DB8PR04MB7163:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR04MB7163CB59303990623097727284FA0@DB8PR04MB7163.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(189003)(199004)(13464003)(6916009)(25786009)(81156014)(81166006)(55016002)(2906002)(6246003)(4326008)(33656002)(53936002)(74316002)(71200400001)(26005)(11346002)(71190400001)(7416002)(446003)(476003)(229853002)(486006)(68736007)(7696005)(102836004)(99286004)(8936002)(966005)(76176011)(14454004)(53546011)(6506007)(256004)(478600001)(45080400002)(64756008)(6436002)(186003)(6306002)(52536014)(6116002)(3846002)(86362001)(66066001)(5660300002)(7736002)(76116006)(66946007)(8676002)(9686003)(73956011)(66476007)(54906003)(305945005)(66446008)(66556008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7163;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WMHYwYoAN7DUlViT5qcn9PjFw+LsN/TwVta+WISz1TWV70CZs29hxL0+0UEHvrc+zT/qInbXxsru+2/ifmiMjDP00xYzVqigTIiv0YbsrT1JbUEoOezijI/SlOEg4AXCdPsWeCBNmjfaAzW6zP6+ZILxybowI8GjjFgqB3Plx8y0bNrmXnOPxqXvvjbIRpArTvyK9/1B6QQldKhdbGnwcLM20lgNdEK31EGpg3cD0jsM1MEdONtOmjm8MGBbncWWOEpG0uYjfm4qyPhjqO07Q+wB/Iz1W9D4Hva7ddvl4vE2bpyhjY9Ji3AVFD6nR2d/yGJrobLjS74gZAahmDldTXkgazVr2Dx45ncrjtbuDqw5+RpqB/Ddsg1Ke0QXWJ30pkHOfA4tip7bxFX7icewiKoDA0wAA3YhbZ84HYATWeM=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52746520-8b1f-498e-4510-08d700286421
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 02:36:17.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOo31MIzyNUgMTg6MzMNCj4gVG86IFou
cS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxn
YWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207
DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExl
byBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdp
bGwuZGVhY29uQGFybS5jb207DQo+IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0u
aC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NSAwMC8yMF0gUENJOiBtb2JpdmVp
bDogZml4ZXMgZm9yIE1vYml2ZWlsIFBDSWUgSG9zdA0KPiBCcmlkZ2UgSVAgZHJpdmVyDQo+IA0K
PiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAwODozNToxMUFNICswMDAwLCBaLnEuIEhvdSB3cm90
ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBzZXQgaXMgdG8gYWRkIGZpeGVzIGZvciBNb2JpdmVpbCBQQ0llIEhvc3Qg
ZHJpdmVyLg0KPiA+IEFuZCB0aGVzZSBwYXRjaGVzIGFyZSBzcGxpdGVkIGZyb20gdGhlIHRocmVh
ZCBiZWxvdzoNCj4gPg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnBhdGNoDQo+ID4NCj4gd29yay5vemxhYnMub3JnJTJG
cHJvamVjdCUyRmxpbnV4LXBjaSUyRmxpc3QlMkYlM0ZzZXJpZXMlM0Q5NjQxNyZhbQ0KPiBwO2QN
Cj4gPg0KPiBhdGE9MDIlN0MwMSU3Q3poaXFpYW5nLmhvdSU0MG54cC5jb20lN0MwZDMyMTY1Mjc0
YmY0YzY3OGI0ODA4ZA0KPiA2ZmZhMWU0Mg0KPiA+DQo+IGYlN0M2ODZlYTFkM2JjMmI0YzZmYTky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTc3NDY4MTcyNzINCj4gMjQ3MSZhbXA7DQo+ID4N
Cj4gc2RhdGE9UkxnZnlOUkJJUmVQdUxGVENRZTRSUVlsZWVYRGV2d3RWTjRJNlpGa1MxcyUzRCZh
bXA7cmVzZXJ2DQo+IGVkPTANCj4gPg0KPiA+IEhvdSBaaGlxaWFuZyAoMjApOg0KPiA+ICAgUENJ
OiBtb2JpdmVpbDogVW5pZnkgcmVnaXN0ZXIgYWNjZXNzb3JzDQo+ID4gICBQQ0k6IG1vYml2ZWls
OiBGb3JtYXQgdGhlIGNvZGUgd2l0aG91dCBmdW5jdGlvbmFsaXR5IGNoYW5nZQ0KPiA+ICAgUENJ
OiBtb2JpdmVpbDogQ29ycmVjdCB0aGUgcmV0dXJuZWQgZXJyb3IgbnVtYmVyDQo+ID4gICBQQ0k6
IG1vYml2ZWlsOiBSZW1vdmUgdGhlIGZsYWcgTVNJX0ZMQUdfTVVMVElfUENJX01TSQ0KPiA+ICAg
UENJOiBtb2JpdmVpbDogQ29ycmVjdCBQQ0kgYmFzZSBhZGRyZXNzIGluIE1FTS9JTyBvdXRib3Vu
ZCB3aW5kb3dzDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBSZXBsYWNlIHRoZSByZXNvdXJjZSBsaXN0
IGl0ZXJhdGlvbiBmdW5jdGlvbg0KPiA+ICAgUENJOiBtb2JpdmVpbDogVXNlIFdJTl9OVU1fMCBl
eHBsaWNpdGx5IGZvciBDRkcgb3V0Ym91bmQgd2luZG93DQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBV
c2UgdGhlIDFzdCBpbmJvdW5kIHdpbmRvdyBmb3IgTUVNIGluYm91bmQNCj4gdHJhbnNhY3Rpb25z
DQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBDb3JyZWN0IGluYm91bmQvb3V0Ym91bmQgd2luZG93IHNl
dHVwIHJvdXRpbmVzDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBGaXggdGhlIElOVHggcHJvY2VzcyBl
cnJvcnMNCj4gPiAgIFBDSTogbW9iaXZlaWw6IENvcnJlY3QgdGhlIGZpeHVwIG9mIENsYXNzIENv
ZGUgZmllbGQNCj4gPiAgIFBDSTogbW9iaXZlaWw6IE1vdmUgdGhlIGxpbmsgdXAgd2FpdGluZyBv
dXQgb2YgbW9iaXZlaWxfaG9zdF9pbml0KCkNCj4gPiAgIFBDSTogbW9iaXZlaWw6IE1vdmUgSVJR
IGNoYWluZWQgaGFuZGxlciBzZXR1cCBvdXQgb2YgRFQgcGFyc2UNCj4gPiAgIFBDSTogbW9iaXZl
aWw6IEluaXRpYWxpemUgUHJpbWFyeS9TZWNvbmRhcnkvU3Vib3JkaW5hdGUgYnVzIG51bWJlcnMN
Cj4gPiAgIFBDSTogbW9iaXZlaWw6IEZpeCB0aGUgY2hlY2tpbmcgb2YgdmFsaWQgZGV2aWNlDQo+
ID4gICBQQ0k6IG1vYml2ZWlsOiBBZGQgbGluayB1cCBjb25kaXRpb24gY2hlY2sNCj4gPiAgIFBD
STogbW9iaXZlaWw6IENvbXBsZXRlIGluaXRpYWxpemF0aW9uIG9mIGhvc3QgZXZlbiBpZiBubyBQ
Q0llIGxpbmsNCj4gPiAgIFBDSTogbW9iaXZlaWw6IERpc2FibGUgSUIgYW5kIE9CIHdpbmRvd3Mg
c2V0IGJ5IGJvb3Rsb2FkZXINCj4gPiAgIFBDSTogbW9iaXZlaWw6IEFkZCA4LWJpdCBhbmQgMTYt
Yml0IHJlZ2lzdGVyIGFjY2Vzc29ycw0KPiA+ICAgZHQtYmluZGluZ3M6IFBDSTogbW9iaXZlaWw6
IENoYW5nZSBncGlvX3NsYXZlIGFuZCBhcGJfY3NyIHRvDQo+ID4gb3B0aW9uYWwNCj4gPg0KPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwtcGNpZS50eHQgfCAgIDIgKw0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyAgICAgICAgfCA1Nzgg
KysrKysrKysrKystLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzY4IGluc2VydGlvbnMo
KyksIDIxMiBkZWxldGlvbnMoLSkNCj4gDQo+IEkgYW0gcHV0dGluZyB0b2dldGhlciBhIGJyYW5j
aCB3aXRoIHRoZSBwYXRjaGVzIEkgd291bGQgbGlrZSB0byBxdWV1ZSwgZm9yDQo+IHRoZSBvbmVz
IEkgcmVxdWVzdGVkIHRvIHNwbGl0IHBsZWFzZSB3YWl0IGZvciBtZSwgSSB3aWxsIHB1Ymxpc2gg
dGhlIGJyYW5jaCBhbmQNCj4gd2lsbCBhc2sgeW91IHRvIHJlYmFzZSBvbiB0b3Agb2YgaXQuDQo+
DQoNCk9rLCB3aWxsIHNwbGl0IHRoZW0gYW5kIHJlYmFzZSBvbiB0aGUgbmV3IGJyYW5jaC4NCg0K
VGhhbmtzLA0KWmhpcWlhbmcNCiANCj4gTG9yZW56bw0K
