Return-Path: <linux-pci+bounces-21780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1485A3AEC0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9904F3A191C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6F20330;
	Wed, 19 Feb 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brb4pQL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E4B66E;
	Wed, 19 Feb 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927521; cv=fail; b=eamUOzC77uhjxnAPSjVi/4poinu39iwJHDfp6g5+6al96siSz3stjy7X8361xZYnmhnTYX1Bv1Mr8f0F/J7aVQ2BnKdvdbpIJC5CvkC2Uecw1G4ahdWO9j+EkwLfQEgVF7KoaxtUyZadEeMu+vEQNCJbqh03n5J5L0uvWqx9oRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927521; c=relaxed/simple;
	bh=QXuvSAt7tNtNJpbK4p+0EGICEI6I42XZI4RGk6zcThE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSiawzkfu9mOCJ+E6M25rEoc6edqETEU20PhOyb1XbD/eZqyrWdN8zCdRjYzSSjDwVygn+8N/5lEqgn8Q1Jm+KVnNvhhVQjjoDN9VKDvABo5HEiOxKHXG5KiWeeUi8Vz/BIK1CrznXLcYqrVYrzkhubioOsj1xNfvjo25oQCMZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brb4pQL4; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvEfFP33XX0ao8sezedkgwRQsfXu5HyCKT4ls9ffJsLTj7tu6CFX0zneQw7DtW6SzCHnw6P27cVK/62T9D+FhQZOdnYd/k7LMq9kyEYRbxVrahm6KnBI9aN5PxYAj1D3TkIvPyuxE/LgLckppMTfwDE3eawlM6WsPwTfnt/tm68SQwKZdxVHDG/Y5nAqkuRRbI9GnuoT/vJ105WykiNS/rsEzWKmoBBnSvc6e3h/A8stYDLhogZL2Wl16M967KGK08iqY8i1OA7NVukW0Z2vy3JG+nR1PnyspGw2Wlvh3WhPwh12YLD6MyWGvBckXHBpAjn+Ipb1BlNeWWeHav6Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGpGJgusOkxPrdiohh/RZPzhIHqUPLy7Fz0sf9jMLlY=;
 b=vp0SEhd8RsCcAiqhwILV0TzKZ+pcOkKEws7YJsIRnvdiOxM/cq/xqoi5gfrJOD68aNFb5vO2t/ZL4ZdWD4LCKACJ828uMcRO8FQLM4126ASZoeQw5pwM4iAvdeKV+yrKCiyViwEoKk+EWj4ePLo601esWIis/wxu0ICpvpU3QXqQBzIQMivrYFbt7YBrJ5/MA+dBro/5yPUZvp8EBUzUc+hSD0AwDAKQVSnN+yOFa1H4l1lykj0+rHMCkD8ybJUFzZO7ZZ8I0hwTkAJlo/fZOj1N80hITc7H6mRnk0A4iHyblNed371tH+LO2iEXjpPXFmaIiJw2K/DZkVe3Rwuukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGpGJgusOkxPrdiohh/RZPzhIHqUPLy7Fz0sf9jMLlY=;
 b=brb4pQL4xB2eke2hLMKNcXptOvLNqnriJOFcAO6SDXqcOt06SUqQz5uANXESmOQxMwaV7qrSzyItZ07tSO5yJYPlPrKgiMgdM970kLx6YN92+8uIpsPtunB/FJSK5eATJE7JhgXR6zGVSfRz1WlU1DDW1G4yWF+Dorldx1OcCHZzh8+/n1qzPERcfi4MWhajJf0UmKhricv/sZaNXdH6sz5JBIOuRiJHN/Ue6gnYFh69b2YbF/Gk/5pkNRQ5pEhYCRc7GxkCeQ5CvBajsjbwf1Ruyh/qsMJu1w/MmvGGrxRgq/SLHvT5fWk6bYT9rCoWSUGPRSro825ShUaPNQiA7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 01:11:56 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 01:11:56 +0000
