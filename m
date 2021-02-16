Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F531C51E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 02:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBPBsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 20:48:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:3276 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhBPBrR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 20:47:17 -0500
IronPort-SDR: lJ6wXNP/1LjUFvIFCIS1vXnoDw6v40/n0igu3AEVV0Qs71EwNa9SZR8Hjpjux4380nIxNS3HLI
 mrFSDbv0xt0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246852887"
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="246852887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:57 -0800
IronPort-SDR: 9vFOpmlm3IuBW0tVIxNRZSnbkppRO4Jbqu673BuYx8VOiQmXbjMq8agk1/l+zyjBhHBFRXY0v1
 UpqJoXFyTFOg==
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="399296110"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:58 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 7/9] cxl/mem: Add set of informational commands
Date:   Mon, 15 Feb 2021 17:45:36 -0800
Message-Id: <20210216014538.268106-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210216014538.268106-1-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add initial set of formal commands beyond basic identify and command
enumeration.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)
---
 drivers/cxl/mem.c            | 9 +++++++++
 include/uapi/linux/cxl_mem.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4d921b4375f9..dc608bb20a31 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,12 +45,16 @@
 enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_GET_LSA		= 0x4102,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
@@ -167,6 +171,11 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(RAW, ~0, ~0, 0),
 #endif
 	CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
+	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
+	CXL_CMD(GET_LSA, 0x8, ~0, 0),
+	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
+	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
 };
 
 /*
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 3b5bf4b58fb4..7670fe0e605a 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -24,6 +24,11 @@
 	___C(IDENTIFY, "Identify Command"),                               \
 	___C(RAW, "Raw device command"),                                  \
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
+	___C(GET_FW_INFO, "Get FW Info"),                                 \
+	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
+	___C(GET_LSA, "Get Label Storage Area"),                          \
+	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
+	___C(GET_LOG, "Get Log"),                                         \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.1

