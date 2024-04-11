Return-Path: <linux-pci+bounces-6116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0E8A0B01
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF411F21007
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7C2EAE5;
	Thu, 11 Apr 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="awMHDaqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6913FD74;
	Thu, 11 Apr 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823432; cv=fail; b=nUIkAcN6hxpWCZpt+ED+5lUurwZUZd2yED3WuC0q8wDHk4827el6rmIGWaseNa7UAbc4ElN6FlpQd0ksSu/wkDUVbPJsvJGZ9/N/ykNczRXrot53zjVFHUGzuxI+G+1+0Duslt2cEftf5DfFXpWyjQ6t0h5vlTWG7NjJ8eVHtPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823432; c=relaxed/simple;
	bh=J+ZNLauWUiYQFF3zVyP3V668P+avkWv0uzh7Fv2Zc5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMyKMNOvGd4AfGHW6MJZIgCmmGB3cL1Rd/433dTyfebSQWKGyadzWA1pn4abg5fCq7tjZE2HfCYih72DjFsVewopOBo7ymrIZRfhtQO+K+iPuhGdHs851qirfohzEFk1WBwz3p1OJ5hdIMLQI+6VQdvIe46+OH5F7ZfAlfs/PCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=awMHDaqV; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8a42MIZzPiZKYWisCZbiwVdXPtxasKGuIdNl3jme+fHsEcxshTasEIWo1sek8ADTKj0GGca+WTcl5oFMd3Nl44iqiMvyuqdaj3Dror9i8gDedlAPvKeKFRluY6imt05jx4Gu2i+1P9iR333KDTHkiRJrChXH646fl7z453CChAV6yW5Ytdkxdrnm4iAMp2xraRCzLLvB4Q5jrMSEiQIrPqzszfAZEPPfL+9uepLDpicjGayldEb5jefRZRfI0wpDmi8hxgYwhrbohYQxhV5ChU5q58dq/yAmIPV7Vaonvpk93YovFoSTCDzPbahv7pWEsUVf3FfUGCZ9lw9ovC/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ZNLauWUiYQFF3zVyP3V668P+avkWv0uzh7Fv2Zc5c=;
 b=XL7KTxwLipTu3/5Y18hWVh1vgrgU7KoXP1CZrR5fTtzXboP+PeNyKoIUM+6Gx96Oj40f2GptnlUA8xFCQ62+S0rv1xdC5gPE9yfEEYtd2hVKKWi/doD4JIqtCslC18wNB7rj5MHz9lFrYtfuhPN9RLWm0YTvYrpIhxNtXXK5gB1Kg2UVA5T7KCPUNpkNk82eNlzc9LxdnboM9lk4vtcw/j7b0CgitBxw7k2uyqdk+agm04C9RmhBkTpCB1bpLHf6rtA5LPLBvUwGp8rEr9m/Fo5fmKBlny2JNF6zaCTSM2efHmPim+2ivAlzmpusBhmhrBO3fpDoig8wsboXo8PIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+ZNLauWUiYQFF3zVyP3V668P+avkWv0uzh7Fv2Zc5c=;
 b=awMHDaqVXu21SqjDE45ZZccWn5M1fHZJE4MZoW8o6UKv+hPWFwpTdQvL8EqIoL94Rv5MS/1UOSGMyyRoRgILpNIoP2M9qaanm/PGk3uguc54FJou8rgQk4ehv8vSNw6/a2vuSV0o0D5Wk2exNYaHI+4qkxOi6rfjFM3HooiJmWE=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TY3PR01MB9948.jpnprd01.prod.outlook.com (2603:1096:400:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 08:17:04 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 08:17:04 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Thread-Topic: [PATCH v6 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Thread-Index: AQHaiuDTCoWA+Jm0gkeB9dn3lr05UbFhweWAgAD1xuA=
Date: Thu, 11 Apr 2024 08:17:04 +0000
Message-ID:
 <TYCPR01MB1104087F1655A7E616368E3D1D8052@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-6-yoshihiro.shimoda.uh@renesas.com>
 <20240410172339.GC16629@thinkpad>
In-Reply-To: <20240410172339.GC16629@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TY3PR01MB9948:EE_
x-ms-office365-filtering-correlation-id: 7c88eb15-1618-42b8-b6a5-08dc59ffc559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3BL9mi+CJIuhYzKexE/WVOYegKBG9rbcJP/gJQYCxZ42sBUfhSYSH/hr9pY+kyHpUXq1pZKKW+TqmcXPO9Og8Hy0XqJcCjft+LuFu13c03d0FoWiK8WboGcCM7rij7xT7NYyyNC4lP3jg/oZEop0Ub75T+cbmURRnY9lbjsYM6ghZkfR+1aB8ZsihUtpakoTu7H6c+eDsQs+3zstziy2lC6wdwnTJ63z7QHl7ojEu7+llueuQ0w5YKkvWiWa8b3tkyRHV8X0mSxbWXJOHusBq9L52W4umjWPWG6jEcGxE8elTHJ6cPtESFmVsYM1i/OqtxzDNGK9xv483r+9kPoDnCEN/8EL/HW0ew59IBhUHUGURLYBlPwDepitZa6+hP03EI5JM773Am90BRu/FkH9cNqIIUyf1SeLQbbvmJO4oxxnk9J2gkV4gv3C2pzL0rD6+Nju4DZrVgHtq13sewjP2XR8x7dhIKXBM0DreFU6lhTWC/zmKo9KkeU8smk3PIpTkFUjBMhYvaeJKob0zwskpoG+8g1HBQl/gYu+bR3Wa2XVRiBDsGqJMKx7TGxHgUPw8X7sFRODDUt5Ff3kaPPCjwYMxLuxeO77Wyn8WG/XgENm37LgBQTJLW6GThRRGVIqAghGwHhXdZF2waE1PRQHPTRIe86RG74oxNWdqC+3HEUzj84NqPhwYJEJgkrh27+zItAVkOjoWtMIR+y5aOsVmHag3gxITA4NAh5S0+KFvLY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1J3K2x0WVltU0hJMmNveHJpNnRIODhoUTMwU1BLcVk2UTRhNGFZT1hWRHhK?=
 =?utf-8?B?eGlIOG9XZFNxSVFjenVSOVRpUlBUeFc2WkU2RGtYZmNuWkZGTHc5TWlDb2RQ?=
 =?utf-8?B?bmtDWFR5eE1MSFVwNTAxTTRZS1dZQXFNTm5hdnBpTFpCZjR6U2lDK2VxNkV5?=
 =?utf-8?B?QnB2elJNMko4dEdHVTN6T01ERjNodEpJSkpmMWIwWk0rcHpWVDNhQ2g0THd3?=
 =?utf-8?B?LzR2MEhtQUpDTTNaZmVlcFh4RW9wUzkwaHJnYW9ZUDRQR2JvM1VIZ2JYWisy?=
 =?utf-8?B?RTVCaklNUXQ3KzB0YlpNaDJzU2hNc2dZZVBQTjJuUDFkRVgyb2h0bk54VUtw?=
 =?utf-8?B?WDRWT0lUNVZLZkcwWDBFS2pSZEN4T1kzc05FWmNFSUZHNzFhL2kyUDhabC9h?=
 =?utf-8?B?THBMUHVNek9zRkFlOVlJWFd2Zi94WXo5SzRndENuakl0ZGRpRzF3dWtxUW5r?=
 =?utf-8?B?TTBXQkNSbDd4ajFWUmMxN0NYeVFmVDFpL25SZENQcHZlSUZuWGM2OUhtRU95?=
 =?utf-8?B?ajZOOEtmTldtZ0JrMnY3ZitPVlpKT253VzN3Y25JaXR4bWV1alhwdGw4TDNy?=
 =?utf-8?B?U0FveEQxSmdteHJDRkpIYWRVS2c1RkhXa1VZaklTcmZ5cWYyODZRMytzdHc5?=
 =?utf-8?B?dnZOWnAxUjRNRE1YYlR6T2xVWUlFeFdhUFdvUzNnVUZXU296QkFrM2thVG1x?=
 =?utf-8?B?VVNxanJDREZTRThTL1h6RzdPMVRnSzZvd3Q5enVCZGtmR1dtVVhad25RSEVF?=
 =?utf-8?B?VnVOdVM2OE54VXhJUTM5SEx2TTlDR1J2aUgybVMra0lQZEhYWDk0aTZsQ2lZ?=
 =?utf-8?B?cEYvMkMvb3EvU1lvTW9oS0t2dFE3cjd4eUNmZmM2UStFSmVubVJCbnNvMHdK?=
 =?utf-8?B?SnNTTEkwR0gxL3NrSDN0czM5K0NnUTNZY3BVTldzc0IwRE5ZbmFlMy9adytE?=
 =?utf-8?B?WXBFK0Z5Qi9VVmxZdUNuSW5ORjMvNzRER3FCWUtNQVRMUTljRFdVcUhObU1T?=
 =?utf-8?B?Zzk2QzlWMGNFZVlhVGtyaUVRRDJmaW0wc0t1WGJxdzM3UThZZk9uWnNUVFBX?=
 =?utf-8?B?WUVkcE1ZRzhTUUtYcXFZM04vUFlPclZDRjZtK1Z2UXlVZGZCbmYzM0F0NWw5?=
 =?utf-8?B?U3pQT2FLUGNlRFpYcitrUTl5bG00UzdzS2w0TkpJTlZDandSbkZsdGphSTJL?=
 =?utf-8?B?UzBnM3Y5bGhUVTZoQWVpVGNZZVEyVExvcGpvcGVzc3dPa0dweERsMTBmNElY?=
 =?utf-8?B?MytwOTRGTjdJVlJGaElicFFYR204OVhFUzJaanU0S3N2eG5JMmZPYi9aWTVF?=
 =?utf-8?B?bDkyaDNWMk9jc0JUNVVSLzhtMjRmcnhXM05DelJQd0gwS2E1QjhMVnNVRGlZ?=
 =?utf-8?B?WUo5enlqNzZjaUtyVW0wazZXUldjYktBRWFRVnluNmtUZFVtUzQ2SUhDV0VD?=
 =?utf-8?B?TWNvbHQySnByeU16YnBURHVkZms1Yk0xanFyeW1OSmZreUhCdmxvWVV0NnFG?=
 =?utf-8?B?L08weWg5QUlMVEEzUkl5VitQMnUwbjJUSUpRNWh4SUxYUzRqd04vbVpycUVw?=
 =?utf-8?B?a2c1WnF4M3lJSVAwTE5FaDczUGw0SCtwU3FqRURXY21aMjVvSEsyMjV0azNO?=
 =?utf-8?B?bHhyLzZtaHcraG43RzRHaldqVHAzOFFvWjVkN2ZuUXVLU01sNjFIdlVvSkhG?=
 =?utf-8?B?cyswV1JSckVnWEZkOUU3dmRqaFJiY1p4Y2VnaGlOQytmN2kxNTVyd0ZvNDA1?=
 =?utf-8?B?L01rdWwzVzRTSzVrcGxJTCtRSTNZOWhKUk40bE9tQWV6clFSSjlhd2x0OHR2?=
 =?utf-8?B?RnMyTHRydlByMFQwYk9NZ1JXN2Rqd3p5MFdMM2ptVG9YSHVyRlpUU0RQRENV?=
 =?utf-8?B?d21ERHNXRUhMazhmWElVM0ZFeldHM09FSnVkQ01oQlh0a2dtZGVOWXVMcmZr?=
 =?utf-8?B?MjdTbTgzNjlwN0tyTmtTOHNRRXh2NGVHYWxuT3JNOENqVTYzdzRaSkR3SHZR?=
 =?utf-8?B?Ni9iUkFFVllxTmo5YkV6SWowNXdRMnVWcFBCTDQ5UVRlM21vZldUMWJ0cWww?=
 =?utf-8?B?bVFtU2VucEtyTmFpUWViY2grNGdBR1lEdUdjdUl2Wmo2L25WTHZZaytTSnp4?=
 =?utf-8?B?U3hNUVk3YitTREVBd3ljUXVRY0pMVTdDMVY5UDRhbEk2bUdRajBQSk5tNi92?=
 =?utf-8?B?MHRPNlUzNXRpVlFZNko5MkVYRGxZNkVncHpSalM2TlJDR1I2a2VNTytDNEIw?=
 =?utf-8?B?ZzBaZi9DbEQ4Y3o3bGQ3SzhQUXJnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c88eb15-1618-42b8-b6a5-08dc59ffc559
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 08:17:04.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pKoiv3LluaqTrP1iflsoY9eWlRBIFbll64Rm+aichuW1PEB5tAfOm1PKgUI6IywzQSN5E/mI7AY3P9oIzEQNdcBfjSTBcm2olmxCiq3evDUx9FbKtbW0UItUTDUjrfy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9948

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCAyOjI0IEFNDQo+IA0KPiBPbiBXZWQsIEFwciAxMCwg
MjAyNCBhdCAwOTo0ODozMEFNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBU
aGlzIGRyaXZlciBjYW4gcmV1c2Ugb3RoZXIgUi1DYXIgR2VuNCBTb0NzIHN1cHBvcnQgbGlrZSBy
OGE3NzlnMCBhbmQNCj4gPiByOGE3NzloMC4gSG93ZXZlciwgcjhhNzc5ZzAgYW5kIHI4YTc3OWgw
IHJlcXVpcmUgb3RoZXIgaW5pdGlhbGl6aW5nDQo+ID4gc2V0dGluZ3MgdGhhdCBkaWZmZXIgdGhh
biByOGE3NzlmMC4gU28sIGFkZCBhIG5ldyBmdW5jdGlvbiBwb2ludGVyDQo+ID4gLmx0c3NtX2Vu
YWJsZSgpIGZvciBpdC4gTm8gYmVoYXZpb3IgY2hhbmdlcy4NCj4gPg0KPiA+IEFmdGVyIGFwcGxp
ZWQgdGhpcyBwYXRjaCwgcHJvYmluZyBTb0NzIGJ5IHJjYXJfZ2VuNF9wY2llX29mX21hdGNoW10N
Cj4gPiB3aWxsIGJlIGNoYW5nZWQgbGlrZSBiZWxvdzoNCj4gPg0KPiA+IC0gcjhhNzc5ZjAgYXMg
InJlbmVzYXMscjhhNzc5ZjAtcGNpZSIgYW5kICJyZW5lc2FzLHI4YTc3OWYwLXBjaWUtZXAiDQo+
ID4NCj4gDQo+IElmIHI4YTc3OWYwIFNvQyBjYW4gd29yayB3aXRoIHRoZSBleGlzdGluZyAncmVu
ZXNhcyxyY2FyLWdlbjQtcGNpZScgYW5kDQo+ICdyZW5lc2FzLHJjYXItZ2VuNC1wY2llLWVwJyBj
b21wYXRpYmxlcywgdGhlbiB5b3Ugc2hvdWxkIGp1c3QgbGVhdmUgaXQgYXMgaXQgaXMNCj4gYW5k
IGFkZCBhIG5ldyBjb21wYXRpYmxlIHdpdGggZGVkaWNhdGVkIGNhbGxiYWNrcyBmb3Igb25seSBy
OGE3NzlnMCBhbmQNCj4gcjhhNzc5aDAuDQoNCk15IGltcGxlbWVudGF0aW9uIHdpbGwgaGF2ZSA0
IGVudHJpZXMuIEFuZCwgaXQgY2FuIHN1cHBvcnQgcjhhNzc5W2ZnaF0wOg0KLS0tDQpzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCByY2FyX2dlbjRfcGNpZV9vZl9tYXRjaFtdID0gew0K
ICAgICAgICB7DQogICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyOGE3Nzlm
MC1wY2llIiwNCiAgICAgICAgICAgICAgICAuZGF0YSA9ICZwbGF0ZGF0YV9yOGE3NzlmMF9wY2ll
LA0KICAgICAgICB9LA0KICAgICAgICB7DQogICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAi
cmVuZXNhcyxyOGE3NzlmMC1wY2llLWVwIiwNCiAgICAgICAgICAgICAgICAuZGF0YSA9ICZwbGF0
ZGF0YV9yOGE3NzlmMF9wY2llX2VwLA0KICAgICAgICB9LA0KICAgICAgICB7DQogICAgICAgICAg
ICAgICAgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyY2FyLWdlbjQtcGNpZSIsCS8qIGZvciByOGE3
NzlbZ2hdMCAqLw0KICAgICAgICAgICAgICAgIC5kYXRhID0gJnBsYXRkYXRhX3JjYXJfZ2VuNF9w
Y2llLA0KICAgICAgICB9LA0KICAgICAgICB7DQogICAgICAgICAgICAgICAgLmNvbXBhdGlibGUg
PSAicmVuZXNhcyxyY2FyLWdlbjQtcGNpZS1lcCIsCS8qIGZvciByOGE3NzlbZ2hdMCAqLw0KICAg
ICAgICAgICAgICAgIC5kYXRhID0gJnBsYXRkYXRhX3JjYXJfZ2VuNF9wY2llX2VwLA0KICAgICAg
ICB9LA0KLS0tDQpBbHNvIGl0IHdpbGwgbm90IGJyZWFrIGV4aXN0aW5nIGFsbCByOGE3NzlmMCBT
b0MgZW52aXJvbm1lbnQgYmVjYXVzZQ0KdGhlIGNvbXBhdGlibGUgaXMNCiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscjhhNzc5ZjAtcGNpZSIsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlbmVzYXMscmNhci1nZW40LXBjaWUiOw0K
DQpIb3dldmVyLCBpZiBJIGNoYW5nZWQgdGhlIGltcGxlbWVudGF0aW9uIGxpa2UgeW91ciBzdWdn
ZXN0aW9uLA0KaXQgd2lsbCBiZSA2IGVudHJpZXMgbGlrZSBiZWxvdzoNCi0tLQ0Kc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcmNhcl9nZW40X3BjaWVfb2ZfbWF0Y2hbXSA9IHsNCiAg
ICAgICAgew0KICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gInJlbmVzYXMscjhhNzc5ZzAt
cGNpZSIsDQogICAgICAgICAgICAgICAgLmRhdGEgPSAmcGxhdGRhdGFfcjhhNzc5ZzBfcGNpZSwN
CiAgICAgICAgfSwNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gInJl
bmVzYXMscjhhNzc5ZzAtcGNpZS1lcCIsDQogICAgICAgICAgICAgICAgLmRhdGEgPSAmcGxhdGRh
dGFfcjhhNzc5ZzBfcGNpZV9lcCwNCiAgICAgICAgfSwNCiAgICAgICAgew0KICAgICAgICAgICAg
ICAgIC5jb21wYXRpYmxlID0gInJlbmVzYXMscjhhNzc5aDAtcGNpZSIsDQogICAgICAgICAgICAg
ICAgLmRhdGEgPSAmcGxhdGRhdGFfcjhhNzc5ZzBfcGNpZSwJCS8qIFdlIGNhbiByZXVzZSByOGE3
NzlnMCdzIG9uZSAqLw0KICAgICAgICB9LA0KICAgICAgICB7DQogICAgICAgICAgICAgICAgLmNv
bXBhdGlibGUgPSAicmVuZXNhcyxyOGE3NzloMC1wY2llLWVwIiwNCiAgICAgICAgICAgICAgICAu
ZGF0YSA9ICZwbGF0ZGF0YV9yOGE3NzlnMF9wY2llX2VwLCAJLyogV2UgY2FuIHJldXNlIHI4YTc3
OWcwJ3Mgb25lICovDQogICAgICAgIH0sICAgICAgICB7DQogICAgICAgICAgICAgICAgLmNvbXBh
dGlibGUgPSAicmVuZXNhcyxyY2FyLWdlbjQtcGNpZSIsDQogICAgICAgICAgICAgICAgLmRhdGEg
PSAmcGxhdGRhdGFfcmNhcl9nZW40X3BjaWUsCQkvKiBmb3IgcjhhNzc5ZjAgKi8NCiAgICAgICAg
fSwNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gInJlbmVzYXMscmNh
ci1nZW40LXBjaWUtZXAiLA0KICAgICAgICAgICAgICAgIC5kYXRhID0gJnBsYXRkYXRhX3JjYXJf
Z2VuNF9wY2llX2VwLCAJLyogZm9yIHI4YTc3OWYwICovDQogICAgICAgIH0sDQotLS0tLQ0KDQpT
bywgSSBwcmVmZXIgbXkgaW1wbGVtZW50YXRpb24gYmVjYXVzZSBjb2RlIHJlYWRhYmlsaXR5IGlz
IGdvb2QgdG8gbWUuIEJ1dCwgd2hhdCBkbyB5b3UgdGhpbms/DQoNCkJlc3QgcmVnYXJkcywNCllv
c2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hp
aGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYyB8IDQxICsr
KysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1yY2FyLWdlbjQuYw0KPiA+IGluZGV4IGRhMjgyMWQ2ZWZjZS4uNDdlYzM5NDg4NWY1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40
LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5j
DQo+ID4gQEAgLTQ4LDcgKzQ4LDkgQEANCj4gPiAgI2RlZmluZSBSQ0FSX0dFTjRfUENJRV9FUF9G
VU5DX0RCSV9PRkZTRVQJMHgxMDAwDQo+ID4gICNkZWZpbmUgUkNBUl9HRU40X1BDSUVfRVBfRlVO
Q19EQkkyX09GRlNFVAkweDgwMA0KPiA+DQo+ID4gK3N0cnVjdCByY2FyX2dlbjRfcGNpZTsNCj4g
PiAgc3RydWN0IHJjYXJfZ2VuNF9wY2llX3BsYXRkYXRhIHsNCj4gPiArCWludCAoKmx0c3NtX2Vu
YWJsZSkoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKTsNCj4gPiAgCWVudW0gZHdfcGNpZV9k
ZXZpY2VfbW9kZSBtb2RlOw0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTYxLDggKzYzLDggQEAgc3Ry
dWN0IHJjYXJfZ2VuNF9wY2llIHsNCj4gPiAgI2RlZmluZSB0b19yY2FyX2dlbjRfcGNpZShfZHcp
CWNvbnRhaW5lcl9vZihfZHcsIHN0cnVjdCByY2FyX2dlbjRfcGNpZSwgZHcpDQo+ID4NCj4gPiAg
LyogQ29tbW9uICovDQo+ID4gLXN0YXRpYyB2b2lkIHJjYXJfZ2VuNF9wY2llX2x0c3NtX2VuYWJs
ZShzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIsDQo+ID4gLQkJCQkJYm9vbCBlbmFibGUpDQo+
ID4gK3N0YXRpYyB2b2lkIHJjYXJfZ2VuNF9wY2llX2x0c3NtX2NvbnRyb2woc3RydWN0IHJjYXJf
Z2VuNF9wY2llICpyY2FyLA0KPiA+ICsJCQkJCSBib29sIGVuYWJsZSkNCj4gPiAgew0KPiA+ICAJ
dTMyIHZhbDsNCj4gPg0KPiA+IEBAIC0xMjcsOSArMTI5LDEzIEBAIHN0YXRpYyBpbnQgcmNhcl9n
ZW40X3BjaWVfc3BlZWRfY2hhbmdlKHN0cnVjdCBkd19wY2llICpkdykNCj4gPiAgc3RhdGljIGlu
dCByY2FyX2dlbjRfcGNpZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2llICpkdykNCj4gPiAgew0K
PiA+ICAJc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyID0gdG9fcmNhcl9nZW40X3BjaWUoZHcp
Ow0KPiA+IC0JaW50IGksIGNoYW5nZXM7DQo+ID4gKwlpbnQgaSwgY2hhbmdlcywgcmV0Ow0KPiA+
DQo+ID4gLQlyY2FyX2dlbjRfcGNpZV9sdHNzbV9lbmFibGUocmNhciwgdHJ1ZSk7DQo+ID4gKwlp
ZiAocmNhci0+cGxhdGRhdGEtPmx0c3NtX2VuYWJsZSkgew0KPiA+ICsJCXJldCA9IHJjYXItPnBs
YXRkYXRhLT5sdHNzbV9lbmFibGUocmNhcik7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0
dXJuIHJldDsNCj4gPiArCX0NCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAqIFJlcXVpcmUgZGlyZWN0
IHNwZWVkIGNoYW5nZSB3aXRoIHJldHJ5aW5nIGhlcmUgaWYgdGhlIGxpbmtfZ2VuIGlzDQo+ID4g
QEAgLTE1Nyw3ICsxNjMsNyBAQCBzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9zdG9wX2xpbmso
c3RydWN0IGR3X3BjaWUgKmR3KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUg
KnJjYXIgPSB0b19yY2FyX2dlbjRfcGNpZShkdyk7DQo+ID4NCj4gPiAtCXJjYXJfZ2VuNF9wY2ll
X2x0c3NtX2VuYWJsZShyY2FyLCBmYWxzZSk7DQo+ID4gKwlyY2FyX2dlbjRfcGNpZV9sdHNzbV9j
b250cm9sKHJjYXIsIGZhbHNlKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgcmNhcl9n
ZW40X3BjaWVfY29tbW9uX2luaXQoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKQ0KPiA+IEBA
IC01MDQsNiArNTEwLDIzIEBAIHN0YXRpYyB2b2lkIHJjYXJfZ2VuNF9wY2llX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmNhcl9nZW40X3BjaWVfdW5wcmVwYXJl
KHJjYXIpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCByOGE3NzlmMF9wY2llX2x0c3Nt
X2VuYWJsZShzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4gK3sNCj4gPiArCXJjYXJf
Z2VuNF9wY2llX2x0c3NtX2NvbnRyb2wocmNhciwgdHJ1ZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcmNhcl9nZW40X3BjaWVfcGxh
dGRhdGEgcGxhdGRhdGFfcjhhNzc5ZjBfcGNpZSA9IHsNCj4gPiArCS5sdHNzbV9lbmFibGUgPSBy
OGE3NzlmMF9wY2llX2x0c3NtX2VuYWJsZSwNCj4gPiArCS5tb2RlID0gRFdfUENJRV9SQ19UWVBF
LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCByY2FyX2dlbjRfcGNpZV9wbGF0
ZGF0YSBwbGF0ZGF0YV9yOGE3NzlmMF9wY2llX2VwID0gew0KPiA+ICsJLmx0c3NtX2VuYWJsZSA9
IHI4YTc3OWYwX3BjaWVfbHRzc21fZW5hYmxlLA0KPiA+ICsJLm1vZGUgPSBEV19QQ0lFX0VQX1RZ
UEUsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IHJjYXJfZ2VuNF9wY2llX3Bs
YXRkYXRhIHBsYXRkYXRhX3JjYXJfZ2VuNF9wY2llID0gew0KPiA+ICAJLm1vZGUgPSBEV19QQ0lF
X1JDX1RZUEUsDQo+ID4gIH07DQo+ID4gQEAgLTUxMyw2ICs1MzYsMTQgQEAgc3RhdGljIHN0cnVj
dCByY2FyX2dlbjRfcGNpZV9wbGF0ZGF0YSBwbGF0ZGF0YV9yY2FyX2dlbjRfcGNpZV9lcCA9IHsN
Cj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCByY2Fy
X2dlbjRfcGNpZV9vZl9tYXRjaFtdID0gew0KPiA+ICsJew0KPiA+ICsJCS5jb21wYXRpYmxlID0g
InJlbmVzYXMscjhhNzc5ZjAtcGNpZSIsDQo+ID4gKwkJLmRhdGEgPSAmcGxhdGRhdGFfcjhhNzc5
ZjBfcGNpZSwNCj4gPiArCX0sDQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAicmVuZXNh
cyxyOGE3NzlmMC1wY2llLWVwIiwNCj4gPiArCQkuZGF0YSA9ICZwbGF0ZGF0YV9yOGE3NzlmMF9w
Y2llX2VwLA0KPiA+ICsJfSwNCj4gPiAgCXsNCj4gPiAgCQkuY29tcGF0aWJsZSA9ICJyZW5lc2Fz
LHJjYXItZ2VuNC1wY2llIiwNCj4gPiAgCQkuZGF0YSA9ICZwbGF0ZGF0YV9yY2FyX2dlbjRfcGNp
ZSwNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+Cu
teCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

