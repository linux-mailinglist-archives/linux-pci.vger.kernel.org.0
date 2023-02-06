Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957EA68BB7C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 12:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBFL1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 06:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBFL1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 06:27:50 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89503C643;
        Mon,  6 Feb 2023 03:27:44 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 72925341DA6;
        Mon,  6 Feb 2023 14:27:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=BeO7USyN2i08XzGSFB
        uEgqnyOPsIll67svfaIGEnjpE=; b=Q/VkDlbesPls3BKSwkapXHClHL4mz0zQj7
        2fGqe/BB03R98PYHygUchV6IV7g3ZctXBE7ggqTZY0vskaIIZ+VYHzQ7PLAhJ6++
        9uSHJ2CFeiuVgKRWRZJ6NjfJ2Uo3qXtJZ62FS3gKZOKEG9enLSoFxFok0qiw82BX
        gMVKFrhik=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 6637F341A69;
        Mon,  6 Feb 2023 14:27:42 +0300 (MSK)
Received: from [10.199.16.60] (10.199.16.60) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Mon, 6 Feb 2023
 14:27:41 +0300
Message-ID: <66b01fd7-7466-5d76-c384-0758ceadee8e@yadro.com>
Date:   Mon, 6 Feb 2023 14:27:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/2] PCI: dwc: Add support for 64-bit MSI target
 addresses
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, <kernel-team@android.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will McVicker <willmcvicker@google.com>
References: <20220825235404.4132818-1-willmcvicker@google.com>
 <decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com>
 <c014b074-6d7f-773b-533a-c0500e239ab8@arm.com>
 <46ba97c9-85ff-eb47-0d05-79dc3960d7b4@yadro.com>
 <20230203221216.c2s6ahm52ug5jtqv@mobilestation>
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <20230203221216.c2s6ahm52ug5jtqv@mobilestation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.16.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergey,

First of all, thank you for the detailed explanation. It is clearer now 
what is going on and why it is that way.

