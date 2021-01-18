Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514F2FAB00
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbhARKok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 05:44:40 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:49828 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388873AbhARJc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 04:32:26 -0500
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0FA1FEFDEF;
        Mon, 18 Jan 2021 17:17:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13518T140326291363584S1610961461018109_;
        Mon, 18 Jan 2021 17:17:44 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4fd38a682f9815058e1bb69cc85248e2>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: bhelgaas@google.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Simon Xue <xxm@rock-chips.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 1/3] PCI: dwc: Skip allocating own MSI domain if using external MSI domain
Date:   Mon, 18 Jan 2021 17:17:37 +0800
Message-Id: <20210118091739.247040-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

On some platform, external MSI domain is using instead of the one
created by designware driver. For instance, if using GIC-V3-ITS
as a MSI domain, we only need set msi-map in the devicetree but
never need any bit in the designware driver to handle MSI stuff.
So skip allocating its own MSI domain for that case.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8a84c005f32b..d9d93cab970a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -235,6 +235,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
 
+	/* Rely on the external MSI domain */
+	if (pp->msi_ext)
+		return 0;
+
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
@@ -258,6 +262,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 static void dw_pcie_free_msi(struct pcie_port *pp)
 {
+	if (pp->msi_ext)
+		return;
+
 	if (pp->msi_irq) {
 		irq_set_chained_handler(pp->msi_irq, NULL);
 		irq_set_handler_data(pp->msi_irq, NULL);
@@ -359,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pci->link_gen < 1)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
-	if (pci_msi_enabled()) {
+	if (pci_msi_enabled() &&
+	    !pp->msi_ext) {
 		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
 				     of_property_read_bool(np, "msi-parent") ||
 				     of_property_read_bool(np, "msi-map"));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0207840756c4..cf3b0664302a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -195,6 +195,7 @@ struct pcie_port {
 	u32			irq_mask[MAX_MSI_CTRLS];
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
+	int			msi_ext;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-- 
2.25.1



