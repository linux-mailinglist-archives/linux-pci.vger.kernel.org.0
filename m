Return-Path: <linux-pci+bounces-19036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978989FC429
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E19B1649A3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0A14A4D4;
	Wed, 25 Dec 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIZ+owuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE814A0BC
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115446; cv=none; b=PpYZOsVyMT2uP5Uzf4XW+xaomhYrGzutmFRnG9ZMQdeKzi48OoJYS/uXvRNeZVt4jkccUFFK302w7aqrjdY8ZXo4pgOsxKWO118K1Ix0BTNS7/D9y7Vfmq3EJH+fp1Ini7KIsqc/KaAgbJMX/r+sk5UdNv++uRk7yh34dvKn12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115446; c=relaxed/simple;
	bh=8lmFmnqNINhoMe/Otj8YE843UJwQh6qmYq2mCaJjmnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYzxbk3U/mjtXW3zwzz51W00NwGrCxunEA3+L79m/ncs4EaPpRDIrCmaqxcme3EDcpkoBG4fT1Kb/+Ub7KqGa/cEK8ON8Ag7u8dDyErCjc1q+RM5jtmIfO8nL27V5KRvqBJtOnnol0OvA2P78GRd3Ippxo+GgNIt+Iqmi2THTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIZ+owuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D09C4CED7;
	Wed, 25 Dec 2024 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115446;
	bh=8lmFmnqNINhoMe/Otj8YE843UJwQh6qmYq2mCaJjmnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIZ+owuVkNbLIrTvCGpkLEghyzEAYZVYOjDTClH9ZRqYoRsDVGTbJJQZLG+ZpoxvK
	 N05+hsIibmyfbxECgHv3xcuvmmyVftwz6OEwNpr7jW3sKamDOITtABKcSPCJTuss6O
	 4YeBjXSBcpRzBIs7P2oOjSV1nN4w9lfE44Jz728BcWNAId5Sayn59osWFkMVjxEpAY
	 kT0dsD7LAR8dFqGewG/mKQI9IFiZfIeZgbLgSOCyd6MkI3Bt3nAdUhlDvF96SJlr36
	 TEvHuru0lWM0PMX+Mg1+tz8fF/+9d8iCwrEcMVmhKmZUaVWMl/mLroPqou+bawee0N
	 rC8bAFnFm6umQ==
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
Subject: [PATCH v8 07/18] nvmet: Improve nvmet_alloc_ctrl() interface and implementation
Date: Wed, 25 Dec 2024 17:29:44 +0900
Message-ID: <20241225082956.96650-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct nvmet_alloc_ctrl_args to define the arguments for
the function nvmet_alloc_ctrl() to avoid the need for passing a pointer
to a struct nvmet_req as an argument. This new data structure aggregates
together the arguments that were passed to nvmet_alloc_ctrl()
(subsysnqn, hostnqn and kato), together with the struct nvmet_req fields
used by nvmet_alloc_ctrl(), that is, the fields port, p2p_client, and
ops as input and the result and error_loc fields as output, as well as a
status field. nvmet_alloc_ctrl() is also changed to return a pointer
to the allocated and initialized controller structure instead of a
status code, as the status is now returned through the status field of
struct nvmet_alloc_ctrl_args.

The function nvmet_setup_p2p_ns_map() is changed to not take a pointer
to a struct nvmet_req as argument, instead, directly specify the
p2p_client device pointer needed as argument.

The code in nvmet_execute_admin_connect() that initializes a new target
controller after allocating it is moved into nvmet_alloc_ctrl().
The code that sets up an admin queue for the controller (and the call
to nvmet_install_queue()) remains in nvmet_execute_admin_connect().

Finally, nvmet_alloc_ctrl() is also exported to allow target drivers to
use this function directly to allocate and initialize a new controller
structure without the need to rely on a fabrics connect command request.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/core.c        | 83 ++++++++++++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c | 58 ++++++++++-----------
 drivers/nvme/target/nvmet.h       | 18 +++++--
 3 files changed, 94 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4b5594549ae6..4909f3e5a552 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1350,15 +1350,15 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
  * Note: ctrl->subsys->lock should be held when calling this function
  */
 static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
-		struct nvmet_req *req)
+		struct device *p2p_client)
 {
 	struct nvmet_ns *ns;
 	unsigned long idx;
 
-	if (!req->p2p_client)
+	if (!p2p_client)
 		return;
 
-	ctrl->p2p_client = get_device(req->p2p_client);
+	ctrl->p2p_client = get_device(p2p_client);
 
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
@@ -1387,45 +1387,44 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
-		uuid_t *hostid)
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 {
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
+	u32 kato = args->kato;
+	u8 dhchap_status;
 	int ret;
-	u16 status;
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	args->status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
+	subsys = nvmet_find_get_subsys(args->port, args->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		goto out;
+			args->subsysnqn);
+		args->result = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		args->error_loc = offsetof(struct nvme_common_command, dptr);
+		return NULL;
 	}
 
 	down_read(&nvmet_config_sem);
