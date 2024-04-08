Return-Path: <linux-pci+bounces-5847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7508089B51E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 03:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA28B1F212F5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A667F8;
	Mon,  8 Apr 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="MEKpp1ly"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11021010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C5EBB;
	Mon,  8 Apr 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538708; cv=fail; b=JF4Rgw0WxxLEZWa4hqGaQsBM52EWqy4Od4YIi6d6EOUwzzKS7cuxywEKsvUHjXz8YdVGLuio165XZ+scal2vEMKyUQceYeXc+va44AbDApwB7hub0pR2Yc0bGVUtJrlsCXebyL54NjBtbxa67dN3LDSfm3f+tEy/IHpO9DjFdog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538708; c=relaxed/simple;
	bh=WBj06uPzK0FObHPbJ+9wNyvSgAkeni9CG6RvnRTfjkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTzlv64WoA4Pca62jOv02TJnX1ENwx/ANLmwIh6tkUNtgvOiEpMILL2dvcz7gKmCNKMz0Uy532mmYo5eIW0A4ulVaxdSgrjAL95mndlP18SURkVzLbgmu1v4QjRuzsAg33QO1o5Tw4pn1TlsTwj3UdS4w9/jc1ZOYlp47xAW5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=MEKpp1ly; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1D7ltVTzCcWnOGx75bhcA3ttTpE/vXEI9K7hYpg5/FjnQ4Zx49ev6QyRlRp3gaLEZ/wtEJDrqcZNKMgofrbtrc1gs3BOhn9duUhe+DENQxDcXkx04drk0kLumYwsK3Dnpwh5BofK8PkUdpSlF+L6YOhjvQaiTE39O+pQOxUp4UHdao3Qp3GMgG3dD5SGGxmmINfIneMBT7Kz9ZxpjNptglwpe7VBt4yBc+SC8BIgIVFR+ZkdBIW5qtG3NdlgxULntD0G5tX9u+25y+qJ379K8DbEGwOq73Xu5jUHIuTmdKKo9ioI28rKDs1RVg8o9dlPirT+OzDnQhKCdpOsBV6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBj06uPzK0FObHPbJ+9wNyvSgAkeni9CG6RvnRTfjkM=;
 b=ocb8m7zAZM19oYtJziXhzS3Pdcqj1IojvsB12LRVVxNfNQZ0wIdo2pnIWz8EnsVAu2mR/rBqvSamHVB7hWuWaJEnqNsfXnlEdbvFqoXA4O2SAeAaXwSMtkqjVDZmX2/o2ip3YQTD4I8KMdWRM/4FP1jXzHTeP3HVBDU+tPAn+owmSqqAIUcYZbVzn/tzqZOWcpa8dWrDH4ubljKtmCp58ZPL7AVUWNlQ+Y0pFSzEa22Qs8sUp6PvoOuE/XX/9D8jDetV55juGvsjGi5S7AMVELPeWBJQDrhe0q/zjSozyyO3Z6O2Wr2LxbzqpLwwX0ECBtjoZnaswUiYc0QG9GwUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBj06uPzK0FObHPbJ+9wNyvSgAkeni9CG6RvnRTfjkM=;
 b=MEKpp1lyxGNZz22UludRpf9FsBXTl3hd0cA+mfMS74E7ehJ9c+gIji0t0deDqTsNLicpWpsh6fUQ3gr/BcAzgRJkv6zDaxcX4KGOgKWE0qfL7FvFYFQdjbQxXqXBcn3N3uqIs+jNTWszauiWPWFoetyex1bdOQQgJpdrtbXobbM=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS0PR01MB5635.jpnprd01.prod.outlook.com (2603:1096:604:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 01:11:42 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 01:11:42 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 5/7] PCI: dwc: rcar-gen4: Add .ltssm_enable() for other
 SoC support
Thread-Topic: [PATCH v4 5/7] PCI: dwc: rcar-gen4: Add .ltssm_enable() for
 other SoC support
