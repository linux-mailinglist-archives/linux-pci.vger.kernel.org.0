Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5254A57A6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiBAHUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:26795 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234709AbiBAHUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700000; x=1675236000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HluE4D/VYY2W9giwxI6QJkiIMH1HD45IF+95yvI+Xww=;
  b=VG++wB8Hc/lBFXLdAB9Bx++Qh8JdD67XnsuGDa0iKvmt0MHnifwQj730
   SETTPXK+CsVHrfAwlNKFu6R7LpgKQlIPVBEYZ0i0gzdITYngT7q9qQ+Kn
   pdvWBcfUdURGxs5ZBOIWVuMkTW3HQwZvIKfwTXhnmKCEt4zeJwlMKSnFy
   tPywZryNnDtjXP17EblaNN9TpaYV7i99AjXpBuqMgBqsCpampyzfRTYXz
   bj7nvvpN1DaZe+Qc4h0rPArXH1x+4pS/tz4W2amN2MtdeNQx/sLZRAGyf
   1Xcw0Y/Oi4XACfbOWHLxwpsIxCYK/Ax8pJKDNvlT0Yrw6qSXbH6Tu4F5m
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310942245"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310942245"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000455"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 05/10] cxl/pci: Create DOE auxiliary devices
Date:   Mon, 31 Jan 2022 23:19:47 -0800
Message-Id: <20220201071952.900068-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL devices will need DOE mailbox access to read things like CDAT.

Call the PCI core helper to find all DOE mailboxes on the device and
create the auxiliary devices for those mailboxes.

sysfs shows this relationship.  Starting with a qemu system with 2
memory devices mem0 and mem1.

$ ls -l /sys/bus/cxl/devices/mem*
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem0
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem1

$ ls -l /sys/bus/auxiliary/devices/
total 0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.1
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.2 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.2
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.3 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.3

$ ls -l /sys/bus/auxiliary/drivers
total 0
drwxr-xr-x 2 root root 0 Jan 25 16:15 pci_doe.pci_doe

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V5:
	Split the CXL specific stuff off from the PCI DOE create
	auxiliary device code.
---
 drivers/cxl/Kconfig |  1 +
 drivers/cxl/pci.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index b88ab956bb7c..6088456fe0ca 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -16,6 +16,7 @@ if CXL_BUS
 config CXL_PCI
 	tristate "PCI manageability"
 	default CXL_BUS
+	select PCI_DOE_DRIVER
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
 	  PCI "memory controller" base class of devices. Device's identified by
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9252e1f4b18c..d4ae79b62a14 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -535,6 +536,14 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 	return rc;
 }
 
+static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return pci_doe_create_doe_devices(pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -603,6 +612,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_setup_doe_devices(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_dvsec_ranges(cxlds);
 	if (rc)
 		dev_err(&pdev->dev,
-- 
2.31.1

