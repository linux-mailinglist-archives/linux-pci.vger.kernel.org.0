Return-Path: <linux-pci+bounces-6819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0658B6711
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 02:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC291F21246
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D591843;
	Tue, 30 Apr 2024 00:53:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FD10F7;
	Tue, 30 Apr 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438427; cv=fail; b=BG8NULQTH0hx9s6jmvSXSt+ZbUL4YtM3pikU5E5JLBub4jwwAyTRUKnx07NiMqwwJCfcfSNf5korjTZjL1mfqin/ZpfLfoQuD4GtWgiSq5I2rqmFkxig9DB8Y8YMqhEm43AWKrRTuE9PmdoIFBt/KM99nLmGHtbOaIjZ97uKxoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438427; c=relaxed/simple;
	bh=3w+CRUPvPl7hO9cUnDrUA37EWQl3YhnsgPyi8+o1HdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D93lLOf5SGNjkQ2d/87ZnQcJbkZh7XdJsuTwlwoz9l6nHRex4AC6ecZxLLNGXkB7Bk7edwPXaEi6X0FtXQCkt2wlCHGhiJV0p+VK9AcaOmqnYGol/0A4Mw75v8J3kMyAIJZpC9gRZKe0Wg51afmI3Bp2IAKpGK1wcimr58ZUOYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM+klsKa7sg+iZ7U9ahW08xZmjGINUzbn/EmTTBIf1LP6Dbq+8SLFSr9gmZawHNY+GnyBWpxXAhmdJNeGaIZPHOtG3JjK0zFfHVSuoR5396Xe3Djuyme+GELoSUM68SSLq8UbFMnafOpI4j0tzY5sn5+c1oWJ7qKU9DxlIRyPKO+z80imnQ3bJptlg7jDc+7wT4d1w1oE4MPYiFvUJkvs/XiZMc2n0Gbo8Ny6csjkSxwP8qAmG20+lZRbIq7KRqud/4aU1kNVEQPIVaLtuFMou8PttK0jlPlZkPGDO+/HqrF2/wXFGOJDzv/xJUUWaNLFxiyZhBgdPr5NBlsczFZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w+CRUPvPl7hO9cUnDrUA37EWQl3YhnsgPyi8+o1HdU=;
 b=PDE8u4Al/HFlWHbd+g0B34AqF5+3ApHW0ucARwgq1A22+MZ9LNRkPMHIObVXj1HJGfTPL15GIgl706Xp9Ia64kyrhmVIbCLCyoyzVkWd3AjNDkn0P5sCJx0n4ni5Ubbv9twO2lQPMFO3Vaa8SNT1b2bN41zROfu5AZFcgn75HuhpZwG/pvCG1VA5IFyjwUUCBUQ28TlllNBhh3c9Jv4eWgCzVoja+pBMo5RN2JMHbgQTrNqh7awGuA1OZzE6V1bG5aQVTKJw+oLGu/JQ6awa/qzh//0Nqzf5P/g3lDiiNzYmCIYQCdtYk1WNavl7IcCw1lr07hvlH/J5MtuKPKRbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0551.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 30 Apr
 2024 00:53:36 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Tue, 30 Apr 2024 00:53:36 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Conor Dooley
	<conor@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxNiAwMC8yMl0gUmVmYWN0b3JpbmcgTWljcm9jaGlw?=
 =?gb2312?Q?_PCIe_driver_and_add_StarFive_PCIe?=
Thread-Topic: [PATCH v16 00/22] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Thread-Index: AQHagPDufmdBlaBn9kKVvS/pnjIg0rGALuWQ
Date: Tue, 30 Apr 2024 00:53:36 +0000
Message-ID:
 <BJXPR01MB08553956E2560A52CCC3FDBEE61AA@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0551:EE_
