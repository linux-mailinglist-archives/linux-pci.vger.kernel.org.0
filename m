Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09902F23B8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbhALAZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:11211 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390809AbhAKWw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:56 -0500
IronPort-SDR: Z+akK1UuMtHT+zy2K0J8j1oPlpvIUlh2LMSF0ayEk7OprBbQA2848K7csHICN7ZcEDQODtYoAv
 l5afBDzetjBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726541"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:37 -0800
IronPort-SDR: 9PYDaynC84qHiDcYIXTzxEDZhwLhHXYKepGyVuK0JyApij/fpGPrkVh/ApSmsyfnfXcI462S3/
 wJyGPxxlk7+A==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778012"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:36 -0800
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
Subject: [RFC PATCH v3 09/16] cxl/mem: Add basic IOCTL interface
Date:   Mon, 11 Jan 2021 14:51:13 -0800
Message-Id: <20210111225121.820014-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a straightforward IOCTL that provides a mechanism for userspace to
query the supported memory device commands. CXL commands as they appear
to userspace are described as part of the UAPI kerneldoc. The command
list returned via this IOCTL will contain the full set of commands that
the driver supports, however, some of those commands may not be
available for use by userspace.

Memory device commands are specified in 8.2.9 of the CXL 2.0
specification. They are submitted through a mailbox mechanism specified
in 8.2.8.4.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format                                 |   1 +
 Documentation/cxl/memory-devices.rst          |   9 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/cxl/mem.c                             | 156 ++++++++++++++++++
 include/uapi/linux/cxl_mem.h                  | 117 +++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 include/uapi/linux/cxl_mem.h

diff --git a/.clang-format b/.clang-format
index 10dc5a9a61b3..3f11c8901b43 100644
--- a/.clang-format
+++ b/.clang-format
@@ -109,6 +109,7 @@ ForEachMacros:
   - 'css_for_each_child'
   - 'css_for_each_descendant_post'
   - 'css_for_each_descendant_pre'
+  - 'cxl_for_each_cmd'
   - 'device_for_each_child_node'
   - 'dma_fence_chain_for_each'
   - 'do_for_each_ftrace_op'
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
 
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..6eb8e634664d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -352,6 +352,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:michael.klein@puffin.lb.shuttle.de>
 0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h
+0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
 0xCF  02     fs/cifs/ioctl.c
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index da2bf941fe92..d4eb3f5b9469 100644
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
@@ -41,6 +42,7 @@
 #define CXL_MAILBOX_TIMEOUT_US 2000
 
 enum opcode {
+	CXL_MBOX_OP_INVALID	= 0x0000,
 	CXL_MBOX_OP_IDENTIFY    = 0x4000,
 	CXL_MBOX_OP_MAX         = 0x10000
 };
@@ -82,6 +84,90 @@ static DEFINE_IDR(cxl_mem_idr);
 /* protect cxl_mem_idr allocations */
 static DEFINE_MUTEX(cxl_memdev_lock);
 
