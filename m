Return-Path: <linux-pci+bounces-4940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C4880D53
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDD28179D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9238DE8;
	Wed, 20 Mar 2024 08:42:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5538394;
	Wed, 20 Mar 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924177; cv=fail; b=OdEmKHrXb96+AnQktF6OUs9OqBdL1aWavlT9dfAQIHhvKozTTWQLaL84hpHjwph4yy8qSdQCZZYp69J4dhU4fzDMFlw/dsUTt5p0OBFXIFOscrj8n80oEzY0O1Wq+lx24VztWPQxvlAwxLmFgVoh+IvVMcuOAnOY7bBdMHknVjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924177; c=relaxed/simple;
	bh=BL16nXSoOK/jp0XLz3NT7aQkbt+ODj92ICQPrGSflJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCNJZF+nr66s+yY025fJknxIMiLFBVBO6V7Ud18IxGhzdOgasaXzMvlA+OgvstW2fzWru5oVq47UFleq2funcUpJQz+mGDPKINaagVtDq16TMr+jsZiFAaGbSF6uyLdM47GE3WEg6uQcPPLoXyW56pUQph4grHBH0dQAIV5FfYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggw3bdGgUmdVycNZgnoGoDQ0igZaqN8k1xvaU71xIHAtLwKuOoaG8WC192Rz5C9IX/bCsundgZH5ZJEF/w0Ld7jozd9chEOgYhCPo85Jq4aWrL5i6dbZk6Ts9qpgw9EtUgMntDDlFN6vOp+sHuZdT62EkB6KyWA4ZFORuteG2RYojp5ZWphSE3RASLklK3BDT2HjNUPXZlVd/OJe001d4dYUkWTfTGmOJdLXjS9ZK6Kb3xvdF9HUP4yoshFOBqvTgD2tMnYm+l1YB/oIIb9qjIbOGkbLjA+CbB3Z9JGZpRMYHpN4ZaJ2BSh1U1qs7bO3Dqk8nLLZfjsOVtl3rm0D+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL16nXSoOK/jp0XLz3NT7aQkbt+ODj92ICQPrGSflJo=;
 b=ZV0BWlWn5FtBuhIqkxuPU9oZW+OIfGJTZ+IS5p36vjWaMmRDN2NPrrNjjLBP5/oRAlYj9qvoy87TOX3O6sQ9aDp9uRKsjzLGpWiyhRfv5Mr4PKHjncjKGlTy1Y08uXJvQJPjPgP/8uCS9n6zB81txJUN0H9FqVXJ0qvKZtWpRzXcsd1blgAHjn8+8ZTgE1mPXHFJbfZbmydkFloBXtVH0OjAO0Z6YCsi0BbToyHU+tvYExyYKCsMf60xRizYvRBQHZ74nIRorOpsr2fNoDmSYyQhifWKBdq/lPxGF0N5anKLQdXwtdlqfcGyoMp4pW/n0YuJcHYaSk1TheLfu0CCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1205.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:42:43 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::851a:37c6:7c9c:fca1]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::851a:37c6:7c9c:fca1%6])
 with mapi id 15.20.7409.010; Wed, 20 Mar 2024 08:42:43 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Bo Gan <ganboing@gmail.com>, Keith Busch <kbusch@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Minda Chen <minda.chen@starfivetech.com>, Conor Dooley
	<conor@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "daire.mcnamara@microchip.com"
	<daire.mcnamara@microchip.com>, "emil.renner.berthing@canonical.com"
	<emil.renner.berthing@canonical.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Thread-Topic: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Thread-Index:
 AQHaaWi+d9assvQENEqJ5rz8wQxEZrEhb4yAgAZ7cgCAAW1+gIANQI1QgAAJLICACbbhAIAAGT6A
Date: Wed, 20 Mar 2024 08:42:43 +0000
Message-ID:
 <ZQ0PR01MB0981DB4002BAECB38DAF0AE18233A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <ZeCd+xqE6x2ZFtJN@lpieralisi>
 <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
 <ZedAn8IC+Mpm4Sqz@lpieralisi>
 <ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <ZfJmMcs2UThVSC4v@kbusch-mbp>
 <16a1e6c6-2e2f-08e5-8da0-1462cec57e1f@gmail.com>
