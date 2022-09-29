Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3885EFE64
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiI2UIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiI2UIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 16:08:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167457B1C4
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2022 13:08:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc7so5093925ejb.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2022 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hBkQoOnEix0LjMpII1qozQZ5ma+384pI569IWpQj5jQ=;
        b=DijubPpbu2SimsoGNKcgqOobL0zBda8P8ifeDgv1RE7z096uWV02YsJsOvsgheI+72
         p2v7mx3/KoBLC1F7CoiW49rYvfbOFWWXlhTc0/x1r4nF8mWczU6BoQh6q29C1mkbWhuW
         oDnZzLEsDTuhjYt3IvPwK5JawMZr4blbjkMVBJATLttaR6xlTbv0TXdVlb4nKPLAlra7
         ILEP8mbWsfO/ZlbmhLssIR9TvHDC9xarLnbnalAJlAXcCGaGopHrTNwvch1tzoQ3/sdD
         1uFG+orQMLpsdNeNo5BBbXs37Zhwnqe82ppoVNNumMAWWTaxI6YTFoww33rbX9ST0jCQ
         qgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hBkQoOnEix0LjMpII1qozQZ5ma+384pI569IWpQj5jQ=;
        b=Dfb+T/FOI+dDicDFeId/t9f0p/pVg5urCTaOsrD4tc6B5/CHZWDExIPuX9r+sZqpl8
         DRXeLCBhKq6+bKaBGDljhyDLbM/hBW58rosKYHCPuGxbv+oyxT9pAM2z2I8agI+HGj4C
         gL5t5CdlwGB5hcH716Yz45/kceNABvQbFp2YrDGZeqIbit/GAA8El9bIT4UgALNZp2no
         YhhGh6dBLOT/16Re3iaHwgDn2LWzI5Z7JtPaPFNPxJeVFcFAEoU1FMz4WdpbEFHCgLX2
         Uw/dJoCFLy2cGjU/7Lw0ajbXEfFaVhpB41rleIq+LtGXSV8MoZd7hslV7/JNp/4Myxxg
         y5Og==
X-Gm-Message-State: ACrzQf3hjl8MFEZldbkU8pYHLQvD4wCskYfM+sZqvlmLZxvvxaSnl6zj
        GzLezWx3+Ftw0J4p0eF7R7WsJHL+pODJTG4NMbxqy9133pA4Mg==
X-Google-Smtp-Source: AMsMyM6fbhdmWhOXFjD1zdOplQ4zK9ZDdU5qScOrWRgYzlNmOorH3zxNe1Ax9tPQ7dgpYtCyQWmsCYCPxGMlNaaApGw=
X-Received: by 2002:a17:907:1df1:b0:779:4f57:6bb2 with SMTP id
 og49-20020a1709071df100b007794f576bb2mr4093123ejc.407.1664482081486; Thu, 29
 Sep 2022 13:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHK3GzwYmk6Fr6-YCjEmCweCPBdWJwHDz4Vc8CdX0xfT7b=-xQ@mail.gmail.com>
 <20220928215601.GA1841511@bhelgaas> <86k05m7dkr.wl-maz@kernel.org>
