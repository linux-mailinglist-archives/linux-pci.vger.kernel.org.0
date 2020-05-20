Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614491DBC4E
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETSGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:06:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:46831 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgETSGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 14:06:49 -0400
IronPort-SDR: 40H4e4sivOBPskR5/hEKzrEX/mKs4VWjbxWNj+bOXl5RJhU+Dppt3ywGtFm/FV+MlYwA+D3JHk
 HnC6V5sY4TSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:06:48 -0700
IronPort-SDR: u9gDP6FZblclJIaNTvy38fhxPFfJMkwzF6VBOKC6I6jaf45Dkik35TYjIPEz9l6IO27V5+BmnD
 kJhWRiHCVbcQ==
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="289442253"
Received: from ydandeka-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.5.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:06:47 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH V3 3/3] PCI: Add helpers to enable/disable CXL.mem and CXL.cache
Date:   Wed, 20 May 2020 11:06:40 -0700
Message-Id: <20200520180640.1911202-4-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520180640.1911202-1-sean.v.kelley@linux.intel.com>
References: <20200520180640.1911202-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With these helpers, a device driver can enable/disable access to
CXL.mem and CXL.cache. Note that the device driver is responsible for
managing the memory area.

Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 drivers/pci/cxl.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  8 +++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 4497c597347f..e58e5262b59a 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -24,6 +24,90 @@
 #define PCI_CXL_HDM_COUNT(reg)		(((reg) & (3 << 4)) >> 4)
 #define PCI_CXL_VIRAL			BIT(14)
 
+#define PCI_CXL_CONFIG_LOCK		BIT(0)
+
+static void pci_cxl_unlock(struct pci_dev *dev)
+{
+	int cxl = dev->cxl_cap;
+	u16 lock;
+
+	pci_read_config_word(dev, cxl + PCI_CXL_LOCK, &lock);
+	lock &= ~PCI_CXL_CONFIG_LOCK;
+	pci_write_config_word(dev, cxl + PCI_CXL_LOCK, lock);
+}
+
+static void pci_cxl_lock(struct pci_dev *dev)
+{
+	int cxl = dev->cxl_cap;
+	u16 lock;
+
+	pci_read_config_word(dev, cxl + PCI_CXL_LOCK, &lock);
+	lock |= PCI_CXL_CONFIG_LOCK;
+	pci_write_config_word(dev, cxl + PCI_CXL_LOCK, lock);
+}
+
+/*
+ * CXL DVSEC CTRL registers have Read-Write-Lockable attributes.
+ * PCI_CXL_CONFIG_LOCK locks these CTRL registers by making them RO.
+ * This lock prevents future changes to configuration and is not intended
+ * for enforcing mutual exclusion. See CXL 1.1, sec 7.1.1.6
+ */
+static int pci_cxl_enable_disable_feature(struct pci_dev *dev, int enable,
+					  u16 feature)
+{
+	int cxl = dev->cxl_cap;
+	int ret;
+	u16 reg;
+
+	if (!dev->cxl_cap)
+		return -EINVAL;
+
+	/* Only for Device 0 Function 0, Root Complex Integrated Endpoints */
+	if (dev->devfn != 0 || (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END))
+		return -EINVAL;
+
+	pci_cxl_unlock(dev);
+	ret = pci_read_config_word(dev, cxl + PCI_CXL_CTRL, &reg);
+	if (ret)
+		goto lock;
+
+	if (enable)
+		reg |= feature;
+	else
+		reg &= ~feature;
+
+	ret = pci_write_config_word(dev, cxl + PCI_CXL_CTRL, reg);
+
+lock:
+	pci_cxl_lock(dev);
+
+	return ret;
+}
+
+int pci_cxl_mem_enable(struct pci_dev *dev)
+{
+	return pci_cxl_enable_disable_feature(dev, true, PCI_CXL_MEM);
+}
+EXPORT_SYMBOL_GPL(pci_cxl_mem_enable);
+
+void pci_cxl_mem_disable(struct pci_dev *dev)
+{
+	pci_cxl_enable_disable_feature(dev, false, PCI_CXL_MEM);
+}
+EXPORT_SYMBOL_GPL(pci_cxl_mem_disable);
+
+int pci_cxl_cache_enable(struct pci_dev *dev)
+{
+	return pci_cxl_enable_disable_feature(dev, true, PCI_CXL_CACHE);
+}
+EXPORT_SYMBOL_GPL(pci_cxl_cache_enable);
+
+void pci_cxl_cache_disable(struct pci_dev *dev)
+{
+	pci_cxl_enable_disable_feature(dev, false, PCI_CXL_CACHE);
+}
+EXPORT_SYMBOL_GPL(pci_cxl_cache_disable);
+
 /*
  * pci_find_cxl_capability - Identify and return offset to Vendor-Specific
  * capabilities.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d9905e2dee95..5ec7fa0eb709 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -472,8 +472,16 @@ static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #ifdef CONFIG_PCI_CXL
 /* Compute eXpress Link */
 void pci_cxl_init(struct pci_dev *dev);
+int pci_cxl_mem_enable(struct pci_dev *dev);
+void pci_cxl_mem_disable(struct pci_dev *dev);
+int pci_cxl_cache_enable(struct pci_dev *dev);
+void pci_cxl_cache_disable(struct pci_dev *dev);
 #else
 static inline void pci_cxl_init(struct pci_dev *dev) { }
+static inline int pci_cxl_mem_enable(struct pci_dev *dev) { return 0; }
+static inline void pci_cxl_mem_disable(struct pci_dev *dev) { }
+static inline int pci_cxl_cache_enable(struct pci_dev *dev) { return 0; }
+static inline void pci_cxl_cache_disable(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCI_PRI
-- 
2.26.2

