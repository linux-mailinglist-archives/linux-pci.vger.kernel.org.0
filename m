Return-Path: <linux-pci+bounces-1811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42296826EFC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50EE1F22F6C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE68405D5;
	Mon,  8 Jan 2024 12:51:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2075.outbound.protection.partner.outlook.cn [139.219.17.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EED405CA;
	Mon,  8 Jan 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUZjeC+ZgmSFj+kg6r2EM9qXex36H2NSpKTxfaz1BjEl2JmRXzirIi+YUWs69Ka12oU3U97zqcxogasyd2vdHxRwd/Oew9dZ24ZZhR/NuI4SILRd4Z7Wm7vnVXzQpXdqO2XTIZKKfA2uDaG9W6fTisFUXwOee5feHsUNz286R5mTt6n4aa+/eO37CkBdcbZ/Uk+FiyPAfO/G3TtVUB9Y4izsVpf75wN8B6V8PBX4+bDRKoA46tW5PmNpUt3BxOmtWcG42S+vYn8wOy2QiGvQvghifNNXwAOIMItPmpuqQBI8IoGEiEdO3dhyxe3hWBxjIyTG189vz/txrQBgbhqjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1o7bCoX34xTloBkWTBewY42FX7BuUZ7tjcFFhrXpQA=;
 b=d350KEO8GbQvXj5PHzG5HT84XaonjO9E5Vojrr8xwxGipvESixDjGbM04dHV/uupedCHrvOp+g8FhWQ2+2QZWKFFwMx7hLZBtBz9QE7zWsGPGpLk3/d6WBcMj9RKD/NfFwBgmT0JJT8kpzd5WU9Tt1EERWV/ECC6cEZk2HEgSepupSbYdGaS/wURIyNTUoDKorQ1dmZ4DtJ1zk3Fyj64kdqulfjgWUnDgEo7EJljFKFl3rx6grNFyrrbvI0u4PPE7ljWesEec3iEgJuhFGhWeFj3d/GbYYQZ6kVYBlfgxt8e2gAfREUBtjZ04n0fMrfi+1U1c6N51N2q39BnsLy5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:17:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:17:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Daire
 McNamara <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxNCAxNS8yMl0gUENJOiBtaWNyb2NoaXA6IEFkZCBl?=
 =?gb2312?B?dmVudCBpcnFjaGlwIGZpZWxkIHRvIGhvc3QgcG9ydCBhbmQgYWRkIFBMREEg?=
 =?gb2312?Q?irqchip?=
Thread-Topic: [PATCH v14 15/22] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Thread-Index: AQHaQiLICxpq4+TOk02iQb9xA+EcbrDPwo1Q
Date: Mon, 8 Jan 2024 11:17:19 +0000
Message-ID:
 <SHXPR01MB0863F00F7D735A9B7189948BE66BA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
 <20240108110612.19048-16-minda.chen@starfivetech.com>
In-Reply-To: <20240108110612.19048-16-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
x-ms-office365-filtering-correlation-id: 56692050-359f-4822-2e73-08dc103b6116
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k8thw8rWh+IMgINN7yJoFIkoih4+qdeeKsXJCAYleOA8drXNy+qpVskyWRCnboRuK6C+sqFO9yfXlA4GPMjf+3IfgyF/qMPXL7CNK91ZFu9x64QickjAQ7BOOeO23NWJ7k6oU5Y5yQQOtKySYOKEGHe0wkLKSAwBh6WQfPQ7z+jvFFfq+c7tuooZ0U6+Idaur0MKy9gELuZXPRwNYX4t1uVVYJ+eUX1VJLsqBQMUbV+FU7Z5pXmZfH/qNeMEXSG7SOOJ4DWVW3IjDbjClWwvqm8rsNi82MDRMQaFbPe9QEfmEVAD9LgJUnYpV7dgKYY/p/K5Ya9hJ2KtByZVPJJriBn/CdEsjjdCeGCKlkeTG5kIBsM58Eepd1QKChbeQxoKwjDC/SxGqd6d5VfODnC0cqwpzCJihImyxdRtE3qRNmkwIMbsLNIdbmwWAIu7tsKjEkCR9lqkOUlBuPq5a+m2IZ7cgHUwjxAiKjsB/CNLXbn6f3Q3MByQ+vTTUyktPgHUpGYNlxeLksl5GXMPgObhmV4uh8eCl78DP1XDc+Sp//9e95ptiTUXDdx9l5VoKdXg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(4326008)(2906002)(55016003)(44832011)(8936002)(54906003)(110136005)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(33656002)(224303003)(41320700001)(508600001)(71200400001)(38070700009)(7696005)(9686003)(107886003)(26005)(41300700001)(40180700001)(83380400001)(122000001)(38100700002)(86362001)(40160700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZmJkSWU5NmlHZkVLNFlGSlJCcmNXRVZlOUl6M05DYVFYT0haSTZGQ3QvZW5X?=
 =?gb2312?B?RHVKMGoyV0RkZXhzODZrMFFiS1l3R1JJbVowYy9rVXcvZmpmMUlFSERqNnBp?=
 =?gb2312?B?SmlZazZrV3VUaVovM1I4NFcraUkyb0U2WTR1WlYwSFBaL0piWE45VHE2aDdM?=
 =?gb2312?B?QnFXSi9xajhicXhVYzFORmd3SkdJSmgrSXdIb01XcEFOdG5McEt1YnJUS0xh?=
 =?gb2312?B?WVVyOTUrdkc2VDdDR2QraHJtc09INXNLVGZTTWJZRVE4ek5MSEM1VHRsc2F0?=
 =?gb2312?B?OFpiNThLYW5wUWswS2prOWVkemw1a1Bab3ZGQzM2TDJCZy92amsxejZpWFpY?=
 =?gb2312?B?UjlrL3RhdE5rVWQ1aytUYUpMUVpPWmd0cmNaMjJaOWZXTldZU05kcDRkenpG?=
 =?gb2312?B?MWhpcDJtOTNIZHlDeGRINEVoWVNFZGNSMjZaa2xndFdkMVFnQ0ZQSHkwKzV5?=
 =?gb2312?B?Q0N4VEc3N29DaTkvUHU1VVNMVUxyRmZZUDQ2T3Q2RHV5ZENHS29uaW0rNTAz?=
 =?gb2312?B?bCtPZERwSHlFeUl5NnNjb3huczk5OGVOdHZrSEUyOXZXRTRyNXdVYzR4SEdP?=
 =?gb2312?B?VXFiN1prQmJQYUZtT3VpTWs0aU5XblNtRktjZ042am9MQUZNcThlTkdpOGRC?=
 =?gb2312?B?M2g0UzFNQmZmenNiYjAwRUNwS2FLNVFYMFVHaFEwcWh4NE44K0orcUNkWmxx?=
 =?gb2312?B?Sm82Y01rSnF2WmdKTXIzbzZuMGxDYW4wMGFSZjdURkxYU3pFNVN5Mk1ESkw5?=
 =?gb2312?B?dkhIRGtQNFVkS2JWRDJDZExRajQ3cXFaa1VJamxGanoxaEt5OXdFQ1JCTVVZ?=
 =?gb2312?B?OEJubjBQLzFPLzlCS2Q3VE96Y0pMdjIyeXJ3RUNUbURaVE8rRkIvTWowRmlw?=
 =?gb2312?B?MThZMktVR0tTcWNrZjQzbGhGUVM0clpXemlDUkt0MkM4cmJ6ZE5Ba2xPZ3oz?=
 =?gb2312?B?eGZkWlFjSEJEUHBxUmJuSVpWU3V4bGpMZXc4YnhMaWs1VFk5a3RUQStQaHN2?=
 =?gb2312?B?cnJRVGFGeVF3K0xOczhjMnpFd3dFRUd6bGxONCsxWkdOT04zQmptTnFKcnJE?=
 =?gb2312?B?QVdYc1FyVHh1d29NeHRLYUcvZkE4WUQ3aTFpL0t2R3pWcHhlaUNKa0JvOElj?=
 =?gb2312?B?TnBNaXhSampqQmtkeHM2bDlxTmpacStwMllLYnpYSU5iaGFyb2N2cGpjZnlO?=
 =?gb2312?B?ZVhLdUFYMitPNE5GQkpjZzdJbGhmRGJhMDVlT2xpejdkSkRPZU5UMXp4ZXcw?=
 =?gb2312?B?ZXgzbkx2ekI2b3pTODY5K2FxaG5SalhXQ0dJR0hwM3FXaHlMMUh5WWIyRHlk?=
 =?gb2312?B?aGhiZU9lVTVCdk53T1p2RXdXRE8wSWpsb2xoMlNwNkZKWWN2ZkplVjIvUzRU?=
 =?gb2312?B?Rm9FMTNLQWxEanNHV0NxWjE0QlVwb3ppd2J3VjRlSVZwNzYvbUExSlc1WFBi?=
 =?gb2312?B?ZHNjcXhzUGo4MS9xNy9wcXVuZ0NnVFAvNnZSUFVBa29EeVluYmdaVjlWMm1w?=
 =?gb2312?B?M3J1ZlNuLzdsUVpiUnhHOGlXWE5VM1IvM2d1SGRTby84dGVkZ0ZvQ1YyOGFn?=
 =?gb2312?B?V1JUd1Y2UFp2MUVrUi83d2hlVXR2dVRxbUtzVHhYTGY4TzYvVE5aalBrVDIx?=
 =?gb2312?B?ZU82RU8wRVFwb2dvMGhBeVVDRENVWVd0RjhOdjZ0d3VFb1BHdXJXYnRuT3NB?=
 =?gb2312?B?TnFJNWtSTWs5Q3gwRXBkbXdib3hrWnAxallEak15dDU4clRZZk5sdW1iT252?=
 =?gb2312?B?blFidlVYd2xrZXFyOUYzUjlvZ0tsNjMwbjdCbDcyck5kNVloRE8wbXhDU3A5?=
 =?gb2312?B?ajVjUXZxc1JDaDJHa3BIWXBTNlFBdEhzQjhkeUpacHN5VEp0QkhUQkl4VVRr?=
 =?gb2312?B?d1huVC9palFSSDdNR3Nyek5OMDIwWFcxZkFoRjhkYXVDdTRPM0UycGZ0ODd5?=
 =?gb2312?B?dXF0V3R2L2pJdUpjL1ZzZUxjT0lqbFM2MXBreWV4cURqUjNRM1FZc1lZZHJM?=
 =?gb2312?B?Wk1rQ0gveDUyUThKdmcrYWZCWWdZZm5oL3M1YjB6aVJGRHpiVC93SVZYYjJW?=
 =?gb2312?B?bDZEUkQzUXQrYitXRXhpK01WczltclRBZzR2WUgvNS9MMXNsZTZxOXlxclZa?=
 =?gb2312?B?K1ZMSUp5VXdnRXhlRUlLRmVRY0dvTlBVTGRHZ0U1Y0hHUE10SjBHYjlMLzBG?=
 =?gb2312?B?Z0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 56692050-359f-4822-2e73-08dc103b6116
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 11:17:19.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoMWnporRjOF7jaDJwp+bp2CPp9Xo9dbF1Qb8f3GiOP0XBdyneKj03KottjFTyfazMtTvALHX6lWeZR7OZEmyBezYFHLhpihuHJqtARupEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512

DQoNCj4g1vfM4jogW1BBVENIIHYxNCAxNS8yMl0gUENJOiBtaWNyb2NoaXA6IEFkZCBldmVudCBp
cnFjaGlwIGZpZWxkIHRvIGhvc3QgcG9ydCBhbmQNCj4gYWRkIFBMREEgaXJxY2hpcA0KPiANCj4g
QXMgUExEQSBkdHMgYmluZGluZyBkb2MoRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS8NCj4gcGxkYSx4cHJlc3NyaWNoMy1heGktY29tbW9uLnlhbWwpIHNob3dlcywgUExEQSBQ
Q0llIGNvbnRhaW5zIGFuIGludGVycnVwdA0KPiBjb250cm9sbGVyLg0KPiANCj4gTWljcm9jaGlw
IFBvbGFyRmlyZSBQQ0lFIGV2ZW50IElSUXMgaW5jbHVkZXMgUExEQSBpbnRlcnJ1cHRzIGFuZCBQ
b2xhcmZpcmUgdGhlaXINCj4gb3duIGludGVycnVwdHMuIFRoZSBpbnRlcnJ1cHQgaXJxY2hpcCBv
cHMgaW5jbHVkZXMgYWNrL21hc2svdW5tYXNrIGludGVycnVwdA0KPiBvcHMsIHdoaWNoIHdpbGwg
d3JpdGUgY29ycmVjdCByZWdpc3RlcnMuDQo+IE1pY3JvY2hpcCBQb2xhcmZpcmUgUENJZSBhZGRp
dGlvbmFsIGludGVycnVwdHMgcmVxdWlyZSB0byB3cml0ZSBQb2xhcmZpcmUgU29DDQo+IHNlbGYt
ZGVmaW5lZCByZWdpc3RlcnMuIFNvIE1pY3JvY2hpcCBQQ0llIGV2ZW50IGlycWNoaXAgb3BzIGNh
biBub3QgYmUgcmUtdXNlZC4NCj4gDQo+IFRvIHN1cHBvcnQgUExEQSBpdHMgb3duIGV2ZW50IElS
USBwcm9jZXNzLCBpbXBsZW1lbnRzIFBMREEgaXJxY2hpcCBvcHMgYW5kDQo+IGFkZCBldmVudCBp
cnFjaGlwIGZpZWxkIHRvIHN0cnVjdCBwY2llX3BsZGFfcnAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+IEFja2VkLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIC4uLi9w
Y2kvY29udHJvbGxlci9wbGRhL3BjaWUtbWljcm9jaGlwLWhvc3QuYyB8IDY2ICsrKysrKysrKysr
KysrKysrKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXBsZGEuaCAgICAg
ICB8ICA1ICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3Bj
aWUtbWljcm9jaGlwLWhvc3QuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2ll
LW1pY3JvY2hpcC1ob3N0LmMNCj4gaW5kZXggYjNkZjM3M2EyMTQxLi5iZWFmNWMyN2RhODQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLW1pY3JvY2hpcC1o
b3N0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUtbWljcm9jaGlw
LWhvc3QuYw0KPiBAQCAtNzcwLDYgKzc3MCw2NCBAQCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIG1j
X2V2ZW50X2lycV9jaGlwID0gew0KPiAgCS5pcnFfdW5tYXNrID0gbWNfdW5tYXNrX2V2ZW50X2ly
cSwNCj4gIH07DQo+IA0KPiArc3RhdGljIHUzMiBwbGRhX2h3aXJxX3RvX21hc2soaW50IGh3aXJx
KSB7DQo+ICsJdTMyIG1hc2s7DQo+ICsNCj4gKwkvKiBod2lycSAyMyAtIDAgYXJlIHRoZSBzYW1l
IHdpdGggcmVnaXN0ZXIgKi8NCj4gKwlpZiAoaHdpcnEgPCBFVkVOVF9QTV9NU0lfSU5UX0lOVFgp
DQo+ICsJCW1hc2sgPSBCSVQoaHdpcnEpOw0KPiArCWVsc2UgaWYgKGh3aXJxID09IEVWRU5UX1BN
X01TSV9JTlRfSU5UWCkNCj4gKwkJbWFzayA9IFBNX01TSV9JTlRfSU5UWF9NQVNLOw0KPiArCWVs
c2UNCj4gKwkJbWFzayA9IEJJVChod2lycSArIFBDSV9OVU1fSU5UWCAtIDEpOw0KPiArDQo+ICsJ
cmV0dXJuIG1hc2s7DQo+ICt9DQo+ICsNCkhpIFRvbWFzDQpwbGRhX2h3aXJxX3RvX21hc2sgKCkg
aXMgZXZlbnQgdG8gcmVnaXN0ZXIgbWFwcGluZy4NCg0KcmVnaXN0ZXIgYml0ICAgICAgZXZlbnQN
CjAgICAgICAgICAgICAgICAgICAwDQoNCnwgICAgICAgICAgICAgICAgICB8DQp8ICAgICAgICAg
ICAgICAgICAgfA0KMjMgICAgICAgICAgICAgICAgMjMNCjI0ICAtLS0tPiAgICAgICAgIDI0IChp
bnR4KQ0KfCAgICAgfA0KMjcgIC0tLSsNCjI4ICAgICAgICAgICAgICAgIDI1DQp8ICAgICAgICAg
ICAgICAgICAgfA0KMzEgICAgICAgICAgICAgICAgMjgNCg0KPiArc3RhdGljIHZvaWQgcGxkYV9h
Y2tfZXZlbnRfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkgew0KPiArCXN0cnVjdCBwbGRhX3Bj
aWVfcnAgKnBvcnQgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCj4gKw0KPiAr
CXdyaXRlbF9yZWxheGVkKHBsZGFfaHdpcnFfdG9fbWFzayhkYXRhLT5od2lycSksDQo+ICsJCSAg
ICAgICBwb3J0LT5icmlkZ2VfYWRkciArIElTVEFUVVNfTE9DQUwpOyB9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIHBsZGFfbWFza19ldmVudF9pcnEoc3RydWN0IGlycV9kYXRhICpkYXRhKSB7DQo+ICsJ
c3RydWN0IHBsZGFfcGNpZV9ycCAqcG9ydCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGRh
dGEpOw0KPiArCXUzMiBtYXNrLCB2YWw7DQo+ICsNCj4gKwltYXNrID0gcGxkYV9od2lycV90b19t
YXNrKGRhdGEtPmh3aXJxKTsNCj4gKw0KPiArCXJhd19zcGluX2xvY2soJnBvcnQtPmxvY2spOw0K
PiArCXZhbCA9IHJlYWRsX3JlbGF4ZWQocG9ydC0+YnJpZGdlX2FkZHIgKyBJTUFTS19MT0NBTCk7
DQo+ICsJdmFsICY9IH5tYXNrOw0KPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcG9ydC0+YnJpZGdl
X2FkZHIgKyBJTUFTS19MT0NBTCk7DQo+ICsJcmF3X3NwaW5fdW5sb2NrKCZwb3J0LT5sb2NrKTsN
Cj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgcGxkYV91bm1hc2tfZXZlbnRfaXJxKHN0cnVjdCBp
cnFfZGF0YSAqZGF0YSkgew0KPiArCXN0cnVjdCBwbGRhX3BjaWVfcnAgKnBvcnQgPSBpcnFfZGF0
YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCj4gKwl1MzIgbWFzaywgdmFsOw0KPiArDQo+ICsJ
bWFzayA9IHBsZGFfaHdpcnFfdG9fbWFzayhkYXRhLT5od2lycSk7DQo+ICsNCj4gKwlyYXdfc3Bp
bl9sb2NrKCZwb3J0LT5sb2NrKTsNCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBvcnQtPmJyaWRn
ZV9hZGRyICsgSU1BU0tfTE9DQUwpOw0KPiArCXZhbCB8PSBtYXNrOw0KPiArCXdyaXRlbF9yZWxh
eGVkKHZhbCwgcG9ydC0+YnJpZGdlX2FkZHIgKyBJTUFTS19MT0NBTCk7DQo+ICsJcmF3X3NwaW5f
dW5sb2NrKCZwb3J0LT5sb2NrKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHN0cnVjdCBpcnFfY2hp
cCBwbGRhX2V2ZW50X2lycV9jaGlwID0gew0KPiArCS5uYW1lID0gIlBMREEgUENJZSBFVkVOVCIs
DQo+ICsJLmlycV9hY2sgPSBwbGRhX2Fja19ldmVudF9pcnEsDQo+ICsJLmlycV9tYXNrID0gcGxk
YV9tYXNrX2V2ZW50X2lycSwNCj4gKwkuaXJxX3VubWFzayA9IHBsZGFfdW5tYXNrX2V2ZW50X2ly
cSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxkYV9ldmVudF9vcHMgcGxk
YV9ldmVudF9vcHMgPSB7DQo+ICAJLmdldF9ldmVudHMgPSBwbGRhX2dldF9ldmVudHMsDQo+ICB9
Ow0KPiBAQCAtNzc3LDcgKzgzNSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxkYV9ldmVudF9v
cHMgcGxkYV9ldmVudF9vcHMgPQ0KPiB7ICBzdGF0aWMgaW50IHBsZGFfcGNpZV9ldmVudF9tYXAo
c3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgaW50IGlycSwNCj4gIAkJCSAgICAg
ICBpcnFfaHdfbnVtYmVyX3QgaHdpcnEpDQo+ICB7DQo+IC0JaXJxX3NldF9jaGlwX2FuZF9oYW5k
bGVyKGlycSwgJm1jX2V2ZW50X2lycV9jaGlwLCBoYW5kbGVfbGV2ZWxfaXJxKTsNCj4gKwlzdHJ1
Y3QgcGxkYV9wY2llX3JwICpwb3J0ID0gKHZvaWQgKilkb21haW4tPmhvc3RfZGF0YTsNCj4gKw0K
PiArCWlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsIHBvcnQtPmV2ZW50X2lycV9jaGlwLCBo
YW5kbGVfbGV2ZWxfaXJxKTsNCj4gIAlpcnFfc2V0X2NoaXBfZGF0YShpcnEsIGRvbWFpbi0+aG9z
dF9kYXRhKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IEBAIC05NjIsNiArMTAyMiw5IEBAIHN0YXRp
YyBpbnQgcGxkYV9pbml0X2ludGVycnVwdHMoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
diwNCj4gIAlpZiAoIXBvcnQtPmV2ZW50X29wcykNCj4gIAkJcG9ydC0+ZXZlbnRfb3BzID0gJnBs
ZGFfZXZlbnRfb3BzOw0KPiANCj4gKwlpZiAoIXBvcnQtPmV2ZW50X2lycV9jaGlwKQ0KPiArCQlw
b3J0LT5ldmVudF9pcnFfY2hpcCA9ICZwbGRhX2V2ZW50X2lycV9jaGlwOw0KPiArDQo+ICAJcmV0
ID0gcGxkYV9wY2llX2luaXRfaXJxX2RvbWFpbnMocG9ydCk7DQo+ICAJaWYgKHJldCkgew0KPiAg
CQlkZXZfZXJyKGRldiwgImZhaWxlZCBjcmVhdGluZyBJUlEgZG9tYWluc1xuIik7IEBAIC0xMDM5
LDYgKzExMDIsNw0KPiBAQCBzdGF0aWMgaW50IG1jX3BsYXRmb3JtX2luaXQoc3RydWN0IHBjaV9j
b25maWdfd2luZG93ICpjZmcpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiAgCXBvcnQtPnBsZGEu
ZXZlbnRfb3BzID0gJm1jX2V2ZW50X29wczsNCj4gKwlwb3J0LT5wbGRhLmV2ZW50X2lycV9jaGlw
ID0gJm1jX2V2ZW50X2lycV9jaGlwOw0KPiANCj4gIAkvKiBBZGRyZXNzIHRyYW5zbGF0aW9uIGlz
IHVwOyBzYWZlIHRvIGVuYWJsZSBpbnRlcnJ1cHRzICovDQo+ICAJcmV0ID0gcGxkYV9pbml0X2lu
dGVycnVwdHMocGRldiwgJnBvcnQtPnBsZGEsICZtY19ldmVudCk7IGRpZmYgLS1naXQNCj4gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1wbGRhLmgNCj4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BsZGEvcGNpZS1wbGRhLmgNCj4gaW5kZXggOWRiOTJjY2YyODZjLi5hM2NlMDE3
MzViZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXBs
ZGEuaA0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1wbGRhLmgNCj4g
QEAgLTEwNyw3ICsxMDcsOSBAQCBlbnVtIHBsZGFfaW50X2V2ZW50IHsNCj4gDQo+ICAjZGVmaW5l
IFBMREFfTlVNX0RNQV9FVkVOVFMJCQkxNg0KPiANCj4gLSNkZWZpbmUgUExEQV9NQVhfSU5UX05V
TQkJCShQTERBX05VTV9ETUFfRVZFTlRTICsNCj4gUExEQV9JTlRfRVZFTlRfTlVNKQ0KPiArI2Rl
ZmluZSBFVkVOVF9QTV9NU0lfSU5UX0lOVFgJCQkoUExEQV9OVU1fRE1BX0VWRU5UUyArDQo+IFBM
REFfSU5UWCkNCj4gKyNkZWZpbmUgRVZFTlRfUE1fTVNJX0lOVF9NU0kJCQkoUExEQV9OVU1fRE1B
X0VWRU5UUyArDQo+IFBMREFfTVNJKQ0KPiArI2RlZmluZSBQTERBX01BWF9FVkVOVF9OVU0JCQko
UExEQV9OVU1fRE1BX0VWRU5UUyArDQo+IFBMREFfSU5UX0VWRU5UX05VTSkNCj4gDQo+ICAvKg0K
PiAgICogUExEQSBpbnRlcnJ1cHQgcmVnaXN0ZXINCj4gQEAgLTE1NSw2ICsxNTcsNyBAQCBzdHJ1
Y3QgcGxkYV9wY2llX3JwIHsNCj4gIAlyYXdfc3BpbmxvY2tfdCBsb2NrOw0KPiAgCXN0cnVjdCBw
bGRhX21zaSBtc2k7DQo+ICAJY29uc3Qgc3RydWN0IHBsZGFfZXZlbnRfb3BzICpldmVudF9vcHM7
DQo+ICsJY29uc3Qgc3RydWN0IGlycV9jaGlwICpldmVudF9pcnFfY2hpcDsNCj4gIAl2b2lkIF9f
aW9tZW0gKmJyaWRnZV9hZGRyOw0KPiAgCWludCBudW1fZXZlbnRzOw0KPiAgfTsNCj4gLS0NCj4g
Mi4xNy4xDQoNCg==

