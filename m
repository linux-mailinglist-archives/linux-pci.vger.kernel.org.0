Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E316041FCE6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhJBP44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 11:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhJBP44 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 11:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B0E61AFE;
        Sat,  2 Oct 2021 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633190110;
        bh=aHfdkke2+9Mh9bQlTSZ8OZdMzP54SvqIsoBmhlhEdPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dJ4TIGus4YtMy/HQJ1APRwqGXbvqK+MPseQ/rj7cOH2zXKxC6Qggvj2sF2NFi2nw0
         1aX9hOPJD2KjGauCg/7PWicG32QQLsofJiJvRW49V82EHvZdULTkRWwZkJLO+AtBvi
         XB35NhYr5LNHazOowajPQtlhKY6SvZHqL3JX4Jf3GXz1HlqpMwsCpGzrqCg6cpB82F
         K2B11z1GeRLSLm+GViJeQ5G2DsduNvJAtpPC0UQu98vPpER7QgSjGLBvsOpWEySx1a
         tP4sSNwLhPjYxN00y3w3BpIol66PRhVoDd8cd5GYiXig1KvP3RKC2ei0q98ogrOyTu
         wBRpizW8qGmbQ==
Date:   Sat, 2 Oct 2021 10:55:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: None of the virtual/physical/bus address matches the (base)
 BAR-0 register
Message-ID: <20211002155508.GA968974@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8U-uGwZqqGk5Z9KP7w_hESgTtrAsSrwxFfCiLZOht1uYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 09:36:44AM +0530, Ajay Garg wrote:
> Thanks Keith.
> 
> Let's take a x86 world as of now, and let's say the physical address
> (returned by virt_to_phys()) is 0661a070.
> The pci address (as stated) is e2c20000.

Something's wrong here.  The low-order 12 bits of the CPU virtual, CPU
physical, and PCI bus address should be the same.  Might be the
hashing done by %p, see Documentation/core-api/printk-formats.rst.

> Since the BAR0-region is of size 256 bytes, so the system-agent (as
> per x86-terminology) will monitor the highest 24 bits of
> address-lines, to sense a MMIO read/write, and then forward the
> transaction to the corresponding pci bridge/device.
> 
> So, in the present case, would
> 
> a)
> The system-agent sense address-lines A31-A8 value as 0661a07? If yes,
> is it the system-agent that does the translation from 0661a070 =>
> e2c20000, before finally forwarding the transaction to pci
> bridge/device?
> 
> b)
> The system-agent sense address-lines A31-A8 value as e2c2000 (and
> simply forwards the transaction to pci bridge/device)? If yes,
> who/what does the translation from 0661a070 =? e2c20000?

> On Fri, Oct 1, 2021 at 8:43 PM Keith Busch <kbusch@kernel.org> wrote:
> > On Fri, Oct 01, 2021 at 08:21:06PM +0530, Ajay Garg wrote:
> > > Hi All.
> > >
> > > I have a SD/MMC reader over PCI, which displays the following (amongst
> > > others) when we do "lspci -vv" :
> > >
> > > #########################################################
> > > Region 0: Memory at e2c20000 (32-bit, non-prefetchable) [size=512]
> > > #########################################################
> > >
> > > Above shows that e2c20000 is the physical (base-)address of BAR0.

Yes.  "lspci -vv" shows the CPU physical address.  "lspci -bvv" shows
the bus addresses, i.e., the addresses you would see with a PCI bus
analyzer.  See Documentation/core-api/dma-api-howto.rst for more.

> > > Now, in the device driver, I do the following :
> > >
> > > ########################################################
> > > .....
> > > struct pci_dev *ptr;
> > > void __iomem *bar0_ptr;
> > > ......
> > >
> > > ......
> > > pci_request_region(ptr, 0, "ajay_sd_mmc_BAR0_region");
> > > bar0_ptr = pci_iomap(ptr, 0, pci_resource_len(ptr, 0));
> > >
> > > printk("Base virtual-address = [%p]\n", bar0_ptr);
> > > printk("Base physical-address = [%p]\n", virt_to_phys(bar0_ptr));
> > > printk("Base bus-address = [%p]\n", virt_to_bus(bar0_ptr));

  printk("Base physical-address = [%#lx]\n", ptr->resource[0].start);
  printk("Base virtual-address = [%px]\n", bar0_ptr);
  printk("Base bus-address = [%#lx]\n", pci_bus_address(ptr, 0));
  printk("BAR 0: %pR\n", &ptr->resource[0]);

> > > Now, in the 3 printk's, none of the value is printed as e2c20000.
> > > I was expecting that the 2nd result, of virt_to_phys() translation,
> > > would be equal to the base-address of BAR0 register, as reported by
> > > lspci.
> > >
> > >
> > > What am I missing?
> > > Will be grateful for pointers.
> >
> > The CPU address isn't always the same as the PCI address. For example,
> > some memory resources are added via pci_add_resource_offset(), so the
> > windows the host sees will be different than the ones the devices use.
