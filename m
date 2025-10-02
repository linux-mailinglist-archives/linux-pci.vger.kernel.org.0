Return-Path: <linux-pci+bounces-37387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DEBB24AE
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D62322EB7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886742AB7;
	Thu,  2 Oct 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAg9IcgI"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA4286A9;
	Thu,  2 Oct 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369870; cv=fail; b=Q9xK+i+FTRyiBTx5MATrwjlXIwO6ggOd24S8nudCW0lCbRZuMRY04wZv1Mqo5A1yOtE4KOFYwUb/dJoBlshZh0oTpu7Mmx8+Zht2++495QitePolh1EQM1Mp8OANDQM71kBkpWYS/M2R7ZzVTVALxMYlHlB0lAuvh+z3FdGiFVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369870; c=relaxed/simple;
	bh=2NZq7qjvYVhCIrShEL/RCBgpeGT7oXukF9w9wui51yY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7F4nf528/s1CjQCFWd5bPyF8+hb4qh+4LCYZG9ssU5jqMEuWcrJsqB2LRRwIG6M7NKb4jo3BUzvjoQfIoRCvt123Hy02PVtVOIYabuBizO0/ykVMQQaAeDRrWrkVf72E24rNUcFG8zMPVSf4ZHcZLv1uR80nGOcawJ0qpdAcrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OAg9IcgI; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Q0YyAjEaCt6cNl6xNG91VC+IgXDRI3nT7OkdS23AcN6xkGwwd2TsdYou3s1y5m2wrLdvpndGbRkgrPFO93rWb4CYoVR/9itCXMtOJfODmEBARx6zHEJWTlNJz/6BhKaSERxDaNbiP6mHuUCCLtjkpx5CNz38Bok5ls7zdXezAYkl7IxTM+FtoiNJi7dvD3lMlrH2eCKHolrDcK+sWnNsp7BvrnwybH/O6xPvWIt+BhnI6mWFe2r6xkLxYRLW9mMDdmqSUy83sKvLpCd1l6JFMU+VAzm7z9ZzlvDN6KvIv9p3ASzty+k+/tjM10TL9aG3ZqS33GY9si9E8uGPV2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yJD4VVbxyWxS0j9gYh+BzAWZmvVmX87b88KcnoPwyo=;
 b=KK8ZyTMbyDgDVqzkiSDalCOz5AD6rf945FsXe3hz+i8ILpdmDn2kWDAUZGZBmg0PL8U5UXOoAhEPdZO71LaIy0Z9tUO49TUvyF7axKuSx0DYpUpQHr2cEnkWfbR2Tk5NBuqc5GBSkGT8Cz7yeJd755z4K/jO6LXrWXKrLAzOgU3WwFdn4DAKOjdkGyk5bfTA/AgM7DY6y5NHjzwV+ifHIztq3XPwTSzaTsAPzf+AmF13/vedTCaC1z9IYpceo3z6Xsh58Wt9aUhfdBSNttAZqu2HTvZHmaEjBPN22/hC/SXrVDC75qoyUe0w78oAhQinmO9nNhzBGdaDdtf3Tqfz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yJD4VVbxyWxS0j9gYh+BzAWZmvVmX87b88KcnoPwyo=;
 b=OAg9IcgIlkeZ0YwNuDDR9pmPAL0K9Tc+8svse/5ejFeRVqvg4oRYm0ULUQi05fJ7EVenmZKnIkMGXFd8yaCNPhAP5qMUyp4j/kZ6NNIcYrcynZMBsp881ZrvfLqajIK3gGhTrb/Icyy0QvLDO/qiiO2socAA6kCiY5isTWs/AoAKrN4VAeafFQuuUWzwytwVLda/YARXd737HsHe4+v0YovRoOjO12WBogX4l1jGMsg/WSiGto5uLb+9X5zKspeYTgHR97HM7Ahk15bDeUaNDrUaT/i1NBOsYR9rgo6SnBtMCIoaiDkfccLNcCjYSP+mzd+jXcfvXKmLKcJV+kWONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 01:51:02 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 01:51:02 +0000
