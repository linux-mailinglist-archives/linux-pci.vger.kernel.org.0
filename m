Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2E4A5391
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiAaXvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:51:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:22290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbiAaXvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643673105; x=1675209105;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/coqwKlOdxaXYlX5oEp45IALwH8yjaQ+IYj+p4ZQB8=;
  b=OYT8kaS158Mo8Be8Tjzm6xi9guQipIsQpUpPLwc0FG0vKRoRK2YdRoJJ
   st9kttMxH9ccr11fFjCmUyJculsO0ICfZ53Lo02a1KMrZLnQslZV/FKNL
   MvHOWuRdxkG+XT/+0pOa4UN5JcgKgzAhzrj0kVHiBKiaVUTpmLjNkmETV
   NwPC+EInP1S8h4DIC8VvEwcCdB1tXwlzKc0QSPfntlvLllVMd1WfF5pOC
   m5Gsjl6GipJDWDlOaZy0oENSO9vDqRxFg28zoyaz4J3wcwUliSbKPA1dF
   3wuT7A7okEHYtcSn8gVoPRc443vG/awDYa7rFrbfQnkcvpC3vgsqLBq4A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333935273"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="333935273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:51:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="537554609"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:51:45 -0800
Subject: [PATCH v4 02/40] cxl/pci: Implement Interface Ready Timeout
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Mon, 31 Jan 2022 15:51:45 -0800
Message-ID: <164367306565.208548.1932299464604450843.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298412919.3018233.12491722885382120190.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298412919.3018233.12491722885382120190.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The original driver implementation used the doorbell timeout for the
Mailbox Interface Ready bit to piggy back off of, since the latter does
not have a defined timeout. This functionality, introduced in commit
8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
the recent "Add Mailbox Ready Time" ECN timeout indicates that the
mailbox ready time can be significantly longer that 2 seconds.

While the specification limits the maximum timeout to 256s, the cxl_pci
driver gives up on the mailbox after 60s. This value corresponds with
important timeout values already present in the kernel. A module
parameter is provided as an emergency override and represents the
default Linux policy for all devices.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[djbw: add modparam, drop check_device_status()]
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- Let non-admins send timeout bug reports (Ben)

 drivers/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8dc91fd3396a..cc0cdd7e9de3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/moduleparam.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -35,6 +37,20 @@
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
+/*
+ * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
+ * dictate how long to wait for the mailbox to become ready. The new
+ * field allows the device to tell software the amount of time to wait
+ * before mailbox ready. This field per the spec theoretically allows
+ * for up to 255 seconds. 255 seconds is unreasonably long, its longer
+ * than the maximum SATA port link recovery wait. Default to 60 seconds
+ * until someone builds a CXL device that needs more time in practice.
+ */
+static unsigned short mbox_ready_timeout = 60;
+module_param(mbox_ready_timeout, ushort, 0644);
+MODULE_PARM_DESC(mbox_ready_timeout,
+		 "seconds to wait for mailbox ready status");
+
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
 	const unsigned long start = jiffies;
@@ -281,6 +297,25 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
 static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 {
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
+	unsigned long timeout;
+	u64 md_status;
+
+	timeout = jiffies + mbox_ready_timeout * HZ;
+	do {
+		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		if (md_status & CXLMDEV_MBOX_IF_READY)
+			break;
+		if (msleep_interruptible(100))
+			break;
+	} while (!time_after(jiffies, timeout));
+
+	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
+		dev_err(cxlds->dev,
+			"timeout awaiting mailbox ready, device state:%s%s\n",
+			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
+			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
+		return -EIO;
+	}
 
 	cxlds->mbox_send = cxl_pci_mbox_send;
 	cxlds->payload_size =

