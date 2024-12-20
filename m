Return-Path: <linux-pci+bounces-18885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F19F8F53
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912B31637B0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729181AF0BB;
	Fri, 20 Dec 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyI+KHRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFA1A7044
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688265; cv=none; b=syJcwX3sb5p6nansM+8OPzSsLnJyWpDJHDpnTldnJvsUKaFqXQWUa6LeLNXPI+qzSJFw83TdaMNOn7ViCJxZFuwFMjBu+9YtvVGIa6gkD92H4WeWhYAB550Bxf2xuLcmF+guLYXKBBOhldqdBTAGhRpEPO9/eDahLX+iPSyXM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688265; c=relaxed/simple;
	bh=hfqR2lpF92MTjmyWR3wu96FX6jTidXXMYSzZH1bARpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiEZiN12SMIXTpfHsmw67RdibFRZH+lbyWlbkfgfh1Lje4sCa8t9M3UmFCoJjXP9Zu40Bub5AbFEnBgmFIfrk/d0Zf3I21wU+pr3xUediwX+TGDOsc9/QCTS5Xrxq/o2PHg5MlybIgC98qGJJqenSD4w7zgQmEjvUOG2Oy75VKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyI+KHRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9730C4CED4;
	Fri, 20 Dec 2024 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688264;
	bh=hfqR2lpF92MTjmyWR3wu96FX6jTidXXMYSzZH1bARpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyI+KHRxcklJtWAgfvd536uxD48JyfGl3Qoc4ha15Kce+LQUKUXuThtCW+PkwsmS+
	 gD0wJjfIlGmeycp4ZwkWMIkZfWFYLuA0bwpkLtHdqDFaGk1Jb9JN4YVNyoX07T7Uol
	 cu5onkZs2YT8J3KSLJ89NoQQVM8Q5ZlAYmLjwLbxHQ1QB43Weji1i6NeRRDXpa1s6S
	 l858q0QUTKi79FYiByizLvspVTtkSzua7esWNJAxAQxV26t4dmRZr8HlHZapyARvxX
	 /JXb69hxhG83X5uN+Hbd6X32YW/5tjKU3Wm0Y5wriTD+O6L07UuVIEY/RmWQj+p+kQ
	 0IE0vxAe0PjMQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v7 10/18] nvmet: Add support for I/O queue management admin commands
Date: Fri, 20 Dec 2024 18:51:00 +0900
Message-ID: <20241220095108.601914-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The I/O submission queue management admin commands
(nvme_admin_delete_sq, nvme_admin_create_sq, nvme_admin_delete_cq,
and nvme_admin_create_cq) are mandatory admin commands for I/O
controllers using the PCI transport, that is, support for these commands
is mandatory for a a PCI target I/O controller.

Implement support for these commands by adding the functions
nvmet_execute_delete_sq(), nvmet_execute_create_sq(),
nvmet_execute_delete_cq() and nvmet_execute_create_cq() to set as the
execute method of requests for these commands. These functions will
return an invalid opcode error for any controller that is not a PCI
target controller. Support for the I/O queue management commands is also
reported in the command effect log  of PCI target controllers (using
nvmet_get_cmd_effects_admin()).

Each management command is backed by a controller fabric operation
that can be defined by a PCI target controller driver to setup I/O
queues using nvmet_sq_create() and nvmet_cq_create() or delete I/O
queues using nvmet_sq_destroy().

As noted in a comment in nvmet_execute_create_sq(), we do not yet
support sharing a single CQ between multiple SQs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 165 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |   8 ++
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6f7e5b0c91c7..c91864c185fc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -12,6 +12,142 @@
 #include <linux/unaligned.h>
 #include "nvmet.h"
 
