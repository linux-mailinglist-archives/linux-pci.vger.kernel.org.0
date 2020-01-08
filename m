Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C4134CF2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 21:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgAHUPO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 15:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgAHUPO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 15:15:14 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EA320720;
        Wed,  8 Jan 2020 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578514513;
        bh=tBezumwZiXfw+iJuCA5Lb1jx5XYFSgomgl+Q0fDWQEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JA9MYxg2ki1Fe5w3z7DzwsYokFOH5foJzaqnzkIZNJwyAmJJlebcnJHLEPgqjqIHn
         7l0uUFm5+S/T6rt62KSWWjkE7IFhcsN9HCSbYx63qstiC9qzJSgM/h0L5MmknoW0BQ
         8rlaNSPjGMiBNmkUe2IXmAR9Wl84lUxL4bpuZCng=
Date:   Wed, 8 Jan 2020 14:15:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
Message-ID: <20200108201511.GA195980@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+ijBTp55gZYAejWthnvdmR_qyQJpVV4r1gyQ-Kud6t9qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> Hi,
> 
> I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> I see that my system freezes without capturing the crash dump for
> certain tests. I debugged this issue and it was tracked down to the
> below mentioned interrupt handler code.
> 
> 
> In ISR, first reads the Interrupt Status register using ‘readl()’ as
> given below.
>     status = readl(ctrl->reg + INT_STATUS);
> 
> 
> And then clears the pending interrupts using ‘writel()’ as given blow.
>         writel(status, ctrl->reg + INT_STATUS);
> 
> 
> I've noticed a kernel hang if INT_STATUS register read again after
> clearing the pending interrupts.
> 
> Can someone clarify me why the kernel hangs without crash dump incase
> if I read the INT_STATUS register using readl() after clearing the
> pending bits?
> 
> Can readl() block?

readl() should not block in software.  Obviously at the hardware CPU
instruction level, the read instruction has to wait for the result of
the read.  Since that data is provided by the device, i.e., your FPGA,
it's possible there's a problem there.

Can you tell whether the FPGA has received the Memory Read for
INT_STATUS and sent the completion?

On the architectures I'm familiar with, if a device doesn't respond,
something would eventually time out so the CPU doesn't wait forever.

> Snippet of the ISR code is given blow:
> 
> https://pastebin.com/WdnZJZF5
> 
> 
> 
> static irqreturn_t pcie_isr(int irq, void *dev_id)
> 
> {
> 
>         struct test_device *ctrl = data;
> 
>         u32 status;
> 
> …
> 
> 
> 
>         status = readl(ctrl->reg + INT_STATUS);
> 
>         /*
> 
>          * Check to see if it was our interrupt
> 
>          */
> 
>         if (!(status & 0x000C))
> 
>                 return IRQ_NONE;
> 
> 
> 
>         /* Clear the interrupt */
> 
>         writel(status, ctrl->reg + INT_STATUS);
> 
> 
> 
>         if (status & 0x0004) {
> 
>                 /*
> 
>                  * Tx interrupt pending.
> 
>                  */
> 
>                  ....
> 
>        }
> 
> 
> 
>         if (status & 0x0008) {
> 
>                 /* Rx interrupt Pending */
> 
>                 /* The system freezes if I read again the INT_STATUS
> register as given below */
> 
>                 status = readl(ctrl->reg + INT_STATUS);
> 
>                 ....
> 
>         }
> 
> ..
> 
>         return IRQ_HANDLED;
> }
> 
> 
> 
> -- 
> Thanks,
> Sekhar
