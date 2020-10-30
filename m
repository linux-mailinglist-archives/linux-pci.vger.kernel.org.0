Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71712A10FF
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJ3WmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 18:42:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:13764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ3WmX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 18:42:23 -0400
IronPort-SDR: lTaDJweJI22BHyoyyfqO0xoCo5/kLzTeylSfNN2oAJVbGffeyCeVEjTn8/NolGAsKfo/INBe6T
 zWfGzfWpGbrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="166090818"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="166090818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 15:42:22 -0700
IronPort-SDR: hf2kzVU3Wp8xnqEiQ8yZvBZjuBmF3kCCCGoSuHZLvlm5RNmTsmx4DpsW7OvBULJU6zGy8yteIX
 aiNpnFS+qJaw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537225980"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 15:42:22 -0700
Subject: [PATCH] PCI: add helper function to find DVSEC
From:   Dave Jiang <dave.jiang@intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, david.e.box@intel.com,
        sean.v.kelly@intel.com, ashok.raj@intel.com
Date:   Fri, 30 Oct 2020 15:42:21 -0700
Message-ID: <160409768616.919324.13994867117217584719.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add function that searches for DVSEC and returns the offset in PCI
configuration space for the interested DVSEC capability.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---

The patch has dependency on David Box’s dvsec definition patch:
https://lore.kernel.org/linux-pci/bc5f059c5bae957daebde699945c80808286bf45.camel@linux.intel.com/T/#m1d0dc12e3b2c739e2c37106a45f325bb8f001774

 drivers/pci/pci.c   |   30 ++++++++++++++++++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2f923d..49e57b831509 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -589,6 +589,36 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
+/**
+ * pci_find_dvsec - return position of DVSEC with provided vendor and DVSEC ID
+ * @dev: the PCI device
+ * @vendor: vendor for the DVSEC
+ * @id: the DVSEC capibility ID
+ *
+ * Return the offset of DVSEC on success or -ENOTSUPP if not found
+ */
+int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
+{
+	u16 dev_vendor, dev_id;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return -ENOTSUPP;
+
+	while (pos) {
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &dev_vendor);
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &dev_id);
+		if (dev_vendor == vendor && dev_id == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(pci_find_dvsec);
+
 /**
  * pci_get_dsn - Read and return the 8-byte Device Serial Number
  * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..6c692d32c82a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1069,6 +1069,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
+int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 u64 pci_get_dsn(struct pci_dev *dev);
@@ -1726,6 +1727,8 @@ static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
 { return 0; }
 static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
 { return 0; }
+static inline int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
+{ return 0; }
 
 static inline u64 pci_get_dsn(struct pci_dev *dev)
 { return 0; }


