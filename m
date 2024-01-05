Return-Path: <linux-pci+bounces-1700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E310824F0C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 08:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7113C1C227CC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E61078B;
	Fri,  5 Jan 2024 07:10:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2058.outbound.protection.partner.outlook.cn [139.219.146.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0818041;
	Fri,  5 Jan 2024 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LABp2Xd8JFXjhBWoVLQVtpZmBrmzBAtPTFoOWTW3DOtkz3rTxFv56pRoBN3xDlxbE4kEiZ6OZN8ylznwblOATKoptMAOXXWsjmvA98b6N5vcdOB6Go4Tba58HNuBbPFO3jQiZOb5qFJZvt7Ms+8DKR7p3HiK14jq9Io7iCpMwNtlJR374YA/DoyfhKcLMxBzS330DotQT2VRYmb8G9CajVIOgJAFoTnAlswFRBXIjUf4ycvpeZ9QGOh9VCD5Ih1/LdY+6RSVI6SXW+3XbYd+6KST26tXzY/A3nGg/4VrIcxU78y9A7BykAhU2oq1tI9fFa6KBpg160VJbANVLOoRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxmeZJF60lnX5RnKDVwlgUX0Ere9i+J3XylcRcaC1Mc=;
 b=ESdbdyR41eKcDEaoSoxNv/t/MfZRYxoHtk/ZzwPPVTb6T4hbPYPjM28dE6hBXZAUhYy1l77XWC8tUcfXXLNoGe9vG4zAaXBCBBtzqT9o89SVFWyKGP4u+FoHx3e7YTJAKHxr1a0vsSvUgCacVldJ3XDoxrOAQoWwm6MtlkYr14f8Xu/T/C7yD/2WHNspSlgf2TYiJH7l63ThrnG0/411GyLyp8hex0GZHWf23N4NiXErwfLoznpqWGm3K/l/31eyRz6NdbkZf78NC0f7kelgYSQGJMd9BW28l9d2j3a+v29URN31XoqtVJrmKWfUUdCLOyacr3N9/puiE7jTiqXnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1222.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Fri, 5 Jan
 2024 02:35:10 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::4583:3e2:da11:265e]) by ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::4583:3e2:da11:265e%6]) with mapi id 15.20.7135.013; Fri, 5 Jan 2024
 02:35:10 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Kevin Hilman <khilman@baylibre.com>, Minda Chen
	<minda.chen@starfivetech.com>, Conor Dooley <conor@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>, Rob Herring
	<robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxMyAwLzIxXSBSZWZhY3RvcmluZyBNaWNyb2NoaXAg?=
 =?gb2312?Q?PCIe_driver_and_add_StarFive_PCIe?=
Thread-Topic: [PATCH v13 0/21] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Thread-Index: AQHaPpXiMe+t6/O8C0OnZGJ4Y32LtrDKgdAQ
Date: Fri, 5 Jan 2024 02:35:10 +0000
Message-ID:
 <ZQ0PR01MB098128579D86207B4B9BA7D28266A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <7hfrzeavmj.fsf@baylibre.com>
