Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7B14E2D3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgA3TAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 14:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgA3TAn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 14:00:43 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A019F20707;
        Thu, 30 Jan 2020 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410842;
        bh=0V7/13J81EhycIrEm5fbG8cZoHrvu3RkJ0uQ6AYKmdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=x/FbzEiXAeCzgutao2QMOoM0wfo2bZwEKIdS1yXImdUT16yth7tm26Tl35DmJSB00
         zPe0dQPesVg3xCd3MyNJ+Qy9g8sSsSbjL6cyuglam2aC9dfaXqlJnS1J92MD4vRBxh
         bdMq6gAWstR1sZAbQD3rVgLh9tVcpWzRR+S7/M98=
Date:   Thu, 30 Jan 2020 13:00:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
Message-ID: <20200130190040.GA96992@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+ijB_SNqRiC1Fn0Uw3OpiS7go4dPPYm6YZckaQ0fuq=QQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 30, 2020 at 09:37:48PM +0530, Muni Sekhar wrote:
> On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > > > Hi,
> > > > >
> > > > > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > > > > parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> > > > > I see that my system freezes without capturing the crash dump for
> > > > > certain tests. I debugged this issue and it was tracked down to the
> > > > > below mentioned interrupt handler code.
> > > > >
> > > > >
> > > > > In ISR, first reads the Interrupt Status register using ‘readl()’ as
> > > > > given below.
> > > > >     status = readl(ctrl->reg + INT_STATUS);
> > > > >
> > > > >
> > > > > And then clears the pending interrupts using ‘writel()’ as given blow.
> > > > >         writel(status, ctrl->reg + INT_STATUS);
> > > > >
> > > > >
> > > > > I've noticed a kernel hang if INT_STATUS register read again after
> > > > > clearing the pending interrupts.
> > > > >
> > > > > Can someone clarify me why the kernel hangs without crash dump incase
> > > > > if I read the INT_STATUS register using readl() after clearing the
> > > > > pending bits?
> > > > >
> > > > > Can readl() block?
> > > >
> > > > readl() should not block in software.  Obviously at the hardware CPU
> > > > instruction level, the read instruction has to wait for the result of
> > > > the read.  Since that data is provided by the device, i.e., your FPGA,
> > > > it's possible there's a problem there.
> > >
> > > Thank you very much for your reply.
> > > Where can I find the details about what is protocol for reading the
> > > ‘memory mapped IO’? Can you point me to any useful links..
> > > I tried locate the exact point of the kernel code where CPU waits for
> > > read instruction as given below.
> > > readl() -> __raw_readl() -> return *(const volatile u32 __force *)add
> > > Do I need to check for the assembly instructions, here?
> >
> > The C pointer dereference, e.g., "*address", will be some sort of a
> > "load" instruction in assembly.  The CPU wait isn't explicit; it's
> > just that when you load a value, the CPU waits for the value.
> >
> > > > Can you tell whether the FPGA has received the Memory Read for
> > > > INT_STATUS and sent the completion?
> > >
> > > Is there a way to know this with the help of software debugging(either
> > > enabling dynamic debugging or adding new debug prints)? Can you please
> > > point some tools\hw needed to find this?
> >
> > You could learn this either via a PCIe analyzer (expensive piece of
> > hardware) or possibly some logic in the FPGA that would log PCIe
> > transactions in a buffer and make them accessible via some other
> > interface (you mentioned it had parallel and other interfaces).
> >
> > > > On the architectures I'm familiar with, if a device doesn't respond,
> > > > something would eventually time out so the CPU doesn't wait forever.
> > >
> > > What is timeout here? I mean how long CPU waits for completion? Since
> > > this code runs from interrupt context, does it causes the system to
> > > freeze if timeout is more?
> >
> > The Root Port should have a Completion Timeout.  This is required by
> > the PCIe spec.  The *reporting* of the timeout is somewhat
> > implementation-specific since the reporting is outside the PCIe
> > domain.  I don't know the duration of the timeout, but it certainly
> > shouldn't be long enough to look like a "system freeze".
> Does kernel writes to PCIe configuration space register ‘Device
> Control 2 Register’ (Offset 0x28)? When I tried to read this register,
> I noticed bit 4 is set (which disables completion timeouts) and rest
> all other bits are zero. So, Completion Timeout detection mechanism is
> disabled, right? If so what could be the reason for this?

To my knowledge Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
except for one powerpc case.  You can check yourself by using cscope
or grep to look for PCI_EXP_DEVCTL2_COMP_TMOUT_DIS or PCI_EXP_DEVCTL2.

If you're seeing bit 4 (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS) set, it's
likely because firmware set it.  You can try booting with
"pci=earlydump" to see what's there before Linux starts changing
things.

Bjorn
