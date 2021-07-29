Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BA3DAF09
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhG2WfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhG2We6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:34:58 -0400
Message-ID: <20210729222542.779791738@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uXX28HYY446PuapxidtNu2nqv20CLiE7a8IJmT71Jlg=;
        b=k1QpCMhStWNPBZzmK5e6NGQuEeVINZ+PG5u0Dq0h4iLGawOZoZweHpM8EVE/dhTLanHlyL
        esO0WXVzGILcpb3tt6cI1TFKUkuI3Y11ZPgaagqOhkUecr5Yj4454PXjqt63WC2ieK/IcP
        J5Is0LJCtyxIM8OpDL1crQpt+e9XqFvGEnl1WDuJWIaAnW8zqWmYAAxAgCN+mQP6qCIr+V
        Z76yKPQ534VH9r3cFYq1IjfYwkj25ZZzyRckCc7q8waYozF0tIqJ1s7PwbHeu9hVX82arH
        fVbi6hYd9tX/13tbenOpnL4sWCPU5XdnRYCL7dvYuImvM/C1dgUNlybOv9+/Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uXX28HYY446PuapxidtNu2nqv20CLiE7a8IJmT71Jlg=;
        b=AUDZZ5yyToY3/ouqtEsRMstTXJN8tdr4OXGz7PY7miRjdijmmjF0snwv/USboisu5FaSSE
        OWIbbU/n4VT0YkCg==
Date:   Thu, 29 Jul 2021 23:51:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 09/19] genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

X86 IO/APIC and MSI interrupts (when used without interrupts remapping)
require that the affinity setup on startup is done before the interrupt is
enabled for the first time as the non-remapped operation mode cannot safely
migrate enabled interrupts from arbitrary contexts. Provide a new irq chip
flag which allows affected hardware to request this.

This has to be opt-in because there have been reports in the past that some
interrupt chips cannot handle affinity setting before startup.

Fixes: 18404756765c ("genirq: Expose default irq affinity mask (take 3)")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>

---
 include/linux/irq.h |    2 ++
 kernel/irq/chip.c   |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -569,6 +569,7 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
+ * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
+	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
 };
 
 #include <linux/irqdesc.h>
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -265,8 +265,11 @@ int irq_startup(struct irq_desc *desc, b
 	} else {
 		switch (__irq_startup_managed(desc, aff, force)) {
 		case IRQ_STARTUP_NORMAL:
+			if (d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP)
+				irq_setup_affinity(desc);
 			ret = __irq_startup(desc);
-			irq_setup_affinity(desc);
+			if (!(d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP))
+				irq_setup_affinity(desc);
 			break;
 		case IRQ_STARTUP_MANAGED:
 			irq_do_set_affinity(d, aff, false);


