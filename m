Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1D2A889D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgKEVML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42476 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id h62so2766944oth.9;
        Thu, 05 Nov 2020 13:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0T8M9HFPja/Qcz5+OFxDy+3Ox865wq64TJqX0lZtiY=;
        b=F7YlrhPPxlL5WCCv0QPOnLO/em6Hcj8vWG1huUJOoS1YhIwjPZYr+TKuPlXsAeBQMd
         VbzPYZCqVRuION5zb7+oSrZUKOjroQpsfTBE27KaBrCGPYOW+oDz/ZNG4LXwwwoxvUxK
         fITBBXR1FwqevgvyvvTf89lEIF7km1AidwI26tUBiAbXdAcDYZqOYc9bRS2emnzfHEtf
         bJJWyrodS21DYgcQfyQBFmM/Nyot+DnCZSiFLopOKXicpwlnkzPfejJmAbd+3IOr7kKJ
         KLji74BeKtf0aK/CEdp4G3YMZ03w8q7KEuxRAvyI4WwjLeXDFxd+qEQXyr1DUI/qE/WI
         TNLQ==
X-Gm-Message-State: AOAM531LQHt7UFBln09m+eRL18Xn+DaoucPP736vKqjEhC5zAwilTPuH
        jR6Lt5lHTJtpvX3BDkQ+rauLjZhIwcDa
X-Google-Smtp-Source: ABdhPJwarjWl30aVDAGce8K8v4WHCluvIN7s3dP5MLrAstD6QcD5fSGc1EK+FdHeAGtb6LE/YmxjFg==
X-Received: by 2002:a9d:2268:: with SMTP id o95mr2871887ota.10.1604610730454;
        Thu, 05 Nov 2020 13:12:10 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:09 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org
Subject: [PATCH v2 06/16] PCI: dwc/dra7xx: Use the common MSI irq_chip
Date:   Thu,  5 Nov 2020 15:11:49 -0600
Message-Id: <20201105211159.1814485-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dra7xx MSI irq_chip implementation is identical to the default DWC one.
The only difference is the interrupt handler as the MSI interrupt is muxed
with other interrupts, but that doesn't affect the irq_chip part of it.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 125 ------------------------
 1 file changed, 125 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a4aabc85dbb1..4d0c35a4aa59 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -377,133 +377,8 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 	return 0;
 }
 
-static void dra7xx_pcie_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
-{
-	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target = (u64)pp->msi_data;
-
-	msg->address_lo = lower_32_bits(msi_target);
-	msg->address_hi = upper_32_bits(msi_target);
-
-	msg->data = d->hwirq;
-
-	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
-		(int)d->hwirq, msg->address_hi, msg->address_lo);
-}
-
-static int dra7xx_pcie_msi_set_affinity(struct irq_data *d,
-					const struct cpumask *mask,
-					bool force)
-{
-	return -EINVAL;
-}
-
-static void dra7xx_pcie_bottom_mask(struct irq_data *d)
-{
-	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	pp->irq_mask[ctrl] |= BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
-			   pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-}
-
-static void dra7xx_pcie_bottom_unmask(struct irq_data *d)
-{
-	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	pp->irq_mask[ctrl] &= ~BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
-			   pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-}
-
-static void dra7xx_pcie_bottom_ack(struct irq_data *d)
-{
-	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
-}
-
-static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
-	.name = "DRA7XX-PCI-MSI",
-	.irq_ack = dra7xx_pcie_bottom_ack,
-	.irq_compose_msi_msg = dra7xx_pcie_setup_msi_msg,
-	.irq_set_affinity = dra7xx_pcie_msi_set_affinity,
-	.irq_mask = dra7xx_pcie_bottom_mask,
-	.irq_unmask = dra7xx_pcie_bottom_unmask,
-};
-
-static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	u32 ctrl, num_ctrls;
-	int ret;
-
-	pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
-
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		pp->irq_mask[ctrl] = ~0;
-		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
-				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    pp->irq_mask[ctrl]);
-		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
-				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    ~0);
-	}
-
-	ret = dw_pcie_allocate_domains(pp);
-	if (ret)
-		return ret;
-
-	pp->msi_data = dma_map_single_attrs(dev, &pp->msi_msg,
-					   sizeof(pp->msi_msg),
-					   DMA_FROM_DEVICE,
-					   DMA_ATTR_SKIP_CPU_SYNC);
-	ret = dma_mapping_error(dev, pp->msi_data);
-	if (ret) {
-		dev_err(dev, "Failed to map MSI data\n");
-		pp->msi_data = 0;
-		dw_pcie_free_msi(pp);
-	}
-	return ret;
-}
-
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
 	.host_init = dra7xx_pcie_host_init,
-	.msi_host_init = dra7xx_pcie_msi_host_init,
 };
 
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
-- 
2.25.1

