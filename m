Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950789F96C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfH1E3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 00:29:43 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:50983
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfH1E3n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 00:29:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/vtzacP7zPs9U+2sdpsptR/3hoBsBkeGUj61lu0wdlV/jzJlcviNnK7Dsv2Peap7f7xb8bHwCggcCPXt4jgKLpgatJesn0AKlY36+8nL2yfs++RnRQ0RQ75zSnrFpJL7bZtTDmOpCiJokuWUg/iGm5qtVS58cM/TNmnRqxb7aKbQIjs1Pq3zeYs+Z5C+/4mkeWied1QpEZTJvH9yudWrKmn4KOr/9KIgE7L3ii2Pc78Fvb6GJuFb/M9CEY2z/TzDZug3lpnuKPZNMe/Na6TUCd4nNE2ocpTVQH1fSh0oI5RZqqBg5EZhfJ3Mb5HDWgmQ7lojg1zhZIlvZ1XHKOPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukBIG7sTUuEU7CTe547b5us2WjlH/678FH5npSYozOw=;
 b=hStmQVYgR0zYwBtU4feOtHHbMtSGFGBCTX1tcl7jWwj4791cpDR8EJ3vy8MldyAQmoLbRPPcPpJnx8IcC63gT1MEJGuc1I8gnkHJjCZn9I3coIPsaloBbYLPFu0gB6ziN+s7Kxt4Z/a42Y+phqaYRipxluEnknoIcXJuDV8hR73qhBy7xqAhDeCzgxouqLC+6IIOtKJJ/X1c9BopsDTR0TiMaVTDNNWJ719hYhFOiNx81E4CyistNKx/CBjZI0sK8UVwfHWanT+sPSnPJ/vpx0tvGtzAtOTv8hAAkcwyl98pbOYvJ5hASxdOLFnR+ios+hM0IwZH8WtINof2htrV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukBIG7sTUuEU7CTe547b5us2WjlH/678FH5npSYozOw=;
 b=Bwu0TvBXLfPTsTDAfFHH4FO/8Jl0OAcuFOO2CXb0Ms2NooJ5RqllQrH9qiudHoUbe1ZINmCeNhihubYaZdw64E0+cjafrjfMTnXsawLd/wtCnA354hDdJpwKnLPQhFneXQl2TttDD/51UkGqcWa9rjIzmrw0TozuDN7mSGJk5Hs=