In-Reply-To: <16a1e6c6-2e2f-08e5-8da0-1462cec57e1f@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1205:EE_
x-ms-office365-filtering-correlation-id: 556f4601-3703-4b3c-bb46-08dc48b9b592
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ExIr/q1UgPIWffRBleam6lVXiP1wHfUTxFklInCrGOVrQuvXoTflXFWCX366u0fhNVNeaZFvTowI+AmbBqey0OYxqaMovrU6kYsnRKvqkQdF4z052dx52buZIhPiyKeThofDkvaL+VcIjckHOfk6Lcf1o7Zwmg3CiNtC+0hZto1rFhU8KW/7UHHd6dKYaZ1m0iAAAosCPITEcZivYyywSFi19TzDx5Ri6fdNuLzwLhUH7T/PfKvpvpUYLmFrTOq/ySpnuP7G99SB8KLAiuhBoDSABSmp+OJ+qbFMo4oDpZZvpw5XnU6rYbElyxcJIIwOrMLpo4t7ZwuWfqgoS72DCljdtVIV5iPogMgerVkf/a9bHuPFzAhWsm/Kpv+/u2+jxqxCZjpwSJF4y7gJ2FqrET34XjzekFWjAs8b0rX+ePE2hdzPiKtUiidAQaYEulf1ntyzQjDOA7Gfjd2XC0yDdgHjegg0nh70KwL9CN7vDg9WiVKdyMLSC/o/dTdkZHmEA/16FBqFehGqp1g5Ow6xTzhDZXk5I38d8XMbGCrbZLRDk58s8Jeu4eZJk1RM7Xg8Po8hM/a+fdmOW7pIax7Bbkb86ylolTLKBtyQgiy/hi1fDOLDMVvpTEpL60kE//ke
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R01ldk1NZlZ6U0dzNWlPY01oeCtaMERNQWhNbUZuQjBqQURkNTY5TTVyTVJo?=
 =?utf-8?B?OExRcGppdldBODdJZWZRbExjOW04RTFFVEd5NGUwSDl1RWR5RkVJN0V0Q0dD?=
 =?utf-8?B?T3NsbDRocy9tWWUyUXREUlVWcitLRlhtV3c4a3JCb2pJeEZQeVA1cUUxbGJ2?=
 =?utf-8?B?aitsYkcyVlhrOUIwNW9xN3dNNkNJbkRUSWtBOXdya1l6dlE3SlF0Y3IrWVNs?=
 =?utf-8?B?YVFyeWdmUlNvRXJGUUwvZlhVU1JNU1p6S2Y3OXNUQ0Z5VXhySEplbHcxTTNa?=
 =?utf-8?B?ZHIzSk9xY2V3YXo5b0lHZzdJYU9QMlpxREtpeFZVRkxhdlJLWVF5YTZxMjhP?=
 =?utf-8?B?d1lTUzdyMWcyeGVXVStjU04va0dqT3hqaTZRRzFhS3J2TlluRzloMFFDWjMw?=
 =?utf-8?B?d29Jc1JRMnVJMElLWnBLM1Z5OHpOeUtlbFUrMGFpQnNEODlVR3Z4TjlPTzM3?=
 =?utf-8?B?dWhOTVFWN3dFZEZ4bTE5QXRJRCt5NVRFd3hvQzlDZWNERFYxWmpyNUlvNCtv?=
 =?utf-8?B?MkhIOXFJc1d6b3h0aDduTTdOaEpFd2dOY1I5RC8wMjc3aVVCbXRVUVFuRDNa?=
 =?utf-8?B?aExaWGk5cVpGa2N4Z25mWCtzNnNJT1QrWWkwTE0zODgwK1JoVkhjTUMwblV0?=
 =?utf-8?B?V3c1WWdSWWRTQTFUdEVjRXpyU0J1bldYZ2R4MDBNUDJmUk9QRXNzamFKZTVR?=
 =?utf-8?B?aFNFQlJPV3MrUXAxenRNRXdTRy9VUytiSldmVG9ERlpOdmFNQ2QvbERJQlha?=
 =?utf-8?B?bHdTczkzR0pEUjEwbHZKOWE4cjJGUlJ4dUJkVEp3a1Nld24wUWJQMDdiNXN5?=
 =?utf-8?B?SXZzdEJZM2JrMEZiUUJJeTMxYmZxMXRvN1NjOXVSMHloWDdWMWNYNVZQODRF?=
 =?utf-8?B?ci9ISTZJSG1tNkFsL1c1SDZFRkFvQ3d4QVp6MVFOSnhVdlNjMG43VnFsekFa?=
 =?utf-8?B?ZUNOS0dITk9PaStWSDZobUhJOVhyYmZCMTlYOWVpYWdJdjJPM0IxZm94dk4v?=
 =?utf-8?B?M3daeWhOR0VKS1R0UG1SRm14SHpwVEQ1cnlxV0NFMDF3WktHblhtVGIyblFn?=
 =?utf-8?B?REp2RXZESVRNUitpZTZXMU1NQzNaVGJXenRIQkg2Ync3TmRvLzJ2R0J3NWRV?=
 =?utf-8?B?ZTM3dG5XMWQyL0xJOEVsM2tXRVprYWowVC9OdCtFNjdhNkFLNERXWGFaRGtx?=
 =?utf-8?B?TUJZVk9nMGdoQy84NVFCUzQxSkxCNVNZcW1JNmU1Z2REVEp1dGlDaEJrZU5i?=
 =?utf-8?B?TzVzY3dJZlZGemtyczV0Y2pEYzEveTJWOXZhd1k5K2RNcnNWNXhkajk3VmZh?=
 =?utf-8?B?dEF0RmRueHM4UDhVMThYS0pmSCtXQUlLd3hmZFMvN1ZVdU9pZ1VHY2YzMndQ?=
 =?utf-8?B?d3lRM21US3pXOHpLUE5mL0dYK1BHQ3lMdGY4SGE1WCtHMmVJL0V3QlF6MzZG?=
 =?utf-8?B?YUZsU3VCN3I1bmFKTDJUTVJuOWp5YkpKblY2dGtzWEVhNXFnNUZ2NUZNaVpT?=
 =?utf-8?B?MHNOdlhGNzhLYk85UUdoQ0RBRnJ1dmNzT2ZldHZsN3I1dlRmQ09rM2thbW1B?=
 =?utf-8?B?azYxVm44K09KbXgwcERNUjFJU1ZKK3dMdm8rYUMzeGVhMUQzOTNTU3BlVzVr?=
 =?utf-8?B?Yk9iYWdZN3pkR2hQbzhjblhsRlJ3aFhsVm5xcjBkQ3RaOUdLcTFnWkx3UTQ4?=
 =?utf-8?B?MjNPek9YU04rS1VuM3EwQzUzd1BjQWZkMGpydGtDcXE4aWo0TnJ0SWxSc0w1?=
 =?utf-8?B?cU5GN0ZxZGEveGxKU2lSOXBYVjgxT0JVL0hNeXdDNTRjQU9CcnJGMC9oSXJa?=
 =?utf-8?B?ZWFUb0JEdis0WWwxQ25PbWlPL0VTWXY2T1h0SGkxSDFZSkMwN082QWlLTlU0?=
 =?utf-8?B?aGlLZjJJaVdzUWRCQllxUkZ6SnF4bE5IaDVVZEZHSklpMDhTenczekRiMTRj?=
 =?utf-8?B?OXlobzVadzlheDdHRWRYNDIwRFBVakhraDFPdzBMZXIvUzMvcmUxVU9IaXpS?=
 =?utf-8?B?cDc1ZUVvTThRVmdsR2hMcE5sMnFiZ0R0dHowRXl3SkVUaFYxR1pZa242VndP?=
 =?utf-8?B?bzRtUHZ1SExXT2FHbHJyRGlsV2R4RXFOM1BJRzNZUWF3cjFBVzByUTcrN3VZ?=
 =?utf-8?Q?65FIdXWGcaPvXruG1bXAsqr60?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 556f4601-3703-4b3c-bb46-08dc48b9b592
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 08:42:43.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUhNBFrbEs1HXbNNQOctLpv5ROW1KWKfJyAP2JJRHo4L1gCATo9y7GIEd0s+2WczHjEmt8HGCezWdACwT40qrSSSJ/5aSPp6IPkQvEwrefk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1205

