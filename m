Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557D1FBA9E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMVZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 16:25:08 -0500
Received: from foss.arm.com ([217.140.110.172]:58590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfKMVZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 16:25:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D87D7A7;
        Wed, 13 Nov 2019 13:25:06 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30ED3F52E;
        Wed, 13 Nov 2019 13:25:00 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: treat dev->bus_dma_mask as a DMA limit
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mips@vger.kernel.org, linux-ide@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        phil@raspberrypi.org, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
References: <20191113161340.27228-1-nsaenzjulienne@suse.de>
 <f74cd8a6-00bf-46c3-8e2e-d278e72d6e0e@arm.com>
 <48da05e0-5acf-8ab3-a6c9-be4988a9450b@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b8e4d303-f226-53d9-f383-73872e41002b@arm.com>
Date:   Wed, 13 Nov 2019 21:24:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <48da05e0-5acf-8ab3-a6c9-be4988a9450b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-13 8:41 pm, Florian Fainelli wrote:
> On 11/13/19 12:34 PM, Robin Murphy wrote:
>> On 13/11/2019 4:13 pm, Nicolas Saenz Julienne wrote:
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
>>> over the tree and treat it as such. Note that dev->bus_dma_limit is
>>> meant to contain the higher accesible DMA address.
>>
>> Neat, you win a "why didn't I do it that way in the first place?" :)
>>
>> Looking at it without all the history of previous attempts, this looks
>> entirely reasonable, and definitely a step in the right direction.
> 
> And while you are changing those, would it make sense to not only rename
> the structure member but introduce a getter and setter in order to ease
> future work where this would no longer be a scalar?

I doubt it - once we get as a far as supporting multiple DMA ranges, 
there will be a whole load of infrastructure churn anyway if only to 
replace dma_pfn_offset, and I'm not sure a simple get/set paradigm would 
even be viable, so it's probably better to save that until clearly 
necessary.

Robin.
