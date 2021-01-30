Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B92309454
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhA3KUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 05:20:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:38334 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232706AbhA3A3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 19:29:23 -0500
IronPort-SDR: xWMoN6Al8GMFv0RRXrPfcHT213hCA4kPbertb8kkNAkEqvmScOae/FKeUZpXbVUXDKhtKDKKXx
 7on8vleMhobw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199350693"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199350693"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:50 -0800
IronPort-SDR: PTVsJjzGJIhPmNWHZWpgsjtpCH+DjMG8Prae3+QWsFBb/v0MOBpY55rwhf13oNO3rkWts8okzc
 gLbIWiaS3/Qg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370591692"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:50 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [PATCH 10/14] cxl/mem: Create concept of enabled commands
Date:   Fri, 29 Jan 2021 16:24:34 -0800
Message-Id: <20210130002438.1872527-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL devices must implement the Device Command Interface (described in
8.2.9 of the CXL 2.0 spec). While the driver already maintains a list of
commands it supports, there is still a need to be able to distinguish
between commands that the driver knows about from commands that may not
be supported by the hardware. No such commands currently are defined in
the driver.

The implementation leaves the statically defined table of commands and
supplements it with a bitmap to determine commands that are enabled.

There are multiple approaches that can be taken, but this is nice for a
few reasons.

Here are some of the other solutions:

Create a per instance table with only the supported commands.
1. Having a fixed command id -> command mapping is much easier to manage
   for development and debugging.
2. Dealing with dynamic memory allocation for the table adds unnecessary
   complexity.
3. Most tables for device types are likely to be quite similar.
4. Makes it difficult to implement helper macros like cxl_for_each_cmd()

If the per instance table did preserve ids, #1 above can be addressed.
However, as "enable" is currently the only mutable state for the
commands, it would yield a lot of overhead for not much gain.
Additionally, the other issues remain.

If "enable" remains the only mutable state, I believe this to be the
best solution. Once the number of mutable elements in a command grows,
it probably makes sense to move to per device instance state with a
fixed command ID mapping.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  4 ++++
 drivers/cxl/mem.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b042eee7ee25..2d2f25065b81 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -17,6 +17,9 @@
 
 #define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
 
+/* XXX: Arbitrary max */
+#define CXL_MAX_COMMANDS 32
+
 /* Device Capabilities (CXL 2.0 - 8.2.8.1) */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -83,6 +86,7 @@ struct cxl_mem {
 	} ram;
 
 	char firmware_version[0x10];
+	DECLARE_BITMAP(enabled_cmds, CXL_MAX_COMMANDS);
 
 	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
 	struct {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2942730dc967..d01c6ee32a6b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -111,6 +111,8 @@ static bool raw_allow_all;
  *    would typically be used for deprecated commands.
  *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
  *    only used internally by the driver for sanity checking.
+ *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
+ *    a direct mapping to hardware. They are implicitly always enabled.
  *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
@@ -126,6 +128,7 @@ struct cxl_mem_command {
 #define CXL_CMD_INTERNAL_FLAG_NONE 0
 #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
 #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
+#define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
 };
 
 #define CXL_CMD(_id, _flags, sin, sout, f)                                     \
@@ -149,7 +152,7 @@ struct cxl_mem_command {
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
-	CXL_CMD(RAW, NONE, ~0, ~0, MANDATORY),
+	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
 };
 
 /*
@@ -683,6 +686,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	c = &mem_commands[send_cmd->id];
 	info = &c->info;
 
+	/* Check that the command is enabled for hardware */
+	if (!test_bit(info->id, cxlm->enabled_cmds))
+		return -ENOTTY;
+
 	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
 		return -EPERM;
 
@@ -1161,6 +1168,33 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return rc;
 }
 
+/**
+ * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
+ * @cxlm: The device.
+ *
+ * Returns 0 if enumerate completed successfully.
+ *
+ * CXL devices have optional support for certain commands. This function will
+ * determine the set of supported commands for the hardware and update the
+ * enabled_cmds bitmap in the @cxlm.
+ */
+static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
+{
+	struct cxl_mem_command *c;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mem_commands) >= CXL_MAX_COMMANDS);
+
+	/* All commands are considered enabled for now (except INVALID). */
+	cxl_for_each_cmd(c) {
+		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+			continue;
+
+		set_bit(c->info.id, cxlm->enabled_cmds);
+	}
+
+	return 0;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -1280,6 +1314,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_enumerate_cmds(cxlm);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_identify(cxlm);
 	if (rc)
 		return rc;
-- 
2.30.0

