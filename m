Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610F2ACB04
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 03:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKJCZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 21:25:45 -0500
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:42886
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbgKJCZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 21:25:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBfmxHNdti+6cssI0c75CZEA+kBF4+2R81hrj54XtSdFbapj81wnTzRk6aPZYiBZHhynGWLXNgu+/9amsdumvjcLSrDNN4OpV37/M/3jOUTS/RF2yfwKkNe0CIlM+IN4DNnf40VMdMVKRRCj4WDjSq7QtwEYrr0vxKSmf/Fll487RF5zG2ba6K8sJ9i9EtET+NnDGDNQyYpe3ns6YpM1O/PgTG9QyHCjKQQlgFWOchdNESysud38quJW7ZXY8s+IJbccUpUvJ3qspXweaUCCEK5MMsfXAMOgPtaa+XNg/X3Y6WZAZcbWSJWQxsCwIuswwTxyO9eprjCD6zWTCPWo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsIssWBEJmaiOz1ix3+KF0t6QS3MD/DulladpG3nM8g=;
 b=jZKUwV4iet6UFPmSrTRwlhw8fifHPu7G57aHdlsNXepbIFLYGqsn1sm1TzacqGU2OX8wXZQk3sM+ma2znkbYCSjYQAwPKe/ll0fZeGrGAh0s1irFRPYf9f6J36X1IHCV2quQxwrB5NyqUIL53olEmB/HBr0y8vgYi2Jk5kB3z79WQUDMuh1bzZ6mwyNwyPVzAwPs5iduw7m8H1VqVFHZm7bjYt5B3mFRGf1EjAIqbNRefrfmZoDIjam6TaqFKfPwlCiSfGZONaqUYVwh+6pTfDmZgnV9RGhLxeM58/wRbbDeDlhOCcA2j6Q3UFvo1atrxvxvx85mv3ea/zY/z/2Udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsIssWBEJmaiOz1ix3+KF0t6QS3MD/DulladpG3nM8g=;
 b=GvYf7CCRNdLUhFiwgu6rzcNx1lh3j0HmfZB3Im7M31NyJZehZKc18qxcoDQcrqwzLdmc2wjm4QYWkEPuQBKMQhKSoV43RvygqySH5+BWSTPILUW1fQMXG5kU+IOZ7ekmxyZNPj+EaSiiTZNy6dI+gsjyzncRK26jx1ce5l6ZJVo=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 02:25:41 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3541.024; Tue, 10 Nov 2020
 02:25:41 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Topic: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Index: AQHWtnmf1Fe2qKyugUaToCGM3cma6am/hnbQgABT4wCAAMJmMA==
