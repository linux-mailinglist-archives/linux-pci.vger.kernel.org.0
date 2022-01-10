Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8341488EE8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 04:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiAJDV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 22:21:56 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:22710
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238350AbiAJDVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Jan 2022 22:21:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eir40jogcHNpCljOg7Pt50Kk0wOgA5Xcc5VKGP2v6s0jNHVwpSn5/EcpC0kTPIvLXU2tiqehmzY90aa3XDiAqDP8rTrrMdaR9nHvFqI7oE01K2qf0ia9Lbte8jdnGt3l4YprTm3lLd0DWqxSub6e531ky1DvNMMEWNw1rrANu96GP7/RHONZdY8UnRsAIz+XJw8aBsQqNVdU0A76UI6WHAQAmDcnKMA4B/Eo+KsQqFg3ZiQqkH7LnYCmOcspYMm8Du6aFNuxmO2R5nEz1ACOac1UQqvGTaE5TIEdo5TOABRcutSThASP7kH3hm+G50hZV9ocQzBlIoEmClLNCtUhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPcMb8qz13CKZRiMWzd5XoVg3UGRSoA3srkYee0t3S4=;
 b=RAd9PG1k5q8pKQTLhVcgiEMEtRtavWR+o3X91jf98MyD4FJSFs4oZC1FlYFZzgLRutvrVva4F/xte32GOCnyNjdkWurTpOWUvRmmPZRnsQOhWAoOwX6Xaha9TTVmjdt3mNp3ix2K0F4SZ9iZ0pm+FJvwh/DB3+Lu3ffNbYFois/8UV8KVIw69btJz47l1jVGy0kVFicZah09gadUPOdvw9cHi0bdaFvif9mu/3gP4dMIsZ27anB3x3groVP3+5nOHKmwLD5btAaRLIKx+t92kCEi4XgPkuLI+hhpS/EWqYXlVlau3+7RnYpYAbkVd5Wge5TJkxRKcrPAAflzwOa7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPcMb8qz13CKZRiMWzd5XoVg3UGRSoA3srkYee0t3S4=;
 b=eowfUj2ae/ASRNCC8sz3k+0xD+G8AiH/du6DU5eLvuWDIhZ7vVR9owmweoEnTB0cXTGAlMMXbGzSUjvorKT+wAc02iYXKyQavfLwxxJNfGaswuJAw5YdYswkvTHqIZ4LMUhFujHBzcZV5n2G4z/6iFwVyhAvhaMSzyTAwDXnDOQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:21:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:21:52 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Thread-Topic: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Thread-Index: AQKNewJSzPE9kU9k33KRUHp3zCSdaarwqs9Q