In-Reply-To: <86k05m7dkr.wl-maz@kernel.org>
From:   Kevin Rowland <kevin.p.rowland@gmail.com>
Date:   Thu, 29 Sep 2022 13:07:50 -0700
Message-ID: <CAHK3GzyU6k1eROfzFFj7AZSwnaJ=kqw6Budz=HibiqxmtAGBmQ@mail.gmail.com>
Subject: Re: ARMv8 SError, panic around msi_set_mask_bit during suspend-to-RAM
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 29, 2022 at 2:08 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 28 Sep 2022 17:56:01 -0400,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Marc, Thomas, Manivannan, Krishna because there's recent
> > discussion about changing MSI IRQ affinity late in shutdown:
> > https://lore.kernel.org/linux-pci/?q=b%3Amsi+b%3Aaffinity+]
> >
> > On Wed, Sep 28, 2022 at 12:01:55PM -0700, Kevin Rowland wrote:
> > > Hello all.
> > >
> > > I'm running a custom kernel based on 5.10.72 on an NXP i.MX8QM (an
> > > ARMv8-A system). The i.MX8QM has 2 designware PCIe 3.0 controllers
> > > on-chip. The driver in use is `drivers/pci/controller/dwc/pci-imx6.c`.
> > >
> > > By default the PCIe controller's Link Capabilities are set to support
> > > ASPM L0s only, although the datasheet indicates support for both L0s
> > > and L1. I recently modified the host controller driver to set LnkCap
> > > to indicate ASPM L1 and L0s; one controller is attached to an SSD that
> > > indicates support for L1s, so changing the host controller LnkCap
> > > allowed the `aspm_enabled` bitmask to become non-zero and the ASPM
> > > bits to be set in the LnkCtrl registers on the host and the SSD. This
> > > is the good news.
> > >
> > > The bad news is that after the LnkCap change, when I attempt to
> > > suspend-to-RAM, I get an asynchronous exception (an SError to be
> > > specific) at the CPU, resulting in a kernel panic. Here's the tail end
> > > of the pstore log that was captured from the exception and resulting
> > > panic:
> > > ```
> > > <6>[   90.850564] psci: CPU3 killed (polled 4 ms)
> > > <4>[   90.851989] IRQ 75: no longer affine to CPU4
> > > <4>[   90.852062] IRQ384: set affinity failed(-22).
> > > <4>[   90.852065] IRQ386: set affinity failed(-22).
> > > <5>[   90.852112] CPU4: shutdown
> > > <6>[   90.853135] psci: CPU4 killed (polled 0 ms)
> > > <4>[   90.856402] IRQ384: set affinity failed(-22).
> > > <4>[   90.856409] Eff. affinity 3-5 of IRQ 386 contains only offline
> > > CPUs after offlining CPU 5
> > > <2>[   90.856536] SError Interrupt on CPU5, code 0xbf000002 -- SError
> > > <4>[   90.856538] CPU: 5 PID: 37 Comm: migration/5 Tainted: G
> > > C O      5.10.72-lts-5.10.y+g886272a218dd #1
> > > <4>[   90.856539] Hardware name: Freescale i.MX8QM, Rivian TCM Board X1 (DT)
> > > <4>[   90.856541] pstate: 00000085 (nzcv daIf -PAN -UAO -TCO BTYPE=--)
> > > <4>[   90.856542] pc : msi_set_mask_bit.isra.0+0x40/0x90
> > > <4>[   90.856544] lr : msi_set_mask_bit.isra.0+0x34/0x90
> > > <4>[   90.856545] sp : ffff800012743bf0
> > > <4>[   90.856546] x29: ffff800012743bf0 x28: 0000000000000005
> > > <4>[   90.856550] x27: ffff000806260218 x26: ffff8000121c9260
> > > <4>[   90.856553] x25: ffff800011d1b000 x24: ffff8000121c9480
> > > <4>[   90.856556] x23: ffff80001225a768 x22: ffff000806260260
> > > <4>[   90.856559] x21: ffff0008062602dc x20: ffff000806260200
> > > <4>[   90.856562] x19: ffff00080286b200 x18: 0000000000000020
> > > <4>[   90.856565] x17: 0000000000000001 x16: 0000000000000019
> > > <4>[   90.856567] x15: ffff0008023812f8 x14: 6e696e696c66666f
> > > <4>[   90.856570] x13: 2072657466612073 x12: 55504320656e696c
> > > <4>[   90.856572] x11: 66666f20796c6e6f x10: 20736e6961746e6f
> > > <4>[   90.856575] x9 : ffff8000106aa084 x8 : 4920666f20352d33
> > > <4>[   90.856578] x7 : 207974696e696666 x6 : 0000000000000000
> > > <4>[   90.856581] x5 : 0000000000000000 x4 : 0000000000000000
> > > <4>[   90.856584] x3 : 0000000000000001 x2 : ffff800012d6302c
> > > <4>[   90.856586] x1 : 0000000000000001 x0 : 0000000000000000
> > > <0>[   90.856589] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > <4>[   90.856591] CPU: 5 PID: 37 Comm: migration/5 Tainted: G
> > > C O      5.10.72-lts-5.10.y+g886272a218dd #1
> > > <4>[   90.856592] Hardware name: Freescale i.MX8QM
> > > <4>[   90.856594] Call trace:
> > > <4>[   90.856595]  dump_backtrace+0x0/0x1b0
> > > <4>[   90.856596]  show_stack+0x24/0x30
> > > <4>[   90.856597]  dump_stack+0xd0/0x12c
> > > <4>[   90.856598]  panic+0x178/0x380
> > > <4>[   90.856600]  nmi_panic+0x98/0xa0
> > > <4>[   90.856601]  arm64_serror_panic+0x8c/0x98
> > > <4>[   90.856602]  do_serror+0x64/0x6c
> > > <4>[   90.856603]  el1_error+0x90/0x110
> > > <4>[   90.856604]  msi_set_mask_bit.isra.0+0x40/0x90
> > > <4>[   90.856605]  pci_msi_mask_irq+0x2c/0x40
> > > <4>[   90.856606]  dw_msi_mask_irq+0x24/0x40
> > > <4>[   90.856607]  irq_shutdown+0xa4/0xe0
> > > <4>[   90.856609]  irq_shutdown_and_deactivate+0x24/0x3c
> > > <4>[   90.856610]  irq_migrate_all_off_this_cpu+0x260/0x290
> > > <4>[   90.856611]  __cpu_disable+0xd8/0xf0
> > > <4>[   90.856612]  take_cpu_down+0x48/0xf0
> > > <4>[   90.856613]  multi_cpu_stop+0xb4/0x1a0
> > > <4>[   90.856614]  cpu_stopper_thread+0xa0/0x130
> > > <4>[   90.856615]  smpboot_thread_fn+0x25c/0x290
> > > <4>[   90.856616]  kthread+0x164/0x16c
> > > <4>[   90.856617]  ret_from_fork+0x10/0x30
> > > <2>[   91.856635] SMP: stopping secondary CPUs
> > > <4>[   91.856636] SMP: failed to stop secondary CPUs 0
> > > <0>[   91.856637] Kernel Offset: disabled
> > > <0>[   91.856639] CPU features: 0x0240022,2100600c
> > > <0>[   91.856640] Memory Limit: none
> > > ```
> > >
> > > Note that the exception occurs right around when we're masking MSIs,
> > > which happens because CPU5 goes offline and the kernel recognizes that
> > > there are no more CPUs left to handle those interrupts. To be a little
> > > more specific, the PC indicates that the CPU was executing a data
> > > memory barrier when the exception arrived. Source here [1] and
> > > disassembly below with my annotation showing the PC when the exception
> > > hit:
> > >
> > > ```
> > >        1b64:       b9005260        str     w0, [x19, #80]
> > >            asm volatile(ALTERNATIVE("ldr %w0, [%1]",
> > >        1b68:       f9403260        ldr     x0, [x19, #96]
> > >        1b6c:       b9400000        ldr     w0, [x0]
> > >                    readl(desc->mask_base);         /* Flush write to
> > > device */
> > >        1b70:       d5033dbf        dmb     ld      <--- PC during exception
> > >        1b74:       2a0003e0        mov     w0, w0
> > >        1b78:       ca000000        eor     x0, x0, x0
> > > ```
> > >
> > > At the point of the exception I believe that the PCIe controller is
> > > powered down, although I haven't confirmed.
>
> You can't rely on the PC reported by the exception here, as a SError
> is asynchronous. This dmb is a red herring: it has no effect on the
> target of the load, it just orders subsequent loads after it (it'd be
> different if this was a dsb). So the problem is most probably
> elsewhere.
Understood. My assumption (which I think was naive) was that the
invalid access would have occurred near in time to the exception,
hence my poking at the MSI mask bit write and read-back that occur
just before the DMB.

