Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B84421241
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhJDPHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 11:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhJDPHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 11:07:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADFE610FC;
        Mon,  4 Oct 2021 15:06:02 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mXPXU-00EfKP-Is; Mon, 04 Oct 2021 16:06:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqdomain: Export __irq_domain_alloc_irqs() to modules
Date:   Mon,  4 Oct 2021 16:05:52 +0100
Message-Id: <20211004150552.3844830-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Apple PCIe controller driver allocates interrupts generated
by the PCIe ports, and uses irq_domain_alloc_irqs() for that.
THis is an inline function that uses __irq_domain_alloc_irqs()
as a backend.

Since the driver can be built as a module, __irq_domain_alloc_irqs()
must be exported.

Fixes: 201adeaa9d82 ("PCI: apple: Add INTx and per-port interrupt support")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---

Notes:
    Since the offending code is only in the PCI tree so far,
    it would make sense if Lorenzo could take this patch directly.

 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5a698c1f6cc6..40e85a46f913 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1502,6 +1502,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 	irq_free_descs(virq, nr_irqs);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__irq_domain_alloc_irqs);
 
 /* The irq_data was moved, fix the revmap to refer to the new location */
 static void irq_domain_fix_revmap(struct irq_data *d)
-- 
2.30.2

