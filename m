Return-Path: <linux-pci+bounces-6389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB358A921D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 06:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124741C20CD8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AED41A88;
	Thu, 18 Apr 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j24EWFh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9131E532;
	Thu, 18 Apr 2024 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415511; cv=fail; b=kTY7wJyswRVZLgcn2aHx8Wy3pwskMswnI7QAnrIcAVg0F7q1rHzgzUhUj8odnSjShD5VkL9S7j5o1sn6JdY7nwt2OGnIJxnYJHznBKZJusxBZqZSqH01G4v7ubVbn3H5HLFlQHQhC87z31BTZukJnnw+87oMBRJVp2xT73QyeyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415511; c=relaxed/simple;
	bh=xn915V5JAqCdCCazFRgrI/IHpPQevjJeX7DTwurPFfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TaeEkrZMyA5yPHyKETB3Dppj6uX3+kn7kgXHIa1o/7g3o01eIsOiFomhj/1kqJCvXjcDbpde+j9Z5RpzSDcWHUs//jiOedDTAAO3Ij5ql/0WQ10bNwVnRudiNBzqws8kBuh8f75HjPeteFFj9CIR3H/KUNh/lV/JmBwPx4/NNJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j24EWFh7; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO3BVOBtMFh6/NAGx7Xxu+wLNGp7RVVkutossDC0BzOfF1Gkpe7GmURhVFffnUahU7BVLkr1IxumH3yiGnr6/ZLUnkc6I26y+LsIFcd+FQec6+t6RQguIJuOH+9ByM5JAmjAuWz9z+BOPSgQuiOt+wkur3Io2KYXo7uaLgyaKxm9JF2eUn8k9xN64whBtIOKO9Cq5HdpHv+UFqVTmzobwRJqn6hOGQF621bnxJMT4SLyo7ifQOfSPQroqTzEZyR3O2PkcxJDBM5USctuDdFCTWS8OGjwrLbKhINM6nZIzHKlE/KpjVcLQOSThWKHay9fqZbr4HOPvZ5YO7u6ocznAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK7nLH26DQz4tGXPVFekAPVFvw0NhAeXkFQKwwQaGC4=;
 b=mnuQb92r4cfg+/on1HIeLHM0sN71Ho3uuHe1Ja91d1oJQYM6A2jUscrVTp+HIWhv8DOiOgrWczidhXwvZoJWEGuwgoCNypxgM1fQM1m5UjvcDAxiVOLG511QoeiJhuzrbhV34a58+Y4eyc2F9BHGoG0NtwCMneCiaufjJtSlLUFOlQt/Rytlk4SDXfaqmLBhi01DgeQL+Lncy/SA+n0g9I3Op6JSAblfmEK2heBYAofSEZw63KuPdmMlDcnJIHIOBzfyRlbrry26df44o+OybPm+tPxMFjDPBcvl4u/M6ACk27Nr9zT5Yw8VJr8bafmQUXSTY3f4+xYfvgjFiw28zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK7nLH26DQz4tGXPVFekAPVFvw0NhAeXkFQKwwQaGC4=;
 b=j24EWFh7UjqHlDNb2pOcHvz46RFEd3qnSW2dkLT398iXTax29pUThnS7gjHBHW7QTy2b0GCQWZ3S2RZH3F20v4fPDFZQdygmkSpQKAHRUQCyATFzb3LS1Zu7+tMhcUGkFPfSfw+8NBa59X7gALI8MTQ6FpGD8Q/4q5RXk/xrcBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 04:45:07 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::a31f:d5e1:a2fb:b24a]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::a31f:d5e1:a2fb:b24a%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 04:45:07 +0000
