Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB768C800
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBFUvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBFUvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F12A9B9;
        Mon,  6 Feb 2023 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716664; x=1707252664;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6tkI3jQT3b1QSCpxAKZuKl9uTp2US9fbB/Zkgo7434=;
  b=aUwa4iHSI5n1Jlio8abtSdLseBuPKvNd+zoz59gmmPJbOarewhtC5fnA
   M/myhP90wh27628J31ZbzFLQmuZ8QmTk5Cr4ir8cWKKmR/mWQ6DokOzbe
   bnl3uYfKbJARgQA3LnXRPN75MFbhXRyo6RuHco4/tIkw6kFp1I+arPG+A
   dm9XN4o/AivFlMYLxHVgJTezZeRQUQOjEn5CfQUzSNNkNBoKRiSRU1dpA
   u8JnLY7o3nU7tQOb5bguHGcDtOqqAi3OVk+2VXYTGzoGXZ63ITr9Bna11
   Jx6GXwmSHbUu3eZbnnMaAbPwhLI4+BWuEthwMb8pwbxDM5KtzxVKd/Mhv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391708461"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391708461"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840493008"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840493008"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:03 -0800
Subject: [PATCH 11/18] PCI: Export pcie_get_width() using the code from sysfs
 PCI link width show function
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:01 -0700
Message-ID: <167571666013.587790.16270669112177554916.stgit@djiang5-mobl3.local>
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

Move the logic in current_link_width_show() to a common function and export
that functiuon as pcie_get_width() to allow other drivers to to retrieve
the current negotiated link width.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pci-sysfs.c |    9 +--------
 drivers/pci/pci.c       |   20 ++++++++++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0217bb5ca8fa..139096c39380 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -215,15 +215,8 @@ static ssize_t current_link_width_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 linkstat;
-	int err;
 
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
-	if (err)
-		return -EINVAL;
-
-	return sysfs_emit(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", pcie_get_width(pci_dev));
 }
 static DEVICE_ATTR_RO(current_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d0131b5623b1..0858fa2f1c2d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6235,6 +6235,26 @@ enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_get_speed);
 
+/**
+ * pcie_get_width - query for the PCI device's current link width
+ * @dev: PCI device to query
+ *
+ * Query the PCI device current negoiated width.
+ */
+
+enum pcie_link_width pcie_get_width(struct pci_dev *dev)
+{
+	u16 linkstat;
+	int err;
+
+	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
+	if (err)
+		return PCIE_LNK_WIDTH_UNKNOWN;
+
+	return FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
+}
+EXPORT_SYMBOL(pcie_get_width);
+
 /**
  * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
  * @dev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6a065986ff8f..21eca09a98e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -305,6 +305,7 @@ enum pci_bus_speed {
 
 enum pci_bus_speed pcie_get_speed(struct pci_dev *dev);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
+enum pcie_link_width pcie_get_width(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
 struct pci_vpd {


