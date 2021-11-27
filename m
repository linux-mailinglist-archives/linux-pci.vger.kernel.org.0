Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652BB45FF18
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355185AbhK0OTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhK0ORs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63585C0613E0
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so25242435wra.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hal5HBf331WxcFEjxYYk3KDXF8ioOIwrN0pArUimBtk=;
        b=X4DmXatczhHdWgH3HfZvs2MgXJ/PLx7qFsCWXaJN2x5IOdyNCwOggPv8nroX+G3q1x
         h57Wjq6Orj5etbk/by9kII9pop5kw8piE2XXm22ghKk1pK+PCbnztMd7o3hnPxXDGr5Q
         EBI223qFmv5IobgTSM0JJ1KD+OOmw6AS5J/hIxkTVRgPQh8Wg9TSaBdTm+jR86ean0+/
         AWMjhJz4m1NVPlQP6qm+Km10hDbi8EU0qTAs+YXB4HRXQFghfantSvSejrQsh8wnEXBg
         sB0qMnb6+yIoSqEUIOnE0CLDRKCmmH4tptk7SgGCJ6j2O+QCSBs1huJiBZ6OxOXcplxT
         JkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hal5HBf331WxcFEjxYYk3KDXF8ioOIwrN0pArUimBtk=;
        b=t+Ms+fGaGJhJ5dyVKUxBdz4d5f+MZfpwmOZx0rrjV++ETMEDYxwJIVd5SrmR6Vfs3U
         pWN5UJtFLAoKCB88JRi48kPMbmQMj78Dk6or4qYUDhSIRBJUbiv6g+EYNlf1xzPVJvoR
         NMQ4jylxIRd5fvXsfaAJ4LP7L1oVBE+kgAaUWPpUQRALCyKUAX/RMDMAs8tr5YopKjFi
         9wr7l1zln0yIVSzH4HwUFNyDADM1+lcJ2IKmWyhSUr3Ls5MAuv7/pDkHT95X0EkKReJx
         jsCGIXZYfrpZX7jZtqsr/3rQxvuM0CXkerHOtNfDs47PUajCVKptY9XwCLlTvjYhT4mm
         bJYg==
X-Gm-Message-State: AOAM532U3+H2gysRZKfGufovVUAi+Xyt2VMdVh/I+xr+DmL2ODg3yfRw
        QMJ4kNqE7oX04IPXoPwfemM=
X-Google-Smtp-Source: ABdhPJyThSz9NmWJCNhb4T5bUBuCc+wBzEa0OzJ61QwBJzoIXbBIDLEoVu6jKBdfqDeOQte9JkVXig==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr20853247wrg.433.1638022290815;
        Sat, 27 Nov 2021 06:11:30 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:30 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 03/13] PCI: tegra: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:11 +0100
