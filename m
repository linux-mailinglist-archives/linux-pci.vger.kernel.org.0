Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040AE10561A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKUPzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 10:55:46 -0500
Received: from foss.arm.com ([217.140.110.172]:58460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfKUPzq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 10:55:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD340328;
        Thu, 21 Nov 2019 07:55:44 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 841A33F52E;
        Thu, 21 Nov 2019 07:55:40 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
To:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
 <20191121152457.GA525@lst.de> <20191121152650.GA651@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70359d2a-10c6-09c7-a857-805085affb0a@arm.com>
Date:   Thu, 21 Nov 2019 15:55:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121152650.GA651@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/11/2019 3:26 pm, Christoph Hellwig wrote:
> On Thu, Nov 21, 2019 at 04:24:57PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 21, 2019 at 10:26:44AM +0100, Nicolas Saenz Julienne wrote:
>>> Using a mask to represent bus DMA constraints has a set of limitations.
>>> The biggest one being it can only hold a power of two (minus one). The
>>> DMA mapping code is already aware of this and treats dev->bus_dma_mask
>>> as a limit. This quirk is already used by some architectures although
>>> still rare.
>>>
>>> With the introduction of the Raspberry Pi 4 we've found a new contender
>>> for the use of bus DMA limits, as its PCIe bus can only address the
>>> lower 3GB of memory (of a total of 4GB). This is impossible to represent
>>> with a mask. To make things worse the device-tree code rounds non power
>>> of two bus DMA limits to the next power of two, which is unacceptable in
>>> this case.
>>>
>>> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
>>> over the tree and treat it as such. Note that dev->bus_dma_limit should
>>> contain the higher accesible DMA address.
>>>
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> I've tentatively added this patch to the dma-mapping tree based on
>> Robins principal approval of the last version.  That way tomorrows
>> linux-next run should still pick it up.
> 
> Actually.  This doesn't apply because the dma-mapping tree doesn't
> have you zone_dma_bits change.  I guess we'll need to wait for the
> next merge window, or maybe post rc1 if this happens to fix the
> powerpc problem that Christian reported.

Hmm, there's no functional dependency though, is there? AFAICS it's 
essentially just a context conflict. Is it worth simply dropping (or 
postponing) the local renaming in __dma_direct_optimal_gfp_mask(), or 
perhaps even cross-merging arm64/for-next/zone-dma into dma/for-next?

Robin.
