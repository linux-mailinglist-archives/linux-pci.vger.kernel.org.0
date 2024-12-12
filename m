Return-Path: <linux-pci+bounces-18343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F39EFCE1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C08188CB60
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89649193084;
	Thu, 12 Dec 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6G0GVFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B218A6A3;
	Thu, 12 Dec 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033554; cv=fail; b=ftCGFHWJCqC1vstJV+oh+b54JDZUOE4615q0YsiAGgPSVS0C8PtnvSxulFj0RqCcvUMd4u0me86VfvoGL85thnXuh3DY8nAYrHX3EhxpBBsEfN+FL28N71q/TkhWZu1lqEQkAHAXG5NbuI/33kPq2f1GcaW+bdcs7ncb0v4hIlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033554; c=relaxed/simple;
	bh=Tfi1ubzgpuni+7NNCHC4vAtKbafzuh6a8nOP7+7xiP0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BU+3HQXFryAJjoJV+EupId1MXPH8Ev0RbaP3APkqnf8BaBhQtt0Ab9C/jPb7QuNmpI5bWC+9W6UhuinOMEm1xQQtK/uL9nPY7h3hgQy7n8vPUFPzp6wTQHRw/RrrLXbGH7sjmy6lVO82hhp0h+Df4S+2Ghy4n200MZjCHxbfxV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6G0GVFT; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwwiYWvuAidX/cmtqPYW6/lnjmlWfd40N1Zg8i2FGmW41W1587l/3TC/r4MogBoBIRT34wZeJJskteG6v9R8oqd6PBtgIm9VD/FGHi6w6zeHK0k5n1YKegYPDgiTWKQQcqE2axmkAL7R6a2hv/vB2XeSdc9N9r3YWF+h7lHwQYK8GRve6OBQhjeQdOj6OE0SYXJYKUKIMa69Fa+ngCdBQBjL4FDv64uBmuL3fUtvSHQ4J8vT1RXpPXTOapRoc6xwUjxeBba/ntUwfOXDLwV2lvsGu0QKNn4LV4YjX/Vef2tJvqZr/1Y0pOIq653DibHMPrSAPyp2ClS7Nb4xvi6lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C73X7cQJLgKK13KzRy4m5qUZfwbFLDuznF3ZbulqsUE=;
 b=A0nYB/GdCyn9PucXXHkdmq9I9POAmXNmX5H9AC16noLQlnJntEIpSYb12AspzxJmKLHZg/3T8+BQistsD7IFWV+3K1a+Dpl5vxxlRpXckT01FL7evVJ6FxxCGVlX1a1P5NYJZmyW3uHL1/giCsCojvpo34DiXGI5A/x+bjci/fUbg1VFPJW9tFHajkYZI6RaT1ZAPOw2LAF8fnkxItpgu4kZWEOfKW/utvpGq1GxCZ42batIGvKQDmCSqFh0vvzsD0PgFLwnv53M7Xb7SpfAZF/mWSOQx3cTx9MZXFOiMJ76VwpMLmn6kVqsEUvEoHwG97Ji5YjKY2o6dZWzgiy7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C73X7cQJLgKK13KzRy4m5qUZfwbFLDuznF3ZbulqsUE=;
 b=Q6G0GVFTUABIjNp2ZrLtEW3+ulb5IuWRi3+N86/0g0+A0AThvPJTO4Irl+8Bc/JnoBFW20Mg8hgsT5jBd+c82x7MkvEgvIMc81tSq93fSNzk6jEdPVZFboKykXyhd1pV9x7zuGTmM1fREYKM3w0/+RhuArYJTEKYb7LbhodiJ/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Thu, 12 Dec 2024 19:59:04 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 19:59:03 +0000
