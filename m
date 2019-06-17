Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4847FC2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFQKek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:34:40 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:60686
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfFQKek (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 06:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dCKS5C0RkqmmBysLg029DtthcWAR6EsokNjzo6iY8U=;
 b=efWpemaaiL9oa6nrhk/UD0jYQhtgwfmkZb87JN1AhAHItKCovvjqPDPbVr6H4B1N6aZce/LgO3J3+P5Gb9hruT7lnqkrDei59F0XCi+Uw6gxZDEPMqZ3D4DB+sBsBccNjsIyIK8KWsh8RdZUVRdP+kMK947++Eg3/OLqaXAIJsI=
Received: from AM6PR04MB6742.eurprd04.prod.outlook.com (20.179.246.158) by
 AM6PR04MB4615.eurprd04.prod.outlook.com (20.176.243.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 10:34:36 +0000
Received: from AM6PR04MB6742.eurprd04.prod.outlook.com
 ([fe80::cdfd:dd0c:dcaf:95b1]) by AM6PR04MB6742.eurprd04.prod.outlook.com
 ([fe80::cdfd:dd0c:dcaf:95b1%7]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 10:34:36 +0000
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
Subject: RE: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHU8Qqz/gJFKoxI7kSHS+a5VfCWFaaXDAuAgAE1ccCAABw2gIAD74cQgAOwLICAAA4C0A==
Date:   Mon, 17 Jun 2019 10:34:35 +0000
Message-ID: <AM6PR04MB67425792524FBA1C773F137984EB0@AM6PR04MB6742.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-5-Zhiqiang.Hou@nxp.com>
 <20190611165935.GA22836@redmoon>
 <AM0PR04MB67383023B81AEB33DAF9C35584EC0@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190612130813.GA15747@redmoon>
 <AM0PR04MB6738B93C7F1B5BE433753CF584E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190617093337.GD18020@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190617093337.GD18020@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 696ee325-dc3c-4996-e860-08d6f30f64c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4615;
x-ms-traffictypediagnostic: AM6PR04MB4615:
x-microsoft-antispam-prvs: <AM6PR04MB4615DCABA50AAC3D4F662FFE84EB0@AM6PR04MB4615.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(13464003)(71200400001)(25786009)(6436002)(76176011)(11346002)(476003)(53546011)(229853002)(6506007)(4326008)(9686003)(6116002)(3846002)(68736007)(55016002)(6246003)(54906003)(478600001)(446003)(102836004)(14454004)(186003)(66446008)(64756008)(66556008)(53936002)(73956011)(76116006)(66946007)(7696005)(66476007)(256004)(316002)(14444005)(2906002)(8936002)(8676002)(81156014)(81166006)(74316002)(7736002)(26005)(86362001)(305945005)(52536014)(99286004)(6916009)(5660300002)(486006)(33656002)(7416002)(71190400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4615;H:AM6PR04MB6742.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8LpoCgRsRJ34sNVRrvcu6d9pTdSD5radnEuLR/+UMSnjT4mBd67g4e4moTOif7QEzV2s4I5G4Rkhlu/oZSqOpAE4pgbh1qMCiau26lDqtwhpMz5vT/G0Fympu6bScpEHjZzMLJj7RuqQKWdFuITjMsu8hJr1PJcUEsVkxsLaAYf8otACKmqqDu9W+h7OHFXEVVyS/s+rirfcfo71fSBGpnCNfVrgdaCfajxrcIyIqQOUv7OQ/CiyaRAtbsGib+eKKuygCFY/daf7eXAAUzB8ZHSJgslSRNFgkf70q7NcQbwBepG+3qWnZGFBNeCJ7dt39jVgUCeo0dfmFe6mZcLCzgE8f37Rrg/vbALXM+EfDwGgSHWnJzPPgV9irwA30ZRFGMlXKyHWj1k20jkwPWyogJIS0scI69sH1+GtsaDmjM0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ee325-dc3c-4996-e860-08d6f30f64c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 10:34:35.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4615
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAxOeW5
tDbmnIgxN+aXpSAxNzozNA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0K
PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gTWluZ2thaSBI
dSA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+
Ow0KPiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSHY1IDA0LzIwXSBQQ0k6IG1vYml2ZWlsOiBSZW1vdmUgdGhlIGZsYWcNCj4gTVNJX0ZMQUdf
TVVMVElfUENJX01TSQ0KPiANCj4gT24gU2F0LCBKdW4gMTUsIDIwMTkgYXQgMDE6MzA6MzlBTSAr
MDAwMCwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4gSGkgTG9yZW56bywNCj4gPg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExvcmVuem8gUGllcmFsaXNpIFttYWls
dG86bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbV0NCj4gPiA+IFNlbnQ6IDIwMTnlubQ25pyIMTLm
l6UgMjE6MDgNCj4gPiA+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+ID4g
PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0
QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiA+ID4gbC5zdWJyYWhtYW55YUBt
b2JpdmVpbC5jby5pbjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+ID4gPiA8bGVveWFu
Zy5saUBueHAuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFy
bS5jb207DQo+ID4gPiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4N
Cj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47DQo+ID4gPiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5i
YW9AbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NSAwNC8yMF0gUENJOiBtb2Jp
dmVpbDogUmVtb3ZlIHRoZSBmbGFnDQo+ID4gPiBNU0lfRkxBR19NVUxUSV9QQ0lfTVNJDQo+ID4g
Pg0KPiA+ID4gT24gV2VkLCBKdW4gMTIsIDIwMTkgYXQgMTE6MzQ6NTFBTSArMDAwMCwgWi5xLiBI
b3Ugd3JvdGU6DQo+ID4gPiA+IEhpIExvcmVuem8sDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBh
IGxvdCBmb3IgeW91ciBjb21tZW50cyENCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPg0KPiA+ID4gPiA+IFNlbnQ6IDIwMTnlubQ25pyIMTLml6UgMTow
MA0KPiA+ID4gPiA+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+ID4gPiA+
ID4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IGJoZWxnYWFz
QGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+
ID4gPiA+ID4gbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbjsgc2hhd25ndW9Aa2VybmVsLm9y
ZzsgTGVvIExpDQo+ID4gPiA+ID4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOw0KPiA+ID4gd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gPiA+ID4gPiBNaW5na2Fp
IEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPiA+IDxtaW5naHVhbi5saWFu
QG54cC5jb20+Ow0KPiA+ID4gPiA+IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0K
PiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NSAwNC8yMF0gUENJOiBtb2JpdmVpbDogUmVt
b3ZlIHRoZSBmbGFnDQo+ID4gPiA+ID4gTVNJX0ZMQUdfTVVMVElfUENJX01TSQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTIsIDIwMTkgYXQgMDg6MzU6MzZBTSArMDAwMCwgWi5x
LiBIb3Ugd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBjdXJyZW50IGNvZGUgZG9l
cyBub3Qgc3VwcG9ydCBtdWx0aXBsZSBNU0lzLCBzbyByZW1vdmUgdGhlDQo+ID4gPiA+ID4gPiBj
b3JyZXNwb25kaW5nIGZsYWcgZnJvbSB0aGUgbXNpX2RvbWFpbl9pbmZvIHN0cnVjdHVyZS4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFBsZWFzZSBleHBsYWluIG1lIHdoYXQncyB0aGUgcHJvYmxlbSBi
ZWZvcmUgcmVtb3ZpbmcgbXVsdGkgTVNJDQo+IHN1cHBvcnQuDQo+ID4gPiA+DQo+ID4gPiA+IE5Y
UCBMWDIgUENJZSB1c2UgdGhlIEdJQy1JVFMgaW5zdGVhZCBvZiBNb2JpdmVpbCBJUCBpbnRlcm5h
bCBNU0kNCj4gPiA+ID4gY29udHJvbGxlciwgc28sIEkgZGlkbid0IGVuY291bnRlciBwcm9ibGVt
Lg0KPiA+ID4NCj4gPiA+IFdlbGwsIHlvdSBzZW50IGEgcGF0Y2ggdG8gZml4IGFuIGlzc3VlLCBl
eHBsYWluIG1lIHRoZSBpc3N1ZSB5b3UgYXJlDQo+ID4gPiBmaXhpbmcgdGhlbiwgYWthIHdoYXQg
aGF2ZSB5b3Ugc2VudCB0aGlzIHBhdGNoIGZvciA/DQo+ID4NCj4gPiBJIGRpZCBub3QgZmFjZSBp
c3N1ZSwgYXMgSSBoYXZlIGV4cGxhaW5lZCBOWFAgZG9lcyBub3QgdXNlIHRoZQ0KPiA+IE1vYml2
ZWlsIElQJ3MgTVNJIGNvbnRyb2xsZXIuICBCdXQgb2J2aW91c2x5IHRoZSBNU0kgYWxsb2NhdGUg
ZnVuY3Rpb24NCj4gPiBkb2VzIG5vdCBzdXBwb3J0IG11bHRpcGxlIE1TSSwgc28gSSBzdWJtaXR0
ZWQgdGhpcyBwYXRjaC4NCj4gDQo+IFRoZXJlIGlzIG5vdGhpbmcgb2J2aW91cy4gV3JpdGUgd2hh
dCB5b3UgYXJlIGZpeGluZyBpbiB0aGUgY29tbWl0IGxvZyBhbmQgSSB3aWxsDQo+IGFwcGx5IHRo
ZSBwYXRjaCwgSSB3b24ndCB3cml0ZSB0aGUgY29tbWl0IGxvZyBmb3IgeW91LiBBbnlvbmUgc2hv
dWxkIGJlIGFibGUNCj4gdG8gdW5kZXJzdGFuZCB3aHkgYSBwYXRjaCB3YXMgbmVlZGVkIGJ5IHJl
YWRpbmcgdGhlIGNvbW1pdCBsb2csIGl0IGlzIGFzDQo+IGltcG9ydGFudCBhcyB3cml0aW5nIHRo
ZSBjb2RlIGl0c2VsZi4NCg0KV2l0aCB0aGUgZmxhZyBNU0lfRkxBR19NVUxUSV9QQ0lfTVNJLCB3
aGVuIHRoZSBFbmRwb2ludCBhbGxvY2F0ZXMgbXVsdGlwbGUNCk1TSSwgaXQgd2lsbCB0cmlnZ2Vy
IHRoZSAiV0FSTl9PTihucl9pcnFzICE9IDEpOyIgaW4gbW9iaXZlaWxfaXJxX21zaV9kb21haW5f
YWxsb2MoKSwNCnRoaXMgaXMgdGhlIGlzc3VlIHRoaXMgcGF0Y2ggd2FudCB0byBmaXguIA0KDQpU
aGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IExvcmVuem8NCj4gDQo+ID4gVGhh
bmtzLA0KPiA+IFpoaXFpYW5nDQo+ID4NCj4gPiA+DQo+ID4gPiBMb3JlbnpvDQo+ID4gPg0KPiA+
ID4gPiBTdWJidSwgZGlkIHlvdSB0ZXN0IHdpdGggRW5kcG9pbnQgc3VwcG9ydGluZyBtdWx0aSBN
U0k/DQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gWmhpcWlhbmcNCj4gPiA+ID4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiBMb3JlbnpvDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IEZpeGVzOiAxZTkxM2U1ODMzNWYgKCJQQ0k6IG1vYml2ZWlsOiBBZGQg
TVNJIHN1cHBvcnQiKQ0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxa
aGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBNaW5naHVhbiBM
aWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+
IFY1Og0KPiA+ID4gPiA+ID4gIC0gQ29ycmVjdGVkIHRoZSBzdWJqZWN0Lg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyB8IDIg
Ky0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiA+IGluZGV4IDU2MzIxMGU3MzFkMy4u
YTBkZDMzN2M2MjE0IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gPiA+ID4gPiBAQCAtNzAzLDcgKzcwMyw3IEBAIHN0
YXRpYyBzdHJ1Y3QgaXJxX2NoaXANCj4gPiA+ID4gPiA+IG1vYml2ZWlsX21zaV9pcnFfY2hpcCA9
IHsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgc3RhdGljIHN0cnVjdCBtc2lfZG9tYWluX2lu
Zm8gbW9iaXZlaWxfbXNpX2RvbWFpbl9pbmZvID0gew0KPiA+ID4gPiA+ID4gIAkuZmxhZ3MJPSAo
TVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTIHwNCj4gPiA+ID4gPiBNU0lfRkxBR19VU0VfREVGX0NI
SVBfT1BTIHwNCj4gPiA+ID4gPiA+IC0JCSAgIE1TSV9GTEFHX01VTFRJX1BDSV9NU0kgfCBNU0lf
RkxBR19QQ0lfTVNJWCksDQo+ID4gPiA+ID4gPiArCQkgICBNU0lfRkxBR19QQ0lfTVNJWCksDQo+
ID4gPiA+ID4gPiAgCS5jaGlwCT0gJm1vYml2ZWlsX21zaV9pcnFfY2hpcCwNCj4gPiA+ID4gPiA+
ICB9Ow0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiAyLjE3LjENCj4g
PiA+ID4gPiA+DQo=