>
> A read may be a reasonable indication (assuming the SError is caused
> because the read times-out), but it could also have been caused by
> something else *earlier* in the instruction stream. Or be generated by
> something else altogether, outside of the CPU.
>
> > >
> > > - - -
> > >
> > > I'm trying to understand what's going wrong but I've hit a wall. I
> > > thought the act of writing to the MSI_MASK bit while the HC is powered
> > > down is what caused the issue, but I hacked a fix to avoid calling
> > > `msi_set_mask_bit()` during suspend-to-RAM and still got the
> > > exception.
>
> Right, here you go. So either this is caused earlier in the suspend
> process, or by something on the device side. It would help if you
> could bisect this.
>
> > > At this point I'm wondering why we mask MSIs so late in the suspend
> > > process (right when the last non-boot CPU is taken offline). Shouldn't
> > > we disable/mask these IRQs as part of host controller suspend?
>
> This is what we do for *all* interrupts. The question is really
> whether there is any form of PM involved when accessing the device
> implementing the masking.
I'm afraid I didn't understand this part. What is it that we do for
all interrupts? Mask them when the last CPU in their affinity mask is
taken offline, or mask them as part of the suspend process of the
owning device?
>
> Another thing that I have wondered about for a long while is that
> there is a pattern that has been cargo-culted all over the tree
> (including by me), where masking an MSI is done both in the interrupt
> controller and in the endpoint. For example:
>
> static void dw_msi_mask_irq(struct irq_data *d)
> {
>         pci_msi_mask_irq(d);
>         irq_chip_mask_parent(d);
> }
>
> static void dw_msi_unmask_irq(struct irq_data *d)
> {
>         pci_msi_unmask_irq(d);
>         irq_chip_unmask_parent(d);
> }
>
> Normally, we should be able to limit only one of these should be
> called (because masking both in the irqchip and in the PCI device is
> redundant, and there is no guarantee that a non-MSI-X device
> implements masking anyway), and I'd expect that removing
> pci_msi_[un]mask_irq() could help here.
The logic behind this makes sense. If I'm reading the source
correctly, the parent irqchip is `dw_pci_msi_bottom_irq_chip` and its
`.irq_unmask` hook also writes to the RC. I will still try this.
>
> > > I'm also wondering if maybe the PCIe _device_ - the SSD - is writing
> > > into host controller memory after the HC is powered down, which could
> > > cause an exception on the data bus that would obviously be
> > > asynchronous to the CPU. But I've just started learning about PCIe and
> > > I have a very fuzzy understanding of how data flows during an MSI.
>
> If the RC is down, I'm not sure how it could propagate errors back to
> the CPU. But hey, I've seen more bizarre things...
>
> HTH,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