+#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
+	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
+		{                                                              \
+			.id = CXL_MEM_COMMAND_ID_##_id,                        \
+			.flags = CXL_MEM_COMMAND_FLAG_##_flags,                \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+			.flags = CXL_CMD_INTERNAL_FLAG_##f,                    \
+			.opcode = CXL_MBOX_OP_##_id,                           \
+	}
+
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @flags: Set of flags reflecting the state of the command.
+ *
+ *  * %CXL_CMD_INTERNAL_FLAG_HIDDEN: Command is hidden from userspace. This
+ *    would typically be used for deprecated commands.
+ *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
+ *    only used internally by the driver for sanity checking.
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	const struct cxl_command_info info;
+	enum opcode opcode;
+	u32 flags;
+#define CXL_CMD_INTERNAL_FLAG_NONE 0
+#define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
+#define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
+};
+
+/*
+ * This table defines the supported mailbox commands for the driver. This table
+ * is made up of a UAPI structure. Non-negative values as parameters in the
+ * table will be validated against the user's input. For example, if size_in is
+ * 0, and the user passed in 1, it is an error.
+ */
+static struct cxl_mem_command mem_commands[] = {
+	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
+	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
+};
+
+#define cxl_for_each_cmd(cmd)                                                  \
+	for ((cmd) = &mem_commands[0];                                         \
+	     ((cmd) - mem_commands) < ARRAY_SIZE(mem_commands); (cmd)++)
+
+static inline int cxl_cmd_index(const struct cxl_mem_command *c)
+{
+	if (unlikely(c >= mem_commands &&
+		     c < (mem_commands + sizeof(mem_commands)))) {
+		struct cxl_mem_command *p;
+
+		cxl_for_each_cmd(p)
+			if (p->opcode == c->opcode &&
+			    p->flags == c->flags)
+				return p - mem_commands;
+	} else {
+		return c - mem_commands;
+	}
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_cmd(c) {
+		if (c->opcode == opcode)
+			return c;
+	}
+
+	return NULL;
+}
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
@@ -140,6 +226,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
 static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 				 struct mbox_cmd *mbox_cmd)
 {
+	const struct cxl_mem_command *cmd;
 	u64 cmd_reg, status_reg;
 	size_t out_len;
 	int rc;
@@ -158,6 +245,13 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	 *   8. If output payload is non-empty, host reads Command Payload Registers
 	 */
 
+	cmd = cxl_mem_find_command(mbox_cmd->opcode);
+	if (!cmd) {
+		dev_info(&cxlm->pdev->dev,
+			 "Unknown opcode 0x%04x being sent to hardware\n",
+			 mbox_cmd->opcode);
+	}
+
 	/* #1 */
 	WARN_ON(cxl_doorbell_busy(cxlm));
 
@@ -200,6 +294,20 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
 	mbox_cmd->size_out = out_len;
 
+	/*
+	 * If the command had a fixed size output, but the hardware did
+	 * something unexpected, just print an error and move on. It would be
+	 * worth sending a bug report.
+	 */
+	if (cmd && cmd->info.size_out >= 0 &&
+	    mbox_cmd->size_out != cmd->info.size_out) {
+		bool too_big = mbox_cmd->size_out > cmd->info.size_out;
+
+		dev_err(&cxlm->pdev->dev,
+			"payload was %s than driver expectations\n",
+			too_big ? "larger" : "smaller");
+	}
+
 	/* #8 */
 	if (out_len && mbox_cmd->payload)
 		memcpy_fromio(mbox_cmd->payload, cxl_payload_regs(cxlm),
@@ -323,8 +431,56 @@ static int cxl_mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int cxl_mem_count_commands(void)
+{
+	struct cxl_mem_command *c;
+	int n = 0;
+
+	cxl_for_each_cmd(c) {
+		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+			continue;
+		n++;
+	}
+
+	return n;
+}
+
 static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	struct cxl_memdev *cxlmd = file->private_data;
+	struct device *dev = &cxlmd->dev;
+
+	if (cmd == CXL_MEM_QUERY_COMMANDS) {
+		struct cxl_mem_query_commands __user *q = (void __user *)arg;
+		struct cxl_mem_command *cmd;
+		u32 n_commands;
+		int j = 0;
+
+		dev_dbg(dev, "Query IOCTL\n");
+
+		if (get_user(n_commands, (u32 __user *)arg))
+			return -EFAULT;
+
+		/* returns the total number if 0 elements are requested. */
+		if (n_commands == 0)
+			return put_user(cxl_mem_count_commands(),
+					(u32 __user *)arg);
+
+		/* otherwise, return max(n_commands, total commands) */
+		cxl_for_each_cmd(cmd) {
+			const struct cxl_command_info *info = &cmd->info;
+
+			if (cmd->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+				continue;
+
+			if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+				return -EFAULT;
+
+			if (j == n_commands)
+				break;
+		}
+	}
+
 	return -ENOTTY;
 }
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..847f825bbe18
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,117 @@
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
+ * to communicate to driver. The commands themselves are somewhat obfuscated
+ * with macro magic. They have the form CXL_MEM_COMMAND_ID_<name>.
+ *
+ * For example "CXL_MEM_COMMAND_ID_INVALID"
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+
+#undef CMDS
+#define CMDS                                                                   \
+	C(INVALID,	"Invalid Command"),                                    \
+	C(IDENTIFY,	"Identify Command"),                                   \
+	C(MAX,		"Last command")
+#undef C
+#define C(a, b) CXL_MEM_COMMAND_ID_##a
+
+enum { CMDS };
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ *
+ *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
+ *    kernel use.
+ *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
+ *    the kernel in order to complete successfully.
+ *
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. The is returned as part of an array from the query ioctl. The
+ * following would be a command named "foobar" that takes a variable length
+ * input and returns 0 bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_NONE 0
+#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
+#define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+
+	__s32 size_in;
+	__s32 size_out;
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
2.30.0

