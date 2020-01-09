Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31D91356C0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgAIKVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 05:21:04 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:57061
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbgAIKVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 05:21:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg5dzScZKWibnHOhqOGYV7YJtZhr8+Dt+OJ4svVTOrb5vDWys/CV3flOrYbmaFcrlR7LasEqSnMWEWs8IwBVMXwPr9h4GRKqSaIjfv2i8BmT9b7OX8I2x4Fy8SqhHc7FvplpV5Va1C5yVHmdzR9yN0+W0t1v4ygVwNh8wTqfR7/WpNrIIb+MC3ZyxjdGS0YH2c6VxXwYGuZJqLC/RxWDtrhy9xiG2cpCY7DF943v/UDSYZcnq6pub+0BHMMDEA4/ZuRgTx7WMgAf2vTxcA5CTE/7rw58MKtxKXWWrQaE0bCG1ZZ46qzoQbT4a2aji+gfRlgSt+dbZ/OSh7loqCA0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGu4W0JuTBnuuOL8lsHGcnJlcC48V9XBNjHmmtj/3o=;
 b=Ae6DdTzxORde3k6BVDxTe+FAP89Ivj21JmBcfMj5IQ4lfkrEyKB62Pv+8nHcI+A74uEBWT9Naef/SVvT+/Lrbcuzdtm8f9c+SsCJdaDv5LpiHYDCN7E5lMuz0cT/Zx16ML08MeoyAunNhlhoxWGxLbJtmouskkGnPQCLbWwas1ErzR5Of+vQ6iWAYkZeTcrRL1aoVMGpE9b9jfvDKQ59BeLL9R3kEhmVUufSsvDwm4De6zLYbqiI0digIRmhMbGfLR5Xd2Xv9K8R0c2G21V2vWctkxiuibzCHgK/oBSVJz9M0Kj052ipePD/+RfNzOYqUo3puznm2gS7a/faGqhm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGu4W0JuTBnuuOL8lsHGcnJlcC48V9XBNjHmmtj/3o=;
 b=pA5UCjrCkYlkyD3iHRGA1bou1cC7IlKHmiROS5Z7GXhBSX3rxIdyhaGS5OlAj956uPjP5jcukzwvklTbkmBJjzaodCTRuAO5xWzUh0QR7dXu/CJnSdrLnqw7vsw2ViRicgsC8oTtQrAD+PyGWLt7NaEkrTXn7lT/kuOx74KmAgI=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3073.eurprd04.prod.outlook.com (10.167.171.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 10:20:59 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::1c80:e053:4521:648d]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::1c80:e053:4521:648d%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 10:20:59 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/4] Redesign MSI-X support in PCIe Endpoint Core
Thread-Topic: [PATCH 0/4] Redesign MSI-X support in PCIe Endpoint Core
Thread-Index: AQHVsCDY882ZY/buIk2tSlM0bNWYLae1iW0AgCzC0ID////XUA==
Date:   Thu, 9 Jan 2020 10:20:59 +0000
Message-ID: <AM5PR04MB3299A1A22D5EDD5438BDD44FF5390@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191211224636.GA122332@google.com>
 <a971c0b1-ed66-fd4c-5a1d-7aef9d410866@ti.com>
