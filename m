Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A200113F9A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfLEKoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 05:44:37 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:7429
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729017AbfLEKoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 05:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwSSS12cEZacHWAZSOTj0Ks0AGOhGmXTTwj5t7FadaphlZ+k3DFRAdZ8tMGZacnWk12DODz7yDO/yG/b1FiOa4qSq28ypDSM4SBm68WdWKWgHtGdtOLaz7VQYuSegxa/xOMU3bvhjVQ1a1inFW7xYNQg10Ob4t6N3SJY7H+Vc7JL7iuGmz5ir0xv0MuC7p2krLK+kf1EyRDmDXGXqQoXwmnv91e2/1rhDPvLeovIt01JmETTgnzlmZFVkyHMBLhAMLH/sGVVTu06LYhVjQJ8+o3klJozl+iU3dW7cRnjrItDQ4HQaz5R7RDLjmB0ggH913sA4ySlswePNK13Gg8MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSXglY/VDo/VIpNCszOGm4UmqGOypqdpPy9E9ryilrU=;
 b=QACEw+gIBsb4Sz9mQwIR1Ij5Mx9yOsG4cejDa7cYH4yeYrqZ53Nl6irOHWa9vM6prl7QI+zUWAk/qW6QfrQBCzJH2NmTrsaNpIABbA/M78SykMIqP4xyf0BQAH04iR4fz6lr6D/oIlP/BISFSFXh7dN8saPfyw20OiC57vNRhdEgq/NXHu5Y0lvnbV8cdG75pSFo9UV44GiciaUAwj+MgmXH4fIh6Azy7mbdg8tL4t5rGrjv7UFjwWfkj49C8qxU70VEByVXyEEiVi0yq8Q8DqZR3D5TFl7UXi0oHI4luelzshENil1U7iii5FflVgR4lKFVi9il4Qs+ZXjJss1RXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSXglY/VDo/VIpNCszOGm4UmqGOypqdpPy9E9ryilrU=;
 b=KVC0ndqXS8rHpBosaiqldokh/2J+Rmk6HTg8o3pGoumzBqByO8uH5ykkdXJQ9fK1WNQVjA4S4PmeLKlPuRt4IPi9wZYkm1HmIwizdMlHKbjaqT3zNLkpjk3ZMCBGZ4HFeWTSXg0eVRMmmmyb8csSybWyKH+YpFbyVQw8YTQp0P0=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
 VI1PR04MB7037.eurprd04.prod.outlook.com (10.186.157.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 10:44:30 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b%7]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 10:44:30 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>,
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
Thread-Index: AQHVqP2u5HKRks3QXEmyFTQz0j+ob6emy2EAgADYg4CAA7rQsA==
Date:   Thu, 5 Dec 2019 10:44:30 +0000
Message-ID: <VI1PR04MB5134FEB9AF2952E84E4C1179EC5C0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30db89d1-77b2-44e2-f1e1-08d779701ba3
x-ms-traffictypediagnostic: VI1PR04MB7037:|VI1PR04MB7037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB703762F6694EB6009E790526EC5C0@VI1PR04MB7037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(13464003)(43544003)(199004)(189003)(99286004)(74316002)(14444005)(305945005)(5660300002)(7696005)(76176011)(66946007)(66476007)(2906002)(81156014)(66446008)(8676002)(66556008)(81166006)(52536014)(71190400001)(8936002)(9686003)(76116006)(71200400001)(25786009)(966005)(4326008)(561944003)(64756008)(6506007)(33656002)(478600001)(86362001)(11346002)(186003)(53546011)(102836004)(26005)(316002)(44832011)(55016002)(110136005)(14454004)(229853002)(7416002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7037;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTuupey0oZ6rGpECx5ZTIUtSF3KDgQJ0+hi3QE2oVPq5TgoKUowDkkQQfzMiSkOmUumqw6aVz+0x//p/ZUWv/trjzqsOxRbboVVg+vKHi07U/tsyTZSz5yub0IG7ikWXCWvXxL0RLm1gZsrVNOe2/KwLbZ9bh+i5pw/bvJohq8P7q6yvdcpQavsYRWXj6TmsLgJiIjMPy9ScYRaFhg62le0yuExLM+Pz4HtWjeWyZVpBvKaJTR9d1mAis11ypqkWu0z3gqvb9OB9+IqAnTDxOKP5kTFp1Yz92laqHS+4zvkYfI6Roa1ZnPOgEZK30CaESCkebsJeS/4KUxCU00afHxG6/yPlT/I5/Rkv5JgEC1T1GIWpb0V+uBkl0e0nND0OSazkMd9yHf6MzlZuWij8blt0/G8l2GQR5ll5J02No9GnLNZWL9+wRD4ipVSwnTJ2zqDKqrvzS2ciNivbPn4sSkUxEJZocbj3pllQB8WBKTF0JN0ad1Au7EDqqL4s4j/etBWOghOyFv8LtSZ5kQpGQj6jFaEwuZBD133e39/o56dJapBUfq65NQWmwMdoE6pp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db89d1-77b2-44e2-f1e1-08d779701ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 10:44:30.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45KSgEd2uEJzrYPyveJ5KKtdBYH0rmytbXhZHJL0GI+kEVJ2iPaY2zeJqgPN2fV8+PKfF3wd2d8XcrUTuu0klQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgWGlhb3dlaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9y
Zz4gT24NCj4gQmVoYWxmIE9mIFhpYW93ZWkgQmFvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gRnJvbTogTWFyYyBaeW5naWVyIDxtYXpAbWlzdGVyam9uZXMub3JnPg0K
PiA+IFNlbnQ6IDIwMTnlubQxMuaciDLml6UgMjA6NDgNCj4gPiBUbzogWGlhb3dlaSBCYW8gPHhp
YW93ZWkuYmFvQG54cC5jb20+DQo+ID4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgZnJvd2FuZC5s
aXN0QGdtYWlsLmNvbTsgTS5oLiBMaWFuDQo+ID4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1p
bmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IFJveSBaYW5nDQo+ID4gPHJveS56YW5nQG54
cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhbmRyZXcubXVycmF5QGFybS5jb207
DQo+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IFoucS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGxheWVy
c2NhcGU6IEFkZCB0aGUgU1JJT1Ygc3VwcG9ydCBpbiBob3N0IHNpZGUNCj4gPg0KPiA+IE9uIDIw
MTktMTItMDIgMTA6NDUsIFhpYW93ZWkgQmFvIHdyb3RlOg0KPiA+ID4gR0lDIGdldCB0aGUgbWFw
IHJlbGF0aW9ucyBvZiBkZXZpZCBhbmQgc3RyZWFtIGlkIGZyb20gdGhlIG1zaS1tYXANCj4gPiA+
IHByb3BlcnR5IG9mIERUUywgb3VyIHBsYXRmb3JtIGFkZCB0aGlzIHByb3BlcnR5IGluIHUtYm9v
dCBiYXNlIG9uIHRoZQ0KPiA+ID4gUENJZSBkZXZpY2UgaW4gdGhlIGJ1cywgYnV0IGlmIGVuYWJs
ZSB0aGUgdmYgZGV2aWNlIGluIGtlcm5lbCwgdGhlIHZmDQo+ID4gPiBkZXZpY2UgbXNpLW1hcCB3
aWxsIG5vdCBzZXQsIHNvIHRoZSB2ZiBkZXZpY2UgY2FuJ3Qgd29yaywgdGhpcyBwYXRjaA0KPiA+
ID4gcHVycG9zZSBpcyB0aGF0IG1hbmFnZSB0aGUgc3RyZWFtIGlkIGFuZCBkZXZpY2UgaWQgbWFw
IHJlbGF0aW9ucw0KPiA+ID4gZHluYW1pY2FsbHkgaW4ga2VybmVsLCBhbmQgbWFrZSB0aGUgbmV3
IFBDSWUgZGV2aWNlIHdvcmsgaW4ga2VybmVsLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9vZi9pcnEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKw0KPiA+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMgfCA5NA0KPiA+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysNCj4gPiA+ICBkcml2ZXJzL3BjaS9yZW1v
dmUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysNCj4gPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDExNSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
b2YvaXJxLmMgYi9kcml2ZXJzL29mL2lycS5jIGluZGV4DQo+ID4gPiBhMjk2ZWFmLi43OTFlNjA5
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9vZi9pcnEuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9vZi9pcnEuYw0KPiA+ID4gQEAgLTU3Niw2ICs1NzYsMTEgQEAgdm9pZCBfX2luaXQgb2ZfaXJx
X2luaXQoY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+ID4gKm1hdGNoZXMpDQo+ID4gPiAg
CX0NCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3UzMiBfX3dlYWsgbHNfcGNpZV9zdHJlYW1pZF9m
aXgoc3RydWN0IGRldmljZSAqZGV2LCB1MzIgcmlkKSB7DQo+ID4gPiArCXJldHVybiByaWQ7DQo+
ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyB1MzIgX19vZl9tc2lfbWFwX3JpZChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiA+ID4gKipucCwNCj4gPiA+ICAJ
CQkgICAgdTMyIHJpZF9pbikNCj4gPiA+ICB7DQo+ID4gPiBAQCAtNTkwLDYgKzU5NSwxMCBAQCBz
dGF0aWMgdTMyIF9fb2ZfbXNpX21hcF9yaWQoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gc3Ry
dWN0IGRldmljZV9ub2RlICoqbnAsDQo+ID4gPiAgCQlpZiAoIW9mX21hcF9yaWQocGFyZW50X2Rl
di0+b2Zfbm9kZSwgcmlkX2luLCAibXNpLW1hcCIsDQo+ID4gPiAgCQkJCSJtc2ktbWFwLW1hc2si
LCBucCwgJnJpZF9vdXQpKQ0KPiA+ID4gIAkJCWJyZWFrOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAo
cmlkX291dCA9PSByaWRfaW4pDQo+ID4gPiArCQlyaWRfb3V0ID0gbHNfcGNpZV9zdHJlYW1pZF9m
aXgocGFyZW50X2RldiwgcmlkX2luKTsNCj4gPg0KPiA+IE92ZXIgbXkgZGVhZCBib2R5LiBHZXQg
eW91ciBmaXJtd2FyZSB0byBwcm9wZXJseSBwcm9ncmFtIHRoZSBMVVQgc28gdGhhdA0KPiBpdA0K
PiA+IHByZXNlbnRzIHRoZSBJVFMgd2l0aCBhIHJlYXNvbmFibGUgdG9wb2xvZ3kuIFRoZXJlIGlz
IGFic29sdXRlbHkgbm8gd2F5DQo+IHRoaXMNCj4gPiBraW5kIG9mIGNoYW5nZSBtYWtlcyBpdCBp
bnRvIHRoZSBrZXJuZWwuDQo+IA0KPiBTb3JyeSBmb3IgdGhpcywgSSBrbm93IGl0IGlzIG5vdCBy
ZWFzb25hYmxlLCBidXQgSSBoYXZlIG5vIG90aGVyIHdheSwgYXMgSQ0KPiBrbm93LCBBUk0NCj4g
Z2V0IHRoZSBtYXBwaW5nIG9mIHN0cmVhbSBJRCB0byByZXF1ZXN0IElEIGZyb20gdGhlIG1zaS1t
YXAgcHJvcGVydHkgb2YNCj4gRFRTLCBpZg0KPiBhZGQgYSBuZXcgZGV2aWNlIHdoaWNoIG5lZWQg
dGhlIHN0cmVhbSBJRCBhbmQgdHJ5IHRvIGdldCBpdCBmcm9tIHRoZSBtc2ktDQo+IG1hcCBvZiBE
VFMsDQo+IGl0IHdpbGwgZmFpbGVkIGFuZCBub3Qgd29yaywgeWVzPyBTbyBjb3VsZCB5b3UgZ2l2
ZSBtZSBhIGJldHRlciBhZHZpY2UgdG8NCj4gZml4IHRoaXMgaXNzdWUsDQo+IEkgd291bGQgcmVh
bGx5IGFwcHJlY2lhdGUgYW55IGNvbW1lbnRzIG9yIHN1Z2dlc3Rpb25zLCB0aGFua3MgYSBsb3Qu
DQo+IA0KDQpJIGFncmVlIHdpdGggdGhlIGNvbW11bml0eSB0aGF0IHRoaXMgc2hvdWxkIGJlIHRh
Y2tsZWQgaW4gZmlybXdhcmUuIEkgYWN0dWFsbHkgc3VibWl0dGVkIChieSBtaXN0YWtlLCBidXQg
bGV0J3MgZGlzcmVnYXJkIHRoYXQgOi0pKSBhIHNpbXBsZSBwcm9wb3NhbCBpbiB1LWJvb3QgWzFd
IHRoYXQgc2hvdWxkIHRha2UgY2FyZSBvZiBpdC4gV2UgY2FuIGRpc2N1c3MgZnVydGhlciBvbiBp
dCwgaWYgeW91IHdpc2guDQoNClsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNo
LzEwMzM0NjYvDQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUNCg==
