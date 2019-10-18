Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489AFDBE86
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfJRHi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 03:38:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37812 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfJRHi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 03:38:59 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iLMqb-0006HC-Ux; Fri, 18 Oct 2019 07:38:54 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, tiwai@suse.com
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v6 1/2] PCI: Add a helper to check Power Resource Requirements _PR3 existence
Date:   Fri, 18 Oct 2019 15:38:47 +0800
Message-Id: <20191018073848.14590-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A driver may want to know the existence of _PR3, to choose different
runtime suspend behavior. A user will be add in next patch.

This is mostly the same as nouveau_pr3_present().

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v6:
- Only define the function when CONFIG_ACPI is set.
v5:
- Add wording suggestion from Bjorn.
v4:
- Let caller to find its upstream port device.

 drivers/pci/pci.c   | 18 ++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..1df99d9e350e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5856,6 +5856,24 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+bool pci_pr3_present(struct pci_dev *pdev)
+{
+	struct acpi_device *adev;
+
+	if (acpi_disabled)
+		return false;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return false;
+
+	return adev->power.flags.power_resources &&
+		acpi_has_method(adev->handle, "_PR3");
+}
+EXPORT_SYMBOL_GPL(pci_pr3_present);
+#endif
+
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..1d15c5d49cdd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+bool pci_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.17.1