-	if (!nvmet_host_allowed(subsys, hostnqn)) {
+	if (!nvmet_host_allowed(subsys, args->hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-			hostnqn, subsysnqn);
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
+			args->hostnqn, args->subsysnqn);
+		args->result = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
-		status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
-		req->error_loc = offsetof(struct nvme_common_command, dptr);
+		args->status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+		args->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
 
-	status = NVME_SC_INTERNAL;
+	args->status = NVME_SC_INTERNAL;
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
 
-	ctrl->port = req->port;
-	ctrl->ops = req->ops;
+	ctrl->port = args->port;
+	ctrl->ops = args->ops;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	/* By default, set loop targets to clear IDS by default */
@@ -1439,8 +1438,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
-	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
-	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->subsysnqn, args->subsysnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
@@ -1463,12 +1462,12 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
+		args->status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 		goto out_free_sqs;
 	}
 	ctrl->cntlid = ret;
 
-	uuid_copy(&ctrl->hostid, hostid);
+	uuid_copy(&ctrl->hostid, args->hostid);
 
 	/*
 	 * Discovery controllers may use some arbitrary high value
@@ -1490,12 +1489,35 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (ret)
 		goto init_pr_fail;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
-	nvmet_setup_p2p_ns_map(ctrl, req);
+	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
 
-	*ctrlp = ctrl;
-	return 0;
+	if (args->hostid)
+		uuid_copy(&ctrl->hostid, args->hostid);
+
+	dhchap_status = nvmet_setup_auth(ctrl);
+	if (dhchap_status) {
+		pr_err("Failed to setup authentication, dhchap status %u\n",
+		       dhchap_status);
+		nvmet_ctrl_put(ctrl);
+		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
+			args->status =
+				NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+		else
+			args->status = NVME_SC_INTERNAL;
+		return NULL;
+	}
+
+	args->status = NVME_SC_SUCCESS;
+
+	pr_info("Created %s controller %d for subsystem %s for NQN %s%s%s.\n",
+		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
+		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
+		ctrl->pi_support ? " T10-PI is enabled" : "",
+		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
+
+	return ctrl;
 
 init_pr_fail:
 	mutex_unlock(&subsys->lock);
@@ -1509,9 +1531,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	kfree(ctrl);
 out_put_subsystem:
 	nvmet_subsys_put(subsys);
-out:
-	return status;
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
 static void nvmet_ctrl_free(struct kref *ref)
 {
@@ -1547,6 +1569,7 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 {
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
+EXPORT_SYMBOL_GPL(nvmet_ctrl_put);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index c49904ebb6c2..8dbd7df8c9a0 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -213,73 +213,67 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
-	u16 status;
-	u8 dhchap_status;
+	struct nvmet_alloc_ctrl_args args = {
+		.port = req->port,
+		.ops = req->ops,
+		.p2p_client = req->p2p_client,
+		.kato = le32_to_cpu(c->kato),
+	};
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
-		status = NVME_SC_INTERNAL;
+		args.status = NVME_SC_INTERNAL;
 		goto complete;
 	}
 
-	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
-	if (status)
+	args.status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (args.status)
 		goto out;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-		req->error_loc = offsetof(struct nvmf_connect_command, recfmt);
-		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
+		args.error_loc = offsetof(struct nvmf_connect_command, recfmt);
+		args.status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(d->cntlid != cpu_to_le16(0xffff))) {
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
+		args.status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
+		args.result = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
 
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
-	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
-				  le32_to_cpu(c->kato), &ctrl, &d->hostid);
-	if (status)
-		goto out;
 
-	dhchap_status = nvmet_setup_auth(ctrl);
-	if (dhchap_status) {
-		pr_err("Failed to setup authentication, dhchap status %u\n",
-		       dhchap_status);
-		nvmet_ctrl_put(ctrl);
-		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
-			status = (NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR);
-		else
-			status = NVME_SC_INTERNAL;
+	args.subsysnqn = d->subsysnqn;
+	args.hostnqn = d->hostnqn;
+	args.hostid = &d->hostid;
+	args.kato = c->kato;
+
+	ctrl = nvmet_alloc_ctrl(&args);
+	if (!ctrl)
 		goto out;
-	}
 
-	status = nvmet_install_queue(ctrl, req);
-	if (status) {
+	args.status = nvmet_install_queue(ctrl, req);
+	if (args.status) {
 		nvmet_ctrl_put(ctrl);
 		goto out;
 	}
 
-	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s.\n",
-		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
-		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
-		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
 out:
 	kfree(d);
 complete:
-	nvmet_req_complete(req, status);
+	req->error_loc = args.error_loc;
+	req->cqe->result.u32 = args.result;
+	nvmet_req_complete(req, args.status);
 }
 
 static void nvmet_execute_io_connect(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4dad413e5fef..ed7e8cd890e4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -549,9 +549,21 @@ int nvmet_sq_init(struct nvmet_sq *sq);
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
-		uuid_t *hostid);
+
+struct nvmet_alloc_ctrl_args {
+	struct nvmet_port	*port;
+	char			*subsysnqn;
+	char			*hostnqn;
+	uuid_t			*hostid;
+	const struct nvmet_fabrics_ops *ops;
+	struct device		*p2p_client;
+	u32			kato;
+	u32			result;
+	u16			error_loc;
+	u16			status;
+};
+
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
-- 
2.47.1


