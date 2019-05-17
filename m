Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6933821A17
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfEQOxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 10:53:10 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:18323
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbfEQOxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 10:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll3Uf7MHPXpKcQUSat8bRWp7autIzTIRe1+BrWBvKQo=;
 b=em/f6B2ZjszO3nytZFFfR3hCdPlOgvtFKkyAS44gTVpw+w34M4OoSZnTcud5PYhAZv5+CD50YGaKRNjevIDBwOkPTqLkjLXZLUCzIOfeCAWB1LWF13Om6pSCLQfbgTRMNP2rexLHJEoP3L13702ZZWlwMSqpCVFIXLZ5IlJnZPU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4149.eurprd04.prod.outlook.com (52.135.166.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 14:52:26 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 14:52:26 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Karthikeyan M <m.karthikeyan@mobiveil.co.in>
CC:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Thread-Topic: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Thread-Index: AQHVBzcF8JsFww2OMEuvH6tu4ID8QqZvcO8Q
Date:   Fri, 17 May 2019 14:52:26 +0000
Message-ID: <AM6PR04MB5781A290AA8442F629328274840B0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20190510134811.GG235064@google.com>
In-Reply-To: <20190510134811.GG235064@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d42701-a9ae-447e-b145-08d6dad74750
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4149;
x-ms-traffictypediagnostic: AM6PR04MB4149:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB4149A86C2B559C46F1231CF0840B0@AM6PR04MB4149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(13464003)(189003)(199004)(8676002)(4326008)(81156014)(81166006)(6436002)(229853002)(15650500001)(316002)(8936002)(14444005)(256004)(25786009)(52536014)(6306002)(55016002)(5660300002)(3846002)(102836004)(99286004)(76176011)(74316002)(6116002)(7736002)(86362001)(2906002)(53546011)(6506007)(9686003)(7696005)(305945005)(6246003)(73956011)(76116006)(66946007)(54906003)(68736007)(110136005)(33656002)(14454004)(71190400001)(66476007)(478600001)(66446008)(53936002)(71200400001)(66556008)(64756008)(476003)(26005)(486006)(446003)(11346002)(186003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4149;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bIJI5/PRpOkm3vPlTLq9gyvwODNMOQ+whduxdkMDKrgQBhPXhRYnTi5rAGPBv76ZqnaDd04A46P4viQaZj3exxJ9wYO+iIyauXF7DJUlgvSRGjwtHiZjnpYWBWWn5G1jt/+g0pZJDn3k6QPN2qVRxKUqhm7ycdwdtckMFfNM45OAnYUuF3T0XGHkaZ7oa7g5CQers8JaETkBI4vs2jROAukrBGr0R2UBoQ1sgmRz+1b9SdkGkRxtzuhdy8XQ2qIFtvflZ8H9qwM5KyTWnQulKaSf3G6fgi/RnZ7O/P8gTqcjY9CJcJZhxdfJv35+v+suNgzU7ZnMVZAf+c9SrGDqdwI9FDGcZimZFGMpN5caFmCnEjL/jJJhGyTDKpQFWtfwk2sAWmHhr2jivUS5fO24luJOU56OKdD+j9oUTsSEpCI=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d42701-a9ae-447e-b145-08d6dad74750
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 14:52:26.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4149
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgW21h
aWx0bzpoZWxnYWFzQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnE6jXUwjEwyNUgMjE6NDgNCj4g
VG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IEthcnRoaWtleWFuIE0NCj4gPG0u
a2FydGhpa2V5YW5AbW9iaXZlaWwuY28uaW4+DQo+IENjOiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8
bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj47DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFd
IFBDSTogbW9iaXZlaWw6IFVwZGF0ZSBtYWludGFpbmVycyBsaXN0DQo+IA0KPiBPbiBUdWUsIE1h
eSAwNywgMjAxOSBhdCAwNzo0NToxNkFNIC0wNDAwLCBTdWJyYWhtYW55YSBMaW5nYXBwYSB3cm90
ZToNCj4gPiBBZGQgS2FydGhpa2V5YW4gTSBhbmQgWi5RLiBIb3UgYXMgbmV3IG1haW50YWluZXJz
IG9mIE1vYml2ZWlsDQo+ID4gY29udHJvbGxlciBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4N
Cj4gDQo+IEknZCBsaWtlIHRvIGluY2x1ZGUgdGhpcyBBU0FQIHNvIHBhdGNoZXMgZ2V0IHNlbnQg
dG8gdGhlIHJpZ2h0IHBsYWNlLCBhbmQgSSB3YW50DQo+IHRvIG1ha2Ugc3VyZSB3ZSBzcGVsbCB0
aGUgbmFtZXMgYW5kIGVtYWlsIGFkZHJlc3NlcyBjb3JyZWN0bHkuDQo+IA0KPiBaaGlxaWFuZywg
eW91IGNvbnNpc3RlbnRseSB1c2UgIkhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+
Ig0KPiBmb3Igc2lnbi1vZmZzIFsxXSAoZXhjZXB0IGZvciAiWi5xLiBIb3UiIGluIGVtYWlsIGhl
YWRlcnMpLiAgQ2FuIHlvdSBhY2sgdGhhdA0KPiB0aGUgdXBkYXRlZCBwYXRjaCBiZWxvdyBpcyBj
b3JyZWN0IGZvciB5b3U/DQo+IA0KPiBLYXJ0aGlrZXlhbiwgSSBkb24ndCBzZWUgYW55IGVtYWls
IG9yIGNvbW1pdHMgZnJvbSB5b3UgeWV0LCBzbyBJJ2QgcmVhbGx5IGxpa2UNCj4geW91ciBhY2sg
YWxvbmcgd2l0aCB0aGUgY2Fub25pY2FsIG5hbWUvZW1haWwgYWRkcmVzcyB5b3UgcHJlZmVyLg0K
PiBUaGVyZSBpcyBhbm90aGVyIEthcnRoaWtleWFuIGFscmVhZHkgaW4gTUFJTlRBSU5FUlMsIHNv
IGhvcGVmdWxseSB3ZSBjYW4NCj4gYXZvaWQgYW55IGNvbmZ1c2lvbi4NCj4gDQo+IFsxXSBnaXQg
bG9nIC0tZm9ybWF0PSIlYW4gPCVhZT4iIC0tYXV0aG9yPVtael1oaXFpYW5nDQo+IA0KPiA+IC0t
LQ0KPiA+ICBNQUlOVEFJTkVSUyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVS
UyBiL01BSU5UQUlORVJTIGluZGV4IDBhNTIwNjEuLjA4Mjk1YTUgMTAwNjQ0DQo+ID4gLS0tIGEv
TUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xMTkwMCw3ICsxMTkw
MCw4IEBAIEY6CWluY2x1ZGUvbGludXgvc3dpdGNodGVjLmgNCj4gPiAgRjoJZHJpdmVycy9udGIv
aHcvbXNjYy8NCj4gPg0KPiA+ICBQQ0kgRFJJVkVSIEZPUiBNT0JJVkVJTCBQQ0lFIElQDQo+ID4g
LU06CVN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0K
PiA+ICtNOglLYXJ0aGlrZXlhbiBNIDxtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluPg0KPiA+
ICtNOglaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+ID4gIEw6CWxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJU3VwcG9ydGVkDQo+ID4gIEY6CURvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwtcGNpZS50eHQNCj4gDQo+IA0KPiBjb21t
aXQgZDI2MGZmOGQzMzUzDQo+IEF1dGhvcjogU3VicmFobWFueWEgTGluZ2FwcGEgPGwuc3VicmFo
bWFueWFAbW9iaXZlaWwuY28uaW4+DQo+IERhdGU6ICAgVHVlIE1heSA3IDA3OjQ1OjE2IDIwMTkg
LTA0MDANCj4gDQo+ICAgICBNQUlOVEFJTkVSUzogQWRkIEthcnRoaWtleWFuIE0gYW5kIEhvdSBa
aGlxaWFuZyBmb3IgTW9iaXZlaWwgUENJDQo+IA0KPiAgICAgQWRkIEthcnRoaWtleWFuIE0gYW5k
IEhvdSBaaGlxaWFuZyBhcyBuZXcgbWFpbnRhaW5lcnMgb2YgTW9iaXZlaWwNCj4gICAgIGNvbnRy
b2xsZXIgZHJpdmVyLg0KPiANCj4gICAgIExpbms6DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2UNCj4gcm5l
bC5vcmclMkZsaW51eC1wY2klMkYxNTU3MjI5NTE2LTY4NzAtMS1naXQtc2VuZC1lbWFpbC1sLnN1
YnJhaG1hbnlhJQ0KPiA0MG1vYml2ZWlsLmNvLmluJmFtcDtkYXRhPTAyJTdDMDElN0N6aGlxaWFu
Zy5ob3UlNDBueHAuY29tJTdDZmFmZWYNCj4gNDgyNjNjMzQ3MDRjNzEzMDhkNmQ1NGUyNmQ2JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUNCj4gJTdDMCU3QzAlN0M2MzY5MzA5Mjg5
NzAwOTEwODkmYW1wO3NkYXRhPW96alRBUjJ5UEhaMWI0bVJGZ0syDQo+IHdhWGpXRjNPTVBFV3ZL
NFY3RmJ6czV3JTNEJmFtcDtyZXNlcnZlZD0wDQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBTdWJyYWht
YW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gICAgIFtiaGVs
Z2FhczogdXBkYXRlIG5hbWVzL2VtYWlsIGFkZHJlc3NlcyB0byBtYXRjaCB1c2FnZSBpbiBnaXQg
aGlzdG9yeV0NCj4gICAgIFNpZ25lZC1vZmYtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdv
b2dsZS5jb20+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
PiBpbmRleCBlMTdlYmY3MGI1NDguLjQyZDdmNDRjYzBlMSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRB
SU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTExODgwLDcgKzExODgwLDggQEAgRjoJ
aW5jbHVkZS9saW51eC9zd2l0Y2h0ZWMuaA0KPiAgRjoJZHJpdmVycy9udGIvaHcvbXNjYy8NCj4g
DQo+ICBQQ0kgRFJJVkVSIEZPUiBNT0JJVkVJTCBQQ0lFIElQDQo+IC1NOglTdWJyYWhtYW55YSBM
aW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gK006CUthcnRoaWtleWFu
IE0gPG0ua2FydGhpa2V5YW5AbW9iaXZlaWwuY28uaW4+DQo+ICtNOglIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiAgTDoJbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiAg
UzoJU3VwcG9ydGVkDQo+ICBGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21vYml2ZWlsLXBjaWUudHh0DQoNCkFja2VkLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0K
