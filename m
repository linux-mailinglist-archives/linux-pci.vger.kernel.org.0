Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19A81A3D40
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDJAMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:12:54 -0400
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:56192
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgDJAMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 20:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyPeTa2pgapM49Eq8Dro0JQ/LIRuKVHbUOtykT2HY+/EHyqh5uxyXIjCPzLG3ZNIHp50/zf3DST8M3GD63HejkVpudlDkFI2BtzXeDOVgVXbX5OvIAD03DFeFTbYU8LWWoN3Ils0OUMJONdkPyRGVDBQr+rgGo8FHuZpWi+7hiT8PTUXidhEI+L7aZUzDinSv5niHktOtfy0BDvgYAjaWKzJpY1yDoTweS9bMwEko0tnxWh1iM4UCwLWoZpuMBXHMsJUKnBjKPQNOPRMNQP7DlKNADmmCKMIgNAdJR1QM1oD76dD1Lr5O4Tyh+xsSmR/R1mIJyldzg11Gbh4OWkVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJMS4nAd3SiJk7CDzJfRcf2i1k2/+5drd5ueJ9cxo9I=;
 b=awNvRB2m2kgr1aDC+4nXovcCF/N6JSKu1QreNg2GZDGaHpyyvMVm6NQvgSLXfh6VUcEOdWcMCbpkmRdC/1QhaPYGD7UgTdP6+OTXmeZ//N7THgFsnxNQKgvTwJc8xl8ZQaYuJNg+KeUFJbvNKNIt8FqCcJnUl9TRYXQEAMSiFVcHTtVzLGQI1GMO3tBeJWgs40yzq2+TyWY36v7KrMpdn8KsIFysE9sBBglUZQelVgakU8Lr21c2C1ndm7qKrbHcb21/RSwhWS0fwzJx30GNcOJGukulhSkGoogoyck0wo4Ahoj/cwFYpvdHIqXLeQ6eIbJk/T/iqXY/tf0XvyLMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJMS4nAd3SiJk7CDzJfRcf2i1k2/+5drd5ueJ9cxo9I=;
 b=Im4t3OeUhSs6Z2iPzzL6ApfcYdCQs70Ml/efk4VXKtUkRSfVMpIk/1GMtaVAfrY32cw/J2m76DP3cUISVDRAGZ348WoTUIzA0gO1jbLTikk7W27uaIX+xNAAjmaqBiCrf/YBC+liA8ZafYtu/z8qnBRyRIePTTG+gDf6VvyzyIw=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2559.jpnprd01.prod.outlook.com (20.177.105.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Fri, 10 Apr 2020 00:12:39 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 00:12:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH v7 7/8] PCI: Add Renesas R8A774C0 device ID
Thread-Topic: [PATCH v7 7/8] PCI: Add Renesas R8A774C0 device ID
Thread-Index: AQHWDbvP66ahBIzixkep7RDyHrjTa6hwiR4AgAAICQCAAOwwQA==
Date:   Fri, 10 Apr 2020 00:12:38 +0000
Message-ID: <TYAPR01MB4544313471DD93D131E82EF5D8DE0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1586360280-10956-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586360280-10956-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <e3f5fa77-f78e-edbf-9efc-53b5ea620460@cogentembedded.com>
 <CA+V-a8s1E_kq_GENBTw3zGxKSPFnVKNY-ta9+c8W8nV4JFyEEw@mail.gmail.com>