Message-ID: <208e6639-a394-428f-bfe9-a3b8d48d6144@amd.com>
Date: Thu, 12 Dec 2024 13:59:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-5-terry.bowman@amd.com>
 <ef7d45cc-d5ed-4a76-a9af-52c2a423ead0@zohomail.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ef7d45cc-d5ed-4a76-a9af-52c2a423ead0@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 843e4faf-9a38-41fe-ab97-08dd1ae76d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZMVlF5QmZEN1R6TXpSWjU5R3paS1RxNjdSTEVnRnkyWnJtWXhEQjBONVBr?=
 =?utf-8?B?T244TkVMUGJUWGxlSHhqL3JjU24va2k0di9xdVY3Z2FsN04rQ2grQnJObFYw?=
 =?utf-8?B?TFRocnk1bUtaVmZoUVZoSGxtOWpESStKSDdJQ3RBWXlaQ1dDVGh0cjRNV3hh?=
 =?utf-8?B?KzI2SmV6ZFpEanJaRUZTanp1ZGhFdFFBZHRxZUZCRkpRTmxzYlByaFJhajRo?=
 =?utf-8?B?cDhjclFLbkU0cmVwdm5Ha2U3bGFOQXg4L1lEVHZCSTROYUh3TlRyazNWTG1C?=
 =?utf-8?B?aTQvTFZKajBaNDBlb080akVhYzVaV3kxcEdhdDVSaGVKWFZBb1dMSk5jWmJH?=
 =?utf-8?B?bFJJelphUjM4bVRGSldpcEE1NXhDeVFLcUVMcW5DQ1RFWE9EU0RqWVNOckNK?=
 =?utf-8?B?MGhseVdiMEJCRFNUMHJoUEh4QlVLQVNjU1pSeklwUHFMVWI5RVowQmVDT3l0?=
 =?utf-8?B?U3RFdFJZVjhzY0xpR1pTaGJaQlNRM2Z1bWdBQzRaQXhBdmdvVm1FTlpEQWc3?=
 =?utf-8?B?LzJJZG9DWkd1UktPa1BXSGRiRmJRZUpPcFNpVFlKeEx3djdyZy9aY3JFR3JD?=
 =?utf-8?B?cHBCMXNKR1kwd3piM0VNZTBUTmVyVmRiRlF2MWRuMmlDcnlscE1PWTZYd1FS?=
 =?utf-8?B?ZjdyNmhYRWd5V1FUbllyQWg0QitYK2U4ZFBuNm1xako3VXNVUU84TG5rT2d6?=
 =?utf-8?B?SC9GU3BidXBQNWdzeGE5Y0lMNkI2OWw3b2tRZkxUdVRnRUFoVzRhTE1BR3Jj?=
 =?utf-8?B?a0hEVUc1SkxHWUUvejZFSC9ISkhRTW0raTBYdndPYTdlclRNamVIS0NsV2gw?=
 =?utf-8?B?MWJSQnIzbFZEaTg5cGF1eks2VE50ZERnNjVJQjg2VCtrOHJyUVRHNFI0NEww?=
 =?utf-8?B?NGgyNTVOTVdRU2FoV2h2YUw4UXdHa2cwN21LNDdtMFlXVEUrdXpmVWFEWEJm?=
 =?utf-8?B?cXM2Y3pCcnRPUDNhenc1bzB2a1owS1RsTFBsNzZjc1k0TExLUndud29rQlZq?=
 =?utf-8?B?d3BUZUlnRkdYUDZQa0dEc0kxNmRIRWk5VTNwVjF0TkNCeHl1UUVLcnIzM09r?=
 =?utf-8?B?SEtqT2VaTjNnb1NQMXZnWGpvT1FpUGdZSmg4V2c1c2lya2dFWHl3dEhhTFZB?=
 =?utf-8?B?S2FDQUVnRk5VQXY3RHltYnNKMm1SK0taU25QOG1zQ1dLTWxyYnJRVEdTUnln?=
 =?utf-8?B?WlNTNTY0QnpsYUxmMkNhTjBhS01lVUFyVVBiOGNEN2lhL3E3a3dacUY0L1o0?=
 =?utf-8?B?cnd2aXhxNkYyUjF0aWVhK1JRdG4xU1dhYlZIQlpEOWhDcGk1bWkxalBBWWRN?=
 =?utf-8?B?NHRRbkpBODF2anhqWHlpM05qMDR5RjJMbUhjQzZhMkUyMVRhWHpaYlkzb0ho?=
 =?utf-8?B?V1BoMWxpM0dFTERMd3R3OFRTbTdEY1g2K3QvZUZwc29Wbjl0QVZpUWpFWDVP?=
 =?utf-8?B?Y0lJcnpZWVVzcm5oU2VvblFVZGMrbGp6WENwbFoyV1NWUTZDeXJaVW5pNFVa?=
 =?utf-8?B?NnNUM2lDRG9BVVhMeVVuQWNxZU55NG1CQkd0QWRqaWh4TVBPU0VJQ21XSHZI?=
 =?utf-8?B?RDFGZFhnb1libUVIU04rYUlNWG14MWxLM3cxMUFFaW1sYnJhVUoxZldKRXh3?=
 =?utf-8?B?U0lZTnFVb2xWdHkreVVwV0RHT2FNMzhUbnhPSGg5eW1MVUwydEs0QmNOS25Q?=
 =?utf-8?B?bWpPRm41V2huOHE1UXN5aGk2SjJQOENHU05EMitaMWRROXM1dWxlbC9mSkxK?=
 =?utf-8?B?dlAxUDBUdDIxR1ZjT25sazNFdFhPalRLQVk1S2hEaXhxS3VybWtEU21KSkg3?=
 =?utf-8?B?Y25WNytFQ3dLN2pPdk9SUENMdC9XQUlTUG1IVmdVamVYN0s5c3dvekw2SE4w?=
 =?utf-8?B?UGRhamh3RjY3dGhWZzhiRldTRGpnZmd3dEc0RUluQytsWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjEwTGJuQ3FzZ0p0ODZjd2Zic0h2ekNkQzNsSnZ0ek5wdEk1bkNkNFFNZUFZ?=
 =?utf-8?B?Ui9nUUxDUEVPNjgzajNGUVM5RHFsUDRGNlNEMjBlK3FXdmNtbVR3WHlla3Ru?=
 =?utf-8?B?cjEyVlhGQnhGMUxCZzFSN2Y2YlhCZ3dZaG5YOFBEbGtwME5oZFlQOGRyTXlO?=
 =?utf-8?B?SStMenVKdS8wYk5BOTNnL1dvRUsvNzQ1Z1dDWXBhMHRnRUJZMjFuWjFEd3Bq?=
 =?utf-8?B?N2R0dHZnTUl3WTJtSCtBdyt1Z2tjMWgzcmZvSEJuOWtVK3MwczZhR2NhMXp2?=
 =?utf-8?B?eVFvOEVsNFJTMFE4dUxyMFZTd0V3RXY1SWFBdFNCZFBBeExXYjJWdlhpcGRM?=
 =?utf-8?B?ZC80cDJKVGhoc3RMS3VFSHBwNEl3RU9kUFdpaVo0TDRYU0x0UEZCRnpOY01Z?=
 =?utf-8?B?R1BwWGZlalMvZkdzbllneHpTWFNyNFJKSmZUaTRZNE9MZ05oSUY3eEkvUnZk?=
 =?utf-8?B?aHZvOXlPc3d4VldwNHVVRE9BODhwT09wNDBwcWh5L2NLWFcwTCtoN1NpY3hy?=
 =?utf-8?B?UlZZNW1xK2FSTXVFenlYQ2h4UjYxeW0ydUpIWUlEbS94SmJhaUYvTE1QbWVS?=
 =?utf-8?B?aXNNUXF2aXVTRWQyRzNEcEQxMWo5NWprNWNlbld0NHpLMkQ0K0hyQjlab3da?=
 =?utf-8?B?cjZSRFlOYlNCRFVaZDlicUNDQmZHUW5TV3JuWUFqbW0rM0JUam9lcDBjQktn?=
 =?utf-8?B?OFJpSVlvRm5JWWlORzNxL1VaSDlScGNUUkdudVhwcWYrQzNJOU1ZWmtlL2h2?=
 =?utf-8?B?d3EzWllMN0FlWXVWSWdQbkVzMzlDK2ZlTGRSbXNLa3pTVkpoLzE3NmJkK3ZO?=
 =?utf-8?B?N0VxMWc2cy9tUjF4VGdXdEM5dklFc3dIbEV0amErWVB6WXdNcU41VUczdDRt?=
 =?utf-8?B?bHl1aDFKRittZXQ3Q2VwaVN0YlhvQUVKNHdmblhObUxnMzhGK051QldGNjhJ?=
 =?utf-8?B?N2U1dGpsNE50SXFtNTU5d2lWa3dGRDROTkRyQ2NudjNydUxVdVhPbHlqUUJN?=
 =?utf-8?B?N05tL0kyNmFXeUdVVTNJMXBkczJqakl0UzVNY0tvbmtSVnYxbFo3ZzRuWThi?=
 =?utf-8?B?bDRoUnAyQ1VuYUE1UTVhSXhKUUZzRDZQWUVzWWpQZ1NOWG9tTWZMV3kwdTB1?=
 =?utf-8?B?UXcvOUNzVjdjbFllbUoxekxMSHNsczFIM2NoWDNkNytLV3ErN2FEYTJTeDQ4?=
 =?utf-8?B?S3dZcS9udkdtOXdzbGt1bTFvM3VZWi9ML3ZkZ0xzL0hTTFVLY3o5dXJ3YVRv?=
 =?utf-8?B?MWJDZGRPUTdoRTRYVEVXaEd5bnY3ak1NYlc1NnE5MVVHOUx2T1FYeXNoUXIx?=
 =?utf-8?B?K2xvYytSc0REeTJsdTRwVUhQSDZtR2V4bGE0WVV1RVdPV0J2UEhPaU5odTFx?=
 =?utf-8?B?bTJIVTJFMFdiRmVIL2RITDZ2RE5iTE9ZRkN0WHRBdXBWR2V3eGZITUdibFJ5?=
 =?utf-8?B?ckRYRjVkcnd2RTNTU04rdDgvSjV1WjFzNSsvVUR0RVcwUzVKejgyVG8xbGpo?=
 =?utf-8?B?ZGJZT0Z3RW5jOHhSSjBoQzFhOTJ3WGVkdWdyb2d3M1BWSitBL1FUWUVadkN6?=
 =?utf-8?B?V3luM1R2YVRoK2ZLUUhMRGVjV1hMUzByQjhJaVNMc3I0SXZsd0doUHFSY2lv?=
 =?utf-8?B?L0pZNUhvTDcxd3IrMURlZlFMdzRnTlczbm4wa1B1djdHOWlqZkRSVXc5c1F0?=
 =?utf-8?B?RHEwTnl1Y005cnFpdEI2NE5tVG5TM21XR2dQMSswYkJNVzVoWHhDTXRDNG0x?=
 =?utf-8?B?Zi9nRjFSL2ZlOElmcHRzSEhLc1ZPanhucktuKzRXT21EY1hzR0lUSjdGdmdB?=
 =?utf-8?B?czZxUUV6ZWI3eDV0b1dscGtDWXJXOVZ1azVIZ0ltUmRGeVN4alE0OVZlR1B3?=
 =?utf-8?B?ZVJOQXMwQUJkZ1ZNa29XYnNQRzRFK3YzSjc1TGIrZ2lwbitCTCtlc2hNZUM0?=
 =?utf-8?B?Rm1mUm4vUk9sUjV3YjBQN1hlSGxneFpYRG04VThvQzQxSCtsNGRmNWhOZHJy?=
 =?utf-8?B?b0NjV2hhU28yT1dKUmJZRC9ZRFpxSzdodGtPMnQ4K3hPVE1uK2Z5ck56UGhQ?=
 =?utf-8?B?ZldoOEpiZ3dhN3RaRWpEZHo0bG9WUjk1c0Z4QWhUVUZySFNyb2p0Q2V0ZURI?=
 =?utf-8?Q?K/dRxwPOUXoKY2rsokcGQhkEg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e4faf-9a38-41fe-ab97-08dd1ae76d92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:59:03.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3TZ3Cbm7FMM9C+VqKQuwmVEyeC4sLHRWWV1HJxx+A5CRYTMeJS0BOAVGJsCmMuWVHeSuybxyM/aNUlpUWNXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614




