Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277B5173A1D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgB1OnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 09:43:17 -0500
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:8612
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbgB1OnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 09:43:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKkyk3RXC2oHNVI/SluA1iCjafT+Co5le65TSwzW9YTX6ML+nUpkjG+G5O+Dchsu8SLUUIywJbpHl/mSXjehl/koHI+jZduTJjdZ/oSKOaULA5tN8oxvw+EvMJ4jK1ttMzf//OSIzReHnGNVYwpl3sNANvwJCcYUcN2U8ksf4G1PxG5VvMD07IJz+jsjUL+vjTzeK4RGKGkkn0qlGJDJxldDtYEzIXoHmevoLDaz3+Wq2Jl0UiL8cMrjF9iqRRN2rYcdKR5RDre2G53mHIKA0ffaeK8lYbRz+nLRo5kgcUELEarjscfLPdNFTlupa/xgGQjbxuaAH4RhvF6Xqbd5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+9elaxFY5PfUCxGjMVKC1sDGQxQnBMDNc+ZPS4PJUc=;
 b=mDrhKarQU9o4NaYpZiDKP/Qg7k2xKGoZeTy2Gz5+Xt8AcUxF7gI2rhD4iCbxICacgUB9cMvOfxtflKHbG2iTu9EeCkP4VpVww9rECfJ/7H7/NFhJ71CxwymCYJtRruwJlQPygWJyJMJvzK/u17SAgXhT7W2p9pqOo+RjyI+CrklSctiy37K8ft1vPJN3xfdMI3phCOqiNUOeF8IpcvPUSL0gcsx9J0DC3QSH3n0DIF5J+L/yxaTXoPbYBKaHtIz+hOqQpX9l4bW2Q17ToFbblUJSOMzOpkZCO+Ui+h8smFxQD3vlE/gHVrrzQqYBbfqXKxMn7SR6eF85C7vGX/8EXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+9elaxFY5PfUCxGjMVKC1sDGQxQnBMDNc+ZPS4PJUc=;
 b=kvugOp3nNa9oLH/pTlLKvlmgvfNqBfZMrsVUwdlUrN/NhKLRzUDKQBrV51ib8rs1x0MmYSN31OMFhLG67zrrpGkKdJsrqSYxkBErgLryzJ7E4l/L4h3KN4RGEFlI5FDhexbLlTtTLWmfKayJ4C1lUrEEcEpHxwSyU8V8QTCovvQ=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3057.eurprd04.prod.outlook.com (10.175.229.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Fri, 28 Feb 2020 14:43:13 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::308c:e154:899b:507e]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::308c:e154:899b:507e%5]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 14:43:13 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v4 08/11] PCI: layerscape: Modify the MSIX to the doorbell
 mode
Thread-Topic: [PATCH v4 08/11] PCI: layerscape: Modify the MSIX to the
 doorbell mode
Thread-Index: AQHVcn/v76ltSUnI6keAnyjCe5OUV6gxcsQAgAAxMyA=
Date:   Fri, 28 Feb 2020 14:43:12 +0000
Message-ID: <AM5PR04MB329992BADD5D2CFA613A6D19F5E80@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190924021849.3185-1-xiaowei.bao@nxp.com>
 <20190924021849.3185-9-xiaowei.bao@nxp.com>
 <55752e77-1094-4cbf-2822-e10b875b4dd9@ti.com>
