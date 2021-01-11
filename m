Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52222F23BC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbhALAZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:11217 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390826AbhAKWx3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:53:29 -0500
IronPort-SDR: CL/0oszWglIRsDqEGsIPoaeaKJ43aAQb+1GdSkkpb2SKkWsKU/261xzEioTCUuyiUa9XAcJuWy
 lI7l7okkY1Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726556"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:45 -0800
IronPort-SDR: 6pJ6EpmEYXLhnzNPZesqE1yNHmYCjD1gD8greVg39HvwW3032McTQ7gljJ5lxij43bU7VKyAD0
 tYiCyHLYh3MQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778058"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:44 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: [RFC PATCH v3 15/16] cxl/mem: Add limited Get Log command (0401h)
Date:   Mon, 11 Jan 2021 14:51:20 -0800
Message-Id: <20210111225121.820014-17-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Get Log command returns the actual log entries that are advertised
via the Get Supported Logs command (0400h). CXL device logs are selected
by UUID which is part of the CXL spec. Because the driver tries to
sanitize what is sent to hardware, there becomes a need to restrict the
types of logs which can be accessed by userspace. For example, the
vendor specific log might only be consumable by proprietary, or offline
applications, and therefore a good candidate for userspace.

The current driver infrastructure does allow basic validation for all
commands, but doesn't inspect any of the payload data. Along with Get
Log support comes new infrastructure to add a hook for payload
validation. This infrastructure is used to filter out the CEL UUID,
which the userspace driver doesn't have business knowing, and taints on
invalid UUIDs being sent to hardware.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 42 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6dfc8ff0aefb..593db737e7a4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -94,7 +94,7 @@ static struct {
 } command_names[] = { CMDS };
 #undef C
 
-#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
+#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, v)                         \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 		{                                                              \
 			.id = CXL_MEM_COMMAND_ID_##_id,                        \
@@ -104,8 +104,12 @@ static struct {
 		},                                                             \
 			.flags = CXL_CMD_INTERNAL_FLAG_##f,                    \
 			.opcode = CXL_MBOX_OP_##_id,                           \
+			.validate_payload = v,                                 \
 	}
 
+#define CXL_CMD(_id, _flags, sin, sout, f) \
+	CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, NULL)
+
 enum {
 	CEL_UUID,
 	DEBUG_UUID
@@ -116,6 +120,8 @@ static const uuid_t log_uuid[] = {
 	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86)
 };
 
+static int validate_log_uuid(void __user *payload, size_t size);
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -129,6 +135,10 @@ static const uuid_t log_uuid[] = {
  *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
  *    a direct mapping to hardware. They are implicitly always enabled.
  *
+ * @validate_payload: A function called after the command is validated but
+ * before it's sent to the hardware. The primary purpose is to validate, or
+ * fixup the actual payload.
+ *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
  * the hardware. The driver will use @info to validate the fields passed in by
@@ -144,6 +154,8 @@ struct cxl_mem_command {
 #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
 #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
 #define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
+
+	int (*validate_payload)(void __user *payload, size_t size);
 };
 
 /*
@@ -157,6 +169,8 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
 	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
 	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0, MANDATORY),
+	CXL_CMD_VALIDATE(GET_LOG, MUTEX, 0x18, ~0, MANDATORY,
+			 validate_log_uuid),
 };
 
 #define cxl_for_each_cmd(cmd)                                                  \
@@ -515,6 +529,15 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 	int rc;
 
 	if (cmd->info.size_in) {
+		if (cmd->validate_payload) {
+			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
+						   cmd->info.size_in);
+			if (rc) {
+				cxl_mem_mbox_put(cxlmd->cxlm);
+				return -EFAULT;
+			}
+		}
+
 		/*
 		 * Directly copy the userspace payload into the hardware. UAPI
 		 * states that the buffer must already be little endian.
@@ -1063,6 +1086,23 @@ struct cxl_mbox_get_log {
 	__le32 length;
 } __packed;
 
+static int validate_log_uuid(void __user *input, size_t size)
+{
+	struct cxl_mbox_get_log __user *get_log = input;
+	uuid_t payload_uuid;
+
+	if (copy_from_user(&payload_uuid, &get_log->uuid, sizeof(uuid_t)))
+		return -EFAULT;
+
+	/* All commands taint except debug vendor log */
+	if (uuid_equal(&payload_uuid, &log_uuid[DEBUG_UUID]))
+		return 0;
+
+	add_taint(TAINT_RAW_PASSTHROUGH, LOCKDEP_STILL_OK);
+
+	return 0;
+}
+
 static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size,
 			u8 *out)
 {
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index b504412d1db7..4c4a12c7a4d5 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -34,6 +34,7 @@ extern "C" {
 	C(IDENTIFY,	"Identify Command"),                                   \
 	C(RAW,		"Raw device command"),                                 \
 	C(GET_SUPPORTED_LOGS,		"Get Supported Logs"),                 \
+	C(GET_LOG,	"Get Log"),                                            \
 	C(MAX,		"Last command")
 #undef C
 #define C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.0