In-Reply-To: <a971c0b1-ed66-fd4c-5a1d-7aef9d410866@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3543e010-5e48-4efe-8b6a-08d794ed9f5e
x-ms-traffictypediagnostic: AM5PR04MB3073:
x-microsoft-antispam-prvs: <AM5PR04MB3073B27C770AB84DD18A7D19F5390@AM5PR04MB3073.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(13464003)(189003)(199004)(71200400001)(478600001)(7416002)(86362001)(966005)(45080400002)(2906002)(9686003)(4326008)(8936002)(55016002)(76116006)(316002)(33656002)(5660300002)(186003)(53546011)(6506007)(54906003)(8676002)(66946007)(81166006)(7696005)(52536014)(64756008)(81156014)(110136005)(44832011)(66476007)(66556008)(26005)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3073;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /T79TvFNhFPqCNQsSRJYkg2oOdVxSaWIwRVNFYXUktklS/qN2yT5BqolCWe2oNlXjs/BCWdvg1J1K3BIz3ZlAGNgfpM0jSH+kTCjOcJe5f8lzxBv+AGptSRmT8pRfPp0mu74L3nXrAHuGuHFtCCZfm4rDgTTVxgNEK5G9KphNgzzYwgG0kVDrZ7bI98BzVhfEgGnvSSsEoFO69qc1mPFh+oPdMBTRnrwqnkkH/UVwfJsjQA0axL6lkcjXkQmidBElQSMat89MwWj+M15kLHVIvp/Fkk1S7q01B0oQCnfpKQcgcs13CH8cJ7/tTQGFt1zhOqdju8XEiQnSjjzcbl6bcZQYykiAjKye3Xljtc+1Oc+wqZXtTqncmlr8EtgVR06QHidlWvFFqNttk3ZT8amYENhvTV2EfRWW1JPeBTEphM4FmGE5EBWbDWE3l2g8r9d8dyQSkUk1YMcOHclsy2MdRSD6BIB0TY1+Gi6lt92HWPjeqI5b4iNNsMqBo2c88WTYIwDBOGAxrIN/aimFMZLxgavdvkYOuXrA0RXnzLnfBLCraYtSfYdJBABMnTBOiaPR42byK58fVdPyBNir/NURaDVhJIQNqB9GTXhPeMO/swxYb1aN0C0KB8yqwel1XUFHTSRxAVCuRM+2BKfPn3Dyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3543e010-5e48-4efe-8b6a-08d794ed9f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 10:20:59.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpPHHrboox+Mlv8XxOcdoWYhm4TexJDbhkZtncIGj8mi/IrIJTMkFWcSh/uk1tptdfB70OrB3sWAwC/Hz4k6rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3073
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lzaG9uIFZpamF5IEFi
cmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gU2VudDogMjAyMOW5tDHmnIg55pelIDE4OjE5DQo+
IFRvOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBHdXN0YXZvIFBpbWVudGVs
DQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2Vp
LmJhb0BueHAuY29tPg0KPiBDYzogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20+OyBBbmRyZXcgTXVycmF5DQo+IDxhbmRyZXcubXVycmF5QGFybS5jb20+OyBNdXJh
bGkgS2FyaWNoZXJpIDxtLWthcmljaGVyaTJAdGkuY29tPjsgSmluZ29vDQo+IEhhbiA8amluZ29v
aGFuMUBnbWFpbC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzRdIFJlZGVzaWduIE1TSS1YIHN1cHBvcnQgaW4gUENJ
ZSBFbmRwb2ludCBDb3JlDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDEyLzEyLzE5IDQ6MTYgQU0sIEJq
b3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gT24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgMDY6MTY6MDRQ
TSArMDUzMCwgS2lzaG9uIFZpamF5IEFicmFoYW0gSSB3cm90ZToNCj4gPj4gRXhpc3RpbmcgTVNJ
LVggc3VwcG9ydCBpbiBFbmRwb2ludCBjb3JlIGhhcyBsaW1pdGF0aW9uczoNCj4gPj4gIDEpIE1T
SVggdGFibGUgKHdoaWNoIGlzIG1hcHBlZCB0byBhIEJBUikgaXMgbm90IGFsbG9jYXRlZCBieQ0K
PiA+PiAgICAgYW55b25lLiBJZGVhbGx5IHRoaXMgc2hvdWxkIGJlIGFsbG9jYXRlZCBieSBlbmRw
b2ludA0KPiA+PiAgICAgZnVuY3Rpb24gZHJpdmVyLg0KPiA+PiAgMikgRW5kcG9pbnQgY29udHJv
bGxlciBjYW4gY2hvb3NlIGFueSByYW5kb20gQkFScyBmb3IgTVNJWA0KPiA+PiAgICAgdGFibGUg
KGlycmVzcGVjdGl2ZSBvZiB3aGV0aGVyIHRoZSBlbmRwb2ludCBmdW5jdGlvbiBkcml2ZXINCj4g
Pj4gICAgIGhhcyBhbGxvY2F0ZWQgbWVtb3J5IGZvciBpdCBvciBub3QpDQo+ID4+DQo+ID4+IElu
IG9yZGVyIHRvIGF2b2lkIHRoZXNlIGxpbWl0YXRpb25zLCBwY2lfZXBjX3NldF9tc2l4KCkgaXMg
bW9kaWZpZWQNCj4gPj4gdG8gaW5jbHVkZSBCQVIgSW5kaWNhdG9yIHJlZ2lzdGVyIChCSVIpIGNv
bmZpZ3VyYXRpb24gYW5kIE1TSVggdGFibGUNCj4gPj4gb2Zmc2V0IGFzIGFyZ3VtZW50cy4gVGhp
cyBzZXJpZXMgYWxzbyBmaXhlZCBNU0lYIHN1cHBvcnQgaW4gZHdjDQo+ID4+IGRyaXZlciBhbmQg
YWRkIE1TSS1YIHN1cHBvcnQgaW4gQ2FkZW5jZSBQQ0llIGRyaXZlci4NCj4gPj4NCj4gPj4gVGhl
IHByZXZpb3VzIHZlcnNpb24gb2YgQ2FkZW5jZSBFUCBNU0ktWCBzdXBwb3J0IGlzIEAgWzFdLg0K
PiA+PiBUaGlzIHNlcmllcyBpcyBjcmVhdGVkIG9uIHRvcCBvZiBbMl0NCj4gPj4NCj4gPj4gWzFd
IC0+DQo+ID4+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRnBhdA0KPiA+Pg0KPiBjaHdvcmsub3psYWJzLm9yZyUyRnBhdGNo
JTJGOTcxMTYwJTJGJmFtcDtkYXRhPTAyJTdDMDElN0N4aWFvd2VpDQo+IC5iYW8lDQo+ID4+DQo+
IDQwbnhwLmNvbSU3Q2ExYzc4MDE3MDMyYzRmNDg4MmI3MDhkNzk0ZWQxZTljJTdDNjg2ZWExZDNi
YzJiNGM2DQo+IGZhOTJjZDkNCj4gPj4NCj4gOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTQxNjE4
NDU5NjA1NzA0JmFtcDtzZGF0YT1vMWdGck1lJTJCDQo+IERFUmNOSVZqSw0KPiA+PiA1WlJKbkRt
TzFRZkFLUW9zdFFjaTA1JTJCckpBJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4+IFsyXSAtPg0KPiA+
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cCUzQSUyRiUyRmxvcmUNCj4gPj4gLmtlcm5lbC5vcmclMkZyJTJGMjAxOTEyMDkwOTIxNDcuMjI5
MDEtMS1raXNob24lNDB0aS5jb20mYW1wO2RhdA0KPiBhPTAyJQ0KPiA+Pg0KPiA3QzAxJTdDeGlh
b3dlaS5iYW8lNDBueHAuY29tJTdDYTFjNzgwMTcwMzJjNGY0ODgyYjcwOGQ3OTRlZDFlOQ0KPiBj
JTdDNjg2DQo+ID4+DQo+IGVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
MzcxNDE2MTg0NTk2MDU3MDQmYQ0KPiBtcDtzZGF0YT0NCj4gPj4NCj4gZmRaRUZTQ0JjODl2QkVa
bENVcHVvSWpacXJzcVdQZE5hTnQzbk1GZE8wSSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+Pg0KPiA+
PiBBbGFuIERvdWdsYXMgKDEpOg0KPiA+PiAgIFBDSTogY2FkZW5jZTogQWRkIE1TSS1YIHN1cHBv
cnQgdG8gRW5kcG9pbnQgZHJpdmVyDQo+ID4+DQo+ID4+IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkg
KDMpOg0KPiA+PiAgIFBDSTogZW5kcG9pbnQ6IEZpeCAtPnNldF9tc2l4KCkgdG8gdGFrZSBCSVIg
YW5kIG9mZnNldCBhcyBhcmd1bWVudHMNCj4gPj4gICBQQ0k6IGR3YzogRml4IGR3X3BjaWVfZXBf
cmFpc2VfbXNpeF9pcnEoKSB0byBnZXQgY29ycmVjdCBNU0lYIHRhYmxlDQo+ID4+ICAgICBhZGRy
ZXNzDQo+ID4+ICAgUENJOiBrZXlzdG9uZTogQWRkIEFNNjU0IFBDSWUgRW5kcG9pbnQgdG8gcmFp
c2UgTVNJWCBpbnRlcnJ1cHQNCj4gPg0KPiA+IFRyaXZpYWwgbml0czoNCj4gPg0KPiA+ICAgLSBU
aGVyZSdzIGEgbWl4IG9mICJNU0ktWCIgYW5kICJNU0lYIiBpbiB0aGUgc3ViamVjdHMsIGNvbW1p
dCBsb2dzLA0KPiA+ICAgICBhbmQgY29tbWVudHMuICBJIHByZWZlciAiTVNJLVgiIHRvIG1hdGNo
IHVzYWdlIGluIHRoZSBzcGVjLg0KPiA+DQo+ID4gICAtICJGaXhlczoiIHRhZ3MgbmVlZCBub3Qg
aW5jbHVkZSAiY29tbWl0Ii4gIEl0IGRvZXNuJ3QgKmh1cnQqDQo+ID4gICAgIGFueXRoaW5nLCBi
dXQgaXQgdGFrZXMgdXAgc3BhY2UgdGhhdCBjb3VsZCBiZSB1c2VkIGZvciB0aGUNCj4gPiAgICAg
c3ViamVjdC4NCj4gPg0KPiA+ICAgLSBDb21taXQgcmVmZXJlbmNlcyB0eXBpY2FsbHkgdXNlIGEg
MTItY2hhciBTSEExLiAgQWdhaW4sIGRvZXNuJ3QNCj4gPiAgICAgaHVydCBhbnl0aGluZy4NCj4g
DQo+IEknbGwgZml4IGFsbCB0aGlzIGluIG15IG5leHQgcmV2aXNpb24uDQo+IA0KPiBYaWFvd2Vp
LCBHdXN0YXZvLA0KPiANCj4gVGhlIGlzc3VlcyB3ZSBkaXNjdXNzZWQgaW4gIFsxXSBzaG91bGQg
YmUgZml4ZWQgd2l0aCB0aGlzIHNlcmllcy4gQ2FuIHlvdSBoZWxwDQo+IHRlc3QgdGhpcyBpbiB5
b3VyIHBsYXRmb3Jtcz8NCg0KT0ssIEkgd2lsbCB0ZXN0IGl0IHdoZW4gSSBhbSBmcmVlLCBhbmQg
Z2l2ZSB0aGUgZmVlZGJhY2sgdG8geW91Lg0KDQpUaGFua3MNClhpYW93ZWkNCg0KPiANCj4gWzFd
IC0+DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxrbWwub3INCj4gZyUyRmxrbWwlMkYyMDE5JTJGMTElMkY2JTJGNjc4
JmFtcDtkYXRhPTAyJTdDMDElN0N4aWFvd2VpLmJhbw0KPiAlNDBueHAuY29tJTdDYTFjNzgwMTcw
MzJjNGY0ODgyYjcwOGQ3OTRlZDFlOWMlN0M2ODZlYTFkM2JjMmI0Yw0KPiA2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzNzE0MTYxODQ1OTYwNTcwNCZhbXA7c2RhdGE9bm1KDQo+IEdpQkxj
RVVuQkZUYWFvSlVPaEwyOTBjbUE3RiUyRjJ1Qm5UcHZ3OXVnbyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiANCj4gVGhhbmtzDQo+IEtpc2hvbg0KPiA+DQo=
