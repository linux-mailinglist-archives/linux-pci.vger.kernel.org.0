Return-Path: <linux-pci+bounces-8460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12890024C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B9EB20FDC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75A15DBB5;
	Fri,  7 Jun 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXQVea0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AF17571;
	Fri,  7 Jun 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760254; cv=fail; b=Mqf7/f0vO30HiitCdMAmpci6DhKHrfP1koVFVi2ilaHR8IaU+vto2egxLo36iR8uAP+gsrGoXhI515gpRMfJE9J4mHiM48CdcZ64SQKtScisntzfZXzGcaKxJ9l1oaks6j+hxEupYaiNi2ClBej90uBYcYw7QdIgJqwH9rqhsX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760254; c=relaxed/simple;
	bh=j+OQ8UznV/QfYSJQxzaq1g4yFo6Z8z+AKgZw9SOZQVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPqcI16egYccyKBs4ORWGrkLqz0S3I0Adz6xlMjseCW/udP38wG/oQjQDom0DZmnv9kCZyNHREutjVBWlvI45Dseew9YPBhGA9nDwnrcN/KVzmuXxX0h0O7KEgRJukIKl4VCrpxcuxAt40WnO3adSl4oZYrhmexXU/PRXKVU77I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXQVea0P; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFKn6famX6VwR23xPUo21eTfEE9WUzGKiaBZrQOfyPMhXJpmBvQaa0GXFyzYMzG8PbioxgjmhfnhNFa2mnMCOCq+EVrZ1/4dnO9yb4Oeu7S+JwqfdJpQ+B1bud0suSyKpmwx/Q48A707o/pLjx0vJtmyk0OluEs5jsY3LAU2VXorfBu0LsP6ndkr/LhPc5MFNmLdzT8kcL9rFcNyh39iU/+ydGqujudYdtn5HLapllrE/okS6pHBWm5/AqffqeCsVREFMZXXDzNhJnjXuLJt5r0uPb0W1WiVEqQyWWs5lubIPm+vZ3rOCyIKj1rijZM0ny8/V5H2cAhhNlXWAQ6foA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MvlamBfqUxzuWY4RBLM5LIdKsRCNy6T3my0ifwrPBM=;
 b=lwex/pL7WMqJZKC+xWMeHeWjsgeXTLh1aahIfjvz+Rk0wHtUFGp3g9SFDoqidiloCs5ry9EMRz2PQT8IssyrnNQPxGaHWVDina/8r2dBgTLfwJQRrvzNqQLhILN5+oSECeyvh2FxtyscmJf5op+hd5BI4jweYlHcQnkIX6l/JfpmRG3oufxr0sFT3SWlvkWFF5l1Z4/LWOKte/Op61GX/0B6q9OPGdoVc9P+79rajpB7YALb7hDvhRlan5BKlqF0Cg9SJQoG9RNdOWu5JfZ/MP6pz/kUVuiSXin/fdRwEQVz/Lj9X3RhIlFpJJaPnc3q71LSx4lk7y7pQfYKFoFIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MvlamBfqUxzuWY4RBLM5LIdKsRCNy6T3my0ifwrPBM=;
 b=HXQVea0PVQ7FTce+5bQBX0L1jMckn/wonGIdCJJ0J1NuLu0NaJYDvOnRWvAcx0DseHn2g+lhZSvi5JW1naDwhyrmRO4h3hwcQxRcZ8yJR0brULynpUkAYEONKnkZGFm86/rorSxZyLoCT9NSuHdK3dKXUJMIAPv9J1F/kRd2SpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 11:37:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:37:27 +0000
Message-ID: <432d2df8-3686-4f87-af1a-a9a172d662b9@amd.com>
Date: Fri, 7 Jun 2024 13:37:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1][v2] PCI: Support VF resizable BAR
To: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Shi, Lianjie"
 <Lianjie.Shi@amd.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>,
 "Zhang, Andy" <Andy.Zhang@amd.com>
