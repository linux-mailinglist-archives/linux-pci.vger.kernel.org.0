Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3296C135231
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 05:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgAIEfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 23:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgAIEfJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 23:35:09 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34850206ED;
        Thu,  9 Jan 2020 04:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578544508;
        bh=QXa52UDQgogCv0yZ0qFyjtSf0PFDJvX8CCIwqKv2hKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rfaSQbAtuEYkNhIkP/sck/+fk20Ie9wy6IjDtGb4nelEYIAOeWVo+ZZJSEubVxV8Z
         WxlWe7djDXDsxGhjcbPuGwxpvZ01n56LkiPmYj5fq7UgZAYRf/9KYiwkixvl6TfjD2
         GLVTnPHJ++MoY7SDhVCixTzoa4GpbuH+0+xVW4xQ=
Date:   Wed, 8 Jan 2020 22:35:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
Message-ID: <20200109043505.GA223446@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+iy9b8Cyc6O=tjzjjixUQqKpTchrQWc+Y4JicAxB_HY5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > Hi,
> > >
> > > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > > parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> > > I see that my system freezes without capturing the crash dump for
> > > certain tests. I debugged this issue and it was tracked down to the
> > > below mentioned interrupt handler code.
> > >
> > >
> > > In ISR, first reads the Interrupt Status register using ‘readl()’ as
> > > given below.
> > >     status = readl(ctrl->reg + INT_STATUS);
> > >
> > >
> > > And then clears the pending interrupts using ‘writel()’ as given blow.
> > >         writel(status, ctrl->reg + INT_STATUS);
> > >
> > >
> > > I've noticed a kernel hang if INT_STATUS register read again after
> > > clearing the pending interrupts.
> > >
> > > Can someone clarify me why the kernel hangs without crash dump incase
> > > if I read the INT_STATUS register using readl() after clearing the
> > > pending bits?
> > >
> > > Can readl() block?
> >
> > readl() should not block in software.  Obviously at the hardware CPU
> > instruction level, the read instruction has to wait for the result of
> > the read.  Since that data is provided by the device, i.e., your FPGA,
> > it's possible there's a problem there.
> 
> Thank you very much for your reply.
> Where can I find the details about what is protocol for reading the
> ‘memory mapped IO’? Can you point me to any useful links..
> I tried locate the exact point of the kernel code where CPU waits for
> read instruction as given below.
> readl() -> __raw_readl() -> return *(const volatile u32 __force *)add
> Do I need to check for the assembly instructions, here?

The C pointer dereference, e.g., "*address", will be some sort of a
"load" instruction in assembly.  The CPU wait isn't explicit; it's
just that when you load a value, the CPU waits for the value.

> > Can you tell whether the FPGA has received the Memory Read for
> > INT_STATUS and sent the completion?
> 
> Is there a way to know this with the help of software debugging(either
> enabling dynamic debugging or adding new debug prints)? Can you please
> point some tools\hw needed to find this?

You could learn this either via a PCIe analyzer (expensive piece of
hardware) or possibly some logic in the FPGA that would log PCIe
transactions in a buffer and make them accessible via some other
interface (you mentioned it had parallel and other interfaces).

> > On the architectures I'm familiar with, if a device doesn't respond,
> > something would eventually time out so the CPU doesn't wait forever.
> 
> What is timeout here? I mean how long CPU waits for completion? Since
> this code runs from interrupt context, does it causes the system to
> freeze if timeout is more?

The Root Port should have a Completion Timeout.  This is required by
the PCIe spec.  The *reporting* of the timeout is somewhat
implementation-specific since the reporting is outside the PCIe
domain.  I don't know the duration of the timeout, but it certainly
shouldn't be long enough to look like a "system freeze".

> lspci output:
> $ lspci
> 00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
> Series SoC Transaction Register (rev 11)
> 00:02.0 VGA compatible controller: Intel Corporation Atom Processor
> Z36xxx/Z37xxx Series Graphics & Display (rev 11)
> 00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series
> SATA AHCI Controller (rev 11)
> 00:14.0 USB controller: Intel Corporation Atom Processor
> Z36xxx/Z37xxx, Celeron N2000 Series USB xHCI (rev 11)
> 00:1a.0 Encryption controller: Intel Corporation Atom Processor
> Z36xxx/Z37xxx Series Trusted Execution Engine (rev 11)
> 00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
> Series High Definition Audio Controller (rev 11)
> 00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> Express Root Port 1 (rev 11)
> 00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> Express Root Port 3 (rev 11)
> 00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> Express Root Port 4 (rev 11)
> 00:1d.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx
> Series USB EHCI (rev 11)
> 00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
> Series Power Control Unit (rev 11)
> 00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus
> Controller (rev 11)
> 01:00.0 RAM memory: PLDA Device 5555

Is this 01:00.0 device the FPGA?

> 03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
