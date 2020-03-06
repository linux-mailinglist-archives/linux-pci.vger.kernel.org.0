Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07B717BDC7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCFNIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:08:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53320 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFNIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:44 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiV-0003fw-Tq; Fri, 06 Mar 2020 14:08:40 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 25A3FFF8FB;
        Fri,  6 Mar 2020 14:08:39 +0100 (CET)
Message-Id: <20200306130623.882129117@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 5/7] genirq: Sanitize state handling in check_irq_resend()
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

The code sets IRQS_REPLAY unconditionally whether the resend happens or
not. That doesn't have bad side effects right now, but inconsistent state
is always a latent source of problems.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/resend.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -93,6 +93,8 @@ static int irq_sw_resend(struct irq_desc
  */
 int check_irq_resend(struct irq_desc *desc)
 {
+	int err = 0;
+
 	/*
 	 * We do not resend level type interrupts. Level type interrupts
 	 * are resent by hardware when they are still active. Clear the
@@ -106,13 +108,17 @@ int check_irq_resend(struct irq_desc *de
 	if (desc->istate & IRQS_REPLAY)
 		return -EBUSY;
 
-	if (desc->istate & IRQS_PENDING) {
-		desc->istate &= ~IRQS_PENDING;
-		desc->istate |= IRQS_REPLAY;
+	if (!(desc->istate & IRQS_PENDING))
+		return 0;
 
-		if (!desc->irq_data.chip->irq_retrigger ||
-		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
-		    return irq_sw_resend(desc);
-	}
-	return 0;
+	desc->istate &= ~IRQS_PENDING;
+
+	if (!desc->irq_data.chip->irq_retrigger ||
+	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+		err = irq_sw_resend(desc);
+
+	/* If the retrigger was successfull, mark it with the REPLAY bit */
+	if (!err)
+		desc->istate |= IRQS_REPLAY;
+	return err;
 }

