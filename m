Return-Path: <linux-pci+bounces-4946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157D880F26
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D75B21F2F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B63BB50;
	Wed, 20 Mar 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFOXSEW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60B3BBC2;
	Wed, 20 Mar 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928618; cv=fail; b=rFo1gtQ9uMDRTqHbsa2VFzbqyQgESDNc7aacGyyf00zC1m3TfhN7PBox0lFBqVCI4E8vj1lDKOaOfFmn9S5Ca+lX6nGpeMAovGE/atokEBh1zqycYyo05Yh1rOVC51i9gCtovBt+zzLBnWMZMqe9syLRn4yarnsLTpc+zcIFkjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928618; c=relaxed/simple;
	bh=MsMWrjAGhoRe8DQQ/NNMuPc49p+PEXrqaXU0R312zrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8PvWfKTXvU2+NDYUroaH9WiGKvbd0Aw1Q856kGMhpZd0jFdmqoUIZ37ddt28aZUSVlc+m3W9//bXI6MrYojkel2Ve/iLiHRquIxBbkMxogqND1LVJ7cJXc7XraYIeLk5sUYCOYMyQhCwimXB/Jo1Iu2PIYrvHxeaEvHqzr7i4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFOXSEW4; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm2aMNS2LMdumH143by0Su1hQ4QVALP8qYObEa8V29nna29Kmz7o1HAifvzTaHj2pHcGsyYUvrp2IGOJNV1GfNxPMSGrzVEEfHb8orBZWpefPvsmAIl7Xe1/qNXZhvnnoPDjWhFlkQ5/KrchuOGXiTh6JdbQnMYjfHexmedW6ok0UorrnY6PzunxSHR/RibwV+Ropbxdrew0QmfhX/x78bhUqIRz1X79987L/tPKSXwCSFbEjPoQ+QdZt0Pp6JaocmKNRqRq53kbWnEcyOu9uhgIbgIjHvUYFKODkbRLexIX5urk4ghtF0PZVP0NiyJMCPzA7/xYP5YkKntDV5uSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UmoKZna9t9WQqNjLr9qivrOBw+yTKvX+i/QqLeWP0M=;
 b=gu8Pfbr+ipSiLhgOU/vlciDtNmvuVpymWhQLqA+mmDB3Mlm2wCTSbs5J21UMMGgM9UgC9vPHSsv06pxUXhsOmCTFtz8A9sQAw2JZt/duYnen/KOvAEY1roMZAYxO/BLcOAUwp5kJej8v9cDRqvmOux7CmrxdtIzowvf3C2at7mws0/IXTsJuSxee+HA3yZis353z97MykTEFneuDBd73DcTohfYfmIxqkaz8sCaHMOaNVMONgj5P5OJiWIkZljDHUSSfbzyh6yH4Q1q8JjPcto4IlAyIqFZduoAINTh++iPz1SWiebYJ9L9bQECmx5ayn3d7mS6lP91btWW4rGH6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UmoKZna9t9WQqNjLr9qivrOBw+yTKvX+i/QqLeWP0M=;
 b=hFOXSEW49WU9oeNmeQHR0COe1u88R7vvZPnX/FLBHvzJxxXcb9FSDelSsKRfhG3SHtsOUWnsA7NIiKx8OUSvjA36lv4+QPmp/EqwgppJmYQORNd4pBvfgXZZTdwYXtjc7QwoHDg4vjDL6cnRUMHEda/a/U7MhfZRXulCnwF+4Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 09:56:50 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f%6]) with mapi id 15.20.7386.023; Wed, 20 Mar 2024
 09:56:50 +0000
