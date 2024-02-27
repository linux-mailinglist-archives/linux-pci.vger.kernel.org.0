Return-Path: <linux-pci+bounces-4084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF22868A13
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE911C206A2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA854BD8;
	Tue, 27 Feb 2024 07:44:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B85339F;
	Tue, 27 Feb 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019886; cv=fail; b=hXruT+7FVHsIk1OGaOxNk2PJRyrlsmLvA9o2P+iQ0TReztQHs2aWVdBHg/sZ8RIfK0zsLrXLvD5y8u2i6DXvuwlDNAWipOJ80WNCMX/skeu3sp5ob0MaGPLoTxGdY7p/GAWdsjNDDM4wn2Rgj6LCveBoUgXn1sNpV1MZGMRxBXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019886; c=relaxed/simple;
	bh=6vVqGkpDWtYdUpTVP/0DMPPG5HdoyFqyqEBjvx8BBQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VIjPIKwSyFeWljt886zJTMnVb+NdGUNhycvMNZIe7K/0D/t7lOm1ug4rnBlSN8TIb9DmD/uAys5PA1FM0CBvNZESNVqJ1DKdj8q7PCm+kG65zguTe8Nw+ua/3jfwhFJSPN9PAPBL5hhUrpSqn3xcnDrTOpIiUflJ2yCMh8EuNOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/zJMV6Ul9bXW0lBI4n+HdWfmJ1TwMAYmSNGfrAOlPnZw+EnbrddiJt2Hh6yJ7KGGhNrprnZAt7ryJaVixwzTSK7jUzMRU/pi4ruJT+bf0W2iSHUsFrFbnM6M8YpRALUtXB+otOOIIJEcPAtDH+TQkDe8cF4WgUCyYTTcqIK9H5X1Ufz8xMIBzmJtiii1bqaNRfNxCkE91fqFQ57ugnQyoMkTJVhgpzf0PcqMhf2RG5ds25JcHB7Dnk3ML3yySQmZ2sZrCh+PzDumY/m4dP5KfYrja+O9QZEBbYNmqeYgQpeLI7mLDRLTi/IcAnW9ads2RUq2dufgFEoJDyDujm6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vVqGkpDWtYdUpTVP/0DMPPG5HdoyFqyqEBjvx8BBQk=;
 b=TTpt3w9D7xRc3UEO2XiRM65N5WTg2gWKyKZU6m+FQ/EiRSBv6OQxMIrCFdHOadyb2JR9pTNMpXke33pBDz/qi3fC6BGqCYC7oCmolOa4kFas9Hfdw2WJF8Aa9uWFxywpQHCAVRgznkzIrczYR5av3prZu+KzPtnkesY28gKdWtFa/MQj0h5miOTsw7ANEY2Ok6ruOyMn0DvCp0yqbXwBFUSVav5heLQQoPCgpN/x7cNYy/hBfo4j2d9ac7MrGFSDK1Iakxix811pEejDlwcsj9PFi29EkgUxcEAbQi+hIeYWtYSxDoR+Is1h2BnJ0sSsgdZaKD5neGmLscGe5jKBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0749.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 01:10:48 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 01:10:48 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Aurelien Jarno <aurelien@aurel32.net>
CC: David Abdurachmanov <david.abdurachmanov@gmail.com>, Conor Dooley
	<conor@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Philipp
 Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie
	<kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
Thread-Topic: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Thread-Index: AQHaYlPYD6wUc0NM7EGAypJO2so9u7ETE0sggAATQACAAXFHEIAIZ5cAgABvhqA=
Date: Tue, 27 Feb 2024 01:10:48 +0000
Message-ID:
 <SHXPR01MB0863C64BC0B48707C5FF99A5E659A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240218101831.113469-1-minda.chen@starfivetech.com>
 <20240218101831.113469-2-minda.chen@starfivetech.com>
 <SHXPR01MB0863FCE82CA2155E52A3EB6FE650A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CAEn-LTphwFA6KgCZWsqiMMob2Xw4t4sCZ70U0u0z2=yJOpyGHA@mail.gmail.com>
 <SHXPR01MB0863DBBEB8C6AD12F3C0056DE657A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <ZdzZClVcyHXKwsUJ@aurel32.net>
