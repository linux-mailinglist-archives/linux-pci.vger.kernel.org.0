Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B41FDE1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 21:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhJBTe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 15:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhJBTe7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 15:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3166461B2C;
        Sat,  2 Oct 2021 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633203193;
        bh=vFLFLT1hVDvetudF/Tp6JD/lFwevk7FqKF3OPxbBcrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q11bUw33KKHW1sZpMZT1U9vGoq5//iOydNCpPNziR/2EvuBATpbj18KPKi3m1PDhD
         UJwJT/JZAcgB6BCCpxb35usfVpIWd2RcIwPHWL81OmkL0V6DZ0/z+7dU7SRD31+nf9
         uW74yfxU5OYMYJTkLlZSJjH0jOYdXIB599fxbjcBjvBtSYxkkW9B/0Hqcjg7E40Xh+
         qZ8dU6ModGxA+gGifv+iOiXW2oxQYZfv6sYbTqrV9s4TXc2LaWNdf9TtXuZ8zMQE63
         72w0KclCZVa1Q3Z8CK6REjMmj/yew1Q5KP+7ka3hv9GIo6HrN8MR0UKjFgantQD+AE
         d+9GmnAAT0qEw==
Date:   Sat, 2 Oct 2021 14:33:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: None of the virtual/physical/bus address matches the (base)
 BAR-0 register
Message-ID: <20211002193311.GA977182@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8XszWK6eGEPvvAV0E3mJWhZZdZMb4CmUsQg6jRdoABWjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 10:42:16PM +0530, Ajay Garg wrote:
> Thanks Bjorn, that certainly helped.
> Especially, it is nice to see that ptr->resource[0].start does give
> e2c20000 :)
> 
> Also, idiotic of me of making newbie kernel-format-specifier
> mistakes :-|

If you're referring to %p being hashed, that's bitten me more than
once.  I understand the value of it, but it's annoying in the
day-to-day development process ;)

> So, now the outputs corresponding to
> 
>     printk("Base virtual-address = [%lx]\n", bar0_ptr);
>     printk("Base physical-address (form-1) = [%lx]\n", dev->resource[0].start);
>     printk("Base bus-address = [%lx]\n", pci_bus_address(dev, 0));
>     printk("BAR 0: %pR\n", &dev->resource[0]);
> 
> are :
> 
>     Base virtual-address = [ffffa0c6c02eb000]
>     Base physical-address (form-1) = [e2c20000]
>     Base bus-address = [e2c20000]
>     BAR 0: [mem 0xe2c20000-0xe2c201ff]
> 
> All as expected.
> Plus, all the lower 12 bits are now same everywhere (due to the 4 KB
> page-size alignment in x86, right)?

Yes.

> My major missing understanding regarding this, is that we use the
> iowrite*/ioread* functions, using bar0_ptr as the
> base-(virtual-)address.
> Thus, bar0_ptr *is* very well the kernel-virtual-address, which maps
> to some physical-address (hopefully e2c20000), which directly triggers
> the write/read with the pci-device.

Yes.

> Right now, the physical-address (form-1) we have printed, is via the
> data-structure field.
> However, looking from the virtual-address <=> physical-address
> translation from the usual memory write/read datapath's perspective, I
> am still not able to coalesce things.
> 
> 
> In the same run as above, if I add the following statements :
> 
>     printk("Base physical-address (form-2) = [%lx]\n", virt_to_phys(bar0_ptr));
>     printk("Base physical-address (form-3) = [%lx]\n",
> virt_to_phys(*((uint32_t*)bar0_ptr)));
>     printk("Base physical-address (form-4) = [%lx]\n",
> virt_to_phys(*((uint64_t*)bar0_ptr)));

I don't think these last two make any sense.  You're doing an MMIO
read from the address bar0_ptr, so this value (0x721f4000001e) came
from the PCI devices.  There's no reason to think it's a kernel
virtual address, so you shouldn't call virt_to_phys() on it.

> I get :
> 
>     Base physical-address (form-2) = [12e6002eb000]
>     Base physical-address (form-3) = [721f4000001e]
>     Base physical-address (form-4) = [721f4000001e]
>
> Looking at the function-doc for virt_to_phys(), it states :
> 
> ########################################################
> * This function does not give bus mappings for DMA transfers. In
> * almost all conceivable cases a device driver should not be using
> * this function
> ########################################################
> 
> 
> 
> So, two queries :
> 
> 1)
> Does the above comment apply here too (in MMIO case)?

Yes.  You should not need to use virt_to_phys() for PCI MMIO
addresses.

> 2)
> If yes, then what is the datapath followed for our case (since
> conventional virtual-address <=> physical-address translations via MMU
> / TLB / page-tables is out of the picture I guess)?

This path is IN the picture.  This is exactly the path used by drivers
doing MMIO accesses.

The CPU does a load from a virtual address (0xffffa0c6c02eb000).  The
MMU translates that virtual address to a physical address
(0xe2c20000).  The PCI host bridge decodes that address and generates
a PCIe Memory Read transaction to the bus address 0xe2c20000.

Your dmesg log should have lines similar to this:

  pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
  pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]

that show the parts of the CPU physical address space that result in
MMIO to PCI devices.  0xe2c20000 should be inside one of those
windows.

Bjorn
