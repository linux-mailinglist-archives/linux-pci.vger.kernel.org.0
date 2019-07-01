Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32F5B8F2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 12:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGAK1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 06:27:50 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:41294
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGAK1u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 06:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUhGPYRi2ANEFS9ovpX/t35XfP1KJPlRUS0Gmo6xnDM=;
 b=Rk5fBktkunWwxWf4LNFf4tT6vxFzVPaKDbvC+0W4MnDNjm8ydHYy/VIgeCtKzwt2+gOSzpWyZCSH8/Vv/di+7FTUhnFL8UT1FYUtRFg0bNrpRAotBDmTX91L6Ea2c3HL+8TIYMEMKJ8t4L7arf1cmGdRvN8oMN05whpBRDo1kpk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5737.eurprd04.prod.outlook.com (20.179.9.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 10:27:46 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 10:27:46 +0000
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
Subject: RE: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Topic: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Index: AQHU8QrIICRAPGaNQUWlVdR7PlC4dKaxxWUAgARHCcA=
Date:   Mon, 1 Jul 2019 10:27:46 +0000
Message-ID: <DB8PR04MB67473911A253C9B7EF9FF1F484F90@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190628170552.GD21829@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190628170552.GD21829@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f13949ae-0153-4c05-d37d-08d6fe0ec27c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB5737;
x-ms-traffictypediagnostic: DB8PR04MB5737:
x-microsoft-antispam-prvs: <DB8PR04MB5737509C3DFF9CB63B62F0B384F90@DB8PR04MB5737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(13464003)(54534003)(199004)(189003)(74316002)(14444005)(11346002)(478600001)(476003)(446003)(7416002)(256004)(66066001)(76116006)(7736002)(68736007)(52536014)(305945005)(33656002)(86362001)(64756008)(66946007)(73956011)(66446008)(66556008)(2906002)(486006)(6116002)(99286004)(55016002)(76176011)(6916009)(5660300002)(9686003)(3846002)(102836004)(53936002)(8676002)(66476007)(6506007)(14454004)(316002)(7696005)(71200400001)(6436002)(26005)(25786009)(4326008)(71190400001)(6246003)(53546011)(229853002)(8936002)(54906003)(81156014)(186003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5737;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8E9qg9R9owK2VZLGCEY73zxzx+pAMpCyuG06HjaXMXs3zlhcPa0DIwf96Id6S0aqCpc0iQI2P3ZZTUJc09NpteAgTpSnWxyXqFW7HXdA+XVOQizT0RohA16yBbYnd8RdLrfE0SahBHVhSKAbdSz710jmlYxbdLSl1huSUovEkEIKBFmwBLuWECYyFHilDnZeY7osPB3aU/3UCUA/LcBBPtL6nFvCd9GngJ1mwySBLs4gguExwaKS282LTKK8BvhiRexU/4l3Oq+7PBfY6liM+B0u8SwF7TGkKxyRbI9KoAyH79jU4805RZicEKudEJCVqrJoAt+SW5bKFtVv3ncaEIRLG0WfeopW/sh0BnU6OPIYVcnu3WncJPZTjl8hv1dn7mUiI+cnDM9pbK8D9ub/UD+C84yKLuIDPlohCoYycZM=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13949ae-0153-4c05-d37d-08d6fe0ec27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 10:27:46.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5737
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOo21MIyOcjVIDE6MDYNCj4gVG86IFou
cS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxn
YWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207
DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExl
byBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdp
bGwuZGVhY29uQGFybS5jb207DQo+IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0u
aC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NSAxMC8yMF0gUENJOiBtb2JpdmVp
bDogRml4IHRoZSBJTlR4IHByb2Nlc3MgZXJyb3JzDQo+IA0KPiBPbiBGcmksIEFwciAxMiwgMjAx
OSBhdCAwODozNjoxMkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gSW4gdGhlIGxvb3AgYmxvY2ss
IHRoZXJlIGlzIG5vdCBjb2RlIHRvIHVwZGF0ZSB0aGUgbG9vcCBrZXksIHRoaXMNCj4gPiBwYXRj
aCB1cGRhdGVzIHRoZSBsb29wIGtleSBieSByZS1yZWFkIHRoZSBJTlR4IHN0YXR1cyByZWdpc3Rl
ci4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWxzbyBhZGQgdGhlIGNsZWFyaW5nIG9mIHRoZSBoYW5k
bGVkIElOVHggc3RhdHVzLg0KPiANCj4gVGhpcyBpcyB0d28gYnVncyBhbmQgdGhhdCByZXF1aXJl
cyB0d28gcGF0Y2hlcywgZWFjaCBvZiB0aGVtIGZpeGluZyBhIHNwZWNpZmljDQo+IGlzc3VlLg0K
PiANCj4gU28gc3BsaXQgdGhlIHBhdGNoIGludG8gdHdvIGFuZCByZXBvc3QgaXQuDQoNClllcywg
d2lsbCBzcGxpdCBpdC4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCiANCj4gTG9yZW56bw0KPiANCj4g
PiBOb3RlOiBOZWVkIE1WIHRvIHRlc3QgdGhpcyBmaXguDQo+ID4NCj4gPiBGaXhlczogOWFmNmJj
YjExZTEyICgiUENJOiBtb2JpdmVpbDogQWRkIE1vYml2ZWlsIFBDSWUgSG9zdCBCcmlkZ2UgSVAN
Cj4gPiBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxp
YW5AbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU3VicmFobWFueWEgTGluZ2FwcGEgPGwuc3Vi
cmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQo+ID4gLS0tDQo+ID4gVjU6DQo+ID4gIC0gQ29ycmVj
dGVkIGFuZCByZXRvdWNoZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCj4gPg0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyB8IDEzICsrKysrKysrKy0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwu
Yw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBpbmRl
eCA0YmE0NTg0NzRlNDIuLjc4ZTU3NWU3MWY0ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gQEAgLTM2MSw2ICszNjEsNyBAQCBzdGF0aWMgdm9p
ZCBtb2JpdmVpbF9wY2llX2lzcihzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+ID4gIAkvKiBIYW5k
bGUgSU5UeCAqLw0KPiA+ICAJaWYgKGludHJfc3RhdHVzICYgUEFCX0lOVFBfSU5UWF9NQVNLKSB7
DQo+ID4gIAkJc2hpZnRlZF9zdGF0dXMgPSBjc3JfcmVhZGwocGNpZSwgUEFCX0lOVFBfQU1CQV9N
SVNDX1NUQVQpOw0KPiA+ICsJCXNoaWZ0ZWRfc3RhdHVzICY9IFBBQl9JTlRQX0lOVFhfTUFTSzsN
Cj4gPiAgCQlzaGlmdGVkX3N0YXR1cyA+Pj0gUEFCX0lOVFhfU1RBUlQ7DQo+ID4gIAkJZG8gew0K
PiA+ICAJCQlmb3JfZWFjaF9zZXRfYml0KGJpdCwgJnNoaWZ0ZWRfc3RhdHVzLCBQQ0lfTlVNX0lO
VFgpIHsgQEANCj4gLTM3MiwxMg0KPiA+ICszNzMsMTYgQEAgc3RhdGljIHZvaWQgbW9iaXZlaWxf
cGNpZV9pc3Ioc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPiA+ICAJCQkJCWRldl9lcnJfcmF0ZWxp
bWl0ZWQoZGV2LCAidW5leHBlY3RlZCBJUlEsDQo+IElOVCVkXG4iLA0KPiA+ICAJCQkJCQkJICAg
IGJpdCk7DQo+ID4NCj4gPiAtCQkJCS8qIGNsZWFyIGludGVycnVwdCAqLw0KPiA+IC0JCQkJY3Ny
X3dyaXRlbChwY2llLA0KPiA+IC0JCQkJCSAgIHNoaWZ0ZWRfc3RhdHVzIDw8IFBBQl9JTlRYX1NU
QVJULA0KPiA+ICsJCQkJLyogY2xlYXIgaW50ZXJydXB0IGhhbmRsZWQgKi8NCj4gPiArCQkJCWNz
cl93cml0ZWwocGNpZSwgMSA8PCAoUEFCX0lOVFhfU1RBUlQgKyBiaXQpLA0KPiA+ICAJCQkJCSAg
IFBBQl9JTlRQX0FNQkFfTUlTQ19TVEFUKTsNCj4gPiAgCQkJfQ0KPiA+IC0JCX0gd2hpbGUgKChz
aGlmdGVkX3N0YXR1cyA+PiBQQUJfSU5UWF9TVEFSVCkgIT0gMCk7DQo+ID4gKw0KPiA+ICsJCQlz
aGlmdGVkX3N0YXR1cyA9IGNzcl9yZWFkbChwY2llLA0KPiA+ICsJCQkJCQkgICBQQUJfSU5UUF9B
TUJBX01JU0NfU1RBVCk7DQo+ID4gKwkJCXNoaWZ0ZWRfc3RhdHVzICY9IFBBQl9JTlRQX0lOVFhf
TUFTSzsNCj4gPiArCQkJc2hpZnRlZF9zdGF0dXMgPj49IFBBQl9JTlRYX1NUQVJUOw0KPiA+ICsJ
CX0gd2hpbGUgKHNoaWZ0ZWRfc3RhdHVzICE9IDApOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIAkvKiBy
ZWFkIGV4dHJhIE1TSSBzdGF0dXMgcmVnaXN0ZXIgKi8NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+
DQo=
