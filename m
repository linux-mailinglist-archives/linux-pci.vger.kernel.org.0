Return-Path: <linux-pci+bounces-42688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6ECA6DCB
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF6B315A97A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323433B95C;
	Fri,  5 Dec 2025 09:16:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF4315D40;
	Fri,  5 Dec 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926185; cv=fail; b=bfPkXr0O6GtyvxAbx9vQz410oYfUxYg1M6Xe3Ol7m+2gXWhgcLhhipF4Sar2f6AX7e/CWSatqpcXRFXHiu18KjssPN6LVMUOkQYn0IJHEMhh0OpnCTVYjH4rX4FO6B004mrTYQWuUhBfmLmPqegmVF6WfMwYBah1xK6qb4p+aM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926185; c=relaxed/simple;
	bh=Tgu2V/X8jNkOmo2VN2FOWperMZoUk69OHgrmYx0n+Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWNncLaiuSrWZDLTjUho7uaePkotRGEuAtVu/8XbhRydHE9JeyqzbtQi5Bv+ALKtJM/IMGE7P9u0t9bxgjOoqA6hnV/1ltDntxH5Du9VE8CpDEIN/t7A++SA1MHbytq/ntuQ6rdAlVG8r3L4ozzHsVZHh0a8nR/uMEnRXmEUgh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfDujxF7dd9XAQAyYHdwmHQEzNcqRYX74geMXSTC8eU2WpdY/L4MabGwXljhuKqDu7fkIPCSloR5NKqHuzXeqmCOm9q7+fOTU24ssU1sAMkBwemBfBzSYmR68lDuvHwk1UFnn627VfitwPlXxrlFoMa9yoIN3lidbmE4RYDFHUFc2Ic5oCq/ZUzSGgpAJsYC95slZ9gtgdS1zCDztFi/fUj0p6QQ48QDuptev14HrMX4MwolmJcRQIxpyHOiJtGaRT+dpG6icFUCyi1jKlD38LpMw+gBPQTXGbg3Ik/WMBP1HfcTtw+ug4SAjlZ10SA5gFvIi9R8mE4vFV7rwDGs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgu2V/X8jNkOmo2VN2FOWperMZoUk69OHgrmYx0n+Dk=;
 b=IJBYuK7Q1d/3uy7dT2wJ6uoSt2mLgsWDZLepfhHTJCavvnIxAYKB1k9WvGvGfp7gC5wAeWGcM79xRvO6G0tHsNtJcs53JXvgQ6j8dJEkh1tcq3zDi1pjTag9yMHrg8z4x5yvNzWSmlKDBxO84V/mrhTsTPy7CfCnTa0fXPDuwpxoEvEdW797Ly4X8QSIS6m7s40aNO14DJGADa2AIXQMiPojvCndrjxFD0OBHqpJg3Oq0W7Bt8Y0cfupS/SwRLP+VQmjsg6wYX8cAznGoOfTFwgoFbUm0fVnJxwn75woFQMXaGflqs4Npsb9okFRhSZByBR3xo48nsGDdZuZehMqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1163.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 07:41:49 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 07:41:49 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for
 VisionFive 2 Lite variants
Thread-Topic: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for
 VisionFive 2 Lite variants
Thread-Index: AQHcXeD7iJDD+48Vx0WE8jBy+XuFyrURxH6AgADyShA=
Date: Fri, 5 Dec 2025 07:41:49 +0000
Message-ID:
 <ZQ2PR01MB13076311CBBFE5B948F394FCE6A72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-5-hal.feng@starfivetech.com>
 <CANAwSgQSBB_yTw5rDz2w6utvjUueWJi9tWUY9oZcpNAT8Wm8iA@mail.gmail.com>
In-Reply-To:
 <CANAwSgQSBB_yTw5rDz2w6utvjUueWJi9tWUY9oZcpNAT8Wm8iA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1163:EE_
