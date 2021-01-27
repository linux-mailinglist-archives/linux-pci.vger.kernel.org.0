Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B32305375
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 07:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhA0GaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 01:30:05 -0500
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:2740
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229808AbhA0G2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 01:28:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9yDI7EV3tvQtyU/T17EZqMa6/IFoXqIkxV8kwQPGJ3g3tL0DCQTtdwDscV/a0lDqE/DcnASDnNomQcOZYkfPo1qsEBWKzJoam01XEUoCRjeTrOByt4g7iY5FxWrHzuMtLZfRNBgbxuD3exao2/Zq4iqmZX43dv2YXc8JGQwjbsCyapOs7+5eMAXRbd4eKvYGWD/sPNnaVoN7WVgJnsghhCgVOnpyJ/VvflUNo+ja2LLNKSxGGKr8KID7dMNIxILnQ/qlZTpfORsLxMAUxIdiA/T336CAxkbK/VrFcHSAVdaJbtA5EkQmc/B1h94+usAGN+cXBWphXK6bP2gW3PEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qijhHLC/RzxuYxhu8KCIb5KnM0xFguNAXZH2qh+TEGg=;
 b=IGt8sIVOMx9FdUNguqMMvGlgCZAys5xiG1gCeL7FWpnKJv1edKBFUJoqor9dfZqQxQBnLgiN46s2IB+HBjFnXTyz2TFtPF1XgIE2KmwGKKgZIrCyHnKkZIRzHAets45lc1ZJKCZqn4gc/XGAM20SZE680hczCAwnUtR/6goZkq9HfWwDPLWqZW0FaEw24YhU+MNkjQOZetWRWZyelc+7scb8qNIBoq18M5wmp4in4Ugx+ZtYPChwoMrjONlA965KV1J6pGJ3cU6NJF5NqDa0tKXcNqs840hadN5EqgtVopZ6bG9smWIPEt/HOGaqFVQ076H+URCfELYqAt0ztylz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qijhHLC/RzxuYxhu8KCIb5KnM0xFguNAXZH2qh+TEGg=;
 b=jkWoYH/v5gXgiGF5HlAmA7P3+6zZIBXyQRVAqFZu6JZhyH/vUOeB9jV9+Nk6hiCUpHrpzcTIAP3mznA2K/rv3HGW6iqKYZ1gAV79tg15G1yZsUcfa6FeMSRe1t3AJEO9ox/8uqSwqNBVo9LDM6EA09Krulvx2eB0SNunqffPKdQ=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3274.eurprd04.prod.outlook.com (2603:10a6:7:1f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 06:27:18 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::d1b3:d2fd:113f:ce47]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::d1b3:d2fd:113f:ce47%4]) with mapi id 15.20.3784.020; Wed, 27 Jan 2021
 06:27:17 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        "masami.hiramatsu@linaro.org" <masami.hiramatsu@linaro.org>
Subject: RE: [PATCH] PCI: dwc: Move forward the iATU detection process
Thread-Topic: [PATCH] PCI: dwc: Move forward the iATU detection process
Thread-Index: AQHW8tQXQE2xfUhF2EeE7TIhKW6h7Ko5Ya6AgAGdP2A=
Date:   Wed, 27 Jan 2021 06:27:17 +0000
Message-ID: <HE1PR0402MB33713DFC517B00EE1D13371784BB0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
 <7d2d8a01-1339-2858-0d6a-5674f1cf2bca@socionext.com>