Message-ID: <6984ee8c-7848-46f8-a421-1b31d8c2231a@amd.com>
Date: Thu, 18 Apr 2024 10:14:57 +0530
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for outbound
 window memory allocation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
 <20240320112928.GB2525@thinkpad> <20240414130058.GA2231@thinkpad>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20240414130058.GA2231@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b79964-fb84-4fb6-ede0-08dc5f625201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i1JIjZ3BFk8m8BPEGb9ev7fHOkN2+FWMpdh1p//YF/S31C3i4AKnmTioSDdQI/4DCjUZAXR8JHeprSX/3zEXSzul7yeH6rGSNixh/nTj/YgKKCc8VBtRSf/rFqjCrXNdrL1vTcBj+Ryl1whthPkf9hfJn9uq9mi2v5koyL16BEKywHzAGVHwEQflAFOHZzGS/xTb50788BhnPWQL/0RhOO8FhaDc84nY5r8c2o9T9St4yVq2KOnf4R1IC3qUiFzgJht0r7fzLGirCnG4btA8Fm25s34JENfI/k5YD78NX9DuwNVyqxiDUtQJiTJebWmm2lSStEsWCj3C7IkOtXkpQMhHssdMACgUCo5zVke5uxsXe3SP1tRrDlCHDUvWioQOuX0BIEF+iX2h4e8jYPSIUgeJYKyPnAyY2WwQPCPhjRAxuEaLRb3XACpc1CdiESLomCX3ZLVq4siSXi4+YSpO5KqVeit6bXzqHWKDr0YTComGVF3G6H1G/0cWIV9gb3hALdzpJObJiCDAhv/trMjbFfwr1h+aPlORCigNqUyUS5qo1S7XiN5iO2iiJPFxdQZSWjIhkOQdS+gg4v3QeRu0P8HKUdAl6SR8sg1AlI+rIkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1pPT051RkZ6SFMxZS8vaHpzajdJWlpOYUVIVVc3Kzl6QmhwRytWSmFFYTh1?=
 =?utf-8?B?aWZyY2FMbFVoY0ZvTCtlNldwQTY5TFlBS09yK1o1VDNLb01KRG5hSVJ0ZVZr?=
 =?utf-8?B?MXcwbHNURUY4UVBKc05QQ1BjVGN5Uk44VFNhUnhoU1g0SGZVTDBmb3dveUZT?=
 =?utf-8?B?QjJ0N1JqbzhHOG0zQ3lmZlN3ZHhrNVhwcHB4SWpQczhvdi9pRXNrQXpTY05M?=
 =?utf-8?B?LzJ2cUgwVnVJWUJvWWNtUEljaGdCdWlzcHcvbko4V2g5WVkwa3M3TzBJL0Fr?=
 =?utf-8?B?K0plZjUwWjJXSTYvdWR2RDR3ZFJKZnZnWGNmTXA0eVh0dWNjUlRVeUpBQktk?=
 =?utf-8?B?eW9JVFgwODAxU1AwUGNaWWNzSXh6U1lVWExqeU1sSTY1TU1RYUNKZHQ4YWEv?=
 =?utf-8?B?WHJTcGc2NklkSWZMdjUxT2RxdDgxWlBFa3FPWmtLVDVrMWJlTXh6TkZnTHFt?=
 =?utf-8?B?RHU3aUVNWmtsejJUWGtSTU9yQjI5RFRlK3FMZEV0NnZZTmtLa3dRL2VMVCtz?=
 =?utf-8?B?Y0RGVjJvWmZPWUQ2NEVCdTVTdE1pYVlFY0N4TDRsVlEyWTZGRkJvNi9aV1c4?=
 =?utf-8?B?TVF3ZG43ZCtQRk1OMU54SEwxNlFxRURBOFV4SkZsZ0JGdllzMUFQUGtTMHVP?=
 =?utf-8?B?TEhobGJGaEN6eXFuY0dDZXViN2svRzJPVjZGZ1JMQTRBWTI2OE1STE5LMlEr?=
 =?utf-8?B?K2Vsd2F4N3g5UDRCYXhRa29mMk5ncE16QVJ6MXhNZzEzTHZ6aWhKRWttbWpm?=
 =?utf-8?B?K2RmbERaOGtSTXVkbVoxcEYzbzlRakI2b04vd3p3bU9XZ0dEMVYzSUt0azNO?=
 =?utf-8?B?bzJ4dFBMK2w3dVI2ekRpOWVtRTNnS3o0eGZERFhPeHptai9CUTNsL0MwQXhT?=
 =?utf-8?B?VHNIclQ0dkhnWUJ2QmR6QTF4K2ZxNXNvT3cyQU9wN3hLYUxqbkROSnJmQjZt?=
 =?utf-8?B?VERsb1VtRzk3VHdHQW9mbWg0bGdMUkFBcjMydjc2NmFSZE9rWlE3Wmcycmgv?=
 =?utf-8?B?SGRnWVE5d2hKS1BKZHR4d21rS0luS3ErYWE0cW5OQk8yb1Y5OXltQ2J2NmhZ?=
 =?utf-8?B?WDhQZm5iUWt4MzFXUFp5aUJuNTMreE51YnpIbHplWm1ZSVB3Z3cxZEtzV1Ri?=
 =?utf-8?B?KzJCN0tZbzVNUnhmM1UyVDlFN1dnQmdWbmZYVkp3NWZYNFJvb1h5TjJsN3V4?=
 =?utf-8?B?S0ZiczliSnlyOVM1dGlCYm9uNlYrV2hIbUh1T3p6ZnpDdnY3ZENvdDljdjN3?=
 =?utf-8?B?aXdmMjBkOVorckQ4c0drZUNFV2ZSMi92S3c0ZUZpQWN5WGxVeVdJODE2aE1l?=
 =?utf-8?B?YVpRQTdRMmVpN0pDZ09rdTZUa0U2R2Jzd1NBWitHQ1NTSnFqWVBxbDBLMHNW?=
 =?utf-8?B?Qk9IWTBEcTR2UXA3M05TUDk2WkQxMmpTcWYyVzVBMFg2cTFGR05qK3N4dVEy?=
 =?utf-8?B?dEtsUEovSTNuM0RVNjVxeWo3T3FhbXhxRTdqNjgvWlpoT3dweDRKeU95Q2p6?=
 =?utf-8?B?QTNLazdCTHpsbWhrUGRtQzVUdE9iL2JSK29rMUdvOWszYzJId2h6c2xVc2FW?=
 =?utf-8?B?N2NYVVNhbGhNRHVqSTliSXBYT0JDdzVld1dtSVc2YkVvNG5PRWxKMjlPUWRN?=
 =?utf-8?B?S2lEQWF1d2tiZEtHMlltYnZJWitmWFYyaTh0UVNRUjhFbUVEMjUrYUM4SWla?=
 =?utf-8?B?Nm9kQkx4M2VRVFp0S2EwR2lUbUZmUzlxUGo1OTl2SUVmcVVuSGEvbGJucUdM?=
 =?utf-8?B?YzQ4Tk9YR213amtwaE00UUdZakZIRk5Cd2VrTWpiYlpFc3dXMmtBajZYNlRh?=
 =?utf-8?B?MXpQcXFERlVyajJDRmJvZlNPc1NRejJJN0xQdVR5N0U2dFBHd3gwL2FZSkh6?=
 =?utf-8?B?dE9tejhGeGhnd3JzdGR2Q0JmQnR6MnNrVndqRTlNYXNvU2d0QmdQa0V1Q25R?=
 =?utf-8?B?ZzhYMlFhN3gvU3VoN0Vua2h5TnMySmtSNUtDeExrYmo5TG1BczNXUHc4VTY4?=
 =?utf-8?B?UjIvZXhXaUVDNExjT0ZScGE5WlNoeDUwZ2lFa1pxRlBrQ0xHcktsKzNEVDMv?=
 =?utf-8?B?R1BTZjBoSEhKemtNa0g1UStrZkRmaUhVLzl0VHRsUkZzdHcyMWZBQTM3OEs3?=
 =?utf-8?Q?fvCWxaNOkm3FabUIN7vZD+LeI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b79964-fb84-4fb6-ede0-08dc5f625201
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 04:45:07.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXCvpxikfBaJ6Zx31DeXN7ILrLO9f0BtaK+w68eKp6eJfdQVDFeXq93+7ME1ZZlqXbjpm/cJge4MiDz1blC9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

