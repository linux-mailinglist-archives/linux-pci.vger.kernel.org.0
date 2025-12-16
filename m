Return-Path: <linux-pci+bounces-43149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5ACC54B4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E308300F324
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A81309EF0;
	Tue, 16 Dec 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQTHtzrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF861FECAB;
	Tue, 16 Dec 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922671; cv=fail; b=dBRz4CcJTZV44Sw/WuIPI6g2Pt0YA7vCcrxkIxawx/dOKfcLX3XatkQfPBNip3AV0FG47IhqfDAM+BH+v5G0iIFF6ymPnvkuoHjmORMUFLcS1aXooL+Pny6Aqwbk/Zkg0kj6y6JBQq+6ep6BsODM/A+OrtVBZPJ31M4GdIHL5mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922671; c=relaxed/simple;
	bh=xoiEBTmHZjm9TjQtaGqlTllgrr1/h3L1pmoHcugTmbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DWqjIq3FvRI1jMBHmzjX4zPWYsGAxTvk8+o574FQIq78HPaRTlN6+ahQ2dWadztpaisZ3z/zLjjO2LruNvI13jRRi+tyek280IhcrTMlgWesx0INT+3yHOVflfde7DeY2THwkhBFf3p2INPD/cjFFtQTkU8dN7X3noRDhP4k6t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQTHtzrv; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMuUsSNm3PUoW6Mxk8t+pfLGJkYa5S756XKi4eenz7BkksjNdqIXaVQj2P3WZLPixGDO7NzWCTqWzlY3S+TTivXWkkq2LHo4pKLIuW6gVAy/xPhLBu8qVFBxOAiOwory6/sIxdFyG2eDIG4Tc9POpCcgPhX63gDTkq4tzhKMkXuu6AjNk/u3HlHntQgknx8krHx+kP8LvScQoWHa0Kd79jLK7bKaZnJLJFuL5roiPjku+A83FFFgMYgWpsHN/Yn+t8EJhblJrBgQWYgfUe9BRTf/f2hFyBw7oqf0ZZVggMon8SUXW6Dpo+nfAwyT84gRqRmUh0L2kMew40cGQb1j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ5WdFaNYY8EZxJAtNCU1MIp5WosqAWgNFnNKQVBY1U=;
 b=iUjgt79KvEQviJ5KNs7m6OXENsdLq4BtCwnBMdK2IzsV9fgzOXbieGwgApDFWe2HALRtBg2iNV+1e9JW8aeiE2GQvN7AjcvNQRyXqCCvu1sJyeMalHLf5UBxR37Y9LqvFuqjIJ2bMNrgLF55xwnUhXJ8XUuPHKh+KtG+/DL7XKHhj0CQ1bfmENkdD9pk8oUW+nBySu1mm6mXLw9pW5DICOVP4T+PVwQOuE4mij8lKeyoRz9VZBBmxWGLnDhgDj5lwAYM/t+ywu7dsfSwHBPIiMD7obcUBMrtVo+L7hUyTK7tZfnzl7ILRYjQaopZYc7URmfMWL9bnw5nK1LliQqPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ5WdFaNYY8EZxJAtNCU1MIp5WosqAWgNFnNKQVBY1U=;
 b=pQTHtzrvL3Xt5dKwaKe78DnzYQdJIdXep7E0GR+iDOt/0wfi1MYkHS6EUNRWgpn1rlDEDibn+LjFS9finNcw6MOxg2u0gTXlKGkA+cUPnPX2Vs6gGRZGdms8Qi5X69l7dIRZiFD+FICzYGUG9R4MV8pCm89fXCxUAw/IQ9NpLTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 22:04:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 22:04:27 +0000
