Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41A918A30F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRTXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 15:23:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:53523 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRTXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 15:23:12 -0400
IronPort-SDR: l17tzpdCnhbsuD5T0P8p9+cq8hLw4x84jbkeo2nz+pY2euY6mv2ghEsuQtAkJiGsYubbcul9nH
 PuUsPVkjipkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 12:23:12 -0700
IronPort-SDR: lc5+nY8X20RmwOMgWKXaoabS743UxfyckFxokQD5dmmPSwnKBEfxIjKKUuruIrUw8jnowK2Hls
 iHuLWM/iNJkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="244923072"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2020 12:23:09 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evgreen@chromium.org>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
To:     x86@kernel.org
Message-ID: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
Date:   Wed, 18 Mar 2020 21:25:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

I can reproduce the lost MSI interrupt issue on 5.6-rc6 which includes
the "Plug non-maskable MSI affinity race" patch.

I can see this on a couple platforms, I'm running a script that first generates
a lot of usb traffic, and then in a busyloop sets irq affinity and turns off
and on cpus:

for i in 1 3 5 7; do
	echo "1" > /sys/devices/system/cpu/cpu$i/online
done
echo "A" > "/proc/irq/*/smp_affinity"
echo "A" > "/proc/irq/*/smp_affinity"
echo "F" > "/proc/irq/*/smp_affinity"
for i in 1 3 5 7; do
	echo "0" > /sys/devices/system/cpu/cpu$i/online
done

I added some very simple debugging but I don't really know what to look for.
xhci interrupts (122) just stop after a setting msi affinity, it survived many
similar msi_set_affinity() calls before this.

I'm not that familiar with the inner workings of this, but I'll be happy to
help out with adding debugging and testing patches.

Details:

 cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
   0:         26          0          0          0          0          0          0          0   IO-APIC    2-edge      timer
   1:          0          0          0          0          0          7          0          0   IO-APIC    1-edge      i8042
   4:          0          4      59941          0          0          0          0          0   IO-APIC    4-edge      ttyS0
   8:          0          0          0          0          0          0          1          0   IO-APIC    8-edge      rtc0
   9:          0         40          8          0          0          0          0          0   IO-APIC    9-fasteoi   acpi
  16:          0          0          0          0          0          0          0          0   IO-APIC   16-fasteoi   i801_smbus
 120:          0          0        293          0          0          0          0          0   PCI-MSI 32768-edge      i915
 121:        728          0          0         58          0          0          0          0   PCI-MSI 520192-edge      enp0s31f6
 122:      63575       2271          0       1957       7262          0          0          0   PCI-MSI 327680-edge      xhci_hcd
 123:          0          0          0          0          0          0          0          0   PCI-MSI 514048-edge      snd_hda_intel:card0
 NMI:          0          0          0          0          0          0          0          0   Non-maskable interrupts
 
trace snippet: 
      <idle>-0     [001] d.h.   129.676900: xhci_irq: xhci irq
      <idle>-0     [001] d.h.   129.677507: xhci_irq: xhci irq
      <idle>-0     [001] d.h.   129.677556: xhci_irq: xhci irq
      <idle>-0     [001] d.h.   129.677647: xhci_irq: xhci irq
      <...>-14    [001] d..1   129.679802: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 2 -> 6
      <idle>-0     [003] d.h.   129.682639: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.682769: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.682908: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.683552: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.683677: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.683819: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.689017: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.689140: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.689307: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.689984: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.690107: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.690278: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.695541: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.695674: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.695839: xhci_irq: xhci irq
      <idle>-0     [003] d.H.   129.696667: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.696797: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.696973: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.702288: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.702380: xhci_irq: xhci irq
      <idle>-0     [003] d.h.   129.702493: xhci_irq: xhci irq
 migration/3-24    [003] d..1   129.703150: msi_set_affinity: direct update msi 122, vector 33 -> 33, apicid: 6 -> 0
 kworker/0:0-5     [000] d.h.   131.328790: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   133.312704: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   135.360786: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
      <idle>-0     [000] d.h.   137.344694: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   139.128679: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   141.312686: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   143.360703: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0
 kworker/0:0-5     [000] d.h.   145.344791: msi_set_affinity: direct update msi 121, vector 34 -> 34, apicid: 0 -> 0


--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -92,6 +92,10 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
            cfg->vector == old_cfg.vector ||
            old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
            cfg->dest_apicid == old_cfg.dest_apicid) {
+               trace_printk("direct update msi %u, vector %u -> %u, apicid: %u -> %u\n",
+                    irqd->irq,
+                    old_cfg.vector, cfg->vector,
+                    old_cfg.dest_apicid, cfg->dest_apicid);
                irq_msi_update_msg(irqd, cfg);
                return ret;
        }
@@ -134,7 +138,10 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
         */
        if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
                this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
-
+       trace_printk("twostep update msi, irq %u, vector %u -> %u, apicid: %u -> %u\n",
+                    irqd->irq,
+                    old_cfg.vector, cfg->vector,
+                    old_cfg.dest_apicid, cfg->dest_apicid);
        /* Redirect it to the new vector on the local CPU temporarily */
        old_cfg.vector = cfg->vector;
        irq_msi_update_msg(irqd, &old_cfg);

Thanks
-Mathias
