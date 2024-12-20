Return-Path: <linux-pci+bounces-18837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D79F8AC0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D517A2EC2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D47081B;
	Fri, 20 Dec 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtucCZ9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5D2594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666875; cv=none; b=r2vUrHgFsD+rheRMcf4oKGUZae/NsKRRgXJmwv7ZZro/5DgCYtREZRK3MsFux1qmltIPLktmkufpj0Gj09mB5w7S18uDAshIhJe0EyaIxAavIu7HCPQIB460l+aacvLLs7Cr1E8dYQLHgyNeRcmar5mKl030SUJbZvcQJQBs2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666875; c=relaxed/simple;
	bh=RbSbpuUHiOaEMoHE31oK6+ZAGIrS+FuUhydC9FsPypw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ooi4UHdZKV7UjOXWwb5uK4ucuWKHPLdFeLuUmy95pOFZwLcSf7FJ3jHTr4LaPILySRbL06HCBOWAjjUoD0n9PG77CcE3KoV0ry38plSmBavgCcNG5iOeDL64yh2PYiZwquvPmXKXjyqrZP8UFXOr7ZuSfgWyW1tCFnuVNign7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtucCZ9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB04FC4CECD;
	Fri, 20 Dec 2024 03:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666874;
	bh=RbSbpuUHiOaEMoHE31oK6+ZAGIrS+FuUhydC9FsPypw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtucCZ9EXHB6alMPSZtEE4fBeUZvisjk/k0QTMZVE7A/e5cr3WhKlfVk82/4HLa3G
	 v0GwHdE6/O4hM8+3eJKDd9YfhOnD2+K81Ev0L7hgG/uIGJan2IoFU1vbkK8izdh3LO
	 SrvtrsjmOixWXx/UFTUht21etfmqgn0EPUut43dEpetIAvCTx0hzYEW/PGbg6zRwt4
	 nohCnNifACk1q+Q0ZtUEcextras42fI6txOmxdaMtM6K5yX03wtxiP37AO7rik+7FX
	 ef6pCjaZV8NHK5OViM14oWNEkezZSq23EkstNt+gG6U+3fmOp+BYg3FOz5yVD09fDB
	 SAjq+30eXy7uw==
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
Subject: [PATCH v6 08/18] nvmet: Introduce nvmet_req_transfer_len()
Date: Fri, 20 Dec 2024 12:54:31 +0900
Message-ID: <20241220035441.600193-9-dlemoal@kernel.org>
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

Add the new function nvmet_req_transfer_len() to parse a request command
to extract the transfer length of the command. This function
implementation relies on multiple helper functions for parsing I/O
commands (nvmet_io_cmd_transfer_len()), admin commands
(nvmet_admin_cmd_data_len()) and fabrics connect commands
(nvmet_connect_cmd_data_len).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c        | 21 +++++++++++++
 drivers/nvme/target/core.c             | 37 ++++++++++++++++++++++
 drivers/nvme/target/discovery.c        | 14 +++++++++
 drivers/nvme/target/fabrics-cmd-auth.c | 14 +++++++--
 drivers/nvme/target/fabrics-cmd.c      | 43 ++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h            |  8 +++++
 6 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 78478a4a2e4d..6f7e5b0c91c7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1296,6 +1296,27 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	if (nvme_is_fabrics(cmd))
+		return nvmet_fabrics_admin_cmd_data_len(req);
+	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
+		return nvmet_discovery_cmd_data_len(req);
+
+	switch (cmd->common.opcode) {
+	case nvme_admin_get_log_page:
+		return nvmet_get_log_page_len(cmd);
+	case nvme_admin_identify:
+		return NVME_IDENTIFY_DATA_SIZE;
+	case nvme_admin_get_features:
+		return nvmet_feat_data_len(req, le32_to_cpu(cmd->common.cdw10));
+	default:
+		return 0;
+	}
+}
+
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4909f3e5a552..9bca3e576893 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -911,6 +911,33 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 	return 0;
 }
 