Date:   Mon, 10 Jan 2022 03:21:52 +0000
Message-ID: <AS8PR04MB867669DBA13715863F0B80F68C509@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211226074019.2556-1-jszhang@kernel.org>
In-Reply-To: <20211226074019.2556-1-jszhang@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64cc9299-9a5c-4f32-7618-08d9d3e858fc
x-ms-traffictypediagnostic: AS8PR04MB8449:EE_
x-microsoft-antispam-prvs: <AS8PR04MB84498AF531EF4B16F54B73988C509@AS8PR04MB8449.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XO1yBzm0APbcQmUyxSMB1aA3LFOQDgLsR+PQ+vkgqNScJFkk6YsM69xw2+mnw9j3MuheWxHNreITWBRStUI2TZsThXIP3qpWPLyEn0r5pgFyBu2capZJMR7qX+B3rAEIL4GUVTFdgwpSpRRxf4i0Z+LT/3AMV7qrTal2YJIpN3njh8PWQXz3+8MMJAVGqCPzgC3Rg2BUcdP8KBh22juW4kFX2Q0ugfL25aCXL+tgY9t0Lomun6eSEUUyxyjd+I894RX0QaEHZfkp9E5S/p9vOYeweGB8eLDSP2td4vRrvq24eVNTjhIMm5Via67DOmtIoguccf+SJyWGG9fC6KEnKCX4E3BkfiRwY0DsnKIMvc1T9g5rWHlVqxEJh8gk9SwjeYbHR4NVRD9jMjsbb0wL9fLWkouraDLOehlrlHfvcRaOnZ5eQiTcMOAADLU0m5OJ3p+EokuLAQPqledS2AjVveMrbnOBPXSQ9qjqFSFrLimHFbJQERD92EczEoJg4+AjKwk9CU6GgcypSIDHv0DKHN3YskPuczD/GGk9JAmXTkWEf9p/HU0pVd9VopllElr1Z7Y0tLNDYKZN+eE5SnSRMosU4Ho9VIYKXQ9o6RKRpmYSiVHSU/smieNRyL+09LP09jXPTOsr9+Vv28li2JfoLTrAUTTcpqUtblz0QXgw6VebVO1NOTcKsu9VvhpyYIR/UPJoPn/eiRkNsRVpzElcnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(110136005)(38070700005)(9686003)(86362001)(508600001)(66574015)(8676002)(52536014)(8936002)(4326008)(66556008)(54906003)(44832011)(53546011)(2906002)(6506007)(83380400001)(316002)(71200400001)(7696005)(55016003)(122000001)(33656002)(38100700002)(66946007)(76116006)(64756008)(66446008)(66476007)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RaY2E0TzJMMEpHUnk4TDUxMkN5N0lWUFdObDlld2NiMUxTOEt1OSsvOWp0?=
 =?utf-8?B?V3cyYllFako3d01Dd2IwamNmaVNyTlZVbGl5QkxBYTM2N0tDdWF5TFBVMGtw?=
 =?utf-8?B?OUN0cHlNWksyV1BMYXVMNFY5a0J0aFNXYWRRVVhqWU8xUCs1NzJsMVFUVXVI?=
 =?utf-8?B?N0trbWh5elFTaXM4N25kcEk2YVpVQTVuNXdZdXNiLzFyb2xQRUJoTjc1VFRH?=
 =?utf-8?B?eFg1RlNYbkM4SU9aQzdIZk5QNUF3UCtiK2NrSnhYMWNpemxuaHhEQ0NyZUI5?=
 =?utf-8?B?U2pDMWF5OXJXVXF4cW9JU05DTVZjbnVna2VzdVdFTDh0cjBWc3hIQkx2OC9V?=
 =?utf-8?B?VjJISEtIcVJEQVFYbXBoK3U5MFo3VW1VMk1KK0w5Q0pWZUlSWGgwSFJZcC9h?=
 =?utf-8?B?N3U2Q2Z3REw4U3N2bE1UMXlOZlEwU3A5eVNlRFdXMGgxNkMydmhIby9ibTQ0?=
 =?utf-8?B?bU05KzBnR1BLYnBlWXFmc0p4ZDN4S2ZtbGFsK2dMc1VnWFQwUTY4Q2hBNWFk?=
 =?utf-8?B?bkdLYm5tR2RBRkthenN3ZURDdisxeWsvaE0wdnc2dHZUN1RqUEIvWW9hV08r?=
 =?utf-8?B?dmFKZUhKZkxDVlhMWjFHemlZc3NyQ3BYYUVQNmZQYzgyVDdGUVRDM1c5RS9m?=
 =?utf-8?B?SGJtczIwRlljMnZ1dXZTc3N0a1NQUXMzN2t3UkhBWHdsRjdhcjArV2tjb0Js?=
 =?utf-8?B?V1NOUDNqQm9PVkVWYlZOR1RVbXdlUFkxMjI0eHlBZnRHK3NQYnZTT09uZ09N?=
 =?utf-8?B?Z1QyZ2dQZFlVN3krUy9BMHB4dzFqNGZFZEhwT1VTMEc3VlpIa1JCTFJEU01V?=
 =?utf-8?B?eVJxRTJlbUlYdnhTUkFuR0VaYVRHZjMzNHNuU1ZEbXZTbXdTNEhBUTJqaEZv?=
 =?utf-8?B?K2wrVm4xdGlPUURodXFaeDd6R1pCRyswcWhkZzIwL2Y1eE9DSUtqb2RnOWlL?=
 =?utf-8?B?cW5LMmtvaGJNWkJualp1cG45RlU4N1ZSQjIydW1GcjZYOHowcHRUTVlVajVP?=
 =?utf-8?B?cisyQnZCQjhBWi9ib1VGNElvMTNMaFp2RmRIekNZUEFLTG12K09YNXVHa0hX?=
 =?utf-8?B?Z3F6ZnBpNk1CVkFNQWtFQm9wbzcwZm1XNER4RGlNMkF5aVR3KzNCa2Y3Sld0?=
 =?utf-8?B?bTlVRjlBaDdzakdrSlBrUUhoT0VkSzEyaHd1VlN6dUt2M2JNV3R1NHFhVGVk?=
 =?utf-8?B?SWs3ZndwbkMvYWNDclZOeXladlpJcVlPUnRqLzhtclBOMS95VTU3dHVHUG45?=
 =?utf-8?B?MDlubitsb3hVeW92enlaN3h5N2dUT2VrUTN3S28zc3NmTWN4NGhnemxUWEQ3?=
 =?utf-8?B?Z1Jwc3YxdzZJSmNvV2xVU3NTRTN4dWpldFBiSUlHN2VyM3pLM3NzUnd6WGhl?=
 =?utf-8?B?c1I1SlZocTZQM1J6TnZHdUlQalF3UkM5M1ZyVm55WG9Ya1lyK1NCN2dQLzRl?=
 =?utf-8?B?VlFsT2g1eWhhc2ZRdjluYnFSUVE4SVVlM2xZRTh5UDNoUWM4Yy9WWDBjT0wz?=
 =?utf-8?B?cmxHZy9qVU82azJ2UGRwS1lwSFROTUNWRFBIbWVVaWx1bWxYeCtDZmFheVpx?=
 =?utf-8?B?WTNEUHdWYjZNOWJuUFdlZGJ6TDlVb0ZKSGFBSU0zUGhpU1dyYkVhUnh3VDJr?=
 =?utf-8?B?anN0cyt1V25KeHVuMmJsdXhkY1kxeXN0QWJOQWtkY1dxa1l2UXQrZXpjT24v?=
 =?utf-8?B?YkcxRUdwdjBsK2tPUW9kR3loWnByajA0cDI1SVgrYXRPR2IrSFBPQjcwOG54?=
 =?utf-8?B?YUZxQVJQSjdENHJFMlpFRHRwdDFjT20rbTRWYU85TytwbFkwTEZHOGp5MWlQ?=
 =?utf-8?B?dE5JY3lhNHNFbU82VG9UYlIyOFQ3ZXdjcEtveVdveTZOSGFVdTlEYUtkWUVo?=
 =?utf-8?B?OXJqODMxdGhnbTR1UStGd1R5MjdXb1hzSjlIWmNvRzVFMzMrbENCU09lUkFC?=
 =?utf-8?B?amRGY2pKd3c0YU5sdFNjbDl0d3VXQ0RuQzRucFRDeWl1QVFzcTJwWFp2bjFO?=
 =?utf-8?B?cWJRSzFGOFZTS0VZdGZWdnJlUmJoNi96Q0FKak5KWThycVJPaXlhK2puZ1hr?=
 =?utf-8?B?VnZyODl6ZzdJemNyQWhGaDFsTy9KRnlnQ1ZWbWlYWUdNa2I2VW5sSEcvU0Vi?=
 =?utf-8?B?c0pQZWpIa0U1TUh5VVBKdklNZnJNaE1DWVQ1OFR5YmVRd0FsZmVMMDBuMnVz?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cc9299-9a5c-4f32-7618-08d9d3e858fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 03:21:52.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzrByof0+6Wjg0bK8oqqj76MXwz99qYnIg+9i0ukUPe9Qw5t51Ng+C6eTs28WEMWUbai0FIRzLcfBFrHKajflQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaXNoZW5nIFpoYW5nIDxqc3po
