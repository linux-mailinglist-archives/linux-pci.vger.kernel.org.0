Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1657A68C7FC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBFUur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D22B097;
        Mon,  6 Feb 2023 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716646; x=1707252646;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8IOW1adM9oC2jAAA+J+4B+32FWUmU6UHY5MmsRIO4bg=;
  b=dEfTOyVJ/0Gw2ooe/ex5AwWYrBd7xc6f5eMuTR+9sftlfWEjfjYkH7cy
   g8G7wEH49kkUUB7IUbfW0lLXjX8OsQzJJJd05UdLY2LaQ+uCU31R189Dk
   7ZA7kbSkcnVc6hB29h9OTrMP/duuwqf/1VMaeQiKJX4M4lkbHXRHxDauH
   Ve5GupE0qghcO32TlVo/E+LlzlCjr0hcaxm1v0vU5XN4XhPsGB6zoqgMd
   fPjTs6fk5XUtwqdJybS2GyAAcpsYT0EWVBbHGTLIAya975IXkJCP7jCX7
   JQdpK0ZIAnREYhQhcWlntDlPVN5ooJIpzWRLyEKx5ssiq9joi0AO23Erw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393912042"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393912042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559702"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559702"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:44 -0800
Subject: [PATCH 09/18] cxl: Add helper function to retrieve ACPI handle of CXL
 root device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:42 -0700
Message-ID: <167571664152.587790.608196538260467034.stgit@djiang5-mobl3.local>
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

Provide a helper to find the ACPI0017 device in order to issue the _DSM.
The helper will take the 'struct device' from a cxl_port and iterate until
the root device is reached. The ACPI handle will be returned from the root
device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/acpi.c |   30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
index 86dc6c9c1f24..05fcd4751619 100644
--- a/drivers/cxl/core/acpi.c
+++ b/drivers/cxl/core/acpi.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -13,6 +14,35 @@ const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
+/**
+ * cxl_acpi_get_root_acpi_handle - get the ACPI handle of the CXL root device
+ * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
+ * Looks for the ACPI0017 device and return the ACPI handle
+ **/
+acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
+{
+	struct device *itr = dev, *root_dev;
+	acpi_handle handle;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	while (itr->parent) {
+		root_dev = itr;
+		itr = itr->parent;
+	}
+
+	if (!dev_is_platform(root_dev))
+		return ERR_PTR(-ENODEV);
+
+	handle = ACPI_HANDLE(root_dev);
+	if (!handle)
+		return ERR_PTR(-ENODEV);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);
+
 /**
  * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
  * @handle: ACPI handle
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e70df07f9b4b..ac6ea550ab0a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -733,6 +733,7 @@ struct qtg_dsm_output {
 
 struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 						 struct qtg_dsm_input *input);
+acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


