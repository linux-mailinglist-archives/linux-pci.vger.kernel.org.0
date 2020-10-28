Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B829E1D0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 03:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgJ1VnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:43:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34756 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ1Vml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:42:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id z23so1149207oic.1;
        Wed, 28 Oct 2020 14:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0T8M9HFPja/Qcz5+OFxDy+3Ox865wq64TJqX0lZtiY=;
        b=br26vZuT3zyqgPHw3wuWzevdniunBK+Fyf/fTksS+GCXareUxSdItYAJA231VK6wLd
         UsyZ3KGU7Dv//xnFmRtPEzDtHJPh0h1qf2s15PoM/dG1354LCbmr4Q7OlkH+WDKtGlvK
         8wdKGZ03PgY4W0lUbjxispdRgUoiWMXSSolSx5zhxQaQoyNMsUCQC/Nzca7G0TXRcyt7
         fZ7Xl1sKm+YXL3QVN5uKGKYwpXolyBDrWpdXAP1ab5ub5AIxWgWfgOeq1hnT4/uBuA4y
         vcML6h0UdBGw1KprHsWh5JxuWV7SMwn2wJ5pjV/WnM/TvHN7ckBkM/HVHkFZA4BpFN9D
         Nz3g==
X-Gm-Message-State: AOAM531EaeGPdmeRH1N/udanHU+LFl8s1uDDmD7CVeo5rK/S/jYxK7VF
        JUVO9rJW6kw4NfLGSupUEvwVty59Hw==
X-Google-Smtp-Source: ABdhPJzzLIwVb0GnrgftuCJ9zcN8udQxeppgVsd6r2Be66BDmlGrxb8/wZxghvtZTyC09OZtmCreNQ==
X-Received: by 2002:aca:47cc:: with SMTP id u195mr630676oia.83.1603918024915;
        Wed, 28 Oct 2020 13:47:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:47:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 06/13] PCI: dwc/dra7xx: Use the common MSI irq_chip
Date:   Wed, 28 Oct 2020 15:46:39 -0500
Message-Id: <20201028204646.356535-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