Received: from VI1PR04MB3310.eurprd04.prod.outlook.com (10.170.231.148) by
 VI1PR04MB4926.eurprd04.prod.outlook.com (20.177.49.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 04:29:32 +0000
Received: from VI1PR04MB3310.eurprd04.prod.outlook.com
 ([fe80::cc5f:fa01:329d:7179]) by VI1PR04MB3310.eurprd04.prod.outlook.com
 ([fe80::cc5f:fa01:329d:7179%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 04:29:32 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.co" <lorenzo.pieralisi@arm.co>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 08/10] PCI: layerscape: Add EP mode support for ls1088a
 and ls2088a
Thread-Topic: [PATCH v2 08/10] PCI: layerscape: Add EP mode support for
 ls1088a and ls2088a
Thread-Index: AQHVWN1gKEkcDc/BT0q+LkXHF2Gt76cIzC+AgARekBCAAdvTgIAA6KGg
Date:   Wed, 28 Aug 2019 04:29:32 +0000
Message-ID: <VI1PR04MB3310F78C86F775BB1F5B7E0CF5A30@VI1PR04MB3310.eurprd04.prod.outlook.com>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-8-xiaowei.bao@nxp.com>
 <20190823142756.GI14582@e119886-lin.cambridge.arm.com>
 <AM5PR04MB3299B100D1029E90945CF7DDF5A10@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <20190827133429.GM14582@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190827133429.GM14582@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8818e4c7-7da0-4c42-9336-08d72b705305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4926;
x-ms-traffictypediagnostic: VI1PR04MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4926CC99E73D337DA2139792F5A30@VI1PR04MB4926.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(13464003)(199004)(189003)(76116006)(305945005)(3846002)(6116002)(44832011)(66946007)(66476007)(66556008)(64756008)(74316002)(66446008)(6916009)(4326008)(229853002)(6506007)(53546011)(102836004)(486006)(33656002)(186003)(76176011)(14454004)(71200400001)(71190400001)(25786009)(26005)(8676002)(14444005)(5660300002)(52536014)(316002)(256004)(478600001)(99286004)(86362001)(54906003)(7416002)(7736002)(53936002)(9686003)(81166006)(81156014)(8936002)(2906002)(446003)(6246003)(11346002)(476003)(7696005)(66066001)(6436002)(55016002)(30864003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4926;H:VI1PR04MB3310.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6rigpGTZVRYxWnz4Ass4FN7VnR/dX1q3nQKuTbe6NpMFGsjO7w6VICMfJny0IrXN03HphSuPqAhK7TKitNnGdFhbMfB0coqLsQjV7aFlOn72JQkxW6kPDLjURA1xYTeL2i5QZzeOQBw8FSDre0nj2LjBA2U4Q/40Mkmj0nynZoXC0WqOu9rkNrIc/b5PCPlMJvXInkqrjrKW1GV+nYXG4dQRcbsgy2uLnSlB6Lk5AHXfP9XFeohlbctEyR2KmSW/qmh5G/Wm/fKkBkmEjcB6PIWKX43vwXwkG+fc8LKYuxDctlWivM8cI0DR13ouRweT+CEnbVTmM5cy9irI3hK+tQvqumFXmPgABKIuRcOgQoMEaWleDdSJlD8lXkW+a08zLK3il4Br99PB06NJlm1XWcls3YXte8QElBwpt+fRwMs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8818e4c7-7da0-4c42-9336-08d72b705305
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 04:29:32.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlQGQMWIXlpZteqNIak7wHhzOVd1L7jjm06Dh03BerxOLtW6pY5chd0U/RGa0WWMQujnNsdtq26slB9ZFQtO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8
YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiBTZW50OiAyMDE55bm0OOaciDI35pelIDIxOjM0DQo+
IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gQ2M6IGJoZWxnYWFzQGdv
b2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9uQHRp
LmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvOyBhcm5kQGFybmRiLmRlOyBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLg0KPiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+
OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kNCj4gWmFuZyA8cm95LnphbmdA
bnhwLmNvbT47IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBndXN0YXZvLnBpbWVudGVsQHN5bm9w
c3lzLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOC8xMF0gUENJOiBsYXllcnNjYXBlOiBBZGQgRVAgbW9k
ZSBzdXBwb3J0IGZvcg0KPiBsczEwODhhIGFuZCBsczIwODhhDQo+IA0KPiBPbiBNb24sIEF1ZyAy
NiwgMjAxOSBhdCAwOTo0OTozNUFNICswMDAwLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gPg0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQW5kcmV3IE11
cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiA+ID4gU2VudDogMjAxOeW5tDjmnIgyM+aX
pSAyMjoyOA0KPiA+ID4gVG86IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+
ID4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207DQo+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcu
bGlAbnhwLmNvbT47IGtpc2hvbkB0aS5jb207DQo+ID4gPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y287IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBNLmguDQo+
ID4gPiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1
QG54cC5jb20+OyBSb3kNCj4gPiA+IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBqaW5nb29oYW4x
QGdtYWlsLmNvbTsNCj4gPiA+IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDA4LzEwXSBQQ0k6IGxheWVyc2NhcGU6IEFkZCBFUCBtb2RlIHN1
cHBvcnQNCj4gPiA+IGZvciBsczEwODhhIGFuZCBsczIwODhhDQo+ID4gPg0KPiA+ID4gT24gVGh1
LCBBdWcgMjIsIDIwMTkgYXQgMDc6MjI6NDBQTSArMDgwMCwgWGlhb3dlaSBCYW8gd3JvdGU6DQo+
ID4gPiA+IEFkZCBQQ0llIEVQIG1vZGUgc3VwcG9ydCBmb3IgbHMxMDg4YSBhbmQgbHMyMDg4YSwg
dGhlcmUgYXJlIHNvbWUNCj4gPiA+ID4gZGlmZmVyZW5jZSBiZXR3ZWVuIExTMSBhbmQgTFMyIHBs
YXRmb3JtLCBzbyByZWZhY3RvciB0aGUgY29kZSBvZg0KPiA+ID4gPiB0aGUgRVAgZHJpdmVyLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9A
bnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IHYyOg0KPiA+ID4gPiAgLSBOZXcgbWVjaGFu
aXNtIGZvciBsYXllcnNjYXBlIEVQIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBXYXMgdGhlcmUgYSB2
MSBvZiB0aGlzIHBhdGNoPw0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMgfCA3Ng0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKy0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMo
KyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiA+ID4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCj4gPiA+ID4gaW5kZXgg
N2NhNWZlOC4uMmE2NmYwNyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+ID4gPiA+IEBAIC0yMCwyNyArMjAs
MjkgQEANCj4gPiA+ID4NCj4gPiA+ID4gICNkZWZpbmUgUENJRV9EQkkyX09GRlNFVAkJMHgxMDAw
CS8qIERCSTIgYmFzZSBhZGRyZXNzKi8NCj4gPiA+ID4NCj4gPiA+ID4gLXN0cnVjdCBsc19wY2ll
X2VwIHsNCj4gPiA+ID4gLQlzdHJ1Y3QgZHdfcGNpZQkJKnBjaTsNCj4gPiA+ID4gLQlzdHJ1Y3Qg
cGNpX2VwY19mZWF0dXJlcwkqbHNfZXBjOw0KPiA+ID4gPiArI2RlZmluZSB0b19sc19wY2llX2Vw
KHgpCWRldl9nZXRfZHJ2ZGF0YSgoeCktPmRldikNCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RydWN0
IGxzX3BjaWVfZXBfZHJ2ZGF0YSB7DQo+ID4gPiA+ICsJdTMyCQkJCWZ1bmNfb2Zmc2V0Ow0KPiA+
ID4gPiArCWNvbnN0IHN0cnVjdCBkd19wY2llX2VwX29wcwkqb3BzOw0KPiA+ID4gPiArCWNvbnN0
IHN0cnVjdCBkd19wY2llX29wcwkqZHdfcGNpZV9vcHM7DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0K
PiA+ID4gPiAtI2RlZmluZSB0b19sc19wY2llX2VwKHgpCWRldl9nZXRfZHJ2ZGF0YSgoeCktPmRl
dikNCj4gPiA+ID4gK3N0cnVjdCBsc19wY2llX2VwIHsNCj4gPiA+ID4gKwlzdHJ1Y3QgZHdfcGNp
ZQkJCSpwY2k7DQo+ID4gPiA+ICsJc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMJCSpsc19lcGM7DQo+
ID4gPiA+ICsJY29uc3Qgc3RydWN0IGxzX3BjaWVfZXBfZHJ2ZGF0YSAqZHJ2ZGF0YTsgfTsNCj4g
PiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBpbnQgbHNfcGNpZV9lc3RhYmxpc2hfbGluayhzdHJ1Y3Qg
ZHdfcGNpZSAqcGNpKSAgew0KPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gPiAgfQ0KPiA+ID4g
Pg0KPiA+ID4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBkd19wY2llX29wcyBsc19wY2llX2VwX29w
cyA9IHsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9vcHMgZHdfbHNfcGNp
ZV9lcF9vcHMgPSB7DQo+ID4gPiA+ICAJLnN0YXJ0X2xpbmsgPSBsc19wY2llX2VzdGFibGlzaF9s
aW5rLCAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGxzX3BjaWVfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4gPiA+ID4gLQl7IC5jb21wYXRpYmxlID0g
ImZzbCxscy1wY2llLWVwIix9LA0KPiA+ID4gPiAtCXsgfSwNCj4gPiA+ID4gLX07DQo+ID4gPiA+
IC0NCj4gPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2VwY19mZWF0dXJlcyoNCj4gPiA+
ID4gbHNfcGNpZV9lcF9nZXRfZmVhdHVyZXMoc3RydWN0IGR3X3BjaWVfZXAgKmVwKSAgeyBAQCAt
ODIsMTAgKzg0LDQ0DQo+ID4gPiA+IEBAIHN0YXRpYyBpbnQgbHNfcGNpZV9lcF9yYWlzZV9pcnEo
c3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ID4gPiAgCX0NCj4gPiA+ID4g
IH0NCj4gPiA+ID4NCj4gPiA+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMg
cGNpZV9lcF9vcHMgPSB7DQo+ID4gPiA+ICtzdGF0aWMgdW5zaWduZWQgaW50IGxzX3BjaWVfZXBf
ZnVuY19jb25mX3NlbGVjdChzdHJ1Y3QgZHdfcGNpZV9lcA0KPiAqZXAsDQo+ID4gPiA+ICsJCQkJ
CQl1OCBmdW5jX25vKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBkd19wY2llICpwY2kg
PSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+ID4gPiArCXN0cnVjdCBsc19wY2llX2VwICpw
Y2llID0gdG9fbHNfcGNpZV9lcChwY2kpOw0KPiA+ID4gPiArCXU4IGhlYWRlcl90eXBlOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJaGVhZGVyX3R5cGUgPSBpb3JlYWQ4KHBjaS0+ZGJpX2Jhc2UgKyBQ
Q0lfSEVBREVSX1RZUEUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKGhlYWRlcl90eXBlICYg
KDEgPDwgNykpDQo+ID4gPiA+ICsJCXJldHVybiBwY2llLT5kcnZkYXRhLT5mdW5jX29mZnNldCAq
IGZ1bmNfbm87DQo+ID4gPiA+ICsJZWxzZQ0KPiA+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+DQo+
ID4gPiBJdCBsb29rcyBsaWtlIHRoZXJlIGlzbid0IGEgUENJIGRlZmluZSBmb3IgbXVsdGkgZnVu
Y3Rpb24sIHRoZQ0KPiA+ID4gbmVhcmVzdCBJIGNvdWxkIGZpbmQgd2FzIFBDSV9IRUFERVJfVFlQ
RV9NVUxUSURFVklDRSBpbg0KPiA+ID4gaG90cGx1Zy9pYm1waHAuaC4gQSBjb21tZW50IGFib3Zl
IHRoZSB0ZXN0IG1pZ2h0IGJlIGhlbHBmdWwgdG8gZXhwbGFpbg0KPiB0aGUgdGVzdC4NCj4gPg0K
PiA+IE9LLCBJIHdpbGwgYWRkIGEgY29tbWVudCBhYm92ZSB0aGlzIGNvZGUuDQo+ID4NCj4gPiA+
DQo+ID4gPiBBcyB0aGUgbHNfcGNpZV9lcF9kcnZkYXRhIHN0cnVjdHVyZXMgYXJlIHN0YXRpYywg
dGhlIHVuc2V0DQo+ID4gPiAuZnVuY19vZmZzZXQgd2lsbCBiZSBpbml0aWFsaXNlZCB0byAwLCBz
byB5b3UgY291bGQganVzdCBkcm9wIHRoZSB0ZXN0IGFib3ZlLg0KPiA+DQo+ID4gRHVlIHRvIHRo
ZSBkaWZmZXJlbnQgUENJZSBjb250cm9sbGVyIGhhdmUgZGlmZmVyZW50IHByb3BlcnR5LCBlLmcu
DQo+ID4gUENJZSBjb250cm9sbGVyMSBzdXBwb3J0IG11bHRpcGxlIGZ1bmN0aW9uIGZlYXR1cmUs
IGJ1dCBQQ0llDQo+ID4gY29udHJvbGxlcjIgZG9uJ3Qgc3VwcG9ydCB0aGlzIGZlYXR1cmUsIHNv
IEkgbmVlZCB0byBjaGVjayB3aGljaA0KPiA+IGNvbnRyb2xsZXIgc3VwcG9ydCBpdCBhbmQgcmV0
dXJuIHRoZSBjb3JyZWN0IG9mZnNldCB2YWx1ZSwgYnV0IGVhY2ggYm9hcmQgb25seQ0KPiBoYXZl
IG9uZSBsc19wY2llX2VwX2RydmRhdGEsIF5fXi4NCj4gDQo+IFllcyBidXQgaWYgdGhleSBkb24n
dCBzdXBwb3J0IHRoZSBmZWF0dXJlIHRoZW4gZnVuY19vZmZzZXQgd2lsbCBiZSAwLg0KPiANCj4g
Pg0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIgc29tZXRoaW5nIHRvIHRoZSBlZmZlY3Qgb2YgdGhlIGZv
bGxvd2luZyBtYXkgaGVscCBzcG90DQo+ID4gPiBtaXNjb25maWd1cmF0aW9uOg0KPiA+ID4NCj4g
PiA+IFdBUk5fT04oZnVuY19ubyAmJiAhcGNpZS0+ZHJ2ZGF0YS0+ZnVuY19vZmZzZXQpOyByZXR1
cm4NCj4gPiA+IHBjaWUtPmRydmRhdGEtPmZ1bmNfb2Zmc2V0ICogZnVuY19ubzsNCj4gPiA+DQo+
ID4gPiBUaGUgV0FSTiBpcyBwcm9iYWJseSBxdWl0ZSB1c2VmdWwgYXMgaWYgeW91IGFyZSBhdHRl
bXB0aW5nIHRvIHVzZQ0KPiA+ID4gbm9uLXplcm8gZnVuY3Rpb25zIGFuZCBmdW5jX29mZnNldCBp
c24ndCBzZXQgLSB0aGVuIHRoaW5ncyBtYXkNCj4gPiA+IGFwcGVhciB0byB3b3JrIG5vcm1hbGx5
IGJ1dCBhY3R1YWxseSB3aWxsIGJyZWFrIGhvcnJpYmx5Lg0KPiA+DQo+ID4gQXMgZGlzY3Vzc2lv
biBiZWZvcmUsIEkgdGhpbmsgdGhlIGZ1bmNfb2Zmc2V0IHNob3VsZCBub3QgZGVwZW5kcyBvbg0K
PiA+IHRoZSBmdW5jdGlvbiBudW1iZXIsIGV2ZW4gaWYgb3RoZXIgcGxhdGZvcm1zIG9mIE5YUCBt
YXkgYmUgdXNlIHdyaXRlDQo+ID4gcmVnaXN0ZXJzIHdheSB0byBhY2Nlc3MgdGhlIGRpZmZlcmVu
dCBmdW5jdGlvbiBjb25maWcgc3BhY2UuDQo+IA0KPiBJIGFncmVlIHRoYXQgZnVuY19vZmZzZXQg
aXMgYW4gb3B0aW9uYWwgcGFyYW1ldGVyLiBCdXQgaWYgeW91IGFyZSBhdHRlbXB0aW5nIHRvDQo+
IGRldGVybWluZSB0aGUgb2Zmc2V0IG9mIGEgZnVuY3Rpb24gYW5kIHlvdSBhcmUgZ2l2ZW4gYSBu
b24temVybyBmdW5jdGlvbg0KPiBudW1iZXIgLSB0aGVuIHNvbWV0aGluZyBoYXMgZ29uZSB3cm9u
ZyBpZiBmdW5jX29mZnNldCBpcyAwLg0KDQpJIGhhdmUgdW5kZXJzdG9vZCB5b3UgbWVhbnMsIG1h
eWJlIEkgbmVlZCB0byBzZXQgYSBmbGFnIGluIHRoZSBkcml2ZXJfZGF0YSBzdHJ1Y3QsDQpiZWNh
dXNlIEkgbWF5IGFkZCBvdGhlciBwbGF0Zm9ybSBvZiBOWFAsIHRoZXNlIHBsYXRmb3JtIHVzZSB0
aGUgd3JpdGUgcmVnaXN0ZXIgDQptZXRob2QgdG8gYWNjZXNzIGRpZmZlcmVudCBmdW5jdGlvbiwg
ZS5nLiANCndyaXRlIGZ1bmNfbnVtIHRvIHJlZ2lzdGVyLCB0aGVuIHdlIGNhbiBhY2Nlc3MgdGhp
cyBmdW5jX251bSBjb25maWcgc3BhY2UuDQoNCkkgd2lsbCBtb2RpZnkgdGhlIGNvZGUgbGlrZSB0
aGlzPyBEbyB5b3UgaGF2ZSBiZXR0ZXIgYWR2aWNlPw0KQ2FzZTE6DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCmluZGV4IDAwNGE3ZTguLjhhMGQ2
ZGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2Fw
ZS1lcC5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1l
cC5jDQpAQCAtMjMsNiArMjMsNyBAQA0KICNkZWZpbmUgdG9fbHNfcGNpZV9lcCh4KSAgICAgICBk
ZXZfZ2V0X2RydmRhdGEoKHgpLT5kZXYpDQoNCiBzdHJ1Y3QgbHNfcGNpZV9lcF9kcnZkYXRhIHsN
CisgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jX2NvbmZpZ19mbGFn
Ow0KICAgICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmNfb2Zmc2V0Ow0K
ICAgICAgICBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMgICAgICpvcHM7DQogICAgICAgIGNv
bnN0IHN0cnVjdCBkd19wY2llX29wcyAgICAgICAgKmR3X3BjaWVfb3BzOw0KQEAgLTk3LDggKzk4
LDE0IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbHNfcGNpZV9lcF9mdW5jX2NvbmZfc2VsZWN0KHN0
cnVjdCBkd19wY2llX2VwICplcCwNCiAgICAgICAgICogUmVhZCB0aGUgSGVhZGVyIFR5cGUgcmVn
aXN0ZXIgb2YgY29uZmlnIHNwYWNlIHRvIGNoZWNrDQogICAgICAgICAqIHdoZXRoZXIgdGhpcyBQ
Q0kgZGV2aWNlIHN1cHBvcnQgdGhlIG11bHRpcGxlIGZ1bmN0aW9uLg0KICAgICAgICAgKi8NCi0g
ICAgICAgaWYgKGhlYWRlcl90eXBlICYgKDEgPDwgNykpDQotICAgICAgICAgICAgICAgcmV0dXJu
IHBjaWUtPmRydmRhdGEtPmZ1bmNfb2Zmc2V0ICogZnVuY19ubzsNCisgICAgICAgaWYgKGhlYWRl
cl90eXBlICYgKDEgPDwgNykpIHsNCisgICAgICAgICAgICAgICBpZiAocGNpZS0+ZHJ2ZGF0YS0+
ZnVuY19jb25maWdfZmxhZykgew0KKyAgICAgICAgICAgICAgICAgICAgICAgaW93cml0ZTMyKChm
dW5jX251bSA8PCBuKSwgcGNpLT5kYmlfYmFzZSArIFBDSV9YWFhYX1hYWCk7DQorICAgICAgICAg
ICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAgICAgICAgICAgIFdBUk5fT04oZnVuY19ubyAm
JiAhcGNpZS0+ZHJ2ZGF0YS0+ZnVuY19vZmZzZXQpOw0KKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHBjaWUtPmRydmRhdGEtPmZ1bmNfb2Zmc2V0ICogZnVuY19ubzsNCisgICAgICAgICAg
ICAgICB9DQorICAgICAgIH0NCg0KICAgICAgICByZXR1cm4gMDsNCiB9DQoNCk9mIGNvdXJzZSwg
SSBkb24ndCBuZWVkIHRvIHNldCB0aGUgZmxhZyB0aGlzIHRpbWUsIGJlY2F1c2UgSSBkb24ndCB1
c2UgdGhlIHNlY29uZCBtZXRob2Qod3JpdGUNCnJlZ2lzdGVyIG1ldGhvZCksIHNvIHRoZSBjb2Rl
IGxpa2UgdGhpczoNCmNhc2UyOg0KK3N0YXRpYyB1bnNpZ25lZCBpbnQgbHNfcGNpZV9lcF9mdW5j
X2NvbmZfc2VsZWN0KHN0cnVjdCBkd19wY2llX2VwICplcCwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggZnVuY19ubykgew0KICAgICAgIHN0cnVjdCBk
d19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KICAgICAgIHN0cnVjdCBsc19w
Y2llX2VwICpwY2llID0gdG9fbHNfcGNpZV9lcChwY2kpOw0KICAgICAgIHU4IGhlYWRlcl90eXBl
Ow0KDQoJICAgb2YgY291cnNlLCB0aGlzIGNvZGUgaXMgbm90IHJlcXVpZWQsIGR1ZSB0byB0aGUg
DQoJICAgcGNpZS0+ZHJ2ZGF0YS0+ZnVuY19vZmZzZXQgaXMgMCwgYnV0IEkgdGhpbmsgdGhpcyBp
cyBtb3JlIGNsZWFyDQoJICAgaWYgdXNlIHRoaXMgY29kZS4NCiAgICAgICBoZWFkZXJfdHlwZSA9
IGlvcmVhZDgocGNpLT5kYmlfYmFzZSArIFBDSV9IRUFERVJfVFlQRSk7DQoNCiAgICAgICAvKg0K
ICAgICAgICAqIFJlYWQgdGhlIEhlYWRlciBUeXBlIHJlZ2lzdGVyIG9mIGNvbmZpZyBzcGFjZSB0
byBjaGVjaw0KICAgICAgICAqIHdoZXRoZXIgdGhpcyBQQ0kgZGV2aWNlIHN1cHBvcnQgdGhlIG11
bHRpcGxlIGZ1bmN0aW9uLg0KICAgICAgICAqLw0KICAgICAgIGlmIChoZWFkZXJfdHlwZSAmICgx
IDw8IDcpKSB7DQoJCQkgICBXQVJOX09OKGZ1bmNfbm8gJiYgIXBjaWUtPmRydmRhdGEtPmZ1bmNf
b2Zmc2V0KTsNCiAgICAgICAgICAgICAgIHJldHVybiBwY2llLT5kcnZkYXRhLT5mdW5jX29mZnNl
dCAqIGZ1bmNfbm87IA0KCQl9DQoJCQ0KICAgICAgIHJldHVybiAwOw0KfQ0KDQpPciBsaWtlIHRo
aXM6DQpDYXNlMzoNCitzdGF0aWMgdW5zaWduZWQgaW50IGxzX3BjaWVfZXBfZnVuY19jb25mX3Nl
bGVjdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHU4IGZ1bmNfbm8pIHsNCiAgICAgICBzdHJ1Y3QgZHdfcGNpZSAq
cGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCiAgICAgICBzdHJ1Y3QgbHNfcGNpZV9lcCAq
cGNpZSA9IHRvX2xzX3BjaWVfZXAocGNpKTsNCg0KCSAgIFdBUk5fT04oZnVuY19ubyAmJiAhcGNp
ZS0+ZHJ2ZGF0YS0+ZnVuY19vZmZzZXQpOw0KICAgICAgIHJldHVybiBwY2llLT5kcnZkYXRhLT5m
dW5jX29mZnNldCAqIGZ1bmNfbm87DQoNCn0NCk9mIGNvdXJzZSwgd2UgY2FuIHJldHVybiBhIC0x
IGJ5IGFkanVyaW5nIHRoZSAoZnVuY19ubyAmJiAhcGNpZS0+ZHJ2ZGF0YS0+ZnVuY19vZmZzZXQp
IA0KVmFsdSBpbiBjYXNlMQ0KDQpUaGFua3MgDQpYaWFvd2VpDQoNCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEFuZHJldyBNdXJyYXkNCj4gDQo+ID4NCj4gPiBJIGhhdmUgYWRkZWQgdGhlIGNvbW1lbnRz
IGFib3ZlIHRoZSBjb2RlLCBhcyBmb2xsb3csIGRvIHlvdSBoYXZlIGFueQ0KPiBhZHZpY2U/DQo+
ID4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgbHNfcGNpZV9lcF9mdW5jX2NvbmZfc2VsZWN0KHN0cnVj
dCBkd19wY2llX2VwICplcCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1OCBmdW5jX25vKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZHdfcGNpZSAq
cGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gPiArICAgICAgIHN0cnVjdCBsc19wY2ll
X2VwICpwY2llID0gdG9fbHNfcGNpZV9lcChwY2kpOw0KPiA+ICsgICAgICAgdTggaGVhZGVyX3R5
cGU7DQo+ID4gKw0KPiA+ICsgICAgICAgaGVhZGVyX3R5cGUgPSBpb3JlYWQ4KHBjaS0+ZGJpX2Jh
c2UgKyBQQ0lfSEVBREVSX1RZUEUpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAg
ICAgKiBSZWFkIHRoZSBIZWFkZXIgVHlwZSByZWdpc3RlciBvZiBjb25maWcgc3BhY2UgdG8gY2hl
Y2sNCj4gPiArICAgICAgICAqIHdoZXRoZXIgdGhpcyBQQ0kgZGV2aWNlIHN1cHBvcnQgdGhlIG11
bHRpcGxlIGZ1bmN0aW9uLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoaGVhZGVy
X3R5cGUgJiAoMSA8PCA3KSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHBjaWUtPmRydmRh
dGEtPmZ1bmNfb2Zmc2V0ICogZnVuY19ubzsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsN
Cj4gPiArfQ0KPiA+DQo+ID4gVGhhbmtzIGEgbG90IGZvciB5b3VyIGRldGFpbCBjb21tZW50cy4N
Cj4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+DQo+ID4gPiBBbmRyZXcgTXVycmF5DQo+
ID4gPg0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGR3X3BjaWVfZXBfb3BzIGxzX3BjaWVfZXBfb3BzID0gew0KPiA+ID4gPiAgCS5lcF9pbml0ID0g
bHNfcGNpZV9lcF9pbml0LA0KPiA+ID4gPiAgCS5yYWlzZV9pcnEgPSBsc19wY2llX2VwX3JhaXNl
X2lycSwNCj4gPiA+ID4gIAkuZ2V0X2ZlYXR1cmVzID0gbHNfcGNpZV9lcF9nZXRfZmVhdHVyZXMs
DQo+ID4gPiA+ICsJLmZ1bmNfY29uZl9zZWxlY3QgPSBsc19wY2llX2VwX2Z1bmNfY29uZl9zZWxl
Y3QsIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbHNfcGNpZV9l
cF9kcnZkYXRhIGxzMV9lcF9kcnZkYXRhID0gew0KPiA+ID4gPiArCS5vcHMgPSAmbHNfcGNpZV9l
cF9vcHMsDQo+ID4gPiA+ICsJLmR3X3BjaWVfb3BzID0gJmR3X2xzX3BjaWVfZXBfb3BzLCB9Ow0K
PiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGxzX3BjaWVfZXBfZHJ2ZGF0
YSBsczJfZXBfZHJ2ZGF0YSA9IHsNCj4gPiA+ID4gKwkuZnVuY19vZmZzZXQgPSAweDIwMDAwLA0K
PiA+ID4gPiArCS5vcHMgPSAmbHNfcGNpZV9lcF9vcHMsDQo+ID4gPiA+ICsJLmR3X3BjaWVfb3Bz
ID0gJmR3X2xzX3BjaWVfZXBfb3BzLCB9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBsc19wY2llX2VwX29mX21hdGNoW10gPSB7DQo+ID4gPiA+
ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDQ2YS1wY2llLWVwIiwgLmRhdGEgPSAmbHMxX2Vw
X2RydmRhdGEgfSwNCj4gPiA+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxsczEwODhhLXBjaWUt
ZXAiLCAuZGF0YSA9ICZsczJfZXBfZHJ2ZGF0YSB9LA0KPiA+ID4gPiArCXsgLmNvbXBhdGlibGUg
PSAiZnNsLGxzMjA4OGEtcGNpZS1lcCIsIC5kYXRhID0gJmxzMl9lcF9kcnZkYXRhIH0sDQo+ID4g
PiA+ICsJeyB9LA0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBpbnQgX19p
bml0IGxzX2FkZF9wY2llX2VwKHN0cnVjdCBsc19wY2llX2VwICpwY2llLCBAQA0KPiA+ID4gPiAt
OTgsNw0KPiA+ID4gPiArMTM0LDcgQEAgc3RhdGljIGludCBfX2luaXQgbHNfYWRkX3BjaWVfZXAo
c3RydWN0IGxzX3BjaWVfZXANCj4gPiA+ID4gKypwY2llLA0KPiA+ID4gPiAgCWludCByZXQ7DQo+
ID4gPiA+DQo+ID4gPiA+ICAJZXAgPSAmcGNpLT5lcDsNCj4gPiA+ID4gLQllcC0+b3BzID0gJnBj
aWVfZXBfb3BzOw0KPiA+ID4gPiArCWVwLT5vcHMgPSBwY2llLT5kcnZkYXRhLT5vcHM7DQo+ID4g
PiA+DQo+ID4gPiA+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJ
T1JFU09VUkNFX01FTSwNCj4gPiA+ICJhZGRyX3NwYWNlIik7DQo+ID4gPiA+ICAJaWYgKCFyZXMp
DQo+ID4gPiA+IEBAIC0xMzcsMTQgKzE3MywxMSBAQCBzdGF0aWMgaW50IF9faW5pdCBsc19wY2ll
X2VwX3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiAg
CWlmICghbHNfZXBjKQ0KPiA+ID4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4NCj4gPiA+
ID4gLQlkYmlfYmFzZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwNCj4gSU9S
RVNPVVJDRV9NRU0sDQo+ID4gPiAicmVncyIpOw0KPiA+ID4gPiAtCXBjaS0+ZGJpX2Jhc2UgPSBk
ZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UoZGV2LCBkYmlfYmFzZSk7DQo+ID4gPiA+IC0JaWYg
KElTX0VSUihwY2ktPmRiaV9iYXNlKSkNCj4gPiA+ID4gLQkJcmV0dXJuIFBUUl9FUlIocGNpLT5k
YmlfYmFzZSk7DQo+ID4gPiA+ICsJcGNpZS0+ZHJ2ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KPiA+ID4gPg0KPiA+ID4gPiAtCXBjaS0+ZGJpX2Jhc2UyID0gcGNpLT5kYmlf
YmFzZSArIFBDSUVfREJJMl9PRkZTRVQ7DQo+ID4gPiA+ICAJcGNpLT5kZXYgPSBkZXY7DQo+ID4g
PiA+IC0JcGNpLT5vcHMgPSAmbHNfcGNpZV9lcF9vcHM7DQo+ID4gPiA+ICsJcGNpLT5vcHMgPSBw
Y2llLT5kcnZkYXRhLT5kd19wY2llX29wczsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgCXBjaWUtPnBj
aSA9IHBjaTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlsc19lcGMtPmxpbmt1cF9ub3RpZmllciA9IGZh
bHNlLCBAQCAtMTUyLDYgKzE4NSwxMyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+IF9faW5pdCBsc19w
Y2llX2VwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+DQo+ID4g
PiA+ICAJcGNpZS0+bHNfZXBjID0gbHNfZXBjOw0KPiA+ID4gPg0KPiA+ID4gPiArCWRiaV9iYXNl
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LA0KPiBJT1JFU09VUkNFX01FTSwN
Cj4gPiA+ICJyZWdzIik7DQo+ID4gPiA+ICsJcGNpLT5kYmlfYmFzZSA9IGRldm1fcGNpX3JlbWFw
X2NmZ19yZXNvdXJjZShkZXYsIGRiaV9iYXNlKTsNCj4gPiA+ID4gKwlpZiAoSVNfRVJSKHBjaS0+
ZGJpX2Jhc2UpKQ0KPiA+ID4gPiArCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXBjaS0+ZGJpX2Jhc2UyID0gcGNpLT5kYmlfYmFzZSArIFBDSUVf
REJJMl9PRkZTRVQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBwY2llKTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlyZXQgPSBsc19hZGRfcGNpZV9lcChwY2ll
LCBwZGV2KTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi45LjUNCj4gPiA+ID4NCg==
