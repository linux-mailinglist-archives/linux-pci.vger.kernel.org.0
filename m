Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618812F23B7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbhALAZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:11217 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390810AbhAKWw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:58 -0500
IronPort-SDR: hEaZWTcPoZmMeWIp7GqKmB7N1TR0Qgx4x+IdHzhofd2FRAEuUjKTVI/jGOhsjNxj1yL7CcOblb
 9iRa9o2lr6NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726545"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726545"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:39 -0800
IronPort-SDR: QJNbhPeeZybgP0fOpn6snQDzRclcrCcv34peKBzxrBaTfGFJsBTyCh5BIBJuFFuejwqqiiwOFu
 2jjYxL2uw9QQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778026"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:37 -0800
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
Subject: [RFC PATCH v3 10/16] cxl/mem: Add send command
Date:   Mon, 11 Jan 2021 14:51:14 -0800
Message-Id: <20210111225121.820014-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The send command allows userspace to issue mailbox commands directly to
the hardware. The driver will verify basic properties of the command and
possible inspect the input (or output) payload to determine whether or
not the command is allowed (or might taint the kernel).

The list of allowed commands and their properties can be determined by
using the QUERY IOCTL for CXL memory devices.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 204 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h |  39 +++++++
 2 files changed, 239 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d4eb3f5b9469..f979788b4d9f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -84,6 +84,13 @@ static DEFINE_IDR(cxl_mem_idr);
 /* protect cxl_mem_idr allocations */
 static DEFINE_MUTEX(cxl_memdev_lock);
 
+#undef C
+#define C(a, b) { b }
+static struct {
+	const char *name;
+} command_names[] = { CMDS };
+#undef C
+
 #define CXL_CMD(_id, _flags, sin, sout, f)                                     \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 		{                                                              \
@@ -319,16 +326,25 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 /**
  * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
  * @cxlm: The memory device to gain access to.
+ * @interruptible: Allow interrupting mutex acquisition.
  *
  * Context: Any context. Takes the mbox_lock.
  * Return: 0 if exclusive access was acquired.
  */
-static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
+static int cxl_mem_mbox_get(struct cxl_mem *cxlm, bool interruptible)
 {
 	u64 md_status;
-	int rc = -EBUSY;
+	int rc;
+
+	if (interruptible) {
+		rc = mutex_lock_interruptible(&cxlm->mbox.mutex);
+		if (rc)
+			return rc;
+	} else {
+		mutex_lock_io(&cxlm->mbox.mutex);
+	}
 
-	mutex_lock_io(&cxlm->mbox.mutex);
+	rc = -EBUSY;
 
 	/*
 	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
@@ -443,6 +459,155 @@ static int cxl_mem_count_commands(void)
 	}
 
 	return n;
+};
+
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
+ * @cxlmd: The CXL memory device to communicate with.
+ * @cmd: The validated command.
+ * @in_payload: Pointer to userspace's input payload.
+ * @out_payload: Pointer to userspace's output payload.
+ * @u: The command submitted by userspace. Has output fields.
+ *
+ * Return:
+ *  * %0	- Mailbox transaction succeeded.
+ *  * %-EFAULT	- Something happened with copy_to/from_user.
+ *  * %-EINTR	- Mailbox acquisition interrupted.
+ *  * %-E2BIG   - Output payload would overrun buffer.
+ *
+ * Creates the appropriate mailbox command on behalf of a userspace request.
+ * Return value, size, and output payload are all copied out to @u. The
+ * parameters for the command must be validated before calling this function.
+ *
+ * A 0 return code indicates the command executed successfully, not that it was
+ * itself successful. IOW, the retval should always be checked if wanting to
+ * determine the actual result.
+ */
+static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
+					const struct cxl_mem_command *cmd,
+					u64 in_payload,
+					u64 out_payload,
+					struct cxl_send_command __user *u)
+{
+	struct mbox_cmd mbox_cmd = {
+		.opcode = cmd->opcode,
+		.size_in = cmd->info.size_in,
+		.payload = NULL, /* Copied by copy_to|from_user() */
+	};
+	int rc;
+
+	if (cmd->info.size_in) {
+		/*
+		 * Directly copy the userspace payload into the hardware. UAPI
+		 * states that the buffer must already be little endian.
+		 */
+		if (copy_from_user((__force void *)cxl_payload_regs(cxlmd->cxlm),
+				   u64_to_user_ptr(in_payload),
+				   cmd->info.size_in)) {
+			cxl_mem_mbox_put(cxlmd->cxlm);
+			return -EFAULT;
+		}
+	}
+
+	rc = cxl_mem_mbox_get(cxlmd->cxlm, true);
+	if (rc)
+		return rc;
+
+	dev_dbg(&cxlmd->dev,
+		"Submitting %s command for user\n"
+		"\topcode: %x\n"
+		"\tsize: %ub\n",
+		command_names[cmd->info.id].name, mbox_cmd.opcode,
+		cmd->info.size_in);
+
+	rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlmd->cxlm);
+	if (rc)
+		return rc;
+
+	if (mbox_cmd.size_out > cmd->info.size_out)
+		return -E2BIG;
+
+	rc = put_user(mbox_cmd.return_code, &u->retval);
+	if (rc)
+		return rc;
+
+	rc = put_user(mbox_cmd.size_out, &u->size_out);
+	if (rc)
+		return rc;
+
+	if (mbox_cmd.size_out)
+		if (copy_to_user(u64_to_user_ptr(out_payload),
+				 (__force void *)cxl_payload_regs(cxlmd->cxlm),
+				 mbox_cmd.size_out))
+			return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * @cxlm: &struct cxl_mem device whose mailbox will be used.
+ * @send_cmd: &struct cxl_send_command copied in from userspace.
+ * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ *
+ * Return:
+ *  * %0	- @out_cmd is ready to send.
+ *  * %-ENOTTY	- Invalid command specified.
+ *  * %-EINVAL	- Reserved fields or invalid values were used.
+ *  * %-EPERM	- Attempted to use a protected command.
+ *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
+ *
+ * The result of this command is a fully validated command in @out_cmd that is
+ * safe to send to the hardware.
+ *
+ * See handle_mailbox_cmd_from_user()
+ */
+static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
+				      const struct cxl_send_command *send_cmd,
+				      struct cxl_mem_command *out_cmd)
+{
+	const struct cxl_command_info *info;
+	struct cxl_mem_command *c;
+
+	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
+		return -ENOTTY;
+
+	/*
+	 * The user can never specify an input payload larger than our hardware
+	 * supports, but output can be arbitrarily large, we simply write out as
+	 * much data as the hardware provides.
+	 */
+	if (send_cmd->size_in > cxlm->mbox.payload_size)
+		return -EINVAL;
+
+	if (send_cmd->flags & CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
+		return -EINVAL;
+
+	/* Convert user's command into the internal representation */
+	c = &mem_commands[send_cmd->id];
+	info = &c->info;
+
+	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
+		return -EPERM;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != send_cmd->size_in)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->size_out < info->size_out)
+		return -ENOMEM;
+
+	/* Setting a few const fields here... */
+	memcpy(out_cmd, c, sizeof(*c));
+	*(s32 *)&out_cmd->info.size_in = send_cmd->size_in;
+	*(s32 *)&out_cmd->info.size_out = send_cmd->size_out;
+
+	return 0;
 }
 
 static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -479,6 +644,37 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 			if (j == n_commands)
 				break;
 		}