x-ms-office365-filtering-correlation-id: 5d7881bc-375a-4fea-3a0b-08de33d1c010
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 9vYSNtusDQz/zcZzd/CV2E+CT3MkVYQKSqD+58KnvM2yTrYHAqlPADOeTjS5gN8n3TGCLQlpTgkMS1m0GW3lNuVUXKgnfy0J45aGPcD17nbS9FMopw7vFh0pEOPbIhjY9na94kzhCusuf36EHgpV50GwjogL9VWJNgixZjzdSg+5p9wtE/6sH5FLrPArpe8Xgw2a/EnL05kPbUscBx8B04yokAeFRWJxc/QfTv8rbcYoNfB8S86dFQIvEYf557HaCGTYWGiZ0goOpI9mDgElpotXccwncdSKFF9Cvpo5c/G671yYk8V6R7SUjya+cMEN9C7x7pCR0BAarzF3SQxnzyyK9POihCLOGp8PiMs+2wJAFO7l8ae6f70nkBba3LUzhFn8ZqOjm32/sQX9Qo+horvDf4xJUkWiFNpf1Nll4LZEcnYqkWFhaP97TMe1X1ErcjHeP+nwWDxRoK2cQHIct6S0EOXUrnOYGqKnFMKd40Tf7qVQltSa+AeLuYRYTLj2BLdbwwNTfqMhLlvWc/zweD3GFxAzmO+5YMkZjqeZuK2E5nyifP4FqMWqQzxEp0iJ5Uut3xu8m/G8LLX57JLLI4DeZ38NyZTo6NLDn8vfBCE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2ZOVG8yVmJIR044RE9MZS81V25BY2twaXl4QWo0SGlKR0kxS202MlZxNEx1?=
 =?utf-8?B?UnhSb0FtYzhrV1JPTGRNV1ZsbjMydXovTGhmQ2F5QzI5eVZncHBrbUFLbHc3?=
 =?utf-8?B?b24rN0V0MERPVHdmVnZLVW16T25HYTZ3MDA4ZDBzc1J5eUhxVFQvbTFIdVBN?=
 =?utf-8?B?UVI0MFBsekFZdnJZeHBDWjVhZndDWmFicjA1QUFiSzZvS3NIdG1PMnoyVE1Z?=
 =?utf-8?B?cmJya2E1TlpUeCs5QkJMY2Ntcm9MaHdZUWhqMkdtSm5XNlloUWVLb0piZzlj?=
 =?utf-8?B?ZGRKelJnRTJlb1V6Nm5nRVZPNU1XbWloQzRYMUJ6ZHdzWFdyR3p1NXRsZlgx?=
 =?utf-8?B?UFhjdjlUbXlYWlBwK01lOEJzY0p5dTdFNGsrajZxY29RQ2xlbyt6L0xCY0hn?=
 =?utf-8?B?ZFRjbzRhbk9mZVBtYlp3a2dMM0VEVXR0bTk5aHVqWnM3cHFwSlBWREo0djRu?=
 =?utf-8?B?djZOalhvWXk3Z1ZOOStwTWxmSXFpcEthOWp1b3pkSVZLc1puYmJ2Y09mSDdv?=
 =?utf-8?B?RjlKYUYvQ1JUenJyZUNPRTdpaEVLYmVZRnhydGxuMVJrTzErUlhxSE8wWkx2?=
 =?utf-8?B?UkxXbHRVUWJqakttZXhOUGJnWHBNdEQ5M1VFRlVYNnF1SWFJc1VxaWRpcHhV?=
 =?utf-8?B?V3hvSmh6WU44OGhvb1JqQUFPQklBcEZxYVZOR2RVYmZxcVhGK0F0WG5obHhI?=
 =?utf-8?B?U2tmM01vNTZYb0dZMCtHc0h0ZkMyeTJ5Q3RyUzNSbVgxYmYxQXhFNnNQUy8r?=
 =?utf-8?B?b3dscVYyOFY5RllOVElPclhKR0h3NU5Nck5yd3cwb2FoSHRFMWZMdUtTZGh0?=
 =?utf-8?B?N2ZvUW5TNEl5NVJjc1dIS3BWOW42NFRHa1lKYytrTnhhZ3FYZ1N6eHVHVzBp?=
 =?utf-8?B?OWpwRmdSVHZBd2JzbkE0alVDSDVocHhLbDNRZVNBRERXdy95Q1ZibThQK2xV?=
 =?utf-8?B?d3Fhek5NWWVmaXZyL2N1ZEVpRk5sa1RPTFZUZys3dkpPajdxc1NqWER6aysz?=
 =?utf-8?B?Wk83M01ERHBKWUpzNW9RZzVFcldGMGZ3WUV5ZlNoMTJseXk0R0pFM2JKRDhQ?=
 =?utf-8?B?NkhDWDZuNmVIcUppWVZpWVVRc0xJNXdHcHFrTERMSFBiNkRIQ21EVG5Ra2ZO?=
 =?utf-8?B?UFJSY3F2MnVRQjZvNjJMY20zd0RNNGxjYks2OXdITlJkMzZ3Q0o5dTA3aGMz?=
 =?utf-8?B?cUdHNTZYWjRpekV4NnF2Y2dBM0lZMzZXQVdFUXJIaTU4WnZjZkJ1S3l2TTd5?=
 =?utf-8?B?cWo4aTROMFN6KzdqbXB6WVIzS2poU0dCMTFueEVSZTgvLyt4bWE4U0FubFBW?=
 =?utf-8?B?VWIrVjN5MkJ0V1dYb0VBRjNkWnhJNnJxZkVPd0JFOWtUWnBiSnlFQ20rQXNt?=
 =?utf-8?B?MlFFblBiYXFQdzlFcVhZYVJ6ME5rRnZEVUZHVG1SdjNEME9ZSXFVWjlaWUlI?=
 =?utf-8?B?cytLN2lRTkN4aVJXREtNTHVWTHlyc1pDWFFtTE5VZzFLRXVUVjA0Y0FLdmpK?=
 =?utf-8?B?bzNUQkJKS004WStvTjlGQVFoVEE3a0dqUDAxYnFDeDQreWZ5c3dxSGYwZ21P?=
 =?utf-8?B?SStsdEczVTRLSlVjdUxvcGJuZjRqTTV2bHJ0OGNlcjVybVNMUnFwclhTY2V2?=
 =?utf-8?B?c2oxc1VkUFEzY3NDNlBkVm1JK0JDTEJidUlFTVN0SGRmdmlPdWZ4c3A2WTVt?=
 =?utf-8?B?Z0pCSVo5K2lyejhGK1UxbFJuU0FVR21JYUJWZFpMbFA3OGVLdHZUNVQyekMr?=
 =?utf-8?B?MGptU2ZNU2ZtYWF4SnB6RklaQWpRbVF1dkt5UDNNanJaQ2F3cG5lNEd1emJP?=
 =?utf-8?B?aGpZT1ZXV1JkYTIraGxLL3I3a2dURmJoemd6a29TOGNPNWhia3R0QUNBcjZY?=
 =?utf-8?B?allJbE1GUTRBcVZQdENDdElYanB5TnB6Y0dkYk14WFRleDQ0bFpJRU9zUFph?=
 =?utf-8?B?UUpLM244UDdEUjhrVmpSQ3NjNi84S015UVhZblFpdnlka3FjT2JHakRxL2dX?=
 =?utf-8?B?d2FLbjI2c0xSYVdQTGFMQnZFcHd6UXBoQ3EzbEdUd2hrMnAzTXlrc2gvbWxx?=
 =?utf-8?B?VVBiaGtYMmhnZVk5NkFHdkRIWUJ1czdzd1Q0K2VKUGU2MjcwdHJvVUd6Yyts?=
 =?utf-8?Q?Q2wrILScjfwyMXs/v4uuLCDzz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7881bc-375a-4fea-3a0b-08de33d1c010
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 07:41:49.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEp1NwGVIGF75DwXPvYQ4M4Tw56qdb+yDIoLAw/a7cYW4zSBFSUVlRWQyJxi/DYWsMCp9IOaOHKiQvwN1B7peP1WYYEUNrgK9r1jwbcqV90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1163