Message-Id: <a0d9ed10e43ba567048809022a3ed90169138fe2.1638022049.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct tegra_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 85 +++++++++++++++---------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index cb0aa65d6934..0dce4c303db7 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -320,7 +320,7 @@ struct tegra_pcie_soc {
 };
 
 struct tegra_pcie {
-	struct device *dev;
+	struct platform_device *pdev;
 
 	void __iomem *pads;
 	void __iomem *afi;
@@ -714,7 +714,7 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 static void tegra_pcie_port_free(struct tegra_pcie_port *port)
 {
 	struct tegra_pcie *pcie = port->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	devm_iounmap(dev, port->base);
 	devm_release_mem_region(dev, port->regs.start,
@@ -777,7 +777,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 		"Peer2Peer error",
 	};
 	struct tegra_pcie *pcie = arg;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	u32 code, signature;
 
 	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
@@ -909,7 +909,7 @@ static int tegra_pcie_pll_wait(struct tegra_pcie *pcie, unsigned long timeout)
 
 static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	u32 value;
 	int err;
@@ -990,7 +990,7 @@ static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
 
 static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct device *dev = &port->pcie->pdev->dev;
 	unsigned int i;
 	int err;
 
@@ -1007,7 +1007,7 @@ static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 
 static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct device *dev = &port->pcie->pdev->dev;
 	unsigned int i;
 	int err;
 
@@ -1025,7 +1025,7 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 
 static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -1056,7 +1056,7 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 
 static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -1151,7 +1151,7 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
@@ -1172,7 +1172,7 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
@@ -1252,7 +1252,7 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 
 	pcie->pex_clk = devm_clk_get(dev, "pex");
@@ -1278,7 +1278,7 @@ static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 
 static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	pcie->pex_rst = devm_reset_control_get_exclusive(dev, "pex");
 	if (IS_ERR(pcie->pex_rst))
@@ -1297,7 +1297,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 
 static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int err;
 
 	pcie->phy = devm_phy_optional_get(dev, "pcie");
@@ -1341,7 +1341,7 @@ static struct phy *devm_of_phy_optional_get_index(struct device *dev,
 
 static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct device *dev = &port->pcie->pdev->dev;
 	struct phy *phy;
 	unsigned int i;
 	int err;
@@ -1374,7 +1374,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
 {
 	const struct tegra_pcie_soc *soc = pcie->soc;
-	struct device_node *np = pcie->dev->of_node;
+	struct device_node *np = pcie->pdev->dev.of_node;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -1393,7 +1393,7 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
 static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int err, i;
 
 	if (pcie->legacy_phy) {
@@ -1415,8 +1415,8 @@ static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
@@ -1522,7 +1522,7 @@ static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
 	err = readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
 				 val & (0x1 << ack_bit), 1, PME_ACK_TIMEOUT);
 	if (err)
-		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
+		dev_err(&pcie->pdev->dev, "PME Ack is not received on port: %d\n",
 			port->index);
 
 	usleep_range(10000, 11000);
@@ -1537,7 +1537,7 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 	struct tegra_pcie *pcie = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct tegra_msi *msi = &pcie->msi;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned int i;
 
 	chained_irq_enter(chip, desc);
@@ -1708,20 +1708,21 @@ static struct msi_domain_info tegra_msi_info = {
 static int tegra_allocate_domains(struct tegra_msi *msi)
 {
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
-	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct device *dev = &pcie->pdev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_domain *parent;
 
 	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
 					  &tegra_msi_domain_ops, msi);
 	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 
 	msi->domain = pci_msi_create_irq_domain(fwnode, &tegra_msi_info, parent);
 	if (!msi->domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
+		dev_err(dev, "failed to create MSI domain\n");
 		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
@@ -1739,9 +1740,9 @@ static void tegra_free_domains(struct tegra_msi *msi)
 
 static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct tegra_msi *msi = &pcie->msi;
-	struct device *dev = pcie->dev;
 	int err;
 
 	mutex_init(&msi->map_lock);
@@ -1819,7 +1820,7 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
 	struct tegra_msi *msi = &pcie->msi;
 	unsigned int i, irq;
 
-	dma_free_attrs(pcie->dev, PAGE_SIZE, msi->virt, msi->phys,
+	dma_free_attrs(&pcie->pdev->dev, PAGE_SIZE, msi->virt, msi->phys,
 		       DMA_ATTR_NO_KERNEL_MAPPING);
 
 	for (i = 0; i < INT_PCI_MSI_NR; i++) {
@@ -1858,7 +1859,7 @@ static void tegra_pcie_disable_interrupts(struct tegra_pcie *pcie)
 static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 				      u32 *xbar)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
 
 	if (of_device_is_compatible(np, "nvidia,tegra186-pcie")) {
@@ -1963,7 +1964,7 @@ static bool of_regulator_bulk_available(struct device_node *np,
  */
 static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
 
 	if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
@@ -2002,14 +2003,14 @@ static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
  */
 static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
 	unsigned int i = 0;
 
 	if (of_device_is_compatible(np, "nvidia,tegra186-pcie")) {
 		pcie->num_supplies = 4;
 
-		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
 					      GFP_KERNEL);
 		if (!pcie->supplies)
@@ -2022,7 +2023,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	} else if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
 		pcie->num_supplies = 3;
 
-		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
 					      GFP_KERNEL);
 		if (!pcie->supplies)
@@ -2114,7 +2115,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node, *port;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	u32 lanes = 0, mask = 0;
@@ -2245,7 +2246,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 #define TEGRA_PCIE_LINKUP_TIMEOUT	200	/* up to 1.2 seconds */
 static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct device *dev = &port->pcie->pdev->dev;
 	unsigned int retries = 3;
 	unsigned long value;
 
@@ -2292,7 +2293,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 
 static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct tegra_pcie_port *port;
 	ktime_t deadline;
 	u32 value;
@@ -2350,7 +2351,7 @@ static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
 
 static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct tegra_pcie_port *port, *tmp;
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
@@ -2634,7 +2635,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->ports);
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
@@ -2652,8 +2653,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto put_resources;
 	}
 
-	pm_runtime_enable(pcie->dev);
-	err = pm_runtime_get_sync(pcie->dev);
+	pm_runtime_enable(&pcie->pdev->dev);
+	err = pm_runtime_get_sync(&pcie->pdev->dev);
 	if (err < 0) {
 		dev_err(dev, "fail to enable pcie controller: %d\n", err);
 		goto pm_runtime_put;
@@ -2674,8 +2675,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 pm_runtime_put:
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
+	pm_runtime_put_sync(&pcie->pdev->dev);
+	pm_runtime_disable(&pcie->pdev->dev);
 	tegra_pcie_msi_teardown(pcie);
 put_resources:
 	tegra_pcie_put_resources(pcie);
@@ -2693,8 +2694,8 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
+	pm_runtime_put_sync(&pcie->pdev->dev);
+	pm_runtime_disable(&pcie->pdev->dev);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_msi_teardown(pcie);
-- 
2.25.1

