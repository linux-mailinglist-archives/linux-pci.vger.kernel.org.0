Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15A47DCB9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbhLWBMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbhLWBMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:12:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC3C06175A;
        Wed, 22 Dec 2021 17:11:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E495CE1F05;
        Thu, 23 Dec 2021 01:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B32BC36AE8;
        Thu, 23 Dec 2021 01:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221911;
        bh=NIHlxx32hZquI6e6s7ce33q6+j4ig8ruxqlAWwHME8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0CiPqthI0XC+sVnpYnHPXcP0K2YhieePFjgiVH+s2E0u6hIs1HSo5MzttON2ai8S
         FfbTnK/jBmE74ntz5xYnVXaOAc0Lw082Bb6jYop7sK4TJtmP6yec8DuuM8XFiy+uFb
         YoaVgN1BmL97qrD8RQ2OJRdlMlnUqSzmkKGohRPJWUwo3QBm58UbjSPMsCpMHtWsmB
         1CTg+j9ZLJdYP9SsedjFFSeXcZ3ie50nMg5epoQsxDS4OiwaQsECaDXLbGOi7wAgm5
         zY1fuWZ3vlL9AbO6HR1xpXYeuHAoordqu/sGkWWd6IwZP9lOv1N6rXchDSCSPqacFu
         dYzqEfMr48j3A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 23/23] PCI: xilinx-cpm: Rename xilinx_cpm_pcie_port to xilinx_cpm_pcie
Date:   Wed, 22 Dec 2021 19:10:54 -0600
Message-Id: <20211223011054.1227810-24-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename struct xilinx_cpm_pcie_port to xilinx_cpm_pcie to match the
convention of <driver>_pcie. No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 44 ++++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 95426df03200..c7cd44ed4dfc 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -99,10 +99,10 @@
 #define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
 
 /**
- * struct xilinx_cpm_pcie_port - PCIe port information
+ * struct xilinx_cpm_pcie - PCIe port information
+ * @dev: Device pointer
  * @reg_base: Bridge Register Base
  * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
- * @dev: Device pointer
  * @intx_domain: Legacy IRQ domain pointer
  * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
@@ -110,10 +110,10 @@
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
  */
-struct xilinx_cpm_pcie_port {
+struct xilinx_cpm_pcie {
+	struct device			*dev;
 	void __iomem			*reg_base;
 	void __iomem			*cpm_base;
-	struct device			*dev;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*cpm_domain;
 	struct pci_config_window	*cfg;
@@ -122,24 +122,24 @@ struct xilinx_cpm_pcie_port {
 	raw_spinlock_t			lock;
 };
 
-static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
+static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
 {
 	return readl_relaxed(port->reg_base + reg);
 }
 
-static void pcie_write(struct xilinx_cpm_pcie_port *port,
+static void pcie_write(struct xilinx_cpm_pcie *port,
 		       u32 val, u32 reg)
 {
 	writel_relaxed(val, port->reg_base + reg);
 }
 
-static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
+static bool cpm_pcie_link_up(struct xilinx_cpm_pcie *port)
 {
 	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
 		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
 }
 
-static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
+static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie *port)
 {
 	unsigned long val = pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
 
@@ -153,7 +153,7 @@ static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
 
 static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
 {
-	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
+	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
@@ -167,7 +167,7 @@ static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
 
 static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
 {
-	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
+	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
@@ -211,7 +211,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 
 static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
 {
-	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long val;
 	int i;
@@ -229,7 +229,7 @@ static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
 
 static void xilinx_cpm_mask_event_irq(struct irq_data *d)
 {
-	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(d);
 	u32 val;
 
 	raw_spin_lock(&port->lock);
@@ -241,7 +241,7 @@ static void xilinx_cpm_mask_event_irq(struct irq_data *d)
 
 static void xilinx_cpm_unmask_event_irq(struct irq_data *d)
 {
-	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(d);
 	u32 val;
 
 	raw_spin_lock(&port->lock);
@@ -273,7 +273,7 @@ static const struct irq_domain_ops event_domain_ops = {
 
 static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 {
-	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long val;
 	int i;
@@ -327,7 +327,7 @@ static const struct {
 
 static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
 {
-	struct xilinx_cpm_pcie_port *port = dev_id;
+	struct xilinx_cpm_pcie *port = dev_id;
 	struct device *dev = port->dev;
 	struct irq_data *d;
 
@@ -350,7 +350,7 @@ static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port *port)
+static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie *port)
 {
 	if (port->intx_domain) {
 		irq_domain_remove(port->intx_domain);
@@ -369,7 +369,7 @@ static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port *port)
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
+static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -410,7 +410,7 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
 	return -ENOMEM;
 }
 
-static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
+static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -462,7 +462,7 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
  */
-static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
+static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
@@ -497,7 +497,7 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
+static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 				    struct resource *bus_range)
 {
 	struct device *dev = port->dev;
@@ -523,7 +523,7 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
 	return 0;
 }
 
-static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port)
+static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie *port)
 {
 	irq_set_chained_handler_and_data(port->intx_irq, NULL, NULL);
 	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
@@ -537,7 +537,7 @@ static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port)
  */
 static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 {
-	struct xilinx_cpm_pcie_port *port;
+	struct xilinx_cpm_pcie *port;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *bus;
-- 
2.25.1

