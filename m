Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD832D37B2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgLIA0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:26:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:16961 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731969AbgLIA0V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:26:21 -0500
IronPort-SDR: gAi/abx/k+gpBaztUF9VINZiQ/ZiePBof4Zbyxj75zj4QQWV4KsYjoZLov12XtTbHMG2G2MJsw
 JmFSW9DMRfmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142101"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:31 -0800
IronPort-SDR: FutnC4UFEceEPiJyz7rzmsBr40hsiAP7b6MFuEIFDe62pQcwgXZkE7iQCkhdrYRPE9/3aYIkj4
 4PHmVC5p31cA==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838534"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:30 -0800
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
Subject: [RFC PATCH 14/14] WIP/cxl/mem: Add get firmware for testing
Date:   Tue,  8 Dec 2020 16:24:18 -0800
Message-Id: <20201209002418.1976362-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This also serves as an example how to add a new command

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 22 ++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6b2f8d3776b5..76aa1e6e4117 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -116,6 +116,7 @@ struct cxl_mem_command {
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
 	CXL_CMD(RAW, TAINT, ~0, ~0, "Raw", true, 0),
+	CXL_CMD(GET_FW_INFO, NONE, 0, 0x50, "Get FW Info", false, 0x0200),
 };
 
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
@@ -827,6 +828,23 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return cxl_register(dev);
 }
 
+static int cxl_mem_enable_commands(struct cxl_mem *cxlm)
+{
+	struct cxl_mem_command *c;
+
+	/*
+	 * For now we pretend Get FW info is supported.
+	 *
+	 * FIXME: Invoke GET LOG to get the Command Effect Logs (CEL).
+	 */
+	c = cxl_mem_find_command(0x200);
+	if (!c)
+		return -ENOENT;
+
+	c->enable = true;
+	return 0;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -936,6 +954,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_enable_commands(cxlm);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_identify(cxlm);
 	if (rc)
 		return rc;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index f2fbb0dcda06..3ac39acf8fa7 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,7 +50,8 @@ struct cxl_command_info {
 	__u32 id;
 #define CXL_MEM_COMMAND_ID_INVALID 0
 #define CXL_MEM_COMMAND_ID_RAW 1
-#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_RAW + 1)
+#define CXL_MEM_COMMAND_ID_GET_FW_INFO 2
+#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_GET_FW_INFO + 1)
 
 	__u32 flags;
 #define CXL_MEM_COMMAND_FLAG_NONE 0
-- 
2.29.2

