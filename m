Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF133032
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfFCMuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 08:50:04 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:29955
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfFCMuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 08:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U743IyRSRUgzb5q3qelEMoxByx7tXa+xhJrOgYaKUlw=;
 b=O1wBxMzULrzG3nxolOIbuRNtxDrrO7dPcE+IFogafNRyAHNJV+bMYBxGOf/63TtQyaY5/9L5x8JnsIpArUVpUAfnMWux2Q7j5Lj4vDa591Py4pfhedxanegI175bFa8MsPcFLF6MQl+IhhTq7+cFrKT7nrz1ImfNcHfWIU8+lTY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (20.177.32.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 12:49:55 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7802:2937:f7e9:20ed]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7802:2937:f7e9:20ed%4]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:49:55 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
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
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv6 5/6] arm64: dts: lx2160a: Add PCIe controller DT nodes
Thread-Topic: [PATCHv6 5/6] arm64: dts: lx2160a: Add PCIe controller DT nodes
Thread-Index: AQHVFSGl3meyBFqLK0uVITlDpjdEh6aJa6KAgABTP2A=
Date:   Mon, 3 Jun 2019 12:49:55 +0000
Message-ID: <AM6PR04MB578147FD591EB0059646023D84140@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190528065129.8769-1-Zhiqiang.Hou@nxp.com>
 <20190528065129.8769-6-Zhiqiang.Hou@nxp.com>
 <CAKnKUHH8JU2Bqgq90rfgZ8r0xxB_RMRj16DBBLDhMpg3mwFU2Q@mail.gmail.com>
