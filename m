Return-Path: <linux-pci+bounces-23227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA02A58284
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CE23AD9EA
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E457187332;
	Sun,  9 Mar 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CMB1vkDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22C13665A;
	Sun,  9 Mar 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511016; cv=fail; b=UZp8iSUdGoTvvbXRgVNf0rM925infWV6T9UrRdrEWowalCM6wvzvRJ5A8v+ML/HhvDiXVQWTWpHMd2B1o07b6k1RpnMGZkZAqyBwpo3ZBZIKA8qNYUFi9e5myZnSzFVcOhYpdqipnvxNhx1GZyiBIzYlAYywsGk5TImh8CQxzC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511016; c=relaxed/simple;
	bh=R6mCLiuEwcm95nKwa++q/X/LNAQxrRe6BaKEYyo0sjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnt3o741x3M+j+fW6/OKKm6iYwX0NudXmETK+4TvNatEcKyDBtJEjwO9nGPrgnx09B3TDhSE5SO4Zqc2TBubLYrJ39kkPRrEAVYW2826WdQDEtl6K54IO1PL/mLxpjDA9jHHtoGImrX4J5GYa+kWmh8K1hqL8eWJsiOYwsgnpa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CMB1vkDV; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ+0U6lMvujJEo0b0yLggrGGNeQE6v3KfX151YIicx0HCZhLoulcAeoRqE2A5m1fZZ6VRzY4M53dmHFMnYj/EPr5ptV6R/aC+eG03/edyCncQaebu2Fo6lyuAC6OvqtFtSH6aQ190P874NsqMidzCZvHX6r7K6sWrCt2dhfovNKX0aduBMzHuiO4mFNx8OPi4fahl65qi8Nl6i5gq1ltf0We0QXUZYOCPBVE+mSU6DLoLtA2eBdp5WsLm+d1DhnkncyhvSb9id88R6sMI/XMRVQ5k5wzmNKnv6LrLBJTkMu9hiprcW2MIUW4XDcKF6hQKNoxSNiiixlNWzRw4Nny8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6mCLiuEwcm95nKwa++q/X/LNAQxrRe6BaKEYyo0sjo=;
 b=CimwIuTR+93xxujg+iZtgrQjplCIxRsfgL1sp7aOlGo4SB1qCL5Bnl5wGWyqVVo12OT3pu4YsHjyXq1qIi6VeDm0KIUw3Fv83TVXkYDaJL5nprlVOraG50l2r8Pnidmcii7eT0jJT74x9bvD+ir20Dtraq3ivpqxFMdFqMEppRCPHusU2QDfoCWvZmW5NniXiqFJO2rhHo+hLfl8VOvE3hVqvpxg5HcPdc/TqcoX1mYMsVHavZryEB36tZQQVKxkE7v9mDdx8TYD2M596kYts298hqhKvHwKHRddSIU6/V651MfE6/g8pheBoVYUZFvcr8aVeWbMnBNnusFHdL07ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6mCLiuEwcm95nKwa++q/X/LNAQxrRe6BaKEYyo0sjo=;
 b=CMB1vkDVv26+RyMVxo+mGTSMUaeEuX86yTMghNsw+lJxjiYI54LSLNPmL+bWJtpimdeC9YyRA7YOgnHu8hZoNAAu4mJwuYT/oZGCwiuu5EB/6Xp7EFJZ6tU5GxUmSZixYy4MfjNjOXdKqVwprObpWG75UtLpaUDD81wzVGOzl2sl725h6xsxZ3I6YVSEgZsJVg/Gs8WJLgBoy+P0ImA9fXJBanFt1NlRo4t+92Ep1SkxJnex5QDh/5kychqs8PKaojy3XoM/DmqxnlCNk5+GN9PKnpk++XqYbOewT1B44+5KDRfVwFGPX1Fqat2cw29awX7RrGzXxHU4E9UbaQrLLQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB5915.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:03:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:03:29 +0000
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
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4M=
Date: Sun, 9 Mar 2025 09:03:29 +0000
Message-ID:
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
In-Reply-To: <2025030931-tattoo-patriarch-006d@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB5915:EE_
x-ms-office365-filtering-correlation-id: bdad171d-2856-4055-cd7c-08dd5ee94263
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|461199028|6072599003|7092599003|15080799006|12071999003|21061999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE54NnBiYVBNM3g5ZmVHM1JIQm4xQU8vTzR1M3hSOG1CdnRnQkZHUVUvdG5D?=
 =?utf-8?B?K0FqMGdnNFVaSkZHcVFZaGZ5TEg3YTU0TStNVENrcm9FSXhycVFLdDZUbnZZ?=
 =?utf-8?B?SlpkbGtWN21GRjI2MlNGU29zdkNVYk9ka08wUUxEbmc0RG11R3VraGc5Tklq?=
 =?utf-8?B?VXJGSWhwenhrUDMyZU5XZ3lRNisxdU9OS01PVmNtZHdyelduektkVkJuZVpC?=
 =?utf-8?B?TSt4dlNxa1BNQWR3RXh4V0RGakxxUk9WRVhKRFpDNUtnK0lsU3VyOUpwSm5v?=
 =?utf-8?B?ZEJ4VC9Gdk1wdFIzWHFVWnBzQW5tS3V0RHZwNFBJUnNrcTI2cFRjWlNLa2dM?=
 =?utf-8?B?TnNFQkgvSWd6d2FXV0hiVVdadGEzYUFuUGNSaDd1dk1rSHIrZEoyb2dUcXZr?=
 =?utf-8?B?WTNuYXpQclJJQ2FRaDF2M3ZsV21jMWZSK2ZxOGgrVlUwdjZuSzhwUzJSdWlR?=
 =?utf-8?B?SjM2NWRTM2Vma3hZc1RWSEJJNThEcXpoSTRGUG5lb1laS3NBekxWcjZqU1Ra?=
 =?utf-8?B?RnVoRnM0a2NybkRYMXZpa0lscmp2TDkvb0dGNmZvZzJBaW9VeUJlU2VLbks3?=
 =?utf-8?B?TVA3OGk3d2s5VkZkVFhOOHNldmVGSy9pVnV6UHMxME5YZlcyV0VpYzF5NDNR?=
 =?utf-8?B?V0hNUlFwaE5LZWZ3TmhyRmEwN0o0d2dmL3BNT0ZHaG1SVUhXUk9NcWhuUnNq?=
 =?utf-8?B?RHR2ZVhnWmIwY1Mrb2NWNzlUbWs1T0FINXVmUjdnWTByT0EwcnVVNHZENWVs?=
 =?utf-8?B?N2xVT0l2UzVCWDlsRitxaFhNWS9Ha25iUkVDbW9PRjRYb0RKWHpNcDIzTkJ0?=
 =?utf-8?B?OUozZ1NFNXVyOEMveUlBQTk3ZHFneVVna2F5RUJyeEFrTlgrQkhOWStqTm9l?=
 =?utf-8?B?bzQzQWptaCt5UG9CZG4wT2Uzd1ZpUHhWc3hFU2piUXVma1RTQVhxRUxla3Ju?=
 =?utf-8?B?b0pzL1M4OEc5MEo1azNZU0JuSU1GOGd2cmQvUjJmanhRd2NFQmRvWER6bkl2?=
 =?utf-8?B?WGVhQ2VLVUdiOG5rVTNFeUpJeW0yRDI4aXBrV24yWWJpRzNzTVlHZVd3WnZL?=
 =?utf-8?B?NkNZQW1BVkxMOENZUUl1RFZWejdKVWRkbk9HcGkxTDM3cDRORUp1bDdwVkQ0?=
 =?utf-8?B?RUpReW1IdmRIU3lpRjB6dUhuejg3cmxoQUwxaStXRU9LdE5HdjUvMmVkZndF?=
 =?utf-8?B?M29KcEcwS1I3dzE3SWNCbS9yOURmbzRma2pVUXJHQWVuU1Z5ZitCTWEwajJG?=
 =?utf-8?B?UXpMaFlySWpVYVI1cU5kVWdEb0d1VkgrU1ZQNnVqajVmMDFoeURidVRxb2dW?=
 =?utf-8?B?L2cveHhZRWxsREp4cjJQc1NQa1R5OCtuY2d2RDZ5SXB1TmswY1Z1OGhIUGlE?=
 =?utf-8?B?Ym9VN0NBOVNDRWR6Q0tiODRuY0tvMmV2VmxhVVZYeWk0YXNkYWZmTUxNazZr?=
 =?utf-8?B?V1NydnRKa0ljTEpycGdwNjZqZVQ5L1oyV2JlL3NRR2g3VDZvOWRrUnRKZEM0?=
 =?utf-8?B?R3FxMmFjbkNLbGlnWjJiOUVQUlluc1RpL0kxVkxaL0JLUmdjUUN6dWV2aUVL?=
 =?utf-8?Q?nsZ9Ku7+OWsooRripfmzMoPN4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bndIeWhXUS9SMmF4SEtIZmRvaU5kMEdiWHZXWVIzU245UUwyekM4Z00zSWdX?=
 =?utf-8?B?ZE5oeVZuNDBjWWlUQjRSVnpyMzRIMXdSVW1uQ1lhNG5NMmxFbURzSG0rZ1FR?=
 =?utf-8?B?NUZPSGR5WjVuR1FaM3RtVlB5V2I4SkVndDBEdFJiSmdEenphUlZmQ3dzaXFx?=
 =?utf-8?B?NkNja3RZM0VWWStIblJLdmpPNWh2VGhQVk1kWW1WUzZsakErRTU4MXNDcm9E?=
 =?utf-8?B?UDBJbDhVS0REMzNIaUNzU0ZSd3RMeHpTd1JmbllBbm9WMzlBSjhyVWVQRVJL?=
 =?utf-8?B?K3NBUXZ5RkdpVWc5R1A4MUJJamNrRWJ5VEtweTZjK2JCR1RFTXZiWE5pRHo5?=
 =?utf-8?B?NkYrR2tXMEN2KzYxYzNxN1VQN3Z2WUk1QWZKcW1UVWxZaEphNm1kK2hGUWVG?=
 =?utf-8?B?SWp6YWVmS3RTNCtzVFlvcW5vSXo3ZnpteURaaVh1ZkZvVTlWdFY1RkRwdVNk?=
 =?utf-8?B?RXNmUHJZbnh5dXF3N3ZtRHVNb1BDU0JvM2wrcDRzYUtrcThmMjJIdWI3NkpZ?=
 =?utf-8?B?Z29lamU1bDY2cXZwbi9ub0lJeDRhajFvOVBxMDN2RDlhWVNHNlBLRkdxbTRY?=
 =?utf-8?B?NlozSDEzV2Z4RG11ZUNIS1lua3RMaHZVRHVJTWNiSHplSS92dHpXeWwwSkw3?=
 =?utf-8?B?WU9HZ0s4TXBRbHYybDJhL0NYRXlTWUxXNXJTYkZsc0FDQUJBNG5Sc05FTmZU?=
 =?utf-8?B?clhHM0Y5cXN4UkRrM1FsbDhtT3p6Kyt1WXI0RlVoNFZBb2N4SkkyeGpQbEhq?=
 =?utf-8?B?b1hFK2tDZEs0eklyUHdPRHN3TDlQaDZaUFUwclljR25KaUN6QjZsSHF3TWpW?=
 =?utf-8?B?UFoxdzluUGdJMHBOekdmRmgxU0tvRDJhaHZ6Zkc5QmdRSm9XZ3FFb3RMTFlx?=
 =?utf-8?B?SE5pTTR0UW9wS2ptOEZ2VTlDVTBiNHo5MEpabm54Q2FTMHo1emdDS3QrM2t5?=
 =?utf-8?B?ak1oSDU1a1ducDhPN0oyUVNSNURoamExWDU5SUpBNDViNGFNbEhvTzkxdUZW?=
 =?utf-8?B?UE90ZGxVYUxGZzJTbUpTRlFQell2My8yQW5LWTBXVVNPZytrUXR2SmQ4a2Jl?=
 =?utf-8?B?MEpLeTI0YThodDg2NElUTWFqdm8vVTdUUU04dlNsYW9ueUgvaDBObXNoZU5R?=
 =?utf-8?B?elNtblhUYm0xaUZJWFkvNDViUjNrTVgvNDVtQkcySzAzaHQzcE5RbHNIaGRE?=
 =?utf-8?B?K0w1cnUxbTE3azVlVVNGdG1sUUY4QkFnZGNiZmZtRGFRcEx4bDdPK0hMSU5w?=
 =?utf-8?B?aWpBQTFBTks1SXFkOHord2N4RUNoaTlMd3BPNmlRNDZ2ZGRPK3AxSExmZlZh?=
 =?utf-8?B?N3JEdzh3NTI3dnVpODVCQnhCeWUxRlJEWTR1OGZUQThEMllib3ZBWm9GQ3Rs?=
 =?utf-8?B?bUJKSGk3Q2RDeFJzUmV4a21Ndi9SS2VMQTRESWNEbWl0M21xcmswWVZVRzdt?=
 =?utf-8?B?WjFwOVBta1dMMGxCbGJocUR5UlVOMXZzaWx1dHFvc3B1YXZ0MytleWVZYzlr?=
 =?utf-8?B?UGtWZit3Nmhkd3hmUkUwRjhoVUZhZDJUeVZpeTR6TUJTRytoa24xREpYUEp5?=
 =?utf-8?B?dk5FdFArOFQ4TVgzZkVpak5ZcUtvY05NSmxKOXdmV3hmcGNBS24wc1hwZ1Rm?=
 =?utf-8?B?QXBkTXFNR1BHeWhJbUdJb0FEZUI0S2M0Sno2UTZWcFZPMXY1dnIrQnNraFRT?=
 =?utf-8?B?MTBRekZjVTNRTi9EWm81aVZ3Qno0OHc5aDJHMHJIbDdKMitqQUM4MkJhVmFH?=
 =?utf-8?Q?DMW352BhDqe0rr20Xc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdad171d-2856-4055-cd7c-08dd5ee94263
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:03:29.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5915

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMjoyNOKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA4OjQwOjMxQU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gRnJvbTogUGF1bCBQYXdsb3dza2kgPHBhdWxA
bXJhcm0uaW8+DQo+PiANCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGRyaXZlciBuYW1lZCBhcHBsZS1i
Y2UsIHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgVDINCj4+IFNlY3VyaXR5IENoaXAgZm91bmQgb24g
Y2VydGFpbiBNYWNzLg0KPj4gDQo+PiBUaGUgZHJpdmVyIGhhcyAzIG1haW4gY29tcG9uZW50czoN
Cj4+IA0KPj4gQkNFIChCdWZmZXIgQ29weSBFbmdpbmUpIC0gdGhpcyBpcyB3aGF0IHRoZSBmaWxl
cyBpbiB0aGUgcm9vdCBkaXJlY3RvcnkNCj4+IGFyZSBmb3IuIFRoaXMgZXN0YWJpbGlzaGVzIGEg
YmFzaWMgY29tbXVuaWNhdGlvbiBjaGFubmVsIHdpdGggdGhlIFQyLg0KPj4gVkhDSSBhbmQgQXVk
aW8gYm90aCByZXF1aXJlIHRoaXMgY29tcG9uZW50Lg0KPiANCj4gU28gdGhpcyBpcyBhIG5ldyAi
YnVzIiB0eXBlPyAgT3IgYSBwbGF0Zm9ybSByZXNvdXJjZT8gIE9yIHNvbWV0aGluZw0KPiBlbHNl
Pw0KDQpJdCdzIGEgUENJIGRldmljZQ0KPiANCj4+IFZIQ0kgLSB0aGlzIGlzIGEgdmlydHVhbCBV
U0IgaG9zdCBjb250cm9sbGVyOyBrZXlib2FyZCwgbW91c2UgYW5kDQo+PiBvdGhlciBzeXN0ZW0g
Y29tcG9uZW50cyBhcmUgcHJvdmlkZWQgYnkgdGhpcyBjb21wb25lbnQgKG90aGVyDQo+PiBkcml2
ZXJzIHVzZSB0aGlzIGhvc3QgY29udHJvbGxlciB0byBwcm92aWRlIG1vcmUgZnVuY3Rpb25hbGl0
eSkuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQsIHdoeSBkb2VzIGEgc2VjdXJpdHkgY2hpcCBo
YXZlIGEgVVNCIHZpcnR1YWwNCj4gaW50ZXJmYWNlIGluIGl0PyAgV2hhdCAiZGV2aWNlcyIgaGFu
ZyBvZmYgb2YgaXQgdGhhdCBhcmUgZm91bmQgYW5kDQo+IGVudW1lcmF0ZWQgYnkgdGhlIGhvc3Qg
T1M/DQoNClRoZSB0MiBjaGlwIG5vdCBvbmx5IGhhbmRsZXMgc2VjdXJpdHksIGJ1dCBhbHNvIGhh
cyBhIHVzYiBodWIsIHdoaWNoIGNvbm5lY3RzIHRoZSBpbnRlcm5hbCBrZXlib2FyZCwgdHJhY2tw
YWQsIHRvdWNoYmFyLCB3ZWJjYW0sIGFuZCBvdGhlciBpbnRlcm5hbCBkZXZpY2VzLiBUaGUgZXh0
ZXJuYWwgdXNiIHBvcnRzIGFyZSBzZXBhcmF0ZS4NCj4gDQo+IEFuZCB3aGF0IG90aGVyIGRyaXZl
cnMgdXNlIHRoaXMgY29udHJvbGxlciwganVzdCBub3JtYWwgTGludXggZHJpdmVycywNCj4gb3Ig
dmVuZG9yLXNwZWNpZmljIG9uZXM/DQoNClRoZSBhbHJlYWR5IHVwc3RyZWFtIGRyaXZlcnMgbGlr
ZSBoaWQtQXBwbGUgZXRjIHdpbGwgdXNlIHRoaXMsIGJhc2ljYWxseSBkZXBlbmRpbmcgdXBvbiB3
aGF0IHVzYiBkZXZpY2UgaXMgZXhwb3NlZC4NCj4gDQo+PiBBdWRpbyAtIGEgZHJpdmVyIGZvciB0
aGUgVDIgYXVkaW8gaW50ZXJmYWNlLCBjdXJyZW50bHkgb25seSBhdWRpbw0KPj4gb3V0cHV0IGlz
IHN1cHBvcnRlZC4NCj4gDQo+IEFnYWluLCBpcyB0aGlzIGEgcGxhdGZvcm0gZGV2aWNlIG9yIGRv
ZXMgaXQgc2l0IG9uIHRoZSBCQ0UgImJ1cyIgeW91DQo+IHdpbGwgY3JlYXRlIGhlcmU/DQpBZ2Fp
biwgYXVkaW8gdmlkZW8gZW5jb2RlcnMgYXJlIGFsc28gYSBwYXJ0IG9mIHRoaXMgY2hpcC4NCg0K
WW91IGNhbiBzYXkgdGhpcyBjaGlwIGlzIG1vcmUgb2YgYSBjbyBwcm9jZXNzb3IuDQo+IA0KPiB0
aGFua3MsDQo+IA0KPiBncmVnIGstaA0K

