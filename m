Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D32D37C3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgLIA2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:28:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:16954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731929AbgLIAZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:59 -0500
IronPort-SDR: WR1wm8lxMWkLMPdvfGFVeIHKYSWLlR+a4a2dPtN+dhk2sSp2JeLloWYMJREvPy6sOeXTS3aYaK
 9Zj+eBy/CL3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142092"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142092"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:28 -0800
IronPort-SDR: 2Y5k+5qwXjV40/Qjbj0fyYaVPjFOmT+ihKoPf5vbws+UaUq7wCax5WrOR71BMUGuZeE/KJSC2g
 5KKHCRDqYgRg==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838511"
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
Subject: [RFC PATCH 10/14] cxl/mem: Add send command
Date:   Tue,  8 Dec 2020 16:24:14 -0800
Message-Id: <20201209002418.1976362-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The send command allows userspace to issue mailbox commands directly to
the hardware. The driver will verify basic properties of the command but
otherwise pass any input payload untouched to the hardware, and return
the output payload to userspace.

The caller of this IOCTL is required to allocate enough space for
max(size_in, size_out) of the payload. The payload input data will be
wiped out if any output payload exists.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 127 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |  35 ++++++++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2c4aadcea0e4..0bf03afc0c80 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -324,6 +324,120 @@ static int cxl_mem_count_commands(void)
 	}
 
 	return n;
+};
+
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
+ * @cxlmd: The CXL memory device to communicate with.
+ * @cmd: The validated command
+ * @u: The command submitted by userspace. Only useful for RAW commands.
+ *
+ * Return: 0 on success.
+ *
+ * This function packages up a &struct mbox_cmd on behalf of userspace,
+ * dispatches the command, and returns the results.
+ */
+static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
+					const struct cxl_mem_command *cmd,
+					struct cxl_send_command __user *u)
+{
+	struct mbox_cmd mbox_cmd;
+	ssize_t payload_size;
+	void *payload;
+	u32 size_out;
+	int rc;
+
+	if (get_user(size_out, &u->size_out))
+		return -EFAULT;
+
+	payload_size = max_t(ssize_t, cmd->info.size_in, size_out);
+	if (payload_size) {
+		payload =
+			memdup_user(u64_to_user_ptr(u->payload), payload_size);
+		if (IS_ERR(payload))
+			return PTR_ERR(payload);
+	}
+
+	rc = cxl_mem_mbox_get(cxlmd->cxlm);
+	if (rc)
+		return rc;
+
+	mbox_cmd = (struct mbox_cmd){
+		.opcode = cmd->opcode,
+		.payload = payload,
+		.size_in = cmd->info.size_in,
+		.size_out = size_out,
+	};
+	rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlmd->cxlm);
+	if (rc)
+		goto out;
+
+	rc = put_user(mbox_cmd.return_code, &u->retval);
+	if (rc)
+		goto out;
+
+	rc = put_user(mbox_cmd.size_out, &u->size_out);
+	if (rc)
+		goto out;
+
+	if (mbox_cmd.size_out)
+		if (copy_to_user(u64_to_user_ptr(u->payload), payload,
+				 mbox_cmd.size_out))
+			rc = -EFAULT;
+
+out:
+	if (payload_size)
+		kfree(payload);
+	return rc;
+}
+
+/**
+ * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * @user_cmd: &struct cxl_send_command from userspace.
+ * @out_cmd: Sanitized and populared &struct cxl_mem_command.
+ *
+ * Return:
+ *  * %0	- Command dispatched successfully.
+ *  * %-EFAULT	- Something happened with copy_to/from_user.
+ *  * %-EINVAL	- Rerserved fields were used.
+ *  * %-EPERM	- Protected command used by the RAW interface.
+ *  * %-ENOMEM	- Input or output buffer wasn't large enough.
+ *
+ */
+static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
+				      struct cxl_mem_command *out_cmd)
+{
+	const struct cxl_command_info *info;
+	struct cxl_send_command cmd;
+	struct cxl_mem_command *c;
+
+	if (copy_from_user(&cmd, user_cmd, sizeof(cmd)))
+		return -EFAULT;
+
+	if (cmd.id == 0 || cmd.id >= CXL_MEM_COMMAND_ID_MAX)
+		return -EINVAL;
+
+	c = &mem_commands[cmd.id];
+	info = &c->info;
+
+	if (cmd.flags & CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (cmd.rsvd)
+		return -EINVAL;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != cmd.size_in)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && cmd.size_out < info->size_out)
+		return -ENOMEM;
+
+	memcpy(out_cmd, c, sizeof(*c));
+
+	return 0;
 }
 
 static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -357,6 +471,19 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 
 			j++;
 		}
+
+		return 0;
+	} else if (cmd == CXL_MEM_SEND_COMMAND) {
+		struct cxl_send_command __user *u = (void __user *)arg;
+		struct cxl_memdev *cxlmd = file->private_data;
+		struct cxl_mem_command c;
+		int rc;
+
+		rc = cxl_validate_cmd_from_user(u, &c);
+		if (rc)
+			return rc;
+
+		return handle_mailbox_cmd_from_user(cxlmd, &c, u);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 1d1e143f98ec..189d86a13637 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -19,6 +19,7 @@ extern "C" {
  */
 
 #define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR('C', 2, struct cxl_send_command)
 
 #define CXL_MEM_COMMAND_NAME_LENGTH 32
 
@@ -48,10 +49,12 @@ extern "C" {
 struct cxl_command_info {
 	__u32 id;
 #define CXL_MEM_COMMAND_ID_INVALID 0
+#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_INVALID + 1)
 
 	__u32 flags;
 #define CXL_MEM_COMMAND_FLAG_NONE 0
 #define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)
+#define CXL_MEM_COMMAND_FLAG_MASK ~BIT(0)
 
 	__s32 size_in;
 	__s32 size_out;
@@ -95,6 +98,38 @@ struct cxl_mem_query_commands {
 	struct cxl_command_info __user commands[]; /* out: supported commands */
 };
 
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command
+ * @rsvd: Reserved for future use.
+ * @retval: Return value from the memory device (output).
+ * @size_in: Size of the payload to provide to the device (input).
+ * @size_out: Size of the payload received from the device (input/output). This
+ *	      field is filled in my userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @payload: Pointer to memory available for payload input/output.
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes, but the payload input
+ * and output are not introspected. Userspace is required to allocate large
+ * enough buffers for max(size_in, size_out).
+ */
+struct cxl_send_command {
+	__u32 id;
+	__u32 flags;
+	__u32 rsvd;
+	__u32 retval;
+
+	struct {
+		__s32 size_in;
+		__s32 size_out;
+		__u64 payload;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.29.2

