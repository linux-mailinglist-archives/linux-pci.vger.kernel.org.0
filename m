Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5A19D3BA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbgDCJbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:31:49 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:4395
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732595AbgDCJbt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:31:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/KPhnHymyFddQxjfmGr+9yvWKQUhLxOXoIGc855DEV0j67f3Sz3sB16Mz0+ewsAWGv1MwWyk4THYDORW90uqElqtKUpIFlIRtu5lq53DpNM6Vmoni0oA1dAptDt8KN7rYM8FIRvTLt5KdwFU5nZTIMI2RHQbPejJmbWgJAgQE5P5EocExO6ZgnVRT31/am2ITQPWqhiBDMx9QFAnzhB+ZajP5ssvzGSitYbuSWoRkAc4AoW08jReKORQ8a1qhCJQYE6bARQGTmKf28GEV8tlCCzcc9UWsFU8dp3psH3+vuWF6lrRhLpjEgIcImdHeUQVPTXdGB8vMjer9lEMTIk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V70GJYUbz1GXDV9y0hvhxp7NDdSQX8iO22oWTYjEBWA=;
 b=Yima1TKPg7DF8EJQsCFtwjUanjgCRUTwYW8wfEPxVOHOGY6mnuPJ4waYrho3EHhFJ6NVF5t7nSDuVUB6VOM+9isAA5ZIl1ZDVBNcwOjxogeNzrg9yvDyvmlk+f7CMNpHDO8t8Yx0qMYMQhrC2iyCAJ4IawijewcBcZkR8Y6dZWzYyFMSWKh7eowkUEIxOAhUokglMpUptCbmkw2TAUjrSE7TM9v5IAVvUjYwi3pRn3PTRFndA0aTiDQj9pcyvvjYKAw5mKxZNHFYsVOs8gOdWcKkfD/bkqFmoQd/LryoiGQtaHgj1SEQvDdUSzjO1I4lSkoNU/FToi5OVHVRHwlmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V70GJYUbz1GXDV9y0hvhxp7NDdSQX8iO22oWTYjEBWA=;
 b=Kq36H25bq7M28e6lx3Ic7PravnCHP7I0infMVVPS7z0CPwyxU6SHJLAo23GB53NKjuW2jvYW0DuXOffXT/04Ad4kXpzZCfwQ5f37bWuafd4zU3SYu9FUBnqT4S8vK6b6JUQ7xqCkams0jQ0t66n91pRdxyijiu82Pe1iLHOugzE=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2021.jpnprd01.prod.outlook.com (52.134.242.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 09:31:44 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:31:44 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v6 02/11] arm64: defconfig: enable CONFIG_PCIE_RCAR_HOST
Thread-Topic: [PATCH v6 02/11] arm64: defconfig: enable CONFIG_PCIE_RCAR_HOST
Thread-Index: AQHWCSZhFu4QxmekC0qbQMp4EyLiHqhnCn8AgAAG1YCAAAopgIAABS5g
Date:   Fri, 3 Apr 2020 09:31:43 +0000
Message-ID: <OSBPR01MB35905B0D9DB55E8FBA340341AAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB454403D69A74036B74CC8220D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdVWn=U82k5RJnBaRUgRHh3bRfdncOupmX67-u-nbwsG9w@mail.gmail.com>
 <TYAPR01MB4544B6B749588A7390323D28D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544B6B749588A7390323D28D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c96b77a3-e098-464b-2924-08d7d7b1d2c7