x-ms-office365-filtering-correlation-id: cd9c91b9-b6a0-4489-a2ba-08dc68aff78f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kHe2O6qlkODrLOs7QDdxonWpD862Qsv+f6kdfjsiFlPFXqZgO0An8oUdETyLRapEjsIdwv+lkLJBTmuI/X3D61UGsIvcIMxzdW8SPY7OnoUx6Rkee1qhjYb6lyzIeiOvNYkREOUxl/LCA4pmvMaquoSWj+D+tm9VkRBNc4v4sLoN8CPVrO7vz2/ZCwF7TwvXpSskHHrje8sLWuRg0B7zjaDjpwmzbyVa0hlasJE4OaWZ7RxYuqkagSZea3hKUu5eFGCNLrWryjfDDVqwuUTmLZzXCaHZfaThS3USx3wMTkp+ykGd6N/U9ovfFea0q21JQj1MPBSNrh0S2AGFFigqWluMzK+C21CeqzvlYsZKOAKaIhG4ueEQQM2a9zW0c6EQVOA7Nacw6pM8n7MFnt7SEL2qX54Lqzo15p0Vt/mcWFFNP8eeC4ccv8ZVaMyiF8OndSYTXPS7lZ1waF10mALYRfqrGYCRsmsoSy/KNJH//zaVAdhUxyjUNfDHed4X/s1qIoWlEapywOEs5iqoMrvIuH/fgp9bjexRW4e1SRgvmp5943HbqSBuaCA50sqDijjjUNLcBGJpRTzyGFk31JggE28aYV/Ym0lMvqNKASxfP9ZrQ+5N2Q/veu67CSe6a8uE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bS9sOHZvd1Q3bldDaTE2VG1sYzFNdlg4YURTNUpQYjczRmMrdDhFZFJ2VVlM?=
 =?gb2312?B?RUpoOGM1d3pBbVRUc0VLUzUvelRITVUxQ2JxVUtkOVpXeEMrb1IzSjJ3a3dx?=
 =?gb2312?B?Z0g1S1o4R20zajl5VmZ6QWF4NktJOFd0WXRTMHZlMnFIQ1pOOHovN09LSmlB?=
 =?gb2312?B?TmhTOEswQ1g2YWE5dXl5OHNtNzkvajZuSmtKdnpRM2NHTVRGY3h6emYzazdN?=
 =?gb2312?B?L3RuaWFTTXhIRTVROWVLMzRPNThVK0FtYjFBRlZKbFk0R3ZGSWRLKy9ER3pO?=
 =?gb2312?B?RVVsMit4ekM1dXdMQ0l2VVE4OUFtNnRDeEN2YmQyeVEzVkoxLzlKRXBiOTlp?=
 =?gb2312?B?dVNpN0RXN2hwZTQ1V2M0Ky9GS2ZTU1NRNVltMlZQSitZd2ZzU1ppU2gvRC9J?=
 =?gb2312?B?eDk2WEdEaXJrTDFpdzEvb1prNHE3WjRXS1FkOVRlME9CS21Tck9hZHhxSVpB?=
 =?gb2312?B?RG1TQWw4OGlEM1FDOXo1Y3E5eG8vK2YvY1Z4TDhkVjhPSTdFcjVJOGdtR245?=
 =?gb2312?B?Q1U2OGdGKzExc3g2eHc4M0hMcEMzZ0hVQW96TjZCWW53SVgzVnI3MzlJSWRw?=
 =?gb2312?B?eWRUd09KZGhNd3BaOVNlTlJWQWtsN3ZJaGszU3llNUN2ZlNRM3Y1Rjlja0RP?=
 =?gb2312?B?TzFOVGg0aFdReGRCMGFJM1ZhS2djU053UXdEUTYxSnc0Um96L2NDVkxuZ2hJ?=
 =?gb2312?B?NTErVEMwY3pPeFFYRzJtTkUwVUtDYTlId001ZVRIbkxWbjk4ejR6M2xDMEFj?=
 =?gb2312?B?WFR3UmxhSHJBTVZudkVLUEpLU0cvcjJVNmxPeFkrSDVPMW9jNWRCSUw1Y29J?=
 =?gb2312?B?UlF4UHhUaENuaStSNUl4Q21Wa2h0VjQ0aEZxMW5JdDJmZThmdWJPa2FzdzZ1?=
 =?gb2312?B?V0FvOHdQdDBQR1Avem9MeHBMdXhTc0JOWERSRHZ4ZkQ5UHdhTklBUXFkWUs1?=
 =?gb2312?B?V2ZmVm0yZktZc1A2UXBpVW1qOVd2eFZwa1JtY1pGWWFrdVFadk4xQ1hlOHZF?=
 =?gb2312?B?cm4rZ2lJZ2puNVVoOFEvYVQ2eEQ3UjJsQW1GUjNaRHFBWk8vNWVIRVp0VWxk?=
 =?gb2312?B?WEdzWG5MeVh6L3pUTFhTSDc5ZGh1a1NBMnI0dWM0SnMyNnorSU1kNTBvUFNn?=
 =?gb2312?B?djhSM09nNWZpSU1YV3Y1YVdmOXI3MHMybUhvcXN4TmNnQWluVmYwb3NVRHZW?=
 =?gb2312?B?RkFOSjVmTVJyclhOVlkvOGd4QnpiTmNDWkk3Z2RuOHJFMlNUNC8zQjMvays4?=
 =?gb2312?B?NGQ2VmpmRUhxcXlwb3ZSZDRPcW56ZmhWbVhSQ2JoNHVYQ2RabGhrTVBLNWxx?=
 =?gb2312?B?WEdKYjN4T3ZYMzgyTW1qRzBVNWZwcklXSUpQZlhUTEJRaWcxajIrUzkwRitQ?=
 =?gb2312?B?cTZkdG00YVluWExDS2s1dVc0UENzY0g3Z0xPMTMwWmQ3cmpjbGJ5WGVGeEZD?=
 =?gb2312?B?d3NjMnpwamVWT05rOXc0dFZjVkx5YWcrS2xKNU9OTzN1cEhMOUlYV0hjSFI0?=
 =?gb2312?B?VEV4N05aRjB2RU42RmU3RmNLZFMyUFRxVyt4blpwUURqQmg4QVMzdmUyRGow?=
 =?gb2312?B?cjBPNnV6cXNZanBIMUtHNmVjM05MOHRTT1A4TElvR2RvU2JNM0doQ1JBSWxG?=
 =?gb2312?B?aXNJSnAzNllHMlBsRjhNa3BpSUlwK0g2L2MyVmNmTlR5UDFYM3JhMjV0b2d5?=
 =?gb2312?B?Yzc4TVBvYko5WHpETEp3a3NwYy8zaCtWcVY0TmZTSHZmU29aWnNsVEhMK0p4?=
 =?gb2312?B?UFBBNUVkeVRuM3lWTGxYblI3TGJVVHFSSVVBeFoyaldBWlplZ2ZueDE0NzlO?=
 =?gb2312?B?Nytrb25sRUtBKytTbnd4TkFzQ0JEN1ZWM0NoNWhDcGlFd3R5aDYxcUM3Q202?=
 =?gb2312?B?TWU4VUJNMjJqTmVXdkdwVXp1Qnl0UnJyZGg0U2s5UDJ6bFUwU3cvK3plcWFW?=
 =?gb2312?B?N2h1blhZOEw5emp1UXhoazMxNjFDbWoyQ0R6MWR6VUJ6VU5GRlVDUjhzM00x?=
 =?gb2312?B?KzAyWXo2Y1NmdWpoMkhkZTRhczQvYmYxUEUva1VMdzlOK1EzOEE5Nys2VzUr?=
 =?gb2312?B?RWRxRFdMYzhvcmtkMU9mWDlaWEhHVkwxYzMveFE1endkUUZETFpnMEZIUEFO?=
 =?gb2312?Q?bjBiSIZeEdvF/rDe1Ks578geu?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c91b9-b6a0-4489-a2ba-08dc68aff78f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 00:53:36.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VG/4iNJAsZaXKAW48C71BGgS1wgYr7fHMiSPBf2W+pB5Fq1rzpKXC+DQWo4UFm24PUYL70iwGrecs9yEIRvCElV6T3j6MdW/tAy+6gN+iSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0551

