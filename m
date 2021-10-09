Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6394427C27
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhJIQqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:46:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:56364 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhJIQqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 12:46:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="226961878"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="226961878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="715860710"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:39 -0700
Subject: [PATCH v3 08/10] PCI: Add pci_find_dvsec_capability to find
 designated VSEC
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Date:   Sat, 09 Oct 2021 09:44:39 -0700
Message-ID: <163379787943.692348.6814373487017444007.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
Extended Capability with the specified Vendor ID and Capability ID.

The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
more "vendor" specific capabilities that are not tied to the Vendor ID
of the PCI component. Where the DVSEC Vendor may be a standards body
like CXL.

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
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci.c   |   32 ++++++++++++++++++++++++++++++++
 include/linux/pci.h |    1 +
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
 

