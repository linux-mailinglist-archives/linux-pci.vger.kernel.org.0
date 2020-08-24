Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C724FB47
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHXKYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 06:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgHXKYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:24:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171DA2074D;
        Mon, 24 Aug 2020 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264639;
        bh=qXuDFnBsvXIaArgVMjXhFFyxN3x1ZY0+hd+ygcXKUNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiPJdcFYB44QuROyS9nOXXZBvpQjEwHM5Dtb9Nl7n1WV7lutLIT4F1y/0aHHvfJC9
         GdDtt2i3lV3omjn2/uxyStueATytz/2wBAGJPW/12te8miaSPLhTOPcdVSWqaBxlgP
         +MKvGCv8uOU1O/LwEKUbY8F1om3ICj847ak9W9t4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9dt-006BQc-H7; Mon, 24 Aug 2020 11:23:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 9/9] irqchip/gic-v2, v3: Prevent SW resends entirely
Date:   Mon, 24 Aug 2020 11:23:17 +0100
Message-Id: <20200824102317.1038259-10-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824102317.1038259-1-maz@kernel.org>
References: <20200824102317.1038259-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, gregory.clement@bootlin.com, jason@lakedaemon.net, laurentiu.tudor@nxp.com, tglx@linutronix.de, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

The GIC irqchips can now use a HW resend when a retrigger is invoked by
check_irq_resend(). However, should the HW resend fail, check_irq_resend()
will still attempt to trigger a SW resend, which is still a bad idea for
the GICs.

Prevent this from happening by setting IRQD_HANDLE_ENFORCE_IRQCTX on all
GIC IRQs. Technically per-cpu IRQs do not need this, as their flow handlers
never set IRQS_PENDING, but this aligns all IRQs wrt context enforcement:
this also forces all GIC IRQ handling to happen in IRQ context (as defined
by in_irq()).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-3-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 drivers/irqchip/irq-gic.c    | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b507bc7c5cda..4e9387aafed8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1279,6 +1279,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &gic_chip;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
@@ -1296,7 +1297,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 		break;
 
 	case LPI_RANGE:
@@ -1310,6 +1311,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	}
 
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e92ee2b6d7a5..b59bcef69bf3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -975,6 +975,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
 	struct gic_chip_data *gic = d->host_data;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
@@ -984,8 +985,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 	}
+
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
-- 
2.27.0

