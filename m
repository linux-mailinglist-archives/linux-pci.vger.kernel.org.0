Return-Path: <linux-pci+bounces-27064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E9AA5D72
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75904A0477
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0A42A9D;
	Thu,  1 May 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5PoIy/Th"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF622AD32;
	Thu,  1 May 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746097105; cv=fail; b=tVulrDm09qGpKKpejohq2O5QKOxWpSpUJ+MDxkDP5oy8l94FsZI+oOnodZFfyBaSDLPJpZLpKl6j3Def/s1iaJv/Avx/zTczbHIJLgzznidhsNWCIZFcZcgVval5/UJ8/w14XoSKkFEtNO8tEIP7uc2HE3sKusvrZGXm0n2NWHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746097105; c=relaxed/simple;
	bh=pM0EwEbg+UZ9AAAqx1lwqPfCPqQmxn2mkGrRdnfRKtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZbIt7M4/Bb0VVDK0XUzU1p69TINwW6sVJP59FdtdEWq1ZaNmy4nmAj3zQKFgEhwn+S0nm8bZOmq22rPK+EyPcS2VBuFuxHewqnopLFtIxNmyck7f2Nz3nR7JlUMHE6sZiznxcV9WX+nyi13fZxDMOYFZtJoagAPB9UG9ypeCfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5PoIy/Th; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW3dzapYnR1Tg47aJBGu8ZQSkCh9QmuPhF34zjjdlYIN0ePTDxiuz/SlOq/81EcvuGnlAktTh2GB9tHGyLyfKjqA3lK5KFAGtldacdDG07bizA2HcMjEVUy3zxvir20G7vmg4JAvSXmeLvNWsPIBhhf0RwNhQUg+eta7Od8qVP3eyDGlOlnHbCxpeybPdhZKGCynfJtfwneKnm8sMwKm5PkmaHSbexp0k0Scy2rYRO1rydmE015cGNvlnYpwyBe7fVdGjnN952gl6LeI4lQvg6slSVcYWLXLuBDV+nyCe/lwyIPF2/rQQuXA3+5URps9oM11YNB8W7O3/s4A63M/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqayPd8Ne+wnUB3YCWmUk4mqorhYrNPNU2HUOxHOJpk=;
 b=T4TDk765DF2g7gXklH3K1oPNHU+XlCiU3uZGXjVuIG4YEGBbqNda1HPu8Xy5eN3JdYj/T7kSJAsR2YMQjps1eKM0d5Qo/B1pVj44oDkmroAazUcURHDR6ofgn5sD5Iwy6Ul0DUut5YyvZcyqMlhsxrkY4vdtZa3Gl/3PFUQrnU0iFj/vS3/juoj0ByDr38+5JfH09yDb4M38sS5aq4ju2YzHHtGAnb+NF/xAqskpHV23YqbGAlAlAGc+ng6uTPCdebjIKr2VEBLWQ5vswQ45wnQj1A1eOPb5psVeUslBwvwJJWwq3XFcmhKjU5DsUzi8fvbKvzIoSTYjHqCc14v3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqayPd8Ne+wnUB3YCWmUk4mqorhYrNPNU2HUOxHOJpk=;
 b=5PoIy/ThVF1SLWkX+5owk5I5A4NrIWkerujmXm/2a5K6BHK5GgnyBXcTs22j/tLLq1eNwvTCgxqxHHYhRuS27ZC3zcvAR04B8ylH4WUtfoutNlndxHQSb6s/iUd7GJtfBYyASSfbsqUuCY5/KO5xH2SRRpiOpKoXvoui31vRaq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 10:58:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 10:58:19 +0000