In-Reply-To: <55752e77-1094-4cbf-2822-e10b875b4dd9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95bd2900-650b-451c-e350-08d7bc5c89e9
x-ms-traffictypediagnostic: AM5PR04MB3057:|AM5PR04MB3057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3057DBC9735C9D51891F1B21F5E80@AM5PR04MB3057.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(186003)(52536014)(33656002)(5660300002)(26005)(316002)(6506007)(8936002)(53546011)(81156014)(81166006)(8676002)(7696005)(7416002)(2906002)(66556008)(55016002)(110136005)(45080400002)(478600001)(966005)(86362001)(71200400001)(44832011)(9686003)(66446008)(64756008)(66946007)(76116006)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3057;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YragBf6unc6znv6fxOLWr2QNjfBy1Ii2VL00ezabfavlJ/7oHoXKTEo5UMiPjxtE9kzh2wKk+VsCTh9kVWZID4b8/QVFmEMXgODxVo9+d1UhE/Je0Q6xv7v/kCftBHZZJtQpNLpUbheJEccW7RneKx643XPJFd5a9xfpy96QboGCRb4pfeGPpCQdaUsQe4xFjlT8H28i/9Lx1gyajdW3cfljYh6QdOMfOHriQa5FdQhE6LsntG8aGdh6UTDKKFvWyoKNRAX+nZTFn96k3QQ/8qW3c8H4yHdXL8jcd/DGsM/KjaCI3XrvoZKrH52hZY9LvJgJZ6M99X0hJpbBKMdYp87Wc/olVh8i70EiI+GWgLbX4f+eHwKAkrBRwPpXENxGhvefyGNdYR1/1Z/llCDeiuQz5ZJ30p8MwhdnyGLxqFMKGbMizfLls9wcdqsjpelq/COqIUvCjKQBUbXewUUDBmWYxTt+4z8CMAuF0KA8g3u1sXxiwtCnmcDMxY19PQHRpRzFUv0r6xLEQVKBVFbOqel4XtnLgXnL988xjsM6IUa5O+NXtzfnq0J6z9PWkxfCscy2TjEY+S3ckzjCZejqug==
x-ms-exchange-antispam-messagedata: SFBcfQ2PhkW9DfWLZ+V33RTrdO73ISzIHMgh6Pbues3gW5ozqWaAjqoTvtSZ3IsBDKp7ggFBzjdcUZXOTFVzyIr3J1Z/uidKtWiGVEPsCA7gTDlf+6pf6gGiROgFck9oowpcJb9H9lOvSNkp4fQElw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd2900-650b-451c-e350-08d7bc5c89e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 14:43:13.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkPwD2XsIfGEWrvIxG2TcRothGJAoKL8E/7IsIuXVBExui8WG4FcQzBd8h5ds2OwDCSE+ZKuDWLSPURXMPu7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3057
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lzaG9uIFZpamF5IEFi
cmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gU2VudDogMjAyMOW5tDLmnIgyOOaXpSAxOTo0MQ0K
PiBUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5v
cmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkN
Cj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IE0uaC4g
TGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2thaS5odUBu
eHAuY29tPjsgUm95IFphbmcNCj4gPHJveS56YW5nQG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWls
LmNvbTsNCj4gZ3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb207IGFuZHJldy5tdXJyYXlAYXJt
LmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAwOC8xMV0gUENJOiBsYXllcnNjYXBlOiBNb2RpZnkgdGhl
IE1TSVggdG8gdGhlDQo+IGRvb3JiZWxsIG1vZGUNCj4gDQo+IEhpIFhpYW93ZWksDQo+IA0KPiBP
biAyNC8wOS8xOSA3OjQ4IGFtLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gPiBkd19wY2llX2VwX3Jh
aXNlX21zaXhfaXJxIHdhcyBuZXZlciBjYWxsZWQgaW4gdGhlIGV4aXNpdG5nIGRyaXZlcg0KPiA+
IGJlZm9yZSwgYmVjYXVzZSB0aGUgbHMxMDQ2YSBwbGF0Zm9ybSBkb24ndCBzdXBwb3J0IHRoZSBN
U0lYIGZlYXR1cmUNCj4gPiBhbmQgbXNpeF9jYXBhYmxlIHdhcyBhbHdheXMgc2V0IHRvIGZhbHNl
Lg0KPiA+IE5vdyB0aGF0IGFkZCB0aGUgbHMxMDg4YSBwbGF0Zm9ybSB3aXRoIE1TSVggc3VwcG9y
dCwgYnV0IHRoZSBleGlzdGluZw0KPiA+IGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEgZG9lc24n
dCB3b3JrLCBzbyB1c2UgdGhlIGRvb3JiZWxsIG1ldGhvZCB0bw0KPiA+IHN1cHBvcnQgdGhlIE1T
SVggZmVhdHVyZS4NCj4gDQo+IA0KPiBJdCBkb2VzIHdvcmsgYWZ0ZXIgWzFdLiBTbyB0aGUgY29t
bWl0IG1lc3NhZ2UgbWlnaHQgbm90IGJlIGV4YWN0bHkgdHJ1ZS4NCg0KR290IGl0LCBJIHdpbGwg
dmVyaWZ5IGl0IHdpdGggeW91ciBwYXRjaCwgZG8geW91IG1lYW4gdGhhdCBJIHNob3VsZCBjb3Jy
ZWN0IHRoZSBjb21taXQgDQptZXNzYWdlPyBJIHRoaW5rIHdlIGNhbiByZXNlcnZlIG15IE1TSS1Y
IHBhdGNoLCB0aGlzIHBhdGNoIGNhbiBwcm92aWRlIGFub3RoZXIgDQpNU0ktWCB0cmlnZ2VyIHdh
eSwgYW5kIHRoaXMgd2F5IGlzIGNsZWFybHkgc3RhdGVkIGluIHRoZSBEV0MgbWFudWFsLCB0aGFu
a3MsIHBsZWFzZQ0KZ2l2ZSB5b3VyIGNvbW1lbnRzLg0KDQpUaGFua3MNClhpYW93ZWkNCg0KPiAN
Cj4gWzFdIC0+DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2UNCj4gcm5lbC5vcmclMkZyJTJGMjAyMDAyMjUw
ODE3MDMuODg1Ny0xLWtpc2hvbiU0MHRpLmNvbSZhbXA7ZGF0YT0wMiUNCj4gN0MwMSU3Q3hpYW93
ZWkuYmFvJTQwbnhwLmNvbSU3Qzg0MTkxZGYwY2QwOTQ1MWVmM2U2MDhkN2JjNDI3NzQ1DQo+ICU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxODQ4NjU5Njk2
ODQNCj4gMTY5JmFtcDtzZGF0YT1LOWZ2YnBRNHh1dVpLaFdUNlVWMk00U1Z5SHhRM0xqcHVKUXp0
a3RMYVJJJTNEJg0KPiBhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gVGhhbmtzDQo+IEtpc2hvbg0KPiAN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBBbmRyZXcgTXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+
DQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gIC0gTm8gY2hhbmdlDQo+ID4gdjM6DQo+ID4gIC0gTW9k
aWZ5IHRoZSBjb21taXQgbWVzc2FnZSBtYWtlIGl0IGNsZWFybHkuDQo+ID4gdjQ6DQo+ID4gIC0g
Tm8gY2hhbmdlDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVy
c2NhcGUtZXAuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+ID4gaW5kZXggMWUwNzI4Ny4uNWYwY2I5OSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1l
cC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUt
ZXAuYw0KPiA+IEBAIC03OSw3ICs3OSw4IEBAIHN0YXRpYyBpbnQgbHNfcGNpZV9lcF9yYWlzZV9p
cnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLA0KPiB1OCBmdW5jX25vLA0KPiA+ICAJY2FzZSBQQ0lf
RVBDX0lSUV9NU0k6DQo+ID4gIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwg
ZnVuY19ubywgaW50ZXJydXB0X251bSk7DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+
ID4gLQkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEoZXAsIGZ1bmNfbm8sIGludGVy
cnVwdF9udW0pOw0KPiA+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaXhfaXJxX2Rvb3Ji
ZWxsKGVwLCBmdW5jX25vLA0KPiA+ICsJCQkJCQkJICBpbnRlcnJ1cHRfbnVtKTsNCj4gPiAgCWRl
ZmF1bHQ6DQo+ID4gIAkJZGV2X2VycihwY2ktPmRldiwgIlVOS05PV04gSVJRIHR5cGVcbiIpOw0K
PiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo=
