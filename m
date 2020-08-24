Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60624FB53
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHXKYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 06:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgHXKXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A5B2074D;
        Mon, 24 Aug 2020 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264632;
        bh=xAjRigESCgC2LNLqnsyL+GzSgONSHYDPspre3j7tOII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J25la+3RmUfVBtUsg8713IDbUZhsr8ofbKDLNJnlTxSR58mhvmd3EF5So6WI1wrej
         Sd5KQT89KJZY19BiAp8Kt4yBJB9UY0l1YOAqmtLx8PkF06sXq9slpioZO6KgUHbloM
         /u4cZAhalpiR0G0rxIQbIiUaufsZNlNlAJ0swL0A=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9dm-006BQc-Ho; Mon, 24 Aug 2020 11:23:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 1/9] irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
Date:   Mon, 24 Aug 2020 11:23:09 +0100
Message-Id: <20200824102317.1038259-2-maz@kernel.org>
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

While digging around IRQCHIP_EOI_IF_HANDLED and irq/resend.c, it has come
to my attention that the IRQ resend situation seems a bit precarious for
the GIC(s).

When marking an IRQ with IRQS_PENDING, handle_fasteoi_irq() will bail out
and issue an irq_eoi(). Should the IRQ in question be re-enabled,
check_irq_resend() will trigger a SW resend, which will go through the flow
handler again and issue *another* irq_eoi() on the *same* IRQ
activation. This is something the GIC spec clearly describes as a bad idea:
any EOI must match a previous ACK.

Implement irq_chip.irq_retrigger() for the GIC chips by setting the GIC
pending bit of the relevant IRQ. After being called by check_irq_resend(),
this will eventually trigger a *new* interrupt which we will handle as usual.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-2-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 324f280ff606..b507bc7c5cda 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 #ifdef CONFIG_CPU_PM
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
@@ -1242,6 +1247,7 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
@@ -1258,6 +1264,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a27ba2cc1dce..e92ee2b6d7a5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -347,6 +347,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -417,6 +422,7 @@ static const struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
-- 
2.27.0