References: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
 <20240523071114.2930804-2-Lianjie.Shi@amd.com>
 <DM6PR12MB49588A7576D6DBE281A4340F81FC2@DM6PR12MB4958.namprd12.prod.outlook.com>
 <DM6PR12MB49584B9866498A33D79EFEC881FB2@DM6PR12MB4958.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB49584B9866498A33D79EFEC881FB2@DM6PR12MB4958.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 80014cdd-b6e2-49e1-76fa-08dc86e634e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R01URXdsR3paWXVGQ3lELzVaRlh4dmw4d1l0dU8xQmxEVU9mREJVN2VXVWxG?=
 =?utf-8?B?eHNoUXpES0x5a1k2VXhPRjRmMDV3dUEwQVA5MzRsWVpkK2hoRGtSWjJKa2JJ?=
 =?utf-8?B?d1cwZmdEMUdtR1lKb2huWW1Uc3NyYUtaZm1NZk5aSG52ZXljdTYyZWFQOVND?=
 =?utf-8?B?VFRhZzYxZUVqR3Juc3NPdmJVdWljdElSaDNBWE9ITnRDYUJUbmRwRHdpR2VC?=
 =?utf-8?B?ekVjTEFvQzQ4UEpEOGZ3a0xGKzN2Zk9LTG40MUp5SXFzY2NUUEszSU5qMXlV?=
 =?utf-8?B?OVVGd3g1Lzc4ZkwydEF6a25aMGs1Rmx2S2EwTlJKVzV3TkdTZVBTOFA2RFQ5?=
 =?utf-8?B?T0F0b3poNGxjS0g0TVlLNjlmeXh4NEcxTnR6YkdzaVNaUTRvL1pndkZtVkt3?=
 =?utf-8?B?cm1SenI3VXM0elprcit3MHc4Q3orWFRMUjNLczdEakNWNXNQdWJPS0Q2MFYw?=
 =?utf-8?B?VVBkZENVek9QODZFT01DdkRZcjJpaEVaKzJDaXZaMFZhTmo3NmNndmZWYWFm?=
 =?utf-8?B?MitIRTlKZWdDVElCSjk5enVTTjllczJLNi8ySFlZUTNVcGJ4QXNmaERRNm9W?=
 =?utf-8?B?ckNvVnB0VTZCalkzQ3BPTWdiVndZamlpOFVtV2Uxc3JsR3RVbjBQZGlCcXhq?=
 =?utf-8?B?d21JamIrMUhsa2pXUkxMQzNyZHlxVTVlbE00WG1HWmtRN2E1YU02ekRHWCtM?=
 =?utf-8?B?aTF1RG5weVBoT2hod1loZW9JRmd4UWpXWmIwYm5leUY2b1grNVBacUlGSGQz?=
 =?utf-8?B?ME01cEllRVROaFhIYWNMWUkrK1JtVDBJbHFRaVN1b0tzVEtCTEZ3UWhkVGtq?=
 =?utf-8?B?MmpTZVlLMkxkRGtSc2haQXdFUUhaTlhmZ1FtN3pDSGNEQVYrTkZLN3ZsZW1X?=
 =?utf-8?B?TE4wUVdFRklvTVZ1Z21ZZmJIVGxGZXBYK1RzZGF1ZTZVb015K0RWZ1JQMW1a?=
 =?utf-8?B?dDY5bWkvNm9INFJJZWg1NHNpNlhoRUxGRU1JZWw1QUp3YjlDK0VoangyMCtR?=
 =?utf-8?B?QWJKTWJ2dG5HK0FMVzZLZ20rcEJkdVo1eSs5MkoxeU1qdkt2TmQ1Wi9KTER6?=
 =?utf-8?B?Q3JTNjd4ZERVSnhYeFU3TEEyYkVYNDdISGorN2FzLzJTL3ZtYU44cWJPZSsr?=
 =?utf-8?B?U3JCUitBNmNOS051VnR2TWRLb25Ed01FUStwdnNmMGJXcnVZZTFsdUxERW1l?=
 =?utf-8?B?M1RDdEpUSStkejVGWXJiaWM1TThMN2Z5NWhlbW9GeG9CeHk2RzBjYnBaVzFy?=
 =?utf-8?B?QkxWdlVIbk9OUHRBbXRGUm9Uc3FjNDhnaE5iZkFPK1oxbTFDelJuZnFLY3Mr?=
 =?utf-8?B?Wm93RnM0YTgzN2txcTZQMTdkWllOcHdMN3dMUGFDNFdMcXcvVFE2ODRsbVZO?=
 =?utf-8?B?ZVRwMVJFUXlZc240NG44QWNMVlRnRzcxMHpjZWRaZms1V05SQlltT1hISVdj?=
 =?utf-8?B?Y0E3cm9jcEN4c3NhKzhQWjRvSXRvUnJYNVRyaEJjcGQvZDFrei82Uk0vVUEy?=
 =?utf-8?B?bm1CcndEU1h2MmEzbGsvLzNaQ3JyVTZaYTQxVXQ1QjhOS0ZIOVA4VzhOeTVl?=
 =?utf-8?B?WXlzTXZscFQrWlp4OENGMUNKZGVPUWlnQUJuNDdyZTd4N3hxcXBtWk0vSXV1?=
 =?utf-8?B?c3grRlgxaFZ6bk1zWWM2djh5NVJxcGRUZnRZRjBCdTdibGI0V1M4Q2x4VElh?=
 =?utf-8?Q?A5YENeiM/sc0XF56/4UO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FyRVltdkZ5VXNKbXI1YUR0WFhLUHB6UFFweGJFZW52dnI1UkxONGsxR0g1?=
 =?utf-8?B?WTZsanlrdklCVkN3dFdQNUxyT2R4TGRXL1pxR3JQVFFHZjNPWDJOaTd3SDhk?=
 =?utf-8?B?NlFwbnV1MHBIRnJXWUpuVWhMODZwYjFDL0JGdUZvSk9pSlhYdWZGRWF1ajBr?=
 =?utf-8?B?S2pRYTBqQlJoVGZpRkJON3RUNWFCeHVZUDhVeHI1NXQ4OHRyMmtLa1lIN3RM?=
 =?utf-8?B?TzM5RWh2bWNQR292eVlUOFpVL3NYUURHWDc3VXRUdkVtaEh2RXFVN2JKWDNS?=
 =?utf-8?B?dTBWUEwwamdJVGVXTkVFUkpINExhNHUyQ0FyUGNVTWlFS1Y3VUJZcENrczNy?=
 =?utf-8?B?TFgyOGdCM0NhdkdJYlgvbGNvYkJVeFZ4U1lrV0hrcEJZQnBPSXJuSEsyOWNW?=
 =?utf-8?B?Q0Q0dWR2VFpML1JoVHhTc2VRSWdFT3U1aW05NGxkdkRCVStqYkF3YkFOZzNp?=
 =?utf-8?B?SjAvNkUrMnNWRTR4bmZLN2pTRGg4MWR0NSsxNFFZS2hibUpPY0pTeHBCUTN2?=
 =?utf-8?B?UEt0NDBlUXdGNU5RQkdTcDExSFZUeFlyN0NyaEZrb3p1N252NVdXelNPVWs1?=
 =?utf-8?B?ZVc2R2dwMHRtV2lWdUVWQ01scTdYdVZUZm5rMGlBMGZnOFo0SSs4elY4NlR2?=
 =?utf-8?B?SnZaV1VuMVlKNWxlaEtsQWVsR0pnSExRdnJVQ0JWMnFncjNhZW5GcWlkbEI3?=
 =?utf-8?B?cVMzdzM0azUvYysvRGdKQUdneGh4eHUzc004VUsrS0NIQXZwZEJFVS9kMXJ2?=
 =?utf-8?B?bFJvbUF2cEJtbFByY1NqYUJTUDFJOHFLMGpFL2RDQVYvaHZuaGQ0WTJwVWF1?=
 =?utf-8?B?YkJ2UkJHSm44a2Fibko1cWs4dE9UNlBBd3BBYm1vbjgxOVF6ZWgzeVVFd3Ez?=
 =?utf-8?B?a2hHOFZsSG1CNHI2UXNJbjVtK3FRc2hGcmhRQmNEMUJldzZJcXV6Rk1rU2dz?=
 =?utf-8?B?Z1JsR3FUdHpaaHd6d1ZNZXNyWWlQZTllWGFwSngraklMSFF4VThjYnk2ejdQ?=
 =?utf-8?B?VG5QeGpUNjBtWHh2c012dDNnT2orcnA1YmVjclRzdEYyTjJ1QnJlNGtHTVpG?=
 =?utf-8?B?bjBrdFRvM3NSSzlJdmlFUUVwSThKQVg1WTRDVHF1T0RPK3BXcVh5Q3owbmJz?=
 =?utf-8?B?VFZDUllBaTRhY1gxZFphc1puck9OUUQ2TnJTZDZ5azI5aEI2ZDJGMS9KWUdl?=
 =?utf-8?B?Ymt0TFpIVlFuaHkxR3hMYy95RWpWMjl0Mm5yb3Y0MEhScU4zUDJyMm1QbUp2?=
 =?utf-8?B?OUIzdEdOMThJNUY2dE9ZN1J6VWtycXp0emxNVCsxWTVjeVNxNlBRU0ZEWnBG?=
 =?utf-8?B?RGlIWTQvVjBCcWdJYU41WWdIVXZoOGZwTXpmTnZ1d0YrdEIzeHpPeFF2SWFF?=
 =?utf-8?B?cnVmTHVXZGlkTklsd1hWbXpFZVJpK2lVRjZGa3RGRE9aS0ZmbXBxbktVU0kw?=
 =?utf-8?B?WkFxU2VMYkZOM3EyVVJ3RWwzZERRbnZRVzQyZm0rVzhhVjVzaXF4RFlONVFn?=
 =?utf-8?B?dWJ3N05SSmN5UGwrSXpzaWh2N285c3dTcit0YkFIeXptOEk3MzMzaU5FSjBR?=
 =?utf-8?B?emZGYlZzTy9wVkVSTVV1MElNYldENEVYYWdIbmJEK1NXK0llUUhrVTg4VFRR?=
 =?utf-8?B?UlJDNjlzcGt0TjZEUzkvZTBZOWorT3BLeW9ndHFNOEpabFVmRHhRbzVoelFm?=
 =?utf-8?B?TDg4SkJvOEk0V3g1eUxvYmRPemExL3JWRGl3akJYdzl0NjFsL0ROOGxJVW85?=
 =?utf-8?B?T3QwTzRxd0h0eS8wUFR3bE1NVkNMK1QrT1pHVW1mMzF4MWRnVW5YRnpML1Zh?=
 =?utf-8?B?dHhLUVV2dk1UVkdZZW85WUdmUm43MTQ3S1NSbEVXcndTdTBlR1Q2Q3NMTlcr?=
 =?utf-8?B?SzJ6VTg0TVUxRkNnMDh1Uytvdkc0eFllQ0RreXR1emdUZFhMVjlNYUlibk9T?=
 =?utf-8?B?SmJrbGtNbnVWaVRZbXBXNTNsMVltREhwSWRtQU9rOFc0T2c4c042bHMzekk5?=
 =?utf-8?B?SWlDcis2THJ5VTdLWGN4SDZNRlh0SW55S2EwemVxSEsvWk1PNFIvcHQ4YllC?=
 =?utf-8?B?OEpkMmp0dnNTN0VtbXdub09QRnhwVlpxUHJReHFIcWF5R3plUkpldGoyRHpk?=
 =?utf-8?Q?aPEROFmu+VkzB/POr5ixhpiVG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80014cdd-b6e2-49e1-76fa-08dc86e634e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:37:26.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAmmO72MyegRU/WwlyE1SEsGNh8LiPns/xu95qYuO+xULVFr6Ln0rfKvi2ri960V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

