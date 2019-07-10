Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062E06457F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGJLAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 07:00:00 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:35394
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfGJK77 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 06:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfjadrs8/RVcClOsSH8trK1RH1VdNKOlkLfrE5OTEbG7z3bWoSyXNc51OkPJjttCuZ6YWgXiHaxRQKEfoYukTsoZNnHiHTed1dOyZHu/Pf0SfYKUxZ1VzopnUX8y3evLZtCQSsHe32V1abXhCToChSYQ9SteSVbHoZ43rjF3rUPAMh3wDWk9KW7VCBsLtmZFKCtdMg7sWKYDr9R1xB9DOnJww2wpgVa+4VaQ7xOzi5JJxvoe8LsPhuS/QmKtStK1Psi0WWSh1u3gjRog2nUJ6T0cI5XWjYCYJtEgxY7TyVfULdnbHPNk1Pav24JsZoLrJsrjVrwrHhR+mQiFo9WxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyWWdvUG0udGBdzuETdyV9wbouWvstbi2Ru0hPwH1Yk=;
 b=njoGFlHsFIp4Tj0ctOoqspJO6kwicbyLBz9OAXe0VTFX3migQhmzd2fJNj+Gc5ea9bgnaweof0ZiuOggMVKcBTF/37hJgC4m2WeE7he/C60/0liIu942ECdCLB2J8KHm/g5/P4qkH2emLnck3BOdg3gFdrkImfSKTfeFo0dAJhvJCh+u6z3YwuqOvFL0In+UbHoSw6U4LTyVILG+HgQdJSzPcGyaqX5Cw2J/xzd5hoteRmPHXV3T36t6IpRaPJmISfKjT5YWwJUPXwlRBJ1qOL84x2WJzw3WuhG3XdoryjwW7g5ILa/ZCddloJABEtJ4rVL7CEtbCg1kYdTHsPx7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyWWdvUG0udGBdzuETdyV9wbouWvstbi2Ru0hPwH1Yk=;
 b=ZKMn521M91dQaM+D3bVKRha9TqFqgUNyMFscGGqbxgAFXbO6hUW/aHilrpGN+eKirwKnWfKEy3L9ulaQXfNmLvSkrfdewHUOQUmu53SVDlYlLV9iSxeWHlBeyzYkc4Vlqr0qpba58rvi0rg17y+bqqeZkwAMyYPDGi3Lwe2A5is=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7081.eurprd04.prod.outlook.com (10.141.120.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 10:59:55 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 10:59:55 +0000
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
Subject: RE: [PATCHv6 00/28] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Thread-Topic: [PATCHv6 00/28] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Thread-Index: AQHVMxlmjw5aCO+Wjkqv+IAkHKqDIKbAnCqAgAMGNJA=
Date:   Wed, 10 Jul 2019 10:59:54 +0000
Message-ID: <DB8PR04MB674701F8622A1C46FF0C3D6284F00@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
 <20190708113503.GA21942@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190708113503.GA21942@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca371bbc-6951-490b-11fa-08d70525bdca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7081;
x-ms-traffictypediagnostic: DB8PR04MB7081:
x-microsoft-antispam-prvs: <DB8PR04MB70812ED875ECCC50CA81CB2484F00@DB8PR04MB7081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(54534003)(66066001)(66946007)(66476007)(64756008)(66446008)(55016002)(66556008)(71190400001)(71200400001)(76116006)(33656002)(14454004)(2906002)(6436002)(54906003)(86362001)(229853002)(99286004)(25786009)(53936002)(6116002)(3846002)(7696005)(8676002)(74316002)(81166006)(81156014)(305945005)(6246003)(7416002)(52536014)(9686003)(14444005)(5660300002)(6916009)(256004)(186003)(26005)(6506007)(53546011)(102836004)(76176011)(476003)(486006)(11346002)(316002)(68736007)(478600001)(446003)(8936002)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7081;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MfaObObXVl89mG2eRlk3lx6+SEEZml0cyp7crImZXcJBO/jk3sU372uf+oknemJakdf5vuixD2SPZUka/hzvVkdVBQE+yo+fnLutHipOOG1pPGyd81rOkvcKUNjT9AYCZeE2uiEFOJ44EdLWwZGYw5WYpGoL09aN2W3EasYEY8yOAMn8WT3uAnciOlAbcHyYB4MAoC62Xa05Czj1PuhJzbrqa/ht+nv3Nqfv64TYdCbdO6WeMc6gq7jCRtmY+JRQVk+2NDyEJfOmYlgEjmuYVGqBmwDnrmQ5DyiLes/QF2uOHswuhENzkp3srYiOuCPBZ8s7ulAQJC4CIiD4yci0d2F1yht1XKT8V48ncOqtYnp+2NUT+M2DYuhanQffTUbnHKYWwnT3G9wXJjoUJu3IO3/23hwb5bjQP489c9zCXiA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca371bbc-6951-490b-11fa-08d70525bdca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 10:59:54.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOo31MI4yNUgMTk6MzUNCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdv
b2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwu
c3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0K
PiA8bGVveWFuZy5saUBueHAuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVh
Y29uQGFybS5jb207DQo+IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlh
biA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NiAwMC8yOF0gUENJOiBtb2JpdmVpbDogZml4
ZXMgZm9yIE1vYml2ZWlsIFBDSWUgSG9zdA0KPiBCcmlkZ2UgSVAgZHJpdmVyDQo+IA0KPiBPbiBG
cmksIEp1bCAwNSwgMjAxOSBhdCAwNTo1NjoyOFBNICswODAwLCBIb3UgWmhpcWlhbmcgd3JvdGU6
DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgdG8gYWRkIGZpeGVzIGZvciBNb2JpdmVpbCBQQ0llIEhv
c3QgZHJpdmVyLg0KPiA+IFNwbGl0ZWQgIzIsICMzLCAjOSBhbmQgIzEwIG9mIHY1IHBhdGNoZXMu
DQo+ID4NCj4gPiBIb3UgWmhpcWlhbmcgKDI4KToNCj4gPiAgIFBDSTogbW9iaXZlaWw6IFVuaWZ5
IHJlZ2lzdGVyIGFjY2Vzc29ycw0KPiA+ICAgUENJOiBtb2JpdmVpbDogUmVtb3ZlIHRoZSBmbGFn
IE1TSV9GTEFHX01VTFRJX1BDSV9NU0kNCj4gPiAgIFBDSTogbW9iaXZlaWw6IEZpeCBQQ0kgYmFz
ZSBhZGRyZXNzIGluIE1FTS9JTyBvdXRib3VuZCB3aW5kb3dzDQo+ID4gICBQQ0k6IG1vYml2ZWls
OiBVcGRhdGUgdGhlIHJlc291cmNlIGxpc3QgdHJhdmVyc2FsIGZ1bmN0aW9uDQo+ID4gICBQQ0k6
IG1vYml2ZWlsOiBVc2UgV0lOX05VTV8wIGV4cGxpY2l0bHkgZm9yIENGRyBvdXRib3VuZCB3aW5k
b3cNCj4gPiAgIFBDSTogbW9iaXZlaWw6IFVzZSB0aGUgMXN0IGluYm91bmQgd2luZG93IGZvciBN
RU0gaW5ib3VuZA0KPiA+ICAgICB0cmFuc2FjdGlvbnMNCj4gPiAgIFBDSTogbW9iaXZlaWw6IEZp
eCB0aGUgQ2xhc3MgQ29kZSBmaWVsZA0KPiA+ICAgUENJOiBtb2JpdmVpbDogTW92ZSB0aGUgbGlu
ayB1cCB3YWl0aW5nIG91dCBvZiBtb2JpdmVpbF9ob3N0X2luaXQoKQ0KPiA+ICAgUENJOiBtb2Jp
dmVpbDogTW92ZSBJUlEgY2hhaW5lZCBoYW5kbGVyIHNldHVwIG91dCBvZiBEVCBwYXJzZQ0KPiA+
ICAgUENJOiBtb2JpdmVpbDogSW5pdGlhbGl6ZSBQcmltYXJ5L1NlY29uZGFyeS9TdWJvcmRpbmF0
ZSBidXMgbnVtYmVycw0KPiA+ICAgUENJOiBtb2JpdmVpbDogRml4IGRldmZuIGNoZWNrIGluIG1v
Yml2ZWlsX3BjaWVfdmFsaWRfZGV2aWNlKCkNCj4gPiAgIGR0LWJpbmRpbmdzOiBQQ0k6IG1vYml2
ZWlsOiBDaGFuZ2UgZ3Bpb19zbGF2ZSBhbmQgYXBiX2NzciB0byBvcHRpb25hbA0KPiA+ICAgUENJ
OiBtb2JpdmVpbDogUmVmb3JtYXQgdGhlIGNvZGUgZm9yIHJlYWRhYmlsaXR5DQo+ID4gICBQQ0k6
IG1vYml2ZWlsOiBNYWtlIHRoZSByZWdpc3RlciB1cGRhdGluZyBtb3JlIHJlYWRhYmxlDQo+ID4g
ICBQQ0k6IG1vYml2ZWlsOiBSZXZpc2UgdGhlIE1FTS9JTyBvdXRib3VuZCB3aW5kb3cgaW5pdGlh
bGl6YXRpb24NCj4gPiAgIFBDSTogbW9iaXZlaWw6IEZpeCB0aGUgcmV0dXJuZWQgZXJyb3IgbnVt
YmVyDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBSZW1vdmUgYW4gdW5uZWNlc3NhcnkgcmV0dXJuIHZh
bHVlIGNoZWNrDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBSZW1vdmUgcmVkdW5kYW50IHZhciBkZWZp
bml0aW9ucyBhbmQgcmVnaXN0ZXIgcmVhZA0KPiA+ICAgICBvcGVyYXRpb25zDQo+ID4gICBQQ0k6
IG1vYml2ZWlsOiBGaXggdGhlIHZhbGlkIGNoZWNrIGZvciBpbmJvdW5kIGFuZCBvdXRib3VuZCB3
aW5kb3cNCj4gPiAgIFBDSTogbW9iaXZlaWw6IEFkZCB0aGUgc3RhdGlzdGljIG9mIGluaXRpYWxp
emVkIGluYm91bmQgd2luZG93cw0KPiA+ICAgUENJOiBtb2JpdmVpbDogQ2xlYXIgdGhlIHRhcmdl
dCBmaWVsZHMgYmVmb3JlIHVwZGF0aW5nIHRoZSByZWdpc3Rlcg0KPiA+ICAgUENJOiBtb2JpdmVp
bDogTWFzayBvdXQgdGhlIGxvd2VyIDEwLWJpdCBoYXJkY29kZSB3aW5kb3cgc2l6ZQ0KPiA+ICAg
UENJOiBtb2JpdmVpbDogQWRkIHVwcGVyIDMyLWJpdCBDUFUgYmFzZSBhZGRyZXNzIHNldHVwIGlu
IG91dGJvdW5kDQo+ID4gICAgIHdpbmRvdw0KPiA+ICAgUENJOiBtb2JpdmVpbDogQWRkIHVwcGVy
IDMyLWJpdCBQQ0kgYmFzZSBhZGRyZXNzIHNldHVwIGluIGluYm91bmQNCj4gPiAgICAgd2luZG93
DQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBGaXggdGhlIENQVSBiYXNlIGFkZHJlc3Mgc2V0dXAgaW4g
aW5ib3VuZCB3aW5kb3cNCj4gPiAgIFBDSTogbW9iaXZlaWw6IE1vdmUgUENJZSBQSU8gZW5hYmxl
bWVudCBvdXQgb2YgaW5ib3VuZCB3aW5kb3cNCj4gcm91dGluZQ0KPiA+ICAgUENJOiBtb2JpdmVp
bDogRml4IGluZmluaXRlLWxvb3AgaW4gdGhlIElOVHggcHJvY2Vzcw0KPiA+ICAgUENJOiBtb2Jp
dmVpbDogRml4IHRoZSBwb3RlbnRpYWwgSU5UeCBtaXNzaW5nIHByb2JsZW0NCj4gPg0KPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwtcGNpZS50eHQgICAgICB8ICAgIDIg
Kw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyAgICAgICAgICAg
ICB8ICA1MjkNCj4gKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAz
MTggaW5zZXJ0aW9ucygrKSwgMjEzIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBPSywgSSByZXdy
b3RlIG1vc3Qgb2YgY29tbWl0IGxvZ3MsIGRyb3BwZWQgcGF0Y2ggMjUgc2luY2UgSSBkbyBub3QN
Cj4gdW5kZXJzdGFuZCB0aGUgY29tbWl0IGxvZywgcHVzaGVkIHRvIHBjaS9tb2JpdmVpbCB0ZW50
YXRpdmVseSBmb3IgdjUuMy4NCiANClRoZSBwYXRjaCAjMjUgaXMgdG8gZml4IHRoZSB3cm9uZ2x5
IHByb2dyYW1taW5nIG9mIHRoZSBDUFUgYmFzZSBhZGRyZXNzIG9mDQp0aGUgaW5ib3VuZCB3aW5k
b3dzLiBUaGUgY3VycmVudCBjb2RlIHNldCB0aGUgQ1BVIGJhc2UgYWRkcmVzcyB3aXRoIHRoZQ0K
UENJIGJhc2UgYWRkcmVzcyBwYXJhbWV0ZXIgd2hpY2ggaXMgdGhlIGNhbGxlciBwYXNzZWQgdG8g
c2V0IHRoZSBQQ0kgYmFzZQ0KYWRkcmVzcyBvZiB0aGUgaW5ib3VuZCB3aW5kb3csIGFuZCB0aGUg
dXBwZXIgMzItYml0IG9mIHRoZSBDUFUgYmFzZSBhZGRyZXNzDQpvZiB0aGUgaW5ib3VuZCB3aW5k
b3cgaXMgbm90IHNldCBpbiBjdXJyZW50IGNvZGUuDQoNClNvIGl0IG1lYW5zIHRoZSBjdXJyZW50
IGNvZGUgb25seSBzdXBwb3J0IDE6MSBpbmJvdW5kIHdpbmRvdyBzZXR0aW5nICYgdGhlDQpDUFUg
YmFzZSBhZGRyZXNzIG11c3QgYmUgPCA0R0IuIEl0IHdvbid0IHdvcmsgaWYgaW4gZnV0dXJlIHNv
bWVvbmUgY2hhbmdlDQppdCB0byBub24gMToxIG1hcHBpbmcgb3IgdGhlIENQVSBiYXNlIGFkZHJl
c3Mgb2YgdGhlIGluYm91bmQgd2luZG93ID4gNEdCLg0KDQpTbywgSSB3aWxsIHJlc2VuZCBpdCBz
ZXBhcmF0ZWx5Lg0KDQo+IEhhdmluZyBzYWlkIHRoYXQsIHlvdSBzaG91bGQgaW1wcm92ZSBjb21t
aXQgbG9ncyB3cml0aW5nIGl0IHRvb2sgbWUgdG9vDQo+IG11Y2ggdGltZSB0byBjaGVjayB0aGVt
IGFsbCBhbmQgcmV3cml0ZSB0aGVtLg0KPiANCj4gTmV2ZXIgZXZlciBhZ2FpbiBwb3N0IGEgbWFz
c2l2ZSBzZXJpZXMgbGlrZSB0aGlzIG1peGluZyByZWZhY3RvcmluZyBmaXhlcyBhbmQNCj4gY2xl
YW4tdXBzIGl0IHdhcyBwYWluZnVsIHRvIHJldmlldy9yZWJhc2UsIHBsZWFzZSBzcGxpdCBwYXRj
aCBzZXJpZXMgaW50byBzbWFsbA0KPiBjaHVua3MgdG8gbWFrZSBteSBsaWZlIG11Y2ggZWFzaWVy
Lg0KDQpJIHVuZGVyc3RhbmQgaXQgaXMgd2Vhcmlzb21lLCBidXQgSSBqdXN0IHdhbnQgdG8gbWFr
ZSBpdCBiZXR0ZXIgYW5kIGVhc2llciB0bw0KYWRkIG5ldyBkcml2ZXIgZm9yIG90aGVyIGRldmVs
b3BlcnMuIEkgd2lsbCB0cnkgdG8gbm90IG1peCB0aGUgZGlzdGluY3QgY2hhbmdlcw0Kc28gdGhh
dCBlYXN5IHRvIG1haW50YWluLg0KVGhhbmsgeW91IHNvIG11Y2ggZm9yIHJlY29tcG9zaW5nIG9m
IHRoZXNlIGNoYW5nZWxvZ3MuDQogDQo+IFBsZWFzZSBjaGVjayBteSBwY2kvbW9iaXZlaWwgYnJh
bmNoIGFuZCByZXBvcnQgYmFjayBpZiBzb21ldGhpbmcgaXMgbm90IGluDQo+IG9yZGVyLg0KDQpZ
ZXMsIGFuZCB0aGFua3MgYWdhaW4uDQoNCkIuUiwNClpoaXFpYW5nDQoNCj4gTG9yZW56bw0K