+static u32 nvmet_io_cmd_transfer_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+	u32 metadata_len = 0;
+
+	if (nvme_is_fabrics(cmd))
+		return nvmet_fabrics_io_cmd_data_len(req);
+
+	if (!req->ns)
+		return 0;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_zone_append:
+		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns))
+			metadata_len = nvmet_rw_metadata_len(req);
+		return nvmet_rw_data_len(req) + metadata_len;
+	case nvme_cmd_dsm:
+		return nvmet_dsm_len(req);
+	case nvme_cmd_zone_mgmt_recv:
+		return (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	default:
+		return 0;
+	}
+}
+
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -1059,6 +1086,16 @@ void nvmet_req_uninit(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
+size_t nvmet_req_transfer_len(struct nvmet_req *req)
+{
+	if (likely(req->sq->qid != 0))
+		return nvmet_io_cmd_transfer_len(req);
+	if (unlikely(!req->sq->ctrl))
+		return nvmet_connect_cmd_data_len(req);
+	return nvmet_admin_cmd_data_len(req);
+}
+EXPORT_SYMBOL_GPL(nvmet_req_transfer_len);
+
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
 	if (unlikely(len != req->transfer_len)) {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7a13f8e8d33d..df7207640506 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -355,6 +355,20 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	nvmet_req_complete(req, stat);
 }
 
+u32 nvmet_discovery_cmd_data_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_admin_get_log_page:
+		return nvmet_get_log_page_len(req->cmd);
+	case nvme_admin_identify:
+		return NVME_IDENTIFY_DATA_SIZE;
+	default:
+		return 0;
+	}
+}
+
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 3f2857c17d95..2022757f08dc 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -179,6 +179,11 @@ static u8 nvmet_auth_failure2(void *d)
 	return data->rescode_exp;
 }
 
+u32 nvmet_auth_send_data_len(struct nvmet_req *req)
+{
+	return le32_to_cpu(req->cmd->auth_send.tl);
+}
+
 void nvmet_execute_auth_send(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -206,7 +211,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			offsetof(struct nvmf_auth_send_command, spsp1);
 		goto done;
 	}
-	tl = le32_to_cpu(req->cmd->auth_send.tl);
+	tl = nvmet_auth_send_data_len(req);
 	if (!tl) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -429,6 +434,11 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 	data->rescode_exp = req->sq->dhchap_status;
 }
 
+u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
+{
+	return le32_to_cpu(req->cmd->auth_receive.al);
+}
+
 void nvmet_execute_auth_receive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -454,7 +464,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 			offsetof(struct nvmf_auth_receive_command, spsp1);
 		goto done;
 	}
-	al = le32_to_cpu(req->cmd->auth_receive.al);
+	al = nvmet_auth_receive_data_len(req);
 	if (!al) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 8dbd7df8c9a0..a7ff05b3be29 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -85,6 +85,22 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+u32 nvmet_fabrics_admin_cmd_data_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->fabrics.fctype) {
+#ifdef CONFIG_NVME_TARGET_AUTH
+	case nvme_fabrics_type_auth_send:
+		return nvmet_auth_send_data_len(req);
+	case nvme_fabrics_type_auth_receive:
+		return nvmet_auth_receive_data_len(req);
+#endif
+	default:
+		return 0;
+	}
+}
+
 u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -114,6 +130,22 @@ u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req)
 	return 0;
 }
 
+u32 nvmet_fabrics_io_cmd_data_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->fabrics.fctype) {
+#ifdef CONFIG_NVME_TARGET_AUTH
+	case nvme_fabrics_type_auth_send:
+		return nvmet_auth_send_data_len(req);
+	case nvme_fabrics_type_auth_receive:
+		return nvmet_auth_receive_data_len(req);
+#endif
+	default:
+		return 0;
+	}
+}
+
 u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -337,6 +369,17 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	goto out;
 }
 
+u32 nvmet_connect_cmd_data_len(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	if (!nvme_is_fabrics(cmd) ||
+	    cmd->fabrics.fctype != nvme_fabrics_type_connect)
+		return 0;
+
+	return sizeof(struct nvmf_connect_data);
+}
+
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ed7e8cd890e4..96c4c2489be7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -517,18 +517,24 @@ void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
 void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
+u32 nvmet_connect_cmd_data_len(struct nvmet_req *req);
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
+u32 nvmet_admin_cmd_data_len(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
+u32 nvmet_discovery_cmd_data_len(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req);
+u32 nvmet_fabrics_admin_cmd_data_len(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req);
+u32 nvmet_fabrics_io_cmd_data_len(struct nvmet_req *req);
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
+size_t nvmet_req_transfer_len(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
@@ -822,7 +828,9 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 }
 
 #ifdef CONFIG_NVME_TARGET_AUTH
+u32 nvmet_auth_send_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_send(struct nvmet_req *req);
+u32 nvmet_auth_receive_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
-- 
2.47.1


