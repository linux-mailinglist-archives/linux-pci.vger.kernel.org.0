Return-Path: <linux-pci+bounces-36374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64AB812C5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A56162520C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCE2F99BD;
	Wed, 17 Sep 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTEeHA8w"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDE1EBFE0;
	Wed, 17 Sep 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130107; cv=fail; b=JNjQQTDieK6PhDQ5vH26c0Pn0XLb9JqBr6IudV1btn3HNKDbLAGNiXpwlu7tmQNQeeIrlU3xMc2Un3GKE4irB/rojPgEPOz1Y3JHxQ4xyEDJ6+vno7TjLMDO2kZOL8ED4bCKl4hbTODymjnbuInKMJJkMVxLyCKeVO1B+o//8Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130107; c=relaxed/simple;
	bh=YHFO9/zxiJ9ct4opqlUFszVQ00QNHOqGKA90c6GcTYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bWA+sEKiniZCQ2Q2wRz08fEpAWLur5ppo3jAkQZOszkIAx8V6geWWJal/ksVKR13VVzLJlEHjhUlnPYw6theN2pEQ7WmWhAv5XtvPI4NqVd2JkGxSvWDNvpWvAhLUrfvj93z+UA3eqkyKm1eswiNW25zOxUr+vCI4wAfmF+i6ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTEeHA8w; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfuXzwJgsngfZz5bpp1gj5ZmUZMKIHs39sjzChWpFdhCUkEhKGP2MRhCCcuBeVp7f5N7d6OZbfXBnBfkFAPQt0ahK84Cxyg137+HO3uJ48q//bCR53h+e7MIBrgQn/zRjVA/o+8C7GE3uZdedeV7ghaVv77QawD0SIlfTDHoJjxlwOeVouLy6jqtx8UoZdYjeDUdeP85GURZmYslvVzmmdiUsPQms/D6emEB4RHA2lzvtvewKIs8beKb1R+URM6zzam+2puX/szKW3E5dSZFMiFBbCUZuAuhTKut9knKPh2o8YkppPI299WzxI4FYb8oRNNdz5no9A2OhgZ2X865DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iakf4izHM76/2wqGG/hLxtQyAIrporw8OzsWWmZXLO4=;
 b=S6IojkCJ+LPCClfWHYPPymYG950oFd4OMebYj+3fwe4C9GZ677dCEcbEV5d1z2WgVtfZA7jR73gUQKVA8oMJdOvHrcphmYM2Pb5TdIAg2B6UseoJjGQY2iSYxqjCNCzQNe6JGOfHEiJn1vMJamIkph+N13JC4i6xZd1mqADbj8qYrI/JX9cztGsCgarFbfYlhobgpGSXSNhHrIMv+lQW8g2E3B8HeIJwuPeKLT9LLoRn3LqbSnu1dQducAohI0ZIJI68b2J68GrFKIYUtC/VhC8vcsJs8Y57AJrHigvWQJBINrjCzT2trgZTwAbR3VdyYAw399Y3MN92JIFdX+Vdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iakf4izHM76/2wqGG/hLxtQyAIrporw8OzsWWmZXLO4=;
 b=iTEeHA8wfzbWUi2AS3X+lfQKbZeWACUInC6VuHMz/FckHcMu12v6RdXKkUZgGBoMh98j5V49ZSTVV1Ncwp3yLDU78UhcShJJ0r6NxzlMA5ZzDcEQs64FxsGvnTteZYfXNzwrhLs9p0CGg5uWzN/3yU/HuerXs2dJdLIs0yDK40M=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Wed, 17 Sep 2025 17:26:59 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::cc) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 17:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:26:59 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:26:58 -0700
