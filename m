Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CB426523
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhJHHVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 03:21:24 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:59357
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229693AbhJHHVY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 03:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt1lKcIv/QfCzx/v8LCcfEp3+4AORU0E/VvgZjgGTTlHZO5V+HPQ7IPcN/up6hUbg5ew6ssnR7ji1hIUIvFRTd/V9nCYI4a5+o6KWFgNqxbelGjeuee+DhiQkMAASXjgzuMfANiYWYGVb7rM5kR+mKP3JeDceFPSqq/+hqk0n0JoMKoiRG5Ojw7tsqloIQ/8LUzH+m07bNU0Ecp/XN6Kbg9pVeWdfw4127JavqWoeEwrAHJES55R7QI90feOME/AvAWd8Y1n8epGZ0wOjqhYkQWlJYUtW6aKEavdb+b2Oo2NSSwRxNYP9U9uHacoUUrNrUzJqXKB0JCdAGbxzlRAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWrHrzwTu2cRqFeIE2G46TCAK7JT4Mpvbywu00VAbfM=;
 b=JfyJzYV60HHooUNVyzeR0y5Xgbjq3XeX/rO4xwhUoJaRlcyIzgmECvNCMoW6jQw+jf3ByagPvp5EDlAlssAfmjt+1iekzFlceTZ+jiLofNpR0yw6h9839e9K5aIU/SLuRLUivF7DUS+ZC7j9nnCmHIbeheQj3C9aO4qQh1zyEpxS2tgz/6uVUcbcChTFspcFhih4BJk9XzNZHodelIxExhGRdnS1d/vgMjvnflur2wfk2xtkIUpg3OoadkztkfuWDUe0i2OGsw+B8/mFxZ5zfXh/q2jE9K78B3dDgXEKYscwA4PTrjIa7BN47HX1BcfeC6aKtg6/O/cU61gVNHKaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWrHrzwTu2cRqFeIE2G46TCAK7JT4Mpvbywu00VAbfM=;
 b=dmpzo9o6lAq+djx+hDW4/wEzTO1PId0si6QziF4TL63yD9fR32ZpdQVr10aDI/yMY8clr/h/XTl4TsZCYz/0Y90HmTVrUyW9OVxMELhTz8X65TvGle/ptTwS/6SDgegO1sV7GvZcDVKfGKOFJbH+p9nEyPiQooZd+7g1d/6BFy4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 07:19:27 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::e001:f560:f0f9:a4ac]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::e001:f560:f0f9:a4ac%3]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 07:19:27 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     =?utf-8?B?S3J6eXN6dG9mIEhhxYJhc2E=?= <khalasa@piap.pl>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to
 512 bytes
Thread-Topic: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to
 512 bytes
Thread-Index: AQHXunnM9UtZC3J8eEmRIfr+eUmw56vIqXhw
Date:   Fri, 8 Oct 2021 07:19:26 +0000
Message-ID: <AS8PR04MB86766EED807B963F4D9931E68CB29@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <m3lf36n0d8.fsf@t19.piap.pl>
In-Reply-To: <m3lf36n0d8.fsf@t19.piap.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: piap.pl; dkim=none (message not signed)
 header.d=none;piap.pl; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 174cc832-fcdc-4ca3-decd-08d98a2bf659