In-Reply-To: <CAKnKUHH8JU2Bqgq90rfgZ8r0xxB_RMRj16DBBLDhMpg3mwFU2Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c90722d0-42d2-46f6-8849-08d6e821fac9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB4792;
x-ms-traffictypediagnostic: AM6PR04MB4792:
x-microsoft-antispam-prvs: <AM6PR04MB4792901B4EED3C0E5400E1D684140@AM6PR04MB4792.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(13464003)(53936002)(6246003)(52536014)(14454004)(9686003)(25786009)(4326008)(478600001)(102836004)(55016002)(99286004)(11346002)(6436002)(229853002)(3846002)(53546011)(6116002)(6506007)(5660300002)(7696005)(76176011)(54906003)(76116006)(6916009)(5024004)(74316002)(305945005)(486006)(7736002)(14444005)(256004)(186003)(2906002)(446003)(476003)(68736007)(26005)(66556008)(7416002)(316002)(33656002)(8936002)(71200400001)(71190400001)(66446008)(66476007)(64756008)(8676002)(66066001)(73956011)(81166006)(86362001)(81156014)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4792;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8isiii4g0OM0AhbZQIe1cMBgRACw//mOBmSD0nyrMWpYNegB5h2fO8yUlWP+NvTgGHcbVYxYXi3Bg+kuCAiYj3+561lJCHiB5UGPAgKfdvqw9+rSMBOHRaUQL3D8vRobii25Dx8iZk8N3QdBLRkNLhrzImBkUl3mtLLhET6P6OktW/L01rLld0r4xeUNvus5eDnDwaRBsq4Ef5R3QVG6qpH+w9zw1xhaadw9hbHt8UzWn1fZb0Ys1RK8Z7KLhwvvyLSCnRAGncC6wdXss42VF7eikXWrt+5TwsW8L89XJdgK+96WzSyfGawv6fi+QpUqLjgGY+fXw5tn9kogcQbbRDXMtoY98phDwPUsJ8/A1i/ccqlhq3ljkxnNwvqwXZHZSVEeljfoktY6Ty1wxSPg+lYUkV7dGhUqvM/3x58lzCs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90722d0-42d2-46f6-8849-08d6e821fac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:49:55.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4792
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2FydGhpa2V5YW4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYXJ0aGlrZXlhbiBNaXRyYW4gW21h
aWx0bzptLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluXQ0KPiBTZW50OiAyMDE55bm0NuaciDPm
l6UgMTM6MTMNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgYXJu
ZEBhcm5kYi5kZTsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGwuc3VicmFobWFueWFAbW9iaXZl
aWwuY28uaW47DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPjsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5j
b207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNv
bT47IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8gPHhp
YW93ZWkuYmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NiA1LzZdIGFybTY0OiBk
dHM6IGx4MjE2MGE6IEFkZCBQQ0llIGNvbnRyb2xsZXIgRFQgbm9kZXMNCj4gDQo+IEhpIEhvdSBa
aGlxaWFuZw0KPiAgICBUd28gaW5zdGFuY2VzIFtAMzYwMDAwMCBhbmQgQDM4MDAwMDBdIG9mIHRo
ZSBzaXggaGFzIGEgZGlmZmVyZW50DQo+IHdpbmRvdyBjb3VudCwgdGhlIFJDIGNhbiBub3QgaGF2
ZSBtb3JlIHRoYW4gOCB3aW5kb3dzLg0KPiBhcGlvLXdpbnMgPSA8MjU2PjsgIC8vQ2FuIHdlIGNo
YW5nZSBpdCB0byA4DQo+IHBwaW8td2lucyA9IDwyND47ICAgIC8vQ2FuIHdlIGNoYW5nZSBpdCB0
byA4DQo+IA0KDQpJIGNoZWNrZWQgd2l0aCBoYXJkd2FyZSB0ZWFtLCB0aGUgUENJZSBjb250cm9s
bGVycyBAMzYwMDAwMCBhbmQgQDM4MDAwMDAgc3VwcG9ydA0KdXAgdG8geDggYW5kIFNSSU9WLCB0
aGVzZSAyIGNvbnRyb2xsZXJzIGhhdmUgZGlmZmVyZW50IG51bWJlciBvZiBpbmJvdW5kIGFuZCBv
dXRib3VuZA0Kd2luZG93cyBmcm9tIHRoZSBvdGhlciA0IFBDSWUgY29udHJvbGxlcnMgd2hpY2gg
YXJlIHN1cHBvcnQgdXAgdG8geDQgYW5kIG5vdCBzdXBwb3J0DQpTUklPVi4NCg0KPiBPbiBUdWUs
IE1heSAyOCwgMjAxOSBhdCAxMjoyMCBQTSBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNv
bT4NCj4gPg0KPiA+IFRoZSBMWDIxNjBBIGludGVncmF0ZWQgNiBQQ0llIEdlbjQgY29udHJvbGxl
cnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBu
eHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gVjY6DQo+ID4gIC0gTm8gY2hhbmdlLg0KPiA+DQo+ID4gIC4u
Li9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8IDE2Mw0KPiA+ICsr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYzIGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHgyMTYwYS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYwYS5kdHNpDQo+ID4gaW5kZXggMTI1YThjYzJjNWIzLi43YTJiOTFmZjFmYmMgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kN
Cj4gPiBAQCAtOTY0LDUgKzk2NCwxNjggQEANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICAgICAg
ICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBjaWVAMzQwMDAwMCB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4MCAw
eDAwMTAwMDAwDQo+IC8qIGNvbnRyb2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4ODAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8q
IGNvbmZpZ3VyYXRpb24gc3BhY2UgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWct
bmFtZXMgPSAiY3NyX2F4aV9zbGF2ZSIsDQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA4DQo+IElSUV9UWVBF
X0xFVkVMX0hJR0g+LCAvKiBBRVIgaW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDEwOA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwg
LyogUE1FIGludGVycnVwdCAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8R0lDX1NQSSAxMDgNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIg
aW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVz
ID0gImFlciIsICJwbWUiLCAiaW50ciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2Vs
bHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNp
IjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgYXBpby13aW5zID0gPDg+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHBwaW8td2lucyA9IDw4PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMt
cmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9
IDwweDgyMDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4ODANCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAw
MDAwMD47IC8qIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgbXNpLXBhcmVudCA9IDwmaXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlu
dGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHQtbWFwID0gPDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMDkgSVJR
X1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwwMDAwIDAgMCAyICZnaWMgMCAwDQo+IEdJQ19TUEkgMTEwIElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAw
MCAwIDAgMyAmZ2ljIDAgMA0KPiBHSUNfU1BJIDExMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdp
YyAwIDANCj4gR0lDX1NQSSAxMTIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAg
fTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBjaWVAMzUwMDAwMCB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNTAwMDAwIDB4MCAweDAwMTAw
MDAwDQo+IC8qIGNvbnRyb2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDB4ODggMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8qIGNvbmZp
Z3VyYXRpb24gc3BhY2UgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMg
PSAiY3NyX2F4aV9zbGF2ZSIsDQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTEzDQo+IElSUV9UWVBFX0xFVkVM
X0hJR0g+LCAvKiBBRVIgaW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDxHSUNfU1BJIDExMw0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1F
IGludGVycnVwdCAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
R0lDX1NQSSAxMTMNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIgaW50ZXJy
dXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImFl
ciIsICJwbWUiLCAiaW50ciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8
Mj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYXBpby13aW5zID0gPDg+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHBwaW8td2lucyA9IDw4PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2Ug
PSA8MHgwIDB4ZmY+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgy
MDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4ODgNCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47
IC8qIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbXNpLXBhcmVudCA9IDwmaXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjaW50
ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVw
dC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRl
cnJ1cHQtbWFwID0gPDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMTQgSVJRX1RZUEVf
TEVWRUxfSElHSD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwwMDAwIDAgMCAyICZnaWMgMCAwDQo+IEdJQ19TUEkgMTE1IElSUV9UWVBFX0xFVkVMX0hJR0g+
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAwMCAwIDAg
MyAmZ2ljIDAgMA0KPiBHSUNfU1BJIDExNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdpYyAwIDAN
Cj4gR0lDX1NQSSAxMTcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICAgIHBjaWVAMzYwMDAwMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNjAwMDAwIDB4MCAweDAwMTAwMDAwDQo+
IC8qIGNvbnRyb2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4OTAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8qIGNvbmZpZ3VyYXRp
b24gc3BhY2UgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMgPSAiY3Ny
X2F4aV9zbGF2ZSIsDQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTE4DQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+
LCAvKiBBRVIgaW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDxHSUNfU1BJIDExOA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVy
cnVwdCAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQ
SSAxMTgNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIgaW50ZXJydXB0ICov
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJw
bWUiLCAiaW50ciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYXBpby13aW5zID0gPDI1Nj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHBp
by13aW5zID0gPDI0PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2UgPSA8
MHgwIDB4ZmY+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgyMDAw
MDAwIDB4MCAweDQwMDAwMDAwIDB4OTANCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47IC8q
IG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
bXNpLXBhcmVudCA9IDwmaXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJy
dXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1t
YXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1
cHQtbWFwID0gPDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMTkgSVJRX1RZUEVfTEVW
RUxfSElHSD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDww
MDAwIDAgMCAyICZnaWMgMCAwDQo+IEdJQ19TUEkgMTIwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAwMCAwIDAgMyAm
Z2ljIDAgMA0KPiBHSUNfU1BJIDEyMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdpYyAwIDANCj4g
R0lDX1NQSSAxMjIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgIHBjaWVAMzcwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNzAwMDAwIDB4MCAweDAwMTAwMDAwDQo+IC8q
IGNvbnRyb2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4OTggMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8qIGNvbmZpZ3VyYXRpb24g
c3BhY2UgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMgPSAiY3NyX2F4
aV9zbGF2ZSIsDQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTIzDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+LCAv
KiBBRVIgaW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDxHSUNfU1BJIDEyMw0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVycnVw
dCAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAx
MjMNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIgaW50ZXJydXB0ICovDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJwbWUi
LCAiaW50ciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYXBpby13aW5zID0gPDg+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBwaW8td2lu
cyA9IDw4PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2UgPSA8MHgwIDB4
ZmY+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgyMDAwMDAwIDB4
MCAweDQwMDAwMDAwIDB4OTgNCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47IC8qIG5vbi1w
cmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbXNpLXBh
cmVudCA9IDwmaXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNl
bGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFz
ayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFw
ID0gPDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMjQgSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwMDAwIDAg
MCAyICZnaWMgMCAwDQo+IEdJQ19TUEkgMTI1IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAwMCAwIDAgMyAmZ2ljIDAg
MA0KPiBHSUNfU1BJIDEyNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdpYyAwIDANCj4gR0lDX1NQ
SSAxMjcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgIHBjaWVAMzgwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHgwMCAweDAzODAwMDAwIDB4MCAweDAwMTAwMDAwDQo+IC8qIGNvbnRy
b2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4
YTAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8qIGNvbmZpZ3VyYXRpb24gc3BhY2Ug
Ki8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMgPSAiY3NyX2F4aV9zbGF2
ZSIsDQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgMTI4DQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+LCAvKiBBRVIg
aW50ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxH
SUNfU1BJIDEyOA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVycnVwdCAqLw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAxMjgNCj4g
SVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIgaW50ZXJydXB0ICovDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJwbWUiLCAiaW50
ciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYXBp
by13aW5zID0gPDI1Nj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHBpby13aW5zID0g
PDI0PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgyMDAwMDAwIDB4MCAw
eDQwMDAwMDAwIDB4YTANCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47IC8qIG5vbi1wcmVm
ZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbXNpLXBhcmVu
dCA9IDwmaXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9
IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0g
PDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMjkgSVJRX1RZUEVfTEVWRUxfSElHSD4s
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwMDAwIDAgMCAy
ICZnaWMgMCAwDQo+IEdJQ19TUEkgMTMwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAwMCAwIDAgMyAmZ2ljIDAgMA0K
PiBHSUNfU1BJIDEzMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdpYyAwIDANCj4gR0lDX1NQSSAx
MzIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIHBjaWVAMzkwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llIjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHgwMCAweDAzOTAwMDAwIDB4MCAweDAwMTAwMDAwDQo+IC8qIGNvbnRyb2xs
ZXIgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4YTgg
MHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+IC8qIGNvbmZpZ3VyYXRpb24gc3BhY2UgKi8N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMgPSAiY3NyX2F4aV9zbGF2ZSIs
DQo+ICJjb25maWdfYXhpX3NsYXZlIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMTAzDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+LCAvKiBBRVIgaW50
ZXJydXB0ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNf
U1BJIDEwMw0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVycnVwdCAqLw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAxMDMNCj4gSVJR
X1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRyb2xsZXIgaW50ZXJydXB0ICovDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJwbWUiLCAiaW50ciI7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBkbWEtY29oZXJlbnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYXBpby13
aW5zID0gPDg+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBwaW8td2lucyA9IDw4PjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgyMDAwMDAwIDB4MCAweDQwMDAw
MDAwIDB4YTgNCj4gMHg0MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47IC8qIG5vbi1wcmVmZXRjaGFi
bGUgbWVtb3J5ICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbXNpLXBhcmVudCA9IDwm
aXRzPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9IDwwIDAg
MCA3PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAwMDAg
MCAwIDEgJmdpYyAwIDAgR0lDX1NQSQ0KPiAxMDQgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwMDAwIDAgMCAyICZnaWMg
MCAwDQo+IEdJQ19TUEkgMTA1IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MDAwMCAwIDAgMyAmZ2ljIDAgMA0KPiBHSUNf
U1BJIDEwNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPDAwMDAgMCAwIDQgJmdpYyAwIDANCj4gR0lDX1NQSSAxMDcgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gICAgICAgICB9
Ow0KPiA+ICB9Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBUaGFu
a3MsDQo+IFJlZ2FyZHMsDQo+IEthcnRoaWtleWFuIE1pdHJhbg0KPiANCj4gLS0NCj4gTW9iaXZl
aWwgSU5DLiwgQ09ORklERU5USUFMSVRZIE5PVElDRTogVGhpcyBlLW1haWwgbWVzc2FnZSwgaW5j
bHVkaW5nIGFueQ0KPiBhdHRhY2htZW50cywgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpIGFuZCBtYXkgY29udGFpbg0KPiBwcm9wcmlldGFyeSBjb25maWRl
bnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBvciBvdGhlcndpc2UgYmUgcHJvdGVjdGVk
DQo+IGJ5IGxhdy4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSBvciBk
aXN0cmlidXRpb24gaXMgcHJvaGliaXRlZC4gSWYNCj4geW91IGFyZSBub3QgdGhlIGludGVuZGVk
IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZXN0cm95IGFsbA0KPiBj
b3BpZXMgYW5kIHRoZSBvcmlnaW5hbCBtZXNzYWdlLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
