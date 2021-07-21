Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4E3D1719
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhGUSrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbhGUSru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:50 -0400
Message-Id: <20210721192650.687529735@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pwHEEYmLAbUc4i2qr603Zxpv2QyDkJm208V/NepdGao=;
        b=cKRWLDWnCs2i9P0yqRlfEEvw16yy1QhLzO0mKEkVltKeKUKG/i2rIlZspVList17emV6uG
        xOB4MBzWKeCbAo4DfR2S11GcUK3kM4XieXvYzAuLGlMWzrAwtFPifX+VbgVx445ObhILkY
        snX0ttokXWqbMZ2w9RP5rutCjsFypMYcWxm0PAAmKhHpsTf2gT2EVuuO1hYSWaQcmPvemm
        rzw+628qtFFijHyVPn8dFgr13NKHlq49XBlDrWGxstIrAvxT9Ltk2R7Uaw4PU7hxdprWSz
        34/BRcIJc4ZSQLc7+mLssYGTkV8PuE3McDX/2/ZUn6FUVJWAO7ZJuWAUWWQbrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pwHEEYmLAbUc4i2qr603Zxpv2QyDkJm208V/NepdGao=;
        b=CF8mopfF2J6rXkAA4ZOmfzYvuDdXShQg+P1uoaRCB8D4muX+3bQF7rcUBLZSAhRHllPBhg
        aDlEPpLnE5MbrhDg==
Date:   Wed, 21 Jul 2021 21:11:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, x86@kernel.org
Subject: [patch 6/8] genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

X86 IO/APIC and MSI interrupts (when used without interrupts remapping)
require that the affinity setup on startup is done before the interrupt is
enabled for the first time as the non-remapped operation mode cannot safely
migrate enabled interrupts from arbitrary contexts. Provide a new irq chip
flag which allows affected hardware to request this.

This has to be opt-in because there have been reports in the past that some
interrupt chips cannot handle affinity setting before startup.

Fixes: 18404756765c ("genirq: Expose default irq affinity mask (take 3)")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
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