In-Reply-To: <ZdzZClVcyHXKwsUJ@aurel32.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0749:EE_
x-ms-office365-filtering-correlation-id: fdc9c697-2992-4fed-2649-08dc3730eea4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AjC8dNAkTcPiB++w9atvpmXTuGmZA6s+4IIGztmAHFBPaOTczR4lkEpmJGFLLPnMDOJhcFGF6lSf+nh7/NtPyYalNb2XsMZRYKgDzITlCzrNUopzmwR2bGIhuRi9AbfmGQMp6qULT2AhhyNW+ibyfOeCC2Q/H0YHD+6JuOQ6BLxrsoA50cYTrGvgC82MNkcI9tt5VGAYEmdVFRw5TVN67VFoGLgeK3fF9D5M88P9I2N7xV8g46zD1hlaWhfhONYIuV4h+cnTgJRmfBAxyIKaJEOfzICC+L05gfrO+VgFpUl9xBBlYEI8GzQSCM0h79QqtPXVwmA4fv/eSrPqU8cRtYz4PbPaNNjsAEGxk0t8SOH6qHPc11rVWmLoIJBouJy4n54YlpzUobd2SNzPK4eW53V3eE780gUEwimbsOxYxpYe2p7ji5J8HXdtZXlckuL9Iq78pUN/kscbGLouO48CAgYBqyHapUmvvJ8D+fcAiBA6KW/J75ECyZwTLSRgbND6vd56+rtXrghf5r7gmdq0Ne416MuHVjZMPUGKZP4CgOQN4ESK1V9Hw6Tk+nN/vkLAUhi4gFDTqnwSgDg5wlzpbSMRtQpJo8+4ZWJE9XSiuvXizB9TlHJAJQ4RH1pM3kr3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2N5QUlaZlk3TGxNMDZGeGk4cUV5L2F3QnVQWWs0QWNUOE5iT243M0NZclJ0?=
 =?utf-8?B?b0dQVTRIbnV1YWFJVHIrdlpEbzc4RGtBYWY2c0dQV3lYVzhLTEw0TDdSMW10?=
 =?utf-8?B?L3h0Z0F5aW4yZnBrcUZNak1MV0RsVTFDRHlnTWFyeHU2bDRXakJZdlY2b0ZV?=
 =?utf-8?B?eGF6RS96a2QwM3pzbjZ1N3kxc0hBU3JtN0QwcUZTL1V4dTZVakVPb29TeFlB?=
 =?utf-8?B?Y08zWjRCdkp5OVB6cldhNHk5TERhWFpUUmM2NDZoM2ZHbTBkb3lEY2dkWm5M?=
 =?utf-8?B?R2U5R1hLZm5lZzZGN2M5RVEyOVZwdmFGQ1hoUlpLS1pyUjJwYmlXMXdKelBI?=
 =?utf-8?B?OU5zL0hzS3NiZGg1WHg3d2NVRG5nR2ZZNVpUZFJpUmlkaTZvcTBMeU9zbUMv?=
 =?utf-8?B?ZEZHOXAvaTNuUGZPMU5ESVpsemYvSlFxTjViRHFCQXJBMUZNM3BMd0ZoSXkr?=
 =?utf-8?B?ZjNvVGdEUVpGRVRROG0yNXMwSWdWVC9mejk1bHdYS0lhYkxzTVliSWt5UCtK?=
 =?utf-8?B?a2VVdEI0SVZ5RnRtMVhOSGZYWmdBQWZQRk9OZGp4NnowQ0JUOTFiQWYra2lH?=
 =?utf-8?B?NWVkcTNKdnJqYW56c1hMbmx6c1JOTjZxbmFOQzA2NmhHRDZkeWRQNTRYTVlP?=
 =?utf-8?B?VHIwOWZldk5taDE3U1JTNFdsallmQ3o1alJ4MFJoa2Zua2hnODgzcTdMbGdY?=
 =?utf-8?B?L3VwNkg0WnFuYTExalFQTlVRdzRnT3hDOSt5Nldhb005Y3NrTHlmaXE2emtD?=
 =?utf-8?B?WTNFMzBzM3NBL3V6M1dPSmtyOGg1Y2Z2endUSzc2aTRZY1R3TWhsYmtPMTls?=
 =?utf-8?B?YkZGWDNOaDJkVjA4VGVzbEFGTHp1NEFONUo1OXdzM2FlWWIrMXg0YXZwUlRZ?=
 =?utf-8?B?ZGM4R1J2ckdrN0NpWjcreGlTOWwvOHpITGdSWkhuZm5OSFp0K1Q5c2NkZDJD?=
 =?utf-8?B?Y0NRYXJDYzZqbUpNZDVmN2tuWTdTNlk2ckgvZnBzRnBaRHo2RTJUWDR3U1d6?=
 =?utf-8?B?Nndacml4WlhTY0hSczluNHl1UXZNNUhqaTBNeDdxQXdON0RWYzBSakhiR0cy?=
 =?utf-8?B?WTNpenRYMjh2WXdNSWc5TVUwdjkvdThKTjg3N3o3Mmc2TDRWbS9lRHA0aWNn?=
 =?utf-8?B?RllVRzI4S2NUcEgrT0RnNEVCTXNDTWFNR3pyZVJhY3VnVWV0TWZ5U3E4MTg5?=
 =?utf-8?B?d0gxTWJQWCtEeWxIWFpIYWI4dWRGbUxockN5T0JrZXovK1NHUDVsaG5yRDJn?=
 =?utf-8?B?RFVrdm8zbjk1amRlTG14cnJRRk5nTFBwUWxrRGtubjhkenRaQis2MXZFN0p6?=
 =?utf-8?B?OWppaHJSSldXeS9KOEJTcG1tKzZERTI0MklmOFYvaWxFay9UVmRvOHE0TlJX?=
 =?utf-8?B?SDlydXo4aGdWVHBXWks5RTZaRWZjL2I5eGlPbmdGL0tBSFNodVJpK1VJZkJZ?=
 =?utf-8?B?WlVCZWduUFprSjUxUkJSNitYR2llOG9WeXNNdWd4WUVLckdEV1B4SjBCNURW?=
 =?utf-8?B?eTBwLzQ0K09kTktSemZxcWxzYXYyYk56b1lrWjVMcUxycHRzSVE4MW5FQjR3?=
 =?utf-8?B?bVBxWVF0NkltZFltYmVDK2R6dncwQmNGazBFajdIdjhCakpTbyt3Y2VOOFN4?=
 =?utf-8?B?dzJvV3A3TkcrcmpCcTRuNTR3cnhVWnFFWlp4aUE2NjdLZ1BzZnY1bGFZd1da?=
 =?utf-8?B?Z25UdjY2R2ZIOW14dnpsL3VrVUNHcGZyMXN5SWxLa0grR3hzL1BZMlVYVjJE?=
 =?utf-8?B?elVDUDA5dW03eTQvVjUzVlh2cDhVTUNqUGZ4QXRZZ1BzV1Q1dzQ5V25CMy9W?=
 =?utf-8?B?OVpoVXVzaE9hZ3E5Vzlqem5EUzJYd0U0V2JUOE1NVC9mQTB5MEZ6MWFsNDhU?=
 =?utf-8?B?d2hweVBxclg3cWZhRHdGNFR2Z0J3VG1DYlpKUExmUUM1L1QxNFgvME1ud0Vp?=
 =?utf-8?B?V0tMeVlrM1d1eTBhRFlTQTdvTmY2dlNraFVoNmZZSEdvV0NMOUN2bUtQWjl4?=
 =?utf-8?B?S0NOMVppMEdnZ0Q2MGhCVkJRVGFtNGZtMUdkMkVpZ1FvdWlLNThTaWdqTFNH?=
 =?utf-8?B?TzdBRDZLSDZlSzI4VldqL3VFbmxCTHhSVURPTWVndmMwaStBbEdTR244UGJO?=
 =?utf-8?Q?nUrjdeuDJwjKsOYWYCDenulx0?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc9c697-2992-4fed-2649-08dc3730eea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 01:10:48.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ije5o4VLfvGXo5VHEukWJkXNXlMHcKNrQ5/7zxVZsF3JY0pPjShRgLgVEaEJYiygYiSR8hoyEjOsX6QNHR1m1hLo1bH332e/TDbbZgzhZc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0749

DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIwMjQtMDItMjEgMTA6MTAsIE1pbmRhIENoZW4gd3JvdGU6
DQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDE6MDLigK9Q
TSBNaW5kYSBDaGVuDQo+ID4gPiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBQTERBIGR0
cyBiaW5kaW5nIGRvYyhEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpLw0KPiA+
ID4gPiA+IHBsZGEseHByZXNzcmljaDMtYXhpLWNvbW1vbi55YW1sKSBzaG93ZWQsIFBMREEgUENJ
ZSBjb250YWlucyBhbg0KPiA+ID4gPiA+IGludGVycnVwdCBjb250cm9sbGVyLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gTWljcm9jaGlwIFBvbGFyRmlyZSBQQ0lFIGV2ZW50IElSUXMgaW5jbHVkZXMg
UExEQSBpbnRlcnJ1cHRzIGFuZA0KPiA+ID4gPiA+IFBvbGFyZmlyZSB0aGVpciBvd24gaW50ZXJy
dXB0cy4gVGhlIGludGVycnVwdCBpcnFjaGlwIG9wcw0KPiA+ID4gPiA+IGluY2x1ZGVzIGFjay9t
YXNrL3VubWFzayBpbnRlcnJ1cHQgb3BzLCB3aGljaCB3aWxsIHdyaXRlIGNvcnJlY3QNCj4gcmVn
aXN0ZXJzLg0KPiA+ID4gPiA+IE1pY3JvY2hpcCBQb2xhcmZpcmUgUENJZSBhZGRpdGlvbmFsIGlu
dGVycnVwdHMgcmVxdWlyZSB0byB3cml0ZQ0KPiA+ID4gPiA+IFBvbGFyZmlyZSBTb0Mgc2VsZi1k
ZWZpbmVkIHJlZ2lzdGVycy4gU28gTWljcm9jaGlwIFBDSWUgZXZlbnQNCj4gPiA+ID4gPiBpcnFj
aGlwIG9wcyBjYW4NCj4gPiA+IG5vdCBiZSByZS11c2VkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
VG8gc3VwcG9ydCBQTERBIGl0cyBvd24gZXZlbnQgSVJRIHByb2Nlc3MsIGltcGxlbWVudHMgUExE
QQ0KPiA+ID4gPiA+IGlycWNoaXAgb3BzIGFuZCBhZGQgZXZlbnQgaXJxY2hpcCBmaWVsZCB0byBz
dHJ1Y3QgcGNpZV9wbGRhX3JwLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
TWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gPiA+IEFja2Vk
LWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLW1pY3JvY2hpcC1o
b3N0LmMgfCA2Ng0KPiArKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGxkYS9wY2llLXBsZGEuaCAgICAgICB8ICAzICsNCj4gPiA+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUt
bWljcm9jaGlwLWhvc3QuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRh
L3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPiA+ID4gPiA+IGluZGV4IGIzZGYzNzNhMjE0MS4uYmVh
ZjVjMjdkYTg0IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGxkYS9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BsZGEvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQo+ID4gPiA+ID4gQEAgLTc3MCw2
ICs3NzAsNjQgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBtY19ldmVudF9pcnFfY2hpcCA9IHsN
Cj4gPiA+ID4gPiAgICAgICAuaXJxX3VubWFzayA9IG1jX3VubWFza19ldmVudF9pcnEsICB9Ow0K
PiA+ID4gPiA+DQo+ID4gPiA+IEhpIFRob21hcw0KPiA+ID4gPiAgIEkgdGhpbmsgdGhpcyBwYXRj
aCBjb2RlIGl0IGlzIGVhc3kgdG8gcmV2aWV3LiBJZiB5b3UgYnVzeSwgQ291bGQNCj4gPiA+ID4g
eW91IGxldCBvdGhlciBJUlEgbWFpbnRhaW5lciByZXZpZXc/IFRoYW5rcy4NCj4gPiA+ID4NCj4g
PiA+ID4gSGkgTG9yZW56bywgQmpvcm4gYW5kIEtyenlzenRvZg0KPiA+ID4NCj4gPiA+IEhpIE1p
bmRhLA0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2hzZXQgc2VlbXMgdG8gaGF2ZSBicm9rZW4gdGhy
ZWFkaW5nIChsb3JlLCBtYWlsbWFuKS4gSSBoYXZlDQo+ID4gPiBzZWVuIG90aGVyIGZvbGtzIG9u
IElSQyBtZW50aW9uaW5nIHRoYXQgdG9vLg0KPiA+ID4NCj4gPiA+IEkgYW0gbm90IHN1cmUgaWYg
dGhhdCByZXF1aXJlcyByZS1zZW5kaW5nLCBidXQgbGV0J3Mgd2FpdCBmb3Igb3RoZXJzIHRvDQo+
IGNvbW1lbnQuDQo+ID4gPg0KPiA+ID4gQ2hlZXJzLA0KPiA+ID4gZGF2aWQNCj4gPiA+DQo+ID4g
RG8geW91IG1lYW4gdGhlIGF1dG8gdGVzdCBlcnJvciBpbiBsaW51eC1yaXNjdj8NCj4gPiBJIGNh
biBzZWUgdGhhdC4gQnV0IEluIHYxNCByZXNlbmQgdmVyc2lvbiwgVGhlcmUgaXMgbm8gZXJyb3Iu
IFZlcnNpb24NCj4gPiAxNSBqdXN0IGFkZCBhIG5ldyBwYXRjaC4gT3RoZXIgbm8gY2hhbmdlLiBJ
dCBpcyB2ZXJ5IHN0cmFuZ2UuDQo+ID4gSWYgbm90IHRoaXMgZXJyb3IsIEkgd2lsbCB3YWl0aW5n
IG90aGVycyBjb21tZW50Lg0KPiANCj4gVjE1IGlzIHdyb25nbHkgdGhyZWFkZWQ6DQo+IC0gUGF0
Y2ggMiBoYXMgbm8gSW4tUmVwbHktVG8gLyBJbi1SZXBseS1UbyBoZWFkZXJzDQo+IC0gUGF0Y2gg
MyB0byAxMyByZWZlcmVuY2UgcGF0Y2ggMiBpbnN0ZWFkIG9mIHRoZSBjb3ZlciBsZXR0ZXINCj4g
LSBQYXRjaCAxNCBoYXMgbm8gSW4tUmVwbHktVG8gLyBJbi1SZXBseS1UbyBoZWFkZXJzDQo+IC0g
UGF0Y2ggMTUgcmVmZXJlbmNlcyBwYXRjaCAxNCBpbnN0ZWFkIG9mIHRoZSBjb3ZlciBsZXR0ZXIN
Cj4gLSBQYXRjaCAxNiBoYXMgbm8gSW4tUmVwbHktVG8gLyBJbi1SZXBseS1UbyBoZWFkZXJzDQo+
IC0gUGF0Y2ggMTcgdG8gMjMgcmVmZXJlbmNlIHBhdGNoIDE3IGluc3RlYWQgb2YgdGhlIGNvdmVy
IGxldHRlcg0KPiANCj4gU2FpZCBvdGhlcndpc2UsIHRoZSBwYXRjaGVzIGFwcGVhcnMgYXMgKHNv
cnJ5IGZvciB0aGUgbG9uZyBsaW5lcyk6DQo+IA0KPiBbUEFUQ0ggdjE1IDAwLzIzXSBSZWZhY3Rv
cmluZyBNaWNyb2NoaXAgUENJZSBkcml2ZXIgYW5kIGFkZCBTdGFyRml2ZSBQQ0llDQo+IOKUlOKU
gD5bUEFUQ0ggdjE1IDAxLzIzXSBkdC1iaW5kaW5nczogUENJOiBBZGQgUExEQSBYcHJlc3NSSUNI
IFBDSWUgaG9zdA0KPiBjb21tb24gcHJvcGVydGllcyBbUEFUQ0ggdjE1IDAyLzIzXSBQQ0k6IG1p
Y3JvY2hpcDogTW92ZQ0KPiBwY2llLW1pY3JvY2hpcC1ob3N0LmMgdG8gcGxkYSBkaXJlY3Rvcnkg
4pSc4pSAPltQQVRDSCB2MTUgMDMvMjNdIFBDSTogbWljcm9jaGlwOg0KPiBNb3ZlIFBMREEgSVAg
cmVnaXN0ZXIgbWFjcm9zIHRvIHBjaWUtcGxkYS5oIOKUnOKUgD5bUEFUQ0ggdjE1IDA0LzIzXSBQ
Q0k6DQo+IG1pY3JvY2hpcDogQWRkIGJyaWRnZV9hZGRyIGZpZWxkIHRvIHN0cnVjdCBtY19wY2ll
IOKUnOKUgD5bUEFUQ0ggdjE1IDA1LzIzXSBQQ0k6DQo+IG1pY3JvY2hpcDogUmVuYW1lIHR3byBQ
Q0llIGRhdGEgc3RydWN0dXJlcyDilJzilIA+W1BBVENIIHYxNSAwNi8yM10gUENJOg0KPiBtaWNy
b2NoaXA6IE1vdmUgUENJZSBob3N0IGRhdGEgc3RydWN0dXJlcyB0byBwbGRhLXBjaWUuaCDilJzi
lIA+W1BBVENIIHYxNSAwNy8yM10NCj4gUENJOiBtaWNyb2NoaXA6IFJlbmFtZSB0d28gc2V0dXAg
ZnVuY3Rpb25zIOKUnOKUgD5bUEFUQ0ggdjE1IDA4LzIzXSBQQ0k6DQo+IG1pY3JvY2hpcDogQ2hh
bmdlIHRoZSBhcmd1bWVudCBvZiBwbGRhX3BjaWVfc2V0dXBfaW9tZW1zKCkg4pSc4pSAPltQQVRD
SCB2MTUNCj4gMDkvMjNdIFBDSTogbWljcm9jaGlwOiBNb3ZlIHNldHVwIGZ1bmN0aW9ucyB0byBw
Y2llLXBsZGEtaG9zdC5jIOKUnOKUgD5bUEFUQ0ggdjE1DQo+IDEwLzIzXSBQQ0k6IG1pY3JvY2hp
cDogUmVuYW1lIGludGVycnVwdCByZWxhdGVkIGZ1bmN0aW9ucyDilJzilIA+W1BBVENIIHYxNQ0K
PiAxMS8yM10gUENJOiBtaWNyb2NoaXA6IEFkZCBudW1fZXZlbnRzIGZpZWxkIHRvIHN0cnVjdCBw
bGRhX3BjaWVfcnAg4pSc4pSAPltQQVRDSA0KPiB2MTUgMTIvMjNdIFBDSTogbWljcm9jaGlwOiBB
ZGQgcmVxdWVzdF9ldmVudF9pcnEoKSBjYWxsYmFjayBmdW5jdGlvbg0KPiDilJTilIA+W1BBVENI
IHYxNSAxMy8yM10gUENJOiBtaWNyb2NoaXA6IEFkZCBJTlR4IGFuZCBNU0kgZXZlbnQgbnVtIHRv
IHN0cnVjdA0KPiBwbGRhX2V2ZW50IFtQQVRDSCB2MTUgMTQvMjNdIFBDSTogbWljcm9jaGlwOiBB
ZGQgZ2V0X2V2ZW50cygpIGNhbGxiYWNrIGFuZA0KPiBhZGQgUExEQSBnZXRfZXZlbnQoKSDilJTi
lIA+W1BBVENIIHYxNSAxNS8yM10gUENJOiBtaWNyb2NoaXA6IEFkZCBldmVudCBpcnFjaGlwDQo+
IGZpZWxkIHRvIGhvc3QgcG9ydCBhbmQgYWRkIFBMREEgaXJxY2hpcCBbUEFUQ0ggdjE1IDE2LzIz
XSBQQ0k6IG1pY3JvY2hpcDogTW92ZQ0KPiBJUlEgZnVuY3Rpb25zIHRvIHBjaWUtcGxkYS1ob3N0
LmMg4pSc4pSAPltQQVRDSCB2MTUgMTcvMjNdIFBDSTogcGxkYTogQWRkIGV2ZW50DQo+IGJpdG1h
cCBmaWVsZCB0byBzdHJ1Y3QgcGxkYV9wY2llX3JwIOKUnOKUgD5bUEFUQ0ggdjE1IDE4LzIzXSBQ
Q0k6IHBsZGE6IEFkZCBob3N0DQo+IGluaXQvZGVpbml0IGFuZCBtYXAgYnVzIGZ1bmN0aW9ucyDi
lJzilIA+W1BBVENIIHYxNSAxOS8yM10gZHQtYmluZGluZ3M6IFBDSTogQWRkDQo+IFN0YXJGaXZl
IEpINzExMCBQQ0llIGNvbnRyb2xsZXIg4pSc4pSAPltQQVRDSCB2MTUgMjAvMjNdIFBDSTogQWRk
DQo+IFBDSUVfUkVTRVRfQ09ORklHX0RFVklDRV9XQUlUX01TIHdhaXRpbmcgdGltZSB2YWx1ZSDi
lJzilIA+W1BBVENIIHYxNQ0KPiAyMS8yM10gUENJOiBzdGFyZml2ZTogQWRkIEpINzExMCBQQ0ll
IGNvbnRyb2xsZXIg4pSc4pSAPltQQVRDSCB2MTUgMjIvMjNdIFBDSToNCj4gc3RhcmZpdmU6IE9m
ZmxvYWQgdGhlIE5WTWUgdGltZW91dCB3b3JrYXJvdW5kIHRvIGhvc3QgZHJpdmVycy4NCj4g4pSU
4pSAPltQQVRDSCB2MTUgMjMvMjNdIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBhZGQgUENJZSBkdHMg
Y29uZmlndXJhdGlvbiBmb3INCj4gSkg3MTEwDQo+IA0KPiBJICp0aGluayogaXQgaXMgdGhlIHJl
YXNvbiB3aHkgc29tZSB0b29scyBhcmUgbm90IGFibGUgdG8gY29uc2lkZXIgYWxsIHRoZSBwYXRj
aGVzDQo+IGFzIGEgc2luZ2xlIHBhdGNoc2V0Lg0KPiANCj4gUmVnYXJkcw0KPiBBdXJlbGllbg0K
PiANCj4gLS0NCj4gQXVyZWxpZW4gSmFybm8gICAgICAgICAgICAgICAgICAgICAgICAgIEdQRzog
NDA5NlIvMURERDhDOUINCj4gYXVyZWxpZW5AYXVyZWwzMi5uZXQgICAgICAgICAgICAgICAgICAg
ICBodHRwOi8vYXVyZWwzMi5uZXQNCg0KSSBrbm93IHdoYXQgdGhlIHJlYXNvbiBpcyAuIEkgaGF2
ZSBzZW50IHRoZSBwYXRjaGVzIHdpdGggZGlmZmVyZW50IGUtbWFpbHMgcmVjZWl2ZXJzLiANCkkg
YW0gc29ycnkgYWJvdXQgaXQgLiBJIHdpbGwgcmVzZW5kIHRoaXMgdG9kYXkuDQo=

