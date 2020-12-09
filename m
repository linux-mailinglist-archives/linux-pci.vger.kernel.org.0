Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9B2D37C5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgLIA2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:28:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:16959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbgLIAZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:59 -0500
IronPort-SDR: Vbbf5Yyriz45L+TTe97gXCRqCa8l4alyyM3LT+6vagJYBn/POSMD+F7lNTiQu/X5n46HBNZVbW
 +fNorpOBFxZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142089"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142089"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:28 -0800
IronPort-SDR: vy0dthkPfL/gcxo52372VSggCr9CVKXZICPtYVNpoOJaYj/GUPeSKxYXAxc3lyPpo/6SgCyhm7
 tHDJ9SRsvrsA==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838506"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:27 -0800
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
Subject: [RFC PATCH 09/14] cxl/mem: Add basic IOCTL interface
Date:   Tue,  8 Dec 2020 16:24:13 -0800
Message-Id: <20201209002418.1976362-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a straightforward IOCTL that provides a mechanism for userspace to
query the supported memory device commands.

Memory device commands are specified in 8.2.9 of the CXL 2.0
specification. They are submitted through a mailbox mechanism specified
in 8.2.8.4.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---

I did attempt to use the same struct for querying commands as well as
sending commands (upcoming patch). The number of unused fields between
the two made for a bad fit IMO.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/cxl/memory-devices.rst |   9 +++
 drivers/cxl/mem.c                    |  89 +++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h         | 102 +++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 include/uapi/linux/cxl_mem.h

diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
index 5f723c25382b..ec54674b3822 100644
--- a/Documentation/cxl/memory-devices.rst
+++ b/Documentation/cxl/memory-devices.rst
@@ -32,6 +32,15 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/mem.c
    :internal:
 
+CXL IOCTL Interface
+-------------------
+
+.. kernel-doc:: include/uapi/linux/cxl_mem.h
+   :doc: UAPI
+
+.. kernel-doc:: include/uapi/linux/cxl_mem.h
+   :internal:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index bb6ea58f6c7b..2c4aadcea0e4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <uapi/linux/cxl_mem.h>
 #include "acpi.h"
 #include "pci.h"
 #include "cxl.h"
@@ -73,6 +74,49 @@ static DEFINE_IDR(cxl_mem_idr);
 /* protect cxl_mem_idr allocations */
 static DEFINE_MUTEX(cxl_memdev_lock);
 
+/*
+ * This table defines the supported mailboxes commands for the driver. The id is
+ * ordinal and thus gaps in this table aren't allowed. This table is made up of
+ * a UAPI structure. Non-negative values in the table will be validated against
+ * the user's input. For example, if size_in is 0, and the user passed in 1, it
+ * is an error.
+ */
+#define CXL_CMD(_id, _flags, sin, sout, _name, _enable, op)                    \
+	{                                                                      \
+		{ .id = CXL_MEM_COMMAND_ID_##_id,                              \
+		  .flags = CXL_MEM_COMMAND_FLAG_##_flags,                      \
+		  .size_in = sin,                                              \
+		  .size_out = sout,                                            \
+		  .name = _name },                                             \
+			.enable = _enable, .opcode = op                        \
+	}
+
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @enable: Whether the command is enabled. The driver may support a large set
+ *	    of commands that may not be enabled. The primary reason a command
+ *	    would not be enabled is for commands that are specified as optional
+ *	    and the hardware doesn't support the command.
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware (!@enable). The driver will use @info to validate the fields
+ * passed in by the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	const struct cxl_command_info info;
+	const u16 opcode;
+	bool enable;
+};
+
+static struct cxl_mem_command mem_commands[] = {
+	CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
+};
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const int timeout = msecs_to_jiffies(2000);
@@ -268,8 +312,53 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int cxl_mem_count_commands(void)
+{
+	int i, n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mem_commands); i++) {
+		struct cxl_mem_command *c = &mem_commands[i];
+
+		if (c->enable)
+			n++;
+	}
+
+	return n;
+}
+
 static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	if (cmd == CXL_MEM_QUERY_COMMANDS) {
+		struct cxl_mem_query_commands __user *q = (void __user *)arg;
+		u32 n_commands;
+		int i, j;
+
+		if (get_user(n_commands, (u32 __user *)arg))
+			return -EFAULT;
+
+		if (n_commands == 0)
+			return put_user(cxl_mem_count_commands(),
+					(u32 __user *)arg);
+
+		for (i = 0, j = 0;
+		     i < ARRAY_SIZE(mem_commands) && j < n_commands; i++) {
+			struct cxl_mem_command *c = &mem_commands[i];
+			const struct cxl_command_info *info = &c->info;
+
+			if (!c->enable)
+				continue;
+
+			if (copy_to_user(&q->commands[j], info, sizeof(*info)))
+				return -EFAULT;
+
+			if (copy_to_user(&q->commands[j].name, info->name,
+					 strlen(info->name)))
+				return -EFAULT;
+
+			j++;
+		}
+	}
+
 	return -ENOTTY;
 }
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..1d1e143f98ec
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * DOC: UAPI
+ *
+ * CXL memory devices expose UAPI to have a standard user interface.
+ * Userspace can refer to these structure definitions and UAPI formats
+ * to communicate to driver
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
+
+#define CXL_MEM_COMMAND_NAME_LENGTH 32
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ *
+ *          - CXL_MEM_COMMAND_FLAG_TAINT: Using this command will taint the kernel.
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ * @name: Name describing the command.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. The is returned as part of an array from the query ioctl. The
+ * following would be a command named "foobar" that takes a variable length
+ * input and returns 0 bytes of output.
+ *
+ *  - @id = 10
+ *  - @name = foobar
+ *  - @flags = 0
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+#define CXL_MEM_COMMAND_ID_INVALID 0
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_NONE 0
+#define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)
+
+	__s32 size_in;
+	__s32 size_out;
+
+	char name[32];
+};
+
+/**
+ * struct cxl_mem_query_commands - Query supported commands.
+ * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
+ *		return min(num_support_commands, n_commands). When @n_commands
+ *		is 0, driver will return the number of total supported commands.
+ * @rsvd: Reserved for future use.
+ * @commands: Output array of supported commands. This array must be allocated
+ *            by userspace to be at least min(num_support_commands, @n_commands)
+ *
+ * Allow userspace to query the available commands supported by both the driver,
+ * and the hardware. Commands that aren't supported by either the driver, or the
+ * hardware are not returned in the query.
+ *
+ * Examples:
+ *
+ *  - { .n_commands = 0 } // Get number of supported commands
+ *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
+ *    supported commands
+ *
+ *  See struct cxl_command_info.
+ */
+struct cxl_mem_query_commands {
+	/*
+	 * Input: Number of commands to return (space allocated by user)
+	 * Output: Number of commands supported by the driver/hardware
+	 *
+	 * If n_commands is 0, kernel will only return number of commands and
+	 * not try to populate commands[], thus allowing userspace to know how
+	 * much space to allocate
+	 */
+	__u32 n_commands;
+	__u32 rsvd;
+
+	struct cxl_command_info __user commands[]; /* out: supported commands */
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif
-- 
2.29.2