Message-ID: <85cab331-d19b-4cd7-83cb-02def31c71ac@amd.com>
Date: Thu, 1 May 2025 16:28:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250430025426.976139-1-tdave@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250430025426.976139-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2271a78d-f077-497a-eeea-08dd889f1553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkpSaFdkcmVOamNOaDIraDEzd2JDRUR3RDExZ1Rxd2tQNDloSmFHVHBjNWly?=
 =?utf-8?B?NXF5cy96NmttYTlwUlo5WFhOeFpLUnBHWUVOSjFITGRqeGxDK3VjZUMrTFNq?=
 =?utf-8?B?dGFLVktmRnFjczA5ZGw0UGVyek1XQVFpcndPNjRvdEhabVhtZ2xtUWRFU0NI?=
 =?utf-8?B?ZTQ4UEpjZEo4UzhnVlA1YitmbVBWK1VUZ3JLWHhENXlYMjkxOHYybE5xVkRX?=
 =?utf-8?B?YUcrSHE0MU1iYkVlcmM2YWNsY29BUC84aUY0V2puOHJDTW52aUNjaFkrZ3Nh?=
 =?utf-8?B?b05BSjAwWEd5aGtTQXpaU2J0RWpPVUhSL2ZXMGRxUk43ZE5OWTZaMTgwTjhv?=
 =?utf-8?B?TjAxM1NEM2JtenpsckY3cjVLNkhieHBKbFd3dnd6WnRpWkFOY05kdG9jRjJu?=
 =?utf-8?B?TmRLak9OazUydFpWWk5jZlNBZkhadWpnSVF5emxFaksra2wzK3pLWlpFSTFv?=
 =?utf-8?B?VUpGeGZrSXFTa1YxR0sxWkpmTTdHMytObitQcWpJbXAySzFWaWRJdXNzL0Fm?=
 =?utf-8?B?QUg4akVVbUJGOVZiNVNBUDRHT2Uwb1daT0tsdERKc0JlTVZpK0pqbXpyQXh2?=
 =?utf-8?B?RkRGUFZwcmtMYVh6cGQ0QmI1MVhMM2VjT2F0a0pGT2VZaTA4ZmlSdUUxS3hp?=
 =?utf-8?B?cWZrNHJsYnBhQk9UdWNSOWNyb2I1QVZFY3lRbEgrdjRpTlZDcWlhYUViY2kr?=
 =?utf-8?B?UURyclAwR0lNU2kvMnhlOGhhTlBiM1pNZEpPQ0xZZEhYblRKNTIyWnBIRkR5?=
 =?utf-8?B?NFJPRDdsMXh6QThJTmR0a0VRZC9pN0g1cE5XOS8vbFZ6eFZlQjZjWTZ0eG8z?=
 =?utf-8?B?QnBzMW9MUkQvQUpzY0xzbFo4QWRzMUpKdUlwTHJkRlVLOHBTZXBrdXM4cGNG?=
 =?utf-8?B?Y0hoNG5vTVkrcUh4cnJ0bVVldGNGZHprZkZwUHRyK3VZWVhDa1NLcHZYaGVG?=
 =?utf-8?B?QVA1eklvRnJHMDNsbGF3N042UEZjR2dsMmNNS3RQaTFadVJrangydjFjbDJs?=
 =?utf-8?B?QVV3TjJjQk1zdlluRnkvL0N6U1hWYlh3QXN1UC9nbHA4eFZXb2lVMzBmMkxN?=
 =?utf-8?B?eWJpbmRURXpnVDdTUVNXK2tZWjhGOVJHTXhmSkpPcFZVcThKeFZxc1hGZ3ZX?=
 =?utf-8?B?Y0R5MnhUSllMZERGNmVzYWtkN2tGMHBlL013SmRhV2wwLzFpVWQ0NlBYTnlh?=
 =?utf-8?B?emlyNDFqR1RqQTZQN2RvaUtKNVJWRGoxUG44SzNlR0hTazk2amVoVGtMRm5X?=
 =?utf-8?B?QUsxZEl2YTFDMEU5SDZsMkFPMTJwMStPWEVlRC9OR1YyWnkrR1NsVHVUSndM?=
 =?utf-8?B?RXZraEtWZVF1UlZYSEdiRHUxZGZsY053UENWcnZtMnpMc2VaWVYyVG5UQjNx?=
 =?utf-8?B?SlRuY0R0UHlFWWkwUS9YZmREQVhreVQyR2Z4K3YwcjFEeXY0SVkyVlVvWlZ2?=
 =?utf-8?B?dVAwcG03aWJUaVZacURINExwWjR3ZE1hT1Q1REsvTlJ1cmRDUzJoNWY0Ri9L?=
 =?utf-8?B?VzJENmpXRittamtVY2R4KzdnOUZ1ZXFGRHpFVEhpa0xmeW00ajdkUXpmRlhH?=
 =?utf-8?B?SS9sbHduQncwa0R5ZVAwd0dka2tkWU9PZjVFRUdiNEU3c0hKVU5tTzVHM1Vj?=
 =?utf-8?B?THNIdFI2bGc5dVV3dkZqUHR2UWRVZDczREh1TVZIbEZlUWZjMllCcFRrM2VO?=
 =?utf-8?B?ZGFLd2dzdENVZHdYZktGRWZYZTFhUGhNK2I0aGhJbFVScUxrd1ZEZjRvaWNp?=
 =?utf-8?B?T1RTOXJtc1M2K05DMEI1Vk5iUHRMbnhmMk42UmRvNkxGN1RXMkVFc2Nxc0Vv?=
 =?utf-8?B?ZVFwTmNiS3ZwT1lFcDJ0VVhNaTdVQy9LSU5sTGxOWFR2M0RqTlpRNG80ejdD?=
 =?utf-8?B?VFJ3eFRGU1NaV2R4NXgzOHI4TTZMRVFCOUZBeU4vd3Q4SjBxbmlnUHR4ai9h?=
 =?utf-8?Q?FeO4IqU4PCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW51MkFTek05UFdiSVdkVHR5b2g3bkE0eTliWmRKV0lPT0RtZDNpZUhEdmFR?=
 =?utf-8?B?NHdPaFVMZi82bkdjZ1JCODYzdEY3bTFpQXhwOCtzeVovSm1zOTQ2aml0S3VM?=
 =?utf-8?B?YjZmdXgzRVVvVDFrcE16Z282WjNGQzB0K3NqRE84aGZueERpOWtvdnRHNDNO?=
 =?utf-8?B?cDhocjdacGd4ZXk3RGt5ZkdyNENxYlpxMmRiQWRKZncwYThjN0tIVm5zWS9o?=
 =?utf-8?B?eFQ3SERMODA1Qkt3R2pBOGVBbE9GVjZDVUhTSXE0T2NpMnJSaWlwdG9lYVlP?=
 =?utf-8?B?TllhY0puZ0o4cVl4ZEhzUVpBUFBUdXZ2S000dU5oc0w0SDZYeVk3ZzRVYlBT?=
 =?utf-8?B?UFg3bjY2azJrbkIxMnN5ZkE1dnJ3VlBVejV3ckw3TVMxc0hoV0ZRREcrNzlE?=
 =?utf-8?B?OGRVd3loZ0lCcW40ZlBPUzRpaERHY3BDaXFOVFZ4QmE1N1FiK0lxRVV5NEM4?=
 =?utf-8?B?NnBqcTd2QitGSEQ5cEZXeitIK2xqdHpjMkFINkdJTzhSUk1GY05qWmRwb1h5?=
 =?utf-8?B?eFRtZ0l4SjJRT1A3V3QzQ2g0MzRCWGlhOGZ5RmNhU3VRc25xK0wzeldIRVlY?=
 =?utf-8?B?UWpGcFpJajFxRXRxUnUzRlpWRnRYQ0M4QXYxSnlkczdnOEVBUDNLS1ViUzB5?=
 =?utf-8?B?Ynp5bFlJWk5KS1c1NTB3ZlF6Wm5nUjhQWXNCZkpCc1hZOHJLSWJyMjdlak9X?=
 =?utf-8?B?VzlpSTBCM0UzWEVJeFMxSGFkc1FoK0xWL1AwOFYvMTFoa0xwNXNXeWUvWWxN?=
 =?utf-8?B?V3NXNXJrMGlqNGhFL1l4TkZ4MnlXMWVHaVJHcWxiaHgwOXhBbGNtd1FsaDBK?=
 =?utf-8?B?eGNCK1NXMjl6ejJLZWRrdm1vclhWdmw4ai81bkJYR3ZsUlVHeEFjOFhRYW44?=
 =?utf-8?B?YUZMTWl2T0hCZlMvSTdpcFF1TTV0aGZ3RXYyeEVFenp3Rk5rSGJ6QW1MazhP?=
 =?utf-8?B?Vml5UmtkaGpEdG9nd3JxOEhwWE1PM1BXVlJEUTZ6cVBGMnQvVjJmZ1pLNEYz?=
 =?utf-8?B?N0VjanhVaGJtU2x6Q2NlSW4vaGMwaWFwaEM4L25YbU01R0xpN0EwdXYyUFdH?=
 =?utf-8?B?OExNc1R1SjVhWnVFUzdPYjd6a21pRmZCTXVzUzE1dE05aVk4SUx2WVZvWDJs?=
 =?utf-8?B?MUFCdDM4eks3a01mVkRNSEtKTG1qVzlHZlpjNHpFLzJmVFVUbk93Y0ZlT0NP?=
 =?utf-8?B?TjlpR2xjM0lOeDNiaXdxbkpOL3d0TVlzWXRKQnJaT2xsN0oyZkxZdjBNT0tC?=
 =?utf-8?B?TTNVYlR1TTNjVUxVQUJObk5IdS9Ydjh0dGpWODZlMzg1K3JIYTJEZkYxd2c5?=
 =?utf-8?B?b20vRkNQeWdnRFVka0wzK0tTdk9FNGVVSlJzUFB4eFBsQjE3WjljTUQrT0Ey?=
 =?utf-8?B?Nmx5OENQR3JXQ1ZUKy9MWmpIRnJETm5FQVNmb3pURGRqM01hMjlJYVllWEQ5?=
 =?utf-8?B?dE51VmwwV0ZNUm8rUWhpcEZFY2xqVkdiL1RVZy9LaUNJVWcvNmRvQlh2c21B?=
 =?utf-8?B?eis4NGJYSGtyQ2lOR0NhMkRCQ2JvSlpleUM2S3QxUEFlZDVsMjcrTmJaeXda?=
 =?utf-8?B?VWE4LzBlT1hhdkt0VWFjMkhxTlMwWVQ2bDZqMmlQalE2RzREZUNvcEZMa2py?=
 =?utf-8?B?N2tKTFhWN1prelZyOFJ1QzRtSU5qbEh5RlNqRnpCQzZBWlpWaGpYZWVBaEta?=
 =?utf-8?B?MzZLRjRZdlRpWEt4WXNkK2pWaWxrcHpTQStpajFVUnlieHQzcnh1YkdxSDNw?=
 =?utf-8?B?ZkZXOFRrTHVjNlh4a2NHOFJlRUpsMkNXY1Vkd3VuYWUxeHFWU2RYNFFtZGpr?=
 =?utf-8?B?R29IOTdFVlRobU03blJSeTFXNi9BSU52b2FHUDFYUDhrQ0FPcktFWTJoRFdZ?=
 =?utf-8?B?NU00NXZIdmNCMDFrbVJpRDZKSUgyalF2aGZnU1prK2krS29qenlISnVEQzJ6?=
 =?utf-8?B?dElHSW04cldhZjBWcTRUcWhIb1dNVTE3b0h1RHpsemtEekQyTWtjelNRNjEz?=
 =?utf-8?B?ZEk2cm1NMzBNbnBMc01XUlhELzVxaExyelJqL0dWWmRVWVVmTG9Ua0JoZXM3?=
 =?utf-8?B?YkxzSTgrazZWalc1d29nQStqckNzZExBdTdkdXpMc2FBaVdBdVRCK2IvMGJV?=
 =?utf-8?Q?JUkz/j+2Bpd0Es8OpnpTwKMFW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271a78d-f077-497a-eeea-08dd889f1553
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:58:19.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAZyz8GrA52vEEtIZPfQG6ed35nYURYO2iTVv4utO+Sr6XpBgK85VrcM5x58OFIe1op+zGiDQHBaX99Bb8Ga/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