Message-ID: <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
Date: Wed, 20 Mar 2024 15:26:41 +0530
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for outbound
 window memory allocation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: a23c8377-20a2-488e-7c0b-08dc48c4105d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4WKZIPJMCAZieGjAnlrWDEvoDaTPncoMf+gtEih4MQH7M4RPlSUfh3SCMIpDN7RAtMOJGn7rmzkO4bTyS319oBkWi3gsJjtTPwpbFyTAtYiqWDCGoxKZS/n8icGRJdj/W+sLrS9OzOcED0SJHYqMUgAykieih4cTA59UXt7/vVstE4FG/xM2K0Vlld8QkTeSAclYsyQCtmKRHpXzeeYrX0wxFaz0OqsxVhYyfypmpPZ+vzMjOzrVP/KDVH2K4FMnVQ7Ig3v00/WoPH9ZNp4c4GFr8LE3MAV6GtIx6SL/9xF3Ai8k3lbo/vdMzTciZMNMgstSC8rQgXfF+WwFWLfIcvfp6ZmDkznZRK9upRx/36v4MuXCIRODrsw2V6jUVOPlFZmWZFcbk2exlse8Cq3xv7DNhdRqGlEvCB9KQcB7Kp+fqKyO2W9FbRF34xJ0bahpAs+Nof1uGjra9x0MPJ/Qz5hlvVmT8hYQbHlEBuA6+3Tubocod4SLP0ThGlZHCmn5iXjsC1qDdqqvYGhKr207RNFBRykvWo++P9B2oPbiu2HsMqwPjx3ijxWsuH4wqx5dOxxWVchJjNVu1Ww5LOzyCqj2pRIjxQ24z5R3xbmX750=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzUrUGlxY0kydkhYZ3U5b3NrWit5S2RZc3lVd0VOa1p6Qytqb2hDVldvM3pT?=
 =?utf-8?B?ZjdMcXNEMG5TRG9WOVVsODdsUXRDS2k4ZkFhTHRPNWpXQkZtUDJkaXBpNXRC?=
 =?utf-8?B?WDdSSVNIZEVKaHI3VnRUWU1yRjhIanZIYWx3RWJhSm1HTXdkNnI2MUlseHI3?=
 =?utf-8?B?MUk1WTJUQTVGYnp5SGlBdHVNSTh2NzNCdDVqaDMyQit2OFJUN00ydFEzaTNK?=
 =?utf-8?B?RTZ6cTJkSXRXMyt1M1UzODN6VmdaZXc3TGNIU21xaHl2Q2N5Nm94RE5PRnhq?=
 =?utf-8?B?blZUUlVsZ2gwM0JpRDBmaklEM09LdFdaWlIzQVQvUFUzWWFYM3F1LzZnanRZ?=
 =?utf-8?B?TnBscm4xc2VUci94bzBvU0JUZjVXY0xRNXcxUThQNDhKYjZneGxMaHJzNURW?=
 =?utf-8?B?eTk0eGo3K0hTZjR5bEFvMDVOV2tzamUySitwQ2NSM2FlK2tDR2YybktpYzNh?=
 =?utf-8?B?Wkp6SjNRaHh1NGdjMXk1YnpYbzgwUllZUlJrV1ZnYWJkMXhJVlNCOTJpNkxM?=
 =?utf-8?B?elRyeGNCc3RPOE4xR3lwaFgyczZzRjFYcWUzclJQbXdCUUpUdUJVTU93V0lj?=
 =?utf-8?B?RGxOMXdORkFKRVZqKzVWN0FKMzl3MFlockhvOXlvM2FLdTIwVVRLUENDUVFW?=
 =?utf-8?B?cFFZdDhKUkJpRU5pNVQ0WTQwRXJIVjgrVTRRdm9vOHYwaVhwM2JLbjdJeXNy?=
 =?utf-8?B?MmlTUkNldVlpaWk4WUg2ajBJRU9KS1ZWOWpZTm1yY25nRnA3S1d1NHRtTk5T?=
 =?utf-8?B?c1B2R2l0RmpOamtqQ0ErU1BvSVlFcVBaY3MyVnJIU0h2eC83NUdVOUtWTERs?=
 =?utf-8?B?UjF1T3RmV1YrUmQ1aWluYVp5czMwd1FBc3NnNE8yUmU2ZW5RakY5ZmZ2cWRL?=
 =?utf-8?B?Z1d2UXdEaVk2UlRvY2ZudXJhYzZRTjdtU0c4RGI5SVR1OEZVREFzeElzOGZh?=
 =?utf-8?B?WlZkRHNUQmlsYUgvdFFpT3hURDJZZlRlaThZYVArL2tOVXRGS0JxWUVVRzdm?=
 =?utf-8?B?L1ZXcWIvRmQ2Q3ZvWkphaHVOMXNUOW5JZTNodmJmbUl1QklLRVk1S09GVG9S?=
 =?utf-8?B?cDdlQms2MUJmQmhhOG9kVmZrNk83RjhMMmY5dUk1NlFWampIanYzK1RyL0NO?=
 =?utf-8?B?cDBpcFJmTzNveDlyQTZVcmNJYW1ZNnk2S0RnblVTM0JLOGltV1hXSkUzYTI5?=
 =?utf-8?B?clpQTnVVMWZhZlozMnNIL25raVZOZlRJZDYyaWFTVUtQbWM3TGVLU2NISE9z?=
 =?utf-8?B?dXBKcytDUXJvdDA2UmxBVFFLckNmd0dXZnVDR3JMMHlERXAyaVZTRlIwRTlC?=
 =?utf-8?B?ZCtha3BjZ0ZtQnhWcnRTVk9iNjcvQnd1RlpzdzRaN0dnVjdUUWZwczllNW5B?=
 =?utf-8?B?ekhaOW5vZTh0UmJMV1lHMW5ETnhVOVV0dXhWelVibkhhZVU0TFdad0MxSDBx?=
 =?utf-8?B?NkxDUnVWSEoyUVVkcmxtenhhUTF3blBDTlNiZ2hOTVVoTmhmRFdvb3lldFF4?=
 =?utf-8?B?eGYwcXR0Z1JzNTluenN2c3lRVzNqNkZlRGlJVEp1VmRNa3p4Skl4TEJXT29G?=
 =?utf-8?B?WXdIVVcxcEpsSUNYMXVqYlVieTBaYjJiUHc4bFBoa1c2djJ3TzZlUC9yYndJ?=
 =?utf-8?B?NzdjYldNV3BUd2EvK20wOGdlQTB2UFg1a1NvcThBcWR2M1NGQjBXeGRsdVJq?=
 =?utf-8?B?MWUydEQ4L3c1L2xqYmxyN0xzVGhJY0dFRjJ2eWpwNjhGYW9PczhRb2JPbUZx?=
 =?utf-8?B?UUYwcGh0NDhGait4ejBGZithMUpHQ1BIaGpNajVCbGRaMHI0K044V2pTSmho?=
 =?utf-8?B?NDRQcEJwK3k1MitIc0hESW40dkJhend1ekdzQU1CWGxvR1hLOU4vU0ZtWDFV?=
 =?utf-8?B?QjhpRVY1VzJ4LzlqRnU5dE5zSUJLdjFRUzVZNGJnSWdaSDBHVHlMNXdQWGZ5?=
 =?utf-8?B?L0FORTRSVWVDUmNnN0ZYMHpPcUtOYzNlVytxT3RJUGVOcGIxRU1EN21wRFQ2?=
 =?utf-8?B?aHJVbHl5RDdJUE9BKy9sZDQzUEdzWFBUc0g4NGF3WEZSNkRVblR3aThhVGNM?=
 =?utf-8?B?VkU3OHFxSS9BL0lWQURydWRoaXlQdUpPNDhJTVhZYnFIRWx2bkhiaXJEUjhN?=
 =?utf-8?Q?qIivlKBmFgrJ09Ci4Nr5KGez8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23c8377-20a2-488e-7c0b-08dc48c4105d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:56:50.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gKdDsp2fp7qFKFXadna2oYN4dF92nqy7JjGPkmENj13xutTYm+hFfrhwycqrvnQd5auHS4q386SKNv9bl9gKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693

