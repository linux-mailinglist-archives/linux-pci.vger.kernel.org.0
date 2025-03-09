Return-Path: <linux-pci+bounces-23240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F88A582EB
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C047A47A4
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC218A959;
	Sun,  9 Mar 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PFpMz72k"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C417A319;
	Sun,  9 Mar 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515136; cv=fail; b=Mu6TV3AvTwirH0WKmIPN/eMoMQqK7CNjzn7j0nFY+NMfJ3W4JFhUvka207tDGNg4sD4A7dicqADz4bD1oa3i58AoE1zb4feQLsHD6nDkvinsgD0ifpA9AT3E00n0FAtWLoHmbeM9OYRo4vRx6YRJeXPLxJmpEqmr5wY5/Gb0vcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515136; c=relaxed/simple;
	bh=uPX4R5nO2yhY925X8D7lBIePhDPsdjx/o0vQAVsy+NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEBXANmh28syJ5sxygoXLsA3LLUHhBciYDrA8spbyzO/FrZczXQzajbmCubYc01Fc3DqNDYMKg53wsBdFEJs8vVlZduNgxy7n0fiH2AJM1pf5D2kfd45MO03g8gM5sgd/rosilz3VPoJ5uwOhoEblFHQHh4wgaOa/PIci7RWdqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PFpMz72k; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I26T4muVpq8nA+dxcjqDOyKTKqC8LJ2hUo9ogQeg3VRWn+fYv+2dTTzDm603BSUNWaLSM7o3Y4T0+67cEpd6v1fl2WJpqkifMz7ROlKmiqe/lEjcwpyWOkz6WcIrKQJSP6lvXU7he7tgkNxY4b0m6DM0mm5hELXae2d9+Yv/88Z7ltjafn4MQLIQQ38pz0egmCO3oxpatKFzYiH3f1dAHECAA4jm/YEpkMUCgxq6K7m5t8x5m8tuH/Sul0SrbPZngULiMpWp6W1Tq2dsEf62fEOfurh4FdJh8kdYuIsH1a2Ns+DxUptdQVd7WzsSnOdWfJcHd+/ZJP7uOo3AwhCh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPX4R5nO2yhY925X8D7lBIePhDPsdjx/o0vQAVsy+NQ=;
 b=CREt7NWqjmMyPat0AoPo4CsoA/Zv9/6Nw1rZtxbgSOmtFTAZEYAI1ss2BLfwRIQzxOmC9/kodWJ6/jZ0K06mEjzaPYXp8xks5U1JTY7hZHn+lSvwrfdeJ4zhMCvARjTEFux1phkjTSvmRNk7RepzKJjkDyTAC8d0dypc8XggDNzHeKcfRZBz3gaxVH3fesEyuUBWSLktF5RB3UsFBXgKu9Y4l6uj0qKNIF9qgexaYwhh6mFQKNe7cUI5iJFBlsf1MXMYMvgFmnBj9nkL6EOXFXfpBc8Pp2anveRDcwthuA7NN9Fc+ZWZ/SPTTsgL/wBMie9AldAiLdjkDh1fHOLSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPX4R5nO2yhY925X8D7lBIePhDPsdjx/o0vQAVsy+NQ=;
 b=PFpMz72kOG3OpQa3EhcpDppx4gVJ4hyXqhYcFf8E9CjNTXDNa8VvHUnl7/KN43mn5oH11CrN49s6vLVKEOrJ+uCNGVMmDPSmTsw+IReyFfZoox77ehsymK5mnfCCv8PBt6swz6FNhgi1JWd8CjkTVEUqnYEGHHc6n6t0DR6CefqUs5YfKMrJLKtbI/uEmx7zrRe6pO8FroRG9mPLwd+t6uL5TxWAR6wx2AzTcAVpsBpkrtiHy5jSpfQlOPPTojNzgB9Af1ZbCEI4keOwfQ2s4a1mwecu++r7Li7uK8u2giVKyNXtcsQyooUG+k2pXq/OMSWJ8LQ8zI+mDco8KQlsxw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9565.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 10:12:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 10:12:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index:
 AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4OAAAMjgIAAA7jxgAACxYCAAAD/g4AAAhAAgAABE5aAAACyAIAABLn9
