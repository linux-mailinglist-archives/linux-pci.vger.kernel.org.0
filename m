Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2410840
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEANVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 09:21:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 09:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3BB80D;
        Wed,  1 May 2019 06:21:36 -0700 (PDT)
Received: from [10.1.30.200] (unknown [10.1.30.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408373F5C1;
        Wed,  1 May 2019 06:21:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Joerg Roedel <joro@8bytes.org>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com>
 <20190501125530.GA15590@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <119be78f-34f5-c19b-d41b-f7279e968b46@arm.com>
Date:   Wed, 1 May 2019 14:20:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501125530.GA15590@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-05-01 1:55 pm, Bjorn Helgaas wrote:
> On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
>> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
>>> Few SOCs have limitation that their PCIe host can't allow few inbound
>>> address ranges. Allowed inbound address ranges are listed in dma-ranges
>>> DT property and this address ranges are required to do IOVA mapping.
>>> Remaining address ranges have to be reserved in IOVA mapping.
>>>
>>> PCIe Host driver of those SOCs has to list resource entries of allowed
>>> address ranges given in dma-ranges DT property in sorted order. This
>>> sorted list of resources will be processed and reserve IOVA address for
>>> inaccessible address holes while initializing IOMMU domain.
>>>
>>> This patch set is based on Linux-5.0-rc2.
>>>
>>> Changes from v3:
>>>    - Addressed Robin Murphy review comments.
>>>      - pcie-iproc: parse dma-ranges and make sorted resource list.
>>>      - dma-iommu: process list and reserve gaps between entries
>>>
>>> Changes from v2:
>>>    - Patch set rebased to Linux-5.0-rc2
>>>
>>> Changes from v1:
>>>    - Addressed Oza review comments.
>>>
>>> Srinath Mannam (3):
>>>    PCI: Add dma_ranges window list
>>>    iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
>>>    PCI: iproc: Add sorted dma ranges resource entries to host bridge
>>>
>>>   drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
>>>   drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>>>   drivers/pci/probe.c                 |  3 +++
>>>   include/linux/pci.h                 |  1 +
>>>   4 files changed, 66 insertions(+), 1 deletion(-)
>>
>> Bjorn, Joerg,
>>
>> this series should not affect anything in the mainline other than its
>> consumer (ie patch 3); if that's the case should we consider it for v5.2
>> and if yes how are we going to merge it ?
> 
> I acked the first one
> 
> Robin reviewed the second
> (https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
> (though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
> with it if Robin was
> (https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).
> 
> Eric reviewed the third (and pointed out a typo).
> 
> My Kconfiggery never got fully answered -- it looks to me as though it's
> possible to build pcie-iproc without the DMA hole support, and I thought
> the whole point of this series was to deal with those holes
> (https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
> have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
> But Srinath didn't respond to that, so maybe it's not an issue and it
> should only affect pcie-iproc anyway.

Hmm, I'm sure I had at least half-written a reply on that point, but I 
can't seem to find it now... anyway, the gist is that these inbound 
windows are generally set up to cover the physical address ranges of 
DRAM and anything else that devices might need to DMA to. Thus if you're 
not using an IOMMU, the fact that devices can't access the gaps in 
between doesn't matter because there won't be anything there anyway; it 
only needs mitigating if you do use an IOMMU and start giving arbitrary 
non-physical addresses to the endpoint.

> So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
> it, Lorenzo, or ...?

This doesn't look like it will conflict with the other DMA ops and MSI 
mapping changes currently in-flight for iommu-dma, so I have no 
objection to it going through the PCI tree for 5.2.

Robin.
