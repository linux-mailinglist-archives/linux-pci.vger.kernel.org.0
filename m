Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6514F966
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2020 19:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBAS3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Feb 2020 13:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgBAS3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Feb 2020 13:29:37 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F16A20679;
        Sat,  1 Feb 2020 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580581776;
        bh=P8e94BZKTj9lmdkE/2c/5ldrD9NmWWwyxlyqQk4l1gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EnmTA6uquITzdmA7ANHkChnd0CFlid07wbYKc/Iq8EYWj1OvLPKPLyyFaXOr1K62J
         d0+tVMderqvl2+rIcmPbbPcAd/dHI9FKP/mhGdkRYY37XaJeFK5u8LiBItH9fuMaoJ
         9crwcStEy1wSDU5ydTcVgoMu/aSZTumI8yAIrHjc=
Date:   Sat, 1 Feb 2020 12:29:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
Message-ID: <20200201182934.GA6311@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+jdUT6d4CHWFyd1vLopY89YeobaSmzsfXL1u=Lt+hHtnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 01, 2020 at 08:44:40AM +0530, Muni Sekhar wrote:
> On Sat, Feb 1, 2020 at 2:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 31, 2020 at 10:04:05PM +0530, Muni Sekhar wrote:
> > > On Fri, Jan 31, 2020 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Jan 30, 2020 at 09:37:48PM +0530, Muni Sekhar wrote:
> > > > > On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > > > > > > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > > > > > > > > parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> > > > > > > > > I see that my system freezes without capturing the crash dump for
> > > > > > > > > certain tests. I debugged this issue and it was tracked down to the
> > > > > > > > > below mentioned interrupt handler code.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > In ISR, first reads the Interrupt Status register using ‘readl()’ as
> > > > > > > > > given below.
> > > > > > > > >     status = readl(ctrl->reg + INT_STATUS);
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > And then clears the pending interrupts using ‘writel()’ as given blow.
> > > > > > > > >         writel(status, ctrl->reg + INT_STATUS);
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I've noticed a kernel hang if INT_STATUS register read again after
> > > > > > > > > clearing the pending interrupts.
> > > > > > > > >
> > > > > > > > > Can someone clarify me why the kernel hangs without crash dump incase
> > > > > > > > > if I read the INT_STATUS register using readl() after clearing the
> > > > > > > > > pending bits?
> > > > > > > > >
> > > > > > > > > Can readl() block?
> > > > > > > >
> > > > > > > > readl() should not block in software.  Obviously at the hardware CPU
> > > > > > > > instruction level, the read instruction has to wait for the result of
> > > > > > > > the read.  Since that data is provided by the device, i.e., your FPGA,
> > > > > > > > it's possible there's a problem there.
> > > > > > >
> > > > > > > Thank you very much for your reply.
> > > > > > > Where can I find the details about what is protocol for reading the
> > > > > > > ‘memory mapped IO’? Can you point me to any useful links..
> > > > > > > I tried locate the exact point of the kernel code where CPU waits for
> > > > > > > read instruction as given below.
> > > > > > > readl() -> __raw_readl() -> return *(const volatile u32 __force *)add
> > > > > > > Do I need to check for the assembly instructions, here?
> > > > > >
> > > > > > The C pointer dereference, e.g., "*address", will be some sort of a
> > > > > > "load" instruction in assembly.  The CPU wait isn't explicit; it's
> > > > > > just that when you load a value, the CPU waits for the value.
> > > > > >
> > > > > > > > Can you tell whether the FPGA has received the Memory Read for
> > > > > > > > INT_STATUS and sent the completion?
> > > > > > >
> > > > > > > Is there a way to know this with the help of software debugging(either
> > > > > > > enabling dynamic debugging or adding new debug prints)? Can you please
> > > > > > > point some tools\hw needed to find this?
> > > > > >
> > > > > > You could learn this either via a PCIe analyzer (expensive piece of
> > > > > > hardware) or possibly some logic in the FPGA that would log PCIe
> > > > > > transactions in a buffer and make them accessible via some other
> > > > > > interface (you mentioned it had parallel and other interfaces).
> > > > > >
> > > > > > > > On the architectures I'm familiar with, if a device doesn't respond,
> > > > > > > > something would eventually time out so the CPU doesn't wait forever.
> > > > > > >
> > > > > > > What is timeout here? I mean how long CPU waits for completion? Since
> > > > > > > this code runs from interrupt context, does it causes the system to
> > > > > > > freeze if timeout is more?
> > > > > >
> > > > > > The Root Port should have a Completion Timeout.  This is required by
> > > > > > the PCIe spec.  The *reporting* of the timeout is somewhat
> > > > > > implementation-specific since the reporting is outside the PCIe
> > > > > > domain.  I don't know the duration of the timeout, but it certainly
> > > > > > shouldn't be long enough to look like a "system freeze".
> > > > > Does kernel writes to PCIe configuration space register ‘Device
> > > > > Control 2 Register’ (Offset 0x28)? When I tried to read this register,
> > > > > I noticed bit 4 is set (which disables completion timeouts) and rest
> > > > > all other bits are zero. So, Completion Timeout detection mechanism is
> > > > > disabled, right? If so what could be the reason for this?
> > > >
> > > > To my knowledge Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > > > except for one powerpc case.  You can check yourself by using cscope
> > > > or grep to look for PCI_EXP_DEVCTL2_COMP_TMOUT_DIS or PCI_EXP_DEVCTL2.
> > > >
> > > > If you're seeing bit 4 (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS) set, it's
> > > > likely because firmware set it.  You can try booting with
> > > > "pci=earlydump" to see what's there before Linux starts changing
> > > > things.
>
> Yes Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, verified with earlydump.
> Firmware means BIOS? If so is there a way to enable the timeout detection?

Sure; you can change the kernel to turn off
PCI_EXP_DEVCTL2_COMP_TMOUT_DIS (for debugging purposes, at least), or
you can do it with setpci, e.g.,

  # setpci -s01:00.0 CAP_EXP+0x28.W=0x0000

> 01:00.0 RAM memory: PLDA Device 5555
>         Subsystem: Device 4000:0000
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at d0400000 (32-bit, non-prefetchable) [size=4M]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [60] Express Endpoint, MSI 00
>         Kernel driver in use: PLDA PCI
>         Kernel modules: plda_pci
> 
> 00: 56 15 55 55 07 00 10 00 00 00 00 05 10 00 00 00
> 10: 00 00 40 d0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 10 00 02 00 c2 8f 00 00 00 28 01 00 21 f4 03 00
> 70: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 02 00 00 00 10 00 00 00 00 00 00 00
> 90: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> So, on my system, the PCI Express capability is at "[60]" and
> PCI_EXP_DEVCTL2 is at 0x88 with value 0x0010
> (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS). Also this matches what lspci
> decodes:
> 
> $ sudo lspci -vvs00.0 | grep -A1 DevCtl2
>                 DevCtl2: Completion Timeout: 50us to 50ms,
> TimeoutDis+, LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
