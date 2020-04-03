Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3ED19D316
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgDCJEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:04:42 -0400
Received: from mail-eopbgr1400110.outbound.protection.outlook.com ([40.107.140.110]:36704
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgDCJEl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0n3puH/GVwvduVGu5FT+K7XQVQxgoeGw0EHWLe2LXiUcQZaAKkL5eDTTOu60l3OfmfvQLfz2VN0zrHWuBVflF9wIxO4pTqzU3P431eEbDgVY6fJLevwlNGMufNIz/9ySsMf0KdB19U0p9hVHrk9sRiIuNSs9kTM+tj2fKizOi/1/XZGSKrrTCqrM4kUOghmYiz/dJDRQkZhaUc0d77wsnLv63jh/eoOcBpP6t/fbRoiLa1m7IQ+BNnXTL0tJh81o5CNAcBULiCpMHWgThj7Hy8suHhxTGltYKsF3W93h2DrBke6UOhW8Fau8Mko6yCFe6k70Mf5PP8FVu7OuU8lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ifLh57Z6sOZphu+sZr0zvImBA+VoFBmuIfXY7gz6Mo=;
 b=YIpsqXxq4afCBxUaep/hm6qLKNckw5N/GhoV4CLwW6TJIIyuOKKe6Lm/goyPc55LFx7/ffmS5aBiqbKXOUF/XjSNy1PIyhTjJ4enKdAYSfILul/M6HZl6DwkjP+b05p5j0jPB0yvHBiV2YVODAaot90NRaQtI3uXiU6qaVGD9NOmJfTjl0g1Ol0LeHiLiLwAvq/RHqQiGZHgU3+rMK7Om9xsd7dvtlo+yPJZyBJSVyoIYmXXaYPK/X2T1L+m7PArPlak9gyZ2TJ1Fx1LRsjf8pDr5504FZ99ATMzYC/eCL/W6t10RarHuZVoj7GijstchzcMGr1W4KStbQ+XX3d/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ifLh57Z6sOZphu+sZr0zvImBA+VoFBmuIfXY7gz6Mo=;
 b=CShNSqGXYeIxVlm6fqCZkL/rwzDMCZtEXV2dT2mNdXh8e70nrLxU8nwN2RWR8iYmMSiaa5JzsmzaKpIyrFJbVaodrxutZdVy6GK6rXNfX//BDrdGwugkC48BvMBvLG+0TAREEvRz7qQxsHm2iq6czDy6Ct4JWoqUlxisowssuMw=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3935.jpnprd01.prod.outlook.com (20.178.138.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Fri, 3 Apr 2020 09:04:36 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:04:36 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Thread-Index: AQHWCSZhTMobSnptQkuFlRDlbRGMO6hnB2iggAAJ7ICAAAiQUA==
Date:   Fri, 3 Apr 2020 09:04:35 +0000
Message-ID: <TYAPR01MB4544B6B749588A7390323D28D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB454403D69A74036B74CC8220D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdVWn=U82k5RJnBaRUgRHh3bRfdncOupmX67-u-nbwsG9w@mail.gmail.com>
In-Reply-To: <CAMuHMdVWn=U82k5RJnBaRUgRHh3bRfdncOupmX67-u-nbwsG9w@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f82b092-c362-4abf-ad12-08d7d7ae0874
x-ms-traffictypediagnostic: TYAPR01MB3935:|TYAPR01MB3935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB393569785400BEBB42F9278FD8C70@TYAPR01MB3935.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(54906003)(66446008)(478600001)(66946007)(7696005)(55236004)(76116006)(81156014)(6506007)(52536014)(81166006)(8936002)(8676002)(5660300002)(33656002)(7416002)(64756008)(110136005)(66476007)(66556008)(26005)(316002)(2906002)(86362001)(71200400001)(4326008)(55016002)(186003)(9686003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vL7tDxgRsZwkt8tfT4prhfnRjbQcGbfmQGvY7epBO5xoBNjhEsuw4mUYvrU74TN2CaXWVxBPZk/Kozs56Q0T7CDUKSNj/M9nJRb5TOeKKioehdLfzpJEq8DA1ZEPGfl9WKLK+e/n43friFAzcYQVzD8cKkdLpGzIfIO1nLVd7i9Ro9ro9YLk/JdqfZfJJJvvBU2TQyXW2KOVHRGvPszVq0kCIdyP/eLKO1JlRJxtnlyjmkc6O9iApmHHzGUrWVojrMBuyf9vMMIk0boK28bpYFavvmF/B7NwJLYK3afNAoqShypPLbrTLbP5+/gkcL6rrK+3pV/EHEZjYMHgegxPqRwhNPWaV3j80lw7R39fiX8yXTqUPka6Tjhw+v4MC4URIlaw4Gu/AxQG6eDRVzVSQMu0JkyDMrrq+4LIPXyNJAK2cMsn5KCBK9kxlB8Axete
x-ms-exchange-antispam-messagedata: Bei40bURwk4ntSHAOXcI92gT3Tq+P7fWE+P2wamilfiMNZni7pD9yKkWvNdP9Qyl2OcwB4PgZZvdSw/0gInW2WYkZDNE4OYze7IvCQsw82cD1hKkSCPJ0KsHPvCxwgb3JWWAofSd5YN7XppHqoNc6Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f82b092-c362-4abf-ad12-08d7d7ae0874
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:04:36.0061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs9OsfD+bzy5u38XCPW8G92/sr7Hy3sp7dphMlYW25j5wHkGhkc2X11rSWuclGZDtGqEE5Q2+KUvyPlIqmItDiib+CRS/2JgBOo9Ksf6wRgTty8DqwhCvX+KwXEag+SA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3935
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gRnJvbTog
R2VlcnQgVXl0dGVyaG9ldmVuLCBTZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjAgNToyOCBQTQ0K
PHNuaXA+DQo+ID4gQnV0LCBJJ20gdGhpbmtpbmcgdGhpcyBwYXRjaCAoYW5kIHBhdGNoIDAzLzEx
KSBzaG91bGQgYmUgc2VwYXJhdGVkDQo+ID4gZnJvbSB0aGlzIHBhdGNoIHNlcmllcyBmb3IgYXJt
NjQgc3Vic3lzdGVtIHRvIGVhc2UgbWFpbnRlbmFuY2UuDQo+ID4gTXkgc2NlbmFyaW8gaXM6DQo+
ID4gIDEpIHBhdGNoIHNlcmllcyAxOiBSLUNhciBQQ0llIGVuZHBvaW50IHN1cHBvcnQuDQo+ID4g
IC0tIFRoaXMgbWVhbnM6IHBhdGNoIDEsIDQgLSA5LCAxMQ0KPiA+DQo+ID4gIDIpIEFmdGVyIHRo
ZSBwYXRjaCBzZXJpZXMgMSBpcyBtZXJnZWQsIHN1Ym1pdCB0aGlzIHBhdGNoIDIvMTEgdG8gYXJt
IHN1YnN5c3RlbQ0KPiA+ICAgIGFuZCBzdWJtaXQgdGhlIHBhdGNoIDEwLzExIHRvIG1pc2Mgc3Vi
c3lzdGVtLg0KPiA+DQo+ID4gIDMpIEF0IGxhc3QsIHN1Ym1pdCBwYXRjaCAzLzExIGFmdGVyIHRo
ZSBwYXRjaCAyLzExIGlzIG1lcmdlZC4NCj4gPg0KPiA+IEdlZXJ0LXNhbiwgd2hhdCBkbyB5b3Ug
dGhpbms/DQo+IA0KPiBUaGFua3MsIEkgYWdyZWUgd2l0aCB5b3VyIHN1bW1hcnkuDQo+IA0KPiBJ
IGNhbiB0YWtlIHBhdGNoIDIvMTEgdGhyb3VnaCByZW5lc2FzLWRldmVsLg0KPiBQcm9iYWJseSBp
dCdzIGJlc3QgaWYgSSBzdWJtaXQgaXQgdG8gYXJtLXNvYyBhcyBhIGZpeCBmb3IgdjUuOCwgYWZ0
ZXINCj4gdGhlIGRyaXZlciBwYXJ0DQo+IGhhcyBiZWVuIG1lcmdlZCBpbnRvIHY1LjgtcmMxLCBz
byAzLzExIGNhbiBiZSBzdWJtaXR0ZWQgZm9yIHY1LjkuDQoNClRoYW5rIHlvdSEgSSBnb3QgaXQu
DQoNCj4gQlRXLCBJJ20gd29uZGVyaW5nIGFib3V0ICJbUEFUQ0ggdjYgMDUvMTFdIFBDSTogcmNh
cjogRml4IGNhbGN1bGF0aW5nDQo+IG1hc2sgZm9yIFBDSUVQQU1SIHJlZ2lzdGVyIi4gQ2FuIHRo
ZSBpc3N1ZSBmaXhlZCBieSB0aGlzIHBhdGNoIGhhcHBlbiB3aXRoDQo+IHRoZSBjdXJyZW50IGRy
aXZlciBpbiBob3N0IG1vZGUsIG9yIGlzIHRoYXQgbGltaXRlZCB0byBlcCBtb2RlPw0KPiBJbiBj
YXNlIG9mIHRoZSBmb3JtZXIsIHBsZWFzZSBzdWJtaXQgaXQgdG8gdGhlIFBDSSBtYWludGFpbmVy
IGFzIGEgc2VwYXJhdGUNCj4gZml4Lg0KDQpUaGFuayB5b3UgZm9yIHBvaW50ZWQgaXQgb3V0LiBJ
IHRoaW5rIHRoaXMgaXMgdGhlIGNhc2Ugb2YgdGhlIGZvcm1lci4NCklJVUMsIGlmIHN1Y2ggYSBz
bWFsbCB3aW5kb3cgUENJZSBkZXZpY2UgZXhpc3RzLCB0aGUgaXNzdWUgaGFwcGVucy4NCg0KUHJh
Ymhha2FyLXNhbiwgaXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KDQpCZXN0IHJlZ2FyZHMs
DQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
