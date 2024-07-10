Return-Path: <linux-pci+bounces-10090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17692D6A9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C4B1F28A66
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E27197A76;
	Wed, 10 Jul 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZNZv2GO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE57197548;
	Wed, 10 Jul 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629370; cv=fail; b=Q0cn+e69Blcgc5xx6CIIcyyTeSrB/1lZsl3RNGmrJTr7IrQBsMjdSmCUkzSxmUmEbvlyN5JCINyBOmpjWyAqAYgJqO+7wpUl5utZtLx4ezTvtslLZQRlrh0c9zK+EWpoA6AjFh0FdiA2clYDMHJC6wz+OG/c06c+gLbntwTsoF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629370; c=relaxed/simple;
	bh=bkjRjjD6Orfc02ht1otKQWXo3VDS7a/ma6hR4nBB/dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lzjUOcSB8Gcdw41fuGkjkHBtg5Hcj7J6FGBQJw6Z8XVPmht9KEyu7+eqWtSawmvyiWYrv6j44+eWCS+BZDxjOCch1fI7Jcfw6ZUJKEXJ/JtAf7mUK2vK1109CFc3edMxzjPdpOEGIVkbnmVZz5lEemGVK0rwKKbA5lHUtcbZ6NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZNZv2GO; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRdBGKFlWpGWG6LWpK/fvXHvccp/8nJDXNvAJP9PloQZMDvvgN7vNU++IaNs6yPYskXtZmU5gK2nbUnL+hUmCbAbRyQwunFuMYfuQuBqJ8aaNgraS8QBu4yVnT/w5g6VogTH1HiQY8wXcE1ifE7hdj3Lp/dzH6mxXOwSLZIEZx82tNYgTZ/07pvYS31kVzxzbnatxpCoONc03xc/mHd5PzKcwxKInOGHk8X34GXRCcY0InHVlzOx9tMxh9z/tyn5TSY2rilPaRhuhT0TkB9OB1FwGCO2+kQ+1gSVG27jOOLNKmrsg+Yjl0nvB0WgHlTOOmRwu0KMxFUUDG9WhcuutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU6Oi9DHbNhA2qiVY8ZKegFLJwg5qq06kR3lgdh9Uto=;
 b=dehVKo+PSzHykQbaXcKtp8PFuqLyxYncoZ9khtmtW1eheDQxQj/IGgB++SNQMIwuYuB85CKio3zHjc9cdfjVk4Yu9hxblfPwgKMbmXxnzMBLUZAq8nFZo96kGDJZxQ8jza5DStKQvCtRyC4hTsedulBg733TvbJogAN2/jdjeB79CXgwQyrPTOaBJasia6YP+8AYnTaVrd4PUZSL4ErfyMRCdw8ZCONgBwLgu/AWx9qLeA8gOBcsYDpZhnnbnwh9C4O3oysJ1TSzC4oxkIXhm4RubQlne112SzEQCnnj/F25ksKj/1FBStEWvLMVkt7XVjScaN5dsZHTuMAKby4eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU6Oi9DHbNhA2qiVY8ZKegFLJwg5qq06kR3lgdh9Uto=;
 b=qZNZv2GOcwD3RFv0bLOThlZaKF2wNt1FA9/w71d0gO1XFza/gYhoUHKckt/LvGWey4RuB6W6jom02j0UKLhlDEelDjCbouwa/GsmtfJOnw9MbdrTyXGUSrZ07g9fyyLqwjQ4wxV4g5XWoMjhSzhzZj7hWC0axWzRGIv8dnt8fho=
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 16:36:03 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::41) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 16:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 10 Jul 2024 16:36:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 11:36:00 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 11:36:00 -0500
Message-ID: <05907efb-0b60-4fe8-8c1e-71506424879d@amd.com>
Date: Wed, 10 Jul 2024 12:35:59 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] PCI: align small (<4k) BARs
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240709162154.GA175839@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240709162154.GA175839@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 619897f4-8f0b-42ed-90de-08dca0fe63a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFFlZVYzcnRrbll5UzMweUJZY0NpNDhLK0pkNmNjVFlvdnZSQlljOFg0Wjdu?=
 =?utf-8?B?aTRmT3RFTU9ONytidUJ3NktCRzdTeUFFbnBTL2tVcjAzcDlYV3ZRK1NuaXZ0?=
 =?utf-8?B?T3FuUXZXbFZqTFJ1Ujh6SnFzL3NCMmUrZUtadWpyVDFzM2Zja0lXMnJWTE1E?=
 =?utf-8?B?S1hiZXpjeThjZGU4NEtlOVhteHlFVmdoMUNoZDZKMXdTdSt3dnlTTEx2Tldi?=
 =?utf-8?B?R2pFN0xhTHRFanlYOFNqTGQrUEh4ZXh4ZXNjMGdxRjhLek1uWFVENkpkRTla?=
 =?utf-8?B?a2VwMjU5Um83OS81ZEFpdmxKL0EyMis4NFhlVjJCSk9GdzNjano2cDhjR0FB?=
 =?utf-8?B?eEFMTHRGMEtvV292Ni9yZXpJNGRWRGR4TjhDT3cyczV3NFBaN2tSMUlnT0FL?=
 =?utf-8?B?YTFsWSs1blRtMkdvenJlSjNVeVFMcDNBVnhGYk5nTHlnVXM1MDc0SEltMnNE?=
 =?utf-8?B?MmQzTDNuQW1NL3djU2p1eGlpdVlIQ0lNUUFUU2VoTEsrbndRS2NWWFZtdTBx?=
 =?utf-8?B?RFhEYkNLbnhSV0VDUkh5ckdpR3BpMzFiRzUrSXVORmVCVlJCckhlZGpvV1hq?=
 =?utf-8?B?cXo4RHNIOCtjREhsU0p5ZUdlb1R1bCtydytCRWRmZmlRSmRyT0ZndmJSQnY2?=
 =?utf-8?B?bzE5OVMzZEp5K1ZMRnBDUjZEa2RTYXo0MjVyczQ4SHFBZGJUNXVWQnZoVzhk?=
 =?utf-8?B?bVRaa1crajdudm84WG5iY3VEOG1IQzk2UXlrYmpoOC9qeFBhck9ESnZxTGNz?=
 =?utf-8?B?SmNKc1h6YUtzU2pmWm1MRVYvSEdrS3ZKTVFFcERuN1pidlpsSGtvYnRNQ2Vv?=
 =?utf-8?B?bEpsUGJWcUxlTnl1eVRrVm1TUTBXaXdWOTdGc3BBRDFsYmw4bEVDRU9oY3ZH?=
 =?utf-8?B?TjRYV3VQWm12OWhuTURwQzhnNnZtY2pqRTJHQXdaK0Q5OW5yRHlqelhURGlt?=
 =?utf-8?B?S1JlQXNJTWNXdHR5MXJIbENsOHQvWUpYRWExVG8xdkc1bkN4Ti9oVzI4S3NK?=
 =?utf-8?B?UFhJK1c0cFpGOTJlSmQrUmEwcHlBSnFpWlJMRXpFSitLMy9mcGM2Mnk2eFEw?=
 =?utf-8?B?anRlS0RQamptU1VyazljcnRkZTBhbzZnUG1KZ0pVcmRZZEkvVWJiV0Q4RGFB?=
 =?utf-8?B?SGdGQ0l3clI1YlhnQVREbDFnbENWZDNseW40L1dMR2R5blZwRlQ1NTQ5Mms5?=
 =?utf-8?B?eU9DTzdqMks0T1hhQmRka2Z3YXl1ZlFYMlRnYW5iRFJvRWppRlVYT2Zrc3cr?=
 =?utf-8?B?bWFPUk5SamIxelpHSkU3UXVTbWUzNm5LRm0zN3lWSUNkSk9uV2FCdTZMS3N2?=
 =?utf-8?B?VnU0aEphS2ZCVFZYMENIdlhHTHY2Z2lnOXFwOTBlQ0lBZGkxeWN2Uk1XMG04?=
 =?utf-8?B?b3l6cjFMWHRNMXpOMC9VTGN2dzAvVFVITVZvaVpZWmpsVi9BUFI5MjhINU50?=
 =?utf-8?B?bXppOVB4cW9iRXRMRjlqQ2loQldFM3plRVVkQVpaRFJReUNsRi9iL1hncld1?=
 =?utf-8?B?djd5SWlpZTRhVDJiOWdEMDVveFdUdlFLUjAwWW1ibG1uYzZIemRwUm9HV0xq?=
 =?utf-8?B?Tm5vNEFFMjRkejNwaHdxZHVPbDBzMlBmS0NhOFJ2YlBURkdROHFFTU0rWGJJ?=
 =?utf-8?B?S0I5TUNiSXo2djRmUmpNcW9kOCt6akVLeTBoUUpZYWFHSDgwVExudFJtOGlh?=
 =?utf-8?B?cDdhbTd0dnp0OEFDYS90RkxjU2cvWGorWFhSYmZQWVRmUERQdU81VnBJOVJ4?=
 =?utf-8?B?eG05YnJXQ2U3azBNb0pHWTBBc2VTZVlOUGI0bkNUY2FDdG4yY3Rya3pJSk8v?=
 =?utf-8?B?OUprTFlqY25qRTV6WWhWRCtvMmhlSTNaRVJXVnNiSUN5VFo3KzB5VVRqYVNN?=
 =?utf-8?B?RkpPWkNuaU04MmlJcmNacFlTSmFtZFVFamQ1NThJS3RhWVZZcG1qc2VHV1pZ?=
 =?utf-8?Q?kkw+YjdWvQvDQ9Zd4LsUFd3SkkwpdhA6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:36:03.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619897f4-8f0b-42ed-90de-08dca0fe63a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

