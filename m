Return-Path: <linux-pci+bounces-18697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E79F67FC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EED16C10A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75193F50F;
	Wed, 18 Dec 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XRfNlhx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E715A856;
	Wed, 18 Dec 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530810; cv=fail; b=G1aJzfK9csIKaC1qCvMYxG+MTNQA9jnnIk+rMXJRTdHkbRBknb1r2nS41LH9U0Z/FnqhywG8xKnIaUwn6ki5puAV6Q69kXQkm1OMwnSVZ2mQKYyIqG44CKGoPt9kiHFO7mnI85mojVekxpGjTZz8lSmuMbJEwzgf6BylCBeKYaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530810; c=relaxed/simple;
	bh=1maKstUwSuznOSyV20nIm/3MlOYs3hZUbjs28XPqeJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+Gkv6VWnami/R7bc1xeq+z16GURRE6DcSEQBCsoDXMvne0d7oAkSsQBEhNdyv20oWnh2czbBkpvM5wHWXsBYfG5NWmEeDjbROmo4DnffL7uLh/syLxSTfKNOTTDQwIBC5NMtzwt+SMGR34wvBPx0XAUSLn2zp9Mg5JYQEBVEWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XRfNlhx/; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB3VcVqcJfKsB/pLhi4lRVjfwPAgXZ3WEO/qgegOQc1avSySLZS9SOPp8jwu41praLcJjdA0zIyCNXv+QNcMa96sxznFEjuCVh4vsAufB/85q5SDydUduOwgGc3tA6RTgEyCwyMJ5UJsMsR27qzcenFOm/6C8yIIhYT3Yw2asbBLdPH6lo85JsCHKdb02OrXX8hxHaayyGRyXDEalwqFvJWXBpKfwUiNNa79q8ArLcfpOuU+bybx1Yfl5K5hapA7alch8aQTYyQ7AluDvHFmiAdkN1FpLC6xJFMmPrWlgP6J0LrqoMffmVFWNGihczFo2Q307TcGyXmiz4wv9LkX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCoe2j9sewp5cOE+YC66REwWy8JYbdin5bbmANlUW3E=;
 b=WusgnbuLjpzjWzC8KhvAH36aFyLfXWYEqepM4HeEi6KgQA6wgCbnP0CdXlFJ0cFQvRWHr617mxuXWI4HnBAkyPBjp2dqbyJeVDWXf52v49kOS+dy4//Ldf8lMXfSh9hjy6kpjPBKsTpbpwqejRbf4pJ/YwIaO41LJNJwH2Kij+sxzqZUEZHqJUoqoPZg664rd1I9kWKjXUybm/En1Puo3aehK7CawkUkBxawC6Ggk8ehv+2iqw/yEKmRQ4hU3Tn50BI1+jW/dMJs0kK/qOi0vz3hPPsH8LfMyTKEzECL5pOlXQir6hArcN5d3TZQF0VYl0pNnzEf1SWCKoQqQvVxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCoe2j9sewp5cOE+YC66REwWy8JYbdin5bbmANlUW3E=;
 b=XRfNlhx/bMGJJ8xyuaOt3zWlN4ZiAnEYMdv2YsmasqoncvqUcEWdOu9Yhs+6/3L7eMX4MuK8VjOu6GxFOdRSV/roj7ZSqJxDrFSokiFQuY9EtTa9kCbaRS+hBPa0p3vR+5nv0KFmYUBgYJ3jcksquolA/hoorVa29sVtn1DcYH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 14:06:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 14:06:46 +0000
