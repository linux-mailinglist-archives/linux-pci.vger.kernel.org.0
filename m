Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8748847DCAB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbhLWBLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57894 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbhLWBLk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F23C3CE1F05;
        Thu, 23 Dec 2021 01:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A1C36AED;
        Thu, 23 Dec 2021 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221897;
        bh=0QYOsHS5wj8XlJwNRMAGvRqv6+NUOG9O0hN3WUXDp44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6OSkDDvAFIANsXOdvzGFs8IpZScUztP7K7pwQlGe2BZ8KSI+LKIWBQRVnwmfFBiW
         gOqd0n32/EFKsepqNKAH6SAl2rkxrJIr45yUmb8Sy+lrg1uhvKujTD5ZdvIkStL/G/
         8F3wyDQnuhlrIKF9FbMj0LjKMYLCB/WaJPeyAPiopoVtboAZMhhGrvOIA1TmCsx1kP
         xBW8SSHMD4wyOwNVS2gUhj417U/JSpkPVJumEsVRKu+2fgZ18RZ2oRA5At1R0qJa8N
         t+kmEkG+KZVFKO6eJqhotVWLyQmuDPb+sxXNIBDRna8N796xuvMLNNbw7BYo/FqHMY
         Mkekpg0L6pjTw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 15/23] PCI: microchip: Rename mc_port to mc_pcie
Date:   Wed, 22 Dec 2021 19:10:46 -0600
Message-Id: <20211223011054.1227810-16-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename struct mc_port to mc_pcie to match the convention of <driver>_pcie.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 42 ++++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 329f930d17aa..29d8e81e4181 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -262,7 +262,7 @@ struct mc_msi {
 	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
 };
 
-struct mc_port {
+struct mc_pcie {
 	void __iomem *axi_base_addr;
 	struct device *dev;
 	struct irq_domain *intx_domain;
@@ -382,7 +382,7 @@ static struct {
 
 static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
 
-static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
+static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
 {
 	struct mc_msi *msi = &port->msi;
 	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
@@ -405,7 +405,7 @@ static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
 
 static void mc_handle_msi(struct irq_desc *desc)
 {
-	struct mc_port *port = irq_desc_get_handler_data(desc);
+	struct mc_pcie *port = irq_desc_get_handler_data(desc);
 	struct device *dev = port->dev;
 	struct mc_msi *msi = &port->msi;
 	void __iomem *bridge_base_addr =
@@ -428,7 +428,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	u32 bitpos = data->hwirq;
@@ -443,7 +443,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 
 static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
 
 	msg->address_lo = lower_32_bits(addr);
@@ -470,7 +470,7 @@ static struct irq_chip mc_msi_bottom_irq_chip = {
 static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	struct mc_port *port = domain->host_data;
+	struct mc_pcie *port = domain->host_data;
 	struct mc_msi *msi = &port->msi;
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -503,7 +503,7 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct mc_port *port = irq_data_get_irq_chip_data(d);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(d);
 	struct mc_msi *msi = &port->msi;
 
 	mutex_lock(&msi->lock);
@@ -534,7 +534,7 @@ static struct msi_domain_info mc_msi_domain_info = {
 	.chip = &mc_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct mc_port *port)
+static int mc_allocate_msi_domains(struct mc_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
@@ -562,7 +562,7 @@ static int mc_allocate_msi_domains(struct mc_port *port)
 
 static void mc_handle_intx(struct irq_desc *desc)
 {
-	struct mc_port *port = irq_desc_get_handler_data(desc);
+	struct mc_pcie *port = irq_desc_get_handler_data(desc);
 	struct device *dev = port->dev;
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -585,7 +585,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 
 static void mc_ack_intx_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
@@ -595,7 +595,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 
 static void mc_mask_intx_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	unsigned long flags;
@@ -611,7 +611,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 
 static void mc_unmask_intx_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	unsigned long flags;
@@ -698,7 +698,7 @@ static u32 local_events(void __iomem *addr)
 	return val;
 }
 
-static u32 get_events(struct mc_port *port)
+static u32 get_events(struct mc_pcie *port)
 {
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -715,7 +715,7 @@ static u32 get_events(struct mc_port *port)
 
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
-	struct mc_port *port = dev_id;
+	struct mc_pcie *port = dev_id;
 	struct device *dev = port->dev;
 	struct irq_data *data;
 
@@ -731,7 +731,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 
 static void mc_handle_event(struct irq_desc *desc)
 {
-	struct mc_port *port = irq_desc_get_handler_data(desc);
+	struct mc_pcie *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
 	u32 bit;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -748,7 +748,7 @@ static void mc_handle_event(struct irq_desc *desc)
 
 static void mc_ack_event_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
@@ -763,7 +763,7 @@ static void mc_ack_event_irq(struct irq_data *data)
 
 static void mc_mask_event_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
@@ -793,7 +793,7 @@ static void mc_mask_event_irq(struct irq_data *data)
 
 static void mc_unmask_event_irq(struct irq_data *data)
 {
-	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
@@ -881,7 +881,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct mc_port *port)
+static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -957,7 +957,7 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 }
 
 static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct mc_port *port)
+				 struct mc_pcie *port)
 {
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -983,7 +983,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct mc_port *port;
+	struct mc_pcie *port;
 	void __iomem *bridge_base_addr;
 	void __iomem *ctrl_base_addr;
 	int ret;
-- 
2.25.1