Message-ID: <5536fc1a-4bc9-413e-a903-08090217979b@amd.com>
Date: Tue, 16 Dec 2025 16:04:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: bus: Adjust error handling in acpi_run_osc()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
References: <12803663.O9o76ZdvQC@rafael.j.wysocki>
 <6225184.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6225184.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 760a7b46-d14d-43e0-9c87-08de3cef1483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rks2Y1p6T1VtTEZ0bDJ6MlZTN2REdDdlL3A5alRGREc0Y1QyZ1V5V2V5WUxh?=
 =?utf-8?B?U2J4UHVJMEhFNUl1RStCaHkzbGt2TjlKN25DYlNOVjBOdVVtSVNnemNvYTJr?=
 =?utf-8?B?NnNpNlh6UGVqc2lBUldKcHNRUXdoTGNySDFrd1orUWV5TTgvNG9HN1BkL0dJ?=
 =?utf-8?B?eHFMQXdMM3JjWEhndUhaanRmSHNhaGxYakxrUkJ5cWxNNHBVK1VCSTF0emdM?=
 =?utf-8?B?Q0duMy94ejlpZGxYK2MyTWlFdnBieGJDWGVHMjdYNkcvN0N1RVlETSt5dGFi?=
 =?utf-8?B?NEhpRTV0S082OGRzdWNGR3JRREM0dVpuWTdEOUxDdmUwbTR4ek1paWUyRHBx?=
 =?utf-8?B?R3MzVW5panBPRmxFVFhPNTc5LzJVbkhIMUZBRmlyR1I1by9mZjkrRmVreTli?=
 =?utf-8?B?dHRmWkpibmdkeHZENFdmS2FmK2c3YTJDcUhqRHBxT0NLL0lTYTljMzU2SElP?=
 =?utf-8?B?bzcySU9RNjY5dXR5aXYzSXR6RVpGdnpGeVVBZEVBZkppKzN4M3lrRzEvTFZD?=
 =?utf-8?B?OGhkdTU1RVUwNHB5R2t1WWxvcGZUbjVSUHk0OFdVTXVHcm1ocjhjcVJpL1hv?=
 =?utf-8?B?ajRUUi9aei9FeklaTzlDeWwyRmFvZHB1aUVNSC9Wdm9kR1hZWkZZM3p1eUtL?=
 =?utf-8?B?cjJkUTBSNVp0T3p5dDMxY1R0MXZxTGhCVEplbkd0d1NCOEVDbWpJb2M1TkVZ?=
 =?utf-8?B?eGs2L00rT2g5OTNIenB3aUhHWmJkRjVlbmtkcC9IT1g0bnM5QlhUOCtUVHlB?=
 =?utf-8?B?dlRmQ0RTcmRldnZVZFcrTkc2L3N3WHVqWFhHeWNrRCsxSHcvUEp4STJBd1RD?=
 =?utf-8?B?S0hpeGVpa0FYNk90VG5hMlpYUFlzZGNuM2RKWlI3ckh5MDFTREpKb29JTlli?=
 =?utf-8?B?QjlyRzhiZUQrNklLb0FoZk93S21BMERBNjlGY3RGeU5MVjYrbXJRQkQxRHI4?=
 =?utf-8?B?dFNicE5IejRjdG5ITVBvVE05UTlNMzM2Tmt1a2ErWnZ6cnk4akJZTEFueU1W?=
 =?utf-8?B?WURrMHNCRVM4Z1JKdGFOT1h0UmI2NmpvT0dvWk1Zb0l1S0V6Ylk0eHNoRUU3?=
 =?utf-8?B?WDM0MGhnQzdndGZMV01POTgrWi8zN1hiSWxKQk0wbGJJWGJGUjhVMXFqM3lB?=
 =?utf-8?B?TmprZEZ6cUtWb1JxajVkVitnM1ZYbDRwcWxua1FCb2xlVnFWOXp0TzFNT2Y1?=
 =?utf-8?B?blFHZU9FSnNKMnhaSUlrWnZXZmtURnpRRm56MmlGYTJFa0tFT3NtL2Y2L3ow?=
 =?utf-8?B?TTExbXdIMVMrNkxEVXZCeHYvcldNeFhwYVJ3WmtDbzNlQndSN3JsdU5IQnZU?=
 =?utf-8?B?b05Sbmd1Ukc5dGc2c2p0RFNRbTQydExwZW5yMkV3VmpjdmRyTjVjQnVhT0Fo?=
 =?utf-8?B?NDVMZ1NxdWdYbDdxeU55YUgrTnRMcGl4L1AwY09LdDF6QzBISFNxSWRSM1Zx?=
 =?utf-8?B?eXlwSENtUVFpNTgvaGRCbWRjd0Fzbkt0QjVRMWk1YW90aVBNeVhwN1NaN29I?=
 =?utf-8?B?M1l4dXZDZk0yMlU1OWN6MWtSOVN5ZmswYVp5d0dXelFkVHF5SHh5cXdVWWdD?=
 =?utf-8?B?anVNZGNHdW9HRmUxdXJTZjMyam8wZEMxYUVOMGZVNVhDTzMvQjZNbUZzS0F6?=
 =?utf-8?B?Tml3TDYyU3cyb21EUS9BT3kvYUo4Mk5tS1NvK3lSUFFHRkZZcmVGWFAybUQz?=
 =?utf-8?B?MGZFUnNMUjhhMTBXYTRBQVpnZ2R1eGFkMEpiWVFoTkt3TkV0azJNeVZZQ1pu?=
 =?utf-8?B?Wnc0UGdhY3JaMDRrMUFuMi9uUFVJYmZyQkdZQmMvYXZRS2RqM3lGcHZQNmp1?=
 =?utf-8?B?S2JWbjJ0WXl0WGZ4bjBSdVlyOGJraEVpdU1JRjJpRVlZaWhnZWpiRXlpZ1li?=
 =?utf-8?B?Q2tvOElMSWZxZXNFTkNVcHQ0Q0VKZDN6Vk9zVno3RkVhcVZpR2w0Y3IycmUw?=
 =?utf-8?Q?cag65DP5cPZ1wswQqMCBKm9CKHxbgDGv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdoUkEyNXhuQVZ1ZTd6d1BKZE9zY2NVY0ZmTXJhVDRlNU94c3VZSTUxNUh5?=
 =?utf-8?B?bGNZNk1vOTcyMUtzNTQ2V1V0MDlDR1hFcGdiMStueC9rSzdkc3l0K0JtN0xG?=
 =?utf-8?B?aWNTR2gxWFpGUml1R1VaSC81Rzd4Z2pxYVlBa0FxMkZaNUxZc1ViRG5wS214?=
 =?utf-8?B?SDBtbmd0d3VuRTYwNXRVdjZlYlBTdXF0d3ZWUTFJSFdQZ2ZaaFA5L2x6U1k5?=
 =?utf-8?B?Tzlpcy8ySHdJK3Q5RXNETllLK1pMaGI4cXlIaXZzeFh3QXhTZ2VZZ3djNjJI?=
 =?utf-8?B?UVVaU2xQcWFYb1RrSXNiekpNbS9zOUV4eU94UDR2emNjR2lRYkxnUU5SU212?=
 =?utf-8?B?S01YOXdKd0x3QXdlSGRmTit3VUlHN0IwSzlRYW9MQ2tqcE5iWGd3WmlPNnp2?=
 =?utf-8?B?RmtIelluMFlxS2tnK3BoamZKb3RQdWNyeWcwSUNZRExheVdUc1JPOG00NTlw?=
 =?utf-8?B?dE9tL1FMVm1ja1d3TG05R2cxdkFmeDMwVUZJK0FlUkxaNThXSVR0dEVxaGI3?=
 =?utf-8?B?bmJTR0tVblg1RTZyM2ZZTjJ3Q0dyTVZKU28vZVNGSW9NUEN0Zm90NnIzRGUv?=
 =?utf-8?B?dGhvRFh1OENlT1Q3cUloTDY4WGY3MWFTNEFRZHhaSlZYNmx2TnVvdjEwUThO?=
 =?utf-8?B?K3U1YzRYV2hnR3ZoQlkvNjB6blFaaHgwcURjUFA2bUZoSVVBeVdOdGlQRFBt?=
 =?utf-8?B?MHNVWTBsbmVjV3BwUUdUOWkxWktCVjkxSUVnRmxxTmZ4MXBXUlUvN1BBZkdO?=
 =?utf-8?B?ZFllK1ZwOG5uRkhvKzl0VFpXekJud1ZHdXdVeG0zaEVUa0Y1alMybHFEZm9r?=
 =?utf-8?B?cENqYjdsOHZGenhkcVFuYWFUbmtzRExiMS8xaWdmZ2twcmwyWTRBRDUzWk1l?=
 =?utf-8?B?WHd5NWhhcE9saWtpSUxrZitxZFk3UThIUEViSERic3JENWhuaWVYMEhLR2l1?=
 =?utf-8?B?cm9SbkFSV1ZLVkJUM1BQS21RSVJJR3VQaG84a0hCME5SV0hyTmFBcGcrRjI1?=
 =?utf-8?B?Qi9tTzljcXpnazE3ME1PVU1KMkI3emkyaWhlc09PUWxtMFZOZ1ovd0NhY0hS?=
 =?utf-8?B?TlhCd0diNGIvaHprZUV5Rlh3aGFxUW1NV0tabHJITXdDNHBGMFJ3U0oxaDhR?=
 =?utf-8?B?MGd1aHp2Rll3VjFadzJBNExGTmZPOWRJSW0wdFAydG52RHY1Z3ZRSWk4NUNy?=
 =?utf-8?B?ODNrZWdINFl6Rkc3UXZsWXpEbEg0RSsvME1ZbkRHT2w1blJqQXVOUDlIQnBR?=
 =?utf-8?B?OStMVmNJbXlhL3ovZnBxNDlnZ0F2QmtGM1NwU3NrV1BBRSs4VXdWbGcvNnha?=
 =?utf-8?B?a3IvU2pqUEw1VmdydmtYdXlLZW5pdWJBV3ByeE1tV3RxbDFZWnlBNlpiUGVm?=
 =?utf-8?B?V0swa2ljZndqbkNtbnoyeXVENHRKYkZ1b3RUMCtFQUFqMGgzL2lXS1htODBt?=
 =?utf-8?B?Q3FmYStRb0NwK2tCWDlNYVJuS2hUOVlHS1ZxUG9LSzZOWmpyNThQemwvdDNt?=
 =?utf-8?B?MHFVenFKZHYySlg1VExHd01qMlZUdTM4ZVlQTFRkSFBiaW05WjFVU1JSQjlK?=
 =?utf-8?B?WTE4akhrdFBBbmVueFc2SEcwK08rVFlaMnlpeGxjQ09xVXRNL0hTeldxcjVY?=
 =?utf-8?B?L1lUQmRFV2pnMXFiaWp1aHA4WTdXL1FDd1N5Z3JiOExPcTVaaDgwalpLa3Zi?=
 =?utf-8?B?NnRTdGlnOTB1YVVzRUZDWmJuaW91eFlIWjBTU3loU1dXaTNPUlNMdHVRMVZD?=
 =?utf-8?B?ZE5qYjAxa1dyK1gwcmpTa0luSVFqNi9WSHFhM3VWWWdOVy9SRUxNUThGTHEx?=
 =?utf-8?B?R2hUWVhydTNwRHVNVFl6WFB0eXp3WVhUK0FITE1kbGNmdW1RNE1IZi9ReS9a?=
 =?utf-8?B?QWJoM1RZbWJJeDBpN0V6bUthaDAvWUZYV3VEbXg2dHg5R3Z6SkhvL2hRT1VU?=
 =?utf-8?B?dUh2NmZidmRpYzN1V1B2N2JnZ1VFQ1lObnlBZk9hWnUxcE5SK0Q1bDFBQXBG?=
 =?utf-8?B?OUdnQnJLUlMrS1U0aE95Q1ZYR0xZTm5XcUQ0Vm1iQlhJQmd2dXJSWWRqOUQ1?=
 =?utf-8?B?ekxKVkRXK1JxMmtPUm53VStGZE5WanNhcG4rVitTV3oySlFmcHdyRGVndDFk?=
 =?utf-8?Q?TzGHuqnTHzGYEiAKH6HOx7gLM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760a7b46-d14d-43e0-9c87-08de3cef1483
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 22:04:27.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRAFRx1oE+lqUcw1gGonOioSEZorFkOc0PAx0tffFLtok6emgiGK+R73t6Zf5UU7tlbSuRZPdoFTKDItNA0fmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200



