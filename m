Return-Path: <linux-pci+bounces-18839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1369F8AC6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A709188C7C6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C8186321;
	Fri, 20 Dec 2024 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ModiQuv+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7B2594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666879; cv=none; b=IHzFU7lhbRYCjcvDkSE3dUgfK6hMS3l8lhu559NBFeKvTq3swlhgMzTPAG3Hk4X9NAXi6BQAgBYYxLCQfb20LMy1RHak8FKi9ZYIwwl+zma+6u46cRE/bEIcuYbtzUztwdqXxUMIl7Va5MGpW8BHlKt4NzJq4vFKbb5RpIkAEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666879; c=relaxed/simple;
	bh=hfqR2lpF92MTjmyWR3wu96FX6jTidXXMYSzZH1bARpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnJYa0odm8kenE6U1u3oRtrsNXKCHTKU0Kp9IJM/MRnDpb+regJ9ZNe/lwTnW2rQ25Qb/+doi23ZvRu05SEI1DNj5TkXaVx+By+9YpwkV3ls/sCGvZ+R5mh4U3uDNxNa01xoAoMJq+/sqydOy8mtdBf4SHGxFA0UUq/F19awm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ModiQuv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDECC4CED7;
	Fri, 20 Dec 2024 03:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666879;
	bh=hfqR2lpF92MTjmyWR3wu96FX6jTidXXMYSzZH1bARpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ModiQuv+vitrSX4LVIaSX0YLcnpG9kaRQ+f8rKbbnQlpYCa5fupB/AH2t6/5Wxnsm
	 936kqnNHNd5xBBWR3U9/2J1xY/VdEaoMCQmIrORxwnqM8uj6TjE5MlknjGL96Nk4vc
	 +J2t9OCgTQjGZqlanNxCy6+Gb/315gRsfNDQ/+chOkVsvYpApcp+Qy+vccnrjUeZch
	 n/KUUBv8zyf4VQ1GKkPHBHUEzfP/40B6lmGgxddKNH7HmKm1UTR/UJTV+T+tGFvwSk
	 Xul7mrUxstlbmC38xd2goRfYUjTKHsYd+6bSKzvF3MkBkrTTgByuOKFRwt00MLfrB3
	 Im2yQEkZi+HRg==
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
Subject: [PATCH v6 10/18] nvmet: Add support for I/O queue management admin commands
Date: Fri, 20 Dec 2024 12:54:33 +0900
Message-ID: <20241220035441.600193-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
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


