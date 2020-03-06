Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77C117BDBB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFNIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:08:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53316 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFNIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:42 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiV-0003fn-AH; Fri, 06 Mar 2020 14:08:39 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B1B69104099;
        Fri,  6 Mar 2020 14:08:38 +0100 (CET)
Message-Id: <20200306130623.684591280@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:44 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 3/7] x86/apic/vector: Force interupt handler invocation to irq context
References: <20200306130341.199467200@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sathyanarayanan reported that the PCI-E AER error injection mechanism
can result in a NULL pointer dereference in apic_ack_edge():

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
 RIP: 0010:apic_ack_edge+0x1e/0x40
 Call Trace:
   handle_edge_irq+0x7d/0x1e0
   generic_handle_irq+0x27/0x30
   aer_inject_write+0x53a/0x720

It crashes in irq_complete_move() which dereferences get_irq_regs() which
is obviously NULL when this is called from non interrupt context.

Of course the pointer could be checked, but that just papers over the real
issue. Invoking the low level interrupt handling mechanism from random code
can wreckage the fragile interrupt affinity mechanism of x86 as interrupts
can only be moved in interrupt context or with special care when a CPU goes
offline and the move has to be enforced.

In the best case this triggers the warning in the MSI affinity setter, but
if the call happens on the correct CPU it just corrupts state and might
prevent further interrupt delivery for the affected device.

Mark the APIC interrupts as unsuitable for being invoked in random contexts.

This prevents the AER injection from proliferating the wreckage, but that's
less broken than the current state of affairs and more correct than just
papering over the problem by sprinkling random checks all over the place
and silently corrupting state.

Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/vector.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -557,6 +557,12 @@ static int x86_vector_alloc_irqs(struct
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
 		/*
+		 * Prevent that any of these interrupts is invoked in
+		 * non interrupt context via e.g. generic_handle_irq()
+		 * as that can corrupt the affinity move state.
+		 */
+		irqd_set_handle_enforce_irqctx(irqd);
+		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
 		 * required for check_timer() to work correctly as it might

