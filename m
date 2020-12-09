Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6122D37C1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgLIA17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:27:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:16961 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731943AbgLIA0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:26:06 -0500
IronPort-SDR: JlsJmpAwW9yv5IItQmMXPRW4uHh8ySZ4rrsuSm9Ue2yjZUHxWVx8jjm2NdWKiLQeQ93SyJBaOo
 DH9hLevEzZYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142094"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:29 -0800
IronPort-SDR: rV3okS6x8LRC8iRYrT1DqL1oXOZZkRpgGmpvmG9cy8GnokOgzwoJuTL4UQWOkZqf/x/NSRMWe3
 7UsSDKmK+iLw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838514"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:28 -0800
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
Subject: [RFC PATCH 11/14] cxl/mem: Add a "RAW" send command
Date:   Tue,  8 Dec 2020 16:24:15 -0800
Message-Id: <20201209002418.1976362-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL memory device send interface will have a number of supported
commands. The raw command is not such a command. Raw commands allow
userspace to send a specified opcode to the underlying hardware and
bypass all driver checks on the command. This is useful for a couple of
usecases, mainly:
1. Undocumented vendor specific hardware commands
2. Prototyping new hardware commands not yet supported by the driver

While this all sounds very powerful it comes with a couple of caveats:
1. Bug reports using raw commands will not get the same level of
   attention as bug reports using supported commands (via taint).
2. Supported commands will be rejected by the RAW command.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h | 14 ++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0bf03afc0c80..a2cea7ac7cc6 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -115,6 +115,7 @@ struct cxl_mem_command {
 
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
+	CXL_CMD(RAW, TAINT, ~0, ~0, "Raw", true, 0),
 };
 
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
@@ -326,6 +327,20 @@ static int cxl_mem_count_commands(void)
 	return n;
 };
 
+static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mem_commands); i++) {
+		struct cxl_mem_command *c = &mem_commands[i];
+
+		if (c->opcode == opcode)
+			return c;
+	}
+
+	return NULL;
+};
+
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
  * @cxlmd: The CXL memory device to communicate with.
@@ -421,6 +436,23 @@ static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
 	c = &mem_commands[cmd.id];
 	info = &c->info;
 
+	/* Checks are bypassed for raw commands but along comes the taint! */
+	if (cmd.id == CXL_MEM_COMMAND_ID_RAW) {
+		struct cxl_mem_command temp =
+			CXL_CMD(RAW, NONE, cmd.size_in, cmd.size_out, "Raw",
+				true, cmd.raw.opcode);
+
+		if (cmd.raw.rsvd)
+			return -EINVAL;
+
+		if (cxl_mem_find_command(cmd.raw.opcode))
+			return -EPERM;
+
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+		memcpy(out_cmd, &temp, sizeof(temp));
+		return 0;
+	}
+
 	if (cmd.flags & CXL_MEM_COMMAND_FLAG_MASK)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 189d86a13637..f2fbb0dcda06 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -49,7 +49,8 @@ extern "C" {
 struct cxl_command_info {
 	__u32 id;
 #define CXL_MEM_COMMAND_ID_INVALID 0
-#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_INVALID + 1)
+#define CXL_MEM_COMMAND_ID_RAW 1
+#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_RAW + 1)
 
 	__u32 flags;
 #define CXL_MEM_COMMAND_FLAG_NONE 0
@@ -103,6 +104,9 @@ struct cxl_mem_query_commands {
  * @id: The command to send to the memory device. This must be one of the
  *	commands returned by the query command.
  * @flags: Flags for the command
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Reserved for future use.
  * @rsvd: Reserved for future use.
  * @retval: Return value from the memory device (output).
  * @size_in: Size of the payload to provide to the device (input).
@@ -120,7 +124,13 @@ struct cxl_mem_query_commands {
 struct cxl_send_command {
 	__u32 id;
 	__u32 flags;
-	__u32 rsvd;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
 	__u32 retval;
 
 	struct {
-- 
2.29.2