Message-ID: <643653d4-5074-473b-81eb-149110e9bced@nvidia.com>
Date: Wed, 1 Oct 2025 18:50:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Alexandre Courbot <acourbot@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <DD7GERKWFHB0.3919YYC6AJA2P@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD7GERKWFHB0.3919YYC6AJA2P@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 48648ca3-a21d-46a5-14c6-08de0156245d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDVidnJJRTQ3TlF0ckxQY2NkVk50bzE0ZzgxVEVvbUJYd3JqTkJsWEFKdU5N?=
 =?utf-8?B?ZlhuR3VBVDhRNlA4UlhwQWZ2R29mV0tFVDBYOWVvRHZRaWt0aHhVakQrSnA3?=
 =?utf-8?B?OWhua2tNR3lITWRvV3ozRHdQYmY3ZUFISEJkZnNzMGdZVlo3WjR2eFl6ejVN?=
 =?utf-8?B?dVhZVTdlR3NyK2t0Ry91Mm96clA3N2Jjamh0V2RLUXRxcWVkaHRXMG8zeU0w?=
 =?utf-8?B?ZXhSVk4wN3lvR0pNVGwxSWlCeVRVS0c5WHBkWUVsSGROSjBySTZPWVhLZEFq?=
 =?utf-8?B?UjZralh6dDk4UGxJTWJhaEZvbUFKY2FjdHVEcEluNW9sSlNtbzdGbVhXWFVj?=
 =?utf-8?B?ZXNlTFYycmM3ZlY3dVpUZUNEcml5V2dtQ3o0aFZVT1kxNFk5c2w4VllwL1Np?=
 =?utf-8?B?ODVQZEdjckx3Rk9hQ1FjS1ltRlk0VWV4SzRucTczeVFnT3RGdEZONkNDdU40?=
 =?utf-8?B?djhEUmN2bGdmS3pFL2FvZGk5VzgwL2cveWowY2lmRUZ5blh3eWc5K1krZko2?=
 =?utf-8?B?YjBza3d3aEtHWFl5ZFpHNldqWHk0c3ZRU1BpMSt1RktEd1NBdlpvVmNZdFdy?=
 =?utf-8?B?Tkp5NFdIYXZ3ZU84eHBIbjdrT2NJK1dXeHJrRytHS3NaTDZ3b2svY3BrbVBB?=
 =?utf-8?B?Sk13SUpBMFpIR2F3VFVBakJhY1lPeEFUcFhYd2xLRFFUdnNFWjJxWWt6dGQz?=
 =?utf-8?B?M3RxMlowVjJSMlN3UXJwbXhEakV1ZkJMcE5MRFR5bml5aFJRUjlKVllhbVBj?=
 =?utf-8?B?REtFRDQ4WDJPb3VPZk5pODZmSXE4WUxXNGQwV1d3VVVzRll2Rmg5L0NmYUpo?=
 =?utf-8?B?NEcwWVU4MjBJcytId1NZN2M2RTVFQ2pEWHJBR2NmeHNESWpvb0QrcVFQOGdE?=
 =?utf-8?B?YzM1K2FJREc3K2lYc002d3NHUWtmdlB2YXR4cjdjTTFKaFJZL3cvMG1JRnBa?=
 =?utf-8?B?MW5OMjdzcGtjb1psSHN4RkJOUTJuWnNYQXZ2NE53M0phdW9acmRzYXpzb1VY?=
 =?utf-8?B?VHR2QjNoRndvaXZ0TVZhR0FWbk90WSs4MER0QWlXeEpHeDZBOXcvSHJtMlZw?=
 =?utf-8?B?SDlWRlYzQnM0UlRyc0ZEUDNob2pKU0xmREV6RnE3MFprTzRpUDc2NmRqdDdz?=
 =?utf-8?B?OFltS3FJOW5JL0xjTlFaV1dVVk14OGtnclFvV0REWHdEdjROaVgzWC9IeUxm?=
 =?utf-8?B?M0ZDY3Q0NWNEaCt5Sk85ZVRxeUVkWlBMT1lKU1NtTzdqRXJ3aHBTZm12WUlF?=
 =?utf-8?B?Nis4Y25kWHJJeTdUQnNFK2xHdS9EbkJVbHRZb05ybklhRFZEeWhwOHlKSXE5?=
 =?utf-8?B?T1ZwSlM5MWdhdUVna0JVZkZHdWRtZ29wcmVISysrM3JRTXVnZWRRdWs3SEpQ?=
 =?utf-8?B?S3IxSThxR0hGT3lNNDdOOXFCM1RkMnhqTkt3VE1GenBpdThkeDlWbzNENS9y?=
 =?utf-8?B?d1Q4TTZVd0kxVzI3UXN1SWVMdDIycXppUkl2alNDOEI2ZTNxL09RVkZidWEz?=
 =?utf-8?B?dnFNdkxnOU10UkJjZEQ1L1I3bmlKK2o0QlhwRnJKdERoMWs1QmRUamY3d3ZP?=
 =?utf-8?B?Rk5aeE9hVnlxUjA3TFkzc1AyK09GSXQzNWQ1Q3NSQkZKQTdIUHBjR3NHUmth?=
 =?utf-8?B?MFd5K29CaXFIcFo2OGd0Q2dndHI0RFdUOHE4NWFLbXl5em1OK0ZQMU1JaWZ0?=
 =?utf-8?B?WVBJV2hLVE5QWnp3SmkvRDFOazBYU0hXam40WHFEMEdFUERmOGUxbUxJb29I?=
 =?utf-8?B?MHdvTysrQ1RzQVQvUnFYc3puODFQcmh2QWpiZDIrR1BVL3JEb29kWjRUUFJw?=
 =?utf-8?B?ZEhhWlozNEdQOTRhbVJSR3JKdzZVZ28vSHB0cXhoSGJ2S0JXYWZrbGQ0dVRs?=
 =?utf-8?B?Q0c0eEk2ZXBTdDV3Um1QSWJRdUExSVE0ZUxWMHBKR0NFd3VaZHFpV3lnSzBG?=
 =?utf-8?Q?tjYKkD1hWoJBh/mCzbdMI84orl64foGt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWpJOW5pSXZmMFBFM2VFTHgxbUF0SXJ4cUhDUWo2bnhRUHZweUZYclJlS0U3?=
 =?utf-8?B?UHhoQUZ0ODFRWWlCdWtERURsNXFoY3FWRTR4Y0twdndIaEFwRUdyNFg1eFI1?=
 =?utf-8?B?VnV3czdLSDBpUkdaMngyNE1oOW1GTVJLb1dTQ0JWcWlXdHBPdkkzVVBYM1N3?=
 =?utf-8?B?cFd2S3c2K3JDbDZCNEVtVU1uQlAwcytzcklGbFB3Smp4U09xby9PWkw4VkQ3?=
 =?utf-8?B?dFZ5ZWpPbmhXZVRIT29EckZ0QkhvaUpZSW1MU1ZUdEN2R1JSL2FwaHZHYUZt?=
 =?utf-8?B?bEFMYXVOVFcvN25HSW81MXN3Wk9HMEQyV1YwZmlMRmx1Zk5ZOHJabUJBaTBL?=
 =?utf-8?B?MWRodnE3UGMvY0VPd3ZYSGRvc1hjQUdMTDdKTkpZak9uNk9xYnhucjlwMTlZ?=
 =?utf-8?B?N0tvMmFyVTFGejRTWGIxWVNzUm5EODZHdjg5ZjBqU2hNclloMDI2OUg1ZjJS?=
 =?utf-8?B?cVFtSjFUaGNVWmY2K3BpUm03SlBieVJUcDZwVXlXQlpyQ2JZamt0cXhvN0xG?=
 =?utf-8?B?Uk5ob1lBKzgySm1XSDVwa3lnZVJoNkFJTit2TmJoSEpyQ1V4dXFobEY4eU4w?=
 =?utf-8?B?Sk1JRmIveEZvNDh3MlZZbEhEdlZhRlNQY1JjbmdTV1MvbmVUY0Fpa2tSN0ZT?=
 =?utf-8?B?YitoRWlZSHdtTUpIandLVmRTNU9yWXBQTFZHOUM3WXF6RWEzRHRVcUw3M29p?=
 =?utf-8?B?WitjRFFPaGpPdHRlL0huN0VBMDBzd0kyVmd1dmQ2cFZsZFBjekg4YU41YXBW?=
 =?utf-8?B?VFI2N3dCcUdSdkcrb3VnQllLUkdRNm0yYjhJSEhGNmo5ZElON0N1WXdZNmtp?=
 =?utf-8?B?eUpxZ1BZejY2ZDFpSEluN0ZnWHNobG0rd3hBdHdocml3d1F1RzVjNmVsVUNt?=
 =?utf-8?B?c01saUZBa2IwWHNMS3ZjdlVPRk5EMG8wQ0ZKdElzM0FXRkd2L29TMmVQWUdh?=
 =?utf-8?B?aXBPOXJiOURtemIxSFFLU3FMeXVmUEFpNVdBRXVHcE1VUXl3RHpITkZNckkz?=
 =?utf-8?B?OVZPRllRKzVidExEUG9jS1J3RUE0QlhRTmNlb0xqcDJLRGM1aVBabWg5ZlBu?=
 =?utf-8?B?OFNKODVCSmpNOTVmajBiR1dJU3NJZkVEazZSdnNqcEJFTDBHbU1jOHVOVzBz?=
 =?utf-8?B?TXdGS2Z3eEVXbGlaRlNTdDNvUy9wTy9aVzMzbU9LeVg1SFYyMmFDcUozVklt?=
 =?utf-8?B?QWpvL3ZHeWlOUlQyRlh5cGFkRGw2di9JTDRNR0h5cG9kbkJ4bFBtaEFFZmdu?=
 =?utf-8?B?cGhNWWYzUEh2R2M3TFNXMDhSbnprd0dEMWxDbXRUVTczRWZpNlhXbzhOV0JU?=
 =?utf-8?B?UDFqZGdWQkEzYnJYZ3VUUXZoRnI4NGozd0k0aFhmY3RRbUdrb1lNNmN3OWFT?=
 =?utf-8?B?blZTUFk1NWM4NlFNc21CN25keXIzdDV6M0NONGtFWjJ3TXJwaUdQWHU0Ly9B?=
 =?utf-8?B?aDZXL0NDNHY4M3YxWG1rRXBFYmUxVUlkamxMb2RjeU9sYUdpYUpNejR2cUJn?=
 =?utf-8?B?Y3pJZnRrcmQzOG1RWEh1bGF6aHFlOGhncFQ3SUQ3QjFhZ1dJcmZNTzZieTRi?=
 =?utf-8?B?Ym9FUjdZRW84YjN6bkZ2Rmd0eHVUWmlUbnptcEJ5dm9UOUpQVFVoVnRqOUww?=
 =?utf-8?B?b0F2M3FINWViOW4zWHhZdnNaWmVCU0YwTkY2ZHNRVVJjTXd2NzVkMEVlK2VC?=
 =?utf-8?B?RGRlWjM5ZjZvM3dVYkVIaU0xT3JmOWcrS1VOSmM0M1BqNnhYQlRmeUpOZHlY?=
 =?utf-8?B?UUNVTmNpOFNJVEt5RDhhRGdydS84RkVya3UyY1ZCRm9FMjFTcS9CQkdqM0ZP?=
 =?utf-8?B?VkhSZm1HM28rdE9lR0VQUjNCKzZWV0RkUUFHQlVqYUFIZGJxSE1FSWtNeXR4?=
 =?utf-8?B?MVMzdTVMT2dGU0VZbW9OM08xcnFUMXRGYjJneGUrNjAvbW1ZWmFDVjVQVmxF?=
 =?utf-8?B?N1l6RmhSWjNtalFZNUN4NkJIM1drQzBDSVdrSWNzOHJhTSttUDIxaFdzY3c4?=
 =?utf-8?B?bGFHQ2N5cmtQbXV2T3lhTlNUUVdXQytmbVRrb1FLMHlSalNRMlZldm9ZSERL?=
 =?utf-8?B?bWw4WE5HM1QyYUdhSWFOQ2JvM1dFMk1leEhFMXVrcVRKVmZyVSt4SUZXMXJh?=
 =?utf-8?Q?hSDY3ID5shkktyXRk45l+8md6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48648ca3-a21d-46a5-14c6-08de0156245d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 01:51:02.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t7nyAuzkNB96NQFf2Q59VGRzYklBdOMjZ+Vq/I73wojOXZnAPVCviaU+hwjokgUgOJniGudHeCohZIu1lKKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

On 10/1/25 6:43 PM, Alexandre Courbot wrote:
> On Thu Oct 2, 2025 at 6:13 AM JST, Zhi Wang wrote:
>> On 1.10.2025 17.48, Jason Gunthorpe wrote:
>>> On Wed, Oct 01, 2025 at 08:09:37AM +0000, Zhi Wang wrote:
...
>> Right, I also mentioned the same use cases of NIC/GPU in another reply
>> to Danilo. But what I get is NVIDIA doesn't use bare metal VF to support
>> linux container, it seems there have been other solutions. IMHO, it is
>> not mandatory that we have to support VF driver on bare metal so far
>> yet.
> 
> For my education, what gets in the way of supporting a VF on the bare
> metal if we already support it from inside a VM?

Synthesizing a response from what I've learned here:

First of all, the PF and VFs will probe() nova-core with the same 
device ID, so nova-core will get multiple probe() calls for the
same device. That has to be handled. (Thanks to Joel for pointing
that out.)

Next, for actual true VF support, nova-core will need to "provision"
the VFs, which I have learned involves the following:

    * allocate vidmem (or "VRAM" in DRM terminology)
    * set up compute quotas
    * configure which GPU features are exposed


thanks,
-- 
John Hubbard