On 04.02.2023 01:12, Serge Semin wrote:
> Hi Evgenii
> 
> On Wed, Feb 01, 2023 at 04:54:55PM +0300, Evgenii Shatokhin wrote:
>> On 31.01.2023 15:42, Robin Murphy wrote:
>>>
>>> On 2023-01-31 12:29, Evgenii Shatokhin wrote:
>>>> Hi,
>>>>
>>>> On 26.08.2022 02:54, Will McVicker wrote:
>>>>> Hi All,
>>>>>
>>>>> I've update patch 2/2 to address Robin's suggestions. This includes:
>>>>>
>>>>>    * Dropping the while-loop for retrying with a 64-bit mask in favor of
>>>>>      retrying within the error if-statement.
>>>>>    * Using an int for the DMA mask instead of a bool and ternary
>>>>> operation.
>>>>>
>>>>> Thanks again for the reviews and sorry for the extra revision today!
>>>>> Hopefully this is the last one :) If not, I'd be fine to submit
>>>>> patch 1/2
>>>>> without 2/2 to avoid resending patch 1/2 for future revisions of patch
>>>>> 2/2
>>>>> (unless I don't need to do that anyway).
>>>>
>>>> The first patch of the series made it into the mainline kernel, but, it
>>>> seems, the second one ("PCI: dwc: Add support for 64-bit MSI target
>>>> address") did not. As of 6.2-rc6, it is still missing.
>>>>
>>>> Was it intentionally dropped because of some issues or, perhaps, just by
>>>> accident? If it was by accident, could you please queue it for inclusion
>>>> into mainline again?
>>>
>>> Yes, it was dropped due to the PCI_MSI_FLAGS_64BIT usage apparently
>>> being incorrect, and some other open debate (which all happened on the
>>> v5 thread):
>>>
>>> https://lore.kernel.org/linux-pci/YzVTmy9MWh+AjshC@lpieralisi/
>>
> 
>> I see. If I understand it correctly, the problem was that
>> PCI_MSI_FLAGS_64BIT flag did not guarantee that 64-bit mask could be used
>> for that particular allocation. Right?
>>
> 
> William was trying to utilize for only software cause. Setting
> PCI_MSI_FLAGS_64BIT didn't actually change the hardware behavior.
> He could have as well provided just a driver private capability
> flag. (see below for a more detailed problem description)
> 
>>>
>>> The DMA mask issues have now been sorted out,
>>
>> I suppose, you mean https://lore.kernel.org/all/20230113171409.30470-26-Sergey.Semin@baikalelectronics.ru/?
> 
> Well, the way the DMA-mask issue has been solved was a bit of the
> hacky. I wouldn't call it a fully proper solution. The problem with
> pointlessly allocating physical memory for the iMSI-RX engine (it
> doesn't perform any DMA) and artificially restricting the coherent-DMA
> mask is still there. The patch in the subject was a compromise in
> order to at least permit unrestricted streaming DMAs but limiting the
> coherent DMAs for the MSI setup to work properly for all peripheral
> devices.
> 
>>
>> It still breaks our particular case when the SoC has no 32-bit-addressable
>> RAM. We'd set DMA masks to DMA_BIT_MASK(36) in the platform-specific driver
>> before calling dw_pcie_host_init(). However, dw_pcie_msi_host_init() resets
>> it to 32-bit, tries dmam_alloc_coherent() and fails.
> 
> Yeah. That's another problem with the implemented approach. But are
> your sure the driver had worked even before this patch? AFAICS the
> driver allocated the MSI-targeted page from DMA32 zone before this
> modification. So the allocation must have failed on your platform too.

You are right. I did not notice earlier that the kernel based on 
6.0-stable we used before did actually contain our SoC-specific 
workaround for this. Without that custom patch, initialization of PCIe 
host does not work. So, yes, the problem was present earlier too.

> 
>>
>> With 36-bit masks, the kernel seems to play well with the devices in our
>> case.
>>
>> I saw your comment in https://lore.kernel.org/linux-pci/4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com/
>> that drivers should always explicitly set their masks.
>>
> 
>> Is it a really bad idea to check the current coherent mask's bits in
>> dw_pcie_msi_host_init() and if it is more than 32 - just issue a warning
>> rather than reset it to 32-bit unconditionally? That would help in our case.
>> Or, perhaps, there is a better workaround.
> 
> The problem isn't in the value the mask is set to. The problem is
> two-leveled, but is mainly connected with the PCIe device detected on
> the PCIe bus. There are some of them which can't send MSI TLPs to the
> 64-bit addresses. Since we can't predict whether such devices exist on
> the bus beforehand the LLDD probe is performed together with the
> MSI-engine initialization, the solution was to just restrict the MSIs
> base address to be allocated within the lowest 4GB. Moreover as I said
> above the iMSI-RX engine doesn't actually cause any DMA thus there is
> no need in any memory allocation. Instead reserving some PCIe-bus
> space/DWORD for MSIs would be enough. Alas the PCIe-subsystem doesn't
> provide a way to do so. That's why we have what you see in the driver:
> DMA mask restriction and coherent DMA memory allocation.

So, if I understand you correctly, what is needed here is a small area 
of PCIe address space accessible to any of the connected PCIe devices. 
As the kernel does not know in advance, which restrictions the devices 
have, it tries to allocate 32-bit-addressable memory, suitable for DMA. 
This way, it would be OK for any attached PCIe device. Right?

> 
> If only we had a way to auto-detected the PCIe-bus space with no
> physical memory behind it and take out a DWORD from it to initialize
> the iMSI-RX engine we could have immediately got rid from the mask
> setting operation and the memory allocation. It would have solved your
> problem too.

Yes, it would solve our issue too. I do not know, however, if a generic 
solution is possible here, but I am no expert in PCIe.

For now, we are probably better off with SoC-specific patches, when we 
know which PCIe devices can possibly be used and what their restrictions 
are.

> 
> -Serge(y)
> 
>>
>> Looking forward to your comments.
> 
> 
> 
>>
>>
>>> so you, or Will, or anyone
>>> else interested should be free to rework this on top of linux-next
>>> (although at this point, more realistically on top of 6.3-rc1 in a few
>>> weeks).
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> Support for 64-bit MSI target addresses is needed for some of our SoCs.
>>>> I ran into a situation when there was no available RAM in ZONE_DMA32
>>>> during initialization of PCIe host. Hence, dmam_alloc_coherent() failed
>>>> in dw_pcie_msi_host_init() and initialization failed with -ENOMEM:
>>>>
>>>> [    0.374834] dw-pcie 4000000.pcie0: host bridge /soc/pcie0@4000000
>>>> ranges:
>>>> [    0.375813] dw-pcie 4000000.pcie0:      MEM
>>>> 0x0041000000..0x004fffffff -> 0x0041000000
>>>> [    0.376171] dw-pcie 4000000.pcie0:   IB MEM
>>>> 0x0400000000..0x07ffffffff -> 0x0400000000
>>>> [    0.377914] dw-pcie 4000000.pcie0: Failed to alloc and map MSI data
>>>> [    0.378191] dw-pcie 4000000.pcie0: Failed to initialize host
>>>> [    0.378255] dw-pcie: probe of 4000000.pcie0 failed with error -12
>>>>
>>>> Mainline kernel 6.2-rc6 was used in that test.
>>>>
>>>> The hardware supports 64-bit target addresses, so the patch "PCI: dwc:
>>>> Add support for 64-bit MSI target address" should help with this
>>>> particular failure.
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Will
>>>>>
>>>>> Will McVicker (2):
>>>>>     PCI: dwc: Drop dependency on ZONE_DMA32
>>>>>
>>>>> v6:
>>>>>    * Retrying DMA allocation with 64-bit mask within the error
>>>>> if-statement.
>>>>>    * Use an int for the DMA mask instead of a bool and ternary operation.
>>>>>
>>>>> v5:
>>>>>    * Updated patch 2/2 to first try with a 32-bit DMA mask. On failure,
>>>>>      retry with a 64-bit mask if supported.
>>>>>
>>>>> v4:
>>>>>    * Updated commit descriptions.
>>>>>    * Renamed msi_64b -> msi_64bit.
>>>>>    * Dropped msi_64bit ternary use.
>>>>>    * Dropped export of dw_pcie_msi_capabilities.
>>>>>
>>>>> v3:
>>>>>     * Switched to a managed DMA allocation.
>>>>>     * Simplified the DMA allocation cleanup.
>>>>>     * Dropped msi_page from struct dw_pcie_rp.
>>>>>     * Allocating a u64 instead of a full page.
>>>>>
>>>>> v2:
>>>>>     * Fixed build error caught by kernel test robot
>>>>>     * Fixed error handling reported by Isaac Manjarres
>>>>>    PCI: dwc: Add support for 64-bit MSI target address
>>>>>
>>>>>    .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++----------
>>>>>    drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
>>>>>    drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>>>>>    3 files changed, 30 insertions(+), 23 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>>
>>>> Thank you in advance.

Regards,
Evgenii