On 4/30/2025 8:24 AM, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
> 
> changes in v2:
> - added no-pasid check in __iommu_set_group_pasid and __iommu_remove_group_pasid
> 
>  drivers/iommu/iommu.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60aed01e54f2..8251b07f4022 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3329,8 +3329,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>  	int ret;

initialize ret to zero?

-Vasant

>  
>  	for_each_group_device(group, device) {
> -		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, NULL);
> +		if (device->dev->iommu->max_pasids > 0)
> +			ret = domain->ops->set_dev_pasid(domain, device->dev,
> +							 pasid, NULL);
>  		if (ret)
>  			goto err_revert;
>  	}
> @@ -3342,7 +3343,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>  	for_each_group_device(group, device) {
>  		if (device == last_gdev)
>  			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
>  	}
>  	return ret;
>  }
> @@ -3353,8 +3355,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>  {
>  	struct group_device *device;
>  
> -	for_each_group_device(group, device)
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	for_each_group_device(group, device) {
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	}
>  }
>  
>  /*
> @@ -3391,7 +3395,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  
>  	mutex_lock(&group->mutex);
>  	for_each_group_device(group, device) {
> -		if (pasid >= device->dev->iommu->max_pasids) {
> +		/*
> +		 * Skip PASID validation for devices without PASID support
> +		 * (max_pasids = 0). These devices cannot issue transactions
> +		 * with PASID, so they don't affect group's PASID usage.
> +		 */
> +		if ((device->dev->iommu->max_pasids > 0) &&
> +		    (pasid >= device->dev->iommu->max_pasids)) {
>  			ret = -EINVAL;
>  			goto out_unlock;
>  		}


