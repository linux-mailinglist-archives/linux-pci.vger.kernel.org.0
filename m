Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CA3DAF12
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhG2WfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhG2WfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F1C0617A5;
        Thu, 29 Jul 2021 15:34:56 -0700 (PDT)
Message-ID: <20210729222542.832143400@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GHTKh4UC+3cHiKHivf/3mVjBEH0mFWprbVF8XAiQXIM=;
        b=jeCl9FoJl2MlO8vzlanvz1uGTg04MpSaLs31DceSx6WPAlKOx/AQdo1WjlhndrAEcvKJj4
        U5ght6x3MCoIM8Z6NKJ/e0WrqFm7t1tCxeLXWjm6JNCf5FXUPTKHakYxJD+GVJZAXj9Spp
        jSI+fVaOYXB2PbYZ8Thk5gbMiFB6dtRc8Z7PF1hoVtUfDjYhJUP3yHuuUgsCkVnCLyr4cD
        ByVTJBkMXljDLVo4TgQCdvNK+LqfxlWruQTk6u96glw1YfilHLW83ZuLisuKThZeaqUCP/
        QkkRitsuKVZCsZ4aFoP/WMtwQKgYlpkJ/ySJuVkMHYICVu9dYfkhVga2+F1tvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GHTKh4UC+3cHiKHivf/3mVjBEH0mFWprbVF8XAiQXIM=;
        b=nzk+7ntFNMy11TbPDHkrvdjov5K5aeeZ1KtIaiO1RBWoIato6RaGOUJBHRlydY4nflRP2r
        eoqV001E73esWrAA==
Date:   Thu, 29 Jul 2021 23:51:49 +0200
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
Subject: [patch V2 10/19] x86/ioapic: Force affinity setup before startup
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The IO/APIC cannot handle interrupt affinity changes safely after startup
other than from an interrupt handler. The startup sequence in the generic
interrupt code violates that assumption.

Mark the irq chip with the new IRQCHIP_AFFINITY_PRE_STARTUP flag so that
the default interrupt setting happens before the interrupt is started up
for the first time.

Fixes: 18404756765c ("genirq: Expose default irq affinity mask (take 3)")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>

---
 arch/x86/kernel/apic/io_apic.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1986,7 +1986,8 @@ static struct irq_chip ioapic_chip __rea
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip ioapic_ir_chip __read_mostly = {
@@ -1999,7 +2000,8 @@ static struct irq_chip ioapic_ir_chip __
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static inline void init_IO_APIC_traps(void)


