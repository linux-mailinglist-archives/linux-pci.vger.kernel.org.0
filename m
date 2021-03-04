Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEE32D97F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 19:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhCDSf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 13:35:58 -0500
Received: from mail-db8eur05on2132.outbound.protection.outlook.com ([40.107.20.132]:33622
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231604AbhCDSf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 13:35:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMDWVgKG/uFibNj3/9Lfh6xZs54wb7K0v1TngoDyWLudUoSNf6azmTjWVCUJq/3DVDu/VOwJaAQQgLmr1UJL9vH7mKL5tvbtzux3NyuslwK+XqnlJRoYB4cHi1Yo35SLv5AOQfo9iiE7vcVL1bMdB9GrxUgSwCcFT3b8L+tG9NX2i8uqk7B8GGCHgz9PL0DJqnnDOelIiq5sMVdLBV/zTenb/ZhrQywa3Y4kudejOH7jbM/UoGdqdGFcAAdyruOnXvfRse18DqaY7q/CJAEbXuSizIdds0MAVHQplLcoagIOEOjcYFvx6ysZbDw0/QpLcFQsmo//TEA2Gm9k5L55tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJwGaYUVWRa1wiOq4VbZMNozOfZpt4K+yV8HcDGCpWo=;
 b=U0BOh2iauyAQ6V+dn4YQAH/XZXukajrZzXd8Vuk0/1RhaYeAqA+L8cbCS0WL7mBack37GowsiMqjh2n64/cSOTglZNHN5mKhF6AVuT/lIAfajeLYhu61d/wpfn/1TQhpWEnRlJhhZLy2lvt+yELXvvWHEd6YPd/ejUmG2jMHqVC2bTDtUYBsoRgqbwFFYpIReBLIeb/rgXdQXKmMlgHgyPee0UbOUupLC55v0g45GLGYsf3DqaR17FgXuVA057cuFaX500EOv7d8+0BmwcP87cP7Sq2r5jE6ni615tHhpwF/LQ+uEGQlBw9WJerDbTVHF+Qb520E6MgqpU/NJIvkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJwGaYUVWRa1wiOq4VbZMNozOfZpt4K+yV8HcDGCpWo=;
 b=m8WHr9H2EaYVPJ57RpC9MLK51/03/JwKspduIYtY9+rjcC21K2AjNva7gh90WwlfpdOrilunIbswQGR0Fm65z5iIck+d3TOVKIwn9UEDvitdEzoN8KYWgILD9KXhLC5D5KckkUkXwenoT9nE3p8oObhc1vlzdWbA6hmyW7cPlk4=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM9PR03MB6772.eurprd03.prod.outlook.com (2603:10a6:20b:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 18:34:42 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::54a9:5d4b:375a:be35]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::54a9:5d4b:375a:be35%6]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 18:34:42 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible Bug on Xgene PCIe Driver
