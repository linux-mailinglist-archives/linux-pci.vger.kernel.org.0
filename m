Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE95420E91
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhJDN0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:26:07 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:10080
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235037AbhJDNYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 09:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcLgTEcgaZm83N489GvkNHonV+7wjuOIw+8tdZPSe+ocdLVLMjZyno49i+/dg3pHe6wiD367yxCLsRB47wKQ0MijwRutGn6fi2nf+f7lB+R3D90g19yZQ+NbSInics2cEYpB1J0lquh7bFRx+ZEucs0JUGoyPX85w+j4Ubdmpdx0dY5NNNqrH235zNIkbgUbZ7in5g+6Byr8jQQvi3Nml2ilg+/HL8HzarSPkh3Sh/Wc4Au1qlpOw7cmAOxS1SbPEKQ+/ZV9DXQ5Yfw/YLwNq6a96UTh6W0xMydFj3L1qHUwFXImWuK1jKSWtXEnjWxp1mme5rH22W6ofZPeR8xTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAU71db1p8rdQgUjQB1Ns2sk4eURkc+wtnNP8/tDPHg=;
 b=ESuZa1gz2RbbsZr20B7mS9i8TWVRxwOemOpm4pYRu6fpQqfOC80ohXaoNmoi7O0OdUB1k8mJnXvurxumyPRMBQVGYfUBsoz3oFjT40nQoHFAZR2jg3HxVdtx/cE8Vz1QaQ6y6QAHAEtte/RF524WcX2qfmrkFpm1dV1VoPWpbUeuZKpOVW8baZ6mVAlw5FQZWoijP6N7qF6kWofWNbBMMyhksLUuk78J+g1t8ArT2Tr5sguZFSH++v64CITaSTbJ6CMpzojYBEJNViqsIPBPoB3+cMplpa2oBJZ5HHE5SW5eD/jLjKbHEjcIaIVzRJp23lubCgcolKzxPPdATjHy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAU71db1p8rdQgUjQB1Ns2sk4eURkc+wtnNP8/tDPHg=;
 b=0B0BVZl1w+La4sfzhJjZqexiinsHGuUdUHDYMc0RcAmgWapzah3OC6dczRd+Nh6FI1y/pv9XEzJwHDcUliAimRWVhJJqJKOittZP3Lna0GmtR2IaeX74tQg56fgVKINqHqBCxQqHF6evgEg6PW5ReGCV88uzHWlTeZZYpvAOS74=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0112.namprd12.prod.outlook.com
 (2603:10b6:301:5a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 13:22:37 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 13:22:36 +0000
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
Date:   Mon, 4 Oct 2021 15:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211004131102.GU3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 13:22:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faa79b9-a537-46bc-3f3c-08d9873a0817
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01121264D0A33595A226C0D883AE9@MWHPR1201MB0112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BEBo5sJrqIfeOlANh57LEpsqiq87iyNtxcceTwZFjCIreP60DaaTPm64JE9zY/6n63kSzDaw/1vjkhgy0syyxpWI+KbUk6lQObiz4HDjj0ZRcKwsd8+BdNHFn5qMR4RX92GAeU7C+Y5QQ84QxMLRhdmNyl5evyckI9Y6E7h+X+wcIrFxqcU+UXQYg4qHV8lQxM7i8pFYV3fpWwAkzfFSV3SBy5ZnG9rHZFPvQiJq3VBf3sXxqyFuEBAL/BxDZiVmZ6OMBhtz+y2rPwDYrsSI/yRBEgPmopuzvOfB0DM6buisnPY/gdB/zsooF+jOWjLCailBisc5iIS3HmexktI2oVu0HKNVsyvBzu7yD1XNHEX65t357nS0xjZyME9S88SjnFW+X+fo0sctInF6uGfeQqQx9h1Rrar3wHYJHp5GqEoCZQ1W3I3u1ANmMuz7uU1P4n67sWrjQPYOdWj7IuBWI5VnW/i23UALwFI2a/Hfb9IuNtjh/IlUYVNBZh4/8r5OlgAn6nv14TcKXLc/RlavWjqBNH0WGIomsyvOT5Pid8OwMc3Ym8Rp3PmEFPrUVppMAS+lzx6H9LDcFdh2ZVBWvCYt7OqNkkgP8bVlnDHUapnPn5lbf6u8amANL6gphSuMtbNPBeOfrcxjhwhzpEOIAWhMQLmHU/Nn0xdTAbWPv5HbD9XDqSuEkl00eF0oju4oowaKpe4AZ3emfg4RGfozAQtE07z7O17UzTqXuall1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(316002)(5660300002)(83380400001)(31696002)(38100700002)(2616005)(8676002)(7416002)(6916009)(54906003)(66574015)(956004)(16576012)(8936002)(4326008)(2906002)(186003)(6666004)(26005)(86362001)(36756003)(508600001)(6486002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9tSTJIRXFhSXZYemQvS2VQTzQzRlhuYXBVcHdRK3RzQTIySVZ1R3BFS2sy?=
 =?utf-8?B?cVRSTXlub21MRDllZTJGTi85Ky9JUlNRSENxN2hybzR6MWY2Z2tJWW9MMlQy?=
 =?utf-8?B?N3ZydGhhdmh1RW9HcFB6VTlBNnpwLzh4UzIybldYTGsyZ0Y5VEtIUDFzaTBP?=
 =?utf-8?B?NkNJQ2dpSGJ1UG5ub0VEWmlScmtISlpTd0V3YUIzRVd6REh0UGlqOUZzbVZY?=
 =?utf-8?B?cDV4aFNPY1Baem1mRWU5YzdLT29QWUFSQ2tLOG1EeFJuZWpBNFFzazVtLzNv?=
 =?utf-8?B?U1hQMThHUFl2QzRUTHJRYXVDUzVnaG5JZlVJWHgzZ2I2K25QTHovNlYzb1Vm?=
 =?utf-8?B?Q2xFdnk1TXZhbW5BN0hZVmJzazJaaGNVRHZpUlg3eTBnVFNYNWRESHNzdU1h?=
 =?utf-8?B?SGZIMmhwaUhETWJtV1I1ZzY3RXF6RHViaGh6d3dGeS8xbk9rOGdWcE8xVHNx?=
 =?utf-8?B?dUplVzVuY3JtWUJtb3VOMC9CVmJZQmRjTS9YRlRnOG4xRngxci9IcHdmTUxu?=
 =?utf-8?B?OVRuRTV6Z3gvNjNVRW9HZm5hcmxxUEhqRDFNZ0RxQ3NOdjJJUHFYalBYbzR2?=
 =?utf-8?B?d3RMSTJIRjUyZWhpREY1N1lmMWRrc245TlRKZERHMTdPKzBibWpPOFZjTUhl?=
 =?utf-8?B?ek0zNG8rUVMyaVZkR1ZIN29QSmRZbkpncUx4a0JScElHUm9DVmFQS29WQm5p?=
 =?utf-8?B?Q2dBOHNsZGRwQXFuTlc4aVdHYm1aencvdWxPTVd6Q2tjMzBRMDJjSHVNZ3l4?=
 =?utf-8?B?SEprL1BPR3EzV3dubFpIeUNjcGE5RHBCaEJMR0ZxY1NjZEZMRzNiOWhRNGNH?=
 =?utf-8?B?SlhrTDRPNjIyRmcxYWFGczhXSkwzSXVXNkVmYzIzb0xWZWRscmg2eE45YkZo?=
 =?utf-8?B?OEdwWkVVL0d2VnRzdG93ODRXbWhMZXp0OTBTQlIyN2hBcGwrMkZ4TitRM0pZ?=
 =?utf-8?B?YnZqdnc3WHpKZ3dMUkVUUUVZclJ2MGtnWlJwRkZHMjNYeEFBdUdmVWpuQUlk?=
 =?utf-8?B?WEFPNWltSnRFejl2enZ5RWE3SmhseDZPcEIyeWtjanFaRHkzeUVPT1NQcnU5?=
 =?utf-8?B?RFpPMEdLNndVUUN3MHd6cjNBZENqK0xQRG82dm83a1RYQWF3UHUwemdqVFNy?=
 =?utf-8?B?ZllHQWtEWE9SdzkxRVh6RDlzanhsYmduUFMzZHhFUlhyT2t1SWRaRGRKQlVZ?=
 =?utf-8?B?Y01ObnVreFpncFlNQnFYWk51OUlsUVlReDZJaTJENkZBNFBRSWZRRDBENjMx?=
 =?utf-8?B?cUZET3owTnc4bHlyS3VHbThRREpTTWpwdUdmdktuOVM3T0kreWIzbDlvZmd5?=
 =?utf-8?B?UHJkckVqcjZXYjUxemU5Y2twYXJYT0hBcTBNUlF3dDZuNWsrQlFDNXgxbk15?=
 =?utf-8?B?Y25XUXlnRlNsY3gweWp3MDM0cFdSOWs1TGREaS9aVGRNWlhMODk1SXFZZDdw?=
 =?utf-8?B?MEdjZEx3VmYwY3FnK01vN2lhdnlhYVBweDlCd2tyZXRsdmJqYkd0TGJjMlVq?=
 =?utf-8?B?Z0d2TEV4SXVlUUZXTHZURzk3VHFEVVkrazlTNnZNT2pvcmpldndUbmNVdmJv?=
 =?utf-8?B?bVVaRS9TeFlMVDJoeDd0czYyUFp0U21YQ2VGY1FEaElqc25FWThMMjZ1OEJX?=
 =?utf-8?B?bUJ5OEdkQWUzYWFUOVpLOEhRTkNuYmNQV1ZGRU5OZEdmLzBsc01BemF0NHBq?=
 =?utf-8?B?MDBMMDhnWndkalFWSk0weTdGRDBsV3kySFlDZW9kVERROVdCVDBPMzVtVDl5?=
 =?utf-8?Q?cEgdy5Jv9eIgsST3VLJklQevNKq24AwJODb35a/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faa79b9-a537-46bc-3f3c-08d9873a0817
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:22:36.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuJNwMMb4NTFiVQ9F93qmMM6VkSOKuzEfFgX6jFPM1ue1eGOtEW3wDH1N1y1oITa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0112
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 04.10.21 um 15:11 schrieb Jason Gunthorpe:
> On Mon, Oct 04, 2021 at 08:58:35AM +0200, Christian König wrote:
>> I'm not following this discussion to closely, but try to look into it from
>> time to time.
>>
>> Am 01.10.21 um 19:45 schrieb Jason Gunthorpe:
>>> On Fri, Oct 01, 2021 at 11:01:49AM -0600, Logan Gunthorpe wrote:
>>>
>>>> In device-dax, the refcount is only used to prevent the device, and
>>>> therefore the pages, from going away on device unbind. Pages cannot be
>>>> recycled, as you say, as they are mapped linearly within the device. The
>>>> address space invalidation is done only when the device is unbound.
>>> By address space invalidation I mean invalidation of the VMA that is
>>> pointing to those pages.
>>>
>>> device-dax may not have a issue with use-after-VMA-invalidation by
>>> it's very nature since every PFN always points to the same
>>> thing. fsdax and this p2p stuff are different though.
>>>
>>>> Before the invalidation, an active flag is cleared to ensure no new
>>>> mappings can be created while the unmap is proceeding.
>>>> unmap_mapping_range() should sequence itself with the TLB flush and
>>> AFIAK unmap_mapping_range() kicks off the TLB flush and then
>>> returns. It doesn't always wait for the flush to fully finish. Ie some
>>> cases use RCU to lock the page table against GUP fast and so the
>>> put_page() doesn't happen until the call_rcu completes - after a grace
>>> period. The unmap_mapping_range() does not wait for grace periods.
>> Wow, wait a second. That is quite a boomer. At least in all GEM/TTM based
>> graphics drivers that could potentially cause a lot of trouble.
>>
>> I've just double checked and we certainly have the assumption that when
>> unmap_mapping_range() returns the pte is gone and the TLB flush completed in
>> quite a number of places.
>>
>> Do you have more information when and why that can happen?
> There are two things to keep in mind, flushing the PTEs from the HW
> and serializing against gup_fast.
>
> If you start at unmap_mapping_range() the page is eventually
> discovered in zap_pte_range() and the PTE cleared. It is then passed
> into __tlb_remove_page() which puts it on the batch->pages list
>
> The page free happens in tlb_batch_pages_flush() via
> free_pages_and_swap_cache()
>
> The tlb_batch_pages_flush() happens via zap_page_range() ->
> tlb_finish_mmu(), presumably after the HW has wiped the TLB's on all
> CPUs. On x86 this is done with an IPI and also serializes gup fast, so
> OK
>
> The interesting case is CONFIG_MMU_GATHER_RCU_TABLE_FREE which doesn't
> rely on IPIs anymore to synchronize with gup-fast.
>
> In this configuration it means when unmap_mapping_range() returns the
> TLB will have been flushed, but no serialization with GUP fast was
> done.
>
> This is OK if the GUP fast cannot return the page at all. I assume
> this generally describes the DRM caes?

Yes, exactly that. GUP is completely forbidden for such mappings.

But what about accesses by other CPUs? In other words our use case is 
like the following:

1. We found that we need exclusive access to the higher level object a 
page belongs to.

2. The lock of the higher level object is taken. The lock is also taken 
in the fault handler for the VMA which inserts the PTE in the first place.

3. unmap_mapping_range() for the range of the object is called, the 
expectation is that when that function returns only the kernel can have 
a mapping of the pages backing the object.

4. The kernel has exclusive access to the pages and we know that 
userspace can't mess with them any more.

That use case is completely unrelated to GUP and when this doesn't work 
we have quite a problem.

I should probably note that we recently switched from VM_MIXEDMAP to 
using VM_PFNMAP because the former didn't prevented GUP on all 
architectures.

Christian.

> However, if the GUP fast can return the page then something,
> somewhere, needs to serialize the page free with the RCU as the GUP
> fast can be observing the old PTE before it was zap'd until the RCU
> grace expires.
>
> Relying on the page ref being !0 to protect GUP fast is not safe
> because the page ref can be incr'd immediately upon page re-use.
>
> Interestingly I looked around for this on PPC and I only found RCU
> delayed freeing of the page table level, not RCU delayed freeing of
> pages themselves.. I wonder if it was missed?
>
> There is a path on PPC (tlb_remove_table_sync_one) that triggers an
> IPI but it looks like an exception, and we wouldn't need the RCU at
> all if we used IPI to serialize GUP fast...
>
> It makes logical sense if the RCU also frees the pages on
> CONFIG_MMU_GATHER_RCU_TABLE_FREE so anything returnable by GUP fast
> must be refcounted and freed by tlb_batch_pages_flush(), not by the
> caller of unmap_mapping_range().
>
> If we expect to allow the caller of unmap_mapping_range() to free then
> CONFIG_MMU_GATHER_RCU_TABLE_FREE can't really exist, we always need to
> trigger a serializing IPI during tlb_batch_pages_flush()
>
> AFAICT, at least
>
> Jason