Message-ID: <8a3cef5a-145b-40f3-a6e4-16dfec76fa2b@nvidia.com>
Date: Wed, 19 Feb 2025 12:11:50 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/kaslr: Revisit entropy when CONFIG_PCI_P2PDMA is
 enabled
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 apopple@nvidia.com, jhubbard@nvidia.com, jgg@nvidia.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250206234234.1912585-1-balbirs@nvidia.com>
 <202502061700.5C52C6D453@keescook>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <202502061700.5C52C6D453@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 1304cdf2-9ec3-46f0-38a3-08dd508266f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDgrOFpwQmJnTE9TM1YveFVIRVB4WGVKMWJ3UnlONXNsUlNjRFRSbGQ0Z0lQ?=
 =?utf-8?B?dDZYdS9oYVcycXdYZFdSQ0hIZXdMOUtLaHRPbFoxVElINzRWN1g2SjRXaUd3?=
 =?utf-8?B?Q3lJSmtEVU5mREFxQXJJaDl5ZVJJWm5XM29hVjhRbE5GdFNMN2l1VFhmNWkv?=
 =?utf-8?B?NnVkQUx2T2VybzZacFgzVU8xYjdjSW9DbXRoR2R4YjZqWmVOb3FYUGhPV1R3?=
 =?utf-8?B?djM1Z1ZoNHFnRXNpK29XQkwwelF5ckxpcFBRMVJ4bGZ6K3dZNEdYZmV0bWVX?=
 =?utf-8?B?RjBZM2dyT0NDM2hhaDY2d3k0Z2hocVRnRk1ad2VFZ3VZMnc4QURUNDB0ak1Y?=
 =?utf-8?B?OEZKV3VuTUNxR1R5V3g5NUpvNVltZGF5eHkwcDNDMUFEU2gyQXM5RHJQVUQ1?=
 =?utf-8?B?Y21keTdoWDAxVWtEQUFUZUd1UjlMQWRDSFVwU1JpSE11UUJST3pvQkdKN05H?=
 =?utf-8?B?WFllRUc0MXpZZXpBRGpVTzg4RTg3eWlzYk5YbW9acEFudlNURTRpbDR2LzZm?=
 =?utf-8?B?MWtWdXc3MEFscXNNN1dxRFJnL2RUcXZ2QnlvWWJsbmc1Yzk4enBVSDZDbXY4?=
 =?utf-8?B?NXFIblZmd21JZGFOTXVvaGVGdFk5SnJ4bkVuMG1HcU5wR0Z0VWI0RDk3VEcv?=
 =?utf-8?B?ZVIzQ2s0R0JtOFRIem1oUGYzdHk1TFY4Vmo5ZVNhKzdOQk5NbloxN25jRXB4?=
 =?utf-8?B?MVJLbkhndExxcUU0K3g1RlJCc1E0WGl5ZjRESFRNbWF5NHNxcnlKL3V5SUw0?=
 =?utf-8?B?YmxGck8ycWErNTlzY01ER3hkWkhQbFZaZ3JZM1lXWm8xaUFIdWEzbGY4eExN?=
 =?utf-8?B?ZkJsRjNCQkNTbm1wcHQ5d0tqVWgvRkRZQ0tlMmtNNU9yTXYrN256dHZLcDZ2?=
 =?utf-8?B?RHNZbnNKYWdEQTZDSGNqQ3RPWjFINU5xa25NbFFIK0I3ekxndklkT1Y2MTlV?=
 =?utf-8?B?L3NJUGVzR3JaTjZ4ODYyMzVQVWo0NEFqNEE3Z21qMjRMMG56Y1ZTTHp1Uit2?=
 =?utf-8?B?VzVzTHM0SWRSdlB5bEFWQjdYSHkrYU9rR3lRMWRVaGg4L3pLUGdJZXNxK0tu?=
 =?utf-8?B?ejNwc0NIWFNVQVBEVFdDSllENUwyOWU2dTlvbERjWG5paWQrSTA4ajNiaUN5?=
 =?utf-8?B?aCtYM0toT3hNalRSeVBaOU1YTFdhQ0g1THpvM2dFU0dtSUlWU09ZMzR0UEY5?=
 =?utf-8?B?N0RTNHZ3WE5ia2wxd29OQlNyYnJBSm9CbDZlaWlJbXhKZzAwWjdES3BSaklM?=
 =?utf-8?B?dG0wT3NLd2pBbHpyTENCNlJselYza2k5NU4vRWViQ0pLNHVxYWcram1tZEpI?=
 =?utf-8?B?Ukw3S0pYR05yWVBFRFV2bG5SeDY3aTBndkVxMHV0WGZqSm5PWlI4OGZYTm15?=
 =?utf-8?B?T0hFNHZ2bVdQQ29xRlRyZlVNS3BiV2JlcFN0aE1Lc1Q1YnRGQ3JmTGZONzhC?=
 =?utf-8?B?QzZSbFkwcFNVM3ZjYlBkbTlnN0ZEVzRXbHEwRTVBUDNCT2tWclVDWmF5ejdQ?=
 =?utf-8?B?bDNVUnRWVXhJcjZTdVN3SkpjWkhrM05lSzNRd0kycDI4UDQ3bEZaQnNzU3py?=
 =?utf-8?B?OXlmN29wVTV2UXFpanRxdnQ2S0hCSjFNNzR0OEZxY2hGYmhVaExwdlhkWjRw?=
 =?utf-8?B?NEVDa2VNNFVRcVNibyt2a2I1SHZXRDk5SUF6L01wSnJwZnlYKzYxVWpORm11?=
 =?utf-8?B?aUtnQXNjOEpNKzVrQnZUTXhBSTVDYVMxZUZZdE9SMEVFYWNGZXdaazFGRzFN?=
 =?utf-8?B?YlpvbmlaV3lEZllQOXhOM0JOQnd4MW1WRU55WTViQzlZWU55U21KTmNmSzFT?=
 =?utf-8?B?eHZINm9NUG12QVo1Qkt6L0xXVkNjL3RFY0ZSWVp0SXFKT0lQdkZONllMa0th?=
 =?utf-8?Q?ia2ZfCynpClRs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBFOXNLNGwwVUk2cndIRGZncTBmS2gyTVRUbkNlVWcwNmZPT1MzYjdZN2Ur?=
 =?utf-8?B?VjdWSkVVSW5hdGRWUDBRdk5YdFdXcnVyWURYUnduRGpBUEhRU0x3eDlqaFJk?=
 =?utf-8?B?MXpxODNxOG9IT1RQeUpmalhuY0ZDWWtsMVNaT0hEWDZEZllKRUxwcFRwQUpa?=
 =?utf-8?B?a2lIMHdnZXRMMEhTUElUdXZ5NWV6VDllbllDZUhzdVdVSTRYZnJrRGpzbU5t?=
 =?utf-8?B?SjlBYzlQSDczUVh4TG5wWnFjVGk0YTU1dkNJVmpiV3Q0Vk1IWWJXcllYRnZF?=
 =?utf-8?B?VVV1b0twU2F6MGtmQkFMdHZWWDlpak5KTFZ3eEY3ZW4zOXMzMnZZVzJoZXVR?=
 =?utf-8?B?eFpUR3ZBWG1wdlpDTmEwZ0c3dnJmMElicmVBR1NYTzZrWW9ncmxVMklWeHEr?=
 =?utf-8?B?TzRHWHJZcEtleFV4UlhTY1IrVFROMk9kTVI3UlFERE1PUEoySFdUaTliMHMx?=
 =?utf-8?B?ZG9Qekh0ZzdQbDNSZEdyU3JudkdGS0NabFE3Ylk5UlJnUEQ3TzVJbG5heGZ6?=
 =?utf-8?B?WGZZbGtFdTJ5S0V4UXBBV1h6VHp2UGtGSlQwR3lpbjlWb1M5aXNXN2MvRXBV?=
 =?utf-8?B?MUlqSHVpR0krNDNrTmpvYUM5dk9vUVJjWnE3MDhnRnBUR1JReStGRCtISXpw?=
 =?utf-8?B?ZW03Rmd3SkprMllYV2kxYkRTOEt0N3JvcFRrNXpRRzZ5ckl5eVo5NG1VU3JR?=
 =?utf-8?B?bVlyNEJvUXl6empSbWJRTmw4Q1F0RVowYjFtSGRGeXB0bU1VK0QxZExkbllV?=
 =?utf-8?B?WlJ1dFlaUVUyZ2tSOVUzRHdvaGZ4VWJld080UFlBTkc3YklJeG5FN280QUVl?=
 =?utf-8?B?Z0s5blhBUCtQakoxamxyWjBUL1c0NEhXbkFVSU1xU3ZzREpKcGJsaERhYlZm?=
 =?utf-8?B?S1FETXJsQWFQc0VKTFdJM3RYUlJFbkdVaUFNUmg4UlNMcTd1b3ZnejRzTm0v?=
 =?utf-8?B?LzBRY2NBR3NackwxaXJ2Mm1td2E5NEM5MXp5VG0zK2NvYVdlRjZCaU45SHo4?=
 =?utf-8?B?ZzZkR1huWXowN0V6Yjl4MFRQTVVHVkFiREN1TGYvUFFTZis4K2VyUXp1QVhL?=
 =?utf-8?B?T0tyQktlWXp3U0FsUUk3ekZST3VCQ1ZaTlBhU2JZS3hhYi8vQ1h5YnB5Mk9h?=
 =?utf-8?B?Q2hYMkhTUER5K1VjL3JmbjJZSnhrbmVqNjloMzhqS1FKU3k0N2NzNkVqampR?=
 =?utf-8?B?cUxPdDFKV2lwNWxScndwOWFDWVhtQnNTQ3JqaEFlUGVwdXhzOVh0cjFrcDcy?=
 =?utf-8?B?aWJHSVpiYkZZbDhxZlBsbCtMKzFjQ2d5SXM2TXZ1VkZ1S0pHeTlZZUwwQ3ZF?=
 =?utf-8?B?TDUxZE13Rm1DTDVHQmc4blg0Sng1bHc4QlpzUTVBWTMzRGxDVDRtYUxyTW5Q?=
 =?utf-8?B?dXRXVEpGS1BvS3N5YXFMcGhRQnhFdGNIRzdWOUdQaGNKVU5yeGlXZzZIUks0?=
 =?utf-8?B?cVN3ZXRoWGhNdkUyaEtNZXZRN1BoYXZBeUQydzdZVTdHaFpyV1luVXRuUlNu?=
 =?utf-8?B?bVBiQmhqbGhkM3MrbnJnNzQvNWJteWp0RXFNQ3Qxa0YrQ1dhVVdCcFcvN2lD?=
 =?utf-8?B?TGhmV09YSmllTktmVjFZcXRxb3hrQ1ZaS2hhMFFUWkNRQWg0RjhOZDQzdG44?=
 =?utf-8?B?R2RUOWlabW5YWXpmWGgvSzA5SnMwU3BKQWtnWUlkeGp4RGoyOXZmTk5XTlpz?=
 =?utf-8?B?RzFTVCtncnRuemJGcGtUcWwveEhISnV5MkpIRDZBMDdnMThrSUVNRG1nZkRm?=
 =?utf-8?B?TUJ1U25wYlpJUENmU2dyQ1YwdThzWFRIaXNjYnZRd2UyU1hIZGNzRW5odURF?=
 =?utf-8?B?anRicGttT0RvVHd2dGtORzhTNEdEOWNRa29RSExOWDZVMjVqQ0tUV0w1a25T?=
 =?utf-8?B?Rjl2dlAxZXhwSWJxc3IyRzc3KzBtVVVrU1JSbFpzZE9OcG9MVEQ4S0FTUXhP?=
 =?utf-8?B?VXhHWkJLdk9iektERDhvakdxaVNUaWM1L21IUUZJKzh0T3pZQ0x5dVlNNzQv?=
 =?utf-8?B?WXh1c1dtbFV5c2oweVhmWmVLT1pFZE9wdytvekJrajhDejZVdDZhazBQL01D?=
 =?utf-8?B?VU0wRFJNOTB4bDFEbU9nYUxGRy9tdHRTaXZLM0ZJaGx6Uy91aWlNVlpVWTZ2?=
 =?utf-8?Q?N029OLTjY/d+m/hTBc1ZrWLG2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1304cdf2-9ec3-46f0-38a3-08dd508266f4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 01:11:56.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3Egsc5naJufBcMvXP2tRouOroR6/UaTRyMYS+GYlcmgPFU/LMHRvGnc/4KMvDyQRE5pX3MCGkcrA1Pmoih7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

On 2/7/25 12:00, Kees Cook wrote:
> On Fri, Feb 07, 2025 at 10:42:34AM +1100, Balbir Singh wrote:
>> When CONFIG_PCI_P2PDMA is enabled, it maps the PFN's via a
>> ZONE_DEVICE mapping using devm_memremap_pages(). The mapped
>> virtual address range corresponds to the pci_resource_start()
>> of the BAR address and size corresponding to the BAR length.
>>
>> When KASLR is enabled, the direct map range of the kernel is
>> reduced to the size of physical memory plus additional padding.
>> If the BAR address is beyond this limit, PCI peer to peer DMA
>> mappings fail.
>>
>> Fix this by not shrinking the size of direct map when CONFIG_PCI_P2PDMA
>> is enabled. This reduces the total available entropy, but it's
>> better than the current work around of having to disable KASLR
>> completely.
>>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> 
> Thanks for the update!
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

Thank you Kees! 

I wanted to request that we pick this up in linux-next via the relevant
subtree for further testing

Balbir Singh

