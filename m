Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C361924CBBD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHUDyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46741 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHUDyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:37 -0400
Received: by mail-io1-f68.google.com with SMTP id 4so447637ion.13;
        Thu, 20 Aug 2020 20:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlJzV8OhTh5Vvu8qiV/8YFigGDBtZq/RAwkrYqOmODA=;
        b=hIS0Kh3XEUq4TWKAAaW/C4xU33PKdVuZQHqgAF+efCStJ5UepvqG+ttgAt+o9GhCx3
         hn+D+9xbg2nlDu7ciODhUipWlrPrhX4uManzfGGhz4mxYMOvHw8gIr5khBSKg30o2p33
         03Q1oRFo6YG9FyWatoq5S522VIP8AuGBGpF672RL+9UbNbvdyclx4wWA1E3IHFfjDSaa
         1Scbif6HBnPy9NSwJI9CQKmohr346v1BTMOIjgOaLn+0bnpmSIqds/gwXEga0+yrtedG
         iLijNeoXJEgKzpBYf/nVAz/bch2eAnT2oTHkHVqry6B1czuQqmCgXGFTstnqw43VLCx7
         w8GQ==
X-Gm-Message-State: AOAM532OV44Xqj6ABaue6d+hRdZBSxx6Sy21zYMLuIeCRutXy8jr1oNo
        MCXbeM1mGQUAcmu5Z84eGA==
X-Google-Smtp-Source: ABdhPJwXcrLWaZzka2x4aHtByoCZP+D78lmfKZFdV5LjiT3MS3pCIEtfnkrqh/XALZEi1JruRCkPEw==
X-Received: by 2002:a6b:f014:: with SMTP id w20mr903984ioc.21.1597982075311;
        Thu, 20 Aug 2020 20:54:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
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
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 02/40] PCI: dwc: Use DBI accessors instead of own config accessors
Date:   Thu, 20 Aug 2020 21:53:42 -0600
Message-Id: <20200821035420.380495-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Designware DBI space contains the root bus bridge config space.
Platforms needing custom {rd,wr}_own_conf functions are also the ones
needing custom {read,write}_dbi ops functions and the access sequences
are the same.

Replace all dw_pcie_{rd,wr}_own_conf() calls with the DBI variants in
preparation to remove dw_pcie_{rd,wr}_own_conf().

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 55 +++++++------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9dafecba347f..1d98554db009 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -82,13 +82,13 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	unsigned long val;
 	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
-					(i * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &status);
+		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
+					   (i * MSI_REG_CTRL_BLOCK_SIZE));
 		if (!status)
 			continue;
 
@@ -148,6 +148,7 @@ static int dw_pci_msi_set_affinity(struct irq_data *d,
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
@@ -158,8 +159,7 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] |= BIT(bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-			    pp->irq_mask[ctrl]);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -167,6 +167,7 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 static void dw_pci_bottom_unmask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
@@ -177,8 +178,7 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] &= ~BIT(bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-			    pp->irq_mask[ctrl]);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -186,13 +186,14 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 static void dw_pci_bottom_ack(struct irq_data *d)
 {
 	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
 
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
@@ -310,10 +311,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	msi_target = (u64)pp->msi_data;
 
 	/* Program the msi_data */
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			    lower_32_bits(msi_target));
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
-			    upper_32_bits(msi_target));
+	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
+	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
@@ -327,7 +326,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
-	u32 hdr_type;
 	int ret;
 
 	raw_spin_lock_init(&pci->pp.lock);
@@ -453,21 +451,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
-	ret = dw_pcie_rd_own_conf(pp, PCI_HEADER_TYPE, 1, &hdr_type);
-	if (ret != PCIBIOS_SUCCESSFUL) {
-		dev_err(pci->dev, "Failed reading PCI_HEADER_TYPE cfg space reg (ret: 0x%x)\n",
-			ret);
-		ret = pcibios_err_to_errno(ret);
-		goto err_free_msi;
-	}
-	if (hdr_type != PCI_HEADER_TYPE_BRIDGE) {
-		dev_err(pci->dev,
-			"PCIe controller is not set to bridge type (hdr_type: 0x%x)!\n",
-			hdr_type);
-		ret = -EIO;
-		goto err_free_msi;
-	}
-
 	bridge->sysdata = pp;
 	bridge->ops = &dw_pcie_ops;
 
@@ -638,12 +621,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
 			pp->irq_mask[ctrl] = ~0;
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
+			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    4, pp->irq_mask[ctrl]);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					    pp->irq_mask[ctrl]);
+			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    4, ~0);
+					    ~0);
 		}
 	}
 
@@ -685,14 +668,14 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 						  pp->io_bus_addr, pp->io_size);
 	}
 
-	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Program correct class for RC */
-	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
-- 
2.25.1

