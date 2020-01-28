Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E314C323
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1Wsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 17:48:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1Wsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2020 17:48:39 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwZer-0006o0-HV; Tue, 28 Jan 2020 23:48:33 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 084FB101227; Tue, 28 Jan 2020 23:48:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com> <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com> <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com> <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de> <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
Date:   Tue, 28 Jan 2020 23:48:32 +0100
Message-ID: <87pnf342pr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan,

Evan Green <evgreen@chromium.org> writes:
> On Tue, Jan 28, 2020 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The patch is only lightly tested, but so far it survived.
>>
>
> Hi Thomas,
> Thanks for the patch, I gave it a try. I get the following splat, then a hang:
>
> [   62.238406]        CPU0
> [   62.241135]        ----
> [   62.243863]   lock(vector_lock);
> [   62.247467]   lock(vector_lock);
> [   62.251071]
> [   62.251071]  *** DEADLOCK ***
> [   62.251071]
> [   62.257687]  May be due to missing lock nesting notation
> [   62.257687]
> [   62.265274] 2 locks held by migration/1/17:
> [   62.269946]  #0: 00000000cfa9d8c3 (&irq_desc_lock_class){-.-.}, at:
> irq_migrate_all_off_this_cpu+0x44/0x28f
> [   62.280846]  #1: 000000006885da2d (vector_lock){-.-.}, at:
> msi_set_affinity+0x13c/0x27b
> [   62.289801]
> [   62.289801] stack backtrace:
> [   62.294669] CPU: 1 PID: 17 Comm: migration/1 Not tainted 4.19.96 #2
> [   62.310713] Call Trace:
> [   62.313446]  dump_stack+0xac/0x11e
> [   62.317255]  __lock_acquire+0x64f/0x19bc
> [   62.321646]  ? find_held_lock+0x3d/0xb8
> [   62.325936]  ? pci_conf1_write+0x4f/0xdf
> [   62.330320]  lock_acquire+0x1b2/0x1fa
> [   62.334413]  ? apic_retrigger_irq+0x31/0x63
> [   62.339097]  _raw_spin_lock_irqsave+0x51/0x7d
> [   62.343972]  ? apic_retrigger_irq+0x31/0x63
> [   62.348646]  apic_retrigger_irq+0x31/0x63
> [   62.353124]  msi_set_affinity+0x25a/0x27b

Bah. I'm sure I looked at that call chain, noticed the double vector
lock and then forgot. Delta patch below.

Thanks,

        tglx

8<--------------
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -64,6 +64,7 @@ msi_set_affinity(struct irq_data *irqd,
 	struct irq_cfg old_cfg, *cfg = irqd_cfg(irqd);
 	struct irq_data *parent = irqd->parent_data;
 	unsigned int cpu;
+	bool pending;
 	int ret;
 
 	/* Save the current configuration */
@@ -147,9 +148,13 @@ msi_set_affinity(struct irq_data *irqd,
 	 * vector/CPU. Check whether the transition raced with a device
 	 * interrupt and is pending in the local APICs IRR.
 	 */
-	if (lapic_vector_set_in_irr(cfg->vector))
-		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+	pending = lapic_vector_set_in_irr(cfg->vector);
+
 	unlock_vector_lock();
+
+	if (pending)
+		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+
 	return ret;
 }
 
