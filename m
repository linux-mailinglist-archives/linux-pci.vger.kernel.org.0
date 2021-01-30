Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55E530944A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhA3AeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 19:34:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:38338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhA3AcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 19:32:06 -0500
IronPort-SDR: SR5doI+Ls5zH4HxZr4iCX1ucFGIVjnS106zN2RDbEOQ5Si48vSxFEpEt57Gl1hFY7jM5ww6BqZ
 6DO3yZY+wPPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199350697"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199350697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:53 -0800
IronPort-SDR: 6xlzRUjn7lUxS+wZo8rZMUlw9vLMCOjoZl0Qgd+c58UVWhMpK7qZKfh4IK1VeJPmgaKS6Ny4DC
 NbF13wTlEOwg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370591712"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:52 -0800
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
Subject: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Date:   Fri, 29 Jan 2021 16:24:37 -0800
Message-Id: <20210130002438.1872527-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
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
index b8ca6dff37b5..086268f1dd6c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -119,6 +119,8 @@ static const uuid_t log_uuid[] = {
 				 0x07, 0x19, 0x40, 0x3d, 0x86)
 };
 
+static int validate_log_uuid(void __user *payload, size_t size);
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -132,6 +134,10 @@ static const uuid_t log_uuid[] = {
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
@@ -147,9 +153,11 @@ struct cxl_mem_command {
 #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
 #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
 #define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
+
+	int (*validate_payload)(void __user *payload, size_t size);
 };
 
-#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
+#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, v)                         \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 	.info =	{                                                              \
 			.id = CXL_MEM_COMMAND_ID_##_id,                        \
@@ -159,8 +167,12 @@ struct cxl_mem_command {
 		},                                                             \
 	.flags = CXL_CMD_INTERNAL_FLAG_##f,                                    \
 	.opcode = CXL_MBOX_OP_##_id,                                           \
+	.validate_payload = v,                                                 \
 	}
 
+#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
+	CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, NULL)
+
 /*
  * This table defines the supported mailbox commands for the driver. This table
  * is made up of a UAPI structure. Non-negative values as parameters in the
@@ -176,6 +188,8 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(GET_PARTITION_INFO, NONE, 0, 0x20, NONE),
 	CXL_CMD(GET_LSA, NONE, 0x8, ~0, MANDATORY),
 	CXL_CMD(GET_HEALTH_INFO, NONE, 0, 0x12, MANDATORY),
+	CXL_CMD_VALIDATE(GET_LOG, MUTEX, 0x18, ~0, MANDATORY,
+			 validate_log_uuid),
 };
 
 /*
@@ -563,6 +577,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 			kvzalloc(cxlm->mbox.payload_size, GFP_KERNEL);
 
 	if (cmd->info.size_in) {
+		if (cmd->validate_payload) {
+			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
+						   cmd->info.size_in);
+			if (rc)
+				goto out;
+		}
+
 		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
 		if (!mbox_cmd.payload_in) {
 			rc = -ENOMEM;
@@ -1205,6 +1226,25 @@ struct cxl_mbox_get_log {
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
+	/* All unspec'd logs shall taint */
+	if (uuid_equal(&payload_uuid, &log_uuid[CEL_UUID]))
+		return 0;
+	if (uuid_equal(&payload_uuid, &log_uuid[DEBUG_UUID]))
+		return 0;
+
+	add_taint(TAINT_RAW_PASSTHROUGH, LOCKDEP_STILL_OK);
+
+	return 0;
+}
+
 static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
 {
 	u32 remaining = size;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 766c231d6150..7cdc7f7ce7ec 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -39,6 +39,7 @@ extern "C" {
 	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
 	___C(GET_LSA, "Get Label Storage Area"),                          \
 	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
+	___C(GET_LOG, "Get Log"),                                         \
 	___C(MAX, "Last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.0

