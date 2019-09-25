Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3494ABDD55
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfIYLoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 07:44:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35805 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbfIYLoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 07:44:05 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iD5iC-0004n8-1R; Wed, 25 Sep 2019 11:44:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, tiwai@suse.com
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v5 1/2] PCI: Add pci_pr3_present() helper to check Power Resource for D3hot
Date:   Wed, 25 Sep 2019 19:43:53 +0800
Message-Id: <20190925114353.25600-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925113255.25062-2-kai.heng.feng@canonical.com>
References: <20190925113255.25062-2-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_pr3_present() to check whether the platform supplies _PR3 to
tell us which power resources the device depends on when in D3hot. This
information is useful to let drivers choose different runtime suspend
behavior. A user will be add in next patch.

This is mostly the same as nouveau_pr3_present().

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v5:
- Add wording suggestion from Bjorn.
v4:
- Let caller to find its upstream port device.

 drivers/pci/pci.c   | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..d03f624d8928 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5856,6 +5856,22 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
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

