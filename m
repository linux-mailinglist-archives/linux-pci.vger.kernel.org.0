Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE22CDE0E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgLCSwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731649AbgLCSwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/3] PCI/MSI: Move MSI/MSI-X flags updaters to msi.c
Date:   Thu,  3 Dec 2020 12:51:09 -0600
Message-Id: <20201203185110.1583077-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203185110.1583077-1-helgaas@kernel.org>
References: <20201203185110.1583077-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_msi_set_enable() and pci_msix_clear_and_set_ctrl() are only used from
msi.c, so move them from drivers/pci/pci.h to msi.c.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c | 21 +++++++++++++++++++++
 drivers/pci/pci.h | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 555791c0ee1a..3e302ca8a96f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -412,6 +412,17 @@ static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 		pci_intx(dev, enable);
 }
 
+static void pci_msi_set_enable(struct pci_dev *dev, int enable)
+{
+	u16 control;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	control &= ~PCI_MSI_FLAGS_ENABLE;
+	if (enable)
+		control |= PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+}
+
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
 	u16 control;
@@ -434,6 +445,16 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
+static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~clear;
+	ctrl |= set;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f5f303775c4..5692f11bc146 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -187,27 +187,6 @@ void pci_no_msi(void);
 static inline void pci_no_msi(void) { }
 #endif
 
-static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
-{
-	u16 control;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	control &= ~PCI_MSI_FLAGS_ENABLE;
-	if (enable)
-		control |= PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
-}
-
-static inline void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
-{
-	u16 ctrl;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	ctrl &= ~clear;
-	ctrl |= set;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
-}
-
 void pci_realloc_get_opt(char *);
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
-- 
2.25.1

