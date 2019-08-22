Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1396498E73
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfHVIz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 04:55:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:18188 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfHVIz6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 04:55:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 01:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,416,1559545200"; 
   d="scan'208";a="169698837"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2019 01:55:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A0B63FC; Thu, 22 Aug 2019 11:55:53 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stefan.maetje@esd.eu, Patrick Talbert <ptalbert@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Robert White <rwhite@pobox.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Make pcie_downstream_port() available outside of access.c
Date:   Thu, 22 Aug 2019 11:55:52 +0300
Message-Id: <20190822085553.62697-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This helper function is useful in other places where code needs to
determine whether the PCIe port is downstream so make it available
outside of access.c.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/access.c | 9 ---------
 drivers/pci/pci.h    | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 544922f097c0..2fccb5762c76 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -336,15 +336,6 @@ static inline int pcie_cap_version(const struct pci_dev *dev)
 	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
 }
 
-static bool pcie_downstream_port(const struct pci_dev *dev)
-{
-	int type = pci_pcie_type(dev);
-
-	return type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_DOWNSTREAM ||
-	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
-}
-
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a83fcf612ca..ae8d839dca4f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -118,6 +118,15 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
 }
 
+static inline bool pcie_downstream_port(const struct pci_dev *dev)
+{
+	int type = pci_pcie_type(dev);
+
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
+	       type == PCI_EXP_TYPE_DOWNSTREAM ||
+	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
+}
+
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
 void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
-- 
2.23.0.rc1

