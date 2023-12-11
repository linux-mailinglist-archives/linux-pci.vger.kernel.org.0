Return-Path: <linux-pci+bounces-748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959580C637
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 11:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3D51F21057
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A22374F;
	Mon, 11 Dec 2023 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PotimvQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73326C2;
	Mon, 11 Dec 2023 02:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEKS8JSv+iG7CC70So2TdwwhAEZJWlYeh25t6OKVKJGdsAsIvBhqQX1npBxyPD2YeZif8EmnTeGrRXBtGpJubIeK32R47NPNdnnvxAhYxDyuIaAtXQEnaHFifC/NxtOm8mnFZ/T7FRMjWSnrHzL3Kn/ZnT1oZxgbrOuhvGZEhvg37AGIJTrt9cJTpPJZgjKzUxJqRypx1TRzctZ98oA9w8SHvKfQJ7FsuYtzJ3bCPzeR3/o8hXtgrIL5DB1tEUekmi5LKff5kNAAH+S6cHeui4yTL65oicl3pmXdfse+qr2n1502GoeOMCOv6RwCZP7prrgBWFV4Ew994HBr3l3zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27vkWcEYiXLAGLBkJAenTIioMG3XlNfx2iLOelLIQQ8=;
 b=TioGYhT0mGmvcR1n+/TAx7P1UWvJwfexky+g/yRgXDHytM8oSErhT9bRUMvBIXbK/xSjXiuJWfLhaFLVMZT9GxGlRTRG+FSCsbLMbpRXeUemLZIqm5IeHEcwWysKUQOgqjO0IKyf2g7i53UeWiUfXZuLtendhZ7RiS98bz2DCmoezi0pomjSTGR1kDjLtwvN7/7ETasXuF4XHD5spoD3R6qzpyh1FAYNZ/EjhBJSykVn7FwQFiuQzyWKAU+JBT1bbK6CQz1YcjA0KzTXtbLLfA8zmcB5ZeEcPeNGXOYEwr69mvgUMfzvkal4mcWl44HqWfKlrGD4oB+r+r71HaNF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27vkWcEYiXLAGLBkJAenTIioMG3XlNfx2iLOelLIQQ8=;
 b=PotimvQjw8SxpBcN1/A7kuFBB6sI8gHUYoA/ys3cy/5AZ4r1VW/dgb8hUGru0y1a1dWhR8+zilS3cKvzaOj6KjnCfw0lxPVKnAaAx0A+ICpQKXYZVrhLJEdqRwUwU9gP3PM/MfuDNaJs+dR8p3FTvzYmxuK3E15E2p7mpZgyZFk=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7994.eurprd04.prod.outlook.com (2603:10a6:10:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:18:12 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:18:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Thread-Topic: [PATCH 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Thread-Index: AQHaKbbtWs8y/xZIzk6kBOM+FnEs4rCfK8KAgASuZ0A=
Date: Mon, 11 Dec 2023 10:18:11 +0000
Message-ID:
 <AS8PR04MB8404B2D7CBC562AA0ED2BFD4928FA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
	 <20231208091355.1417292-2-sherry.sun@nxp.com>
 <0cd40cf388e70b101b3857220fd7a74cf75cfa81.camel@pengutronix.de>
In-Reply-To: <0cd40cf388e70b101b3857220fd7a74cf75cfa81.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB7994:EE_
x-ms-office365-filtering-correlation-id: 2cab862a-7100-4afc-9749-08dbfa327ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ysPZ4O0QJdBdlzmqAcXxPM/qn5ybeVQU7Z9IxKMcuYPUHXalmoqSUAJ9zChqyhPBGhxgTEZcGECevhk5MOyZCG5x7bt7gOHt4p9XU88Il/vXTRfZc48vOyjQ1/VsG0kcr0hPiPMc3AvoFd4MJE5ao1HPc7pOmP8Yn3WmK2C8sYK5NvxbYzAWnyOJpGX1pz51Ew6Ma8ynmjxK0gfbVEGNeI7jxxRgvo7uLWg+P2kzv+sUcUGHaoGMPgvZ8sRZqLbdhkcoqr0U6eHavVkKcRX1/9udvOjsygHKSJLSXiYbKMoCWBJW9sGVcj5UoXcU2VjpHir8ErJ0ki/n8TSG2dJQpm0kfwvAFaoJXymJykZXCMUeBIO1Q5kcW2MC9ahoA5XbRJGEfY0/fvMQR0eR4RKmhbhA72mhxE7IgTukgkwMS4yeHiQcqOhJxsCpdfdEaevYLHnv8LOfQ6IaKBwozhfq/7qAon9XWmewnJw53oTTJ0Wbk3hH9198BfrO8/PSU+MBSPkV3nMMzIwmsDZ//pznhmPthJHUgliAwbxtsBSsVZEcagmyjBtx11O8joA2MMIa03XdF7VTOuAIWEBHhlp6MeG0q5GD/AShnrykKMp4hjd6fHGsaRYYiHq7yeIz8ERMAN1PfPwLSGK35OFg1XXPUg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(55016003)(921008)(38100700002)(122000001)(33656002)(86362001)(38070700009)(316002)(83380400001)(52536014)(44832011)(7416002)(5660300002)(53546011)(71200400001)(9686003)(6506007)(7696005)(66556008)(110136005)(66946007)(76116006)(8936002)(8676002)(66476007)(66446008)(64756008)(54906003)(2906002)(41300700001)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1ZOZE5TeHNPb05iL3BseDA0b0xXcGJOcnVnRjhGcjlJMmxsQ2tPVUdBZ1Rp?=
 =?utf-8?B?N21mczVNVmExak83Zitnb3NYSFRMN1ZYeXZDRUhvVkd6OEVxZFJKRTBJODZu?=
 =?utf-8?B?akNEZjExd0JTdllBTTIvalhzYmdKZzNYTnRlNUx0cC9LckNPTDhYK29OakZX?=
 =?utf-8?B?NS9ydXNqdWRsQlcwK3FpdnNNWEtTblFyelk3YjFsbVdqb0VURmF3b1NpOWhw?=
 =?utf-8?B?aWNUaU8yYnJ1TGdjTzFUdXNlRlowd1VEcExXY3V4Y0liYXFTNGdCS0VZVE45?=
 =?utf-8?B?UUNzK3hFUFVwVVBRbVFpODE2bGxmR01NbkNVcytYcXlhRjkxWGN3YjZlR0ww?=
 =?utf-8?B?b2J4RExQM00rU3MzVXl1Y2ZuaU1VeWVTWk9sQjkzL0UzSlI1L0VRTVFwQUw0?=
 =?utf-8?B?K0hNSXZvbjlzZEZIVUJaamY0aTR0RzJYV2wyZER3VTF0Sk1TRkQrSGJqbFE1?=
 =?utf-8?B?QklMRHpSbnkzL3BhL3BGZnIyb2tZTytGVUhZZjNrT3U2N3dyM1dnc3o4bXNR?=
 =?utf-8?B?VXc5ZXJwblFxS1F1RldRK1BwbWR4SllyblJrRmpZRVJqRWNDUVFidlh0bE5v?=
 =?utf-8?B?cUE0NTZiMERsT0tVcnVEOFEyUkFVZk9oVnJaSVV5Y1cyVWx5YkUwYi8yWXND?=
 =?utf-8?B?YzNSQ01yZGlTTkxDOXFHSFZHS20rWGhwdkdYV0hvbFF6VnVIL1pjZ2VlTmY3?=
 =?utf-8?B?UzRaN3VyY0JGeUQ5ZGFaM3hSa1Q4VHhReUtDb0dob0s2dnlRSDNYcDQxN3dM?=
 =?utf-8?B?YUFOcms0VGdaOFhQalBVclJyZnBVVXV2SGdaTm1mbG0xdHRmMUNrQ0RhMENF?=
 =?utf-8?B?dEFKOFlVc3g3SEp3ZW93d0UvV1JCR3hXNUpFZGpVc252QjNUNnB5cXY0djIx?=
 =?utf-8?B?clVpZ0ZKVU5DVjJpZmVwR3ZPZGtLWWdiV0djV3FTandyS0lycnJGNzFZTURq?=
 =?utf-8?B?NkUwYWg2T2N3OU0vNytlL0ZuNHpzTXBwOUczN3BLb0JnVENGcWM2dGV5dnpV?=
 =?utf-8?B?VjNuVlpCaC9pQmJRVWhTQjIxUXBiQnNKclpBOURGb3hxbUFycGJiYUd0Rk9O?=
 =?utf-8?B?V2pjNSs1RGVpd3Jub3E4OTZYQWJ1d01vdk9yTzMrTUJpOWFtd1ljbkJZRlcy?=
 =?utf-8?B?Q2R3ajlkUGFiNEhwTXdneGhyUDBFRVBnNlYzTkswWDVReHhmZUo2ejNTVGZq?=
 =?utf-8?B?QkRaWERhbmYwV01rZWVuSjVMaWc2VHdxRGMrcTc5TE5maVJ6Q2QrQ0I2MEhM?=
 =?utf-8?B?d25ydXU1UTRwdzZmVGpRSFRYQVNTT2w5UWx2czBYaXpyQmtHS0pvNlVQbXdp?=
 =?utf-8?B?eE14Szc1YXVQNnhXK0xHUTRKaThVSHphZ2FncHZJZktqalh1VkNvL0lxb3R4?=
 =?utf-8?B?S2xPOWZnVXpXQWxpL3NCaTBzRWhhVUJacGZ2UlBUbStvUW40SVN1ckU0WWNi?=
 =?utf-8?B?VnJINVh6ZVJhUkJTQnhmSmJsOWhRMlNUNVpBQzUwZC9hQnNmZkowWXJFeEUy?=
 =?utf-8?B?c3o4RUw2K3lVRHA0S3huR1RNRm1PVVhwaEZnTzdQM3BwcHY5TGlRUXBYV1Zh?=
 =?utf-8?B?UEcyeEE1RFEzWCtsanBmdDJkd3dGenpvZnNHV2EwTmNXSVhrTUtINHVzeFEx?=
 =?utf-8?B?UWJiTVpRSFRxakdJT2pKN09KRUtvMWRCckVuOWZVa01HVUNTbnJ1cHNvMkdR?=
 =?utf-8?B?N0hLN0xLVGpodzE1V3ArUlk0MCtUVnhjWnRBRGRGRGpBdlNvbFBORlhZSThL?=
 =?utf-8?B?cFBuTTlXdHBnZXNxRzR3N3ozcGx3V1hFb29qY2NaaEk0Y3IvdkxvYWZHUkF2?=
 =?utf-8?B?TTVOenY2dm04M0xzT0pRMkpoMWVXNHo1dzZMWTJTUi9TeUFuNjN3NGhFQWRh?=
 =?utf-8?B?VWtTVjFVbGhuN2Rua3Z4OFNZMU1jK21RWHJERmRtbGZCSnhiUTZGMTFscjhh?=
 =?utf-8?B?R1JZNGpSem5PWDFpUEw3bGV0VTl5VStDN2I4YVcxRzNEMW5jTXdSM0tDam1w?=
 =?utf-8?B?QTFJSjBhSWNRM284Y1I4c3ZTSjM1WnhuWUlkelp0dnlZNjBmSE9adjlMN0JW?=
 =?utf-8?B?RDJSMEs2QzJVZWhMUGJpTUxSeVExVlNncTZiaFZ0QjlQLy9MR1ExaW1NN3VU?=
 =?utf-8?Q?odpg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cab862a-7100-4afc-9749-08dbfa327ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 10:18:11.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Nh1a2m3C5uwWysZU8BM5fCfMYHWNip6muva3BcLDyUiBLJJWokQQgo2d4HyXbU0vDbo8H4qxBy1Z/jawq1wTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7994

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjPlubQxMuaciDjml6UgMTg6MTYNCj4g
VG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IEhvbmd4aW5nIFpodQ0KPiA8aG9u
Z3hpbmcuemh1QG54cC5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBQQ0k6IGlteDY6
IEFkZCBwY2kgaG9zdCB3YWtldXAgc3VwcG9ydCBvbiBpbXgNCj4gcGxhdGZvcm1zLg0KPiANCj4g
QW0gRnJlaXRhZywgZGVtIDA4LjEyLjIwMjMgdW0gMTc6MTMgKzA4MDAgc2NocmllYiBTaGVycnkg
U3VuOg0KPiA+IEFkZCBwY2kgaG9zdCB3YWtldXAgZmVhdHVyZSBmb3IgaW14IHBsYXRmb3Jtcy4N
Cj4gPiBFeGFtcGxlIG9mIGNvbmZpZ3VyaW5nIHRoZSBjb3JyZXNwb25kaW5nIGR0cyBwcm9wZXJ0
eSB1bmRlciB0aGUgUENJDQo+ID4gbm9kZToNCj4gPiBob3N0LXdha2UtZ3BpbyA9IDwmZ3BpbzUg
MjEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4g
PHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jIHwgNjkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNzQ3MDMzNjJhZWVjLi4wNTBjOTE0
MGY0YTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBAQCAtNzIsNiArNzIsNyBAQCBzdHJ1Y3QgaW14Nl9wY2llX2RydmRhdGEgeyAgc3RydWN0IGlt
eDZfcGNpZSB7DQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZQkJKnBjaTsNCj4gPiAgCWludAkJCXJlc2V0
X2dwaW87DQo+ID4gKwlpbnQJCQlob3N0X3dha2VfaXJxOw0KPiA+ICAJYm9vbAkJCWdwaW9fYWN0
aXZlX2hpZ2g7DQo+ID4gIAlib29sCQkJbGlua19pc191cDsNCj4gPiAgCXN0cnVjdCBjbGsJCSpw
Y2llX2J1czsNCj4gPiBAQCAtMTIzNywxMSArMTIzOCw0NiBAQCBzdGF0aWMgaW50IGlteDZfcGNp
ZV9yZXN1bWVfbm9pcnEoc3RydWN0DQo+IGRldmljZSAqZGV2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGlteDZfcGNpZV9zdXNwZW5kKHN0cnVjdCBkZXZp
Y2UgKmRldikgew0KPiA+ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+aG9zdF93YWtlX2lycSA+
PSAwKQ0KPiA+ICsJCWVuYWJsZV9pcnFfd2FrZShpbXg2X3BjaWUtPmhvc3Rfd2FrZV9pcnEpOw0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGlt
eDZfcGNpZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgaW14Nl9w
Y2llICppbXg2X3BjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAo
aW14Nl9wY2llLT5ob3N0X3dha2VfaXJxID49IDApDQo+ID4gKwkJZGlzYWJsZV9pcnFfd2FrZShp
bXg2X3BjaWUtPmhvc3Rfd2FrZV9pcnEpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgaW14Nl9wY2llX3Bt
X29wcyA9IHsNCj4gPiAgCU5PSVJRX1NZU1RFTV9TTEVFUF9QTV9PUFMoaW14Nl9wY2llX3N1c3Bl
bmRfbm9pcnEsDQo+ID4gIAkJCQkgIGlteDZfcGNpZV9yZXN1bWVfbm9pcnEpDQo+ID4gKwlTWVNU
RU1fU0xFRVBfUE1fT1BTKGlteDZfcGNpZV9zdXNwZW5kLCBpbXg2X3BjaWVfcmVzdW1lKQ0KPiA+
ICB9Ow0KPiA+DQo+ID4gK2lycXJldHVybl90IGhvc3Rfd2FrZV9pcnFfaGFuZGxlcihpbnQgaXJx
LCB2b2lkICpwcml2KSB7DQo+ID4gKwlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSBwcml2
Ow0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gaW14Nl9wY2llLT5wY2ktPmRldjsNCj4gPiAr
DQo+ID4gKwlkZXZfZGJnKGRldiwgIiVzOiBob3N0IHdha2V1cCBieSBwY2llIiwgX19mdW5jX18p
Ow0KPiA+ICsNCj4gTm90IHN1cmUgaG93IG11Y2ggdmFsdWUgdGhpcyBkZWJ1ZyBwcmludCBjYXJy
aWVzLiBJZiB5b3Ugd2FudCB0byBrZWVwIGl0LA0KPiBkcm9wIHRoZSBfX2Z1bmNfXy4gVGhlcmUg
aXMgbm8gb3RoZXIgcGxhY2UgaW4gdGhpcyBkcml2ZXIgaGFuZGxpbmcgdGhlIHdha2V1cCwNCj4g
c28gdGhlIGZ1bmN0aW9uIG5hbWUgaW4gdGhlIHByaW50IGlzIHB1cmUgbm9pc2UuDQoNCk9rLCB3
aWxsIHJlbW92ZSB0aGUgZGVidWcgcHJpbnQgaW5mbyBoZXJlLg0KDQo+IA0KPiA+ICsJLyogTm90
aWZ5IFBNIGNvcmUgd2UgYXJlIHdha2V1cCBzb3VyY2UgKi8NCj4gPiArCXBtX3dha2V1cF9ldmVu
dChkZXYsIDApOw0KPiA+ICsJcG1fc3lzdGVtX3dha2V1cCgpOw0KPiA+ICsNCj4gPiArCXJldHVy
biBJUlFfSEFORExFRDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBpbXg2X3BjaWVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gQEAgLTEyNTAsNiArMTI4Niw3IEBAIHN0YXRpYyBp
bnQgaW14Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpkYmlfYmFz
ZTsNCj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiAr
CXN0cnVjdCBncGlvX2Rlc2MgKmhvc3Rfd2FrZV9ncGlvOw0KPiA+ICAJaW50IHJldDsNCj4gPiAg
CXUxNiB2YWw7DQo+ID4NCj4gPiBAQCAtMTQ1Nyw2ICsxNDk0LDMyIEBAIHN0YXRpYyBpbnQgaW14
Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJCXZh
bCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsNCj4gPiAgCQkJZHdfcGNpZV93cml0ZXdfZGJpKHBj
aSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUywNCj4gdmFsKTsNCj4gPiAgCQl9DQo+ID4gKw0KPiA+
ICsJCS8qIGhvc3Qgd2FrZXVwIHN1cHBvcnQgKi8NCj4gPiArCQlpbXg2X3BjaWUtPmhvc3Rfd2Fr
ZV9pcnEgPSAtMTsNCj4gPiArCQlob3N0X3dha2VfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsKGRldiwgImhvc3QtDQo+IHdha2UiLCBHUElPRF9JTik7DQo+ID4gKwkJaWYgKElTX0VSUiho
b3N0X3dha2VfZ3BpbykpDQo+ID4gKwkJCXJldHVybiBQVFJfRVJSKGhvc3Rfd2FrZV9ncGlvKTsN
Cj4gPiArDQo+ID4gKwkJaWYgKGhvc3Rfd2FrZV9ncGlvICE9IE5VTEwpIHsNCj4gPiArCQkJaW14
Nl9wY2llLT5ob3N0X3dha2VfaXJxID0NCj4gZ3Bpb2RfdG9faXJxKGhvc3Rfd2FrZV9ncGlvKTsN
Cj4gPiArCQkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShkZXYsIGlteDZfcGNpZS0N
Cj4gPmhvc3Rfd2FrZV9pcnEsIE5VTEwsDQo+ID4gKw0KPiAJaG9zdF93YWtlX2lycV9oYW5kbGVy
LA0KPiA+ICsJCQkJCQkJSVJRRl9PTkVTSE9UIHwNCj4gSVJRRl9UUklHR0VSX0ZBTExJTkcsDQo+
ID4gKwkJCQkJCQkiaG9zdF93YWtlIiwNCj4gaW14Nl9wY2llKTsNCj4gPiArCQkJaWYgKHJldCkg
ew0KPiA+ICsJCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVxdWVzdA0KPiBob3N0X3dha2Vf
aXJxICVkICglZClcbiIsDQo+ID4gKwkJCQkJaW14Nl9wY2llLT5ob3N0X3dha2VfaXJxLCByZXQp
Ow0KPiA+ICsJCQkJaW14Nl9wY2llLT5ob3N0X3dha2VfaXJxID0gLTE7DQo+IA0KPiBXaGF0J3Mg
dGhlIHBvaW50IG9mIHJlc2V0dGluZyBob3N0X3dha2VfaXJxIHRvIC0xIGluIHRob3NlIGVycm9y
IHBhdGhzPw0KPiBOb2JvZHkgaXMgZ29pbmcgdG8gYWNjZXNzIHRoaXMgbWVtYmVyIGFueW1vcmUg
YWZ0ZXIgdGhlIGVycm9yLiBKdXN0IGRyb3ANCj4gdGhpcy4NCj4gDQo+IFlvdSBjb3VsZCBzaW1w
bGlmeSBhbGwgdGhvc2UgZXJyb3IgcGF0aHMgdG8gaWYgKGVycikNCj4gICAgIHJldHVybiBkZXZf
ZXJyX3Byb2JlKC4uLik7DQoNClNvdW5kcyByZWFzb25hYmxlLCBJIHdpbGwgcmVtb3ZlIHRoZSBo
b3N0X3dha2VfaXJxIHJlc2V0dGluZyBoZXJlIGFuZCB1c2UgZGV2X2Vycl9wcm9iZSgpIGluc3Rl
YWQsIHRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==

