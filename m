Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12FF10F49D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 02:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLCBmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 20:42:40 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:23531
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfLCBmk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 20:42:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhhRFuiEIYVo6A5rbb+wyhEWTQQEet3Ru5X+wTmXDSGNvq12Uh8sO25+ji/qACrhdhBmrXdu5pVetsiaH7tY55VsKkzVpu0nZP9LLsCdylx7KsQc2rzqARuD1NNoWoZ7H1tE81RCIfqp9SFL3kJyhqOXQKbGbcPUBdCDjS3NfejWkhdELVInbyqLk9hQF43+OXjf0Bw3r6ka5nBVBIamyTyqdXuA2KclSdpy5X3BQTi3zjyWhZZLr68/tzw22hsUmDu4/IG0ijwQINVtNcKLnoJmq4YS7I/rZ8UGB/gPH6ICCbJaSKzn2J76hSAv0C3TTGGQLVYlvo8+EjrVq5ACJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCMHkhp8XsbTT/kLVQDwo0zBRTsJV4Kn7ehe8M0q2+c=;
 b=avtWf9ba8GknkdReRTC6s85KjZD/tPTA/GkGsr66LVn/fhwHCLgm4j+6c7G/lbL2S5FFP/Ix7GOo+XuG08SDOEzHuhzBWbD0icybRuqgdyEODdlRNU8YSc4sfrRkCU7JrLkL0G7dvI/cXiQqJg4g5lsz7KEU/H9/a4Iwg22oZ/SQqdAEoPSqoAqA5mSSH2o8tqkJ2ykh/BSrfXDokTYRkzWG9LfnqB3w+8dSuH8B9yj+pbSk6BIdSRpd9j0tYgF+bAD6Inz65IBehov1UCvTw0FWUek1CSrmjwS6n23uqe0jNV6j6p6QR7Q+JOS2pr361AMneFmR0Tyjq7CdKnKlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCMHkhp8XsbTT/kLVQDwo0zBRTsJV4Kn7ehe8M0q2+c=;
 b=hcpRU0VjWqNBjDCH1NI3U40qpUZ1DNEPa9V/BJuGd/joRjvwJXIHvsYvCAy8tI0foukONef3UtN9BNjJWxjpftteYHvZVZuqOdR/8lFm+V/C8U/9g0Yjf5uxvXrknQEMrWHA8u9cokuV0e9R06VZTmu8n+z9KK1tQqGeOaMo4iU=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB2977.eurprd04.prod.outlook.com (10.173.254.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 01:42:35 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 01:42:35 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Marc Zyngier <maz@misterjones.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Topic: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Index: AQHVqP2nw3AoM5GAtUqPe+h1Ib8VVaemy2EAgADUbVA=
Date:   Tue, 3 Dec 2019 01:42:35 +0000
Message-ID: <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
In-Reply-To: <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb03bd63-e3b8-480f-3d75-08d7779212b5
x-ms-traffictypediagnostic: AM5PR04MB2977:|AM5PR04MB2977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB297768975BED668EFA9B3D3DF5420@AM5PR04MB2977.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(13464003)(66446008)(26005)(102836004)(6246003)(44832011)(14454004)(256004)(7696005)(81156014)(8676002)(2906002)(81166006)(7416002)(74316002)(7736002)(305945005)(99286004)(478600001)(316002)(71200400001)(54906003)(33656002)(8936002)(71190400001)(6116002)(3846002)(186003)(6916009)(52536014)(11346002)(6506007)(53546011)(446003)(66556008)(66476007)(64756008)(229853002)(25786009)(4326008)(66066001)(55016002)(6436002)(9686003)(86362001)(5660300002)(76176011)(14444005)(76116006)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB2977;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cw7SHZkP1hZgAVJi7ez0lW3QGsHAgYuom9HsAF8U6gIpYDGL+7anUi6I3aYLtW9TxTnVFvt9rHpP4Q7BLONFwE4HsJo30Cv8tJEj+urz7pYb1NnVup1vRAX3zGCh130tO8+z749OPtRGzffxJOxjCMzAdSLpH8n0crAnoZ21fMlle5tZTpYZsKWtWik2qEfbbaYrAZFatks6XmzZrDElbk4VoiFoxqnr55zl0U3v6wHZ556P+ZxMI0xKtC/tECjidkEZ9cd8mndDETdlNgbk+veK/XEsN8wn9OldyynR4PbDc2ryTGkM2s9NbbmpszfpIa7LyGjPiIs2JAKWho4baIG5Cpc0614txf6HviaPl10oxD3Wc+m0Sm/Mtna98x9ltQeBAbb8K9GddXKV/D2MlFCGhPN2dFSiz38A7dsU7Bzo3eKZyekJtWYvhyNIVGy+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb03bd63-e3b8-480f-3d75-08d7779212b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 01:42:35.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7HJdwSpUJD/DVgMYb+Lo7XOmNgWFES+G+l/d7lG2wxtUFrOfsX9WUUzambAXsMiz4ky5bFn3Pojt6uQsUGIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2977
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXpAbWlzdGVyam9uZXMub3JnPg0KPiBTZW50OiAyMDE55bm0MTLmnIgy5pelIDIwOjQ4DQo+IFRv
OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVs
Lm9yZzsgZnJvd2FuZC5saXN0QGdtYWlsLmNvbTsgTS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFu
QG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZw0KPiA8
cm95LnphbmdAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGFuZHJldy5tdXJy
YXlAYXJtLmNvbTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgWi5xLiBI
b3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGxh
eWVyc2NhcGU6IEFkZCB0aGUgU1JJT1Ygc3VwcG9ydCBpbiBob3N0IHNpZGUNCj4gDQo+IE9uIDIw
MTktMTItMDIgMTA6NDUsIFhpYW93ZWkgQmFvIHdyb3RlOg0KPiA+IEdJQyBnZXQgdGhlIG1hcCBy
ZWxhdGlvbnMgb2YgZGV2aWQgYW5kIHN0cmVhbSBpZCBmcm9tIHRoZSBtc2ktbWFwDQo+ID4gcHJv
cGVydHkgb2YgRFRTLCBvdXIgcGxhdGZvcm0gYWRkIHRoaXMgcHJvcGVydHkgaW4gdS1ib290IGJh
c2Ugb24gdGhlDQo+ID4gUENJZSBkZXZpY2UgaW4gdGhlIGJ1cywgYnV0IGlmIGVuYWJsZSB0aGUg
dmYgZGV2aWNlIGluIGtlcm5lbCwgdGhlIHZmDQo+ID4gZGV2aWNlIG1zaS1tYXAgd2lsbCBub3Qg
c2V0LCBzbyB0aGUgdmYgZGV2aWNlIGNhbid0IHdvcmssIHRoaXMgcGF0Y2gNCj4gPiBwdXJwb3Nl
IGlzIHRoYXQgbWFuYWdlIHRoZSBzdHJlYW0gaWQgYW5kIGRldmljZSBpZCBtYXAgcmVsYXRpb25z
DQo+ID4gZHluYW1pY2FsbHkgaW4ga2VybmVsLCBhbmQgbWFrZSB0aGUgbmV3IFBDSWUgZGV2aWNl
IHdvcmsgaW4ga2VybmVsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhp
YW93ZWkuYmFvQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvb2YvaXJxLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgOSArKysNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWxheWVyc2NhcGUuYyB8IDk0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9wY2kvcHJvYmUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA2ICsrDQo+ID4gIGRyaXZlcnMvcGNpL3JlbW92ZS5jICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNiArKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9pcnEuYyBiL2RyaXZlcnMvb2YvaXJxLmMgaW5kZXgN
Cj4gPiBhMjk2ZWFmLi43OTFlNjA5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvb2YvaXJxLmMN
Cj4gPiArKysgYi9kcml2ZXJzL29mL2lycS5jDQo+ID4gQEAgLTU3Niw2ICs1NzYsMTEgQEAgdm9p
ZCBfX2luaXQgb2ZfaXJxX2luaXQoY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+ICptYXRj
aGVzKQ0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4NCj4gPiArdTMyIF9fd2VhayBsc19wY2llX3N0cmVh
bWlkX2ZpeChzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiByaWQpIHsNCj4gPiArCXJldHVybiByaWQ7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB1MzIgX19vZl9tc2lfbWFwX3JpZChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiA+ICoqbnAsDQo+ID4gIAkJCSAgICB1
MzIgcmlkX2luKQ0KPiA+ICB7DQo+ID4gQEAgLTU5MCw2ICs1OTUsMTAgQEAgc3RhdGljIHUzMiBf
X29mX21zaV9tYXBfcmlkKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKipucCwNCj4gPiAgCQlpZiAoIW9mX21hcF9yaWQocGFyZW50X2Rldi0+b2Zfbm9kZSwgcmlk
X2luLCAibXNpLW1hcCIsDQo+ID4gIAkJCQkibXNpLW1hcC1tYXNrIiwgbnAsICZyaWRfb3V0KSkN
Cj4gPiAgCQkJYnJlYWs7DQo+ID4gKw0KPiA+ICsJaWYgKHJpZF9vdXQgPT0gcmlkX2luKQ0KPiA+
ICsJCXJpZF9vdXQgPSBsc19wY2llX3N0cmVhbWlkX2ZpeChwYXJlbnRfZGV2LCByaWRfaW4pOw0K
PiANCj4gT3ZlciBteSBkZWFkIGJvZHkuIEdldCB5b3VyIGZpcm13YXJlIHRvIHByb3Blcmx5IHBy
b2dyYW0gdGhlIExVVCBzbyB0aGF0IGl0DQo+IHByZXNlbnRzIHRoZSBJVFMgd2l0aCBhIHJlYXNv
bmFibGUgdG9wb2xvZ3kuIFRoZXJlIGlzIGFic29sdXRlbHkgbm8gd2F5IHRoaXMNCj4ga2luZCBv
ZiBjaGFuZ2UgbWFrZXMgaXQgaW50byB0aGUga2VybmVsLg0KDQpTb3JyeSBmb3IgdGhpcywgSSBr
bm93IGl0IGlzIG5vdCByZWFzb25hYmxlLCBidXQgSSBoYXZlIG5vIG90aGVyIHdheSwgYXMgSSBr
bm93LCBBUk0NCmdldCB0aGUgbWFwcGluZyBvZiBzdHJlYW0gSUQgdG8gcmVxdWVzdCBJRCBmcm9t
IHRoZSBtc2ktbWFwIHByb3BlcnR5IG9mIERUUywgaWYNCmFkZCBhIG5ldyBkZXZpY2Ugd2hpY2gg
bmVlZCB0aGUgc3RyZWFtIElEIGFuZCB0cnkgdG8gZ2V0IGl0IGZyb20gdGhlIG1zaS1tYXAgb2Yg
RFRTLA0KaXQgd2lsbCBmYWlsZWQgYW5kIG5vdCB3b3JrLCB5ZXM/IFNvIGNvdWxkIHlvdSBnaXZl
IG1lIGEgYmV0dGVyIGFkdmljZSB0byBmaXggdGhpcyBpc3N1ZSwNCkkgd291bGQgcmVhbGx5IGFw
cHJlY2lhdGUgYW55IGNvbW1lbnRzIG9yIHN1Z2dlc3Rpb25zLCB0aGFua3MgYSBsb3QuDQoNClRo
YW5rcyANClhpYW93ZWkNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gICAgICAgICAgTS4NCj4gLS0N
Cj4gV2hvIHlvdSBqaXZpbicgd2l0aCB0aGF0IENvc21payBEZWJyaXM/DQo=