Hi Mani,

On 4/14/2024 6:30 PM, Manivannan Sadhasivam wrote:
> On Wed, Mar 20, 2024 at 04:59:28PM +0530, Manivannan Sadhasivam wrote:
>> On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
>>> Hi Mani,
>>>
>>> On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
>>>> As proposed during the last year 'PCI Endpoint Subsystem Open Items
>>>> Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
>>>> framework for managing the endpoint outbound window memory allocation.
>>>>
>>>> PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
>>>> driver from the start for managing the memory required to map the host
>>>> address space (outbound) in endpoint. Even though it works well, it
>>>> completely defeats the purpose of the 'Genalloc framework', a general
>>>> purpose memory allocator framework created to avoid various custom memory
>>>> allocators in the kernel.
>>>>
>>>> The migration to Genalloc framework is done is such a way that the existing
>>>> API semantics are preserved. So that the callers of the EPC mem APIs do not
>>>> need any modification (apart from the pcie-designware-epc driver that
>>>> queries page size).
>>>>
>>>> Internally, the EPC mem driver now uses Genalloc framework's
>>>> 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
>>>> based on the requested size as like the previous allocator. And the
>>>> page size passed during pci_epc_mem_init() API is used as the minimum order
>>>> for the memory allocations.
>>>>
>>>> During the migration, 'struct pci_epc_mem' is removed as it is seems
>>>> redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
>>>> is now used to hold the address windows of the endpoint controller.
>>>>
>>>> [1] https://lpc.events/event/17/contributions/1419/
>>>
>>> Thank you for working on this!
>>>>
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
>>>>    drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
>>>>    include/linux/pci-epc.h                         |  25 +---
>>>>    3 files changed, 81 insertions(+), 140 deletions(-)
>>>>
>>> .
>>> .
>>>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
>>>> index a9c028f58da1..f9e6e1a6aeaa 100644
>>>> --- a/drivers/pci/endpoint/pci-epc-mem.c
>>>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
>>>> @@ -4,37 +4,18 @@
>>>>     *
>>>>     * Copyright (C) 2017 Texas Instruments
>>>>     * Author: Kishon Vijay Abraham I <kishon@ti.com>
>>>> + *
>>>> + * Copyright (C) 2024 Linaro Ltd.
>>>> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>     */
>>>> +#include <linux/genalloc.h>
>>>>    #include <linux/io.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/pci-epc.h>
>>>> -/**
>>>> - * pci_epc_mem_get_order() - determine the allocation order of a memory size
>>>> - * @mem: address space of the endpoint controller
>>>> - * @size: the size for which to get the order
>>>> - *
>>>> - * Reimplement get_order() for mem->page_size since the generic get_order
>>>> - * always gets order with a constant PAGE_SIZE.
>>>> - */
>>>> -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
>>>> -{
>>>> -	int order;
>>>> -	unsigned int page_shift = ilog2(mem->window.page_size);
>>>> -
>>>> -	size--;
>>>> -	size >>= page_shift;
>>>> -#if BITS_PER_LONG == 32
>>>> -	order = fls(size);
>>>> -#else
>>>> -	order = fls64(size);
>>>> -#endif
>>>> -	return order;
>>>> -}
>>>> -
>>>>    /**
>>>>     * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
>>>>     * @epc: the EPC device that invoked pci_epc_mem_init
>>>> @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>>>    			   struct pci_epc_mem_window *windows,
>>>>    			   unsigned int num_windows)
>>>>    {
>>>> -	struct pci_epc_mem *mem = NULL;
>>>> -	unsigned long *bitmap = NULL;
>>>> -	unsigned int page_shift;
>>>> +	struct pci_epc_mem_window *window = NULL;
>>>>    	size_t page_size;
>>>> -	int bitmap_size;
>>>> -	int pages;
>>>>    	int ret;
>>>>    	int i;
>>>> -	epc->num_windows = 0;
>>>> -
>>>>    	if (!windows || !num_windows)
>>>>    		return -EINVAL;
>>>> @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>>>    		page_size = windows[i].page_size;
>>>>    		if (page_size < PAGE_SIZE)
>>>>    			page_size = PAGE_SIZE;
>>>> -		page_shift = ilog2(page_size);
>>>> -		pages = windows[i].size >> page_shift;
>>>> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>>>> -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>>> -		if (!mem) {
>>>> +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
>>>> +		if (!windows[i].pool) {
>>>>    			ret = -ENOMEM;
>>>> -			i--;
>>>> -			goto err_mem;
>>>> +			goto err_free_mem;
>>>> +		}
>>>> +
>>>> +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
>>>> +				  NULL);
>>>> +
>>>> +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
>>>
>>> Do you have to ioremap upfront the entire window? This could be a problem in
>>> 32-bit systems which has limited vmalloc space. I have faced issues before
>>> when trying to map the entire memory window and had to manipulate vmalloc
>>> boot parameter.
>>>
>>> I'd prefer we find a way to do ioremap per allocation as before.
>>>
>>
>> Hmm, thanks for pointing it out. Current genalloc implementation works on the
>> virtual address as opposed to physical address (that might be due to majority of
>> its users managing the virtual address only). That's the reason I did ioremap of
>> the entire window upfront.
>>
>> Let me see if we can somehow avoid this.
>>
> 
> Looks like we have to introduce some good amount of change to support dynamic
> ioremap with genalloc. But IMO it doesn't worth the effort to introduce these
> changes for some old systems which are supposed to go away soon.
> 
> So I think we can keep the old and genalloc based allocators and use the old one
> only for 32bit systems and genalloc allocator for the rest.
> 
> What do you think?

sure, that should be okay. But can we check with genalloc maintainers to 
see what they think?

Thanks,
Kishon

