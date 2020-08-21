Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF824D509
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHUMcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 08:32:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHUMci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:32:38 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k96Da-0000Fx-UJ; Fri, 21 Aug 2020 12:32:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     jonathan.derrick@intel.com, Mario.Limonciello@dell.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Date:   Fri, 21 Aug 2020 20:32:20 +0800
Message-Id: <20200821123222.32093-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

New Intel laptops with VMD cannot reach deeper power saving state,
renders very short battery time.

As BIOS may not be able to program the config space for devices under
VMD domain, ASPM needs to be programmed manually by software. This is
also the case under Windows.

The VMD controller itself is a root complex integrated endpoint that
doesn't have ASPM capability, so we can't propagate the ASPM settings to
devices under it. Hence, simply apply ASPM_STATE_ALL to the links under
VMD domain, unsupported states will be cleared out anyway.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c |  3 ++-
 drivers/pci/quirks.c    | 11 +++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..dcc002dbca19 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -624,7 +624,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		aspm_calc_l1ss_info(link, &upreg, &dwreg);
 
 	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
+	link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
+			     ASPM_STATE_ALL : link->aspm_enabled;
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bdf9b52567e0..2e2f525bd892 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5632,3 +5632,14 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * Device [8086:9a09]
+ * BIOS may not be able to access config space of devices under VMD domain, so
+ * it relies on software to enable ASPM for links under VMD.
+ */
+static void pci_fixup_enable_aspm(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_ENABLE_ASPM;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a09, pci_fixup_enable_aspm);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..66a45916c7c6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -227,6 +227,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Enable ASPM regardless of how LnkCtl is programmed */
+	PCI_DEV_FLAGS_ENABLE_ASPM = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.17.1