I need the original set of patches, e.g. directly use git send-email 
with my mail address.

Forwarded and mangled multiple times the patches are not applicable to 
any tree any more.

Regards,
Christian.

Am 07.06.24 um 10:42 schrieb Chang, HaiJun:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> + Christian to review the VF resizable BAR patch.
>
> -----Original Message-----
> From: Chang, HaiJun
> Sent: Friday, May 31, 2024 12:26 PM
> To: Lianjie Shi <Lianjie.Shi@amd.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com>
> Subject: RE: [PATCH 1/1][v2] PCI: Support VF resizable BAR
>
> Hi, Bjorn and pci driver maintainers
>
> Could you review the VF resizable BAR patch?
>
> Thanks,
> HaiJun
>
> -----Original Message-----
> From: Lianjie Shi <Lianjie.Shi@amd.com>
> Sent: Thursday, May 23, 2024 3:11 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
> Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com>
> Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR
>
> Add support for VF resizable BAR PCI extended cap.
> Similar to regular BAR, drivers can use pci_resize_resource() to resize an IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is resized, but the total resource size of the IOV resource should not exceed its original size upon init.
>
> Based on following patch series:
> Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/
>
> Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
> ---
>   drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
>   drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
>   include/uapi/linux/pci_regs.h |  1 +
>   3 files changed, 85 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index e5f243dd4..12f86e00a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>          }
>   }
>
> +static void pci_restore_vf_rebar_state(struct pci_dev *pdev) { #ifdef
> +CONFIG_PCI_IOV
> +       unsigned int pos, nbars, i;
> +       u32 ctrl;
> +       u16 total;
> +
> +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
> +       if (!pos)
> +               return;
> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +       nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
> +
> +       for (i = 0; i < nbars; i++, pos += 8) {
> +               struct resource *res;
> +               int bar_idx, size;
> +               u64 tmp;
> +
> +               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +               bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> +               total = pdev->sriov->total_VFs;
> +               if (!total)
> +                       return;
> +
> +               res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
> +               tmp = resource_size(res);
> +               do_div(tmp, total);
> +               size = pci_rebar_bytes_to_size(tmp);
> +               ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> +               ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
> +               pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +       }
> +#endif
> +}
> +
>   /**
>    * pci_restore_state - Restore the saved state of a PCI device
>    * @dev: PCI device that we're dealing with @@ -1882,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
>          pci_restore_ats_state(dev);
>          pci_restore_vc_state(dev);
>          pci_restore_rebar_state(dev);
> +       pci_restore_vf_rebar_state(dev);
>          pci_restore_dpc_state(dev);
>          pci_restore_ptm_state(dev);
>
> @@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
>    */
>   static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)  {
> +       int cap = PCI_EXT_CAP_ID_REBAR;
>          unsigned int pos, nbars, i;
>          u32 ctrl;
>
> -       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +#ifdef CONFIG_PCI_IOV
> +       if (bar >= PCI_IOV_RESOURCES) {
> +               cap = PCI_EXT_CAP_ID_VF_REBAR;
> +               bar -= PCI_IOV_RESOURCES;
> +       }
> +#endif
> +
> +       pos = pci_find_ext_capability(pdev, cap);
>          if (!pos)
>                  return -ENOTSUPP;
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c index c6d933ddf..d978a2ccf 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int resno)  }  EXPORT_SYMBOL(pci_release_resource);
>
> +static int pci_memory_decoding(struct pci_dev *dev, int resno) {
> +       u16 cmd;
> +
> +#ifdef CONFIG_PCI_IOV
> +       if (resno >= PCI_IOV_RESOURCES) {
> +               pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
> +               if (cmd & PCI_SRIOV_CTRL_MSE)
> +                       return -EBUSY;
> +               else
> +                       return 0;
> +       }
> +#endif
> +       pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +       if (cmd & PCI_COMMAND_MEMORY)
> +               return -EBUSY;
> +
> +       return 0;
> +}
> +
>   int pci_resize_resource(struct pci_dev *dev, int resno, int size)  {
>          struct resource *res = dev->resource + resno;
>          struct pci_host_bridge *host;
>          int old, ret;
>          u32 sizes;
> -       u16 cmd;
>
>          /* Check if we must preserve the firmware's resource assignment */
>          host = pci_find_host_bridge(dev->bus); @@ -444,9 +463,9 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>          if (!(res->flags & IORESOURCE_UNSET))
>                  return -EBUSY;
>
> -       pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -       if (cmd & PCI_COMMAND_MEMORY)
> -               return -EBUSY;
> +       ret = pci_memory_decoding(dev, resno);
> +       if (ret)
> +               return ret;
>
>          sizes = pci_rebar_get_possible_sizes(dev, resno);
>          if (!sizes)
> @@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>          if (ret)
>                  return ret;
>
> -       res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
> +#ifdef CONFIG_PCI_IOV
> +       if (resno >= PCI_IOV_RESOURCES)
> +               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
> +       else
> +#endif
> +               res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
>
>          /* Check if the new config works by trying to assign everything. */
>          if (dev->bus->self) {
>                  ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> -               if (ret)
> +               if (ret && ret != -ENOENT)
>                          goto error_resize;
>          }
>          return 0;
>
>   error_resize:
>          pci_rebar_set_size(dev, resno, old);
> -       res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
> +
> +#ifdef CONFIG_PCI_IOV
> +       if (resno >= PCI_IOV_RESOURCES)
> +               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
> +       else
> +#endif
> +               res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
> +
>          return ret;
>   }
>   EXPORT_SYMBOL(pci_resize_resource);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h index a39193213..a66b90982 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -738,6 +738,7 @@
>   #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
>   #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
>   #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
> +#define PCI_EXT_CAP_ID_VF_REBAR        0x24    /* VF Resizable BAR */
>   #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
>   #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> --
> 2.34.1
>


