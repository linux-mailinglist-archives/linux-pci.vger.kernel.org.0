Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B403719D43B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgDCJpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:45:04 -0400
Received: from mail-eopbgr1400120.outbound.protection.outlook.com ([40.107.140.120]:6221
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgDCJpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBfTxoYsfIPOsFCTdDSVRm1SoL5jy47WTROX0+0fi+Sw/Vy5q3XHWP9gx8KV3Dlnkahe1X9A45eEh/G96leUfexY4aHJvdjZC3lY61AOCYEjCypElqCqK81qfPahLGlHZovDA6ijCh8yUdTTBbqGLDEqxME8B3NFfr6qS/jtbcf42KSZnU6v+JwxcKsZ1uYlXP0UgRt1xnFrBfVryxY4gAUbTn6/tNbCTLBFZZHnCrvfRZ7wEX1KRHBCX7kKO/9FvHMFkA9sH7d5TOL58hm/zsdQV5lTKDeEFN+m2c/YkiiYDnvLNQWE26oyStbQAKAvWLkCR5T9VTNzQg2yPT3SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIc5nBQu/aOcO3k0qYvTFoWOqJSS8aaTn08gKjqehSA=;
 b=SFclxZULwwDQtSolv4+++tNai3uBt5CrbCNd6vc4EtLFWrYyWZ8Brfu5Cp2yyVmo7pFTgajUGaMofwl0tyy3OnNULaH8RLsGmI0WhAmf/y1DTlV6eKsS5t3BA0OhDMg+G8f5wIsUQ5B01P8+Zi4KZC1ehnpvfzZ1kpMS7LlOCwNwSkpQ3qrlT+htKrmDIy4cRFzXmtO4IYE+28HNFXPR9j0/iveA7wRO+CDFG0pApwgo3x3zcyw3rGsF/YNvDuHZy2ouq8iYPA1PWOzlPV38CZLKXwI43TAwmHCzWModqlXGrzVN+ZrDNlF7amUsDi67r1DsPDUJRH/XghXPl4J9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIc5nBQu/aOcO3k0qYvTFoWOqJSS8aaTn08gKjqehSA=;
 b=NHFNZAJhDstltq32hGqLLeey9JwzlAIK5WyYzI806cP8joci8llpQzkg/o16ZLaQpO83xXlKMlKHhsZgSiBuaV8YwTzLMhKqfevf+oX7zEZG70mFcudTaRudRi7qYIp89RLJAzGZcOL2Gt698Tp8bBb7NQg7WRMt0owI+13gKbA=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5246.jpnprd01.prod.outlook.com (20.179.187.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Fri, 3 Apr 2020 09:44:58 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:44:58 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
Thread-Index: AQHWCSZhTMobSnptQkuFlRDlbRGMO6hnB2iggAAJ7ICAAAiQUIAACS6AgAACZ6A=
Date:   Fri, 3 Apr 2020 09:44:58 +0000
Message-ID: <TYAPR01MB4544C82A8763A28034985C9DD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB454403D69A74036B74CC8220D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdVWn=U82k5RJnBaRUgRHh3bRfdncOupmX67-u-nbwsG9w@mail.gmail.com>
 <TYAPR01MB4544B6B749588A7390323D28D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <OSBPR01MB35905B0D9DB55E8FBA340341AAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB35905B0D9DB55E8FBA340341AAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8b28959-59cd-461b-ce6f-08d7d7b3ac43
x-ms-traffictypediagnostic: TYAPR01MB5246:|TYAPR01MB5246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB524602F757F73EDC9F0A000ED8C70@TYAPR01MB5246.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(52536014)(54906003)(55236004)(33656002)(55016002)(9686003)(86362001)(478600001)(8936002)(6506007)(71200400001)(2906002)(7696005)(7416002)(66556008)(186003)(110136005)(5660300002)(316002)(26005)(66946007)(81156014)(4326008)(76116006)(66476007)(66446008)(81166006)(8676002)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVSHotmYBiYyMcntgRJUe1oifgbDQid7HfY+XYyFcGF1OBrX0BzwJJm7tPjbdLnhHADap0iNJbEywr2yOYsrxxrAZjnaanQPEr98puLpQlsoY7JpqKDFaMnm7691PqjGRkiB70g//1JqJVuYmyUU3Xt/tfjQB+yfXmcYFeWBWIptFRIkXyNH8DtaVMGORagTkbZ0XLv/LFhc/mKeVlh1rdljVSXqjf3u5ZnSbj2q45sqia1gOMhdeK0HbJsOV4btUx/F0joJKHrhAjJdlN+3DnvqHZpiFovoi4/zvsRWw0H5yjjXSjhdyZqW7zM7UE7o6NcC5Cii8I09G0pz+c7kbmptr1GcZvYxy2iCfLWHIqMTn9TAKf0oLghviprKc7ohFdjaXrxyvBkveudpGFp6tQtSuyXAJ/kmV9w9E/DB1rdq1H2tKiBmLW/3VCOlB2Mi
x-ms-exchange-antispam-messagedata: ZntTqWT1qDAwjWGvjXPfeAvUbYx2Z4KRJngscq04Gzb3tHaHkzznoMx/KPHyUlwm9I+Ei8KYCCT2wGSsUauT/OO36BfSRgCJ5avN3GKpVqKQMcuc5ef1vr7UkZ/T+nh9CGmUAR1shKeEECi0ldIJqQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b28959-59cd-461b-ce6f-08d7d7b3ac43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:44:58.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jG4XhzeRNZ5dal9JO05wXwBo912oynQRqmYfeBjeDHxOV9G7uC7Dm00VRe9CfW2Zr1WTuWGCCPzMXeCFuTzHhbMaaDwCUpCFVgUTO18t4CswgrsU4j7+q95C/vQbYQoe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5246
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLXNhbiwNCg0KPiBGcm9tOiBQcmFiaGFrYXIgTWFoYWRldiBMYWQsIFNlbnQ6
IEZyaWRheSwgQXByaWwgMywgMjAyMCA2OjMyIFBNDQo8c25pcD4NCj4gPiA+IEJUVywgSSdtIHdv
bmRlcmluZyBhYm91dCAiW1BBVENIIHY2IDA1LzExXSBQQ0k6IHJjYXI6IEZpeCBjYWxjdWxhdGlu
Zw0KPiA+ID4gbWFzayBmb3IgUENJRVBBTVIgcmVnaXN0ZXIiLiBDYW4gdGhlIGlzc3VlIGZpeGVk
IGJ5IHRoaXMgcGF0Y2ggaGFwcGVuIHdpdGgNCj4gPiA+IHRoZSBjdXJyZW50IGRyaXZlciBpbiBo
b3N0IG1vZGUsIG9yIGlzIHRoYXQgbGltaXRlZCB0byBlcCBtb2RlPw0KPiA+ID4gSW4gY2FzZSBv
ZiB0aGUgZm9ybWVyLCBwbGVhc2Ugc3VibWl0IGl0IHRvIHRoZSBQQ0kgbWFpbnRhaW5lciBhcyBh
IHNlcGFyYXRlDQo+ID4gPiBmaXguDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHBvaW50ZWQgaXQg
b3V0LiBJIHRoaW5rIHRoaXMgaXMgdGhlIGNhc2Ugb2YgdGhlIGZvcm1lci4NCj4gPiBJSVVDLCBp
ZiBzdWNoIGEgc21hbGwgd2luZG93IFBDSWUgZGV2aWNlIGV4aXN0cywgdGhlIGlzc3VlIGhhcHBl
bnMuDQo+ID4NCj4gPiBQcmFiaGFrYXItc2FuLCBpcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/
DQo+ID4NCj4gVGhpcyBpc3N1ZSB3aWxsIG9ubHkgYmUgaGl0IG9uIEVQLCB3aGVuIGluIGhvc3Qg
bW9kZSB0aGUgc2l6ZXMgd2lsbCBiZSBmaXhlZCB0byAxIE1ieXRlcyAvMiBNYnl0ZXMgLzEyOCBN
Ynl0ZXMNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuIE5vdyBJIHVuZGVyc3Rvb2QgdGhp
cyBpcyByZWxhdGVkIHRvICJQQ0lFbiBtZW1vcnkgbSIgaW4gdGhlIGRvY3VtZW50DQphbmQgcmVs
YXRlZCB0byByYW5nZXMgcHJvcGVydHkgaW4gdGhlIGRldmljZSBub2RlLiBTbywgSSdkIGxpa2Ug
dG8gcmVjYWxsIG15IHByZXZpb3VzIGNvbW1lbnQgYW5kDQpJIGFncmVlIHRoZSBwYXRjaCAwNi8x
MSBpcyByZXF1aXJlZCBvbiBFUCBtb2RlIG9ubHkuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGly
byBTaGltb2RhDQoNCg==
