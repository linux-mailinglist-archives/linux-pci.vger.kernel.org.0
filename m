Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C19C68C7FE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBFUu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:58 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426261F917;
        Mon,  6 Feb 2023 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716655; x=1707252655;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dHwcCEIBHwYLkC6sY/0WBKRXyhrXJ9a0pJB/q9IXXU0=;
  b=jEPKvdnoule+NB+I61CvRB2gbtmpTFkpBFNNeY/88YvYjPfNYdsOSWBl
   fYo8d0opUiiz23P9138Y7MQPNlaVLMDT3MJas19z0vl5Nqd5f4RkfCCvq
   0mZeV5f5GZ6zg8AF96lScN7dTnMngRzbRs/3AU0cDgNeIsur3Yo1VFc7C
   KDiTrQWkPoQRtAStbkV1gq/2M+13XqjmHdPaGgeQLXAF8uNonHz9FjL6w
   jzOL8K7MCeJcebzoiPUSX+u6AaX+99easWA/TYJ0MZyz6ZF2ZCljF05Uz
   VB+vWXxXvIRrG6pIBGEhn1nf+3QV7wrYaFgfkUwqyHEyyk3+JWdpvJx4E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391708411"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391708411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840492964"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840492964"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:54 -0800
Subject: [PATCH 10/18] PCI: Export pcie_get_speed() using the code from sysfs
 PCI link speed show function
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:52 -0700
Message-ID: <167571665075.587790.11513782507200128278.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the logic in current_link_speed_show() to a common function and export
that functiuon as pcie_get_speed() to allow other drivers to to retrieve
the current negotiated link speed.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pci-sysfs.c |   12 ++----------
 drivers/pci/pci.c       |   20 ++++++++++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd0d9d9bc509..0217bb5ca8fa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -205,17 +205,9 @@ static ssize_t current_link_speed_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 linkstat;
-	int err;
-	enum pci_bus_speed speed;
-
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
-	if (err)
-		return -EINVAL;
 
-	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
-
-	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "%s\n",
+			  pci_speed_string(pcie_get_speed(pci_dev)));
 }
 static DEVICE_ATTR_RO(current_link_speed);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..d0131b5623b1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6215,6 +6215,26 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_get_width_cap);
 
+/**
+ * pcie_get_speed - query for the PCI device's current link speed
+ * @dev: PCI device to query
+ *
+ * Query the PCI device current link speed.
+ */
+enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
+{
+	u16 linkstat, cls;
+	int err;
+
+	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
+	if (err)
+		return PCI_SPEED_UNKNOWN;
+
+	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, linkstat);
+	return pcie_link_speed[cls];
+}
+EXPORT_SYMBOL(pcie_get_speed);
+
 /**
  * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
  * @dev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65e84b4..6a065986ff8f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -303,6 +303,7 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+enum pci_bus_speed pcie_get_speed(struct pci_dev *dev);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 


