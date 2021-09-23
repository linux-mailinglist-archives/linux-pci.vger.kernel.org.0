Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F5416461
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhIWR22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 13:28:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:47626 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242542AbhIWR22 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 13:28:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211144816"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="211144816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="704832559"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:55 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 6/9] PCI: Add pci_find_dvsec_capability to find designated VSEC
Date:   Thu, 23 Sep 2021 10:26:44 -0700
Message-Id: <20210923172647.72738-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
Extended Capability with the specified DVSEC ID.

The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
more vendor specific capabilities that aren't tied to the vendor ID of
the PCI component.

DVSEC is critical for both the Compute Express Link (CXL) driver as well
as the driver for OpenCAPI coherent accelerator (OCXL).

Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/pci/pci.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..94ac86ff28b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -732,6 +732,38 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
 
+/**
+ * pci_find_dvsec_capability - Find DVSEC for vendor
+ * @dev: PCI device to query
+ * @vendor: Vendor ID to match for the DVSEC
+ * @dvsec: Designated Vendor-specific capability ID
+ *
+ * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
+ * offset in config space; otherwise return 0.
+ */
+u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 v, id;
+
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
+		if (vendor == v && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..c93ccfa4571b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1130,6 +1130,7 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
+u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
-- 
2.33.0