In-Reply-To: <7d2d8a01-1339-2858-0d6a-5674f1cf2bca@socionext.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88e49b41-7d7c-4135-2bdf-08d8c28c9846
x-ms-traffictypediagnostic: HE1PR04MB3274:
x-microsoft-antispam-prvs: <HE1PR04MB327442ECC2D20560E584949A84BB0@HE1PR04MB3274.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfGYF+4zauMTsyTwLi6SvgOJVoIatmkQwvVrny8BOXeVVhINQ73V6tW22+mI9qgCLHCuMekkbcgUUWb4OjRwW0RN1EIyuLTfs/e88knZXDfcOVn9HZzgjaGOBeijrsSNTlsS3eA3P3EnlKlWuSojczhS37ZME3143Tu9LXrJ8vVnuXaL66RX+vAFLRMkUadcae0D+PpwPOMEidhhyRBz4P84w3XjdwXt9qCRtYuq0+A9KT98aK6vPsetb9lgovDql4iLnr6Kt4eorx/adyXguxU23FHkPep/sRY85sDaddddwDjAar0rDjaEpZsxxI8I13FAR6fx7GDZJMGzFmHYhtIG0Dq5gxCRG+nHqaRo0sJ7G8K20eK3G0qBaOa4/WuGW6r8ez6i2RxZBb0Oyhls8fsK3+JRmmUtfDJ0WMIRSQbMyQjW0Lu5D9seGyNQqB44ySLu/R74pOqsG8McXYy1ImwoLCdsghFeKvR68z1AAAU49C56GO2SkzVvBgmdl+yjGWf4tkDuondhn0Jd8Hyb9wuSHg+arEYE+p8CeVM6MUxznjGpGeF5GMmtH9W3B/wMnH87wYbTXmf7OEGtSInYxGbidPQmiXVokRVm+uTygtY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(45080400002)(66446008)(76116006)(966005)(83380400001)(55016002)(52536014)(5660300002)(66476007)(186003)(2906002)(71200400001)(53546011)(8936002)(316002)(6506007)(9686003)(66556008)(86362001)(64756008)(8676002)(66946007)(54906003)(478600001)(6916009)(26005)(7416002)(4326008)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?dDBCR3ZjQnBvczhnMFNMMHEwT2UzVFhHamM4OXRVcGN5VmJKYmtyTGZkV3RO?=
 =?gb2312?B?MnZUNHZVOVdTb2laUm5xOTNwU1h3YU1BT1JuNnV5anhFaXpTSDRFalY2eGFt?=
 =?gb2312?B?b0RqckNqV0RyZDl1RjNRYVBTQ0YvN0dsS000REhrSFFxU0g4RGJ5K1pCWGdG?=
 =?gb2312?B?dGRSTVJRY1Rrai9mQ3o2YWx0VGtKVVJrRldiQWN1NUZod0pmTUNyU3pkUXVC?=
 =?gb2312?B?QjNsNjdtdjJJOGV2eWw1MTJDalFlaWczY0RweGUwUnkwNHZNdnROdkUxenhs?=
 =?gb2312?B?OHJ5bTB0NU50aFNuczVrMWFQQ0hVUEtPTHl3d2FwMlJNUzdBUUVMMWZybDBL?=
 =?gb2312?B?SVhqMlF6VE9KNW5hMmt6MkRaMkhwM3NpRExLekswMmdkSGoybkpoOTdTVWt4?=
 =?gb2312?B?anFXdWNPQStxUmxDWEZMbStxZXd6YXZEcWtvUmpSTGhVWEpjSWMvL0M2YndQ?=
 =?gb2312?B?VC8yQkdrTk10S1NNSkFFaXMwQkZBNU1ReEI2YVk0UXowTkcxWUY2cjRxUVhO?=
 =?gb2312?B?dXd1azBjamp4eENFbnRDVU8vZlJWcU5ZVE9oclhQV3Y4ajBwOFViY1prenBP?=
 =?gb2312?B?Q0NReE5ERVdrNUl3RHZOZWw5REVlRC9adWpoNlJTZnp5NDVBMlR6emF1WVRi?=
 =?gb2312?B?R2haTEhhWTQ2NlJMSjlndlRURytLTnN2amFTbXFyTngyOTZtcUZkSWFRNzAv?=
 =?gb2312?B?VUJxb1p6ZnJwTGRTT1hGa3o5cWpvOEVXVnVSZ25ERHhwWXUzRDR5SE8waTJR?=
 =?gb2312?B?WjMxbTU1S2hCV3o0RHJHM3h0RFlleWxCa1h6QzZOTVdleHoyNTBLUlJrNUdQ?=
 =?gb2312?B?LzgwQm9Obm80RGFNcTlCN3RTQWM4dG9CdXA0QlQxOUJ5aDhEK1dQZE5Lc2RS?=
 =?gb2312?B?OVRJT0JPVFYvME1ocXdJVEsrQXdZWXdDUXRlTEt2UzVoTGZJclJaQk94T3I3?=
 =?gb2312?B?VVQ1N0pzMm5ISC9keTlRVDhyWXZjaVlBcWcxa2VPY1lIc0YvK3NIeXJub3lH?=
 =?gb2312?B?Sm95T3ZzU01pMEkyV3BOMk5VY1pBMkZISUg1bGxxUGRVNWx2K21iSnRGazBK?=
 =?gb2312?B?STBCd09Zb3hXOVdYTXlPSzBPb0VobitOeXRDV1lCd1RKc1dxeFBUc3ZlRi9B?=
 =?gb2312?B?TDBQMHBhcWpwTjN0Qi9ydWtpZnpaUCs1dUFmM2V2QlFGZHRRM3Z3SFA0bmx1?=
 =?gb2312?B?eG1SZ0ovbVhPanhZTTFTb1FtWnZSMlpETVZaSWRvUGk0WDBCQzNHenVtTmR3?=
 =?gb2312?B?V1JBRm1hTmE0S1o5UzUyaWw2ZEx6OHBybVFtSWl5dUtpTlRxYUI2S0tFckhl?=
 =?gb2312?B?WjhCdVk4U0FCVlJGdGZZZ2kzN3pQZTBNRExrQWNDcGsvV1VZMnMrM1lRSE8x?=
 =?gb2312?B?cnZpMzQ1cklVY3E1bk5BRHBEbUU5UXFHVW8rT0xZTGhjOTVnTDlPTzMrdEVx?=
 =?gb2312?Q?GPGElkJo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e49b41-7d7c-4135-2bdf-08d8c28c9846
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 06:27:17.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ABo67kbwoL7tig8kGl8y8I3dCnbdZqKLcroDyAyNWcaLrgSCLU8FcME0GvBfmW8jdvZPIHYVAqgt5GiCaB+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3274
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNClllcywgdGhleSBhcmUgZml4IHRoZSBzYW1lIGlzc3VlLg0KUm9iIGFuZCBvdGhlciBj
b250cmlidXRvcnMgc2VudCBzbyBtYW55IHBhdGNoZXMgdG8gcmVmaW5lIHRoZSBkcml2ZXJzIGFu
ZCBtYWtlIHRoZSBjb2RlIGJyaWVmIGFuZCBtb3JlIHJlYWRhYmxlLCBzbyBJIGRvbid0IHRoaW5r
IHdlIHNob3VsZCBqdXN0IGZvY3VzIG9uIHRoZSBmaXhlcyBvZiB0aGlzIGlzc3VlLiBJIGRvbid0
IHRoaW5rIGl0IGlzIGEgZ29vZCBjaG9pY2UgdGhhdCB5b3VyIHBhdGNoIG1vdmUgc29tZSBvZiB0
aGUgc29mdHdhcmUgcGVyc3BlY3RpdmUgaW5pdGlhbGl6YXRpb25zIGludG8gaGFyZHdhcmUgb25l
cy4NCg0KVGhhbmtzDQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEt1bmloaWtvIEhheWFzaGkgPGhheWFzaGkua3VuaWhpa29Ac29jaW9uZXh0LmNvbT4N
Cj4gU2VudDogMjAyMcTqMdTCMjbI1SAxMzoyNg0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhv
dUBueHAuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lz
LmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGphc3dpbmRlci5zaW5naEBsaW5hcm8ub3Jn
OyBtYXNhbWkuaGlyYW1hdHN1QGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJ
OiBkd2M6IE1vdmUgZm9yd2FyZCB0aGUgaUFUVSBkZXRlY3Rpb24gcHJvY2Vzcw0KPiANCj4gSGks
DQo+IA0KPiBUaGlzIGxvb2tzIHRvIG1lIHRoZSBzYW1lIGZpeCBhcyBteSBwb3N0ZWQgcGF0Y2hb
MV0uDQo+IElzIHRoaXMgbW9yZSBlZmZlY3RpdmUgdGhhbiBtaW5lPw0KPiANCj4gVGhhbmsgeW91
LA0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dw0KPiAuc3Bpbmljcy5uZXQlMkZsaXN0cyUyRmxp
bnV4LXBjaSUyRm1zZzEwMzg4OS5odG1sJmFtcDtkYXRhPTA0JTdDMDElDQo+IDdDWmhpcWlhbmcu
SG91JTQwbnhwLmNvbSU3Q2Q5ZmE1OGFhYzQ3NzRjOWRkNjFiMDhkOGMxYmFkMTI4JTdDDQo+IDY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc0NzIzNTU0MTIyMDI1
NjMNCj4gJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUwNCj4gQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtz
ZGF0YT1NdDNCNGpRMVExZnUlMg0KPiBGQXo5czRZNGVpZUh2N25Zb3J2dlQycEtscUZMRTlrJTNE
JmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBPbiAyMDIxLzAxLzI1IDEzOjQ4LCBaaGlxaWFuZyBIb3Ug
d3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4g
Pg0KPiA+IEluIHRoZSBkd19wY2llX2VwX2luaXQoKSwgaXQgZGVwZW5kcyBvbiB0aGUgZGV0ZWN0
ZWQgaUFUVSByZWdpb24NCj4gPiBudW1iZXJzIHRvIGFsbG9jYXRlIHRoZSBpbi9vdXRib3VuZCB3
aW5kb3cgbWFuYWdlbWVudCBiaXQgbWFwLg0KPiA+IEl0IGZhaWxzIGFmdGVyIHRoZSBjb21taXQg
MjgxZjFmOTljZjNhICgiUENJOiBkd2M6IERldGVjdCBudW1iZXIgb2YNCj4gPiBpQVRVIHdpbmRv
d3MiKS4NCj4gPg0KPiA+IFNvIHRoaXMgcGF0Y2ggbW92ZSB0aGUgaUFUVSByZWdpb24gZGV0ZWN0
aW9uIGludG8gYSBuZXcgZnVuY3Rpb24sIG1vdmUNCj4gPiBmb3J3YXJkIHRoZSBkZXRlY3Rpb24g
dG8gdGhlIHZlcnkgYmVnaW5uaW5nIG9mIGZ1bmN0aW9ucw0KPiA+IGR3X3BjaWVfaG9zdF9pbml0
KCkgYW5kIGR3X3BjaWVfZXBfaW5pdCgpLiBBbmQgYWxzbyByZW1vdmUgaXQgZnJvbSB0aGUNCj4g
PiBkd19wY2llX3NldHVwKCksIHNpbmNlIGl0J3MgbW9yZSBsaWtlIGEgc29mdHdhcmUgcGVyc3Bl
Y3RpdmUNCj4gPiBpbml0aWFsaXphdGlvbiBzdGVwIHRoYW4gaGFyZHdhcmUgc2V0dXAuDQo+ID4N
Cj4gPiBGaXhlczogMjgxZjFmOTljZjNhICgiUENJOiBkd2M6IERldGVjdCBudW1iZXIgb2YgaUFU
VSB3aW5kb3dzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWVwLmMgICB8ICAyICsrDQo+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgIDIgKysNCj4gPiAgIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jICAgICAgfCAxMSArKysrKysrKy0tLQ0KPiA+
ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggICAgICB8ICAx
ICsNCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtZXAuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWVwLmMNCj4gPiBpbmRleCBiY2QxY2Q5YmE4YzguLmZjZjkzNWJmNmY1ZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
ZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jDQo+ID4gQEAgLTcwNyw2ICs3MDcsOCBAQCBpbnQgZHdfcGNpZV9lcF9pbml0KHN0cnVj
dCBkd19wY2llX2VwICplcCkNCj4gPiAgIAkJfQ0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJZHdfcGNp
ZV9pYXR1X2RldGVjdChwY2kpOw0KPiA+ICsNCj4gPiAgIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KPiAiYWRkcl9zcGFjZSIpOw0KPiA+
ICAgCWlmICghcmVzKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGlu
ZGV4IDhhODRjMDA1ZjMyYi4uOGVhZTgxN2MxMzhkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTMx
Niw2ICszMTYsOCBAQCBpbnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IHBjaWVfcG9ydCAqcHAp
DQo+ID4gICAJCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gPiAgIAl9DQo+ID4N
Cj4gPiArCWR3X3BjaWVfaWF0dV9kZXRlY3QocGNpKTsNCj4gPiArDQo+ID4gICAJYnJpZGdlID0g
ZGV2bV9wY2lfYWxsb2NfaG9zdF9icmlkZ2UoZGV2LCAwKTsNCj4gPiAgIAlpZiAoIWJyaWRnZSkN
Cj4gPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGluZGV4IDViNzJhNTQ0OGQyZS4uNWI5YmYw
MmQ5MThiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmMNCj4gPiBAQCAtNjU0LDExICs2NTQsOSBAQCBzdGF0aWMgdm9pZCBkd19wY2ll
X2lhdHVfZGV0ZWN0X3JlZ2lvbnMoc3RydWN0DQo+IGR3X3BjaWUgKnBjaSkNCj4gPiAgIAlwY2kt
Pm51bV9vYl93aW5kb3dzID0gb2I7DQo+ID4gICB9DQo+ID4NCj4gPiAtdm9pZCBkd19wY2llX3Nl
dHVwKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gK3ZvaWQgZHdfcGNpZV9pYXR1X2RldGVjdChz
dHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAgew0KPiA+IC0JdTMyIHZhbDsNCj4gPiAgIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRldjsNCj4gPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAg
PSBkZXYtPm9mX25vZGU7DQo+ID4gICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRv
X3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiA+DQo+ID4gICAJaWYgKHBjaS0+dmVyc2lvbiA+PSAw
eDQ4MEEgfHwgKCFwY2ktPnZlcnNpb24gJiYgQEAgLTY4Nyw2ICs2ODUsMTMNCj4gPiBAQCB2b2lk
IGR3X3BjaWVfc2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPg0KPiA+ICAgCWRldl9pbmZv
KHBjaS0+ZGV2LCAiRGV0ZWN0ZWQgaUFUVSByZWdpb25zOiAldSBvdXRib3VuZCwgJXUNCj4gaW5i
b3VuZCIsDQo+ID4gICAJCSBwY2ktPm51bV9vYl93aW5kb3dzLCBwY2ktPm51bV9pYl93aW5kb3dz
KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBkd19wY2llX3NldHVwKHN0cnVjdCBkd19wY2ll
ICpwY2kpIHsNCj4gPiArCXUzMiB2YWw7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2kt
PmRldjsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+ID4N
Cj4gPiAgIAlpZiAocGNpLT5saW5rX2dlbiA+IDApDQo+ID4gICAJCWR3X3BjaWVfbGlua19zZXRf
bWF4X3NwZWVkKHBjaSwgcGNpLT5saW5rX2dlbik7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IDVkOTc5OTUzODAwZC4u
ODY3MzY5ZDRjNGY3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmgNCj4gPiBAQCAtMzA1LDYgKzMwNSw3IEBAIGludCBkd19wY2llX3By
b2dfaW5ib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUNCj4gKnBjaSwgdTggZnVuY19ubywgaW50IGlu
ZGV4LA0KPiA+ICAgdm9pZCBkd19wY2llX2Rpc2FibGVfYXR1KHN0cnVjdCBkd19wY2llICpwY2ks
IGludCBpbmRleCwNCj4gPiAgIAkJCSBlbnVtIGR3X3BjaWVfcmVnaW9uX3R5cGUgdHlwZSk7DQo+
ID4gICB2b2lkIGR3X3BjaWVfc2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSk7DQo+ID4gK3ZvaWQg
ZHdfcGNpZV9pYXR1X2RldGVjdChzdHJ1Y3QgZHdfcGNpZSAqcGNpKTsNCj4gPg0KPiA+ICAgc3Rh
dGljIGlubGluZSB2b2lkIGR3X3BjaWVfd3JpdGVsX2RiaShzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1
MzIgcmVnLCB1MzINCj4gdmFsKQ0KPiA+ICAgew0KPiA+DQo+IA0KPiAtLS0NCj4gQmVzdCBSZWdh
cmRzDQo+IEt1bmloaWtvIEhheWFzaGkNCg==
