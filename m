Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D64624D4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhK2WbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:31:11 -0500
Received: from ale.deltatee.com ([204.191.154.188]:48154 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhK2Wax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=h3I3KuBV0EWpxrs/PZnldvg5FyRAoHiTFhFI8WLZtNg=; b=XGhjJUo2WcTINFvER9CSwQY9TX
        GFFz4P+6Oplo33ZFyVVblbe69M3YyjMz8quXkNayNK98eC9jPpb7o2nwfW65Zf2PvExMR+RNx1xc+
        h0kG7Yy4JPu0u0WOdT4EzzWtGEMtcJCsl84rzKmlFH4aHTkT5KypZ2K1opX1MSzo4KhD5FKKhbSde
        j0MqfHCDGr9X7KM5eJFz7fgcXk2kqbn3NcDXoZAcBj7IeR7BbxI3t9LkQ9m04eDfyp5fkm5MdvQPP
        Bw/SeeAas6aCntn16fXgue43WfF4Prot4xpvBpyAycDrbJZ2hFREwICsC9Qn4ogq6vF+1AoX4YhFr
        /fC2Zh7A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mrp7M-00AR6j-2z; Mon, 29 Nov 2021 15:27:25 -0700
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Date:   Mon, 29 Nov 2021 15:27:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <874k7ueldt.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, jgg@nvidia.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-29 1:51 p.m., Thomas Gleixner wrote:
> Logan,
> 
> On Mon, Nov 29 2021 at 11:21, Logan Gunthorpe wrote:
>> On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
>>> Replace the about to vanish iterators, make use of the filtering and take
>>> the descriptor lock around the iteration.
>>
>> This patch looks good to me:
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> thanks for having a look at this. While I have your attention, I have a
> question related to NTB.
> 
> The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
> to allocate non-hardware backed MSI-X descriptors.
> 
> AFAIU these descriptors are not MSI-X descriptors in the regular sense
> of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
> usage is somewhere in NTB which has nothing to do with the way how the
> real MSI-X interrupts of a device work which explains why we have those
> pci.msi_attrib.is_virtual checks all over the place.
> 
> I assume that there are other variants feeding into NTB which can handle
> that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
> in that code.
> 
> Could you please shed some light on the larger picture of this?

Yes, of course. I'll try to explain:

The NTB code here is trying to create an MSI interrupt that is not
triggered by the PCI device itself but from a peer behind the
Non-Transparent Bridge (or, more carefully: from the CPU's perspective
the interrupt will come from the PCI device, but nothing in the PCI
device's firmware or hardware will have triggered the interrupt).

In most cases, the NTB code needs more interrupts than the hardware
actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
for: it allows the driver to request more interrupts than the hardware
advertises (ie. pci_msix_vec_count()). These extra interrupts are
created, but get flagged with msi_attrib.is_virtual which ensures
functions that program the MSI-X table don't try to write past the end
of the hardware's table.

The NTB code in drivers/ntb/msi.c uses these virtual MSI-X interrupts.
(Or rather it can use any interrupt: it doesn't care whether its virtual
or not, it would be fine if it is just a spare interrupt in hardware,
but in practice, it will usually be a virtual one). The code uses these
interrupts by setting up a memory window in the bridge to cover the MMIO
addresses of MSI-X interrupts. It communicates the offsets of the
interrupts (and the MSI message data) to the peer so that the peer can
trigger the interrupt simply by writing the message data to its side of
the memory window. (In the code: ntbm_msi_request_threaded_irq() is
called to request and interrupt which fills in the ntb_msi_desc with the
offset and data, which is transferred to the peer which would then use
ntb_msi_peer_trigger() to trigger the interrupt.)

Existing NTB hardware does already have what's called a doorbell which
provides the same functionally as the above technique. However, existing
hardware implementations of doorbells have significant latency and thus
slow down performance substantially. Implementing the MSI interrupts as
described above increased the performance of ntb_transport by more than
three times[1].

There aren't really other "variants". In theory, IDT hardware would also
require the same quirk but the drivers in the tree aren't quite up to
snuff and don't even support ntb_transport (so nobody has added
support). Intel and AMD drivers could probably do this as well (provided
they have extra memory windows) but I don't know that anyone has tried.

Let me know if anything is still unclear or you have further questions.
You can also read the last posting of the patch series[2] if you'd like
more information.

Logan

[1] 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
[2]
https://lore.kernel.org/all/20190523223100.5526-1-logang@deltatee.com/T/#u