PiBPbiAzLzEzLzI0IDc6NTEgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiA+IE9uIFRodSwgTWFy
IDE0LCAyMDI0IGF0IDAyOjE4OjM4QU0gKzAwMDAsIEtldmluIFhpZSB3cm90ZToNCj4gPj4+IFJl
OiBbUEFUQ0ggdjE1LFJFU0VORCAyMi8yM10gUENJOiBzdGFyZml2ZTogT2ZmbG9hZCB0aGUgTlZN
ZSB0aW1lb3V0DQo+ID4+PiB3b3JrYXJvdW5kIHRvIGhvc3QgZHJpdmVycy4NCj4gPj4+DQo+ID4+
PiBPbiBNb24sIE1hciAwNCwgMjAyNCBhdCAxMDowODowNkFNIC0wODAwLCBQYWxtZXIgRGFiYmVs
dCB3cm90ZToNCj4gPj4+PiBPbiBUaHUsIDI5IEZlYiAyMDI0IDA3OjA4OjQzIFBTVCAoLTA4MDAp
LCBscGllcmFsaXNpQGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4+Pj4+IE9uIFR1ZSwgRmViIDI3LCAy
MDI0IGF0IDA2OjM1OjIxUE0gKzA4MDAsIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4+Pj4+PiBGcm9t
OiBLZXZpbiBYaWUgPGtldmluLnhpZUBzdGFyZml2ZXRlY2guY29tPg0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+IEFzIHRoZSBTdGFyZml2ZSBKSDcxMTAgaGFyZHdhcmUgY2FuJ3Qga2VlcCB0d28gaW5ib3Vu
ZCBwb3N0IHdyaXRlDQo+ID4+Pj4+PiBpbiBvcmRlciBhbGwgdGhlIHRpbWUsIHN1Y2ggYXMgTVNJ
IG1lc3NhZ2VzIGFuZCBOVk1lIGNvbXBsZXRpb25zLg0KPiA+Pj4+Pj4gSWYgdGhlIE5WTWUgY29t
cGxldGlvbiB1cGRhdGUgbGF0ZXIgdGhhbiB0aGUgTVNJLCBhbiBOVk1lIElSUQ0KPiA+Pj4+Pj4g
aGFuZGxlDQo+ID4+PiB3aWxsIG1pc3MuDQo+ID4+Pj4+DQo+ID4+Pj4+IFBsZWFzZSBleHBsYWlu
IHdoYXQgdGhlIHByb2JsZW0gaXMgYW5kIHdoYXQgIk5WTWUgY29tcGxldGlvbnMiDQo+ID4+Pj4+
IG1lYW5zIGdpdmVuIHRoYXQgeW91IGFyZSB0YWxraW5nIGFib3V0IHBvc3RlZCB3cml0ZXMuDQo+
IA0KPiBFY2hvaW5nIEtlaXRoIGhlcmUuIFdoeSBhcmUgeW91IHRyZWF0aW5nIE5WTWUgY29tcGxl
dGlvbnMgKyBNU0kgYXMgYSBzcGVjaWFsDQo+IGNhc2U/DQo+IFdoYXQncyBzcGVjaWFsIGFib3V0
IHRoaXMgY29tYmluYXRpb24gb3RoZXIgdGhhbiB0d28gcG9zdGVkIHdyaXRlcz8gSSBvd24NCj4g
Skg3MTEwIHZpc2lvbmZpdmUgMiBib2FyZHMgbXlzZWxmLCBhbmQgaWYgSSdtIG5vdCBtaXN0YWtl
biwgdGhlcmUgYXJlIHR3bw0KPiBpZGVudGljYWwgUENJZSBjb250cm9sbGVycyBpbiBKSDcxMTAu
IFRoZSBmaXJzdCBvbmUgY29ubmVjdHMgdGhlIG9uYm9hcmQgVVNCDQo+IGNvbnRyb2xsZXIgb2Yg
dmYyLCB3aGljaCBhbHNvIGVuYWJsZXMgTVNJIGludGVycnVwdHMuIEhvdyBjb21lIHRoaXMgZXhh
Y3QNCj4gcHJvYmxlbSBub3QgYWZmZWN0aW5nIHRoZSBVU0IgY29udHJvbGxlcj8gVGhlIGNvbW1p
dCBtZXNzYWdlIGZyb20gTWluZGENCj4gc3Ryb25nbHkgc3VnZ2VzdHMgaXQgZG9lcywgYW5kIGFs
c28gZm9yIFI4MTY5IE5JQy4gVGh1cywgd2h5IHdvdWxkIHlvdSBzdWdnZXN0DQo+IHRoZSBwcm9i
bGVtIGlzIGNvbmZpbmVkIHRvIE5WTWU/DQo+IA0KPiBCbw0KPiANCg0KSGksIEJvLCANClllcywg
d2UgaGF2ZSB0d28gUENJZSBjb250cm9sbGVyIGluIEpINzExMCBTb0MsIGFuZCB0aGUgVVNCIGh1
YiAmIE5JQyBvdmVyDQpQQ0llIHdvcmsgZmluZSBubyBtYXR0ZXIgd2UgYXBwbHkgdGhpcyBwYXRj
aCBvciBub3QuDQoNCkxldCBtZSBleHBsYWluIGluIGRldGFpbCBhYm91dCB0aGUgb3JpZ2luIG9m
IHRoaXMgcGF0Y2g6DQpBcyBkZXNjcmliZWQgaW4gdGhlIHRpdGxlLCB3ZSBmaXhlZCB0aGUgdGlt
ZW91dCBpc3N1ZSBieSBhIHdvcmthcm91bmQgaW4gTlZNZQ0KZHJpdmVyLCB0aGF0IG1heSBhZmZl
Y3RzIGFsbCBvdGhlciBwbGF0Zm9ybXMuIFRodXMsIHdlIHdhbnRlZCB0byBvZmZsb2FkIHRoZQ0K
d29ya2Fyb3VuZCBmcm9tIE5WTWUgZHJpdmVyIHRvIG91ciBQQ0llIGNvbnRyb2xsZXIgcGxhdGZv
cm0gZHJpdmVyLg0KQWZ0ZXIgZmluaXNoZWQgdGhlIG9mZmxvYWQgcGF0Y2gsIHdlIHdhbnRlZCB0
byB0ZXN0IGlmIGl0IGRvZXMgaGFybSB0byB0aGUgb3RoZXINClBDSWUgZGV2aWNlcywgc28geW91
IGNhbiBzZWUgd2UgdGVzdGVkIHdpdGggUjgxNjkgTklDIGluIGRlc2NyaXB0aW9uLg0KDQpNU0kg
YW5kIE5WTWUgY29tcGxldGlvbiBhcmUgdHdvIGluYm91bmQgcG9zdCByZXF1ZXN0cyBmcm9tIE5W
TWUgZGV2aWNlDQp0byBKSDcxMTAuDQpXZSBtYWRlIHRoZSBtaXN0YWtlIG9mIGdlbmVyYWxpemlu
ZyBib3RoIG9mIHRoZW0gYXMgIiB0d28gaW5ib3VuZCBwb3N0IHdyaXRlIiwgDQpiZWNhdXNlIHdl
IGhhZCBiZWVuIGludmVzdGlnYXRpbmcgdGhlIGlzc3VlIGluIHRoZSBkaXJlY3Rpb24gb2YgaW5i
b3VuZCBvcmRlcmluZy4NCg0KQWN0dWFsbHksIHRoZSBwaGVub21lbm9uIG9mIHRoaXMgcHJvYmxl
bSBpczoNCiJKSDcxMTAgaGF2ZSBhIHNtYWxsIHByb2JhYmlsaXR5IG9mIG5vdCBnZXR0aW5nIHRo
ZSB1cGRhdGVkIE5WTWUgY29tcGxldGlvbiANCnBlbmRpbmcgc3RhdHVzIGluIE5WTWUgTVNJIGhh
bmRsZXIsIGFuZCB3ZSBjYW4gZ2V0IG9uZSBhZnRlciAxIHRvIDN1cyBkZWxheS4iDQpUaHVzLCB0
aGF0IG1heSByZWxhdGVkIHRvIHRoZSBvcmRlcmluZywgY2FjaGUgY29uc2lzdGVuY3kgb3Igb3Ro
ZXIgcmVhc29ucy4NClRoaXMgaXNzdWUgaXMgc3RpbGwgdW5kZXIgaW52ZXN0aWdhdGlvbi4NCiAN
Cj4gPj4NCj4gPj4gU29ycnksIHdlIG1hZGUgYSBjYXN1YWwgY29uY2x1c2lvbiBoZXJlLg0KPiA+
PiBOb3QgYW55IHR3byBvZiBpbmJvdW5kIHBvc3QgcmVxdWVzdHMgY2FuYHQgYmUga2VwdCBpbiBv
cmRlciBpbiBKSDcxMTANCj4gPj4gU29DLCB0aGUgb25seSBvbmUgY2FzZSB3ZSBmb3VuZCBpcyBO
Vk1lIGNvbXBsZXRpb25zIHdpdGggTVNJIGludGVycnVwdHMuDQo+ID4+IFRvIGJlIG1vcmUgcHJl
Y2lzZSwgdGhleSBhcmUgdGhlIHBlbmRpbmcgc3RhdHVzIGluIG52bWVfY29tcGxldGlvbg0KPiA+
PiBzdHJ1Y3QgYW5kIG52bWVfaXJxIGhhbmRsZXIgaW4gbnZtZS9ob3N0L3BjaS5jLg0KPiA+Pg0K
PiA+PiBXZSBoYXZlIHNob3duIHRoZSBvcmlnaW5hbCB3b3JrYXJvdW5kIHBhdGNoIGJlZm9yZToN
Cj4gPj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUpNNTVaOUh0QlN5Q3E3ckRF
REZkdzY0NHBPV0NLSmZQcWhtaTMNCj4gUw0KPiA+PiBEMXg2cDNnMlNMUUBtYWlsLmdtYWlsLmNv
bS8gV2UgcHV0IGl0IGluIG91ciBnaXRodWIgYnJhbmNoIGFuZCB3b3Jrcw0KPiA+PiBmaW5lIGZv
ciBhIGxvbmcgdGltZS4NCj4gPj4gTG9va2luZyBmb3J3YXJkIHRvIGJldHRlciBhZHZpY2VzIGZy
b20gc29tZW9uZSBmYW1pbGlhciB3aXRoIE5WTWUNCj4gZHJpdmVycy4NCj4gPg0KPiA+IFNvIHRo
aXMgcGxhdGZvcm0gdHJlYXRzIHN0cmljdGx5IG9yZGVyZWQgd3JpdGVzIHRoZSBzYW1lIGFzIGlm
IHJlbGF4ZWQNCj4gPiBvcmRlcmluZyB3YXMgZW5hYmxlZD8gSSBhbSBub3Qgc3VyZSBpZiB3ZSBj
b3VsZCByZWFzb25hYmx5IHdvcmsgYXJvdW5kDQo+ID4gc3VjaCBiZWhhdmlvci4gQW4gYXJiaXRy
YXJ5IGRlbGF5IGlzIGxpa2VseSB0b28gbG9uZyBmb3IgbW9zdCBjYXNlcywNCj4gPiBhbmQgdG9v
IHNob3J0IGZvciB0aGUgd29yc3QgY2FzZS4NCj4gPg0KPiA+IEkgc3VwcG9zZSB3ZSBjb3VsZCBx
dWlyayBhIG5vbi1wb3N0ZWQgdHJhbnNhY3Rpb24gaW4gdGhlIGludGVycnVwdA0KPiA+IGhhbmRs
ZXIgdG8gZm9yY2UgZmx1c2ggcGVuZGluZyBtZW1vcnkgdXBkYXRlcywgYnV0IHRoYXQgd2lsbA0K
PiA+IG5vdGljZWFibHkgaGFybSB5b3VyIG52bWUgcGVyZm9ybWFuY2UuIE1heWJlIGlmIHlvdSBj
b25zdHJhaW4gc3VjaA0KPiA+IGJlaGF2aW9yIHRvIHRoZSBzcHVyaW91cyBJUlFfTk9ORSBjb25k
aXRpb24sIHRoZW4gaXQgbWlnaHQgYmUgb2theT8gSSBkb24ndA0KPiBrbm93Lg0KPiA+DQo+IA0K
PiBBbHNvIGNvcGllZCBLZWl0aCdzIGxhdGVzdCByZXBseSBiZWxvdywgYW5kIEkgYWxzbyBoYXZl
IHRoZSBzYW1lIGRvdWJ0Lg0KPiANCg0KSGksIEtlaXRoLCBzb3JyeSBmb3IgdGhlIGxhdGUgcmVw
bHkuDQpXZSBoYXZlIHRyaWVkIHRvIGFkZCBhIGR1bW15IG5vbi1wb3N0IHJlcXVlc3QoIGNvbmZp
ZyByZWFkICkgaW4gdGhlIGhhbmRsZXIsDQpidXQgaXQgZG9lc24ndCBoZWxwLg0KQmVzaWRlcywg
d2UgdHJpZWQgdG8gYWRkIHRoZSBtYigpIGJlZm9yZSBjaGVja2luZyB0aGUgTlZNZSBjb21wbGV0
aW9uLCANCmFuZCBpdCBkb2Vzbid0IGhlbHAgdG9vLg0KDQo+ID4gSG0sIHRoYXQgbWF5IG5vdCBi
ZSBnb29kIGVub3VnaDogaWYgbnZtZSBjb21wbGV0aW9ucyBjYW4gYmUgcmVvcmRlcmVkDQo+ID4g
d2l0aCB0aGVpciBtc2kncywgdGhlbiBJIGFzc3VtZSBkYXRhIG1heSByZW9yZGVyIHdpdGggdGhl
aXIgY29tcGxldGlvbi4NCj4gPiBZb3VyIGFwcGxpY2F0aW9uIHdpbGwgaW5ldml0YWJseSBzZWUg
c3RhbGUgYW5kIGNvcnJ1cHRlZCBkYXRhLCBzbyBpdA0KPiA+IHNvdW5kcyBsaWtlIHlvdSBuZWVk
IHNvbWUga2luZCBvZiBiYXJyaWVyIHBlciBjb21wbGV0aW9uLiBPdWNoIQ0KDQpJZiB3ZSBkbyBu
b3QgYXBwbHkgdGhlIHBhdGNoLCB3ZSBtaWdodCBnZXQgdGhlIHRpbWVvdXQgd2FybmluZ3MgYW5k
IHdhc3RlDQpzb21lIHRpbWUsIHRoZSBwcm9ibGVtIHNlZW1zIHRvIGJlIGxlc3Mgc2VyaW91cyB0
aGFuIHlvdSBkZXNjcmliZWQuDQpBZnRlciBhcHBseWluZyB0aGUgd29ya2Fyb3VuZCwgd2UgY2Fu
IGRvIHRhc2tzIHdpdGggTlZNZSBTU0Qgbm9ybWFsbHksDQpzdWNoIGFzIGJvb3QgdXAsIGhpYmVy
bmF0aW9uIGFuZCBzYXZpbmcgZGF0YS4NCg==

