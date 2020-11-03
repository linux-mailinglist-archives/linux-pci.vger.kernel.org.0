Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4342A4910
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKCPNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 10:13:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:34739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgKCPM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:29 -0500
IronPort-SDR: Ol+I4++jtWGzMY6BqcOux7Dnlxcq7FRO4n/uk3RljWzF9XYDUAZpds7lYKWxB7CqSK7AM+pssq
 bx91YPt+tI/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169171871"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="169171871"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 07:12:29 -0800
IronPort-SDR: fSAl7AUd+ZKdTT+5bWTVxe8bAkm2TNdC41/hgoBXt8GIzRriF7oLhkn1/qGv1e37g3z550e26l
 yWTCwHy34vDg==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="470831337"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 07:12:28 -0800
Subject: [PATCH v2] PCI: add helper function to find DVSEC
From:   Dave Jiang <dave.jiang@intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, david.e.box@intel.com,
        sean.v.kelley@intel.com, ashok.raj@intel.com, rdunlap@infradead.org
Date:   Tue, 03 Nov 2020 08:12:28 -0700
Message-ID: <160441629367.1427673.8803864097727237280.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add function that searches for DVSEC and returns the offset in PCI
configuration space for the interested DVSEC capability.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---

v2:
- Comment fixups (Randy)
- Function return 0 on fail to be consistent with other find cap functions.  (Randy)

 drivers/pci/pci.c   |   30 ++++++++++++++++++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2f923d..09208a31114a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -589,6 +589,36 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
+/**
+ * pci_find_dvsec - return position of DVSEC with provided vendor and DVSEC ID
+ * @dev: the PCI device
+ * @vendor: vendor for the DVSEC
+ * @id: the DVSEC capability ID
+ *
+ * Return: the offset of DVSEC on success or 0 if not found
+ */
+int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
+{
+	u16 dev_vendor, dev_id;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
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
+	return 0;
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


