Return-Path: <linux-pci+bounces-23221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C334A5821A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951D6188B5B2
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C9191F89;
	Sun,  9 Mar 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gXCaivRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB018FC74;
	Sun,  9 Mar 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509864; cv=fail; b=kZGdYU/HmgzMxKPn/U29/RmjvnIFp+jMgoxr5NENGQ0bKOpN4YwiVtuDBySC/pU6BV8yAvC/ysH8OsdeSTtOW8WBKDhyNFa3jUL2Q/HMogzSiYd6wiF33A0A1CoPfEStm3N+ODVrlCwoneCbAisP+FMSMsKjnB76f8ludYmUEyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509864; c=relaxed/simple;
	bh=DfGUfQp+ZwTifrERsJD5VUtDXlg1AXHskukMQWMJCVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nAhbDVRxC+RlRC4Ok2xuvQfnAKzPdxjsFrtetJU7YXXGZsxKaVhZtLfxseW2LYh2eFoZ/YHg3Zw80vI57yyILF/fXxtsjHKS+79zJYZ+fTlenpOS6bXAWsxzdMxf69ZYMeKYijgFNfiaNYNCNMS03cKQmFCbb2lehfAgkgmOcek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gXCaivRY; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCFrYMR3c31kpx6eCogxDY+vN1huUY84oqq9VqG7dtvDB9YF0S+onspbTZHF2diqYF30yz482LxrGyPiGqk6k0ISEoYeWgtaFEDX3zoKvjj0rgEgSdkc+jg0mOdcewVIiwLYupMU12SHHogZGGF9A+GiZbvxAJ7lSu5Srse14jJ4FyoITUmImyYSRdvh2jGe9PWbr6fzzoBlZlCQhW/xwhawshI+UeKNU7dHexjiBbmyYZQnrdyaZ7nDu6Ug93P29ko30p0SQlmwaT5hSn5c0TQL7srfMaM49JyRg+/MVH3xLkJEMvprliRtzulHXlKwOyLjFt7RET0lgTlkDtRr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfGUfQp+ZwTifrERsJD5VUtDXlg1AXHskukMQWMJCVg=;
 b=yIM40UdHuwBnlDEua/Jyd1fz4yvgg1O/OU3Rqz2owiWySKZ8Gj//itmmRhTEZE2wWkeqPCIzFkyenGfh9+AfMN6O7EFSOQTKkm391sUTMhRUVrnyO8sM8exPkTI/At0/GE+aRLcpNsskei/cscTOJCkCfu/ovjx+RBA0D9e7MbwTpS/0BCKEeOTG0BQofKAGn+czICLovyFo76GJzCwENHGvijhtXf/nPmO+TyZ4ZfwYYxO8ZqNzxWLiBA25MCzQR1DkAgBfeVQW9n87+4tK7HR+9+/cSr/n8Xj7KfNiAc9naK6EcTQ3UdjYA652dXkWW1ynrcetc928tC0Mk9EVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfGUfQp+ZwTifrERsJD5VUtDXlg1AXHskukMQWMJCVg=;
 b=gXCaivRY7RI/kBCDM8DRw2fYxFmHJMb+7Yqf0A3SsIlYY0LOeccMH2JY1l94Nx5TR332j7rxRSIV3V+nshH0XTyYq4oP4NuwrdGvn3ErqECEkIWNAbMKWq/NrVNJgv6CZrpMvOl40EaGZWe0ZMOxqeJR/TDfx0dvJnBtkVseqnPNv5Rk3e0Xv802PYDZVFclAjrvlIPpRW3C/wFKNEzc88uQEy/fksLNatB7qlm7DKsja6HHXMV9OQ3syp70M+Q4W30GT2NIZVXukq6gHVNnfmwTFuE25t3wkFkPtia2Z5Qy6fving3a/DaEe/Lu6aCyLf1cG7yyTzkML6puuRVhKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8698.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 08:44:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 08:44:16 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Aun-Ali Zaidi
	<admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqfTUA
