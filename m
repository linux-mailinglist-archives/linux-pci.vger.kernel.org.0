Return-Path: <linux-pci+bounces-31708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F71AFD564
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51578563AD1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AB2E6D16;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Ms+XLB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5B2E613E;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=IeY3fMOHsb0VmLxtFxfWJ0GV98/3n4b+3OE32JzHvsYlDLt/RfZ90K4sWD2yhyeUuQOgPpnbQvIH8OAJmpZZyt3X9uUzwD/D6jWwrAqYnAC7RIwyKNYCXHSv5yWk2QBT5vUKK5shNvNx8LhJuWhHLVvGDJNxeDc4Iv1FXRfM9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=GcwbIHtYH5IvK/ZrsZkV+WGzeAfxODsrDBcp9MXIE4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDzICw5TEV7cDeRCpPBKAOx2+axVwORRSc5zGOTjtppp19jUotG3JtcT7XkE+5QJ+O1TnLi+vSFWtwowBKi3Wk6p3KXxvelGmi/rT5orlYnte4cNHAhaACzG3yTFy3Jf3s4KL0sd78n9RbBIB7XDk2MCbi0pvmQVzJAoM8LXfSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Ms+XLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB03C4CEF5;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996051;
	bh=GcwbIHtYH5IvK/ZrsZkV+WGzeAfxODsrDBcp9MXIE4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1Ms+XLBKvaS6OLuasxkeCVmVMNaniPuw3GhOy2cJ3HVI1Rugquyb9GV4YaJ0MCZD
	 3Slu0C668w5WomxBFMOFzNjSfRWETgcuXVgCHVG2blIykmf6cK842u8ZxJoF9UWQ1I
	 mRNknRykoC5zeVFaOFjyz4AUL+eOqP8IdZ4m+C6wYsEuGX3WakAmmf43a7QYnrzt+b
	 gE9AAXRktxyXwCXf+D6oexvGl1cFXL3HBbblrEWD/Pw6tf0GcrXDJL/AxV1XaCyURg
	 52KoHQBxdOTW+i3O1KuYhF+WRZdJYt+ITtNTxqrsFe6bpmG4QcT5cgMScAaffvQaGO
	 0PrXnMGGAgN7Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCn-00Dqhw-Ix;
	Tue, 08 Jul 2025 18:34:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 05/13] PCI: xgene-msi: Make per-CPU interrupt setup robust
Date: Tue,  8 Jul 2025 18:33:56 +0100
Message-Id: <20250708173404.1278635-6-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The way the per-CPU interrupts are dealt with in the XGene MSI
driver isn't great:

- the affinity is set after the interrupt is enabled

- nothing prevents userspace from moving the interrupt around

- the affinity setting code pointlessly allocates memory

- the driver checks for conditions that cannot possibly happen

Address all of this in one go, resulting in slightly simpler setup
code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 29 ++++++--------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index b05ec8b0bb93f..5b69286689177 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -355,40 +355,26 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 {
 	struct xgene_msi *msi = &xgene_msi_ctrl;
 	struct xgene_msi_group *msi_group;
-	cpumask_var_t mask;
 	int i;
 	int err;
 
 	for (i = cpu; i < NR_HW_IRQS; i += msi->num_cpus) {
 		msi_group = &msi->msi_groups[i];
-		if (!msi_group->gic_irq)
-			continue;
-
-		irq_set_chained_handler_and_data(msi_group->gic_irq,
-			xgene_msi_isr, msi_group);
 
 		/*
 		 * Statically allocate MSI GIC IRQs to each CPU core.
 		 * With 8-core X-Gene v1, 2 MSI GIC IRQs are allocated
 		 * to each core.
 		 */
-		if (alloc_cpumask_var(&mask, GFP_KERNEL)) {
-			cpumask_clear(mask);
-			cpumask_set_cpu(cpu, mask);
-			err = irq_set_affinity(msi_group->gic_irq, mask);
-			if (err)
-				pr_err("failed to set affinity for GIC IRQ");
-			free_cpumask_var(mask);
-		} else {
-			pr_err("failed to alloc CPU mask for affinity\n");
-			err = -EINVAL;
-		}
-
+		irq_set_status_flags(msi_group->gic_irq, IRQ_NO_BALANCING);
+		err = irq_set_affinity(msi_group->gic_irq, cpumask_of(cpu));
 		if (err) {
-			irq_set_chained_handler_and_data(msi_group->gic_irq,
-							 NULL, NULL);
+			pr_err("failed to set affinity for GIC IRQ");
 			return err;
 		}
+
+		irq_set_chained_handler_and_data(msi_group->gic_irq,
+			xgene_msi_isr, msi_group);
 	}
 
 	return 0;
@@ -402,9 +388,6 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
 
 	for (i = cpu; i < NR_HW_IRQS; i += msi->num_cpus) {
 		msi_group = &msi->msi_groups[i];
-		if (!msi_group->gic_irq)
-			continue;
-
 		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
 						 NULL);
 	}
-- 
2.39.2