Message-ID: <85537504-f107-44aa-9b6d-f61eb067b330@amd.com>
Date: Wed, 18 Dec 2024 08:06:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241218103433.384027-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241218103433.384027-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 66562931-782e-4b9c-3618-08dd1f6d350b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG84WjFLcGFxNEtmbE81bHljTGVBNTc1TmVYaktMNm10amo1MkFOSVJPa0ZV?=
 =?utf-8?B?WFlISVFtWDNwbE9TcWozQmtRTUZJbzdUSXNuSHB4cnFnNzdxY1dOU2V4QlVu?=
 =?utf-8?B?eGlDK1RWZXBHMFQydUVVREJKbzFpaEw0RW1GY0tpaEpmdW1ERUVUeVEya05E?=
 =?utf-8?B?b0Fkc2o0TXV5QVdUK3dZaFJnK1pUVC9aS3BVWFhwYStySnUrUzJJZ29CZjJE?=
 =?utf-8?B?cndYVTVraDdrU203L1AweCtETSs0cmI2WDFUa1ozd24xaXhLRVpKd2wvdyt6?=
 =?utf-8?B?RTV3TFM2Ty9nQ1laY1NDbGRDK2F4cmdwV3daZSsxZTRLdTZmUlFZSUFKSXFK?=
 =?utf-8?B?VHRDRlM0SmlpVE4yNVdoODBnYWVCUVM2WnBrVkZ6elhKMWhYTXVVUnhMaGx3?=
 =?utf-8?B?dUV6RkRKd2NUNEVTVkJxUmVVdVlPQjk5N0tRSjJ2YWdLenFCbmxLUEdUVnFj?=
 =?utf-8?B?YUpsTzVIUGU1Qlg3aEpYVUwrZnNMaUlhclNHRXRzckxqYWVuOFlQUFN3eG1L?=
 =?utf-8?B?N2lXcXRQbFZFSk11dXkxV3hiOFE2M2hlL0RSSWRjeUljSXdWMTh5NkJXZ2o5?=
 =?utf-8?B?LzFORHBmWXNhbzMvZXdBalRYYnNaY2FLaFMzZk9XY2hBMEUxM3BsaTBFeFE0?=
 =?utf-8?B?UFdWRHNGWGh4V21lTVVSME9iN2RGNFZrWDZVL0xhRms4MFY5TktSMExFVS9Z?=
 =?utf-8?B?d0hZUWs3Y01TVk15TytlNm56N3hVUCt4ZU9DcFNJNUY5Znk0b2Y5MUNvVnR6?=
 =?utf-8?B?WWFPV1JGSUNEYjluUzZRN1U5SEdOKzl3WWZKa2l5RWJTRkJ5TVFJZkViUkJj?=
 =?utf-8?B?T2ZBY2hZZFJhOG9hUmJzWmZieHV4RFU1NVdya2JDVkhXenRrSzVoTmc0ZzRC?=
 =?utf-8?B?NFl2MDhlNDQ3SVFLYVYxMzVpMmZwZlkrNjhXQUJIaGRXT3dJaEpzL3pUZ28v?=
 =?utf-8?B?QWsvVGpnOUtZUysrbS8vN3dDdDN2Qit0SS9VRlhjMVl0aEtrYW5wYVk2cEIv?=
 =?utf-8?B?bGJicnRzcm9ORVFub3p0b3llNkNqa2pRaGpKbGtHK2ZYbHJsd0FDdnQxelJG?=
 =?utf-8?B?U2I4b2swUk0rTUpxOHFEeTBIZzdoUGIvazBsM3hJSjR1bFZBY0ZzRGFVQkZh?=
 =?utf-8?B?WHo1MWd0UmJTU0ppUGJHd21FQ25saEduTGlmWEx3VHJRZVJmcVZoNmlWZGtJ?=
 =?utf-8?B?VTBXN2Z3cjQzQTc4RVZmUHczS1ZTaXpmaVFSOXJuWXNmcUNnNlYycGR4TTFm?=
 =?utf-8?B?M05zSVhXZHBtWmpzeEl2WUhmUE5Kc0JKNlVKWEdSa3c2N2hEbGExMDJKY0gw?=
 =?utf-8?B?Qk5vakhGK0VrQjhYWFBJa0plWUhZa0Z2RHRJOTk3YUg1WkZTdllQUENBZDRv?=
 =?utf-8?B?T3daZmFBSlV3RlZtS2ZMK3lvbVliU2pVSDdiL2tmaE9zMXF6YmdEeGsybENW?=
 =?utf-8?B?NEtaSjdSM2tNd1BiQnZROEV0YVF5S2crbjhOaE1xaktIV2JVeDFJMDdYNXBM?=
 =?utf-8?B?cHZ6RzRwWlVDSVhZU01KS3AzNVRlUXBwUEpkMU5ZcW9LNThWdXFIN3RxL2Ur?=
 =?utf-8?B?alphcWlmTG1MSzdBbE5uelpMVlh2dVFEZGh3YkNhS3htK1BYVzRXR21WZlBV?=
 =?utf-8?B?SWVoSEVXa3JsODZrQUZxVkNuM0hVN2dzbjZ4ajVoV20yUkcyelhINisvMkR6?=
 =?utf-8?B?QWoyQXROOVNXMG90dktUNUJyT1BDRW5wak1JYjhxRktHK0xoMVI0ZnJLZUsx?=
 =?utf-8?B?YWphUEx5aEFJQWVKT3R2SU83SittcHlLNzZNZzdWdTF6OXpJTEN4UWFJWUJU?=
 =?utf-8?B?WFRjMTM1d0lJRGxjL3hJZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWU1NVFQV3NJZ0FTektqQlVLVUd3K2FpaXB4a1VjOXV5cVorZFBZcGVrMjNV?=
 =?utf-8?B?QnE1NlRzQnFGbmI0WmxEbkxuY0Y4by93TkFYeVFZaEF4YWU1MzF4TDZDaVU5?=
 =?utf-8?B?R0ExSTRSM0sveDFwblZ2eVowdnpBUm45Wjg2NzYyeVdaUGdQcWFsNEJGRGZq?=
 =?utf-8?B?Q3ZRV0Z1UDgrUUo3QTFFUGpGdGwvdU5rV3l1UjBNQS85bXhyMUFKLy8xU1BZ?=
 =?utf-8?B?dktJLzdudFJtd2NBZVF3cklTUHJZbmxPQVRHQ3h1K01ZSS9JL2VMeGVDdCsv?=
 =?utf-8?B?NzAyVDFNYUlpOHc4UWVCSGZuVkV4QTc0bjNnU01oY1FtOWJNYnVjeFRGTEVn?=
 =?utf-8?B?MVdaeGJwWjVJbEowT2x5Y2tiYytvRTRDTU5JckhTd3ZUMFlSWXNsS0RBYVly?=
 =?utf-8?B?c0s4dVZUVm1yWHNHKyswVVdxamFOcXE4Z2IyR3puVkdQL2k1NE1HM1AvSjFv?=
 =?utf-8?B?RWZYa3hINW1RUG1Vem1TbzU5cDEyVnVYUnJlSkNCNXRMOGd2SUVHMy85ZkVR?=
 =?utf-8?B?c1d4cDFPY0p2SGtLVmVmdVZMVHJVbnlPL2VtU0VBbVh1Y3ZYdWkxbUhxRll1?=
 =?utf-8?B?cnAyQk15bjZtKzQ5M2NOVGpTNjlsWW1jbDBNMytNUU5NN080MXJsVnNNUmFY?=
 =?utf-8?B?YTJ0bFBSTUpWSmYrVVN3eTkrVEhSMmlQc2R1bUw4aUhnYWw5OWFoSWZUSUwz?=
 =?utf-8?B?aFhXSXNRWkFQWENPYUNZOExmcTE4ejk4MEtaSFI1bGNiTTRLeFhhbEU5OTZi?=
 =?utf-8?B?TjE3OVgrTnZRL0hadlVZMXZDSStOSGw1MDJSLzBoMm5qZmtyemNEbTZtRU5Z?=
 =?utf-8?B?WUFQa0Ryd3VjWWVaUzRYajZUYUFhVk1VTGpzQ3lUY05lYjdBY1hZK3lyMnQ3?=
 =?utf-8?B?QTVVOVBsSHhRNWlUUWhsKzluVW8vbzh6eVluL1lWYjBNdGtmM2FZeTYwcUQy?=
 =?utf-8?B?OU4xcU1CaE1jQVZleWRrWlQ0cDJOZkZ5RnNjaXJnTnhUdWZlUFJvTzFETVpu?=
 =?utf-8?B?bnZ6cko4ZG1reFZPeGpKc2M4ekR1bkszZGRGbTJyaC9tRlZJUWpscGFKSmph?=
 =?utf-8?B?TmNYeGJiRk92ZWF5Y3g1YmRYRGNybWl3QTdQNDY0ekpEVWN1Yy9vWjJQTWt2?=
 =?utf-8?B?dytySXBBR2lSL1owTzQ2RmpxNjA2Sjltc0NUMVdKRGlEbkY4aG5iRU1hd1hl?=
 =?utf-8?B?RzdqZ2Z6Z2tHNmRTWDFpU294Tm4rR21EczNJRS8wcm9SNW1kWDRqYkkvYUh0?=
 =?utf-8?B?Qkw3N292L1Q0M0E1NHVmRGsvYVF5bGxTL0VCdTI0MVNrUzNzcmlIM1JKdmV5?=
 =?utf-8?B?c1pjcXNBeUZPdFV0WGxNYVpVNzJkeXMxWXJXUkE2SlhJUFpxNkRUZlRubndm?=
 =?utf-8?B?ZDBhczh3MW92cGpsZ1d1dXdtNFNvdlM0WXEzbmxDanNneHlNcTJOWWJ6a1N3?=
 =?utf-8?B?a3RrYkxlWE5FNVcvaldNbkQ1YVcvbHlPMHNyN3lSYlg0ZC8yK01yb05mOUtl?=
 =?utf-8?B?dk1WeERtUUU3UVQ5a2JDTGJQaW1VM3BMS0FTMkZybEpGL3lqSHpabURKNm1F?=
 =?utf-8?B?d0tWdHRyRGdlbE1oQ3hHazRzYzlaTWZpaEJtRG0rU0drNTFzd3FscHN0NnJO?=
 =?utf-8?B?eURwdmhKSlpMeE44aVh3aUJZOStMZ3FwNDlRY04vR1lZM3pjeWlUUVFIanh4?=
 =?utf-8?B?R0YvYjVJZHVzOThNWGg2NWhKVXdYRGcxUzBvY1pMd3V4VTNiWWFFdStSdU5S?=
 =?utf-8?B?R2Y0TDV2YmhXbk9lMjNBbmJRWGFsYmoxUXhoWWtQMFdmNmZkdXNIbnE1NFhz?=
 =?utf-8?B?VnZrTHU0YW81d294MmVWR1FqVXl0cXFpcjMzRW81QzlXQlZXMlRmekxUNGN4?=
 =?utf-8?B?ZWxqSndvTEFTVUVMV1RDRUZJS25mbE5RYU1MYjlvMGEzcEJhYTEwMVlqTHRa?=
 =?utf-8?B?c3VDRmVMM1A5NW5kNlRRUnUreHZSTFMza2hmNG1DRy9QSk9ucHhmbHRJRXRD?=
 =?utf-8?B?enpEbjQ5VGpURGlBQkh5MW9idkxFNnNQWE5FM2VKOTZXUWRQWXFuSHZNSFZM?=
 =?utf-8?B?WmdPYWdwOG8xcTVwLzgwK09idk4wOXBPMk43SE83c1diY2M4blBCNWtESk9F?=
 =?utf-8?Q?HtNtvUfaW5oaqLWrndMlA+xcE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66562931-782e-4b9c-3618-08dd1f6d350b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:06:45.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clVznaRq/Ulk99YhLomvcFb+75nZKqiLKwc+7Ozv6PGKX6G5nIGMS3CER4e0SUnT0VnINEZx1kxyym3cg7iRbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

On 12/18/2024 04:34, Werner Sembach wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
> policy that all PCIe ports are allowed to use D3.  When the system is
> suspended if the port is not power manageable by the platform and won't be
> used for wakeup via a PME this sets up the policy for these ports to go
> into D3hot.
> 
> This policy generally makes sense from an OSPM perspective but it leads to
> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
> specific old BIOS. This manifests as a system hang.
> 
> On the affected Device + BIOS combination, add a quirk for the PCI device
> ID used by the problematic root port on to ensure that these root ports are
> not put into D3hot at suspend.
> 
> This patch is based on
> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/
> but with the added condition both in the documentation and in the code to
> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS.
> 
> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org # 6.1+
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121

These two tag (Reported-by and Closes) should be stripped because this 
is now for very different hardware.

> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a1..68075a6a5283c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3908,6 +3908,32 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>   			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>   			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
> + * may cause problems when the system attempts wake up from s2idle.
> + *
> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
> + * a system hang.
> + */
> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
> +			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> +{
> +	if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
> +	    !acpi_pci_power_manageable(pdev))
> +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);

So it needs to be applied to /all/ the root ports PID 0x14eb, not just 
one of them?

>   #endif
>   
>   /*