Date:   Tue, 10 Nov 2020 02:25:41 +0000
Message-ID: <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200930153519.7282-16-kishon@ti.com>
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
In-Reply-To: <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93779005-415e-4c82-877a-08d8851feb64
x-ms-traffictypediagnostic: VI1PR04MB7071:
x-microsoft-antispam-prvs: <VI1PR04MB7071B435662015109840F28492E90@VI1PR04MB7071.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVX0tShhzXI9JOf+W1Z4YK9TAgL5QhqHwLr2Fpf+O/bOompyKU5RBsBX98ln8o8dzZ0e10HYW3cTfn7RE9j1KDjNOwQsBtfqajHvfClH/sNh4zrKL5vuvVt8I+DzEE6nVYfm1Ngg0W3QG96P6CbhZTpOp2iXJUb9xmyZLtHC3ztSA5jhqKlvWdcORkuE52Khfu86zAiHgRbXkKq/d0wHY++Yq2TPuZqLFDPRFzBwchNyxw9JwfdzA4J0K+FSJz+FW+6KWvII+vz3BMot97/xi71Jib8MQ2hMuJsa7UuWP5LGr8b6hPYsldilsoujjawv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(55016002)(9686003)(76116006)(66946007)(7696005)(7416002)(6506007)(83380400001)(26005)(53546011)(186003)(64756008)(66556008)(2906002)(52536014)(66446008)(5660300002)(66476007)(8936002)(54906003)(478600001)(316002)(8676002)(44832011)(33656002)(4326008)(6916009)(86362001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yaSdp3VcLf6wntND6mEHs7En8imWVjhRY8q6hmZo3VgAgwXq+ekJ3DmFJ5FvTVDnCtaFfBrqCgicYQ0ZEJfJO83RXMWfz0huo1RQB1RagnUID9ZLR9j72WRQkpiHwWitCwsVScMBrIvOGfOhHQif0Peb1kNb3zqNHm/Op4unoO80pG/+Gz9sCSYxL01UnJ2MyrKg1Q3ujxFkay9czZgvTKuIgw4wzlbfBSu/74GLC57YS28MjhQGC+T/G9ru2pa1+L6noz8twBW5ZlbrdF+mNVu0fYLGf4kkrXcjGlpN1kaw94rzkAo5D5qcvj0U3u0GNqV1YZeDDAhiVtPXwBgk4YY5mSMIIon15uRvI0yT56MIwPVh046JQOWda5McIf3SWdjFR74R9tKdJ2F6Cx0Gu266cqlmaTMo5X13y1TFHtaAjKCSArr6vQFQZNOqd+4X4gXYxXt7UXGr52pmskNyv5LVj7d1xVp/xtd3E3xpfA7dTLnmpN1cX5m4J0vdCYZDXD21OVawD1lVaiI6BODwdaP0qsG+WEBxTswzf2OUqAEioxnLRMefaob/UgDk2o7C/lmz3hZ+OzPkvaPFJjFMyKRhSeA3K6Xhswp4QCKpi8E9q6KZn07oZjV49G4SP6rOylBcRlJUih3SAzf9lSVSXxmY/SPa/tsXEblHe6ChPiX4f/Ll+DhZ8eJ31rE3Z51TFfYn6hRqbShePmv3nn3EqbCfzBoDh8wPYS5ZiZeuZkho38eSbpc5OFhvJIaOhcIENpRYmo+pV7+tCcd3cm4AFS2paPuQ0embydfyzP6NLG8oF0XlN55bMrqaeDBqVoe+XoQHufWWo8XaCYf1iJGgYNudGSOTVbaTuQwJYlePYNu8DeJ6J9pd06E+BjXcKs6EikDel5uNhu+XwH7fIo+hqA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93779005-415e-4c82-877a-08d8851feb64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 02:25:41.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /V6C5XCfnwre99pwRJtrRT/SedbuPKlBxgXAvgncN1W4loRFenBIfuVygbn7Vxh2m5y6sD63vjXSeMvviBjc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7071
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTUvMThdIE5UQjogQWRkIHN1
cHBvcnQgZm9yIEVQRiBQQ0ktRXhwcmVzcyBOb24tDQo+IFRyYW5zcGFyZW50IEJyaWRnZQ0KPiAN
Cj4gSGkgU2hlcnJ5LA0KPiANCj4gT24gMDkvMTEvMjAgMzowNyBwbSwgU2hlcnJ5IFN1biB3cm90
ZToNCj4gPiBIaSBLaXNob24sDQo+ID4NCj4gPj4gU3ViamVjdDogW1BBVENIIHY3IDE1LzE4XSBO
VEI6IEFkZCBzdXBwb3J0IGZvciBFUEYgUENJLUV4cHJlc3MgTm9uLQ0KPiA+PiBUcmFuc3BhcmVu
dCBCcmlkZ2UNCj4gPj4NCj4gPj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9u
QHRpLmNvbT4NCj4gPj4NCj4gPj4gQWRkIHN1cHBvcnQgZm9yIEVQRiBQQ0ktRXhwcmVzcyBOb24t
VHJhbnNwYXJlbnQgQnJpZGdlIChOVEIpIGRldmljZS4NCj4gPj4gVGhpcyBkcml2ZXIgaXMgcGxh
dGZvcm0gaW5kZXBlbmRlbnQgYW5kIGNvdWxkIGJlIHVzZWQgYnkgYW55IHBsYXRmb3JtDQo+ID4+
IHdoaWNoIGhhdmUgbXVsdGlwbGUgUENJZSBlbmRwb2ludCBpbnN0YW5jZXMgY29uZmlndXJlZCB1
c2luZyB0aGUgcGNpLWVwZi0NCj4gbnRiIGRyaXZlci4NCj4gPj4gVGhlIGRyaXZlciBjb25ubmVj
dHMgdG8gdGhlIHN0YW5kYXJkIE5UQiBzdWItc3lzdGVtIGludGVyZmFjZS4gVGhlDQo+ID4+IEVQ
RiBOVEIgZGV2aWNlIGhhcyBjb25maWd1cmFibGUgbnVtYmVyIG9mIG1lbW9yeSB3aW5kb3dzIChN
YXggNCksDQo+ID4+IGNvbmZpZ3VyYWJsZSBudW1iZXIgb2YgZG9vcmJlbGwgKE1heCAzMiksIGFu
ZCBjb25maWd1cmFibGUgbnVtYmVyIG9mDQo+ID4+IHNjcmF0Y2gtcGFkIHJlZ2lzdGVycy4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRp
LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL250Yi9ody9LY29uZmlnICAgICAgICAgIHwg
ICAxICsNCj4gPj4gIGRyaXZlcnMvbnRiL2h3L01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0KPiA+
PiAgZHJpdmVycy9udGIvaHcvZXBmL0tjb25maWcgICAgICB8ICAgNiArDQo+ID4+ICBkcml2ZXJz
L250Yi9ody9lcGYvTWFrZWZpbGUgICAgIHwgICAxICsNCj4gPj4gIGRyaXZlcnMvbnRiL2h3L2Vw
Zi9udGJfaHdfZXBmLmMgfCA3NTUNCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4gIDUgZmlsZXMgY2hhbmdlZCwgNzY0IGluc2VydGlvbnMoKykNCj4gPj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL250Yi9ody9lcGYvS2NvbmZpZyAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4+IGRyaXZlcnMvbnRiL2h3L2VwZi9NYWtlZmlsZSAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4+IGRyaXZlcnMvbnRiL2h3L2VwZi9udGJfaHdfZXBmLmMNCj4gPj4NCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnRiL2h3L0tjb25maWcgYi9kcml2ZXJzL250Yi9ody9LY29uZmlnIGlu
ZGV4DQo+ID4+IGU3N2M1ODcwNjBmZi4uYzMyNWJlNTI2YjgwIDEwMDY0NA0KPiA+PiAtLS0gYS9k
cml2ZXJzL250Yi9ody9LY29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvbnRiL2h3L0tjb25maWcN
Cj4gPj4gQEAgLTIsNCArMiw1IEBADQo+ID4+ICBzb3VyY2UgImRyaXZlcnMvbnRiL2h3L2FtZC9L
Y29uZmlnIg0KPiA+PiAgc291cmNlICJkcml2ZXJzL250Yi9ody9pZHQvS2NvbmZpZyINCj4gPj4g
IHNvdXJjZSAiZHJpdmVycy9udGIvaHcvaW50ZWwvS2NvbmZpZyINCj4gPj4gK3NvdXJjZSAiZHJp
dmVycy9udGIvaHcvZXBmL0tjb25maWciDQo+ID4+ICBzb3VyY2UgImRyaXZlcnMvbnRiL2h3L21z
Y2MvS2NvbmZpZyINCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnRiL2h3L01ha2VmaWxlIGIv
ZHJpdmVycy9udGIvaHcvTWFrZWZpbGUgaW5kZXgNCj4gPj4gNDcxNGQ2MjM4ODQ1Li4yMjNjYTU5
MmI1ZjkgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbnRiL2h3L01ha2VmaWxlDQo+ID4+ICsr
KyBiL2RyaXZlcnMvbnRiL2h3L01ha2VmaWxlDQo+ID4+IEBAIC0yLDQgKzIsNSBAQA0KPiA+PiAg
b2JqLSQoQ09ORklHX05UQl9BTUQpCSs9IGFtZC8NCj4gPj4gIG9iai0kKENPTkZJR19OVEJfSURU
KQkrPSBpZHQvDQo+ID4+ICBvYmotJChDT05GSUdfTlRCX0lOVEVMKQkrPSBpbnRlbC8NCj4gPj4g
K29iai0kKENPTkZJR19OVEJfRVBGKQkrPSBlcGYvDQo+ID4+ICBvYmotJChDT05GSUdfTlRCX1NX
SVRDSFRFQykgKz0gbXNjYy8gZGlmZiAtLWdpdA0KPiA+PiBhL2RyaXZlcnMvbnRiL2h3L2VwZi9L
Y29uZmlnIGIvZHJpdmVycy9udGIvaHcvZXBmL0tjb25maWcgbmV3IGZpbGUNCj4gPj4gbW9kZSAx
MDA2NDQgaW5kZXggMDAwMDAwMDAwMDAwLi42MTk3ZDFhYWIzNDQNCj4gPj4gLS0tIC9kZXYvbnVs
bA0KPiA+PiArKysgYi9kcml2ZXJzL250Yi9ody9lcGYvS2NvbmZpZw0KPiA+PiBAQCAtMCwwICsx
LDYgQEANCj4gPj4gK2NvbmZpZyBOVEJfRVBGDQo+ID4+ICsJdHJpc3RhdGUgIkdlbmVyaWMgRVBG
IE5vbi1UcmFuc3BhcmVudCBCcmlkZ2Ugc3VwcG9ydCINCj4gPj4gKwlkZXBlbmRzIG9uIG0NCj4g
Pj4gKwloZWxwDQo+ID4+ICsJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBFUEYgTlRCIG9uIGNvbmZp
Z3VyYWJsZSBlbmRwb2ludC4NCj4gPj4gKwkgIElmIHVuc3VyZSwgc2F5IE4uDQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL250Yi9ody9lcGYvTWFrZWZpbGUNCj4gPj4gYi9kcml2ZXJzL250Yi9o
dy9lcGYvTWFrZWZpbGUgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4gPj4gMDAwMDAwMDAw
MDAwLi4yZjU2MGE0MjJiYzYNCj4gPj4gLS0tIC9kZXYvbnVsbA0KPiA+PiArKysgYi9kcml2ZXJz
L250Yi9ody9lcGYvTWFrZWZpbGUNCj4gPj4gQEAgLTAsMCArMSBAQA0KPiA+PiArb2JqLSQoQ09O
RklHX05UQl9FUEYpICs9IG50Yl9od19lcGYubw0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dGIvaHcvZXBmL250Yl9od19lcGYuYw0KPiA+PiBiL2RyaXZlcnMvbnRiL2h3L2VwZi9udGJfaHdf
ZXBmLmMgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4gPj4gMDAwMDAwMDAwMDAwLi4wYTE0
NDk4Nzg1MWENCj4gPj4gLS0tIC9kZXYvbnVsbA0KPiA+PiArKysgYi9kcml2ZXJzL250Yi9ody9l
cGYvbnRiX2h3X2VwZi5jDQo+ID4+IEBAIC0wLDAgKzEsNzU1IEBADQo+ID4gLi4uLi4uDQo+ID4+
ICtzdGF0aWMgaW50IG50Yl9lcGZfaW5pdF9wY2koc3RydWN0IG50Yl9lcGZfZGV2ICpuZGV2LA0K
PiA+PiArCQkJICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+PiArew0KPiA+PiArCXN0cnVj
dCBkZXZpY2UgKmRldiA9IG5kZXYtPmRldjsNCj4gPj4gKwlpbnQgcmV0Ow0KPiA+PiArDQo+ID4+
ICsJcGNpX3NldF9kcnZkYXRhKHBkZXYsIG5kZXYpOw0KPiA+PiArDQo+ID4+ICsJcmV0ID0gcGNp
X2VuYWJsZV9kZXZpY2UocGRldik7DQo+ID4+ICsJaWYgKHJldCkgew0KPiA+PiArCQlkZXZfZXJy
KGRldiwgIkNhbm5vdCBlbmFibGUgUENJIGRldmljZVxuIik7DQo+ID4+ICsJCWdvdG8gZXJyX3Bj
aV9lbmFibGU7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJcmV0ID0gcGNpX3JlcXVlc3RfcmVn
aW9ucyhwZGV2LCAibnRiIik7DQo+ID4+ICsJaWYgKHJldCkgew0KPiA+PiArCQlkZXZfZXJyKGRl
diwgIkNhbm5vdCBvYnRhaW4gUENJIHJlc291cmNlc1xuIik7DQo+ID4+ICsJCWdvdG8gZXJyX3Bj
aV9yZWdpb25zOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXBjaV9zZXRfbWFzdGVyKHBkZXYp
Ow0KPiA+PiArDQo+ID4+ICsJcmV0ID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChkZXYsIERN
QV9CSVRfTUFTSyg2NCkpOw0KPiA+PiArCWlmIChyZXQpIHsNCj4gPj4gKwkJcmV0ID0gZG1hX3Nl
dF9tYXNrX2FuZF9jb2hlcmVudChkZXYsDQo+ID4+IERNQV9CSVRfTUFTSygzMikpOw0KPiA+PiAr
CQlpZiAocmV0KSB7DQo+ID4+ICsJCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBzZXQgRE1BIG1hc2tc
biIpOw0KPiA+PiArCQkJZ290byBlcnJfZG1hX21hc2s7DQo+ID4+ICsJCX0NCj4gPj4gKwkJZGV2
X3dhcm4oJnBkZXYtPmRldiwgIkNhbm5vdCBETUEgaGlnaG1lbVxuIik7DQo+ID4+ICsJfQ0KPiA+
PiArDQo+ID4+ICsJbmRldi0+Y3RybF9yZWcgPSBwY2lfaW9tYXAocGRldiwgMCwgMCk7DQo+ID4N
Cj4gPiBUaGUgc2Vjb25kIHBhcmFtZXRlciBvZiBwY2lfaW9tYXAgc2hvdWxkIGJlIG5kZXYtPmN0
cmxfcmVnX2JhciBpbnN0ZWFkDQo+IG9mIHRoZSBoYXJkY29kZSB2YWx1ZSAwLCByaWdodD8NCj4g
Pg0KPiA+PiArCWlmICghbmRldi0+Y3RybF9yZWcpIHsNCj4gPj4gKwkJcmV0ID0gLUVJTzsNCj4g
Pj4gKwkJZ290byBlcnJfZG1hX21hc2s7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJbmRldi0+
cGVlcl9zcGFkX3JlZyA9IHBjaV9pb21hcChwZGV2LCAxLCAwKTsNCj4gPg0KPiA+IHBjaV9pb21h
cChwZGV2LCBuZGV2LT5wZWVyX3NwYWRfcmVnX2JhciwgMCk7DQo+ID4NCj4gPj4gKwlpZiAoIW5k
ZXYtPnBlZXJfc3BhZF9yZWcpIHsNCj4gPj4gKwkJcmV0ID0gLUVJTzsNCj4gPj4gKwkJZ290byBl
cnJfZG1hX21hc2s7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJbmRldi0+ZGJfcmVnID0gcGNp
X2lvbWFwKHBkZXYsIDIsIDApOw0KPiA+DQo+ID4gcGNpX2lvbWFwKHBkZXYsIG5kZXYtPmRiX3Jl
Z19iYXIsIDApOw0KPiANCj4gR29vZCBjYXRjaC4gV2lsbCBmaXggaXQgYW5kIHNlbmQuIFRoYW5r
IHlvdSBmb3IgcmV2aWV3aW5nLg0KDQpZb3UncmUgd2VsY29tZS4NCkJ5IHRoZSB3YXksIHNpbmNl
IEkndmUgc3R1ZGllZCBWT1AodmlydGlvIG92ZXIgcGNpZSkgYmVmb3JlLCBhbmQgb25seSByZWNl
bnRseSBsZWFybmVkDQphYm91dCBOVEIgcmVsYXRlZCBjb2RlLiBJIGhhdmUgc29tZSBxdWVzdGlv
bnMgYWJvdXQgTlRCLg0KDQpGb3IgTlRCLCBpbiBvcmRlciB0byBtYWtlIHR3byhvciBtb3JlKSBk
aWZmZXJlbnQgc3lzdGVtcyB0byBjb21tdW5pY2F0ZSB3aXRoIGVhY2ggb3RoZXIsIA0Kc2VlbXMg
YXQgbGVhc3QgdGhyZWUgYm9hcmRzIGFyZSByZXF1aXJlZCh0d28gaG9zdCBib2FyZHMgYW5kIG9u
ZSBib2FyZCB3aXRoIG11bHRpcGxlIEVQDQppbnN0YW5jZXMgYXMgYnJpZGdlKSwgcmlnaHQ/DQpC
dXQgZm9yIFZPUCwgb25seSB0d28gYm9hcmRzIGFyZSBuZWVkZWQob25lIGJvYXJkIGFzIGhvc3Qg
YW5kIG9uZSBib2FyZCBhcyBjYXJkKSB0byByZWFsaXplIHRoZQ0KY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIHRoZSB0d28gc3lzdGVtcywgc28gbXkgcXVlc3Rpb24gaXMgd2hhdCBhcmUgdGhlIGFkdmFu
dGFnZXMgb2YgdXNpbmcgTlRCPyANCkJlY2F1c2UgSSB0aGluayB0aGUgYXJjaGl0ZWN0dXJlIG9m
IE5UQiBzZWVtcyBtb3JlIGNvbXBsaWNhdGVkLiBNYW55IHRoYW5rcyENCg0KQmVzdCByZWdhcmRz
DQpTaGVycnkNCg0KPiANCj4gUmVnYXJkcywNCj4gS2lzaG9uDQo=