YW5nQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMjYsIDIwMjEgMzo0MCBQ
TQ0KPiBUbzogSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5jb20+OyBHdXN0YXZvIFBpbWVu
dGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IExvcmVuem8gUGllcmFsaXNp
DQo+IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz47IEtyenlzenRvZg0KPiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBQQ0k6
IGR3YzogRml4IGludGVncmF0ZWQgTVNJIFJlY2VpdmVyIG1hc2sgcmVnIHNldHRpbmcNCj4gZHVy
aW5nIHJlc3VtZQ0KPiANCj4gSWYgdGhlIGhvc3Qgd2hpY2ggbWFrZXMgdXNlIG9mIHRoZSBJUCdz
IGludGVncmF0ZWQgTVNJIFJlY2VpdmVyIGxvc3RzDQo+IHBvd2VyIGR1cmluZyBzdXNwZW5kLCB3
ZSBjYWxsIGR3X3BjaWVfc2V0dXBfcmMoKSB0byByZWluaXQgdGhlIFJDLiBCdXQNCj4gZHdfcGNp
ZV9zZXR1cF9yYygpIGFsd2F5cyBzZXQgdGhlIHBwLT5pcnFfbWFza1tjdHJsXSBhcyB+MCwgc28g
dGhlIG1hc2sNCj4gcmVnaXN0ZXIgaXMgYWx3YXlzIHNldCBhcyAweGZmZmZmZmZmIGluY29ycmVj
dGx5LCB0aHVzIHRoZSBNU0kgY2FuJ3Qgd29yayBhZnRlcg0KPiByZXN1bWUuDQo+IA0KPiBGaXgg
dGhpcyBpc3N1ZSBieSBtb3ZpbmcgcHAtPmlycV9tYXNrW2N0cmxdIGluaXRpYWxpemF0aW9uIHRv
DQo+IGR3X3BjaWVfaG9zdF9pbml0KCksIHNvIHdlIGNhbiBjb3JyZWN0bHkgc2V0IHRoZSBtYXNr
IHJlZyBkdXJpbmcgYm90aA0KPiBib290IGFuZCByZXN1bWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKaXNoZW5nIFpoYW5nIDxqc3poYW5nQGtlcm5lbC5vcmc+DQpbUmljaGFyZCBaaHVdIFRlc3Rl
ZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KVGhhbmtzLg0KDQpCZXN0
IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgNyArKysrKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gaW5kZXggZjQ3
NTVmM2EwM2JlLi4yZmE4NmYzMmQ5NjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiBAQCAtMzYyLDYgKzM2MiwxMiBA
QCBpbnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IHBjaWVfcG9ydCAqcHApDQo+ICAJCQlpZiAo
cmV0IDwgMCkNCj4gIAkJCQlyZXR1cm4gcmV0Ow0KPiAgCQl9IGVsc2UgaWYgKHBwLT5oYXNfbXNp
X2N0cmwpIHsNCj4gKwkJCXUzMiBjdHJsLCBudW1fY3RybHM7DQo+ICsNCj4gKwkJCW51bV9jdHJs
cyA9IHBwLT5udW1fdmVjdG9ycyAvDQo+IE1BWF9NU0lfSVJRU19QRVJfQ1RSTDsNCj4gKwkJCWZv
ciAoY3RybCA9IDA7IGN0cmwgPCBudW1fY3RybHM7IGN0cmwrKykNCj4gKwkJCQlwcC0+aXJxX21h
c2tbY3RybF0gPSB+MDsNCj4gKw0KPiAgCQkJaWYgKCFwcC0+bXNpX2lycSkgew0KPiAgCQkJCXBw
LT5tc2lfaXJxID0NCj4gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgIm1z
aSIpOw0KPiAgCQkJCWlmIChwcC0+bXNpX2lycSA8IDApIHsNCj4gQEAgLTU0MSw3ICs1NDcsNiBA
QCB2b2lkIGR3X3BjaWVfc2V0dXBfcmMoc3RydWN0IHBjaWVfcG9ydCAqcHApDQo+IA0KPiAgCQkv
KiBJbml0aWFsaXplIElSUSBTdGF0dXMgYXJyYXkgKi8NCj4gIAkJZm9yIChjdHJsID0gMDsgY3Ry
bCA8IG51bV9jdHJsczsgY3RybCsrKSB7DQo+IC0JCQlwcC0+aXJxX21hc2tbY3RybF0gPSB+MDsN
Cj4gIAkJCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfTVNJX0lOVFIwX01BU0sgKw0KPiAg
CQkJCQkgICAgKGN0cmwgKiBNU0lfUkVHX0NUUkxfQkxPQ0tfU0laRSksDQo+ICAJCQkJCSAgICBw
cC0+aXJxX21hc2tbY3RybF0pOw0KPiAtLQ0KPiAyLjM0LjENCg==
