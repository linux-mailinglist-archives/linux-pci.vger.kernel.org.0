Return-Path: <linux-pci+bounces-31009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F732AEC96A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0185D189C405
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D973287260;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBUd/rwb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00793278741;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131829; cv=none; b=Lm9+0C52h0dSTIlyMgouzMj6xYKm4whV3P52KCk4AD7c2Z/C8EifH4n70p0bGNf6jLKPx1VNKqd8Wn//RFEWwtqMpK2NS2pb/C+G73uQGTdgdfLUUaIU2fHv7OWAfJ/ThrX8tViMWOK+wRwFiL2zVMM+36oLa6qUfWViRvBXNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131829; c=relaxed/simple;
	bh=sLHbDjMOHIJK5FmjK2GBYLynXvuhrJcJu9u/Pnuu0t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiiYQL8whEdFEjoA3XiZzFTpCs8Q5IGyTEkS2uYvIRJ3f3AOvu9oMOK3BprEogf6JQj9H7lFPNjjfvACL66FGnydUTM+myT9xLC8t1zskGx1zWOLdEKoPuNuDsdlF45ohl/AbhpNev+BEMD84bpop9tbh6o0bAm+0n51xLI8FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBUd/rwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A4BC4AF0B;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131828;
	bh=sLHbDjMOHIJK5FmjK2GBYLynXvuhrJcJu9u/Pnuu0t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBUd/rwbkcwGj5oOKCjOnDc9IgcnMsAY4+78S/j83PoJA0drmiifTAZmie46L9sve
	 TVtvum5fmrJBq2JukTpUK2Nxs2PaoE4gb4rVig4COzT4niYnlb5VUw8Nv3bCgmGWtW
	 wJFe1AkOBpGnxUYXdphSzijlgXK8AUlFoxU8QPDExqscFE7mvIjvpr5hM5jwHwi2Dj
	 FxXPi3DhI4ngIf5UQxJRAbfRFJabxae+5pCjVfUdkXdQoEFOH0VMtFYbavb2MUbBor
	 FKanDCFZDNnDdGS6yfN2zx8TecQOEKCLP1HFniAxUsHGLQQEUIIReg/Xb6px5dxMl2
	 wd4udbWxBy5Aw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNi-00AqZC-OS;
	Sat, 28 Jun 2025 18:30:26 +0100
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
Subject: [PATCH 05/12] PCI: xgene-msi: Make per-CPU interrupt setup robust
Date: Sat, 28 Jun 2025 18:29:58 +0100
Message-Id: <20250628173005.445013-6-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628173005.445013-1-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
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
 drivers/pci/controller/pci-xgene-msi.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index b05ec8b0bb93f..25cb4119bab07 100644
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
-- 
2.39.2


