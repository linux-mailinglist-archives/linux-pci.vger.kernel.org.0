Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBD4626A7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhK2Wzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:55:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:35009 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236124AbhK2WzR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 17:55:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233592853"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233592853"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:50:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="540182749"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.175.223]) ([10.209.175.223])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:50:24 -0800
Message-ID: <693a42d6-34d0-b8f9-f8b8-39ebbabb7f16@intel.com>
Date:   Mon, 29 Nov 2021 15:50:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/29/2021 3:27 PM, Logan Gunthorpe wrote:
>
> On 2021-11-29 1:51 p.m., Thomas Gleixner wrote:
>> Logan,
>>
>> On Mon, Nov 29 2021 at 11:21, Logan Gunthorpe wrote:
>>> On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
>>>> Replace the about to vanish iterators, make use of the filtering and take
>>>> the descriptor lock around the iteration.
>>> This patch looks good to me:
>>>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> thanks for having a look at this. While I have your attention, I have a
>> question related to NTB.
>>
>> The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
>> to allocate non-hardware backed MSI-X descriptors.
>>
>> AFAIU these descriptors are not MSI-X descriptors in the regular sense
>> of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
>> usage is somewhere in NTB which has nothing to do with the way how the
>> real MSI-X interrupts of a device work which explains why we have those
>> pci.msi_attrib.is_virtual checks all over the place.
>>
>> I assume that there are other variants feeding into NTB which can handle
>> that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
>> in that code.
>>
>> Could you please shed some light on the larger picture of this?
> Yes, of course. I'll try to explain:
>
> The NTB code here is trying to create an MSI interrupt that is not
> triggered by the PCI device itself but from a peer behind the
> Non-Transparent Bridge (or, more carefully: from the CPU's perspective
> the interrupt will come from the PCI device, but nothing in the PCI
> device's firmware or hardware will have triggered the interrupt).
>
> In most cases, the NTB code needs more interrupts than the hardware
> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> for: it allows the driver to request more interrupts than the hardware
> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> created, but get flagged with msi_attrib.is_virtual which ensures
> functions that program the MSI-X table don't try to write past the end
> of the hardware's table.
>
> The NTB code in drivers/ntb/msi.c uses these virtual MSI-X interrupts.
> (Or rather it can use any interrupt: it doesn't care whether its virtual
> or not, it would be fine if it is just a spare interrupt in hardware,
> but in practice, it will usually be a virtual one). The code uses these
> interrupts by setting up a memory window in the bridge to cover the MMIO
> addresses of MSI-X interrupts. It communicates the offsets of the
> interrupts (and the MSI message data) to the peer so that the peer can
> trigger the interrupt simply by writing the message data to its side of
> the memory window. (In the code: ntbm_msi_request_threaded_irq() is
> called to request and interrupt which fills in the ntb_msi_desc with the
> offset and data, which is transferred to the peer which would then use
> ntb_msi_peer_trigger() to trigger the interrupt.)
>
> Existing NTB hardware does already have what's called a doorbell which
> provides the same functionally as the above technique. However, existing
> hardware implementations of doorbells have significant latency and thus
> slow down performance substantially. Implementing the MSI interrupts as
> described above increased the performance of ntb_transport by more than
> three times[1].
>
> There aren't really other "variants". In theory, IDT hardware would also
> require the same quirk but the drivers in the tree aren't quite up to
> snuff and don't even support ntb_transport (so nobody has added
> support). Intel and AMD drivers could probably do this as well (provided
> they have extra memory windows) but I don't know that anyone has tried.

The Intel driver used to do something similar to bypass the doorbell 
hardware errata for pre Skylake Xeon hardware that wasn't upstream. I'd 
like to get this working for the performance reasons you mentioned. I 
just really need to find some time to test this with the second memory 
window Intel NTB has.


>
> Let me know if anything is still unclear or you have further questions.
> You can also read the last posting of the patch series[2] if you'd like
> more information.
>
> Logan
>
> [1] 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
> [2]
> https://lore.kernel.org/all/20190523223100.5526-1-logang@deltatee.com/T/#u
>
>
>
>
