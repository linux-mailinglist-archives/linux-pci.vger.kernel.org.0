Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A83632763
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKUPKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiKUPJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 10:09:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DBD3395;
        Mon, 21 Nov 2022 07:00:16 -0800 (PST)
Message-ID: <20221121140050.705171344@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xVC5XhbyhuC0nBwKYdli0UkkPUi3eZn9huiS4dLgbno=;
        b=vwn1NtVaeWpzWR0KY98QBhWK1aS0jtYIfpHEqHGKLVMaKSd8dCf1wXkLuu6Do7FS+xpHRr
        1bciPbQgGX83ut5KEzwdp3OkAsaHoKupl/THeC12qFTh5wWFF7gYmjMtEQMKtvJJ3T8RSY
        bQ2cs5o2HMkUcMcfsCLh0NRWvOcOxC6zFJPw2qi6HPO4P8aIEZzjT9nzt57xV+XYRtarwL
        Ur3LzSeSuoS3hzSQHWW3m8GwuXTZis6nkLGYuCOyw5u7F8lhZmgnYgFZBYLcIJ3KxKqYCD
        qeykij+aRKm4zK78AVpIE9DzuNd8H7016kLNM6UjlivMlTRtPF7hHeWngSK70Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xVC5XhbyhuC0nBwKYdli0UkkPUi3eZn9huiS4dLgbno=;
        b=JzHCyAnuDTPU5GhvQhVEJpvVEt48zMqZWiaEwdeeThy07eCD8lvkRskVRtDbI6tP15CtT3
        iAESw3oGSii/tcDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 38/40] irqchip/irq-mvebu-icu: Remove platform MSI leftovers
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:15 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All related domains provide MSI parent functionality, so the fallback code
to the original platform MSI implementation is not longer required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/irqchip/irq-mvebu-icu.c |  213 +---------------------------------------
 1 file changed, 6 insertions(+), 207 deletions(-)

--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -129,196 +129,6 @@ static void mvebu_icu_init(struct mvebu_
 	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
-/* Start of area to be removed once all parent chips provide MSI parent */
-
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
-static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	struct irq_data *d = irq_get_irq_data(desc->irq);
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
-	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
-	struct mvebu_icu *icu = icu_irqd->icu;
-	unsigned int icu_int;
-
-	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization per domain */
-		mvebu_icu_init(icu, msi_data, msg);
-		/* Configure the ICU with irq number & type */
-		icu_int = msg->data | ICU_INT_ENABLE;
-		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
-			icu_int |= ICU_IS_EDGE;
-		icu_int |= icu_irqd->icu_group << ICU_GROUP_SHIFT;
-	} else {
-		/* De-configure the ICU */
-		icu_int = 0;
-	}
-
-	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
-}
-
-static struct irq_chip mvebu_icu_nsr_chip = {
-	.name			= "ICU-NSR",
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
-static struct irq_chip mvebu_icu_sei_chip = {
-	.name			= "ICU-SEI",
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
-static int
-mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-			       unsigned long *hwirq, unsigned int *type)
-{
-	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
-	struct mvebu_icu *icu = msi_data->icu;
-
-	/* Check the count of the parameters in dt */
-	if (WARN_ON(fwspec->param_count != param_count)) {
-		dev_err(icu->dev, "wrong ICU parameter count %d\n",
-			fwspec->param_count);
-		return -EINVAL;
-	}
-
-	if (static_branch_unlikely(&legacy_bindings)) {
-		*hwirq = fwspec->param[1];
-		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-		if (fwspec->param[0] != ICU_GRP_NSR) {
-			dev_err(icu->dev, "wrong ICU group type %x\n",
-				fwspec->param[0]);
-			return -EINVAL;
-		}
-	} else {
-		*hwirq = fwspec->param[0];
-		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-
-		/*
-		 * The ICU receives level interrupts. While the NSR are also
-		 * level interrupts, SEI are edge interrupts. Force the type
-		 * here in this case. Please note that this makes the interrupt
-		 * handling unreliable.
-		 */
-		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
-			*type = IRQ_TYPE_EDGE_RISING;
-	}
-
-	if (*hwirq >= ICU_MAX_IRQS) {
-		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int
-mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			   unsigned int nr_irqs, void *args)
-{
-	int err;
-	unsigned long hwirq;
-	struct irq_fwspec *fwspec = args;
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(domain);
-	struct mvebu_icu *icu = msi_data->icu;
-	struct mvebu_icu_irq_data *icu_irqd;
-	struct irq_chip *chip = &mvebu_icu_nsr_chip;
-
-	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
-	if (!icu_irqd)
-		return -ENOMEM;
-
-	err = mvebu_icu_irq_domain_translate(domain, fwspec, &hwirq,
-					     &icu_irqd->type);
-	if (err) {
-		dev_err(icu->dev, "failed to translate ICU parameters\n");
-		goto free_irqd;
-	}
-
-	if (static_branch_unlikely(&legacy_bindings))
-		icu_irqd->icu_group = fwspec->param[0];
-	else
-		icu_irqd->icu_group = msi_data->subset_data->icu_group;
-	icu_irqd->icu = icu;
-
-	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err) {
-		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
-		goto free_irqd;
-	}
-
-	/* Make sure there is no interrupt left pending by the firmware */
-	err = irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
-	if (err)
-		goto free_msi;
-
-	if (icu_irqd->icu_group == ICU_GRP_SEI)
-		chip = &mvebu_icu_sei_chip;
-
-	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    chip, icu_irqd);
-	if (err) {
-		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
-		goto free_msi;
-	}
-
-	return 0;
-
-free_msi:
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-free_irqd:
-	kfree(icu_irqd);
-	return err;
-}
-
-static void
-mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-			  unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_get_irq_data(virq);
-	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
-
-	kfree(icu_irqd);
-
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
-
-static const struct irq_domain_ops mvebu_icu_domain_ops = {
-	.translate = mvebu_icu_irq_domain_translate,
-	.alloc     = mvebu_icu_irq_domain_alloc,
-	.free      = mvebu_icu_irq_domain_free,
-};
-
-/* End of removal area */
-
 static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
@@ -448,9 +258,10 @@ static const struct of_device_id mvebu_i
 
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	const struct msi_domain_template *tmpl;
 	struct mvebu_icu_msi_data *msi_data;
 	struct device *dev = &pdev->dev;
-	struct irq_domain *irq_domain;
+	bool sei;
 
 	msi_data = devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
@@ -471,26 +282,14 @@ static int mvebu_icu_subset_probe(struct
 	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
 
-	if (irq_domain_is_msi_parent(dev->msi.domain)) {
-		bool sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
-		const struct msi_domain_template *tmpl;
-
-		tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
-
-		if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
-						  ICU_MAX_IRQS, NULL, msi_data))
-			return -ENOMEM;
-	}
+	sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
+	tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
 
-	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
-							    mvebu_icu_write_msg,
-							    &mvebu_icu_domain_ops,
-							    msi_data);
-	if (!irq_domain) {
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+					  ICU_MAX_IRQS, NULL, msi_data)) {
 		dev_err(dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
 	}
-
 	return 0;
 }
 