On 12/11/2024 7:34 PM, Li Ming wrote:
> On 12/12/2024 7:39 AM, Terry Bowman wrote:
>> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors.
>>
>> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
>> device errors.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>>  include/ras/ras_event.h |  9 ++++++---
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index fe6edf26279e..53e9a11f6c0f 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>  
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>>  	int layer, agent;
>>  	int id = pci_dev_id(dev);
>>  	const char *level;
>>  
>>  	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>>  		goto out;
>>  	}
>>  
>> @@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>>  
>> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>>  		   aer_error_layer[layer], aer_agent_string[agent]);
>>  
>>  	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>> @@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>>  		pci_err(dev, "  Error of this Agent is reported first\n");
>>  
>> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>>  			info->severity, info->tlp_header_valid, &info->tlp);
>>  }
>>  
>> @@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		   struct aer_capability_regs *aer)
>>  {
>> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>>  	int layer, agent, tlp_header_valid = 0;
>>  	u32 status, mask;
>>  	struct aer_err_info info;
>> @@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  	if (tlp_header_valid)
>>  		__print_tlp_header(dev, &aer->header_log);
>>  
>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index e5f7ee0864e7..1bf8e7050ba8 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>  
>>  TRACE_EVENT(aer_event,
>>  	TP_PROTO(const char *dev_name,
>> +		 const char *bus_type,
>>  		 const u32 status,
>>  		 const u8 severity,
>>  		 const u8 tlp_header_valid,
>>  		 struct pcie_tlp_log *tlp),
>>  
>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>  
>>  	TP_STRUCT__entry(
>>  		__string(	dev_name,	dev_name	)
>> +		__string(	bus_type,	bus_type	)
>>  		__field(	u32,		status		)
>>  		__field(	u8,		severity	)
>>  		__field(	u8, 		tlp_header_valid)
>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>  
>>  	TP_fast_assign(
>>  		__assign_str(dev_name);
>> +		__assign_str(bus_type);
>>  		__entry->status		= status;
>>  		__entry->severity	= severity;
>>  		__entry->tlp_header_valid = tlp_header_valid;
>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>  		}
>>  	),
>>  
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>> -		__get_str(dev_name),
>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>> +		__get_str(dev_name), __get_str(bus_type),
>>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>  			__entry->severity == AER_FATAL ?
>>  			"Fatal" : "Uncorrected, non-fatal",
> Hi Terry,
>
>
> Patch #3 is using flexbus dvsec to identify CXL RP/USP/DSP. But per CXL r3.1 section 9.12.3 "Enumerating CXL RPs and DSPs", there may be a flexbus dvsec if CXL RP/DSP is in disconnect state or connecting to a PCIe device.
>
> If a PCIe device connects to a CXL RP/DSP, and the CXL RP/DSP reports an error, the error log will be also "CXL Bus Type", is it expected? My understanding is that the CXL RP/DSP is working on PCIe mode.
>
> If not, I think that setting "pci_dev->is_cxl" during cxl port enumeration and CXL device probing is another option.
>
>
> Thanks
>
> Ming
>
Hi Ming,

aer_print_error() logs the AER details (including bus type) for the device that detected the error
not the RPAER reporting agent unless the error is detected in the RP. The bus type is determined
using the 'dev' parameter and in your example is a PCIe device not a CXL device. aer_print_error()
will log "PCI bus" because the flexbus DVSEC will not be present in 'dev' config space.

I agree in your example the RP and downstream device will train to PCIe mode and not CXL mode. But, the
flexbus DVSEC will still be present in the RP PCIe configuration space. The pci_dev::is_cxl structure
member indicates CXL support and is not reflective of the current training state.

Regards,
Terry