Date: Sun, 9 Mar 2025 10:12:06 +0000
Message-ID:
 <PN3PR01MB9597B64008E01DC0336FAE37B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030909-recoup-unafraid-1df0@gregkh>
 <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030901-deceiver-jolliness-53f5@gregkh>
In-Reply-To: <2025030901-deceiver-jolliness-53f5@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB9565:EE_
x-ms-office365-filtering-correlation-id: db56c111-1d4b-4469-30bc-08dd5ef2d8bd
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|6072599003|7092599003|8062599003|19110799003|8060799006|15080799006|440099028|3412199025|102099032|21061999003|12071999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmdHUzJXLzhiYTFVRjlxUFJLOUhkNWlOaFoybFV1aE5vREUxVU92SG1JdWdK?=
 =?utf-8?B?NTJIaHpDNXBleXB5ejl1QzBXUWtIbk9taEFPazBwMzRjRjd5YWZuak50UzZQ?=
 =?utf-8?B?d0tQYW1LWGloYk9vZ05RcmgrQTltRGV3Z25JUE91S0lpeW12Tm9CZUwwTXNv?=
 =?utf-8?B?dkFRNm90RkZJRDZWVnU5bEQrckIzb2M4MndiOHA0YlhsVzNOZDlLQ0lrbXBi?=
 =?utf-8?B?b2ltcVAzNmFqbXl0Tld4dk5SRnlSYS96QkNnUmQ3bk9KUFpiVzNHOHFDQU5j?=
 =?utf-8?B?SlRXSkFCVElUSnNuT1o1TTF0Tm9nQmVxRFJMZWcyWEtubCtEVURVdjlOUXZQ?=
 =?utf-8?B?WVM3RnFMdzUzeTI5RHNhUkZ3VlphTkxoYytkZEJiTXBKWFdldjFtckdhdGIz?=
 =?utf-8?B?U2lCRHJCb2gzMHVZbUhHMDdZQjNxM1JaU2NrRTNZZVcvQTQxZkVla2Y1Qkdu?=
 =?utf-8?B?WXFBMUFJVlA1bytvSk13MTJhUERqWldiZElGZmw2SWlLWEZOM1Q2ODJveDk2?=
 =?utf-8?B?eWlhRlViTmQxaHVpUDUvWVd5Zy94cVdsN2dYM3lBVTBhZDQvQXNZRis5aHNI?=
 =?utf-8?B?S2gzTlJoc0FEMHYvWVhOMGZDeVQyWlAyMktBZXBsajBEcjl3ejQvdjZyMm9H?=
 =?utf-8?B?bU1rSDhEeFJ1QnF6aUFIM1FtY0tacVZWa3hVcmNDeFAxbDFRMnFKMnN6L0hK?=
 =?utf-8?B?OEk0QUUzQ0RLVDhMSVo2UnZLbDVicExnSXk5dWhrbU9FV0dsSi9aTmltRWhL?=
 =?utf-8?B?NWZZdlZ0QkQ4bG0yb0FQVjh0TGlRcnArRDJYTWM5dit1Nkl5VDUvRHNKcU5D?=
 =?utf-8?B?ZlFsbWpveFUzNHpXNzZzT3lEODdnb0hLdElsL1pQemtTN0JZTVd3aTAyWUF1?=
 =?utf-8?B?SHE2Q0RkeU4ycytpUFF0V3g3d3k0Qk53OUt5S3dtLzJNelM4VFM5RVRHNlRO?=
 =?utf-8?B?L3N4RzMrMVhCZkZEak1MR0IvNTg0UFBCdVl5T0ZwN1g1UG5YZjhyYndGSTJr?=
 =?utf-8?B?Y1pDLzl2d0E5cFpCdHozV1lkNUs2Uzczd2NSbHdvSk1vVmNDclpoa2dtNENM?=
 =?utf-8?B?Z3A0Z3FER3NaeDZSUXpIbGpvU2ZJWTZ4clVDQXRpYWhTcEd2RWtyWm91YVBw?=
 =?utf-8?B?cTBtNldDa1oyWEJzT0piQnd4alBlODVKWVdmK1NGcGlWb3drN1dYNUI4eWM2?=
 =?utf-8?B?c0ExZUcxTENWOEdsTVZZa2dPTGpXeXRJM1FaRUw5N3BiaStCa2wzWGUwTVhQ?=
 =?utf-8?B?K2hFL1d6ZW4yd3JId1ZoYW9qQVNtc3NQYXZGUG8rTUxqN2JBUzZES3hkS3JV?=
 =?utf-8?B?Vkhlb0c2ZUZ0UFV5VVQ5VjFGT08yRDZ2OC81QWFuRVEwVE9MTE9HQ3J2cmFJ?=
 =?utf-8?B?K3BtUndLbW4wME1FR2trWDFNOEpMcENEZnFpMXVsRDArREVlK3BwbXVZbmpT?=
 =?utf-8?B?Z1BHTmxCeEs0b0ZXSDJWRlZ3ZC9FNUlMczZ4ZU9VeDhzeTlwTU1CS3poZ2lo?=
 =?utf-8?B?L3BVNWpDMFNvZkN1aTNtc3JrQkRNb2Z6Vm5wYVlpUFJCeGZSeXJVY3FCQjZP?=
 =?utf-8?Q?A1C+a309ltAf8IPGLteRmBw2Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlZ1a3ZBQk5WWkIyZzZVZFlOK0VRZHVxUm1Xem5ESjJIcXdLR2l5aUFpODBy?=
 =?utf-8?B?UjBIN0V5aEdoTEtWVk5UYWFoSVQyNWU0K0g0dzE1dHYwSGdtd283VGI3WGVY?=
 =?utf-8?B?VkF1TmFqcU5ua1F1SVptRE9aRzF2SVpXNEtnN2tFdVo2MHNpTHVCaUptWnBk?=
 =?utf-8?B?ekRaMTFBRkZkZHdtVzVKL0ZiU3dtc3VjMFZNSGgzR0FIU0FTSFpwRndlUThn?=
 =?utf-8?B?RTd2cW43VENpSnRwam5EOGVySmxZZS8zMVh2Y0xDTlFsdWhMdnVVN1NvTDhy?=
 =?utf-8?B?WSt1emtDOW9JZy9aREtDTlF2YzJhWUdMSVVLZnl1cmFON2JHYkx5UnF1Y1Vo?=
 =?utf-8?B?VmFVOFlqL1g2Q2ZkMW85U1dJdElMY3NPMHMvZjlyU0wvL1VCUGJxVmxFZGdN?=
 =?utf-8?B?clo4am5rTWdoZTlqK3lTcktXNkhuY3lRM2ZyQVorVWxHQXRYSzdzeC9xNk1L?=
 =?utf-8?B?NzJWR1lKcHhRS1pPdUI2ZVQ0cGhReEx3RW1PbmpsdzR4TlFwSm84ZnhCcENo?=
 =?utf-8?B?VVZEcjV0MlkyaVdia3lqcERTRldPdTlDT0VuQkVPL0pSUzI3MWtNcmJwNkph?=
 =?utf-8?B?SVp6cjVTQ2lURlpldDlwdjJvMTc3UVFncnpZVDZSeFJXQnI1OHpxYm56VkNS?=
 =?utf-8?B?MjJmaURPZFo5WituU21VZ1g0SEpma2w1b0hmVi9lQ3N2R3RYTTZYYmtCdEdO?=
 =?utf-8?B?bndUcDZIY2szSlg2MTJZNDA1N1JhbU5va2I3STZiSHo5dWFMSWNZNHlBNkNR?=
 =?utf-8?B?ZFB3U0hjT1YvUEY3MmdYd09lSDVHdDhJYzVDaE5NV2FBU2IvMWFLVk9Wemg0?=
 =?utf-8?B?ckhlakgrZm1vZXNMb3VBaGo4N05SMU5tZTFtQy8rb1RYMDVOWmpaYUtORlZO?=
 =?utf-8?B?Yjg1UDhHVFd5YUVWY2ZjRnZkNmhlL0VqcFBTL3lsQVlOdzlHZHdERG9qaW9P?=
 =?utf-8?B?OUlXRHNxQmtkdnJpYmR5UzRRcDVndStnaklwWnhwOS9mdEUyZEtOcU5lS3pi?=
 =?utf-8?B?WFNlendKWkwwZzFuM2lUU2JINVJVL3lRSFRiOHpKQy9iNGNGR3NRbG9PQWVH?=
 =?utf-8?B?c05STHE5V0RnOVdDZHVCdU9SMHNuZEJaZ3lZQ0h0QjJKZ2lnQkJiT0JjZGlW?=
 =?utf-8?B?UUNRa2VNeGwzaVZtdVlYbmxsT0hMTGFnTkNFRkEzSExRQi9CU0tibkNPQlFG?=
 =?utf-8?B?TFJzTE9nMk1lOUxTeDhRd21KWTNvWWdleCt2ZUlTMDB5T2FiQWgrV1Y2WEZv?=
 =?utf-8?B?ZUxPNE5MS0FRenp5dlYvc1FxV1BFK2szcDN3ZFNxTFZaemtJMTUwY0JqeWFj?=
 =?utf-8?B?dVcwNnduY2UwWFZYY2FBZm50WVNPczl3RGZ0NllPRGIyYlorTEcvYndoM1RP?=
 =?utf-8?B?Q3lGcEVQSFhHajF0WGU4Lzh1aTlUMWJXSEN5Rk1uelVxVHFheWVJQnoyc1RI?=
 =?utf-8?B?Vm5yRFVRQ2JsclFsbW1OV2JoUktDSDZlbVJrM2hBYWFVeVNxVWxNNU95UGlm?=
 =?utf-8?B?QXZTYm1DNkNHWUJwNTlGMS9MdGhmbUdQMXhpRFdYdzZ0UEt6OEtEME9tVVl3?=
 =?utf-8?B?QytwZXhsYkdBTklZeUhwZ1JFU2dqLytGSklOSmpxajM5RjQ1S3pFM1QydXFr?=
 =?utf-8?Q?KQ6kC3eswHAsBNQ5qwmc/bZQIUIjhHXIU2wF3fcAGUGA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: db56c111-1d4b-4469-30bc-08dd5ef2d8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 10:12:06.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9565

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMzoyNuKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjUyOjQzQU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMzoyMeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwOTo0MToyOUFNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IE9uIDkgTWFyIDIwMjUsIGF0IDM6MDnigK9Q
TSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7v09u
IFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjI4OjAxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3Rl
Og0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+Pj4gT24gOSBNYXIgMjAyNSwgYXQgMjo0NuKAr1BN
LCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IO+7
v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjAzOjI5QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdy
b3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT24gOSBNYXIgMjAyNSwgYXQg
MjoyNOKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwODo0MDozMUFNICswMDAwLCBB
ZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+Pj4+Pj4gRnJvbTogUGF1bCBQYXdsb3dza2kgPHBhdWxA
bXJhcm0uaW8+DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBkcml2
ZXIgbmFtZWQgYXBwbGUtYmNlLCB0byBhZGQgc3VwcG9ydCBmb3IgdGhlIFQyDQo+Pj4+Pj4+Pj4+
IFNlY3VyaXR5IENoaXAgZm91bmQgb24gY2VydGFpbiBNYWNzLg0KPj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+Pj4gVGhlIGRyaXZlciBoYXMgMyBtYWluIGNvbXBvbmVudHM6DQo+Pj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+PiBCQ0UgKEJ1ZmZlciBDb3B5IEVuZ2luZSkgLSB0aGlzIGlzIHdoYXQgdGhlIGZpbGVz
IGluIHRoZSByb290IGRpcmVjdG9yeQ0KPj4+Pj4+Pj4+PiBhcmUgZm9yLiBUaGlzIGVzdGFiaWxp
c2hlcyBhIGJhc2ljIGNvbW11bmljYXRpb24gY2hhbm5lbCB3aXRoIHRoZSBUMi4NCj4+Pj4+Pj4+
Pj4gVkhDSSBhbmQgQXVkaW8gYm90aCByZXF1aXJlIHRoaXMgY29tcG9uZW50Lg0KPj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+IFNvIHRoaXMgaXMgYSBuZXcgImJ1cyIgdHlwZT8gIE9yIGEgcGxhdGZvcm0g
cmVzb3VyY2U/ICBPciBzb21ldGhpbmcNCj4+Pj4+Pj4+PiBlbHNlPw0KPj4+Pj4+Pj4gDQo+Pj4+
Pj4+PiBJdCdzIGEgUENJIGRldmljZQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gR3JlYXQsIGJ1dCB0aGVu
IGlzIHRoZSByZXNvdXJjZXMgc3BsaXQgdXAgaW50byBzbWFsbGVyIGRyaXZlcnMgdGhhdCB0aGVu
DQo+Pj4+Pj4+IGJpbmQgdG8gaXQ/ICBIb3cgZG9lcyB0aGUgb3RoZXIgZGV2aWNlcyB0YWxrIHRv
IHRoaXM/DQo+Pj4+Pj4gDQo+Pj4+Pj4gV2UgdGVjaG5pY2FsbHkgY2FuIHNwbGl0IHVwIHRoZXNl
IDMgaW50byBzZXBhcmF0ZSBkcml2ZXJzIGFuZCBwdXQgdGhlbiBpbnRvIHRoZWlyIG93biB0cmVl
cy4NCj4+Pj4+IA0KPj4+Pj4gVGhhdCdzIGZpbmUsIGJ1dCB5b3Ugc2F5IHRoYXQgdGhlIGJjZSBj
b2RlIGlzIHVzZWQgYnkgdGhlIG90aGVyIGRyaXZlcnMsDQo+Pj4+PiByaWdodD8gIFNvIHRoZXJl
IGlzIHNvbWUgc29ydCBvZiAidGllIiBiZXR3ZWVuIHRoZXNlLCBhbmQgdGhhdCBuZWVkcyB0bw0K
Pj4+Pj4gYmUgcHJvcGVybHkgY29udmV5ZWQgaW4gdGhlIGRldmljZSB0cmVlIGluIHN5c2ZzIGFz
IHRoYXQgd2lsbCBiZQ0KPj4+Pj4gcmVxdWlyZWQgZm9yIHByb3BlciByZXNvdXJjZSBtYW5hZ2Vt
ZW50Lg0KPj4+PiANCj4+Pj4gWWVzIHRoZXJlIG5lZWRzIHRvIGJlIGEgdGllLCBiYXNpY2FsbHkg
Zmlyc3QgZXN0YWJsaXNoIGEgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSB0MiB1c2luZyBiY2UgYW5k
IHRoZW4gdGhlIG90aGVyIDIgY29tZSBpbnRvIHRoZSBwaWN0dXJlLiBJIGRpZCBnZXQgYSBiYXNp
YyBpZGVhIGZyb20gd2hhdCB0aGUgbWFpbnRhaW5lcnMgd2FudCwgYW5kIHRoaXMgd2lsbCBiZSBz
b21lIHdvcmsgdG8gZG8uIFRoYW5rcyBmb3IgeW91ciBpbnB1dHMhDQo+Pj4gDQo+Pj4gSWYgdGhl
cmUgaXMgImNvbW11bmljYXRpb24iIHRoZW4gdGhhdCdzIGEgYnVzIGluIHRoZSBkcml2ZXIgbW9k
ZWwNCj4+PiBzY2hlbWUsIHNvIGp1c3QgdXNlIHRoYXQsIHJpZ2h0Pw0KPj4gDQo+PiBTbyBiYXNp
Y2FsbHkgUkUgdGhlIHdob2xlIGRyaXZlciB0byBzZWUgd2hhdCBleGFjdGx5IHNob3VsZCBiZSB1
c2U/DQo+IA0KPiBJJ20gc29ycnksIEkgY2FuIG5vdCBwYXJzZSB0aGlzLg0KDQoNCkkgd2FzIGFz
a2luZyB0aGF0IHNob3VsZCBJIGludHJvZHVjZSBhIGNvbXBsZXRlbHkgbmV3IGJ1cyBpbnN0ZWFk
IG9mIHBjaSBhbmQgcHJvYmFibHkgcmV2ZXJzZSBlbmdpbmVlciB0aGUgb3JpZ2luYWwgbWFjT1Mg
ZHJpdmVyIHRvIHNlZSB3aGF0IGV4YWN0bHkgaXMgZ29pbmcgb24gdGhlcmU/DQoNCkkgbWlnaHQg
bm90IGhhdmUgYmVlbiBjbGVhciwgYnV0IEknbSBub3QgdGhlIGF1dGhvciBvZiB0aGlzIHBhdGNo
Lg==

