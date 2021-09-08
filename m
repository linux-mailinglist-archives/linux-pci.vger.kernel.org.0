Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A55403689
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348350AbhIHJDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 05:03:38 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:52996
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234820AbhIHJDh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 05:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEKXfKPUmLN0BxstEyvR3wu8WQDTdc4CueSEw+pELycsvmSf3mzkKFY/vJf+kj9elJhrq7oAWj2LE8Yqomq6x1FzbEjkYMc7aTFnWtxTaKPSbn5Z5ZNe1uM3nsS3O2Wuzp3C98WmNgSfiAWlbIb3cjitdfHC90u9Lfp4L0QoI6lawCt0T8x8g0gEQbk3kCb/wHpivQwOd3roVNOpwiNqsVwOyIUFM670/mVZWIhFjwtjnKeRWCZUKt9XduO6WyXFbfsY27c44lwabF1PYDXTy4aYbuQUFS2W11lsPT80DUKDdR4r5QEJ3pbfH50c9JaxeEEQcSDG+2wlJbYWWjHvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kK4WWG1VBa3/we+sQHyS1JrBAI340amauEqnWRNVZy4=;
 b=WYsjXhl6XNYh59GEOg5NqZiwswuRWbo0i1ki8A1Xmt8jW+pi0YfLd68mRXpCAOf5yjRF+Pmz45MYx2pRDrPR6giSmwEjrfTePYGYQyvy1oetP5/OJmQBlLC8isw6uDksAOQYNRg+M/rK/PM8uNh+dn5qUc3JM6cXGNSC3OS5PqzymDdm/Ri9CXmE5M/bMeUt7+iOPkIAvBYX1AJBgtnfoWfpWfNTgvNEOdLW+Hyvh0RYs7tyZ1gn2vgIixiEeIT4FkMI14+fu5Xa/1fV/seMvy8EYinhaZWKLhaKYUX3BTV7CNfnfFGG+rOwhG3zcfWJyoyVC9Qy18xTOEtCtzLSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK4WWG1VBa3/we+sQHyS1JrBAI340amauEqnWRNVZy4=;
 b=fZgj1RGeXTLqg3wx/0zuhtTSkYgGYECjp0rL/atkUu8L0NbKaU0XDsim6r2e59zVllfoZrlLfrqlyJB828XCQrGYVkJnRdtREjFfSGjzmq+CqiM6zisygKmwPxmpJ3grTUF0BXvqnna/JiZhbuNo+jUXLmMYRimXrqwF99zNmJk=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 09:02:26 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef%5]) with mapi id 15.20.4457.025; Wed, 8 Sep 2021
 09:02:26 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
Thread-Topic: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
Thread-Index: AQHXpIJDyY2p633pJ0mWNxSzi2/g/auZ01aAgAADetA=
Date:   Wed, 8 Sep 2021 09:02:26 +0000
Message-ID: <VI1PR04MB58535180BEE89EF4584BEF3F8CD49@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
 <125bd22edb69ce38a18bcc80c6507da28e8eb185.camel@pengutronix.de>
