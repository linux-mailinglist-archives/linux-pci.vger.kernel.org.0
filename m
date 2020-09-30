Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315DD27E3A3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3IZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 04:25:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgI3IZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 04:25:19 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kNXQB-0001lF-JK; Wed, 30 Sep 2020 08:25:08 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, jonathan.derrick@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] PCI/ASPM: Add helper to enable ASPM link
Date:   Wed, 30 Sep 2020 16:24:53 +0800
Message-Id: <20200930082455.25613-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platform firmware may not be able to access config space to program
ASPM. For instance, devices behind Intel VMD are not configured by the
BIOS.

So add a helper to let drivers have an option to enable ASPM.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 73 ++++++++++++++++++++++++++++++-----------
 include/linux/pci.h     |  7 ++++
 2 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..b5ac6a99e016 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1080,6 +1080,58 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
+static u32 pcie_aspm_convert_state(int state)
+{
+	u32 aspm = 0;
+
+	if (state & PCIE_LINK_STATE_L0S)
+		aspm |= ASPM_STATE_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		/* L1 PM substates require L1 */
+		aspm |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+	if (state & PCIE_LINK_STATE_L1_1)
+		aspm |= ASPM_STATE_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		aspm |= ASPM_STATE_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		aspm |= ASPM_STATE_L1_1_PCIPM;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		aspm |= ASPM_STATE_L1_2_PCIPM;
+
+	return aspm;
+}
+
+static void pci_set_link_state(struct pci_dev *pdev, bool enable, int state)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	mutex_lock(&aspm_lock);
+	if (enable)
+		link->aspm_default = pcie_aspm_convert_state(state);
+	else
+		link->aspm_disable = pcie_aspm_convert_state(state);
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	if (state & PCIE_LINK_STATE_CLKPM) {
+		link->clkpm_default = enable;
+		link->clkpm_disable = !enable;
+	}
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	mutex_unlock(&aspm_lock);
+}
+
+int pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return -EINVAL;
+
+	pci_set_link_state(pdev, true, state);
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_link_state);
+
 static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
@@ -1101,26 +1153,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 
 	if (sem)
 		down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_disable |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_disable |= ASPM_STATE_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_disable |= ASPM_STATE_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
-	pcie_config_aspm_link(link, policy_to_aspm_state(link));
-
-	if (state & PCIE_LINK_STATE_CLKPM)
-		link->clkpm_disable = 1;
-	pcie_set_clkpm(link, policy_to_clkpm_state(link));
-	mutex_unlock(&aspm_lock);
+	pci_set_link_state(pdev, false, state);
 	if (sem)
 		up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..a6a7830ec258 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1568,14 +1568,21 @@ extern bool pcie_ports_native;
 #define PCIE_LINK_STATE_L1_2		BIT(4)
 #define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)
 #define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
+#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
+					 PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
+					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
+					 PCIE_LINK_STATE_L1_2_PCIPM)
 
 #ifdef CONFIG_PCIEASPM
+int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
+static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
-- 
2.17.1

