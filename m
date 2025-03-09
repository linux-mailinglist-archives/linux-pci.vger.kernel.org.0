Return-Path: <linux-pci+bounces-23232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91883A582AF
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCDE163438
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64818CBFE;
	Sun,  9 Mar 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kRqXv/rr"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09CECF;
	Sun,  9 Mar 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512489; cv=fail; b=EGWp4C9oEELBZTEWxkIb0vRDNyvzjUnNJCV7QbpkbgQiKgvJLJ364eg7vizRUlty/69luP3e2OfU4Tn9atEXEXwUAecYzBfa2uHfEr2/oTN8NUfFOh+e+6arUQUgp8rIMpSsATgGQD4ZYIGnViMJa+1GPOMZAqt7rN0Scjy/UDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512489; c=relaxed/simple;
	bh=IFoP4IJgFEBdGrZL5ZcpEn7cW/s6YY0Py90x/wa/Kzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5TLLrU9dftV/zoYB6HXe6balM14H3L5Bm583drtN0Kn56QQ7DKIcQJJyyDHm01M+l5JMT4o0ul/csiUzDuRImF43sdb1X29N4NffJPni+ELVax2XZpoAs1UmnugGMy1CBBBKX2w5kySpDUVAY4GzjxjolN1srYOA3IRveSzDZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kRqXv/rr; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yct+OZm6WagE0C28OY3t4oTdh013R/ndHkl2NY3Y/ZHv81o2jnmRMInDIBUYlQVVHJzu5i1zbJ0bUSzcUScfk/Q8STDlHuqY50F98o5ezq2qpB1CwMfgBQGpilTbco2B3vAklCtMdhM4WB3jUZDaM/T0aDmS46I+1zTF1q4caP1UQIVWUVC8pkF+LO3HSQPq0t0R038JcXFP9gBU1sOFNw/OiuTKt6STfsxI8GNE0xHM98KH6jilZYS5JoWYEqXiVQGXfVgrmHbNfRvb+ojHml093HE2XdTDeHbCg1XURK+j3kL825B0C/XB1qH7AeHy0diqJ7n+RL2/YRmHCtiq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFoP4IJgFEBdGrZL5ZcpEn7cW/s6YY0Py90x/wa/Kzs=;
 b=Xzm49rbz6yM6kZS5BEKL5lLqTFOIOw+RI2XyW+zwMvRxg+Aehw1CJEKIo6f1SLC4OGCWE8h1ojTsH6HEL99L+MuiTo+XdsOkRKbtCAXGMx9j/oYGUtyy8l0WhEKb/ni7vn8nLaTyaR68xagKiaVeIjXtwprFu6DAPsEyxik9wrJhVBNAT5ts7MsxdK4TEQsjOcAu96RElObeWyA6QwwDC5ognDKYH6G6/17Ca61GEvdLeJFlGjK5lY3GmJlRDknmSl89Pre7SDaECDMozrHBtFAt5Tj9bZnWziMp9OKrDso4UQK2OUFe+hCvrUi+BweAfLBKI/KBIN9UOUYcgaDdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFoP4IJgFEBdGrZL5ZcpEn7cW/s6YY0Py90x/wa/Kzs=;
 b=kRqXv/rr0knxvX8HdH7f9wZFJSz6rAHK93Vgk3APsYASHukMQb84IFyKylEghRbkXwkr3EEQrD+HMejVMR1rK0S7yugDm0TZqXnlkKZRprhK/GXYCoR1OrE+rrqa4Nzwixd6i+GhB7e/DstYgK1ZkDhGjvSoP+PPT3AfdJj4SH2mCsDsdI2MqpotbHD/7lCFJFnmdSbFQiNjQelHVqNutBX1p1sD3kJbjfO35gupfSL/MJHO+r0uvB3SA5KXC+uz7KhZtJ3GSG4cWztmPfGuZURFgIZS2PitbD1kIzF1/p3Lf5xKWg7kh+7ItZzdMK9b1ci7/PV9In3X/2eSCNoe8g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB10767.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:24c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:28:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:28:01 +0000
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
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4OAAAMjgIAAA7jx
Date: Sun, 9 Mar 2025 09:28:01 +0000
Message-ID:
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
In-Reply-To: <2025030937-antihero-sandblast-7c87@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB10767:EE_
x-ms-office365-filtering-correlation-id: d69ded0f-e810-42dd-28a3-08dd5eecafef
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|6072599003|8062599003|8060799006|19110799003|15080799006|7092599003|102099032|440099028|3412199025|21061999003|12071999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjdCMndnMHJnWkpnM2dlTTMyMTBXTGh4WERjNzErWG9UTVFGSlljT01vVmdL?=
 =?utf-8?B?c3hyeE96NmxlWW0va3kzV2dvWmdxVEFYYnV4aDhXcWJPQmFTTC9DVmwyQk1S?=
 =?utf-8?B?YXdkejZCNVBCeHpaNGJMWXRmMVdvMUtkbXNkdHo2RlFDMUNDODI2MmtsKzhx?=
 =?utf-8?B?UkNKOUI0bVlpZlVDSFUzOGFINFdRczloM0lEazZXa3NleUJXTisvN0Q2UG9T?=
 =?utf-8?B?ZnJ1YVE1bzh6Nm9aMy9oRXcvUHhqOUlleDRBcFN5bkNzTDNjS1BRSjVVL0tJ?=
 =?utf-8?B?MW1mRDVKcXFUT3BDbEtrKzgxR212YUZBaWhaanV6VE8zbC94WldkOWVzbjRl?=
 =?utf-8?B?bk82aVoyZUNWZEl5K1RTQVJtYlExWmhWNFhOanpJUFFlZ3FFbE04ZlZ1OEFp?=
 =?utf-8?B?RVhPYnhHWCtDT2RIMmlabDBYREROQ2xvZDFIYkdnckRxWmpkdUEwdkRKazN5?=
 =?utf-8?B?Wm12R0FUbkRDOHREZXdJaHNueCtSY1RYRnFHOE1YN3NOS0VnUHRkYjhJSWJu?=
 =?utf-8?B?cEtIbEpSM0FhM2VHNWxxKzM1azJsajVZYlMxZWh1T0V6aTVJTDVUakZXU1Ex?=
 =?utf-8?B?NnRZc28wa2FYYSs3OVQrbXBPeVlnZXVhcWwzNWNldFE4SEJHQjBWN3FXYWp5?=
 =?utf-8?B?eTVEWlY1WExpVlgxNllQTzczS2llRTlrRVNEc05YZ2d1N0x5R0JlMlVVTE4z?=
 =?utf-8?B?V0x4S012TmN6ZDRpcU9KYnZSN3FCZXVUQTB2aFZJc3ViK01wYnFuYzY4aUVy?=
 =?utf-8?B?MkNxaE0wVkdqTzN3L05IeENwMFdqNUlRb3lieUlvelA1NmZnd2JFU2xCWTh3?=
 =?utf-8?B?b1lUbmttd2tSQnloZkFIc2daSjN0VVJBV2RmcGRnOXlxa3JiQzBBaE9Sd09X?=
 =?utf-8?B?RjFTaGxKVmRNd2xZN29XOXF0RmFGVllQNjhKNUExTmpETFJ3WGR4aGVNVVh2?=
 =?utf-8?B?S2JLNEwxSW1PaUlUZHlFT3ZoMEhrd3lMNU9zUUxNQWpWVS9lU3RuYXlHWEcw?=
 =?utf-8?B?eWx0bjRvMVNsZkJLeHZYUnoyNlN1YUM4Nm9NdmpWWFArNHo0NE43R0tYM2lk?=
 =?utf-8?B?VW9ZMTRnOU84cTNBd0x3WHFlN0FyY2FPRGRDeitKL09qQVdXVjZJVGxkRU9z?=
 =?utf-8?B?WlVOVlFHemlYVEczVnQ3aVJkRWJBKyttYXEyMlE4NkpIYnpxcXcvTmdxR3Js?=
 =?utf-8?B?ZElKR0tFWlRnbEpYVWJyRndEOFBSaTBUc21zOUp3TUsxWUtiS1hUL0JPSU5Y?=
 =?utf-8?B?cHF5aldMZ2VjNkJtdFhlTzhESzFPd3kyb29ESkwxdFFwTzVqK2pzMUpkU2ht?=
 =?utf-8?B?S0VHNVdNS25URk84VlkrNlVnU1lNOWtHd0FTNVRaYVdWL0VpeUljanZVaTZw?=
 =?utf-8?B?bVdYdkhoaEcyRW82aVBzcjgweVdIcm1xcFgzYitianJ5VGNPRTNoc2dBZGZO?=
 =?utf-8?B?VVNmbFY5TlY4b0ZFWUpUaU9FNVBRY1pMZGd1Vmt5VmNlS1VuUVFidEhYenMy?=
 =?utf-8?B?RHprNGoxZ2gzQlNQZzBxT0dBQ1hqYkR5b0MzZm1XUVhSQjVidDMraWVrRm5R?=
 =?utf-8?Q?8bXHybXcmCr9GcvZtyrv+25IY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2VYL3F0bURYakJJdnF6anhac2YwQUl6dUVsWUl2Z1UrRldNSzJ4RE1LZ3Bv?=
 =?utf-8?B?aXpFYXdza1E4Qnk1WmJkVXB0QUR1cWJuRjZaQmpSZmNrOU95VkRhRDNxbWVI?=
 =?utf-8?B?WGdja1Zzcitrb056SUNPRzV1VmtWTlJwQWtEM2dhdmQ3N0NUVDBHTGFZSzlX?=
 =?utf-8?B?MEZyeWZ3dTEwVjFCdGtjOHlnSGFWWHY2bVR3azBDWXRRR0dtTkZxOVdHa1dh?=
 =?utf-8?B?cVdkaHZnK1MzeWFXb0Jxc3lZQTZjOVNOcTVUWDNLYnRyaVBRL3YwektKWndp?=
 =?utf-8?B?TWdzLzk1aUkxeG1NQ1BUTnpOdnJORUhFMmpSL2NXenk2aDZ4QjBrQ0hqL3hx?=
 =?utf-8?B?UXJlblMvV1lzTVlzakxBNTNvTVpjN3JlYkxzZVRxYURrbTVZd01TNVdEa3dY?=
 =?utf-8?B?QlJ0dzdoRXd3bzFSLzR4d0poT3dobFl2YkJKcVZ4ckw4MTdTWDVrUktUaHh5?=
 =?utf-8?B?clh6bmY2b0hjcjRKUVFDM2RBdjcrcEpKZy9mQStyOGpTNFU0KzJ5UUZzaHMy?=
 =?utf-8?B?a3NIc0J5NkpkRm1CUFZkYXI4eGtSRkIvaldrcmN3U2FQZXhsOG0yZGU2V3Iv?=
 =?utf-8?B?ZmRPb3ZZdnlmTkxtajE0cmQ5ZTlBeWlwd1VPWkdlT3VXSzFOcG50YkxYVW9W?=
 =?utf-8?B?L29KUitRS1pOb2ZLTUxSbjFBQjlEWFVIQ2xjVHhYdkt1UVd0dGFQYSt3eGxN?=
 =?utf-8?B?SFRVNjZ0am5GeEx5cVVRaW0rU3lXdTNtWjBTK1oxUUJkc3VjSGNDZW5ta082?=
 =?utf-8?B?R01TNkFmS1A4Nm5UVGZNSmh5WjRkMjBFTUhoSXc4WTVGeURDTXNrZEkrd056?=
 =?utf-8?B?aU9zQ01hWjZWUm9kSUFudWM1TmZHSitpRHFIdDgvbmtHcnNKMXVLNzNJSVdO?=
 =?utf-8?B?Sy9zM2ZpQUFXbjN4NVA2UHFPWWFUZEVSaDljOHRYVVVFOVdPZlZWbFhBcjlC?=
 =?utf-8?B?S3hPcnp2bzF6dFprQnA3Z1NqNDFPSWU2WENjZytLVG5DbERuMlBhUWgwZWx4?=
 =?utf-8?B?M2lsNGxLSWNPTE56cUEvQTVDRmIrc3VaODZ4c1hCdUcwZmJ5TTduYkdRTHRM?=
 =?utf-8?B?YWUrRy93Z1BXNDM2cE96dVhmeFVjQkNZdHJockt4elFmQnlIMUZFclVnNkNa?=
 =?utf-8?B?S1A4czN6WnRCcUxnUXp4VkZ6ZzUvaC9wUkltN0FUck9LeWk0NkE1R2dJcWpo?=
 =?utf-8?B?V2d2c3RUcG1HKzhUV0NwbjVjMGQwZlJlemtDa3JnQ2JUckRKbXh4alNuNDcx?=
 =?utf-8?B?dUpKSWVJT1d1VW04V3ZWNlk5bmVOYk5hc2U2VFh1VVdHK1Q2Y1YyNTJyNnd1?=
 =?utf-8?B?Q3U1bUVUcGdDQWJUQ0FjNjNPblR6ejlGUThGREo1VWlIeWdRWTRFejVYTjN2?=
 =?utf-8?B?ZERwb0dYNWVlYW5zOTdYNHh5b2t1Ykk1TytOOTVBSEFZVkt5WUROWFExd21D?=
 =?utf-8?B?Y1pMMDBmaksyTlZTbXFHUDlIZ1E4QWozcTByYVN0V2pKT0llRlo3ZXBQT0lr?=
 =?utf-8?B?d0t4cDJLS2VuaDFBZ0d3eU5mczBjQ0s3ZU55QmhneS9vVzA0aTRaMCtNUmIw?=
 =?utf-8?B?SWN2Y0VUaHpJWDE0TFFWUlZCN09lL01TU2xnUU9oVnJKdVA0dVJ1dHNSUjZX?=
 =?utf-8?B?UjJ3bE81WmRnbE8yUHpWVFVIVE9OMUxsZnU1R1hRRVpzbG94M2R3bGhuR0Uy?=
 =?utf-8?B?T2ZLZXRTaFk0SUZMZFJqMzhpOGpGRnQyR1daRkdBQzdoZVRuYVRwMW1rNURz?=
 =?utf-8?Q?QOZDBqDAeDMz05VmCE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d69ded0f-e810-42dd-28a3-08dd5eecafef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:28:01.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB10767

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMjo0NuKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjAzOjI5QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMjoyNOKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwODo0MDozMUFNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gRnJvbTogUGF1bCBQYXdsb3dza2kgPHBhdWxAbXJhcm0uaW8+DQo+Pj4+
IA0KPj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBkcml2ZXIgbmFtZWQgYXBwbGUtYmNlLCB0byBhZGQg
c3VwcG9ydCBmb3IgdGhlIFQyDQo+Pj4+IFNlY3VyaXR5IENoaXAgZm91bmQgb24gY2VydGFpbiBN
YWNzLg0KPj4+PiANCj4+Pj4gVGhlIGRyaXZlciBoYXMgMyBtYWluIGNvbXBvbmVudHM6DQo+Pj4+
IA0KPj4+PiBCQ0UgKEJ1ZmZlciBDb3B5IEVuZ2luZSkgLSB0aGlzIGlzIHdoYXQgdGhlIGZpbGVz
IGluIHRoZSByb290IGRpcmVjdG9yeQ0KPj4+PiBhcmUgZm9yLiBUaGlzIGVzdGFiaWxpc2hlcyBh
IGJhc2ljIGNvbW11bmljYXRpb24gY2hhbm5lbCB3aXRoIHRoZSBUMi4NCj4+Pj4gVkhDSSBhbmQg
QXVkaW8gYm90aCByZXF1aXJlIHRoaXMgY29tcG9uZW50Lg0KPj4+IA0KPj4+IFNvIHRoaXMgaXMg
YSBuZXcgImJ1cyIgdHlwZT8gIE9yIGEgcGxhdGZvcm0gcmVzb3VyY2U/ICBPciBzb21ldGhpbmcN
Cj4+PiBlbHNlPw0KPj4gDQo+PiBJdCdzIGEgUENJIGRldmljZQ0KPiANCj4gR3JlYXQsIGJ1dCB0
aGVuIGlzIHRoZSByZXNvdXJjZXMgc3BsaXQgdXAgaW50byBzbWFsbGVyIGRyaXZlcnMgdGhhdCB0
aGVuDQo+IGJpbmQgdG8gaXQ/ICBIb3cgZG9lcyB0aGUgb3RoZXIgZGV2aWNlcyB0YWxrIHRvIHRo
aXM/DQoNCldlIHRlY2huaWNhbGx5IGNhbiBzcGxpdCB1cCB0aGVzZSAzIGludG8gc2VwYXJhdGUg
ZHJpdmVycyBhbmQgcHV0IHRoZW4gaW50byB0aGVpciBvd24gdHJlZXMuDQo+IA0KPj4+PiBWSENJ
IC0gdGhpcyBpcyBhIHZpcnR1YWwgVVNCIGhvc3QgY29udHJvbGxlcjsga2V5Ym9hcmQsIG1vdXNl
IGFuZA0KPj4+PiBvdGhlciBzeXN0ZW0gY29tcG9uZW50cyBhcmUgcHJvdmlkZWQgYnkgdGhpcyBj
b21wb25lbnQgKG90aGVyDQo+Pj4+IGRyaXZlcnMgdXNlIHRoaXMgaG9zdCBjb250cm9sbGVyIHRv
IHByb3ZpZGUgbW9yZSBmdW5jdGlvbmFsaXR5KS4NCj4+PiANCj4+PiBJIGRvbid0IHVuZGVyc3Rh
bmQsIHdoeSBkb2VzIGEgc2VjdXJpdHkgY2hpcCBoYXZlIGEgVVNCIHZpcnR1YWwNCj4+PiBpbnRl
cmZhY2UgaW4gaXQ/ICBXaGF0ICJkZXZpY2VzIiBoYW5nIG9mZiBvZiBpdCB0aGF0IGFyZSBmb3Vu
ZCBhbmQNCj4+PiBlbnVtZXJhdGVkIGJ5IHRoZSBob3N0IE9TPw0KPj4gDQo+PiBUaGUgdDIgY2hp
cCBub3Qgb25seSBoYW5kbGVzIHNlY3VyaXR5LCBidXQgYWxzbyBoYXMgYSB1c2IgaHViLCB3aGlj
aCBjb25uZWN0cyB0aGUgaW50ZXJuYWwga2V5Ym9hcmQsIHRyYWNrcGFkLCB0b3VjaGJhciwgd2Vi
Y2FtLCBhbmQgb3RoZXIgaW50ZXJuYWwgZGV2aWNlcy4gVGhlIGV4dGVybmFsIHVzYiBwb3J0cyBh
cmUgc2VwYXJhdGUuDQo+IA0KPiBUaGF0IGZlZWxzIHN0cmFuZ2UsIGJ1dCBoZXksIHdlJ3ZlIHNl
ZW4gd29yc2UgOikNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=