+
+		return 0;
+	} else if (cmd == CXL_MEM_SEND_COMMAND) {
+		struct cxl_send_command send, __user *u = (void __user *)arg;
+		struct cxl_mem_command c;
+		int rc;
+
+		dev_dbg(dev, "Send IOCTL\n");
+
+		if (copy_from_user(&send, u, sizeof(send)))
+			return -EFAULT;
+
+		rc = device_lock_interruptible(dev);
+		if (rc)
+			return rc;
+
+		if (!get_live_device(dev)) {
+			device_unlock(dev);
+			return -ENXIO;
+		}
+
+		rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
+		if (!rc)
+			rc = handle_mailbox_cmd_from_user(cxlmd, &c,
+							  send.in_payload,
+							  send.out_payload, u);
+
+		put_device(dev);
+		device_unlock(dev);
+
+		return rc;
 	}
 
 	return -ENOTTY;
@@ -837,7 +1033,7 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	int rc;
 
 	/* Retrieve initial device memory map */
-	rc = cxl_mem_mbox_get(cxlm);
+	rc = cxl_mem_mbox_get(cxlm, false);
 	if (rc)
 		return rc;
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 847f825bbe18..cb4e2bee5228 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -26,6 +26,7 @@ extern "C" {
  */
 
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
 
 #undef CMDS
 #define CMDS                                                                   \
@@ -69,6 +70,7 @@ struct cxl_command_info {
 #define CXL_MEM_COMMAND_FLAG_NONE 0
 #define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
 #define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(31, 2)
 
 	__s32 size_in;
 	__s32 size_out;
@@ -110,6 +112,43 @@ struct cxl_mem_query_commands {
 	struct cxl_command_info __user commands[]; /* out: supported commands */
 };
 
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @size_in: Size of the payload to provide to the device (input).
+ * @size_out: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @in_payload: Pointer to memory for payload input (little endian order).
+ * @out_payload: Pointer to memory for payload output (little endian order).
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
+		__u64 in_payload;
+	};
+
+	struct {
+		__s32 size_out;
+		__u64 out_payload;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.30.0

