Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894DE2B20C0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMQql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 11:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgKMQql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 11:46:41 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2C72137B;
        Fri, 13 Nov 2020 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605286000;
        bh=H6g8Ry6LF3fT3Mg+983j+AekkcPTRIYeNjaYhL8NFMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VFWTK7lpIZBSonIj/NuBM3/IvkQlu/kmCs26BehXS+9c+JMJyMy+BAyAQ9BCKeKGx
         k7mOFHyGZMokejPSCrDUZWaDAJKw/gTqVJn+fP4qWUdrLN45XnqbddpfFrfq5318ft
         IWFT1JiweMqIanVdDN5AnSuvbApEFMhwwIO+jfQU=
Date:   Fri, 13 Nov 2020 10:46:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201113164638.GA1019448@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684cf38f-3977-4ec2-c4a6-7c4c31f9851a@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:14:14AM -0300, Guilherme G. Piccoli wrote:
> On 23/10/2018 14:03, Bjorn Helgaas wrote:
> > On Mon, Oct 22, 2018 at 05:35:06PM -0300, Guilherme G. Piccoli wrote:
> >> On 18/10/2018 19:15, Bjorn Helgaas wrote:
> >>> On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> >>> [...] 
> >> I understand your point, but I think this is inherently an architecture
> >> problem. No matter what solution we decide for, it'll need to be applied
> >> in early boot time, like before the PCI layer gets initialized.
> > 
> > This is the part I want to know more about.  Apparently there's some
> > event X between early_quirks() and the PCI device enumeration, and we
> > must disable MSIs before X:
> > 
> >   setup_arch()
> >       early_quirks()                     # arch/x86/kernel/early-quirks.c
> >       early_pci_clear_msi()
> >   ...
> >   X
> >   ...
> >   pci_scan_root_bus_bridge()
> >     ...
> >     DECLARE_PCI_FIXUP_EARLY              # drivers/pci/quirks.c
> > 
> > I want to know specifically what X is.  If we don't know what X is and
> > all we know is "we have to disable MSIs earlier than PCI init", then
> > we're likely to break things again in the future by changing the order
> > of disabling MSIs and whatever X is.
> 
> Hi Bjorn (and all CCed), I'm sorry to necro-bump a thread >2 years
> later, but recent discussions led to a better understanding of this 'X'
> point, thanks to Thomas!
> 
> For those that deleted this thread from their email clients, it's
> available in [0] - the summary is that we faced an IRQ storm really
> early in boot, due to a bogus PCIe device MSI behavior, when booting a
> kdump kernel. This led the machine to get stuck in the boot and we
> couldn't kdump. The solution hereby proposed is to clear MSI interrupts
> early in x86, if a parameter is provided. I don't have the reproducer
> anymore and it was pretty hard to reproduce in virtual environments.
> 
> So, about the 'X' Bjorn, in another recent thread about IRQ storms [1],
> Thomas clarified that and after a brief discussion, it seems there's no
> better way to prevent the MSI storm other than clearing the MSI
> capability early in boot. As discussed both here and in thread [1], this
> is indeed a per-architecture issue (powerpc is not subject to that, due
> to a better FW reset mechanism), so I think we still could benefit in
> having this idea implemented upstream, at least in x86 (we could expand
> to other architectures if desired, in the future).
> 
> As a "test" data point, this was implemented in Ubuntu (same 3 patches
> present in this series) for ~2 years and we haven't received bug reports
> - I'm saying that because I understand your concerns about expanding the
> early PCI quirks scope.
> 
> Let me know your thoughts. I'd suggest all to read thread [1], which
> addresses a similar issue but in a different "moment" of the system boot
> and provides some more insight on why the early MSI clearing seems to
> make sense.

I guess Thomas' patch [2] (from thread [1]) doesn't solve this
problem?

I think [0] proposes using early_quirks() to disable MSIs at
boot-time.  That doesn't seem like a robust solution because (a) the
problem affects all arches but early_quirks() is x86-specific and (b)
even on x86 early_quirks() only works for PCI segment 0 because it
relies on the 0xCF8/0xCFC I/O ports.

If I understand Thomas' email correctly, the IRQ storm occurs here:

  start_kernel
    setup_arch
      early_quirks               # x86-only
        ...
          read_pci_config_16(num, slot, func, PCI_VENDOR_ID)
            outl(..., 0xcf8)     # PCI segment 0 only
            inw(0xcfc)
    local_irq_enable
      ...
        native_irq_enable
          asm("sti")             # <-- enable IRQ, storm occurs

native_irq_enable() happens long before we discover PCI host bridges
and run the normal PCI quirks, so those would be too late to disable
MSIs.

It doesn't seem practical to disable MSIs in the kdump kernel at the
PCI level.  I was hoping we could disable them somewhere in the IRQ
code, e.g., at IOAPICs, but I think Thomas is saying that's not
feasible.

It seems like the only option left is to disable MSIs before the
kexec.  We used to clear the MSI/MSI-X Enable bits in
pci_device_shutdown(), but that broke console devices that relied on
MSI and caused "nobody cared" warnings when the devices fell back to
using INTx, so fda78d7a0ead ("PCI/MSI: Stop disabling MSI/MSI-X in
pci_device_shutdown()") left them unchanged.

pci_device_shutdown() still clears the Bus Master Enable bit if we're
doing a kexec and the device is in D0-D3hot, which should also disable
MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
device causing the storm was in PCI_UNKNOWN state?

> [0] https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
> 
> [1] https://lore.kernel.org/lkml/87y2js3ghv.fsf@nanos.tec.linutronix.de

[2] https://lore.kernel.org/lkml/87tuueftou.fsf@nanos.tec.linutronix.de/

Notes to my future self about related changes:

  2008-04-23 d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2")
    Disable MSI before kexec because new kernel isn't prepared for MSI

  2011-10-17 d5dea7d95c48 ("PCI: msi: Disable msi interrupts when we initialize a pci device")
    Disable MSI/MSI-X at boot; only works for new kernels with
    CONFIG_PCI_MSI=y

  2012-04-27 b566a22c2332 ("PCI: disable Bus Master on PCI device shutdown")
    Disable bus mastering on shutdown (if enable/disable nested correctly)

  2013-02-04 7897e6022761 ("PCI: Disable Bus Master unconditionally in pci_device_shutdown()")
    Disable bus mastering unconditionally (ignore nested enable/disable)

  2013-03-14 6e0eda3c3898 ("PCI: Don't try to disable Bus Master on disconnected PCI devices")
    Don't touch bus mastering for D3cold or unknown state

  2015-05-07 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
    Disable MSI/MSI-X at boot even without CONFIG_PCI_MSI=y; broke
    Open Firmware arches

  2015-10-21 e80e7edc55ba ("PCI/MSI: Initialize MSI capability for all architectures")
    Disable MSI/MSI-X at boot for all arches, including Open Firmware

  2017-01-26 fda78d7a0ead ("PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()")
    Leave MSI enabled before kexec; disabling causes device to use INTx,
    which drivers aren't prepared for, causing "nobody cared" warnings