PiBPbiAwNS4xMi4yNSAwMTowNSwgQW5hbmQgTW9vbiB3cm90ZToNCj4gSGkgSGFsLA0KPiANCj4g
T24gVHVlLCAyNSBOb3YgMjAyNSBhdCAxMzoyNywgSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZl
dGVjaC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGEgY29tbW9uIGJvYXJkIGR0c2kgZm9yIHVz
ZSBieSBWaXNpb25GaXZlIDIgTGl0ZSBhbmQgVmlzaW9uRml2ZSAyDQo+ID4gTGl0ZSBlTU1DLg0K
PiA+DQo+ID4gQWNrZWQtYnk6IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxlbWlsLnJlbm5lci5iZXJ0
aGluZ0BjYW5vbmljYWwuY29tPg0KPiA+IFRlc3RlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWJy
dWdnZXJAc3VzZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0
YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9qaDcxMTAtc3RhcmZpdmUtdmlzaW9u
Zml2ZS0yLWxpdGUuZHRzaSAgICB8IDE2MSArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE2MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
IGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi1saXRlLmR0c2kNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlLmR0c2kNCj4gPiBi
L2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi1saXRlLmR0c2kNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uZjg3OTdhNjY2ZGJmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlLmQN
Cj4gPiArKysgdHNpDQo+ID4gQEAgLTAsMCArMSwxNjEgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAyNSBTdGFyRml2ZSBUZWNobm9sb2d5IENvLiwgTHRkLg0KPiA+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMjUgSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+ICAqLw0KPiA+ICsN
Cj4gPiArL2R0cy12MS87DQo+ID4gKyNpbmNsdWRlICJqaDcxMTAtY29tbW9uLmR0c2kiDQo+ID4g
Kw0KPiA+ICsvIHsNCj4gPiArICAgICAgIHZjY18zdjNfcGNpZTogcmVndWxhdG9yLXZjYy0zdjMt
cGNpZSB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVk
IjsNCj4gPiArICAgICAgICAgICAgICAgZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiA+ICsgICAgICAg
ICAgICAgICBncGlvID0gPCZzeXNncGlvIDI3IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsgICAg
ICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJ2Y2NfM3YzX3BjaWUiOw0KPiA+ICsgICAgICAg
ICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiArICAgICAg
ICAgICAgICAgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gKyAgICAg
ICB9Ow0KPiA+ICt9Ow0KPiANCj4gVGhlIHZjY18zdjNfcGNpZSByZWd1bGF0b3Igbm9kZSBpcyBj
b21tb24gdG8gYWxsIEpINzExMCBkZXZlbG9wbWVudA0KPiBib2FyZHMuDQo+IGFuZCBpdCBpcyBl
bmFibGVkIHRocm91Z2ggdGhlIFBXUkVOX0ggc2lnbmFsIChQQ0lFMF9QV1JFTl9IX0dQSU8zMiku
DQo+IA0KPiBWaXNpb25GaXZlIDIgUHJvZHVjdCBEZXNpZ24gU2NoZW1hdGljcyBiZWxvdyBbMV0g
aHR0cHM6Ly9kb2MtDQo+IGVuLnJ2c3BhY2Uub3JnL1Zpc2lvbkZpdmUyL1BERi9TQ0hfUlYwMDJf
VjEuMkFfMjAyMjEyMTYucGRmDQo+IA0KPiBNYXJzX0hhcmR3YXJlX1NjaGVtYXRpY3MNCj4gWzJd
IGh0dHBzOi8vZ2l0aHViLmNvbS9taWxrdi1tYXJzL21hcnMtDQo+IGZpbGVzL2Jsb2IvbWFpbi9N
YXJzX0hhcmR3YXJlX1NjaGVtYXRpY3MvTWlsay0NCj4gVl9NYXJzX1NDSF9WMS4yMV8yMDI0LTA1
MTAucGRmDQoNCk5vLCBHUElPMzIgaXMgY29ubmVjdGVkIHRvIHRoZSBXQUtFIHBpbiwgaXQgaXMg
bm90IHVzZWQgdG8gY29udHJvbCB0aGUgUENJZSBzbG90IHBvd2VyLg0KDQpCZXN0IHJlZ2FyZHMs
DQpIYWwNCg==

