Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1923D9955
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhG1XO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 19:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhG1XO6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 19:14:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F2E60F9B;
        Wed, 28 Jul 2021 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514096;
        bh=m6s7DO/ztieozI72gxTnDwEqbJWF6hB8G1z8X+BxgGk=;
        h=From:To:Cc:Subject:Date:From;
        b=AqXPyK1BXtYVSKQNKV4dUqQtcL/2EhKuo5jEaIVngojjPCMWJDqvLFw8PShutKdFb
         1jOBde48BqirYLnEilcKMP8SsXG3ZcqjnPaHiiQWLfQ8Zw3gv47j9dexiVPYYzBdc3
         3g3NmfmrFXLpQjxpCO5YDKOWBAckr6KICc0W9yCMeKZet54YOzDUkIbPJtRGNFGlwV
         TXdlFrXF5nuOaXCHiB1+kTZFxJ5TFCpjMhjtSsmi/zJLXP3B0UZCRmDm+txZPsBDoh
         H7gALfHyrKJNVln8Mhp7mSlw+RQGKuTHWDjB3yFRbE9c0ZvMO3Qgq0/Ql2aDKM87om
         /F8z2X4O6XqVQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Make pci_cap_saved_state private to core
Date:   Wed, 28 Jul 2021 18:14:47 -0500
Message-Id: <20210728231447.869117-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

struct pci_cap_saved_data and struct pci_cap_saved_state were declared in
include/linux/pci.h, but aren't needed outside drivers/pci/.  Move them to
drivers/pci/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   | 17 +++++++++++++++--
 include/linux/pci.h | 12 ------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd431072..ab5a989e6580 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -37,6 +37,21 @@ int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
+struct pci_cap_saved_data {
+	u16		cap_nr;
+	bool		cap_extended;
+	unsigned int	size;
+	u32		data[];
+};
+
+struct pci_cap_saved_state {
+	struct hlist_node		next;
+	struct pci_cap_saved_data	cap;
+};
+
+void pci_allocate_cap_save_buffers(struct pci_dev *dev);
+void pci_free_cap_save_buffers(struct pci_dev *dev);
+
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
@@ -100,8 +115,6 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
-void pci_allocate_cap_save_buffers(struct pci_dev *dev);
-void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..2ceeb5e9f28a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -288,18 +288,6 @@ enum pci_bus_speed {
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
-struct pci_cap_saved_data {
-	u16		cap_nr;
-	bool		cap_extended;
-	unsigned int	size;
-	u32		data[];
-};
-
-struct pci_cap_saved_state {
-	struct hlist_node		next;
-	struct pci_cap_saved_data	cap;
-};
-
 struct irq_affinity;
 struct pcie_link_state;
 struct pci_vpd;
-- 
2.25.1