DQo+IA0KPiBUaGlzIHBhdGNoc2V0IGZpbmFsIHB1cnBvc2UgaXMgYWRkIFBDSWUgZHJpdmVyIGZv
ciBTdGFyRml2ZSBKSDcxMTAgU29DLg0KPiBKSDcxMTAgdXNpbmcgUExEQSBYcHJlc3NSSUNIIFBD
SWUgSVAuIE1pY3JvY2hpcCBQb2xhckZpcmUgVXNpbmcgdGhlIHNhbWUgSVANCj4gYW5kIGhhdmUg
Y29tbWl0IHRoZWlyIGNvZGVzLCB3aGljaCBhcmUgbWl4ZWQgd2l0aCBQTERBIGNvbnRyb2xsZXIg
Y29kZXMgYW5kDQo+IE1pY3JvY2hpcCBwbGF0Zm9ybSBjb2Rlcy4NCj4gDQo+IEZvciByZS11c2Ug
dGhlIFBMREEgY29udHJvbGxlciBjb2RlcywgSSByZXF1ZXN0IHJlZmFjdG9yaW5nIG1pY3JvY2hp
cCBjb2RlcywNCj4gbW92ZSBQTERBIGNvbW1vbiBjb2RlcyB0byBQTERBIGZpbGVzLg0KPiBEZXNp
Z3dhcmUgYW5kIENhZGVuY2UgaXMgZ29vZCBleGFtcGxlIGZvciByZWZhY3RvcmluZyBjb2Rlcy4N
Cj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gVGhlIHJlZmFjdG9yaW5nIHBhdGNoZXMgdG90YWwgbnVtYmVyIGlzIDE2LChw
YXRjaCAxLTE2KSB3aGljaCBkbyBOT1QgY29udGFpbg0KPiBjaGFuZ2luZyBsb2dpYyBvZiBjb2Rl
cy4NCj4gDQo+IFRoZXNlIHBhdGNoZXMganVzdCBjb250YWluIHRocmVlIHR5cGUgYmFzaWMgb3Bl
cmF0aW9ucy4NCj4gKHJlbmFtZSwgbW9kaWZ5IGNvZGVzIHRvIHN1cHBvcnQgc3RhcmZpdmUgcGxh
dGZvcm0sIGFuZCBtb3ZpbmcgdG8gY29tbW9uIGZpbGUpDQo+IElmIHRoZXNlIHBhdGNoZWQgYXJl
IGFsbCBiZSByZXZpZXdlZC4gVGhleSBjYW4gYmUgYWNjZXB0ZWQgZmlyc3QuDQo+IA0KSGkgTG9y
ZW56byBLcnp5c3p0b2YgLEJqb3JuIGFuZCBvdGhlciBQQ0llIG1haW50YWluZXINCiAgIERvIHlv
dSBoYXZlIGFueSBjb21tZW50IHRvIHBhdGNoIDEtMTY/IEhvcGUgcGF0Y2ggMS0xNihyZWZhY3Rv
cmluZyBwYXRjaGVzKSByZWFkeQ0KdG8gbWVyZ2VkIGZpcnN0Lg0K

