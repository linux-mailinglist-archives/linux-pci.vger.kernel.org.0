Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C8CEBA28
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfJaXFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 19:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaXFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 19:05:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469D62080F;
        Thu, 31 Oct 2019 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572563134;
        bh=4z2WuELNukNwKuKrFR1f3kQfDOncbIyk/+Kn5OAHdec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L3xc+mry460+mKLDYMYkBOhGK+f+eRRMzhLD3aBVcDSwHy5hy+uJ44c7lwaBi7qoB
         5h4rUMRCnK4Mv96EKpJWUkIToZgZiAhhwC67d28eUGe20yFziukgpXzAiE0veeh28K
         42ADyhYQRSM6yuofTjj2JfBrWqYYQCAv8XwBwXOQ=
Date:   Thu, 31 Oct 2019 18:05:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kar Hin Ong <kar.hin.ong@ni.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
Message-ID: <20191031230532.GA170712@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB625541BF4ADC84690B5C45E9C3630@MN2PR04MB6255.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, IRQ maintainer]

On Thu, Oct 31, 2019 at 03:53:50AM +0000, Kar Hin Ong wrote:
> Hi,
> 
> I've an Intel Haswell system running Linux kernel v4.14 with
> preempt_rt patch. The system contain 2 IOAPICs: IOAPIC 1 is on the
> PCH where IOAPIC 2 is on the CPU.
> 
> I observed that whenever a PCI device is firing interrupt (INTx) to
> Pin 20 of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts: 
>    1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
>    2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously
>       triggered
> 
> The unexpected interrupt is unhandled eventually. When this scenario
> happen more than 99,000 times, kernel disables the interrupt line
> (Pin 19 of IOAPIC 1) and causing device that has requested it become
> malfunction.
> 
> I managed to also reproduced this issue on RHEL 8 and Ubuntu 19-04
> (without preempt_rt patch) after added "threadirqs" to the kernel
> command line.
> 
> After digging further, I noticed that the said issue is happened
> whenever an interrupt pin on IOAPIC 2 is masked:
>  - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1  
>  - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1  
> 
> I also noticed that kernel will explicitly mask a specific interrupt
> pin before execute its handler, if the interrupt is configured as
> "oneshot" (i.e. threaded). See
> https://elixir.bootlin.com/linux/v4.14/source/kernel/irq/chip.c#L695
> This explained why it only happened on RTOS and Desktop Linux with
> "threadirqs" flag, because these configurations force the interrupt
> handler to be threaded.
> 
> From Intel Xeon Processor E5/E7 v3 Product Family External Design
> Specification (EDS), Volume One: Architecture, section 13.1 (Legacy
> PCI Interrupt Handling), it mention: "If the I/OxAPIC entry is
> masked (via the 'mask' bit in the corresponding Redirection Table
> Entry), then the corresponding PCI Express interrupt(s) is forwarded
> to the legacy PCH"
> 
> My interpretation is: when kernel receive a "oneshot" interrupt, it
> mask the line before start handling it (or sending the eoi signal).
> At this moment, if the interrupt line is still asserting, then the
> interrupt signal will be routed to the IOAPIC in PCH, and hence
> causing another interrupt to be fired erroneously.  
> 
> I would like to understand if my interpretation is make sense. If
> yes, should the "oneshot" algorithm need to be updated to support
> Haswell system?

Just to make sure this hasn't already been fixed, can you reproduce
the problem on a current kernel, e.g., v5.3 or v5.4-rc5?

Bjorn