+static void nvmet_execute_delete_sq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 sqid = le16_to_cpu(req->cmd->delete_queue.qid);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!sqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_sqid(ctrl, sqid, false);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	status = ctrl->ops->delete_sq(ctrl, sqid);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_create_sq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	u16 sqid = le16_to_cpu(cmd->create_sq.sqid);
+	u16 cqid = le16_to_cpu(cmd->create_sq.cqid);
+	u16 sq_flags = le16_to_cpu(cmd->create_sq.sq_flags);
+	u16 qsize = le16_to_cpu(cmd->create_sq.qsize);
+	u64 prp1 = le64_to_cpu(cmd->create_sq.prp1);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!sqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_sqid(ctrl, sqid, true);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	/*
+	 * Note: The NVMe specification allows multiple SQs to use the same CQ.
+	 * However, the target code does not really support that. So for now,
+	 * prevent this and fail the command if sqid and cqid are different.
+	 */
+	if (!cqid || cqid != sqid) {
+		pr_err("SQ %u: Unsupported CQID %u\n", sqid, cqid);
+		status = NVME_SC_CQ_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	if (!qsize || qsize > NVME_CAP_MQES(ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = ctrl->ops->create_sq(ctrl, sqid, sq_flags, qsize, prp1);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_delete_cq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 cqid = le16_to_cpu(req->cmd->delete_queue.qid);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!cqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_cqid(ctrl, cqid);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	status = ctrl->ops->delete_cq(ctrl, cqid);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_create_cq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	u16 cqid = le16_to_cpu(cmd->create_cq.cqid);
+	u16 cq_flags = le16_to_cpu(cmd->create_cq.cq_flags);
+	u16 qsize = le16_to_cpu(cmd->create_cq.qsize);
+	u16 irq_vector = le16_to_cpu(cmd->create_cq.irq_vector);
+	u64 prp1 = le64_to_cpu(cmd->create_cq.prp1);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!cqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_cqid(ctrl, cqid);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	if (!qsize || qsize > NVME_CAP_MQES(ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = ctrl->ops->create_cq(ctrl, cqid, cq_flags, qsize,
+				      prp1, irq_vector);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
@@ -230,8 +366,18 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_get_cmd_effects_admin(struct nvme_effects_log *log)
+static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
+					struct nvme_effects_log *log)
 {
+	/* For a PCI target controller, advertize support for the . */
+	if (nvmet_is_pci_ctrl(ctrl)) {
+		log->acs[nvme_admin_delete_sq] =
+		log->acs[nvme_admin_create_sq] =
+		log->acs[nvme_admin_delete_cq] =
+		log->acs[nvme_admin_create_cq] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
+
 	log->acs[nvme_admin_get_log_page] =
 	log->acs[nvme_admin_identify] =
 	log->acs[nvme_admin_abort_cmd] =
@@ -268,6 +414,7 @@ static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 
 static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_effects_log *log;
 	u16 status = NVME_SC_SUCCESS;
 
@@ -279,7 +426,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
-		nvmet_get_cmd_effects_admin(log);
+		nvmet_get_cmd_effects_admin(ctrl, log);
 		nvmet_get_cmd_effects_nvm(log);
 		break;
 	case NVME_CSI_ZNS:
@@ -287,7 +434,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 			status = NVME_SC_INVALID_IO_CMD_SET;
 			goto free;
 		}
-		nvmet_get_cmd_effects_admin(log);
+		nvmet_get_cmd_effects_admin(ctrl, log);
 		nvmet_get_cmd_effects_nvm(log);
 		nvmet_get_cmd_effects_zns(log);
 		break;
@@ -1335,9 +1482,21 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return nvmet_parse_passthru_admin_cmd(req);
 
 	switch (cmd->common.opcode) {
+	case nvme_admin_delete_sq:
+		req->execute = nvmet_execute_delete_sq;
+		return 0;
+	case nvme_admin_create_sq:
+		req->execute = nvmet_execute_create_sq;
+		return 0;
 	case nvme_admin_get_log_page:
 		req->execute = nvmet_execute_get_log_page;
 		return 0;
+	case nvme_admin_delete_cq:
+		req->execute = nvmet_execute_delete_cq;
+		return 0;
+	case nvme_admin_create_cq:
+		req->execute = nvmet_execute_create_cq;
+		return 0;
 	case nvme_admin_identify:
 		req->execute = nvmet_execute_identify;
 		return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5c8ed8f93918..86bb2852a63b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -408,6 +408,14 @@ struct nvmet_fabrics_ops {
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
 	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
+
+	/* Operations mandatory for PCI target controllers */
+	u16 (*create_sq)(struct nvmet_ctrl *ctrl, u16 sqid, u16 flags,
+			 u16 qsize, u64 prp1);
+	u16 (*delete_sq)(struct nvmet_ctrl *ctrl, u16 sqid);
+	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
+			 u16 qsize, u64 prp1, u16 irq_vector);
+	u16 (*delete_cq)(struct nvmet_ctrl *ctrl, u16 cqid);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.47.1