Date: Sun, 9 Mar 2025 08:44:16 +0000
Message-ID: <2B62772A-4292-4673-8F86-9D27D7AB4EE6@live.com>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
In-Reply-To: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8698:EE_
x-ms-office365-filtering-correlation-id: ba7e3b2b-c11c-44b0-8810-08dd5ee6936a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|8062599003|461199028|7092599003|15080799006|102099032|3412199025|440099028|21061999003|12071999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?elJTU21OUk9IaS9BV2NGVHBTSWs1TFJXeVZGVzUzcGpNQW05NjZHRGlZNTBa?=
 =?utf-8?B?SXlkWEVWS3pFQ2NuZnUyL0pXcEp5cmw4RzQ1TWNtQ3NNcTV2VkhmWEx4bFBK?=
 =?utf-8?B?QmJsRUc2cXg5WE5TQ0NoaFRvQVZ4NGxjMDVGSkhJdW1qT1VEQ0ZZdmU3L1NC?=
 =?utf-8?B?U2t1VXFmZS9FTUhWOXo2Rmg5V2xjMU5HZW53Q3dYYzZWa3Q2NDhaUVBZdVl3?=
 =?utf-8?B?bWNvSDRJMThaWXF5dE9qS2MwTDNpOUladUVWamJWb1FQSjhSSGNZUVk4V3NC?=
 =?utf-8?B?SGE2R05HTDhOR2NwYkdrdnJoTytQRmFFU0l1UytFZnl1bDNTSFpjaTdPVXVG?=
 =?utf-8?B?VmVNYzJaN1prRHlORk9vdGdUMldxbU40eStXcWg2clZXRWg1V3RraEhWTGZ5?=
 =?utf-8?B?NW9neVJ0Wll1SXVPbHlBWDVXejd3THZsYWtUS2pGTmpJY1RKdUF4Ni90c05T?=
 =?utf-8?B?TndGQ0JwWXRKTll3VnZCUGYvQURoOTQ4QVRLdTZxRXAzMmNwZWlpUHZJdGZm?=
 =?utf-8?B?ZEwzdUFiV0RiSExzM20rQ0NjOVVGU0NmTmErU09pQ2RWMnkzamxBaStRakhy?=
 =?utf-8?B?Ym5Ldi9kakpiak96ZlB3aHZ2eUxRT0pjdlhaczNMb0xWcXorQ2dJdDdqQnBS?=
 =?utf-8?B?QzM0OUc5Nm9Va1RTdHQvaGYycHY3YytWWGY1Qjl5dS81VXFRbkRvdHpjb0tL?=
 =?utf-8?B?V3BLN1c3UGtRVGZpN04yRFFwY1pqUjBHTWplSGFqMk81ckMyLzE1dHRiVGRs?=
 =?utf-8?B?VGVuM0lFN2pqSmVjQnVTTEJPZzVhdW1MN3J1cGdpV3JNSDVMQWdOdkpsQnZl?=
 =?utf-8?B?WExqY1VKOFhCQncrOGdWVE9rUHZtNFZlZUt5Y0t5NzErUHpDRDEwOVAwQm5x?=
 =?utf-8?B?aTkrMGV2dTBtc08ydjAzZTgvSGFRV3VFR3FtVERneWhNaG1BRVZvbXdab29W?=
 =?utf-8?B?M296emNaZUVoQkN5aStFNmw3R1dNYmgyWkwzcDFwbFJ3Y0ZuVmpOaVdhbnNl?=
 =?utf-8?B?R1JNejdZQW96N2U0N1JBZ2owbVB6eEVOeFNieE92Z0t0bkpZYUkxV05GYkJw?=
 =?utf-8?B?cU1uL1pLQ3gxUitKZUFqMGhoLytKRnJWMXNrYTAraERGNlhqczBUZ2szNWtY?=
 =?utf-8?B?S2pRbytESUtWSm1GRUNXTGpRNStSUGxQVmlXOHpWUGZmK0ZhMG9GcWRlQ2d6?=
 =?utf-8?B?QU50V00ySDJNTVRBWTROMVhuNmxxYmRheGpQcm5PRzJXc2pCMVhZcU1BQktw?=
 =?utf-8?B?UGZRNGhsZW9tTFNsNytlUnJPbzVyZGJXRkZhMjQ4aVFGQlN5UnEvcnY4VkV5?=
 =?utf-8?B?d216eVFsMlVEcmk4Wi9scjBUM2RJUEQvWUNXb21UUzBuN1BLcHlXcHRRVUdT?=
 =?utf-8?B?SFllSzdRRGQxcndXS0RzaENqbGtrTEE5YkREM2R1aHpqaWJ1VjNHaitYeFd2?=
 =?utf-8?B?dlFudlptVGxPWTVsbllXd1RFOCt1UVV6Y1JicEhWcnBoeXJmVElzZ3Z5d3k0?=
 =?utf-8?B?T2d4NWlKQXZxb3ZyKytaT3AyTVR5L2NRK2RwSmdQbjB3MnRsV2hxdXZnajZW?=
 =?utf-8?B?YVd1QT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFdjaVN6SnNxWWQyS2JtZUw4Yk1OZVBkMEpFOUwzV3M2TXNNOEgweHNKT2ZP?=
 =?utf-8?B?bjNiN2Y3ZlpvdFRWbW5NMVdxczRYeWFwb2RDV0FQb2tsb0RvWHlST1FuQVJk?=
 =?utf-8?B?NG5HRzVhM2VMQldYTC9melJnQit4UGl6K1RMQ2p3d1F1N21MbWN4T1FTc1Rn?=
 =?utf-8?B?SjVmOGE2d2I4aEdncnpzWVhHeW1SVnoyOGtNcWJrYWxwclY5eTBsbGt2U3B0?=
 =?utf-8?B?eDFwR0xRMGJIL0tDQXhwNlQ0VmpLYit0azJVajVjUk9OTzRXbkhyRGllK2Yr?=
 =?utf-8?B?Z1JuRjlLS0hMQSthYyswWU9zSEVxKzFTelptNTRzUHFHZlpJY0pmM3JCZlB3?=
 =?utf-8?B?bUJjQlVua1R1b0pmYVpScWhGaE03YWVuWk9JcWgwczlBYXowRzFnbnFsOWNW?=
 =?utf-8?B?REdxa3h6RnJmN0tRVEE2OG1iTWJnZjBwZXBVaTE5U0tmTUNTSEZTbzREcE9j?=
 =?utf-8?B?Qk1Mb1U0SkF3bXFTbW9qaGxzaENxNlJ6aytGTER2NkJZSDB0dmhsTWNzSlJD?=
 =?utf-8?B?djhjZUQ4dVRWQ2dBZUhaOUdZZ3FxeHBvdERRZFB0SGx2bHlheG9TZXNqQVlQ?=
 =?utf-8?B?bHc4VEFaZzRwL3lZNEUrWjRlLzdOcVFvbzQyRmtncTJwNHNxTHhkK0RuOFoy?=
 =?utf-8?B?dFBTMVhnWUphVk9ZYXYreEt4a21lZytHUjdUUDF5VGMxMjRudk9Jd3FzZ01J?=
 =?utf-8?B?MUdSbmJ4MlhXeHYwbTc3cUhTMk52YXFNTkl2Nkt2NXNnVXNKNTJJZGlRQkxZ?=
 =?utf-8?B?NEtka2xtaU1TWEVYZDhZSTdmcUxRaERna1d1bEExQ012OGVIa0tVanVoUlVZ?=
 =?utf-8?B?VUpPZ0piQXdzbXdsMnBvcTF6MndhU2VBQnppdkhFK1IvYXVqNkpSV2lnejlr?=
 =?utf-8?B?ckdkVEF1dXRiZ0tFN0x4a205L3lLcGMyMUFTaEhOK0QwblIyRmRNTEw3dGMy?=
 =?utf-8?B?Qy9oWUhzOVFBRUMzU3h5SGJJdGFzMStRYmJNeXQ4VW1ZMi9IRld5T1RZb3Ir?=
 =?utf-8?B?SFZDMUd0aGh0VXI3YmtNWFJRNXpUa2ExYm9xZERKeEtBV2hBMDgxeGJPZEdZ?=
 =?utf-8?B?emJuT2o2bWJHWlJ5TXBaNTZVcU1tWWlKQWxFOEcvcU9PenNGMU1LMk9iTEZR?=
 =?utf-8?B?cFp5Q0p4dnRTYkxyQk0zeHVFdjJUMmdtb2VFeHI5VlNHVU1CS0xCeStrMVda?=
 =?utf-8?B?ZjF3eWdxZW9KbnUwWlhjOWgzYXBlTm84ZFcwekltN0kxSmlYUUdVWGFTQjUv?=
 =?utf-8?B?S1hKZkVyNmNnS2QzOW9BS0tWVUsvWU0yOVhGZ0lXdGlTR1liWGt0VG4vN3hN?=
 =?utf-8?B?dldKYyt4TE92SGtNS1pLdjNSaEdvMTRDZ255VE45WFhHUUF3bzkwMjhpTTMy?=
 =?utf-8?B?OU42L0tlNmNJWDFkN3Nhajc3QVE2UUtVRVhmWWVBNXVjMGNEWTl5R0RPWjFL?=
 =?utf-8?B?RGp0ZDZhVVNQMElUZlVrbE9VUG0wa3FpM1JrMkloM3NaR0E0dTg0Tld1UmlF?=
 =?utf-8?B?czAzS2tBQkM5bm8xaHJCSlVqMmhmQVp6VjlpZVRtajNVYlhQY0tzZTBBdG1I?=
 =?utf-8?B?THR1dEkxdGU0SFdJNlo1TGU3NWxhMm5xSVBTOHVDWHkrenBNdzVtSU5HcGc4?=
 =?utf-8?B?UUk4eTh6dVdaRDRmQURibFdWTG5tTWVRdktNdzE5Q0w3WWpzZmF0SXNuZUFH?=
 =?utf-8?B?UEY0VVVLcEEwL3Z5anlvUzRsc2Nmalh6S1d2dXBFbkJYc2U3WVZTY0JtS3Z3?=
 =?utf-8?Q?2eXCBe6ykavSDEF7Mmb1jHJK98ko8/6kzMrYbxp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71DF898396F554CA004849A66E27517@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e3b2b-c11c-44b0-8810-08dd5ee6936a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 08:44:16.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8698

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMjoxMOKAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IFBhdWwgUGF3bG93c2tpIDxwYXVsQG1y
YXJtLmlvPg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGEgZHJpdmVyIG5hbWVkIGFwcGxlLWJjZSwg
dG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBUMg0KPiBTZWN1cml0eSBDaGlwIGZvdW5kIG9uIGNlcnRh
aW4gTWFjcy4NCj4gDQo+IFRoZSBkcml2ZXIgaGFzIDMgbWFpbiBjb21wb25lbnRzOg0KPiANCj4g
QkNFIChCdWZmZXIgQ29weSBFbmdpbmUpIC0gdGhpcyBpcyB3aGF0IHRoZSBmaWxlcyBpbiB0aGUg
cm9vdCBkaXJlY3RvcnkNCj4gYXJlIGZvci4gVGhpcyBlc3RhYmlsaXNoZXMgYSBiYXNpYyBjb21t
dW5pY2F0aW9uIGNoYW5uZWwgd2l0aCB0aGUgVDIuDQo+IFZIQ0kgYW5kIEF1ZGlvIGJvdGggcmVx
dWlyZSB0aGlzIGNvbXBvbmVudC4NCj4gDQo+IFZIQ0kgLSB0aGlzIGlzIGEgdmlydHVhbCBVU0Ig
aG9zdCBjb250cm9sbGVyOyBrZXlib2FyZCwgbW91c2UgYW5kDQo+IG90aGVyIHN5c3RlbSBjb21w
b25lbnRzIGFyZSBwcm92aWRlZCBieSB0aGlzIGNvbXBvbmVudCAob3RoZXINCj4gZHJpdmVycyB1
c2UgdGhpcyBob3N0IGNvbnRyb2xsZXIgdG8gcHJvdmlkZSBtb3JlIGZ1bmN0aW9uYWxpdHkpLg0K
PiANCj4gQXVkaW8gLSBhIGRyaXZlciBmb3IgdGhlIFQyIGF1ZGlvIGludGVyZmFjZSwgY3VycmVu
dGx5IG9ubHkgYXVkaW8NCj4gb3V0cHV0IGlzIHN1cHBvcnRlZC4NCj4gDQo+IEN1cnJlbnRseSwg
c3VzcGVuZCBhbmQgcmVzdW1lIGZvciBWSENJIGlzIGJyb2tlbiBhZnRlciBhIGZpcm13YXJlDQo+
IHVwZGF0ZSBpbiBpQnJpZGdlIHNpbmNlIG1hY09TIFNvbm9tYS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBhdWwgUGF3bG93c2tpIDxwYXVsQG1yYXJtLmlvPg0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0
eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0KPiANCg0KRldJVywgSSBhbSBhd2FyZSBv
ZiB0aGUgbWlzc2luZyBtYWludGFpbmVycyBmaWxlIGFuZCBzdGlsbCBub3QgcmVtb3ZlZCBMaW51
eCB2ZXJzaW9uIGNoZWNrcyBpbiB0aGUgZHJpdmVyLg0KDQpNeSBtYWluIHB1cnBvc2Ugb2Ygc2Vu
ZGluZyB0aGlzIHdhcyB0byBrbm93IHRoZSB2aWV3cyBvZiB0aGUgbWFpbnRhaW5lcnMgYWJvdXQg
dGhlIGNvZGUgcXVhbGl0eSwgYW5kIHdoZXRoZXIgdGhpcyBxdWFsaWZpZXMgZm9yIHN0YWdpbmcg
b3Igbm90Lg==