On 12/16/2025 2:17 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some platform firmware incorrectly sets the OSC_CAPABILITIES_MASK_ERROR
> bit in its _OSC return buffer even if no support bits have been actually
> masked, which causes acpi_run_osc() to return an error when executed
> with OSC_QUERY_ENABLE clear in the OC capabilities buffer.  As a result,
> the OS assumes that the _OSC evaluation has failed and the platform has
> not acknowledged any capabilities, while the platform assumes that it
> actually has acknowledged some of them.  This confusion may lead to
> missing functionality (and possibly other issues) down the road.
> 
> To address this problem, adjust acpi_run_osc() to avoid returning an
> error when OSC_CAPABILITIES_MASK_ERROR is set in the return buffer
> and OSC_QUERY_ENABLE is clear in the OC capabilities, but all of the
> bits in the support mask supplied by the OS are also set in the bit
> mask returned by the platform firmware.

If possible can you add some more context to explain which _OSC was 
behaving this way?  And if it's production hardware what hardware was 
affected?

It sounds like a viable workaround, I just want to make sure that if we 
have to change this again later we have more information to look back upon.

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/bus.c |   23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -240,9 +240,13 @@ acpi_status acpi_run_osc(acpi_handle han
>   		status = AE_TYPE;
>   		goto out_kfree;
>   	}
> +	if (out_obj->buffer.length <= OSC_SUPPORT_DWORD) {
> +		status = AE_BAD_DATA;
> +		goto out_kfree;
> +	}
>   	/* Need to ignore the bit0 in result code */
>   	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> -	if (errors) {
> +	if (errors & ~OSC_CAPABILITIES_MASK_ERROR) {
>   		if (errors & OSC_REQUEST_ERROR)
>   			acpi_print_osc_error(handle, context,
>   				"_OSC request failed");
> @@ -252,17 +256,20 @@ acpi_status acpi_run_osc(acpi_handle han
>   		if (errors & OSC_INVALID_REVISION_ERROR)
>   			acpi_print_osc_error(handle, context,
>   				"_OSC invalid revision");
> -		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> -			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
> -			    & OSC_QUERY_ENABLE)
> -				goto out_success;
> +		status = AE_ERROR;
> +		goto out_kfree;
> +	}
> +	if (errors) {
> +		u32 retbuf = ((u32 *)out_obj->buffer.pointer)[OSC_SUPPORT_DWORD];
> +		u32 capbuf = ((u32 *)context->cap.pointer)[OSC_SUPPORT_DWORD];
> +		u32 querybuf = ((u32 *)context->cap.pointer)[OSC_QUERY_DWORD];
> +
> +		/* OSC_CAPABILITIES_MASK_ERROR is set in errors. */
> +		if (!(querybuf & OSC_QUERY_ENABLE) && (capbuf & retbuf) != capbuf) {
>   			status = AE_SUPPORT;
>   			goto out_kfree;
>   		}
> -		status = AE_ERROR;
> -		goto out_kfree;
>   	}
> -out_success:
>   	context->ret.length = out_obj->buffer.length;
>   	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
>   				       context->ret.length, GFP_KERNEL);
> 
> 
> 


