Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D772D37BA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgLIA10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:27:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:16954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731963AbgLIA0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:26:18 -0500
IronPort-SDR: GiOMss1028r+Gn5r+MOCm7hz8628P00XP3bhAjxED68agM7VzF6g2xxTZy9EudSJntYzjrWq3w
 etSVOMN+z7cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142096"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142096"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:29 -0800
IronPort-SDR: sJ1HRcf/iJjZI7fHyYYvkJ4ktLx/cXdcJ8KMLv9oTnd56IUILKXY3VDk+2k+D0AKY5VXXCcp5n
 Bt4yLtIRI7Zg==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838520"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 12/14] cxl: Add basic debugging
Date:   Tue,  8 Dec 2020 16:24:16 -0800
Message-Id: <20201209002418.1976362-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a standard debug function for use throughout the driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  3 +++
 drivers/cxl/mem.c | 26 +++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 77c2dee6843c..e5afb89dab0b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -9,6 +9,9 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
+#define cxl_debug(fmt, ...)                                                    \
+	pr_debug("CXL DEBUG: %s: " fmt, __func__, ##__VA_ARGS__)
+
 #define CXL_SET_FIELD(value, field)                                            \
 	({                                                                     \
 		WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a2cea7ac7cc6..6b2f8d3776b5 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -122,9 +122,12 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const int timeout = msecs_to_jiffies(2000);
 	const unsigned long start = jiffies;
+	unsigned long end = start;
 
 	while (cxl_doorbell_busy(cxlm)) {
-		if (time_after(jiffies, start + timeout)) {
+		end = jiffies;
+
+		if (time_after(end, start + timeout)) {
 			/* Check again in case preempted before timeout test */
 			if (!cxl_doorbell_busy(cxlm))
 				break;
@@ -133,6 +136,8 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 		cpu_relax();
 	}
 
+	cxl_debug("Doorbell wait took %dms",
+		  jiffies_to_msecs(end) - jiffies_to_msecs(start));
 	return 0;
 }
 
@@ -180,6 +185,8 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	}
 
 	/* #4 */
+	cxl_debug("Sending command to %s\n",
+		  dev_driver_string(&cxlm->pdev->dev));
 	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
 			     CXLDEV_MB_CTRL_DOORBELL);
 
@@ -308,6 +315,8 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
 	if (!cxlmd)
 		return -ENXIO;
 
+	cxl_debug("Opened %pD\n", file);
+
 	file->private_data = cxlmd;
 
 	return 0;
@@ -383,6 +392,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 		.size_in = cmd->info.size_in,
 		.size_out = size_out,
 	};
+	cxl_debug("Submitting command for user\n"
+		  "\topcode: %x\n"
+		  "\tsize: %zub/%zub\n",
+		  mbox_cmd.opcode, mbox_cmd.size_in, mbox_cmd.size_out);
 	rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
 	cxl_mem_mbox_put(cxlmd->cxlm);
 	if (rc)
@@ -479,6 +492,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		u32 n_commands;
 		int i, j;
 
+		cxl_debug("Query IOCTL\n");
+
 		if (get_user(n_commands, (u32 __user *)arg))
 			return -EFAULT;
 
@@ -511,6 +526,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		struct cxl_mem_command c;
 		int rc;
 
+		cxl_debug("Send IOCTL\n");
+
 		rc = cxl_validate_cmd_from_user(u, &c);
 		if (rc)
 			return rc;
@@ -843,6 +860,13 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 
 	id = (struct cxl_mbox_identify *)mbox_cmd.payload;
 
+	cxl_debug("Driver identify command\n"
+		  "\tFirmware Version: %s\n"
+		  "\tTotal Capacity: %llu (%llu persistent)\n"
+		  "\tLSA size: %u\n",
+		  id->fw_revision, id->total_capacity, id->persistent_capacity,
+		  id->lsa_size);
+
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs
-- 
2.29.2

