Return-Path: <linux-pci+bounces-37643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D6BBFB3A
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECB93BF333
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6251F3BBB;
	Mon,  6 Oct 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b18nM0db"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93F21ABDC
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790354; cv=none; b=XySac9MhB4WYlssVQ9918JtDdjKaB0zJDrLSlZXEovEH24xW9Pj533difXz5dYvAwscTbmniJKZsKA6/Xygsb2zvyiyZKPaxgZEkzGU4uLFrpl/KE2jj2UEOdDXuzT4UnEXVADvrqo55yiK0x/kIIZ2lfsGU5eYZujVr0Xf9Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790354; c=relaxed/simple;
	bh=Aej4+ASsuGPeqOnCXcPK7fKl74+lrJeckUSToEzjuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEMU6y7mzJpfLiQCczRekr7JySz2lObnY5TmijpEl5Fkd5VZ8Bm6fGeDvzguHVEmGHvmpjSrhzdle+K0YMal7kRY1Vtvn5+8iLD2Z3PDnaSrIvVVe5ZazwRfSOadEsOvzkL7/jmyKPGObB9f5iPPJu5NhU0JsP2a0vvPjv41F9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b18nM0db; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759790350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/G+Kct3IYxsDjgh/+m7hqymHKvsq2adn2DPTztJb+g=;
	b=b18nM0dbZ/cEVFyGR07qJwE2VgnBuBSM+0VQEDlhPSZ0eCCeTpMlMAvF1XukAtu5IwzY0v
	juRQ5elBG2ZTtntSzOzVhcvPmjpP5AG16Ee3T5VXtZ1gAYyu38sEpqNsu+meM5pDLvfTra
	1VOS0ULvX2iw+DU/pXnVXp0KMYUYcAA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-jM5XDErLPTOeUs7sALe8Ug-1; Mon,
 06 Oct 2025 18:39:06 -0400
X-MC-Unique: jM5XDErLPTOeUs7sALe8Ug-1
X-Mimecast-MFC-AGG-ID: jM5XDErLPTOeUs7sALe8Ug_1759790345
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E419D195608E;
	Mon,  6 Oct 2025 22:39:04 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.90.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CE401800447;
	Mon,  6 Oct 2025 22:39:01 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: dwc: Code cleanup
Date: Mon,  6 Oct 2025 18:38:12 -0400
Message-ID: <20251006223813.1688637-3-rrendec@redhat.com>
In-Reply-To: <20251006223813.1688637-1-rrendec@redhat.com>
References: <20251006223813.1688637-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Thomas Gleixner <tglx@linutronix.de>

Code cleanup with no functional changes. These changes were originally
made by Thomas Gleixner (see Link tag below) in a patch that was never
submitted as is. Other parts of that patch were eventually submitted as
commit 8e717112caf3 ("PCI: dwc: Switch to msi_create_parent_irq_domain()")
and the remaining parts are the code cleanup changes in this patch.

Summary of changes:
- Use guard()/scoped_guard() instead of open-coded lock/unlock.
- Return void in a few functions whose return value is never used.
- Simplify dw_handle_msi_irq() by using for_each_set_bit().

One notable deviation from the original patch is that I reverted back to
a simple 1 by 1 iteration over the controllers inside dw_handle_msi_irq.
The reason is that with the original changes, the IRQ offset was
calculated incorrectly.

This patch also prepares the ground for the next patch in the series,
which enables MSI affinity support, and was originally part of that same
series that Thomas Gleixner prepared.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Co-developed-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 98 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  7 +-
 2 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4..69051b1d72c2e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -45,35 +45,25 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 };
 
 /* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
+void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
-	int i, pos;
-	unsigned long val;
-	u32 status, num_ctrls;
-	irqreturn_t ret = IRQ_NONE;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int i, num_ctrls;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
+		unsigned int reg_off = i * MSI_REG_CTRL_BLOCK_SIZE;
+		unsigned int irq_off = i * MAX_MSI_IRQS_PER_CTRL;
+		unsigned long status, pos;
+
+		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS + reg_off);
 		if (!status)
 			continue;
 
-		ret = IRQ_HANDLED;
-		val = status;
-		pos = 0;
-		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
-					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
-			generic_handle_domain_irq(pp->irq_domain,
-						  (i * MAX_MSI_IRQS_PER_CTRL) +
-						  pos);
-			pos++;
-		}
+		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
+			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
 	}
-
-	return ret;
 }
 
 /* Chained MSI interrupt service routine */
@@ -94,13 +84,10 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target = (u64)pp->msi_data;
+	u64 msi_target = (u64)pp->msi_data;
 
 	msg->address_lo = lower_32_bits(msi_target);
 	msg->address_hi = upper_32_bits(msi_target);
-
 	msg->data = d->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
@@ -112,18 +99,14 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	guard(raw_spinlock)(&pp->lock);
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] |= BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void dw_pci_bottom_unmask(struct irq_data *d)
@@ -131,18 +114,14 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	guard(raw_spinlock)(&pp->lock);
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] &= ~BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void dw_pci_bottom_ack(struct irq_data *d)
@@ -159,54 +138,42 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
-	.name = "DWPCI-MSI",
-	.irq_ack = dw_pci_bottom_ack,
-	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_mask = dw_pci_bottom_mask,
-	.irq_unmask = dw_pci_bottom_unmask,
+	.name			= "DWPCI-MSI",
+	.irq_ack		= dw_pci_bottom_ack,
+	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
+	.irq_mask		= dw_pci_bottom_mask,
+	.irq_unmask		= dw_pci_bottom_unmask,
 };
 
-static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs,
-				    void *args)
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs, void *args)
 {
 	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-	u32 i;
 	int bit;
 
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
-				      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	scoped_guard (raw_spinlock_irq, &pp->lock) {
+		bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
+					      order_base_2(nr_irqs));
+	}
 
 	if (bit < 0)
 		return -ENOSPC;
 
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, bit + i,
-				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
-				    NULL, NULL);
-
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, bit + i, pp->msi_irq_chip,
+				    pp, handle_edge_irq, NULL, NULL);
+	}
 	return 0;
 }
 
-static void dw_pcie_irq_domain_free(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs)
+static void dw_pcie_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
-			      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	guard(raw_spinlock_irq)(&pp->lock);
+	bitmap_release_region(pp->msi_irq_in_use, d->hwirq, order_base_2(nr_irqs));
 }
 
 static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
@@ -239,8 +206,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
 		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-							 NULL, NULL);
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
 
 	irq_domain_remove(pp->irq_domain);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd..ef212a56f60c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -802,7 +802,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
+void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
@@ -823,10 +823,7 @@ static inline int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	return 0;
 }
 
-static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
-{
-	return IRQ_NONE;
-}
+static inline void dw_handle_msi_irq(struct dw_pcie_rp *pp) { }
 
 static inline void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 { }
-- 
2.51.0


