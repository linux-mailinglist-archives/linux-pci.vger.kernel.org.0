Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB954F6D0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380246AbiFQLhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380908AbiFQLhN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 07:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F576A40C
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 04:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F48761DD0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 11:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9763FC3411D;
        Fri, 17 Jun 2022 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655465830;
        bh=3K7Q0JSJn4ho4p9PJn8g+xr4dteRRYxoCVeZhnLACFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NSs2HLRGw1N5dxkyT8vjWyLy2hANpZlKz5FNAEsfT4PWzuKGTYpYfgMc7dZitrS0o
         YEhtnPTJJlL5eotTjRbla+La7XQXU5k3Pv1CKlJJ1m9WVqLjSkEtt7+NQX368H1iff
         yda/1vB4DyTyFKSxXd0vm2ro6dwZ/a2sQFZ6q+A6ZWoNHILoyivyk5iX9AQDdXRXuK
         jPTxMvCKbyx23GWWlKzdWrqrLL1I5dI8Iatpub0HJ6CfOo2+x6tQ7H6Rez8JyY+MWK
         P3LSaSDW5hRClqT3Y3ULtqKYyZLsjhNJVnJD9l+EAypfChDySrsn2rgNlmSjuduG29
         jJdAyWFcjqU3Q==
Date:   Fri, 17 Jun 2022 06:37:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20220617113708.GA1177054@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7G5BN4n-jRnfVYOikkk0pCt=ZLB0MW=iKu+s07gieKXg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 10:21:14AM +0800, Huacai Chen wrote:
> On Fri, Jun 17, 2022 at 6:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jun 16, 2022 at 04:39:46PM +0800, Huacai Chen wrote:
> > > On Thu, Jun 9, 2022 at 3:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Jun 08, 2022 at 05:34:21PM +0800, Huacai Chen wrote:
> > > > > On Fri, Jun 3, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> > > > > > > On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > > > > > > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe
> > > > > > > > > services during shutdown") causes poweroff/reboot
> > > > > > > > > failure on systems with LS7A chipset.  We found that if
> > > > > > > > > we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
> > > > > > > > > do_pci_disable_device(), it can work well. The hardware
> > > > > > > > > engineer says that the root cause is that CPU is still
> > > > > > > > > accessing PCIe devices while poweroff/reboot, and if we
> > > > > > > > > disable the Bus Master Bit at this time, the PCIe
> > > > > > > > > controller doesn't forward requests to downstream
> > > > > > > > > devices, and also doesn't send TIMEOUT to CPU, which
> > > > > > > > > causes CPU wait forever (hardware deadlock). This
> > > > > > > > > behavior is a PCIe protocol violation (Bus Master should
> > > > > > > > > not be involved in CPU MMIO transactions), and it will
> > > > > > > > > be fixed in new revisions of hardware (add timeout
> > > > > > > > > mechanism for CPU read request, whether or not Bus
> > > > > > > > > Master bit is cleared).
> > > > > > > >
> > > > > > > > LS7A might have bugs in that clearing Bus Master Enable
> > > > > > > > prevents the root port from forwarding Memory or I/O
> > > > > > > > requests in the downstream direction.
> > > > > > > >
> > > > > > > > But this feels like a bit of a band-aid because we don't
> > > > > > > > know exactly what those requests are.  If we're removing
> > > > > > > > the Root Port, I assume we think we no longer need any
> > > > > > > > devices *below* the Root Port.
> > > > > > > >
> > > > > > > > If that's not the case, e.g., if we still need to produce
> > > > > > > > console output or save state to a device, we probably
> > > > > > > > should not be removing the Root Port at all.
> > > > > > >
> > > > > > > Do you mean it is better to skip the whole
> > > > > > > pcie_port_device_remove() instead of just removing the
> > > > > > > "clear bus master" operation for the buggy hardware?
> > > > > >
> > > > > > No, that's not what I want at all.  That's just another
> > > > > > band-aid to avoid a problem without understanding what the
> > > > > > problem is.
> > > > > >
> > > > > > My point is that apparently we remove a Root Port (which means
> > > > > > we've already removed any devices under it), and then we try
> > > > > > to use a device below the Root Port.  That seems broken.  I
> > > > > > want to understand why we try to use a device after we've
> > > > > > removed it.
> > > > >
> > > > > I agree, and I think "why we try to use a device after remove
> > > > > it" is because the userspace programs don't know whether a
> > > > > device is "usable", so they just use it, at any time. Then it
> > > > > seems it is the responsibility of the device drivers to avoid
> > > > > the problem.
> > > >
> > > > How is userspace able to use a device after the device is removed?
> > > > E.g., if userspace does a read/write to a device that has been
> > > > removed, the syscall should return error, not touch the missing
> > > > device.  If userspace mmaps a device, an access after the device
> > > > has been removed should fault, not do MMIO to the missing device.
> > >
> > > To give more details, let's take the graphics driver (e.g. amdgpu)
> > > as an example again. The userspace programs call printf() to display
> > > "shutting down xxx service" during shutdown/reboot. Or we can even
> > > simplify further, the kernel calls printk() to display something
> > > during shutdown/reboot. You know, printk() can happen at any time,
> > > even after we call pcie_port_device_remove() to disable the pcie
> > > port on the graphic card.
> >
> > I've been focusing on the *remove* path, but you said the problem
> > you're solving is with *poweroff/reboot*.  pcie_portdrv_remove() is
> > used for both paths, but if there's a reason we need those paths to be
> > different, we might be able to split them.
>
> I'm very sorry for that. I have misunderstood before because I suppose
> the "remove path" is the pcie_portdrv_remove() function, but your
> meaning is the .remove() callback in pcie_portdriver. Am I right this
> time?

No need to be sorry, you clearly said from the beginning that this was
a shutdown issue, not a remove issue!  I was just confused because the
.remove() and the .shutdown() callbacks are both
pcie_portdrv_remove(), so I was thinking "remove" even though you said
"poweroff".

> > For remove, we have to assume accesses to the device may already or
> > will soon fail.  A driver that touches the device, or a device that
> > performs DMA, after its drv->remove() method has been called would be
> > seriously broken.  The remove operation also unbinds the driver from
> > the device.
>
> Then what will happen about the "remove path"? If we still take the
> graphics driver as an example, "rmmod amdgpu" always fails with
> "device is busy" because the graphics card is always be used once
> after the driver is loaded. So the "remove path" has no chance to be
> executed.

Do you think this is a problem?  It doesn't sound like a problem to
me, but I don't know anything about graphics drivers.  I assume that
if a device is in use, the expected behavior is that we can't remove
the driver.

> But if we take a NIC driver as an example, "rmmod igb" can
> mostly succeed, and there will be no access on the device after
> removing, at least in our observation. I think there is nothing broken
> about the "remove path".

I agree.

Bjorn
