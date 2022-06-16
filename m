Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051C754EDB4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379091AbiFPW5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379259AbiFPW5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 18:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4064DF44
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 15:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85DD460E05
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 22:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7263C34114;
        Thu, 16 Jun 2022 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655420262;
        bh=XLm2AumHhqtpw6MQtzrn3AgWLTtuFYpc+cRBqBaIlaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KBJP1OoN4AfHaoyPKa+M/ICrqTEa1CylunNUIUdF9lD08BxJuKlBqDOUh4GPlDsPP
         36DefZwJZRBjNBjNFFpKMIiwwdysCe0oHTkna1FYl/OasiAiimtAV+jd1yplPo2D4F
         URlPXsGN2HE3VUAdKdIy2CJ5pjJFs1kNxpIbmsiILOUiwEQwwYvmvGcgNtL3zb69kz
         FhaoEnwioUw3+KXGcnuB+vKCHhFYgkxRIHoMvDzBxkT8a17mf6AYS4jDfyyO36p9LN
         o0whzsa5XTlkk0qJu+xyPPAJJOp81X9ksF0so0z87W7oYOnkxgKEcHAB2/X/95HTn3
         j3Mh78Ld0Tzkw==
Date:   Thu, 16 Jun 2022 17:57:40 -0500
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
Message-ID: <20220616225740.GA1138506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 04:39:46PM +0800, Huacai Chen wrote:
> On Thu, Jun 9, 2022 at 3:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jun 08, 2022 at 05:34:21PM +0800, Huacai Chen wrote:
> > > On Fri, Jun 3, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> > > > > On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > > > > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe
> > > > > > > services during shutdown") causes poweroff/reboot
> > > > > > > failure on systems with LS7A chipset.  We found that if
> > > > > > > we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
> > > > > > > do_pci_disable_device(), it can work well. The hardware
> > > > > > > engineer says that the root cause is that CPU is still
> > > > > > > accessing PCIe devices while poweroff/reboot, and if we
> > > > > > > disable the Bus Master Bit at this time, the PCIe
> > > > > > > controller doesn't forward requests to downstream
> > > > > > > devices, and also doesn't send TIMEOUT to CPU, which
> > > > > > > causes CPU wait forever (hardware deadlock). This
> > > > > > > behavior is a PCIe protocol violation (Bus Master should
> > > > > > > not be involved in CPU MMIO transactions), and it will
> > > > > > > be fixed in new revisions of hardware (add timeout
> > > > > > > mechanism for CPU read request, whether or not Bus
> > > > > > > Master bit is cleared).
> > > > > >
> > > > > > LS7A might have bugs in that clearing Bus Master Enable
> > > > > > prevents the root port from forwarding Memory or I/O
> > > > > > requests in the downstream direction.
> > > > > >
> > > > > > But this feels like a bit of a band-aid because we don't
> > > > > > know exactly what those requests are.  If we're removing
> > > > > > the Root Port, I assume we think we no longer need any
> > > > > > devices *below* the Root Port.
> > > > > >
> > > > > > If that's not the case, e.g., if we still need to produce
> > > > > > console output or save state to a device, we probably
> > > > > > should not be removing the Root Port at all.
> > > > >
> > > > > Do you mean it is better to skip the whole
> > > > > pcie_port_device_remove() instead of just removing the
> > > > > "clear bus master" operation for the buggy hardware?
> > > >
> > > > No, that's not what I want at all.  That's just another
> > > > band-aid to avoid a problem without understanding what the
> > > > problem is.
> > > >
> > > > My point is that apparently we remove a Root Port (which means
> > > > we've already removed any devices under it), and then we try
> > > > to use a device below the Root Port.  That seems broken.  I
> > > > want to understand why we try to use a device after we've
> > > > removed it.
> > >
> > > I agree, and I think "why we try to use a device after remove
> > > it" is because the userspace programs don't know whether a
> > > device is "usable", so they just use it, at any time. Then it
> > > seems it is the responsibility of the device drivers to avoid
> > > the problem.
> >
> > How is userspace able to use a device after the device is removed?
> > E.g., if userspace does a read/write to a device that has been
> > removed, the syscall should return error, not touch the missing
> > device.  If userspace mmaps a device, an access after the device
> > has been removed should fault, not do MMIO to the missing device.
>
> To give more details, let's take the graphics driver (e.g. amdgpu)
> as an example again. The userspace programs call printf() to display
> "shutting down xxx service" during shutdown/reboot. Or we can even
> simplify further, the kernel calls printk() to display something
> during shutdown/reboot. You know, printk() can happen at any time,
> even after we call pcie_port_device_remove() to disable the pcie
> port on the graphic card.

I've been focusing on the *remove* path, but you said the problem
you're solving is with *poweroff/reboot*.  pcie_portdrv_remove() is
used for both paths, but if there's a reason we need those paths to be
different, we might be able to split them.

For remove, we have to assume accesses to the device may already or
will soon fail.  A driver that touches the device, or a device that
performs DMA, after its drv->remove() method has been called would be
seriously broken.  The remove operation also unbinds the driver from
the device.

The semantics of device_shutdown(), pci_device_shutdown(), and any
drv->shutdown() methods are not documented very well.  This path is
only used for halt/poweroff/reboot, so my guess is that not very much
is actually required, and it doesn't do anything at all with respect
to driver binding.

I think we mainly want to disable things that might interfere with
halt/poweroff/reboot, like interrupts and maybe DMA.  We disable DMA
in this path to prevent devices from corrupting memory, but I'm more
open to a quirk in the shutdown path than in the remove path.  So how
about if you clone pcie_port_device_remove() to make a separate
pcie_port_device_shutdown() and put the quirk there?

> The call stack is: printk() --> call_console_drivers() -->
> con->write() --> vt_console_print() --> fbcon_putcs()
> 
> I think this is a scenario of "userspace programs (or kernel itself)
> don't know whether a device is 'usable', so they just use it, at any
> time"
> 
> And why does the graphic driver call .suspend() in its .shutdown() can
> fix the problem?
>
> One of the key operations in .suspend() is drm_fb_helper_set_suspend()
> --> fb_set_suspend() --> info->state = FBINFO_STATE_SUSPENDED;
>
> This operation will cause fbcon_is_inactive() to return true, then
> refuse fbcon_putcs() to really write to the framebuffer.

> > > Take radeon/amdgpu driver as an example, the .shutdown() of the
> > > callback can call suspend() to fix.
> > >
> > > But..., another problem is: There are many drivers "broken", not just
> > > radeon/amdgpu drivers (at least, the ahci driver is also "broken").
> > > Implementing the driver's .shutdown() correctly is nearly impossible
> > > for us, because we don't know the hardware details of so many devices.
> > > On the other hand, those drivers "just works" on most platforms, so
> > > the driver authors don't think they are "broken".
> >
> > It sounds like you have analyzed this and have more details about
> > exactly how this happens.  Can you please share those details?  There
> > are a lot of steps in the middle that I don't understand yet.
> >
> > Without those details, "userspace programs don't know whether a device
> > is 'usable', so they just use it, at any time" is kind of hand-wavey
> > and not very convincing.
> >
> > > So, very sadly, we can only use a band-aid now. :(
> > >
> > > > If the scenario ends up being legitimate and unavoidable, fine -- we
> > > > can figure out a quirk to work around the fact the LS7A doesn't allow
> > > > that access after we clear Bus Master Enable.  But right now the
> > > > scenario smells like a latent bug, and leaving bus mastering enabled
> > > > just avoids it without fixing it.
> > > >
> > > > Bjorn