Hi Mani,

On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
> As proposed during the last year 'PCI Endpoint Subsystem Open Items
> Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> framework for managing the endpoint outbound window memory allocation.
> 
> PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> driver from the start for managing the memory required to map the host
> address space (outbound) in endpoint. Even though it works well, it
> completely defeats the purpose of the 'Genalloc framework', a general
> purpose memory allocator framework created to avoid various custom memory
> allocators in the kernel.
> 
> The migration to Genalloc framework is done is such a way that the existing
> API semantics are preserved. So that the callers of the EPC mem APIs do not
> need any modification (apart from the pcie-designware-epc driver that
> queries page size).
> 
> Internally, the EPC mem driver now uses Genalloc framework's
> 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> based on the requested size as like the previous allocator. And the
> page size passed during pci_epc_mem_init() API is used as the minimum order
> for the memory allocations.
> 
> During the migration, 'struct pci_epc_mem' is removed as it is seems
> redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> is now used to hold the address windows of the endpoint controller.
> 
> [1] https://lpc.events/event/17/contributions/1419/

Thank you for working on this!
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
>   drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
>   include/linux/pci-epc.h                         |  25 +---
>   3 files changed, 81 insertions(+), 140 deletions(-)
> 
.
.
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a9c028f58da1..f9e6e1a6aeaa 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -4,37 +4,18 @@
>    *
>    * Copyright (C) 2017 Texas Instruments
>    * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * Copyright (C) 2024 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>    */
>   
> +#include <linux/genalloc.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   
>   #include <linux/pci-epc.h>
>   
> -/**
> - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> - * @mem: address space of the endpoint controller
> - * @size: the size for which to get the order
> - *
> - * Reimplement get_order() for mem->page_size since the generic get_order
> - * always gets order with a constant PAGE_SIZE.
> - */
> -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> -{
> -	int order;
> -	unsigned int page_shift = ilog2(mem->window.page_size);
> -
> -	size--;
> -	size >>= page_shift;
> -#if BITS_PER_LONG == 32
> -	order = fls(size);
> -#else
> -	order = fls64(size);
> -#endif
> -	return order;
> -}
> -
>   /**
>    * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
>    * @epc: the EPC device that invoked pci_epc_mem_init
> @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>   			   struct pci_epc_mem_window *windows,
>   			   unsigned int num_windows)
>   {
> -	struct pci_epc_mem *mem = NULL;
> -	unsigned long *bitmap = NULL;
> -	unsigned int page_shift;
> +	struct pci_epc_mem_window *window = NULL;
>   	size_t page_size;
> -	int bitmap_size;
> -	int pages;
>   	int ret;
>   	int i;
>   
> -	epc->num_windows = 0;
> -
>   	if (!windows || !num_windows)
>   		return -EINVAL;
>   
> @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>   		page_size = windows[i].page_size;
>   		if (page_size < PAGE_SIZE)
>   			page_size = PAGE_SIZE;
> -		page_shift = ilog2(page_size);
> -		pages = windows[i].size >> page_shift;
> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>   
> -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> -		if (!mem) {
> +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> +		if (!windows[i].pool) {
>   			ret = -ENOMEM;
> -			i--;
> -			goto err_mem;
> +			goto err_free_mem;
> +		}
> +
> +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> +				  NULL);
> +
> +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);

Do you have to ioremap upfront the entire window? This could be a 
problem in 32-bit systems which has limited vmalloc space. I have faced 
issues before when trying to map the entire memory window and had to 
manipulate vmalloc boot parameter.

I'd prefer we find a way to do ioremap per allocation as before.

Thanks,
Kishon