x-ms-traffictypediagnostic: AS8PR04MB8481:
x-microsoft-antispam-prvs: <AS8PR04MB8481BF42CA2FAE5DEC079B178CB29@AS8PR04MB8481.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIbJ6TIKszAS4YjPARIWWs6FpUvCw92t5GoRad41lNv1iioSzDiZknQYN6ZNcFggV7YIcYZz5Wf1GethyFY+1e7eT0Mi1BHkjkaEW4dwN7zpj3IaAmoD72OX1nC8is5BD7idt4xeXuILIcHPoL9cClN7eCgA7DCRczxhj5SrVhbUW7+VMRSwnhlO8QYZ3qDUjgk8gRB7ktbiwSEJQUH10FxIqJral8f9crE7n3huK83kNPjEtOoNQVU367g2j+mPUKPJKcw6619S9i52NpvKXbBX/z91ulr+o6ltF7lxHSdbOCJjwISfxGeEP1GfTkGEFPAL9IaHkreamjd2mP9aRH/XNNbiolX42mTvlf1uNhcXz5fRuVWIXuWxB6vUaEOMJd8aRl01+0QzGnjGpRL1haAocI4ZPVUy/b8zpsskI5+WjnhUjJmw9E5mTpkMBkMd8ssw7o+kIBSoCKNzhFJyP6vzS7iDf3diITNeRFE9DIyueUH925uLOu3KpsTPeahTDPnGMaGct5e8ivGOE6HGih9IQon9TC+aOQ1u3kfCtlmHwukKg7lBD5ErtMKNWb5ahojQR60KqxepwcWV0dT1j1XENONkWIA43srl0x7zBTUmhNxANdSxAcHmUYUUxScsQA+icVEYJhAQygqx8awcYQEQ/NC6+jXoWMNvshA7RuP4WL+SChSGFczHU5Fx0UtI8sJ6v2uH/idsUk5uTGh2rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(26005)(66946007)(86362001)(64756008)(66446008)(66476007)(76116006)(7416002)(186003)(66556008)(7696005)(83380400001)(110136005)(5660300002)(33656002)(55016002)(316002)(54906003)(8676002)(122000001)(4326008)(66574015)(38100700002)(71200400001)(9686003)(2906002)(508600001)(53546011)(52536014)(8936002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWZybVQrTlRjd004V1BBY1c0ekUrajRBSTRqQWRmSFVXNUZFYWx1Y2hYcFMz?=
 =?utf-8?B?ekxvTTU2MzVtT0R0NTQzZC9vTVhUVVN6ejhkRHFIWkRsbHBUU2tPTDVoVjc5?=
 =?utf-8?B?RWJLcWNJS0NQUFlEUUpkRGFCVU9BaUdvZzFmQlo5TDR2OFdXKzJCcHIyM01s?=
 =?utf-8?B?SDlCSk5ENnhVVlNaQkhSVVMrano4UnRvTi9DUGJjdWtScGkzM2tTMGNPVW5I?=
 =?utf-8?B?Nk9HMkZUSnEycm9EWEdYcHUvOFhaeVBPdEFZajN5K0lJMWRDNnN0WlZoUElP?=
 =?utf-8?B?WUJDd1NFWG1GVTU3bklyc2tvcHh2ODRCNDlKTlQzNmxoaWpJYjVFZlk5Um9W?=
 =?utf-8?B?V3M1VGliM2VaT3o5ZDRzQmlraUdPOHBGbEtaM1NzcUpUWnQwcy85TVJlUzBh?=
 =?utf-8?B?QTVnTXZJckhFS3JFREk5TFRObHN2MUhlRzcraG80cGRHOVBtN1V6K3dDRm5Q?=
 =?utf-8?B?YlZhd3V0aHZKNDI2RnFhYkczUWNWa2hua1ExMlN3UDZ0NDlrODNWeTdmZXdW?=
 =?utf-8?B?TXVJRGI2THB3N1dBOW45NkxuSWJnUFFEeGx3dUk0WERKZ2hXRi92WjMxekZ4?=
 =?utf-8?B?QzAzWW5HdlJUM1FDSjJKYXlXNFhOM1lPWGhuOVZCSlZ3VmZWTmpLSHpKdVNJ?=
 =?utf-8?B?M1ZUWVlScWF6aUkwejNrOWNTTjJmbFpUcGNXVDNacVRpS2pEVHZqdWx1aG5x?=
 =?utf-8?B?akIyV2xhRlFtSGF5aVVqRFBsSkNnWHFNTGRORFRTd2MzUVozcytFa2RrbUxr?=
 =?utf-8?B?M2RlcXphVXprNUFPUmRDWVRHM3NGVTI1TFBmdXcxUS9iTUxQTkw4SUtKcHVM?=
 =?utf-8?B?T09taFdUb0ZjazdUSVA1NktOcUdoTjgreTV2TXRCYUJ0SlZJNjBiSFplWWgz?=
 =?utf-8?B?S1dVRmNQT2ZLZ2xwM0s1Y1BwTzJCYzJMbmdZK21IUEpQM3VCQlEvcDdHdk5m?=
 =?utf-8?B?NFQydm5xSUh5OVZuL3NiMnc2MWhxYW43bTJHR2hxYXVBTzdiSE10T1FwbjY5?=
 =?utf-8?B?NUtha2ViODdreEI2Ti9yeUs2VEpSbURKRzdGc1dnenJQL0dsMW5hQTFrVS9W?=
 =?utf-8?B?aUhCV0s2SkE5dGdneXNYTWJSbnV4cnpMTnJtY3RkNE5HK0FFU1pFSCtHSy83?=
 =?utf-8?B?TlVJeFFjbldOa29ZR2xJUUdnckxqcEwzYTd3OGY4UEFYUDBaK25WYWZLWGlK?=
 =?utf-8?B?L1M3NFVGRmhwYU9rS3FhRmtwcnJUMGRCYmhXVEpiZ0JlclI3ZnBxaDFkcGp6?=
 =?utf-8?B?ckN2MVVGR3kydHVLWkVsd2VKNTRGZjBsdFVnY1hvdkRYbjRmY0Q4bzBpN3Ix?=
 =?utf-8?B?YllueGlZQTN0YzhuT0diM3ZOOXpDUWRTb2RESU92VkhKTy8rVlM4RDF2Znpa?=
 =?utf-8?B?QXE0V2s0b0Z4RDUwSzZsNHZFbVhXYUwxbFBweDdlSVhlZTlIRmNlU2k4ZWxz?=
 =?utf-8?B?WktEckpHSCtRd3Y5RDhucWs1aGlZeU8wM2FFcURpaEZWRnFTUkZ0Q0tXUHA3?=
 =?utf-8?B?dDlhc0RkL3JIM1VTZWJpOTV0QStZR3k1UkNNUzVqay96WXQ1RmlvQ1REcEYz?=
 =?utf-8?B?MXFyNXJpT00rbW12ZVE2UXlhOTdVUGxhazl3SHlCMmRwWklCN1pQQVRlUmZ2?=
 =?utf-8?B?cW1SQURmTnU1MXhEemVDNHY0VkFzOUFnK2hlUldKZFJmRCs3azNRcmNydXAr?=
 =?utf-8?B?dXVjNlRnYUtWaVg3M2prVXhBSlVWa3FaMXBVNURmY1hRbkVUdHYxOHBHUFYr?=
 =?utf-8?Q?hOTfBid0H8+aZ3E9xU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174cc832-fcdc-4ca3-decd-08d98a2bf659
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 07:19:27.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiQM5C1xudx/c9ks6WqoRGo6AwDzBhG2FnEzCBzYpVZUyyJSGKqiozAlXbEgB9pnlPgCP+hfZnQ0h1tx1qOuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgSGHFgmFzYSA8
a2hhbGFzYUBwaWFwLnBsPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNiwgMjAyMSAyOjE3
IFBNDQo+IFRvOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgQXJ0ZW0gTGFwa2luIDxlbWFpbDJ0ZW1hQGdtYWlsLmNv
bT47IE5laWwNCj4gQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT47IEh1YWNhaSBD
aGVuDQo+IDxjaGVuaHVhY2FpQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IEty
enlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgUmljaGFyZA0KPiBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Ow0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MyBSRVBP
U1RdIFBDSWU6IGxpbWl0IE1heCBSZWFkIFJlcXVlc3QgU2l6ZSBvbiBpLk1YIHRvIDUxMg0KPiBi
eXRlcw0KPiANCj4gRFdDIFBDSWUgY29udHJvbGxlciBpbXBvc2VzIGxpbWl0cyBvbiB0aGUgUmVh
ZCBSZXF1ZXN0IFNpemUgdGhhdCBpdCBjYW4NCj4gaGFuZGxlLiBGb3IgaS5NWDYgZmFtaWx5IGl0
J3MgZml4ZWQgYXQgNTEyIGJ5dGVzIGJ5IGRlZmF1bHQuDQo+IA0KPiBJZiBhIG1lbW9yeSByZWFk
IGxhcmdlciB0aGFuIHRoZSBsaW1pdCBpcyByZXF1ZXN0ZWQsIHRoZSBDUFUgcmVzcG9uZHMgd2l0
aA0KPiBDb21wbGV0ZXIgQWJvcnQgKENBKSAob24gaS5NWDYgVW5zdXBwb3J0ZWQgUmVxdWVzdCAo
VVIpIGlzIHJldHVybmVkDQo+IGluc3RlYWQgZHVlIHRvIGEgZGVzaWduIGVycm9yKS4NCj4gDQo+
IFRoZSBpLk1YNiBkb2N1bWVudGF0aW9uIHN0YXRlcyB0aGF0IHRoZSBsaW1pdCBjYW4gYmUgY2hh
bmdlZCBieSB3cml0aW5nIHRvDQo+IHRoZSBQQ0lFX1BMX01SQ0NSMCByZWdpc3RlciwgaG93ZXZl
ciB0aGVyZSBpcyBhIGZpeGVkIChhbmQNCj4gdW5kb2N1bWVudGVkKSBtYXhpbXVtIChDWF9SRU1P
VEVfUkRfUkVRX1NJWkUgY29uc3RhbnQpLiBUZXN0cw0KPiBpbmRpY2F0ZSB0aGF0IHZhbHVlcyBs
YXJnZXIgdGhhbiA1MTIgYnl0ZXMgZG9uJ3Qgd29yaywgdGhvdWdoLg0KPiANCj4gVGhpcyBwYXRj
aCBtYWtlcyB0aGUgUlRMODExMSB3b3JrIG9uIGkuTVg2Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S3J6eXN6dG9mIEhhxYJhc2EgPGtoYWxhc2FAcGlhcC5wbD4NCltSaWNoYXJkIFpodV0gSSdtIGZp
bmUgd2l0aCB0aGlzIHBhdGNoLiBBY2tlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPi4gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tDQo+
IFdoaWxlIEFUTSBuZWVkZWQgb25seSBvbiBBUk0sIHRoaXMgdmVyc2lvbiBpcyBjb21waWxlZCBp
biBvbiBhbGwgYXJjaHMuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gaW5kZXggODBmYzk4YWNmMDk3Li4yMjUzODBlNzVmZmYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAtMTE0OCw2ICsxMTQ4LDcgQEAgc3RhdGlj
IGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
IAkJaW14Nl9wY2llLT52cGggPSBOVUxMOw0KPiAgCX0NCj4gDQo+ICsJbWF4X3BjaWVfbXJycyA9
IDUxMjsNCj4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpbXg2X3BjaWUpOw0KPiANCj4g
IAlyZXQgPSBpbXg2X3BjaWVfYXR0YWNoX3BkKGRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jIGluZGV4DQo+IGFhY2Y1NzVjMTVjZi4uYWJl
YjQ4YTY0ZWUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KPiArKysgYi9kcml2
ZXJzL3BjaS9wY2kuYw0KPiBAQCAtMTEyLDYgKzExMiw4IEBAIGVudW0gcGNpZV9idXNfY29uZmln
X3R5cGVzIHBjaWVfYnVzX2NvbmZpZyA9DQo+IFBDSUVfQlVTX1BFRVIyUEVFUjsgIGVudW0gcGNp
ZV9idXNfY29uZmlnX3R5cGVzIHBjaWVfYnVzX2NvbmZpZyA9DQo+IFBDSUVfQlVTX0RFRkFVTFQ7
ICAjZW5kaWYNCj4gDQo+ICt1MTYgbWF4X3BjaWVfbXJycyA9IDQwOTY7IC8vIG5vIGxpbWl0DQo+
ICsNCj4gIC8qDQo+ICAgKiBUaGUgZGVmYXVsdCBDTFMgaXMgdXNlZCBpZiBhcmNoIGRpZG4ndCBz
ZXQgQ0xTIGV4cGxpY2l0bHkgYW5kIG5vdA0KPiAgICogYWxsIHBjaSBkZXZpY2VzIGFncmVlIG9u
IHRoZSBzYW1lIHZhbHVlLiAgQXJjaCBjYW4gb3ZlcnJpZGUgZWl0aGVyIEBADQo+IC01ODE2LDYg
KzU4MTgsOSBAQCBpbnQgcGNpZV9zZXRfcmVhZHJxKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBy
cSkNCj4gIAkJCXJxID0gbXBzOw0KPiAgCX0NCj4gDQo+ICsJaWYgKHJxID4gbWF4X3BjaWVfbXJy
cykNCj4gKwkJcnEgPSBtYXhfcGNpZV9tcnJzOw0KPiArDQo+ICAJdiA9IChmZnMocnEpIC0gOCkg
PDwgMTI7DQo+IA0KPiAgCXJldCA9IHBjaWVfY2FwYWJpbGl0eV9jbGVhcl9hbmRfc2V0X3dvcmQo
ZGV2LCBQQ0lfRVhQX0RFVkNUTCwgZGlmZg0KPiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpLmgg
Yi9pbmNsdWRlL2xpbnV4L3BjaS5oIGluZGV4DQo+IDA2ZmYxMTg2YzFlZi4uMmI5NWE4MjA0ODE5
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvcGNpLmgNCj4gQEAgLTk5Niw2ICs5OTYsNyBAQCBlbnVtIHBjaWVfYnVzX2NvbmZpZ190eXBl
cyB7ICB9Ow0KPiANCj4gIGV4dGVybiBlbnVtIHBjaWVfYnVzX2NvbmZpZ190eXBlcyBwY2llX2J1
c19jb25maWc7DQo+ICtleHRlcm4gdTE2IG1heF9wY2llX21ycnM7DQo+IA0KPiAgZXh0ZXJuIHN0
cnVjdCBidXNfdHlwZSBwY2lfYnVzX3R5cGU7DQo+IA0KPiANCj4gLS0NCj4gS3J6eXN6dG9mICJD
aHJpcyIgSGHFgmFzYQ0KPiANCj4gU2llxIcgQmFkYXdjemEgxYF1a2FzaWV3aWN6DQo+IFByemVt
eXPFgm93eSBJbnN0eXR1dCBBdXRvbWF0eWtpIGkgUG9taWFyw7N3IFBJQVAgQWwuIEplcm96b2xp
bXNraWUgMjAyLA0KPiAwMi00ODYgV2Fyc3phd2ENCg==