In-Reply-To: <125bd22edb69ce38a18bcc80c6507da28e8eb185.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 141ce4fb-8bbf-43ed-300d-08d972a76134
x-ms-traffictypediagnostic: VE1PR04MB7374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB737403D267D305475C2C4E3C8CD49@VE1PR04MB7374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BiO3C3x0WA0QCkoq4nwxw3Azsc3hFAU5N4VjQ/ifec4f0nQThItHwxaOi44xnVtA2Txj3K+HXuxY261F8BGE36hv7xRLBwPxGKJgw6ZQpvD5E0Zqs4D9be+AUDf/l5YTCHT85BvZ0uIb++ySMaDC8Z0k+H/2PsWpJJiKD0wyFYRo+Ui4IX98mXw1ln7Kq+dpf4g038DhlsPVznxv0b8DXIfWgwuEvyY4pOrnGGdFT5VWyUpnDc4pnmZtK9W+usNlCDw4Zy0TdCxG3NL2OWY8AX1853ffIfqI7//wfUZ1nnbFe28s5Dw83CEIMp/RXlLt2K/n5bYxcm0Ta95OYLCuCrs0tWWZhVKUY3in85fHf4fe1NKO5irdnpDHh6RX6bJrJFkd7KaPDdbu94JGzYULpjS/AVK4O7YncVZwPMbhu/m+eq4pcZUwrcKADyzET+Nrn59z50J4vKZEiymAwvot8+Qb96B53WuvnqMidJFMc9dsZLN4BkdmG/jsoxjpOFB2IQP00PtO7jCaGY3POfO68xM+8G8qsU/b4EYQ8j/hpOogf3+YnUk83a+dOVAYtY1HuMyjl10sAQUGus/1h+E5RRGlpR6fVIv+0XuGD3wL2U1B8r/i3jUwYpQOdMkT7/jiXW38KuoIMFV3KAcuwQ2Whv/ASBVjbkBqV5Wgzfcn+P88OwcasmGK0bJI6AeO0NJrai3N14B1nsFHfioGXAsboQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(6506007)(8936002)(122000001)(64756008)(7696005)(83380400001)(53546011)(33656002)(26005)(186003)(4326008)(55016002)(5660300002)(8676002)(2906002)(66446008)(38070700005)(478600001)(9686003)(52536014)(316002)(54906003)(71200400001)(86362001)(110136005)(66946007)(66556008)(76116006)(66476007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3dHc0c0V283dXl3VVhQQ0FzVks1dmtlV0tSS2JmbVF1cEpYZFdBOXdzajlW?=
 =?utf-8?B?eVZJS1JMRTluaUFCTTFhS3BYeEQ4dDlnYW1reERLV3ZYdmZ2ay9wdUlRbnR3?=
 =?utf-8?B?QVFtakU4TFViSjVyV3RjSDJHVjlEc25CczFlZmFQbEhmK3NEZzhUTEI5T3lI?=
 =?utf-8?B?TUQ4UmdVMlRoSDJLQUtVdzJ0Wjk2V0R0RFA4WWVWOUZsTlM1NVZxU2hGRkpl?=
 =?utf-8?B?NTVHS0luek45Qmg0OU1FM0dNczREc0RXVkNRNkh2VEtyUkpFR0dZNTg4NDhI?=
 =?utf-8?B?Z2VYT20yRjAzTUNNd1U1WUxBMXhJQ215eVVYK1BmYVM1eERqMDA3YWpqaTdO?=
 =?utf-8?B?S2xwQ2U2ODJ0ZVY1RWZ2c3VXc3Y1aUlsc3dQNmI5OHYwaW9odWNPNGtPQjBt?=
 =?utf-8?B?eW9aSS9sNFlJamxEUGREaVV5a2J6ODhjSXMvdTR4b3hodkw1WHdMUUprQUdq?=
 =?utf-8?B?b2t5VHpWOWErWlUxQU1GWFQ5ODZ2cTc3bEhheEFkOHRvL2JIaWxXc2hnMy9D?=
 =?utf-8?B?MFRwempwSVQzM3Q5VDBGNlNhanFwK09CcmZrcG5XZGZvWWNMVXc1Rmk0Q0p1?=
 =?utf-8?B?eFMyRlJmNWZ0ZDVhYVRIQUk2bSt5Ryt2Y3A4WG1LNUM5UWtxbUwxcmF6bjBw?=
 =?utf-8?B?R0pVUUFWMjYrRnpSMGxLVUhuZGcwZ1hSMjNteTJmWHpQSmQ1NzlJeXJuRFU4?=
 =?utf-8?B?REtwTzhjUVRDV0JuLzlTUnA3WnJZRVF5L0ZRTENkT1hCRTQ1dmpoTXpTL2FU?=
 =?utf-8?B?NSs0ZWkzemdFbmRNeGswK1J0ZFpvMFo2Q25ERG92Z0VyOUgwZE1IdnJiSCt3?=
 =?utf-8?B?cFFxQkdwS1QrSWFQMXdxb2dMQ0FxbHdIYm8yVDl6MmNNNDZYS3NoQXg5K3ha?=
 =?utf-8?B?aXQ1RVljWnRWSXlJR3FZK0dUbGU3eHdSZDV0TmlBbkNUSlM0RnVTS3pncHdI?=
 =?utf-8?B?ZE9CWWk4ZDRoZHNVdkRBcTNGc0U2c1FSOGZjNUh6U0JURGtOaTk5b3MzSjd6?=
 =?utf-8?B?NGlKS0NZc0ZhNEFRbUpzcXdJMm1QOUx6N3o1OHd2R3hZY0lMYXl3VU5WM0tt?=
 =?utf-8?B?ajI5RnQ3UlJxb0JBenZ2c280dzNZaS9QM2c3aWJUM2NBMWRoWVQvVDI0NEdu?=
 =?utf-8?B?R1VqdFduMVAwK1FuYk9sNThJWERQbFBJS2l3QzdDNlQyeEdlWFZpSUp4anJz?=
 =?utf-8?B?ZGE0d3lhM1dhaVM0cDhGMFg0ZW90OG84VFIvdnI5WGZkN1ViVFQwVnljbk1J?=
 =?utf-8?B?bWtxRVhwcFZ1QUtIbVU5aVhyY0ZNN2hEelpPb0JiZDh3b2h0cklGQ3dEa00z?=
 =?utf-8?B?cjR5aXJkbVpVb3hTck1TOFJ0ekRKNHNyVi8zYWwvMjhtTEhoclFjSWNaMFdn?=
 =?utf-8?B?LzVWVG9aazgrNnNieXk3SGZmM2pNY0tpTlpJTUtxZkZmUlZBNmpUb0VPMWxm?=
 =?utf-8?B?TEJwM292c2dNMkl6d1VoWmFqQXZpOGpoZmQ4MFVMSnQxbUV3dnZIdmtUWFJH?=
 =?utf-8?B?d2NxcXFCNk10WllKUkFZdnNKSjNMQWJDNFI2QXBGMHFRZTJtSi8vTStvcmRl?=
 =?utf-8?B?V3FCZnh3dC9kbmhSWDVZaG12Y2FCY0xyWnJWaXRueDluMVpJbGVaK01EaVBy?=
 =?utf-8?B?bFRBdDRTTW9jaVozNHNMbFZLTVBpZnZ2ZytvSG1rV2VmamE3UTJGQU8vcWRX?=
 =?utf-8?B?YWpURnBkb1lYSWkvUjZXWmdjdDh6K2tXaTh4a0tDVzg0eGhORE1oQksxQkRJ?=
 =?utf-8?Q?mBfCLxoPYaGHu1D1mHO/cMZ0d2qnTeu63UT6Zxi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141ce4fb-8bbf-43ed-300d-08d972a76134
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 09:02:26.4971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSkYZyt+xZhPlneNw4uWx9w21dmWFRZCCfYGvkSUwKADTyw3WKUshee/L3sXm0+XsScoBf7XV0MXBjm/WxIsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgOCwgMjAyMSA0
OjQ4IFBNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzNdIFBDSTogaW14OiBlbmNhcHN1bGF0ZSB0aGUgY2xvY2sgZW5hYmxlIGludG8gb25lDQo+
IHN0YW5kYWxvbmUgZnVuY3Rpb24NCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW0gMDguMDkuMjAyMSB1
bSAxNDo1OSArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IE5vIGZ1bmN0aW9uIGNoYW5n
ZXMsIGp1c3QgZW5jYXBzdWxhdGUgdGhlIGkuTVggUENJZSBjbG9ja3MgZW5hYmxlDQo+ID4gb3Bl
cmF0aW9ucyBpbnRvIG9uZSBzdGFuZGFsb25lIGZ1bmN0aW9uDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA4Mg0KPiA+ICsrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwg
MzEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IGluZGV4IDgwZmM5OGFjZjA5Ny4uMDI2NDQzMmU0YzRhIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTE0Myw2ICsxNDMs
OCBAQCBzdHJ1Y3QgaW14Nl9wY2llIHsNCj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19S
WF9EQVRBX0VOCQlCSVQoNSkNCj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9QTExf
RU4JCUJJVCgzKQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgaW14Nl9wY2llX2Nsa19lbmFibGUoc3Ry
dWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKTsNCj4gPiArDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBp
cyBzdHJpY3RseSBuZWVkZWQuIENhbiB5b3UganVzdCBtb3ZlIHRoZSBwbGFjZW1lbnQgb2YgdGhl
DQo+IG5ldyBpbXg2X3BjaWVfY2xrX2VuYWJsZSBmdW5jdGlvbiBpbiB0aGUgZmlsZSwgc3VjaCB0
aGF0IHdlIGNhbiBhdm9pZCB0aGUNCj4gZm9yd2FyZCBkZWNsYXJhdGlvbj8NCj4gDQpbUmljaGFy
ZCBaaHVdIFRoYW5rcyBmb3IgeW91ciBxdWlja2x5IHJldmlldy4NCk9rYXksIHdvdWxkIG1vdmUg
dGhlIHBsYWNlbWVudCB0byBhdm9pZCBoZSBmb3J3YXJkIGRlY2xhcmF0aW9uLg0KDQo+ID4gIHN0
YXRpYyBpbnQgcGNpZV9waHlfcG9sbF9hY2soc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llLCBi
b29sDQo+ID4gZXhwX3ZhbCkgIHsNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSBpbXg2X3Bj
aWUtPnBjaTsgQEAgLTQ5OCwzMyArNTAwLDEyIEBAIHN0YXRpYw0KPiA+IHZvaWQgaW14Nl9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJ
CX0NCj4gPiAgCX0NCj4gPg0KPiA+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteDZfcGNp
ZS0+cGNpZV9waHkpOw0KPiA+IC0JaWYgKHJldCkgew0KPiA+IC0JCWRldl9lcnIoZGV2LCAidW5h
YmxlIHRvIGVuYWJsZSBwY2llX3BoeSBjbG9ja1xuIik7DQo+ID4gLQkJZ290byBlcnJfcGNpZV9w
aHk7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteDZf
cGNpZS0+cGNpZV9idXMpOw0KPiA+ICsJcmV0ID0gaW14Nl9wY2llX2Nsa19lbmFibGUoaW14Nl9w
Y2llKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAtCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBl
bmFibGUgcGNpZV9idXMgY2xvY2tcbiIpOw0KPiA+IC0JCWdvdG8gZXJyX3BjaWVfYnVzOw0KPiA+
ICsJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llIGNsb2Nrc1xuIik7DQo+ID4g
KwkJZ290byBlcnJfY2xrczsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGlteDZfcGNpZS0+cGNpZSk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJZGV2X2Vy
cihkZXYsICJ1bmFibGUgdG8gZW5hYmxlIHBjaWUgY2xvY2tcbiIpOw0KPiA+IC0JCWdvdG8gZXJy
X3BjaWU7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JcmV0ID0gaW14Nl9wY2llX2VuYWJsZV9yZWZf
Y2xrKGlteDZfcGNpZSk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJ1
bmFibGUgdG8gZW5hYmxlIHBjaWUgcmVmIGNsb2NrXG4iKTsNCj4gPiAtCQlnb3RvIGVycl9yZWZf
Y2xrOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCS8qIGFsbG93IHRoZSBjbG9ja3MgdG8gc3RhYmls
aXplICovDQo+ID4gLQl1c2xlZXBfcmFuZ2UoMjAwLCA1MDApOw0KPiA+IC0NCj4gPiAgCS8qIFNv
bWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElPLiAqLw0KPiA+ICAJaWYgKGdwaW9f
aXNfdmFsaWQoaW14Nl9wY2llLT5yZXNldF9ncGlvKSkgew0KPiA+ICAJCWdwaW9fc2V0X3ZhbHVl
X2NhbnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4gPiBAQCAtNTc4LDEzICs1NTksNyBA
QCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gPiBp
bXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPg0KPiA+ICAJcmV0dXJuOw0KPiA+DQo+ID4gLWVycl9y
ZWZfY2xrOg0KPiA+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZSk7DQo+
ID4gLWVycl9wY2llOg0KPiA+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNp
ZV9idXMpOw0KPiA+IC1lcnJfcGNpZV9idXM6DQo+ID4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUo
aW14Nl9wY2llLT5wY2llX3BoeSk7DQo+ID4gLWVycl9wY2llX3BoeToNCj4gPiArZXJyX2Nsa3M6
DQo+ID4gIAlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2
X3BjaWUtPnZwY2llKSA+IDApIHsNCj4gPiAgCQlyZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2
X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+IEBAIC05MTQsNiArODg5LDUxIEBA
IHN0YXRpYyB2b2lkIGlteDZfcGNpZV9wbV90dXJub2ZmKHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlt
eDZfcGNpZSkNCj4gPiAgCXVzbGVlcF9yYW5nZSgxMDAwLCAxMDAwMCk7DQo+ID4gIH0NCj4gPg0K
PiA+ICtzdGF0aWMgaW50IGlteDZfcGNpZV9jbGtfZW5hYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlt
eDZfcGNpZSkgew0KPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IGlteDZfcGNpZS0+cGNpOw0K
PiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShpbXg2X3BjaWUtPnBjaWVfcGh5KTsN
Cj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBlbmFibGUg
cGNpZV9waHkgY2xvY2tcbiIpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiA+
ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2ll
X2J1cyBjbG9ja1xuIik7DQo+ID4gKwkJZ290byBlcnJfcGNpZV9idXM7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteDZfcGNpZS0+cGNpZSk7DQo+ID4g
KwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gZW5hYmxlIHBjaWUg
Y2xvY2tcbiIpOw0KPiA+ICsJCWdvdG8gZXJyX3BjaWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gaW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKGlteDZfcGNpZSk7DQo+ID4gKwlpZiAocmV0
KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gZW5hYmxlIHBjaWUgcmVmIGNsb2Nr
XG4iKTsNCj4gPiArCQlnb3RvIGVycl9yZWZfY2xrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8q
IGFsbG93IHRoZSBjbG9ja3MgdG8gc3RhYmlsaXplICovDQo+ID4gKwl1c2xlZXBfcmFuZ2UoMjAw
LCA1MDApOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnJfcmVmX2NsazoNCj4gPiAr
CWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBjaWUpOw0KPiA+ICtlcnJfcGNpZToN
Cj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBjaWVfYnVzKTsNCj4gPiAr
ZXJyX3BjaWVfYnVzOg0KPiA+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNp
ZV9waHkpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gKw0KPiBTdXBlcmZsdW91cyBu
ZXdsaW5lLg0KW1JpY2hhcmQgWmh1XUdvdCB0aGF0LiBCbGFuayBsaW5lIHdvdWxkIGJlIHJlbW92
ZWQgbGF0ZXIuDQpUaGFua3MuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+ICt9
DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY2xrX2Rpc2FibGUoc3RydWN0IGlt
eDZfcGNpZSAqaW14Nl9wY2llKSAgew0KPiA+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZf
cGNpZS0+cGNpZSk7DQo+IA0KDQo=