Thread-Topic: Possible Bug on Xgene PCIe Driver
Thread-Index: AQHXEHLskWRUNgvJ7U+bHazaVRt+XKp0KTWA
Date:   Thu, 4 Mar 2021 18:34:42 +0000
Message-ID: <267e17b48256913a377bf8057fa3f4c6890478f5.camel@esd.eu>
References: <CAPOPQMD7qYCaNWsznoTH1fr+Xy1QKjfMBhpA4y4RByDpnOFWnw@mail.gmail.com>
In-Reply-To: <CAPOPQMD7qYCaNWsznoTH1fr+Xy1QKjfMBhpA4y4RByDpnOFWnw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=esd.eu;
x-originating-ip: [217.86.141.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5091cd9c-28dc-4d8f-a2bd-08d8df3c2d3e
x-ms-traffictypediagnostic: AM9PR03MB6772:
x-microsoft-antispam-prvs: <AM9PR03MB67725619D0B9BDF1558E10D481979@AM9PR03MB6772.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BTkXnY3wfxq4hCrY5Sgi9vI4xJSxMi1ltHa67FPUAbolkPKe3AIgLnyfZbMCr555EHt3c7WyNbpwn7oAcX6jDPSKJRFLADVH1Zaoege/HtPluU9ufAQ5gJOEqXEant9gOtQmTZfM18Rl7UfR7kRzhJ8vMp7Q5KuA84mV7Y8cJO5na1jMuoUDiNPQwvKLqYsuwRlQfJwNUqdGXDhjfv+NnCVQ1+XXLOOKmJcitKxbSrWQgUM3+Q0qs/vvNtIOzZYgAViHyiOoWBMtehpq3aOe4sLODjO9As9lHERIXPxjkRXijsL5RNZCSWsNgOR3z9htjpQclctN7zip4D/pj2ucxXQDhUSlfLT/HxiOHuGkkpXXgWGSsweVIny+c9pBVkfkIarb3+Fna1UiKsDDVOquAFycefYVE1jffQGmkQk+bECDxpDTqB5v9XRd1tVyu8miv8ZDrQKWF7954RJ6VhPLWJ3wKYmJ3QNMB8N/jTdkoYPyemm0n3+X6BmtZviSyoKKQN5L9/0wNmZD/M8BHlNJySBv+8ILNj8geQysk8LnRr79Td8kygfJEYQw1Qctt0S+Wj7KYM5Rg0Lv6MBYyYzr5/qhIk9TaGkGhj4iZRoOJT1WPFbeF+7RdT1tulbf+02/LbCEmH8fekWmnpke//3aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39830400003)(396003)(366004)(66946007)(66476007)(6486002)(66446008)(66556008)(64756008)(186003)(2616005)(6916009)(6506007)(6512007)(478600001)(85202003)(76116006)(316002)(966005)(5660300002)(85182001)(71200400001)(83380400001)(26005)(36756003)(86362001)(2906002)(8936002)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YnQrUGtwNFFlL1J1dFlhV1hoYlRzR1VrQ2ZzQzhYaVBlRHlOVVF4MEg1M2NI?=
 =?utf-8?B?YWRBWUt1cDFFaWNpa01sbERZenVacVJqNEV6MmVDL1REVCtmRUwzN1kyUnRV?=
 =?utf-8?B?ZUhGcm5oSWd6VTBSbEFEL0V1aDJEblp2Nm4rMTZXV3pEYXIzOGNIYjdTZk9i?=
 =?utf-8?B?VktqWGxNdkRLMnZtVEVoY0E1VUhvZUl5eTNzSHI1UkZrWGlXb3pOcThVdzM3?=
 =?utf-8?B?TlR1Y2Y3U3I1TjN4Y0gzVmNBQ2pNVjZ6Q0ltcEh1ZU1kcG5WRzR6b0ZkUkV0?=
 =?utf-8?B?cUNKM25GZUk5TE9DSk9DVW9KN2RVRXNCV1Zya3NjVDVvTG9zZWg5Slh1bWRS?=
 =?utf-8?B?dUtzNjl3V2tTbUtwczdiWFJweDVicWRKanlHNFlnN0wyUG5ram9CdXU4alRq?=
 =?utf-8?B?VUtjUytDVW1CSHh6NVM4Y1JSR0VXcXNuMEs1ZlFmUG5qOEU4aEY3YXhJWndn?=
 =?utf-8?B?VGN3YUlZUlJ3MHU5dVJuMHZkSHdGM0JtcUUweFh1cVI3eXhxbVd6OVNJNVVo?=
 =?utf-8?B?dkdTcy9Bd2VuYndyZDNOWjZFM1NKMDlsS1A2ejdOUGdnZCtqUVFtN3N4RnpT?=
 =?utf-8?B?ODd2OFZkT3JFWStXRWZqaGlrT2M0RmpqZ2NqYThiTzBMVmN3SVBuRDVRbGZl?=
 =?utf-8?B?c003Qi9SVnV4cEVpdWpZKzZ6Uy9GYytFeUE4QXc4Vkpldk9OdTVDMjgvaWtF?=
 =?utf-8?B?ZzlzVlJWZ1JIdkJRQmIyWVpZeW1Xb2VYOHV5NHMreXFCdFIxcUZhUTFrRDZD?=
 =?utf-8?B?aE5kZG5ERlU2Q2ZYWDErQ0JCVUlLZXVwMjd6OTF5SmoyWEtYZWpQVHJTS2gz?=
 =?utf-8?B?V01nMSsvVHRZVUIySm9mcXJzZDRFL1RQL3Z0Nlg1Yk1NY1dJT1NVdjBZeWRX?=
 =?utf-8?B?L1JXRDBOd3ZBNDRJZ2w1V2RlYndnUUxtYzZTWHFXYkJmNzRBbFVLWjBEc3Aw?=
 =?utf-8?B?Ym5nTEswbXJpd1hlTFNqSDJoWEU3dVVaWk9ZN3lEeG5TMWNlSWJ0UGtlSkdy?=
 =?utf-8?B?WlhiMi83TkhJZUtPVHprV3NjYXAyYkJjMVR3NloyRVlYWUUzOTNYU0ZhYzlt?=
 =?utf-8?B?clN5cGxVVmt0NTFCQmtxUERQRndSc3hDZEZXTVFzUTEvd1pjbkE3YW1udFEv?=
 =?utf-8?B?b3Z1MERQaGRzQjZ0anllYjZrRElRV0c1VUQ5eFM4RVRsZjBsUXBXMVQ2S3l2?=
 =?utf-8?B?aGd5Y1lIdWtlcGFDMGpIVWM2YTZxeUcvQlluTFJ5WDNFZ05HaDV5bVN2RWVa?=
 =?utf-8?B?ckJzS2dvSjdBRVhUb1hGeFBFOERTWlJ6VlNqSU1QUUVtOHZzc3cwcDdqWHBv?=
 =?utf-8?B?Z1hxaFhyTWdjU3EzcG1uYXdhT2VIZmFCQ1N3SHdMckFLMGNmd1ZvYTFtZWtG?=
 =?utf-8?B?bU56WTIzRTFiNktBbnFHeTNVU1laaEdueWpUM0UvQkZLSFVhREdESFNxcXdx?=
 =?utf-8?B?S2lmc1ZvNzcwcG81b1ZvZEFIb2w0YThtU0lXdDhac01ZWVNJNjhoRUdHb0hh?=
 =?utf-8?B?RVJSK3lTM0Q1RWdXQjZOWnNoMkpsTmlod2FpV3RKdDN6U0Nmbng5cmNlbmJU?=
 =?utf-8?Q?KrbaEzh24Y0e669x0v5k+NZtKmxHLIF8i1ywUBC05gH4yS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <63F8001B0BCCCB4085A568B72224A87D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5091cd9c-28dc-4d8f-a2bd-08d8df3c2d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 18:34:42.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXf5QXX26rI0Glm/JEJxw5BiTSlHwhpqIUW2dbkpgd/tmNQwgEKqd8MaMu0UFIMRRWsMaHDl5+2ClUhhP5rxjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6772
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbiAwMi4wMy4yMDIxLCAyMjo1MSAtMDUwMCBzY2hyaWViIFh1aGVuZyBM
aToNCj4gSGksDQo+IA0KPiBXZSBhcmUgdXNpbmcgTGludXggNS4xMCBvbiBhIEhQRSBQcm9saWFu
dCBtNDAwIG1hY2hpbmUgd2l0aCBhbiBYR2VuZQ0KPiBQQ0llIGJyaWRnZS4gVGhlIG1hY2hpbmUg
d29ya3Mgd2VsbCBvbiBzb21lIGVhcmxpZXIgdmVyc2lvbnMgbGlrZSA1LjQNCj4gYnV0IGZhaWxz
IHRvIHNldCB1cCB0aGUgUENJZSBicmlkZ2Ugb24gNS4xMC4NCj4gDQo+IFJ1bm5pbmcgYGxzY3Bp
YCBvbiA1LjQgc2hvd3M6DQo+IDAwOjAwLjAgUENJIGJyaWRnZTogQXBwbGllZCBNaWNybyBDaXJj
dWl0cyBDb3JwLiBYLUdlbmUgUENJZSBicmlkZ2UgKHJldiAwNCkNCj4gMDE6MDAuMCBFdGhlcm5l
dCBjb250cm9sbGVyOiBNZWxsYW5veCBUZWNobm9sb2dpZXMgTVQyNzUyMCBGYW1pbHkNCj4gW0Nv
bm5lY3RYLTMgUHJvXQ0KPiANCj4gd2hpbGUgb24gNS4xMCBpdCBzaG93cyBub3RoaW5nLg0KPiAN
Cj4gVGhlIGVhcmxpZXN0IGNvbW1pdCB3ZSBmb3VuZCB0aGF0IGNhdXNlcyB0aGUgYnVnIGlzDQo+
IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjAwNjAyMTcxNjAxLjE3NjMw
LTEtemhlbmdkZWppbjVAZ21haWwuY29tLw0KPiB3aGljaCBjaGFuZ2VzIHRoZSBmaWxlIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpLXhnZW5lLmMgYnkgd3JhcHBpbmcNCj4gdGhlIGNhbGwgb2Yg
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSBpbnRvDQo+IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZV9ieW5hbWUuDQo+IA0KPiBCeSByZXZlcnRpbmcgdGhlIGNoYW5nZSwgdGhlIFBD
SWUgYnJpZGdlIHdvcmtzIG5vdy4gV2UgYXJlIGN1cmlvdXMgd2h5DQo+IHRoaXMgcGF0Y2ggY2Fu
IGNhdXNlIHRoZSBpc3N1ZS4NCj4gDQo+IEFkZGl0aW9uYWxseSwgdGhpcyBidWcgc3RpbGwgZXhp
c3RzIG9uIDUuMTAuMTkgYW5kIHJldmVydGluZyB0aGUgYWJvdmUNCj4gcGF0Y2ggYWxzbyBmaXhl
ZCB0aGUgaXNzdWUuDQo+IA0KPiBBbnkgaGVscCB3b3VsZCBiZSBhcHByZWNpYXRlZCENCj4gDQoN
CkJlaW5nIGN1cmlvdXMgSSd2ZSBiZWVuIGxvb2tpbmcgYXQgdGhlIGRpZmYgZnJvbSB0aGUgbWVu
dGlvbmVkIHBhdGNoIGZvciB0aGUNCnBjaS14Z2VuZS5jIHNvdXJjZToNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLXhnZW5lLmMgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS0NCnhnZW5lLmMNCmluZGV4IGQxZWZhOGZmYmFlMS4uMTQzMWExOGViMDJjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2kteGdlbmUuYw0KKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2kteGdlbmUuYw0KQEAgLTM1NSw4ICszNTUsNyBAQCBzdGF0aWMg
aW50IHhnZW5lX3BjaWVfbWFwX3JlZyhzdHJ1Y3QgeGdlbmVfcGNpZV9wb3J0ICpwb3J0LA0KIAlp
ZiAoSVNfRVJSKHBvcnQtPmNzcl9iYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKHBvcnQtPmNzcl9i
YXNlKTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgImNmZyIpOw0KLQlwb3J0LT5jZmdfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNv
dXJjZShkZXYsIHJlcyk7DQorCXBvcnQtPmNmZ19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFw
X3Jlc291cmNlX2J5bmFtZShwZGV2LCAiY2ZnIik7DQogCWlmIChJU19FUlIocG9ydC0+Y2ZnX2Jh
c2UpKQ0KIAkJcmV0dXJuIFBUUl9FUlIocG9ydC0+Y2ZnX2Jhc2UpOw0KIAlwb3J0LT5jZmdfYWRk
ciA9IHJlcy0+c3RhcnQ7CS8qIDw9PT09ICovDQoNCkkgdGhpbmsgeW91IGNhbiBzZWUgdGhlIGVy
cm9yIGV2ZW4gZnJvbSB0aGlzIHNob3J0IHNuaXBwZXQuIEluIHRoZSB3b3JraW5nIGNhc2UNCndp
dGggdGhlIGxpbmVzIG1hcmtlZCB3aXRoICItIiBwcmVzZW50IHRoZSByZXMgdmFyaWFibGUgaXMg
c2V0IGJ5DQpwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKCkgY29ycmVjdGx5LiBUaGVuIGl0
IGNhbiBiZSB1c2VkIHRvIHNldCB1cCANCnBvcnQtPmNmZ19hZGRyIGluIHRoZSBsaW5lIG1hcmtl
ZCBieSAvKiA8PT09PSAqLy4NCg0KSW4gdGhlIGZhaWx1cmUgY2FzZSB3aXRoIHRoZSBsaW5lIG1h
cmtlZCB3aXRoICIrIiBvbmx5IGFjdGl2ZSB0aGUgcmVzIHZhcmlhYmxlDQppcyBub3QgdXBkYXRl
ZCBieSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCkgYW5kIGNhcnJpZXMg
ZGF0YSBmcm9tDQphbiBlYXJsaWVyIHJlc291cmNlIHNlYXJjaCBvciBldmVuIGlzIHVuaW5pdGlh
bGl6ZWQuIFRoZSB2YWx1ZSBzZXQgdG8gDQpwb3J0LT5jZmdfYWRkciB3aWxsIGJlIGNyYXAgd2l0
aCBhIGhpZ2ggcHJvYmFiaWxpdHkgSSB0aGluay4NCg0KQmVzdCByZWdhcmRzLA0KICAgIFN0ZWZh
bg0KDQo=