In-Reply-To: <CA+V-a8s1E_kq_GENBTw3zGxKSPFnVKNY-ta9+c8W8nV4JFyEEw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7930e37-21f2-4db9-f51c-08d7dce3e157
x-ms-traffictypediagnostic: TYAPR01MB2559:|TYAPR01MB2559:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2559DCE47DACF5B447986E99D8DE0@TYAPR01MB2559.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(8676002)(71200400001)(54906003)(316002)(110136005)(478600001)(81166007)(33656002)(7416002)(2906002)(4744005)(76116006)(66446008)(186003)(26005)(55236004)(66476007)(52536014)(66946007)(55016002)(6506007)(66556008)(5660300002)(8936002)(7696005)(86362001)(9686003)(4326008)(64756008)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bVv7ATNQrwzzsutT6PHd8Ocsq8cT58KLlfceEF7FQtxshIJdJlbpnuE/VF47cm5Ths/U4XIWFggwmDDr0yJZLWwcuwGyZOWbcGmh/+foyZaehH07Md8THldB7ORJMWQPPdADJyeFsDLBCvETcHjP54i7kaea+Da42IHPEMZiWGAhXkumoZ+H5cdMrc9C2HCT2374EGFcpiwaMUEv9QUaGpWpfB2X3fjsjJATXCUzUGst0H3SSTi9nZx2QCdiz2A2tp9GvcOQUJWVvcfNSdm/iAE/T8Ui/qUJV4P0SH8LD+bn8XFljNE2pKaqulNnFJT4Hi1Qi+hEyjRGQytHjpb6euFFFQXgDDsXd86TFCSJJnkerOayMBukkt0HjXQvGkRw6vRaFk0PBKZ7w3D9zV+/qgx0YmLlIGJyHzbsti1UJ0RvOTVowlKnfr+MA2OzZVz
x-ms-exchange-antispam-messagedata: Y20TwZ9Ft+zMWl7pnsCLL8gkvC79CCwOqHdbHMX+gDN8/reG+/hBlYvGUM3AH6hRGKu/3dRQgUR/ed+8+QFwo3jNRSw8yHA++rmpR9rO2EIKUUrIzF4D6QmsQ+I2xJDdvkRVncxG5lKIdvVay64QyA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7930e37-21f2-4db9-f51c-08d7dce3e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 00:12:39.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f87/bCPE86htyXT3bVCRnx2IlQtb8bYWEYF7B4Py1L/E68j0UI/u7BNQ3z+GTZmImKIBMefPMmmThFzmyMqJi6Au16nwkVNVrHZ49intYn7HNuo8Ia7dH91Kswp7AXgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2559
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLCBTZXJnZWksIEJqb3JuLA0KDQo+IEZyb206IExhZCwgUHJhYmhha2FyLCBT
ZW50OiBUaHVyc2RheSwgQXByaWwgOSwgMjAyMCA3OjA1IFBNDQo8c25pcD4gDQo+ID4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmggYi9pbmNsdWRlL2xpbnV4L3BjaV9pZHMu
aA0KPiA+ID4gaW5kZXggMWRmYzRlMWRjYjk0Li45ZTk1N2MxOGFiZWIgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9w
Y2lfaWRzLmgNCj4gPiA+IEBAIC0yNDYwLDYgKzI0NjAsNyBAQA0KPiA+ID4gICAjZGVmaW5lIFBD
SV9ERVZJQ0VfSURfUkVORVNBU19TSDc3NjMgICAgICAgIDB4MDAwNA0KPiA+ID4gICAjZGVmaW5l
IFBDSV9ERVZJQ0VfSURfUkVORVNBU19TSDc3ODUgICAgICAgIDB4MDAwNw0KPiA+ID4gICAjZGVm
aW5lIFBDSV9ERVZJQ0VfSURfUkVORVNBU19TSDc3ODYgICAgICAgIDB4MDAxMA0KPiA+ID4gKyNk
ZWZpbmUgUENJX0RFVklDRV9JRF9SRU5FU0FTX1I4QTc3NEMwICAgICAgIDB4MDAyZA0KPiA+DQo+
ID4gICAgIFdlIGRvbid0IGFkZCB0aGUgZGV2aWNlIElEcyBpbiB0aGlzIGZpbGUsIHVubGVzcyB1
c2VkIGluIHNldmVyYWwgcGxhY2VzLg0KPiA+IElzIGl0Pw0KPiA+DQo+IE15IGJhZCBJIHNob3Vs
ZCBoYXZlIGNoZWNrZWQgaXQgYmVmb3JlIG1ha2luZyB0aGlzIGNoYW5nZSBhY3R1YWxseSBpdA0K
PiB3YXMgc3VnZ2VzdGVkIGluIG15IHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHNlcmllcyBidXQg
YW55d2F5IGF0bSB0aGlzDQo+IHdhcyBwbGFubmVkIHRvIGJlICB1c2VkIG9ubHkgaW4gcGNpX2Vu
ZHBvaW50X3Rlc3QgZHJpdmVyLCBzbyBpbiB0aGF0DQo+IGNhc2UgSWxsIGRyb3AgdGhpcyBwYXRj
aC4NCg0KSSdtIHZlcnkgc29ycnksIHRoaXMgaXMgbXkgZmF1bHQuIEkgc3VnZ2VzdGVkIHRoaXMg
YnV0IEkgZGlkbid0IGNoZWNrDQp0aGlzIHBjaV9pZHMuaCdzIHJ1bGUuLi4NCg0KQmVzdCByZWdh
cmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