x-ms-traffictypediagnostic: OSBPR01MB2021:|OSBPR01MB2021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2021078E9DCA28E57CAA542DAAC70@OSBPR01MB2021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(26005)(81166006)(81156014)(71200400001)(66446008)(478600001)(186003)(54906003)(316002)(86362001)(110136005)(53546011)(6506007)(7696005)(76116006)(33656002)(55016002)(7416002)(4326008)(8676002)(5660300002)(9686003)(8936002)(2906002)(66946007)(52536014)(66556008)(66476007)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YeIsbFxwYIWRZM0FB7AH+zKdPT9mRcjSROP04dxv+BiO2aZpZTICkU09LazdEPmvcWVHJ1ZvVUMnjP5mhG+MmVq8vpUk/EQtXW5Mvjhauj+OHOJvn4XObtyjWjEeFeyM4Zx60IJis4A4/0pLCkOd5t99jiQdWLZYf23qwXtO2aj6UxzV1H25se1hqB9LCtqNErxIsXFLSYyKgoUc2sm3a3AJBRfVZqRDs3mbIufzw3P7jJ/n2t5ZNl0ClT6dOnDURsow78fdufyiIWAimJg2QmdLfIr0Kq3UrMlX5o5E4c9keZtQHMdToGe5hbMKWiGi23uavNJc5b93eDAk/SsKaOkcjjkniqKyx/C1A2HKVmNlGV+qhINg5ewdIIZPLVbfDl6w9ya1+TzlYPWh/Rdjy9iharPczbo3PXo3SGP29Xrpa3gRy1vDGy936tsEuBPc
x-ms-exchange-antispam-messagedata: GVV7CB3PNuk9Bamfa+ZPVQgqgWZRYhj2qLqU1GRNpL/Mep0LXkMedzGVEzgH8wgIGVGsrpQllfv02fkHsAsRiwnA5/Znks1wXP9A9c/Eny5gYq5eySfdZ4mJFliiWKBB6cNNy09X/gwsVaYr07by7A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b77a3-e098-464b-2924-08d7d7b1d2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:31:43.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VMvEqtGHKer2dhPJECeDBN4X+JioRP7vXuM6mrdsUWYF6NkRuu9hMwxUW3cm+CzHatRRKYb3qQZQp1Jw/BfWGzmg/KlQE2zgi/tFqTM23653gDTNxvGIXXTdLw0ngmv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2021
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2hpbW9kYS1zYW4vR2VlcnQtc2FuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT4NCj4gU2VudDogMDMgQXByaWwgMjAyMCAxMDowNQ0KPiBUbzogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz47IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhh
a2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdp
bGxAa2VybmVsLm9yZz47IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIu
YmU+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgQXJuZA0KPiBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBBbmRyZXcgTXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+Ow0K
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1yZW5lc2FzLXNv
Y0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzDQo+IFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVu
ZXNhcy5jb20+OyBGcmFuayBSb3dhbmQgPGZyb3dhbmQubGlzdEBnbWFpbC5jb20+OyBHdXN0YXZv
IFBpbWVudGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IEppbmdvbyBIYW4g
PGppbmdvb2hhbjFAZ21haWwuY29tPjsgU2ltb24gSG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+
OyBTaGF3biBMaW4NCj4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT47IFRvbSBKb3NlcGggPHRq
b3NlcGhAY2FkZW5jZS5jb20+OyBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPjsgbGlu
dXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhZCBQcmFiaGFrYXIgPHByYWJo
YWthci5jc2VuZ2dAZ21haWwuY29tPjsgTWFnbnVzIERhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNv
bT47IEtpc2hvbiBWaWpheQ0KPiBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+OyBMb3JlbnpvIFBp
ZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IE1hcmVrIFZhc3V0IDxtYXJlay52
YXN1dCtyZW5lc2FzQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjYgMDIvMTFdIGFybTY0OiBkZWZjb25maWc6IGVuYWJsZSBDT05G
SUdfUENJRV9SQ0FSX0hPU1QNCj4NCj4gSGkgR2VlcnQtc2FuLA0KPg0KPiBUaGFuayB5b3UgZm9y
IHlvdXIgY29tbWVudHMhDQo+DQo+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuLCBTZW50OiBG
cmlkYXksIEFwcmlsIDMsIDIwMjAgNToyOCBQTQ0KPiA8c25pcD4NCj4gPiA+IEJ1dCwgSSdtIHRo
aW5raW5nIHRoaXMgcGF0Y2ggKGFuZCBwYXRjaCAwMy8xMSkgc2hvdWxkIGJlIHNlcGFyYXRlZA0K
PiA+ID4gZnJvbSB0aGlzIHBhdGNoIHNlcmllcyBmb3IgYXJtNjQgc3Vic3lzdGVtIHRvIGVhc2Ug
bWFpbnRlbmFuY2UuDQo+ID4gPiBNeSBzY2VuYXJpbyBpczoNCj4gPiA+ICAxKSBwYXRjaCBzZXJp
ZXMgMTogUi1DYXIgUENJZSBlbmRwb2ludCBzdXBwb3J0Lg0KPiA+ID4gIC0tIFRoaXMgbWVhbnM6
IHBhdGNoIDEsIDQgLSA5LCAxMQ0KPiA+ID4NCj4gPiA+ICAyKSBBZnRlciB0aGUgcGF0Y2ggc2Vy
aWVzIDEgaXMgbWVyZ2VkLCBzdWJtaXQgdGhpcyBwYXRjaCAyLzExIHRvIGFybSBzdWJzeXN0ZW0N
Cj4gPiA+ICAgIGFuZCBzdWJtaXQgdGhlIHBhdGNoIDEwLzExIHRvIG1pc2Mgc3Vic3lzdGVtLg0K
PiA+ID4NCj4gPiA+ICAzKSBBdCBsYXN0LCBzdWJtaXQgcGF0Y2ggMy8xMSBhZnRlciB0aGUgcGF0
Y2ggMi8xMSBpcyBtZXJnZWQuDQo+ID4gPg0KPiA+ID4gR2VlcnQtc2FuLCB3aGF0IGRvIHlvdSB0
aGluaz8NCj4gPg0KPiA+IFRoYW5rcywgSSBhZ3JlZSB3aXRoIHlvdXIgc3VtbWFyeS4NCj4gPg0K
PiA+IEkgY2FuIHRha2UgcGF0Y2ggMi8xMSB0aHJvdWdoIHJlbmVzYXMtZGV2ZWwuDQo+ID4gUHJv
YmFibHkgaXQncyBiZXN0IGlmIEkgc3VibWl0IGl0IHRvIGFybS1zb2MgYXMgYSBmaXggZm9yIHY1
LjgsIGFmdGVyDQo+ID4gdGhlIGRyaXZlciBwYXJ0DQo+ID4gaGFzIGJlZW4gbWVyZ2VkIGludG8g
djUuOC1yYzEsIHNvIDMvMTEgY2FuIGJlIHN1Ym1pdHRlZCBmb3IgdjUuOS4NCj4NCj4gVGhhbmsg
eW91ISBJIGdvdCBpdC4NCj4NClRoYW5rIHlvdSwgSWxsIHNwbGl0IHRoZSBwYXRjaGVzIGFjY29y
ZGluZ2x5IGFuZCBwb3N0IGEgdjcuDQoNCj4gPiBCVFcsIEknbSB3b25kZXJpbmcgYWJvdXQgIltQ
QVRDSCB2NiAwNS8xMV0gUENJOiByY2FyOiBGaXggY2FsY3VsYXRpbmcNCj4gPiBtYXNrIGZvciBQ
Q0lFUEFNUiByZWdpc3RlciIuIENhbiB0aGUgaXNzdWUgZml4ZWQgYnkgdGhpcyBwYXRjaCBoYXBw
ZW4gd2l0aA0KPiA+IHRoZSBjdXJyZW50IGRyaXZlciBpbiBob3N0IG1vZGUsIG9yIGlzIHRoYXQg
bGltaXRlZCB0byBlcCBtb2RlPw0KPiA+IEluIGNhc2Ugb2YgdGhlIGZvcm1lciwgcGxlYXNlIHN1
Ym1pdCBpdCB0byB0aGUgUENJIG1haW50YWluZXIgYXMgYSBzZXBhcmF0ZQ0KPiA+IGZpeC4NCj4N
Cj4gVGhhbmsgeW91IGZvciBwb2ludGVkIGl0IG91dC4gSSB0aGluayB0aGlzIGlzIHRoZSBjYXNl
IG9mIHRoZSBmb3JtZXIuDQo+IElJVUMsIGlmIHN1Y2ggYSBzbWFsbCB3aW5kb3cgUENJZSBkZXZp
Y2UgZXhpc3RzLCB0aGUgaXNzdWUgaGFwcGVucy4NCj4NCj4gUHJhYmhha2FyLXNhbiwgaXMgbXkg
dW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KPg0KVGhpcyBpc3N1ZSB3aWxsIG9ubHkgYmUgaGl0IG9u
IEVQLCB3aGVuIGluIGhvc3QgbW9kZSB0aGUgc2l6ZXMgd2lsbCBiZSBmaXhlZCB0byAxIE1ieXRl
cyAvMiBNYnl0ZXMgLzEyOCBNYnl0ZXMNCg0KQ2hlZXJzLA0KLS1QcmFiaGFrYXINCg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IFlvc2hpaGlybyBTaGltb2RhDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNz
IEV1cm9wZSBHbWJILCBHZXNjaGFlZnRzZnVlaHJlci9QcmVzaWRlbnQ6IENhcnN0ZW4gSmF1Y2gs
IFNpdHogZGVyIEdlc2VsbHNjaGFmdC9SZWdpc3RlcmVkIG9mZmljZTogRHVlc3NlbGRvcmYsIEFy
Y2FkaWFzdHJhc3NlIDEwLCA0MDQ3MiBEdWVzc2VsZG9yZiwgR2VybWFueSwgSGFuZGVsc3JlZ2lz
dGVyL0NvbW1lcmNpYWwgUmVnaXN0ZXI6IER1ZXNzZWxkb3JmLCBIUkIgMzcwOCBVU3QtSUROci4v
VGF4IGlkZW50aWZpY2F0aW9uIG5vLjogREUgMTE5MzUzNDA2IFdFRUUtUmVnLi1Oci4vV0VFRSBy
ZWcuIG5vLjogREUgMTQ5Nzg2NDcNCg==
