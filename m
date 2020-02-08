Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4984D1561B7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBHAAS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBHAAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:17 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545726"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:15 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 3/9] PCI: pci-bridge-emul: Provide a helper to set behavior
Date:   Fri,  7 Feb 2020 17:00:01 -0700
Message-Id: <1581120007-5280-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a handler to set behavior of a PCI or PCIe register. Add the
appropriate enums to specify the register's Read-Only, Read-Write, and
Write-1-to-Clear behaviors.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 19 +++++++++++++++++++
 drivers/pci/pci-bridge-emul.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index e0567ca..aa18091 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -44,6 +44,25 @@ struct pci_bridge_reg_behavior {
 	u32 w1c;
 };
 
+void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
+				      bool pcie, int reg, u32 val,
+				      enum pci_bridge_emul_reg_behavior type)
+{
+	struct pci_bridge_reg_behavior *behavior;
+
+	if (pcie)
+		behavior = &bridge->pcie_cap_regs_behavior[reg / 4];
+	else
+		behavior = &bridge->pci_regs_behavior[reg / 4];
+
+	if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO)
+		behavior->ro = val;
+	else if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW)
+		behavior->rw = val;
+	else /* PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C */
+		behavior->w1c = val;
+}
+
 static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
 	[PCI_COMMAND / 4] = {
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index b318830..f7027e1 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -72,6 +72,12 @@ struct pci_bridge_emul_pcie_conf {
 typedef enum { PCI_BRIDGE_EMUL_HANDLED,
 	       PCI_BRIDGE_EMUL_NOT_HANDLED } pci_bridge_emul_read_status_t;
 
+enum pci_bridge_emul_reg_behavior {
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO,
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW,
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C,
+};
+
 struct pci_bridge_emul_ops {
 	/*
 	 * Called when reading from the regular PCI bridge
@@ -132,4 +138,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 			       int size, u32 value);
 
+void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
+				      bool pcie, int reg, u32 val,
+				      enum pci_bridge_emul_reg_behavior type);
+
 #endif /* __PCI_BRIDGE_EMUL_H__ */
-- 
1.8.3.1