Thread-Index: AQHahYhrJTZIIP3eJUK8rtnuZqyvpbFZu7SAgAPccoA=
Date: Mon, 8 Apr 2024 01:11:42 +0000
Message-ID:
 <TYCPR01MB110408DFD88FEEB22C13C1ED8D8002@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
 <20240403053304.3695096-6-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUbKgqFr93x+0PCzGrRyW2bL69oTp+zsZ2SZ8mh0Fk36g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUbKgqFr93x+0PCzGrRyW2bL69oTp+zsZ2SZ8mh0Fk36g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS0PR01MB5635:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rqxxv2xQCeeCLXDSdSSkH7mhqYyZTj6/ZYdexKdNbzrfxyW+os2gNcXZ/hUcvzdvMOxUYVaRxRNVgftiumUzgQ66nuXPuo8tkbV1fh5ggekgaZbvOqfjlunWIvOljc6Aei2qz/dEP+fhJFkLfDPLFcplnCkr7aZHZkMAiPceKSVWV3DxxENAlSVIfo9KnkE29qEoRnVaC5Q6u1rELk8RHYzHNvXT2lbaVVeChNAzyOIbsvXChZRL/dxpbD1RNdoJK9LPIbqvXXW4lxHEz+Eny3KJLub7MuKMBVoMomN+qnoxtH6mxA5AqCNARBdyQgECnJWFRDM+y/57iRF3WQFWHY2WrAoazMs8ZklhVDYkkSgr69+T+FK2drJZK7Cy+YGtRh+pgNkqhQntzus4pIMMBS7MPOYVWU7PBDFJ+P4JMLKFKlFeW56ZXHS4HWYrMX9lhOJmKW1EJOmVePNMAooxRB51NtAdxuoMGOVuqXcwfaK4g4UcDAt+rEFqs/PF0vkWNllOaVrv3YykEl1gVUrCeC/+iVx9EaMAktp01BGqAfqy2gDoTtJVnU4SED0+pqQGTYBRt3mw4ZVTTdUHkXkV/aVZm4qSONo1gSc7wX/Gn/XsRH5mDZxZhHkj2PT75T1pzR0wVS9AYk3Iv5ATGe1r+e2Y7hUISfeiljKwd7AqQuc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG1GRFc2dHZ3NHp1eFhpQWRmcXRJcjFObGZnQlZKU1BONnFjOURKcEhqdm8y?=
 =?utf-8?B?SmR3S0JYUFJQRFdzWFcwVWRwWWV4ZGJ1NTAwVkJ6dnI1d0lJdHplQVMwWU5T?=
 =?utf-8?B?bEhOa216RmxTczBwRlVEWHB0VHdvRG1wV1VWT2RmRmlRVm1zbXZqNXcvQmZP?=
 =?utf-8?B?T3ZaWnNwUDZVMHZZSzR3SDJtbFVDd1N2WW8xdjYwWWxrYjBxZmgvZkY4WXZs?=
 =?utf-8?B?anI2SzR1REZ0eHlaRkpQbU9IZmZMQ2cvV2p4UXAxeklVVjhsZmdncVB0VnNW?=
 =?utf-8?B?dTRLWllRRmwvZHdNaDgwaWhYVDNnYy9kZExjUXR1bzBJdXhqbmYxeWdSSUo0?=
 =?utf-8?B?bWxRQXdNSCsyQUxxWDZGcmZLcmkyUm1OUVhhNWxKWHJqK3NLeXVNNmtHYjcy?=
 =?utf-8?B?WG9hanJ5VHNkRVZTRWNHWGF2OTJoMy9EYzliZEdiQjE4eUxTblFxaWZGNitm?=
 =?utf-8?B?R0g2VXBCZDZ6Z24veU9sZ3pGZHJuajZ3Tzd4Q2xqVUFrRlA3VXpEUlRxVlRs?=
 =?utf-8?B?OXQ0SE1kUlZqekplalNoMjRCY2h3b01nRVVQY2RKdDhpcDRNb2ZXK2FMVnhZ?=
 =?utf-8?B?MFgvRy9GQkV3OGVzWHpabEZIeVR6WE1vK2R3R21SNWRHNXpmQ2hmUUJIUERt?=
 =?utf-8?B?K2pvNXZMTVFWdm9nR0hPZmFNRmtEVXJUM2cwOGpBRm8wYU9KdVg2S3pIRXNx?=
 =?utf-8?B?a2VIeWpOZ01WcW9jaEM1NTRsaExaZ0JnRGQrUXZkMVdxTkwzRFI4Y2FzZVFF?=
 =?utf-8?B?b2lSZWpzUHEvazd2YUVxRk50QVdFS3Q4YlRLWHF3dWMvT2VzSVdKOGRXcjBz?=
 =?utf-8?B?NlZTMDBXUmcxOVQzYTRDdmxucDhSR29ldWpEdE9BdXMrYmFTQzRxZy96UFVv?=
 =?utf-8?B?eDNPOXpHOXF0bnVoUzExaXBoZzgvOUcralh5UTBMSDUzK0NaejBxcnRXc2p0?=
 =?utf-8?B?OWlnWFROMjhKUlpVa0dZMjUzQ084NlRRSmEwZVFKdERSNXJidVQ4dysrTGNy?=
 =?utf-8?B?ekEwUVVxQ24ycm0zYjJzdSszckkzYW5vb2lMMlhiSkJnQ29WSERlcDRYa25T?=
 =?utf-8?B?bGtES05XNTkrWlRRQzlMbVArdlVyRDdMVDYydWFzVC8zMjA4TC9Ma2lUV3dY?=
 =?utf-8?B?ZVBVSXVEMm1jVVRVU3ZDd3Zxc1l2bklYc09ic2duQVpua2k2WlFXb3h2b1Fh?=
 =?utf-8?B?NWlSNjNvSkxZeHhzQUEzKzdOcHc2YWYrb3h5R1hjMEorZUxlcE9CSy8rZnhE?=
 =?utf-8?B?MjhPMDNLMk44NW11WHF0WFBkQi9IUFhpSXpXWUdTWk1kM1dZZkJnbFJTMUpB?=
 =?utf-8?B?Z2tmOGQrbjA4VUNVQVl2elZwZFBFQTFPR241cUxQcnpEdGlSdnBIWkd0MUVQ?=
 =?utf-8?B?cTRrNnpkbDYxakdFdTQ2aTlJOEVFMkRPZzA2dllVQ2ZJQThYc2FmSDZsNUFU?=
 =?utf-8?B?QUlQVFFmVFRBWFFOZVpOZ3BGdVM3S3AvZHRwMkxjZisvUVQyb0R0cHhhVjlo?=
 =?utf-8?B?dnZIM0FxcFJxZHNPQ2NqamYvWmdHS1d0LzNjdmlYRDNRQnFjSkNqcWNuMnh1?=
 =?utf-8?B?cXBWVk81aEtqTUt5S1pjdFA0dHFCVUZjZDArUjBDU3FjMU95ZCswNWNuMWow?=
 =?utf-8?B?SStMUEgra0pxWGVIS1J1alBSTmwxMGd4QTVpcjQ4bE12Ym96dDdwdUlhRDFq?=
 =?utf-8?B?VW1kb05qN2ptRm95WDB0K2g0VzZHK1diYklaQ2Q3UFJHc1hMQmF2KzRTdjh1?=
 =?utf-8?B?VXY5ek5EU3lGL0YrY0dRV0NMZ21YSS91Nmd0SXhFY0R6aGh3Y2tRQlVwQlZy?=
 =?utf-8?B?YU9sSkVwdmRQSnlvM1VzL2xQd0drYlFIWVQwNDdDRlpNYzFvN1dzL3lvSkNn?=
 =?utf-8?B?bS9kQ2FUNkJPU0xueWwrVTc4azdwWkVaTzN0Z2dhSFRPUTltTG9rK0kveUlK?=
 =?utf-8?B?c0ExYndjZFZLdWwzOGV4VWc4SGxsRUY3eUd1ZUlzY1VHRHIrY1Z3eTJXeDlU?=
 =?utf-8?B?RnpHMnQxYkZISVVzbXdZOEJIcW5tMWp6dWxrUDc1M0licTFpcVdGYXlwTjhp?=
 =?utf-8?B?cWZYc2hGdjhwMVNvOWZOSDhQN095cCtRWVZJZzFtdUZhZFNwN1B6akxOMXlV?=
 =?utf-8?B?Nzk3K3l4c0xieTZKdmdjbVpnek40KzRlak1RanhLY1ZxMk5rYmFMaVFzNUw1?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a518c6-f3b4-4292-81fb-08dc5768da3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 01:11:42.8908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxvcXvcRvuIZmkdN/ONFTKzrQi1QGxA0uYRqu17HbpeSIJlOrOh3s9Q+oJuNus5Yqa+2tFZjEEewN94nXXAxIzz+/3etXeQYpq+G781hv3Dg8Oao0tSNL5ceVniAcL7A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5635

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5
LCBBcHJpbCA1LCAyMDI0IDExOjEzIFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IE9u
IFdlZCwgQXByIDMsIDIwMjQgYXQgNzozM+KAr0FNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBkcml2ZXIgY2Fu
IHJldXNlIG90aGVyIFItQ2FyIEdlbjQgU29DcyBzdXBwb3J0IGxpa2UgcjhhNzc5ZzAgYW5kDQo+
ID4gcjhhNzc5aDAuIEhvd2V2ZXIsIHI4YTc3OWcwIGFuZCByOGE3NzloMCByZXF1aXJlIG90aGVy
IGluaXRpYWxpemluZw0KPiA+IHNldHRpbmdzIHRoYXQgZGlmZmVyIHRoYW4gcjhhNzc5ZjAuIFNv
LCBhZGQgYSBuZXcgZnVuY3Rpb24gcG9pbnRlcg0KPiA+IC5sdHNzbV9lbmFibGUoKSBmb3IgaXQu
IE5vIGJlaGF2aW9yIGNoYW5nZXMuDQo+ID4NCj4gPiBBZnRlciBhcHBsaWVkIHRoaXMgcGF0Y2gs
IHByb2JpbmcgU29DcyBieSByY2FyX2dlbjRfcGNpZV9vZl9tYXRjaFtdDQo+ID4gd2lsbCBiZSBj
aGFuZ2VkIGxpa2UgYmVsb3c6DQo+ID4NCj4gPiAtIHI4YTc3OWYwIGFzICJyZW5lc2FzLHI4YTc3
OWYwLXBjaWUiIGFuZCAicmVuZXNhcyxyOGE3NzlmMC1wY2llLWVwIg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMu
Y29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIg
cmV2aWV3IQ0KDQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2Fy
LWdlbjQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1n
ZW40LmMNCj4gDQo+ID4gQEAgLTUxMyw2ICs1MzYsMTQgQEAgc3RhdGljIHN0cnVjdCByY2FyX2dl
bjRfcGNpZV9wbGF0ZGF0YSBwbGF0ZGF0YV9yY2FyX2dlbjRfcGNpZV9lcCA9IHsNCj4gPiAgfTsN
Cj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCByY2FyX2dlbjRfcGNp
ZV9vZl9tYXRjaFtdID0gew0KPiA+ICsgICAgICAgew0KPiA+ICsgICAgICAgICAgICAgICAuY29t
cGF0aWJsZSA9ICJyZW5lc2FzLHI4YTc3OWYwLXBjaWUiLA0KPiA+ICsgICAgICAgICAgICAgICAu
ZGF0YSA9ICZwbGF0ZGF0YV9yOGE3NzlmMF9wY2llLA0KPiA+ICsgICAgICAgfSwNCj4gPiArICAg
ICAgIHsNCj4gPiArICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyOGE3Nzlm
MDQtcGNpZS1lcCIsDQo+IA0KPiByZW5lc2FzLHI4YTc3OWYwLXBjaWUtZXANCg0KT29wcy4gSSds
bCBmaXggaXQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gPiArICAg
ICAgICAgICAgICAgLmRhdGEgPSAmcGxhdGRhdGFfcjhhNzc5ZjBfcGNpZV9lcCwNCj4gPiArICAg
ICAgIH0sDQo+ID4gICAgICAgICB7DQo+ID4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0g
InJlbmVzYXMscmNhci1nZW40LXBjaWUiLA0KPiA+ICAgICAgICAgICAgICAgICAuZGF0YSA9ICZw
bGF0ZGF0YV9yY2FyX2dlbjRfcGNpZSwNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgt
bTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwg
cGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0
byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0
aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRz
DQo=