In-Reply-To: <7hfrzeavmj.fsf@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1222:EE_
x-ms-office365-filtering-correlation-id: 080d11ca-2a84-44e3-88ea-08dc0d96f03f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 10Er+8cBEExcgmcApRf21maOJZ/Crw6wAugR2L6mo0p0zIrJw5hqsB8nLCfJ+egqxIj7+vvr3LY6EujoIloaN7rMeAaeWNMspXVl4ZYSWt10U9oJTCMEwbeHy4D5KCGK2bi21l7BN1eFbiD8stF6mEzH5Wxemmrek47sOQisA67hFX/BkVHKT91M2K4MElewwAaxXJ+UX541gaUtZBQOx0Jv0nJsdpJXsQkhywvvjQnKAP4aNOvL4PVahMdjWetGJn3cqLuGYuoJqTgYh3ZakWs9QuT2uXLR7v32R9Mpr5TBn1K7/LXzuVbKqca5kEBkA5RIl4nVxL8GZfT2yRIy4xGV0oCvp9Y3li7GwHkMn5it9ECe7Nt6jGt3+O5Y68e6lYJNJNqxDXUahkvSpRgkRB5ybus+15wGWlf3dELvtm4BSxHO9EmmovEBz7kJf7X/SX0kOvYQyu0ztqHJ48c8xRziKZ/W8Uuds6faCxD+Og/B8bW0BwKo87h5XX2zeG8QOU712sIZjUy7mqE35OqiZ5wan5+UK5OtOj3ynkxmmyYDDzSh4mm8uu7KEsHID/fv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(508600001)(2906002)(40180700001)(44832011)(5660300002)(7416002)(921011)(122000001)(40160700002)(33656002)(38100700002)(55016003)(4326008)(8936002)(7696005)(224303003)(66446008)(38070700009)(66476007)(76116006)(66946007)(9686003)(71200400001)(54906003)(64756008)(110136005)(66556008)(26005)(41300700001)(86362001)(83380400001)(107886003)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MkVIR1huZm03b0VFTXdHVGpEcStjUjFkQnBsRnRXYjdKM1E4V0RoOE5PVVgr?=
 =?gb2312?B?cER5d2VlNmpVN2VWTE9LbUVlb0J2VDQ2M1JqTkNpaHlnNGV6Nkg4RUxxVnpL?=
 =?gb2312?B?UGdSdHV5YlpsaDZqSHg0MnN2UjA5a0RNRS9IWnR5emFXb1Z0bWU5SjFFV0w0?=
 =?gb2312?B?WTRYRW40OVVnVnhkQ1hNS3hvb1lxKzNWMURsdDBiNEVqS3RTNXdoQ2tOemtT?=
 =?gb2312?B?c1VLN0x5Vm9jNzdKaW5FTHhLa1NBWko3NmFhNjJoanQvdVRWamp3SmZCNW5z?=
 =?gb2312?B?Q2FsRHFwdE9leThGenVGem5JQ3F0M1loU2xxVTk0REN0Rng0L0tiOCtLT2pz?=
 =?gb2312?B?a0Y0ZzlpMkNjN2ljVjRMTnQrVCszaURTRW1TSDhEMWU4NFM2c00yVU40S2hG?=
 =?gb2312?B?alpJNW8ya2c5SU5LVnZDc09McVVqVTlUcHE4RTljZW9ldHVJWVBBcGVVbzZo?=
 =?gb2312?B?bW9EZmg1c1JULzVodU9Yb0xBZnZuMUFoVVJEV2JJR0NpY1l1R3p2ZEVsdGlp?=
 =?gb2312?B?YkVHRjRJSGE2OGVpR2xSM1FTZitpaHNBZXR1Q3I4VWtlcWxYV09FQlRuais5?=
 =?gb2312?B?OHkzVW56Q05ERjVSV2JkMUtMSzFXZzhPaXM0cHQzWHpWZWRtcFgwRWFvbUZi?=
 =?gb2312?B?UDlCMzNoWEErRHNkZzRjVVNCZFh5bGx5aERQeGo4VktkMHZ0WDZWZStFR3JO?=
 =?gb2312?B?Rmo1SENKVjR1eDBCRmdDakN6bDQ3VG1uNHhyV3c1dFVhV2V1M0tRbWh3ZWt5?=
 =?gb2312?B?NDBnYW5sQ3FZZTdyd3BEM2lCUHFTZldUYTQyUE1lRTJaRUE1ZGNBQlAxeEZN?=
 =?gb2312?B?S2k5ZUZyMWZTN3o3UmhlQmx2eUFQTXZCeC9vWXlRelhQUTFvUHZzU2wvMjBG?=
 =?gb2312?B?TFJTNXpBZzhkT2tERlJSNGVlMk1BVGRtY2ZBZjNJaElhTVhuVkN1ZnpMQnBH?=
 =?gb2312?B?eGVIOWh2M1JobzBySk5qUHZ1bXhNVEE4ait5L0xvb2J1bys2SlIrMjA1UGNC?=
 =?gb2312?B?RTBPWlNBZnRESlFpSHNwNjZwZXdWR0pKajlwbCtVYVprQUJnbjM1eW9pZFkz?=
 =?gb2312?B?VmdlM2p3MUJ5dzgrM1dHeko1VjNyQnhxTndyWmIxNE9sQ0xnOEN1TDg5OHN5?=
 =?gb2312?B?cHV4M3Z2eFJkNGZBY2svNjloWnNGTFhHTVVEWWY5RTNHUFcyMlNoNGRUQk9D?=
 =?gb2312?B?TGhJTGlUMW9OQUdYUGxITHVlMStqdjBxMFJhcmVqbFZoV0VuaHROQnloZ1JS?=
 =?gb2312?B?TFYrYm8vbXAvQkU3VmlwSzNZSk9YSGo1ZkVnS0lVWHlIa2dUMzBlTlZ6NlVG?=
 =?gb2312?B?eDNBOWZXcUorZUsrSzlwWnJYSUxmM2x2ODFEVGNZcXV1d1pTVHg3MU8vWUo0?=
 =?gb2312?B?ZkNwZnJEMzk4K3lQb2Y1MkdqMjV4VFc5cVZvbGFUbEI0UmJuSW9zVjN3ZCtX?=
 =?gb2312?B?SVVVd21vMUxNckVWdUxXN3VuK01TY21DQUNWTzJCT0lTUjFMMWljSEp0Ui9D?=
 =?gb2312?B?N3pNR2xoR1dRTVZWb25tTEFoT3FCcUg5ZXNVdERvTTJsa3lmN1cySU8zamxO?=
 =?gb2312?B?T0hmR1dGVmhsVjNQWVJmZFdzK3h3Z3ZwZjJ3Rm9mRUF5N3Y3VXhXRDBBSnFJ?=
 =?gb2312?B?eXBzcXhDQ0JVSEE0anRSd0RFclNhSksxdDladHNGY1lHaDVMZktUSkRzeUpQ?=
 =?gb2312?B?dW9nNC9KTlhNVk11NzZRbGZoaVF0Z0JwWDEydXFncjRHUTV1Z0U2dm9wNHZI?=
 =?gb2312?B?S295SllPTXE1bll5NW1vMEhZSTlPSHRuM3IrZHBJbkxKV3laS0hMOUE4d0g1?=
 =?gb2312?B?WTVXcnlOUkM3TG5zMXE0b0RkMEwwMm9vUWxZdWh1dVhuSkNIajk4L3lMNm5r?=
 =?gb2312?B?b1NQRGpaOWZISnNINVJ3ME8zZ2hHUkpNd1d4SjNiL2k2ck5PTWNUTklESzhB?=
 =?gb2312?B?V1BHSk16RXdsZy9qNjhnRTRFVExsNFlvVCtUdlcvN1o4LzFhRnFKVzNnd0hR?=
 =?gb2312?B?Y3NIc1F0MkhaSnZQTnpYZzE5a0E1cWdpdDFJTlYxVDdFOTlWN2RYditUUFFh?=
 =?gb2312?Q?E5NpbJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 080d11ca-2a84-44e3-88ea-08dc0d96f03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 02:35:10.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuW/hQSaTVCShMEefGwO+JscG0WbVMEKYx08f3G0Iwx6Y6sEDx5EJOLThoFx20ErRHNbvG33xkw91Mhsl69tgYSNLNY/tWKD0tWqid/srRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1222

PiBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gVGhpcyBwYXRjaHNldCBmaW5hbCBwdXJwb3NlIGlzIGFkZCBQQ0llIGRyaXZlciBmb3IgU3Rh
ckZpdmUgSkg3MTEwIFNvQy4NCj4gPiBKSDcxMTAgdXNpbmcgUExEQSBYcHJlc3NSSUNIIFBDSWUg
SVAuIE1pY3JvY2hpcCBQb2xhckZpcmUgVXNpbmcgdGhlDQo+ID4gc2FtZSBJUCBhbmQgaGF2ZSBj
b21taXQgdGhlaXIgY29kZXMsIHdoaWNoIGFyZSBtaXhlZCB3aXRoIFBMREENCj4gPiBjb250cm9s
bGVyIGNvZGVzIGFuZCBNaWNyb2NoaXAgcGxhdGZvcm0gY29kZXMuDQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHRoaXMgc2VyaWVzLg0KPiANCj4gSSB0ZXN0ZWQgdGhpcyBvbiBhIFZpc2lvbkZpdmUgdjIg
Ym9hcmQsIGFuZCBpdCBzZWVtcyB0byBwcm9iZSBhbmQgZmluZCBteQ0KPiBNLjIgTlZNZSBTU0Qs
IGJ1dCB0aGVuIGdldHMgdGltZW91dHMgd2hlbiB0cnlpbmcgdG8gdXNlIHRoZSBOVk1lIChlLmcu
DQo+ICdibGtpZCcgY29tbWFuZCkNCj4gDQoNCkhpLCBLZXZpbjoNCkNvdWxkIHlvdSBwbGVhc2Ug
cHJvdmlkZSB0aGUgbWFudWZhY3R1cmVyIGFuZCBtb2RlbCBvZiB0aGUgTS4yIE5WTWUgU1NEDQp5
b3UgdGVzdGVkPw0KDQo+IEtlcm5lbCBsb2dzIGJlbG93Lg0KPiANCj4gS2V2aW4NCj4gDQo+IFsg
ICAxNS4xMzEwOTRdIHBjaWUtc3RhcmZpdmUgOWMwMDAwMDAwLnBjaWU6IGhvc3QgYnJpZGdlDQo+
IC9zb2MvcGNpZUA5YzAwMDAwMDAgcmFuZ2VzOg0KPiBbICAgMTUuMTM4NjM3XSBwY2llLXN0YXJm
aXZlIDljMDAwMDAwMC5wY2llOiAgICAgIE1FTQ0KPiAweDAwMzgwMDAwMDAuLjB4MDAzZmZmZmZm
ZiAtPiAweDAwMzgwMDAwMDANCj4gWyAgIDE1LjE0NzE4MF0gcGNpZS1zdGFyZml2ZSA5YzAwMDAw
MDAucGNpZTogICAgICBNRU0NCj4gMHgwOTgwMDAwMDAwLi4weDA5YmZmZmZmZmYgLT4gMHgwOTgw
MDAwMDAwDQo+IFsgICAxNS4zNjgwNDBdIHBjaWUtc3RhcmZpdmUgOWMwMDAwMDAwLnBjaWU6IHBv
cnQgbGluayB1cA0KPiBbICAgMTUuMzc0MjE5XSBwY2llLXN0YXJmaXZlIDljMDAwMDAwMC5wY2ll
OiBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDE6MDANCj4gWyAgIDE1LjM4MDk0NF0gcGNpX2J1
cyAwMDAxOjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQ0KPiBbICAgMTUuMzg2NDQz
XSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0NCj4gMHgzODAwMDAwMC0w
eDNmZmZmZmZmXQ0KPiBbICAgMTUuMzkzMzMwXSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJl
c291cmNlIFttZW0NCj4gMHg5ODAwMDAwMDAtMHg5YmZmZmZmZmYgcHJlZl0NCj4gWyAgIDE1LjQw
MDg4Ml0gcGNpIDAwMDE6MDA6MDAuMDogWzE1NTY6MTExMV0gdHlwZSAwMSBjbGFzcyAweDA2MDQw
MA0KPiBbICAgMTUuNDA3MTY1XSBwY2kgMDAwMTowMDowMC4wOiBzdXBwb3J0cyBEMSBEMg0KPiBb
ICAgMTUuNDExNDQ3XSBwY2kgMDAwMTowMDowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQx
IEQyIEQzaG90DQo+IEQzY29sZA0KPiBbICAgMTUuNDE5OTY0XSBwY2kgMDAwMTowMDowMC4wOiBi
cmlkZ2UgY29uZmlndXJhdGlvbiBpbnZhbGlkIChbYnVzIDAwLTAwXSksDQo+IHJlY29uZmlndXJp
bmcNCj4gWyAgIDE1LjQyODI0NV0gcGNpIDAwMDE6MDE6MDAuMDogWzEyNmY6MjI2M10gdHlwZSAw
MCBjbGFzcyAweDAxMDgwMg0KPiBbICAgMTUuNDM0MzMxXSBwY2kgMDAwMTowMTowMC4wOiByZWcg
MHgxMDogW21lbSAweDAwMDAwMDAwLTB4MDAwMDNmZmYNCj4gNjRiaXRdDQo+IFsgICAxNS40NDE1
NzhdIHBjaSAwMDAxOjAxOjAwLjA6IDQuMDAwIEdiL3MgYXZhaWxhYmxlIFBDSWUgYmFuZHdpZHRo
LA0KPiBsaW1pdGVkIGJ5IDUuMCBHVC9zIFBDSWUgeDEgbGluayBhdCAwMDAxOjAwOjAwLjAgKGNh
cGFibGUgb2YgMzEuNTA0IEdiL3Mgd2l0aA0KPiA4DQo+IC4wIEdUL3MgUENJZSB4NCBsaW5rKQ0K
PiBbICAgMTUuNDU2OTEwXSBwY2lfYnVzIDAwMDE6MDE6IGJ1c25fcmVzOiBbYnVzIDAxLWZmXSBl
bmQgaXMgdXBkYXRlZCB0byAwMQ0KPiBbICAgMTUuNDYzNTUzXSBwY2kgMDAwMTowMDowMC4wOiBC
QVIgODogYXNzaWduZWQgW21lbQ0KPiAweDM4MDAwMDAwLTB4MzgwZmZmZmZdDQo+IFsgICAxNS40
NzAzNTJdIHBjaSAwMDAxOjAxOjAwLjA6IEJBUiAwOiBhc3NpZ25lZCBbbWVtDQo+IDB4MzgwMDAw
MDAtMHgzODAwM2ZmZiA2NGJpdF0NCj4gWyAgIDE1LjQ3NzY5OV0gcGNpIDAwMDE6MDA6MDAuMDog
UENJIGJyaWRnZSB0byBbYnVzIDAxXQ0KPiBbICAgMTUuNDgyNjg2XSBwY2kgMDAwMTowMDowMC4w
OiAgIGJyaWRnZSB3aW5kb3cgW21lbQ0KPiAweDM4MDAwMDAwLTB4MzgwZmZmZmZdDQo+IFsgICAx
NS40ODk2MzJdIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+
IDAwMDIpDQo+IFsgICAxNS40OTYwMzhdIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDogUE1FOiBTaWdu
YWxpbmcgd2l0aCBJUlEgNTYNCj4gWyAgIDE1LjUwMjQ3Ml0gdXNiIDEtMTogbmV3IGhpZ2gtc3Bl
ZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4aGNpX2hjZA0KPiBbICAgMTUuNTA5NzU1XSB1
c2IgdXNiMi1wb3J0Mjogb3Zlci1jdXJyZW50IGNvbmRpdGlvbg0KPiBbICAgMTUuNTE1ODgzXSBu
dm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMTowMTowMC4wDQo+IFsgICAxNS41MjA2MTVdIG52
bWUgMDAwMTowMTowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikNCj4gWyAgIDE1
LjUzMjY4NV0gbnZtZSBudm1lMDogYWxsb2NhdGVkIDY0IE1pQiBob3N0IG1lbW9yeSBidWZmZXIu
DQo+IFsgICAxNS41NTAwNzBdIG52bWUgbnZtZTA6IDQvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1
ZXVlcw0KPiBbICAgMTUuNTYyOTkyXSBudm1lIG52bWUwOiBJZ25vcmluZyBib2d1cyBOYW1lc3Bh
Y2UgSWRlbnRpZmllcnMNCj4gWyAgIDE1LjY2MzMyN10gaHViIDEtMToxLjA6IFVTQiBodWIgZm91
bmQNCj4gWyAgIDE1LjY2NzMyMF0gaHViIDEtMToxLjA6IDQgcG9ydHMgZGV0ZWN0ZWQNCj4gDQo+
IFsgICA0Ni4wNjQwNTJdIG52bWUgbnZtZTA6IEkvTyA0MjQgUUlEIDMgdGltZW91dCwgY29tcGxl
dGlvbiBwb2xsZWQNCj4gDQo+IFsgICA3Ni43ODQwNDZdIG52bWUgbnZtZTA6IEkvTyA0MjUgKEkv
TyBDbWQpIFFJRCAzIHRpbWVvdXQsIGFib3J0aW5nDQo+IFsgICA3Ni43OTAxNzldIG52bWUgbnZt
ZTA6IEkvTyA0MjYgKEkvTyBDbWQpIFFJRCAzIHRpbWVvdXQsIGFib3J0aW5nDQo+IFsgICA3Ni43
OTYyOTRdIG52bWUgbnZtZTA6IEkvTyA0MjcgKEkvTyBDbWQpIFFJRCAzIHRpbWVvdXQsIGFib3J0
aW5nDQo+IFsgICA3Ni44MDI0MTFdIG52bWUgbnZtZTA6IEkvTyA0MjggKEkvTyBDbWQpIFFJRCAz
IHRpbWVvdXQsIGFib3J0aW5nDQo+IFsgICA3Ni44MDg1MjVdIG52bWUgbnZtZTA6IEkvTyA0Mjkg
KEkvTyBDbWQpIFFJRCAzIHRpbWVvdXQsIGFib3J0aW5nDQoNCg==

