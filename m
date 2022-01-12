Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842A848C6F8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354511AbiALPSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35286 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbiALPSi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96DA4B81ECD;
        Wed, 12 Jan 2022 15:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0753C36AEB;
        Wed, 12 Jan 2022 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000715;
        bh=7cnGPeKxrEx9BUioQPhHb7keGl7Sglo0nNvBLgQcPKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2B9c0j3t2GP6DyC5C0g+MmdHgP91o+KH/DbQo8UVAsuOeFruVKwjV6NV3S5rx+TC
         wt6rpoNABQrmVMkRPWVecBtpVZ68GJ59M+4xF/JuRZGCL0mpNnZIfulCochdXSwfw5
         YjWJXQDd079mhrEW00M2MerQKCv9IfBYIS2R7Npsu/yl2VNLFYWvUfWLdDx5vsi8EB
         W6WA1hiKfPR2/3sLxFOEQH+z+4VPiyv6tJwQjEuXoVWijojNmZ4Ok96SrS9JnRzXJH
         pNDRI10umSWWaSW1YuCvYUwI/T+lKeOzxWnfbOrCGTeMD/MX5p6SKttOlZfD3PcedC
         NPvzZZ9o9D15A==
Received: by pali.im (Postfix)
        id A3EF7768; Wed, 12 Jan 2022 16:18:34 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/11] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
Date:   Wed, 12 Jan 2022 16:18:06 +0100
Message-Id: <20220112151814.24361-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is read-only capability in PCI config space. Put it between base PCI
capability and base PCI Express capability.

Driver just have to specify subsystem_vendor_id and subsystem_id fields in
emulated bridge structure and pci-bridge-emul takes care of correctly
compose PCI Bridge Subsystem Vendor ID capability.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 69 +++++++++++++++++++++++++----------
 drivers/pci/pci-bridge-emul.h |  2 +
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 9f4f173f0650..c84f423a5893 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -21,8 +21,11 @@
 #include "pci-bridge-emul.h"
 
 #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
+#define PCI_CAP_SSID_SIZEOF	(PCI_SSVID_DEVICE_ID + 2)
+#define PCI_CAP_SSID_START	PCI_BRIDGE_CONF_END
+#define PCI_CAP_SSID_END	(PCI_CAP_SSID_START + PCI_CAP_SSID_SIZEOF)
 #define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
-#define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
+#define PCI_CAP_PCIE_START	PCI_CAP_SSID_END
 #define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
 
 /**
@@ -315,6 +318,25 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 	},
 };
 
+static pci_bridge_emul_read_status_t
+pci_bridge_emul_read_ssid(struct pci_bridge_emul *bridge, int reg, u32 *value)
+{
+	switch (reg) {
+	case PCI_CAP_LIST_ID:
+		*value = PCI_CAP_ID_SSVID |
+			(bridge->has_pcie ? (PCI_CAP_PCIE_START << 8) : 0);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	case PCI_SSVID_VENDOR_ID:
+		*value = bridge->subsystem_vendor_id |
+			(bridge->subsystem_id << 16);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+}
+
 /*
  * Initialize a pci_bridge_emul structure to represent a fake PCI
  * bridge configuration space. The caller needs to have initialized
@@ -337,9 +359,17 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 	if (!bridge->pci_regs_behavior)
 		return -ENOMEM;
 
-	if (bridge->has_pcie) {
+	if (bridge->subsystem_vendor_id)
+		bridge->conf.capabilities_pointer = PCI_CAP_SSID_START;
+	else if (bridge->has_pcie)
 		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
+	else
+		bridge->conf.capabilities_pointer = 0;
+
+	if (bridge->conf.capabilities_pointer)
 		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
+
+	if (bridge->has_pcie) {
 		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
 		bridge->pcie_conf.cap |= cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4);
 		bridge->pcie_cap_regs_behavior =
@@ -423,26 +453,28 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 		read_op = bridge->ops->read_base;
 		cfgspace = (__le32 *) &bridge->conf;
 		behavior = bridge->pci_regs_behavior;
-	} else if (!bridge->has_pcie) {
-		/* PCIe space is not implemented, and no PCI capabilities */
-		*value = 0;
-		return PCIBIOS_SUCCESSFUL;
-	} else if (reg < PCI_CAP_PCIE_END) {
+	} else if (reg >= PCI_CAP_SSID_START && reg < PCI_CAP_SSID_END && bridge->subsystem_vendor_id) {
+		/* Emulated PCI Bridge Subsystem Vendor ID capability */
+		reg -= PCI_CAP_SSID_START;
+		read_op = pci_bridge_emul_read_ssid;
+		cfgspace = NULL;
+		behavior = NULL;
+	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
 		/* Our emulated PCIe capability */
 		reg -= PCI_CAP_PCIE_START;
 		read_op = bridge->ops->read_pcie;
 		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
-	} else if (reg < PCI_CFG_SPACE_SIZE) {
-		/* Rest of PCI space not implemented */
-		*value = 0;
-		return PCIBIOS_SUCCESSFUL;
-	} else {
+	} else if (reg >= PCI_CFG_SPACE_SIZE && bridge->has_pcie) {
 		/* PCIe extended capability space */
 		reg -= PCI_CFG_SPACE_SIZE;
 		read_op = bridge->ops->read_ext;
 		cfgspace = NULL;
 		behavior = NULL;
+	} else {
+		/* Not implemented */
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
 	}
 
 	if (read_op)
@@ -500,24 +532,21 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 		write_op = bridge->ops->write_base;
 		cfgspace = (__le32 *) &bridge->conf;
 		behavior = bridge->pci_regs_behavior;
-	} else if (!bridge->has_pcie) {
-		/* PCIe space is not implemented, and no PCI capabilities */
-		return PCIBIOS_SUCCESSFUL;
-	} else if (reg < PCI_CAP_PCIE_END) {
+	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
 		/* Our emulated PCIe capability */
 		reg -= PCI_CAP_PCIE_START;
 		write_op = bridge->ops->write_pcie;
 		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
-	} else if (reg < PCI_CFG_SPACE_SIZE) {
-		/* Rest of PCI space not implemented */
-		return PCIBIOS_SUCCESSFUL;
-	} else {
+	} else if (reg >= PCI_CFG_SPACE_SIZE && bridge->has_pcie) {
 		/* PCIe extended capability space */
 		reg -= PCI_CFG_SPACE_SIZE;
 		write_op = bridge->ops->write_ext;
 		cfgspace = NULL;
 		behavior = NULL;
+	} else {
+		/* Not implemented */
+		return PCIBIOS_SUCCESSFUL;
 	}
 
 	shift = (where & 0x3) * 8;
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 6b5f75b2ad02..71392b67471d 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -132,6 +132,8 @@ struct pci_bridge_emul {
 	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
 	void *data;
 	bool has_pcie;
+	u16 subsystem_vendor_id;
+	u16 subsystem_id;
 };
 
 enum {
-- 
2.20.1