Message-ID: <d41ce9c7-94b2-47c0-8861-811b2c11d557@amd.com>
Date: Wed, 17 Sep 2025 12:26:57 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] cxl/core: Enable CXL.mem isolation
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-7-Benjamin.Cheatham@amd.com>
 <20250912162121.0000484c@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912162121.0000484c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1b0d32-ac70-484f-1979-08ddf60f684f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBtODBMMjhhdmdjbWpXY3p6bmpDQTRpcjgramVWMUhwaGtiM28wYUFqY3Ji?=
 =?utf-8?B?eEIrMytkbGVNWmdNeUJmMVU5UEVXa1RVM0l1SmR6UlFpc0RjeGNLNno0K2U1?=
 =?utf-8?B?ejFFZGI0ZGdhV09xTzBaRFVtZHozVXNqdmhYSVo4WFlYRzZ1Q2FBSUJtQS9x?=
 =?utf-8?B?eFlndVJYcU1ISTZ2RDMzNmVxbEVaMWJjUlQwRzJlY0FRYmIwNFEzUnRlRTdI?=
 =?utf-8?B?dTdYbVQ5Y0t2VXVIQ2RhaVV4bWhwWXA2VVAzWURJVTE0ZUlsdVA5WWF4eHNO?=
 =?utf-8?B?YzRhYzFUa3ZIYnZ3dHZXdStoRVpKS0E2KzNwVDNhcTM5R0NmMG9HVysvdkVp?=
 =?utf-8?B?SzVZTXprZkhQaFgyTWtvc0NOcFp3Qkd1MmNEby9QOVNqdktvc212RTlSNnp1?=
 =?utf-8?B?ZXhDR0I4N1pZQjVnSG5TVDRSNEludDYyZjIxSnNJWmE5TU1VMlNFbHorSXRj?=
 =?utf-8?B?SHQwZjA5dGtVcE5KcUEyM3ZRYS9OY3djV2hMcjkvZHhLYmc0SEdYcG1Dd28w?=
 =?utf-8?B?eVk1Q1ppTlczTklydmp5SjdQRjg1clFQOEFsc3ZRQ2V0OG16Y2oveWIra3RI?=
 =?utf-8?B?ZmVJdTljbDFibFV4M25xWFdVTzFuK29zb1VlOXhTOThyaUNGZk1QQTdHUHhz?=
 =?utf-8?B?eWtKQk1Ga0hZRUROelIzWjErUHNIejMxTVJiRmRZM2EydSt0TUdjdUhBUmdD?=
 =?utf-8?B?eGh1VFY5aHJISGwzT1dJbThTOTFFckE0czZiMHBnU3V1WkR5NHJyNFBWaXdD?=
 =?utf-8?B?ZzBmcFZLV3pmVGlpZzJpQ3lIZEwyZHhVaXZnNm5WeUU2MW5LdFg0T1ZUS29B?=
 =?utf-8?B?bUpvRVc2VnRaRStLMWZuRm5uSTdSRGtPcHlTT2dla0JMTkdzMDh3akhPQ2tW?=
 =?utf-8?B?MGF3OUlnR29KM1VoQVJHOVBzZnYyM2ZZeWN2ZmxSNGoySHcwMHFaMDlrRnlU?=
 =?utf-8?B?WGZhTWQyTUxYdnplcVJJc2VzUCtZTThCM1dnM0loS09ZWVFIRHVsLzVsS2Vs?=
 =?utf-8?B?MWFsSUZybTFpNGYrVTJ6ZjFBN0tHeHljNEtSd3B3UUlEMFFRYVlZa2YvWUFS?=
 =?utf-8?B?SzloYWdFdFg1OHhLTGdKT09yVmxmYlQyNFI2RXRzQ25mM1FDUjZKWG0wZW1q?=
 =?utf-8?B?Z1F6NlNCWG4zTDZPT0lJN25rVG9HYk1FeDdOemUwWXVYcHV3ZXZQUFVBZG8r?=
 =?utf-8?B?a3JvVW4vU1ErUjdERkFJaFY5YmJ0cmd6L0E2UXlHNlNHMllyaXlMMzlUMnk3?=
 =?utf-8?B?ZUM1Y056UUYvam5vQnd5R1lNUmNtSlZ2dFMyWXBZSEgyM1d1QzBBdWxOOWh3?=
 =?utf-8?B?SU0zRDFFRDJZT0VGbHpYWDdKbVRkSlhuVWFZVWtkd2w0RjhzV0FpcWJGbUFE?=
 =?utf-8?B?QnBvRkh0NWUxcEhWRXpqOUI2a0NKQXZVNEV0ell0Z05XUmdyeGhpdlJ0enNx?=
 =?utf-8?B?WVErTVRYK3FYc0dLVElpRHY1c0RBdGg1N3A4VWNoZW5kaElDWGxyVVdySlBk?=
 =?utf-8?B?M3F3TmRKdmdlOEo1a2RBVGR5M09vUG12a0FyUy9DTkxSbUtzUlAyYkJJVTQy?=
 =?utf-8?B?TkZmS01yWWxuU1Zob2R6T1FuZ0p1enFPZFk2N0VyUFUxZGUwSWVwVldPL2Ji?=
 =?utf-8?B?VWNXSlYxbEpFcDBkMmtISE15OVhlWFNLSW10RlMxZ0FiazczN1EvZWJKYmMy?=
 =?utf-8?B?UXZlQ2tYb2lqa1hsdWkyY3UvNTZMcldobll2V3oxUVA2akhPUWJ6eDQ4TjBK?=
 =?utf-8?B?ZG9hWCsxTmFYWUkwQkpzQXpTUGpqZEdqWmRKMi9qZ3VVblVZMnJNZWZSY1Zt?=
 =?utf-8?B?ZmpGbFRCVWlVTHY2ZEhhTDNuVThKVStGQWF5eCtwQWlPRGJuZ2x0NWdOblZP?=
 =?utf-8?B?MGc4bUFtR3dOOUx1VnNqR0Y1NEQvekZpYTdsVDhWMVEyYUpMNldSd0FJRkJB?=
 =?utf-8?B?UUZ1eEttMzk1ZEVMWlBpUEhFdm9YdmdmZzkxWUZ1eUw2djlLQUlZMithb28w?=
 =?utf-8?B?dE56WWlDM3JQRDFyMzlCaXRrRXlFNHhxVi9IZ1RNaGlWV0VvT1hJWHNjZkhW?=
 =?utf-8?Q?RBXR3j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:26:59.0631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1b0d32-ac70-484f-1979-08ddf60f684f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158



On 9/12/2025 10:21 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:08 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Enable CXL.mem isolation during set up of CXL-capable PCIe Root Ports
>> that have the capability. This capability is optional, so failure to
>> enable isolation is not an error that should fail probe.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
>> +static int cxl_dport_wait_for_rp_busy(void __iomem *reg)
>> +{
>> +	u32 status;
>> +	int i = 4;
>> +
>> +	do {
> 
> readl_poll_timeout() in iopoll.h should work here.
> 

I wasn't aware of that, I'll check it out.

> 
>> +		status = readl(reg + CXL_ISOLATION_STATUS_OFFSET);
>> +		if (!(status & CXL_ISOLATION_STAT_RP_BUSY))
>> +			return 0;
>> +
>> +		msleep(500);
>> +	} while (--i);
>> +
>> +	return -ETIMEDOUT;
>> +}


