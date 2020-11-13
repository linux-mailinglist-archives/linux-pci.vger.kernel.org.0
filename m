Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C92B292C
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 00:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMXbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMXbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 18:31:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B785C0613D1;
        Fri, 13 Nov 2020 15:31:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605310269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xc3rTvoMmqA9/0bADmRAVBpeW9tL0Jxl2wS+CPsu+a4=;
        b=0Qu1Q0UZ/BxKCQd6wellIwDfTCdCpY0dyXxfGNsgiQNZ61XEy8DaMw+FNB/lFd7jvsmzqO
        O2gGNgPakh5wigR+iXi7rAISWU7J7psOdOSYEfeVrBBkYCuYOwRpO6LU3aJj9sqoHptZbT
        b9ptYVl5cX6LGeTPAA+qQv7n7yKe/YDt7XQLdhKS/bZYmOJjPawx+q5yCX73PShhHk5p+1
        TpYGBO2dBhuhQnutENm3+rep6iPMe5zSkrcwxBWn6XxQ/Q9+39yuqiaZ2p26fI2KDUZ3LQ
        mkHHYQfvACx/pRKLpblbNYWe4jriVHoXhZS4xZ9S0ATeDvirU8YO4s/mEU8ImQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605310269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xc3rTvoMmqA9/0bADmRAVBpeW9tL0Jxl2wS+CPsu+a4=;
        b=2oZMmbkzYFkgGooi4AKbzJ3C1mo3gBtfBj5w6I48soQbwLPQlSxET8mO0yIHUynv029650
        z/9ha1MSbiwnxXBQ==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <20201113164638.GA1019448@bjorn-Precision-5520>
References: <20201113164638.GA1019448@bjorn-Precision-5520>
Date:   Sat, 14 Nov 2020 00:31:09 +0100
Message-ID: <87ft5cltqa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 10:14:14AM -0300, Guilherme G. Piccoli wrote:
>> On 23/10/2018 14:03, Bjorn Helgaas wrote:
> I guess Thomas' patch [2] (from thread [1]) doesn't solve this
> problem?

No. As I explained in [1] patch from [2] cannot solve it because the
patch from [2] which is what Liu was trying to solve requires that there
is a registered interrupt handler which knows how to shut up the
interrupt.

> I think [0] proposes using early_quirks() to disable MSIs at
> boot-time.  That doesn't seem like a robust solution because (a) the
> problem affects all arches but early_quirks() is x86-specific and (b)
> even on x86 early_quirks() only works for PCI segment 0 because it
> relies on the 0xCF8/0xCFC I/O ports.
>
> If I understand Thomas' email correctly, the IRQ storm occurs here:
>
>   start_kernel
>     setup_arch
>       early_quirks               # x86-only
>         ...
>           read_pci_config_16(num, slot, func, PCI_VENDOR_ID)
>             outl(..., 0xcf8)     # PCI segment 0 only
>             inw(0xcfc)
>     local_irq_enable
>       ...
>         native_irq_enable
>           asm("sti")             # <-- enable IRQ, storm occurs
>
> native_irq_enable() happens long before we discover PCI host bridges
> and run the normal PCI quirks, so those would be too late to disable
> MSIs.

Correct.

> It doesn't seem practical to disable MSIs in the kdump kernel at the
> PCI level.  I was hoping we could disable them somewhere in the IRQ
> code, e.g., at IOAPICs, but I think Thomas is saying that's not
> feasible.

MSIs are not even going near the IOAPIC and as long as the interrupt
core does not have an interrupt set up for the device is has no idea
where to look at to shut it down. Actually it does not even reach the
interrupt core. The raised vector arrives at the CPU and the low level
code sees: No handler associated, ignore it. We cannot do anything from
the low level code because all we know is that the vector was raised,
but we have absolutely zero clue where that came from. At that point the
IO-APIC interrupts are definitely not the problem because they are all
disabled.

> It seems like the only option left is to disable MSIs before the
> kexec.  We used to clear the MSI/MSI-X Enable bits in
> pci_device_shutdown(), but that broke console devices that relied on
> MSI and caused "nobody cared" warnings when the devices fell back to
> using INTx, so fda78d7a0ead ("PCI/MSI: Stop disabling MSI/MSI-X in
> pci_device_shutdown()") left them unchanged.

That might be solvable because INTx arrives at the IO-APIC and we could
mask all the INTx related IO-APIC lines, but that's icky because of
this:

> pci_device_shutdown() still clears the Bus Master Enable bit if we're
> doing a kexec and the device is in D0-D3hot, which should also disable
> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
> device causing the storm was in PCI_UNKNOWN state?

That's indeed a really good question.

Thanks,

        tglx
