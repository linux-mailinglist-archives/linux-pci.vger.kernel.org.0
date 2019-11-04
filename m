Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9DDEF147
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfKDXlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 18:41:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39134 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfKDXlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 18:41:19 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRlyC-00019P-9m; Tue, 05 Nov 2019 00:41:12 +0100
Date:   Tue, 5 Nov 2019 00:41:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Kar Hin Ong <kar.hin.ong@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
In-Reply-To: <20191031230532.GA170712@google.com>
Message-ID: <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
References: <20191031230532.GA170712@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Oct 2019, Bjorn Helgaas wrote:
> On Thu, Oct 31, 2019 at 03:53:50AM +0000, Kar Hin Ong wrote:
> > I've an Intel Haswell system running Linux kernel v4.14 with
> > preempt_rt patch. The system contain 2 IOAPICs: IOAPIC 1 is on the
> > PCH where IOAPIC 2 is on the CPU.
> > 
> > I observed that whenever a PCI device is firing interrupt (INTx) to
> > Pin 20 of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts: 
> >    1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
> >    2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously
> >       triggered
> >
> > The unexpected interrupt is unhandled eventually. When this scenario
> > happen more than 99,000 times, kernel disables the interrupt line
> > (Pin 19 of IOAPIC 1) and causing device that has requested it become
> > malfunction.
> > 
> > I managed to also reproduced this issue on RHEL 8 and Ubuntu 19-04
> > (without preempt_rt patch) after added "threadirqs" to the kernel
> > command line.
> > 
> > After digging further, I noticed that the said issue is happened
> > whenever an interrupt pin on IOAPIC 2 is masked:
> >  - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1  
> >  - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1

This is pretty much the same problem which we had analyzed and worked
around years ago.

> > From Intel Xeon Processor E5/E7 v3 Product Family External Design
> > Specification (EDS), Volume One: Architecture, section 13.1 (Legacy
> > PCI Interrupt Handling), it mention: "If the I/OxAPIC entry is
> > masked (via the 'mask' bit in the corresponding Redirection Table
> > Entry), then the corresponding PCI Express interrupt(s) is forwarded
> > to the legacy PCH"

Oh well. Really useful behaviour - NOT!

> > I would like to understand if my interpretation is make sense. If
> > yes, should the "oneshot" algorithm need to be updated to support
> > Haswell system?

No. You cannot change the oneshot algorithm.

The workarounds for this are enabled by PCI quirls and either
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y or 'ioapicreroute' on the command
line.

It might be wortha try to add the PCI ID of that box to the quirk list,
i.e. the PCI ID matches in drivers/pci/quirks.c which belong to the
function: quirk_reroute_to_boot_interrupts_intel().

Thanks,

	tglx
