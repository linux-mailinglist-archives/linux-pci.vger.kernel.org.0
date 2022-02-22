Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDED4BF66D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiBVKrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiBVKrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54351A9E04;
        Tue, 22 Feb 2022 02:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0FA8B81982;
        Tue, 22 Feb 2022 10:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282E5C340E8;
        Tue, 22 Feb 2022 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526806;
        bh=7cnGPeKxrEx9BUioQPhHb7keGl7Sglo0nNvBLgQcPKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S192IFHoXYBV6qgJVdG2Rmp68b0jJau5ytX4M3nbdz784QZrQIyh7PrZ3u7V8PoIo
         QR8LafAeo4Tg/8ALDk6o6zdNN+SWqNPZPFwFEYiOoK0z3ZF9HzIN+Z3A+vYKGytjCC
         psUIIuDeO0Ivu5iUIBKRSv6Lv+vFTTdUbahDBDbbdXhvkE9dpDknq5S4v6Iz+zQy6o
         WsTaoUMxGPmcA40pSKJSPZ7OaTeF1IJUtxEErwpZFfZR1bE8NBfgs/9Yp7+OuvfOMU
         MOqqhuSX9zlg3l2iUX8hJf8j6J7yAkkLc6CZHb5QHQWyBnx+GtUOYIMLxJTC8PaGGA
         o4B0jkA6jZZHw==
Received: by pali.im (Postfix)
        id CF61EFDB; Tue, 22 Feb 2022 11:46:45 +0100 (CET)
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
Subject: [PATCH v3 03/12] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
Date:   Tue, 22 Feb 2022 11:46:16 +0100
Message-Id: <20220222104625.28461-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222104625.28461-1-pali@kernel.org>
References: <20220222104625.28461-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