On 7/9/24 12:21, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 09:36:03AM -0400, Stewart Hildebrand wrote:
>> Issues observed when small (<4k) BARs are not 4k aligned are:
>>
>> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
>> (<4k) BARs require each memory BAR to be page aligned. Currently, the
>> only way to guarantee this alignment from a user perspective is to fake
>> the size of the BARs using the pci=resource_alignment= option. This is a
>> bad user experience, and faking the BAR size is not always desirable.
>> See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
>> for further discussion.
> 
> Include the relevant part of this discussion directly here so this log
> is self-contained.  Someday that function will change, which will make
> this commit log less useful.

Will do

>> 2. Devices with multiple small (<4k) BARs could have the MSI-X tables
>> located in one of its small (<4k) BARs. This may lead to the MSI-X
>> tables being mapped in the same 4k region as other data. The PCIe 6.1
>> specification (section 7.7.2 MSI-X Capability and Table Structure) says
>> we probably shouldn't do that.
>>
>> To improve the user experience, and increase conformance to PCIe spec,
>> set the default minimum resource alignment of memory BARs to 4k. Choose
>> 4k (rather than PAGE_SIZE) for the alignment value in the common code,
>> since that is the value called out in the PCIe 6.1 spec, section 7.7.2.
>> The new default alignment may be overridden by arches by implementing
>> pcibios_default_alignment(), or by the user with the
>> pci=resource_alignment= option.
>>
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> Preparatory patches in this series are prerequisites to this patch.
>> ---
>>  drivers/pci/pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 9f7894538334..e7b648304383 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6453,7 +6453,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
>>  
>>  resource_size_t __weak pcibios_default_alignment(void)
>>  {
>> -	return 0;
>> +	/*
>> +	 * Avoid MSI-X tables being mapped in the same 4k region as other data
>> +	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
>> +	 * and Table Structure.
>> +	 */
>> +	return 4 * 1024;
>>  }
>>  
>>  /*
>> -- 
>> 2.45.2
>>


