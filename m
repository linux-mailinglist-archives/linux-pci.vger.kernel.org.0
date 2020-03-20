Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C218CAD4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCTJxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 05:53:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35099 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCTJxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 05:53:13 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFEKv-00015l-M7; Fri, 20 Mar 2020 10:53:05 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 07D27100375; Fri, 20 Mar 2020 10:52:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evgreen@chromium.org>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
Date:   Fri, 20 Mar 2020 10:52:59 +0100
Message-ID: <87d0974akk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mathias,

Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> I can reproduce the lost MSI interrupt issue on 5.6-rc6 which includes
> the "Plug non-maskable MSI affinity race" patch.
>
> I can see this on a couple platforms, I'm running a script that first generates
> a lot of usb traffic, and then in a busyloop sets irq affinity and turns off
> and on cpus:
>
> for i in 1 3 5 7; do
> 	echo "1" > /sys/devices/system/cpu/cpu$i/online
> done
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "F" > "/proc/irq/*/smp_affinity"
> for i in 1 3 5 7; do
> 	echo "0" > /sys/devices/system/cpu/cpu$i/online
> done
> trace snippet: 
>       <idle>-0     [001] d.h.   129.676900: xhci_irq: xhci irq
>       <idle>-0     [001] d.h.   129.677507: xhci_irq: xhci irq
>       <idle>-0     [001] d.h.   129.677556: xhci_irq: xhci irq
>       <idle>-0     [001] d.h.   129.677647: xhci_irq: xhci irq
>       <...>-14     [001] d..1   129.679802: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 2 -> 6

Looks like a regular affinity setting in interrupt context, but I can't
make sense of the time stamps

>       <idle>-0     [003] d.h.   129.682639: xhci_irq: xhci irq
>       <idle>-0     [003] d.h.   129.702380: xhci_irq: xhci irq
>       <idle>-0     [003] d.h.   129.702493: xhci_irq: xhci irq
>  migration/3-24    [003] d..1   129.703150: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 6 -> 0

So this is a CPU offline operation and after that irq 122 is silent, right?

>  kworker/0:0-5     [000] d.h.   131.328790: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   133.312704: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   135.360786: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>       <idle>-0     [000] d.h.   137.344694: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   139.128679: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   141.312686: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   143.360703: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
>  kworker/0:0-5     [000] d.h.   145.344791: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0

That kworker context looks fishy. Can you please enable stacktraces in
the tracer so I can see the call chains leading to this? OTOH that's irq
121 not 122. Anyway moar information is always useful.

And please add the patch below.

Thanks,

        tglx

8<---------------
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -243,6 +243,7 @@ u64 arch_irq_stat(void)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
 	desc = __this_cpu_read(vector_irq[vector]);
+	trace_printk("vector: %u desc %lx\n", vector, (unsigned long) desc);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		if (IS_ENABLED(CONFIG_X86_32))
 			handle_irq(desc, regs);
