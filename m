Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C231D7EA2
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgERQfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:35:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:16277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgERQfb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:35:31 -0400
IronPort-SDR: qkjEDVsDQrUJ0uxT2KDBh/P5PVlG2s9xumjObA75rt1TF5Vy/FOHEcOFEC5NlmL5V/NoKDYUe2
 XnycEb2e0TJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:31 -0700
IronPort-SDR: 3lAMrXfvg6iBCKfRCHhNzz8jLK1E8btCKvRFX1DaNHANuHANWi+pXBjd10gP5ScnCCQLliCBKG
 /5xpovKo1ZyQ==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="264014300"
Received: from kharjox-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.180.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:30 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH V2 3/3] PCI: Add helpers to enable/disable CXL.mem and CXL.cache
Date:   Mon, 18 May 2020 09:35:23 -0700
Message-Id: <20200518163523.1225643-4-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
References: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
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
 drivers/pci/cxl.c | 93 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h |  8 ++++
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 4437ca69ad33..0d0a1b82ea98 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -24,6 +24,88 @@
 #define PCI_CXL_HDM_COUNT(reg)		(((reg) & (3 << 4)) >> 4)
 #define PCI_CXL_VIRAL			BIT(14)
 
+#define PCI_CXL_CONFIG_LOCK		BIT(0)
+
+static void pci_cxl_unlock(struct pci_dev *dev)
+{
+	int pos = dev->cxl_cap;
+	u16 lock;
+
+	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
+	lock &= ~PCI_CXL_CONFIG_LOCK;
+	pci_write_config_word(dev, pos + PCI_CXL_LOCK, lock);
+}
+
+static void pci_cxl_lock(struct pci_dev *dev)
+{
+	int pos = dev->cxl_cap;
+	u16 lock;
+
+	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
+	lock |= PCI_CXL_CONFIG_LOCK;
+	pci_write_config_word(dev, pos + PCI_CXL_LOCK, lock);
+}
+
+static int pci_cxl_enable_disable_feature(struct pci_dev *dev, int enable,
+					  u16 feature)
+{
+	int pos = dev->cxl_cap;
+	int ret;
+	u16 reg;
+
+	if (!dev->cxl_cap)
+		return -EINVAL;
+
+	/* Only for PCIe */
+	if (!pci_is_pcie(dev))
+		return -EINVAL;
+
+	/* Only for Device 0 Function 0, Root Complex Integrated Endpoints */
+	if (dev->devfn != 0 || (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END))
+		return -EINVAL;
+
+	pci_cxl_unlock(dev);
+	ret = pci_read_config_word(dev, pos + PCI_CXL_CTRL, &reg);
+	if (ret)
+		goto lock;
+
+	if (enable)
+		reg |= feature;
+	else
+		reg &= ~feature;
+
+	ret = pci_write_config_word(dev, pos + PCI_CXL_CTRL, reg);
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
@@ -73,11 +155,6 @@ void pci_cxl_init(struct pci_dev *dev)
 	dev->cxl_cap = pos;
 
 	pci_read_config_word(dev, pos + PCI_CXL_CAP, &cap);
-	pci_read_config_word(dev, pos + PCI_CXL_CTRL, &ctrl);
-	pci_read_config_word(dev, pos + PCI_CXL_STS, &status);
-	pci_read_config_word(dev, pos + PCI_CXL_CTRL2, &ctrl2);
-	pci_read_config_word(dev, pos + PCI_CXL_STS2, &status2);
-	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
 
 	pci_info(dev, "CXL: Cache%c IO%c Mem%c Viral%c HDMCount %d\n",
 		FLAG(cap, PCI_CXL_CACHE),
@@ -86,6 +163,12 @@ void pci_cxl_init(struct pci_dev *dev)
 		FLAG(cap, PCI_CXL_VIRAL),
 		PCI_CXL_HDM_COUNT(cap));
 
+	pci_read_config_word(dev, pos + PCI_CXL_CTRL, &ctrl);
+	pci_read_config_word(dev, pos + PCI_CXL_STS, &status);
+	pci_read_config_word(dev, pos + PCI_CXL_CTRL2, &ctrl2);
+	pci_read_config_word(dev, pos + PCI_CXL_STS2, &status2);
+	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
+
 	pci_info(dev, "CXL: cap ctrl status ctrl2 status2 lock\n");
 	pci_info(dev, "CXL: %04x %04x %04x %04x %04x %04x\n",
 		 cap, ctrl, status, ctrl2, status2, lock);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d9905e2dee95..6336e16565ac 100644
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
+static inline int pci_cxl_mem_enable(struct pci_dev *dev) {}
+static inline void pci_cxl_mem_disable(struct pci_dev *dev) {}
+static inline int pci_cxl_cache_enable(struct pci_dev *dev) {}
+static inline void pci_cxl_cache_disable(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_PRI
-- 
2.26.2

