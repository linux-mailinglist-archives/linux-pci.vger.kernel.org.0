Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F295C4579E1
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhKTAGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhKTAGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542396"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088342"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 04/23] cxl/pci: Implement Interface Ready Timeout
Date:   Fri, 19 Nov 2021 16:02:31 -0800
Message-Id: <20211120000250.1663391-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The original driver implementation used the doorbell timeout for the
Mailbox Interface Ready bit to piggy back off of, since the latter
doesn't have a defined timeout. This functionality, introduced in
8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
since a timeout has been defined with an ECN to the 2.0 spec.

While devices implemented prior to the ECN could have an arbitrarily
long wait and still be within spec, the max ECN value (256s) is chosen
as the default for all devices. All vendors in the consortium agreed to
this amount and so it is reasonable to assume no devices made will
exceed this amount.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This patch did not exist in RFCv2
---
 drivers/cxl/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6c8d09fb3a17..2cef9fec8599 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -298,6 +299,34 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
 static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 {
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
+	unsigned long timeout;
+	u64 md_status;
+	int rc;
+
+	/*
+	 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
+	 * dictate how long to wait for the mailbox to become ready. For
+	 * simplicity, and to handle devices that might have been implemented
+	 * prior to the ECN, wait the max amount of time no matter what the
+	 * device says.
+	 */
+	timeout = jiffies + 256 * HZ;
+
+	rc = check_device_status(cxlds);
+	if (rc)
+		return rc;
+
+	do {
+		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		if (md_status & CXLMDEV_MBOX_IF_READY)
+			break;
+		if (msleep_interruptible(100))
+			break;
+	} while (!time_after(jiffies, timeout));
+
+	/* It's assumed that once the interface is ready, it will remain ready. */
+	if (!(md_status & CXLMDEV_MBOX_IF_READY))
+		return -EIO;
 
 	cxlds->mbox_send = cxl_pci_mbox_send;
 	cxlds->payload_size =
-- 
2.34.0

