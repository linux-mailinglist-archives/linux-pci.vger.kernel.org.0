Return-Path: <linux-pci+bounces-19043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C79FC42E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5007C164B9F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027F154425;
	Wed, 25 Dec 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nebINO54"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE67153BC1
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115459; cv=none; b=G1lpj3yiGdQkJIh0bIHjqK7mrLfGR1Fggqnhba8nEYqF4HEK12vO8VvLB384xpFRK29y5fOtwuXKgK5SDpDkO4dXYwnb4XEXdrFOvDG8SoPYWdAOOdgeW6yhtZ+yTk3oW/A6FM9UTQ2IY1Z8GRXf3AnG3twuFyPmYNKK8RdYjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115459; c=relaxed/simple;
	bh=6KGBMBW/kBM1QJf4FWHCu4JDI0qVY9pDSSUIY5LqHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL3WGn4WcHfjItKDf0CwkSYwQyM7N7lJEJaPZ/JkosbAgojUReXZnDCEI3S9hZ/dRIEKrLBq910OP+9vG6EPoltkq+lrc0DqnxZH02yb6F87omhVXP0oFoNZ23CRFxG/7NS2dv5pzZu/wlLbBo6SiFvExyBnqwu3RoNs9Z/svGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nebINO54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA493C4CED6;
	Wed, 25 Dec 2024 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115458;
	bh=6KGBMBW/kBM1QJf4FWHCu4JDI0qVY9pDSSUIY5LqHPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nebINO54ZGRd4nxE8ptRdCvb1beiCscjimTaSU4zPY9RMY/OnhxZDGy3ussGz2hXF
	 +ogYpQTvqkiaaQePy9qUxQT2OeE9gvXJgk8eE/9faPS6DFWSz+7CuBJJrJs9oO4/iy
	 cOBJVRZs8+UN4bMZQIrsV/rDqrGsih81Mm20pzjUfm/F4jznMpORoz69n9R0DXVI+B
	 LV3/0jeYYLlfnh6pE7AHxK8t3SnjwIPGkA28ipwGU93y9dPTzmVtR6eoSyHzgUwIhT
	 XE34ezOOYofEhWYhOwTQiaRWbD+Nkv8mXMI+yYfLmoJcdPqDUW5Gb0I9mC1gO3UMwB
	 V+5aCCBuhNmCA==
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
Subject: [PATCH v8 14/18] nvmet: Implement interrupt coalescing feature support
Date: Wed, 25 Dec 2024 17:29:51 +0900
Message-ID: <20241225082956.96650-15-dlemoal@kernel.org>
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

The NVMe base specifications v2.1 mandate Supporting the interrupt
coalescing feature (NVME_FEAT_IRQ_COALESCE) for PCI controllers.
Introduce the data structure struct nvmet_feat_irq_coalesce to define
the time and threshold (thr) fields of this feature and implement the
functions nvmet_get_feat_irq_coalesce() and
nvmet_set_feat_irq_coalesce() to get and set this feature. These
functions respectively use the controller get_feature() and
set_feature() operations to fill and handle the fields of struct
nvmet_feat_irq_coalesce.

While the Linux kernel nvme driver does not use this feature and thus
will not complain if it is not implemented, other major OSes fail
initializing the NVMe device if this feature support is missing.

Support for this feature is prohibited for fabrics controllers. If a get
feature or set feature command for this feature is received for a
fabrics controller, the command is failed with an invalid field error.

Suggested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     | 10 +++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index efef3acba9fb..eff9fd2e81ed 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1282,6 +1282,27 @@ static u16 nvmet_set_feat_host_id(struct nvmet_req *req)
 				   sizeof(req->sq->ctrl->hostid));
 }
 
+static u16 nvmet_set_feat_irq_coalesce(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_irq_coalesce irqc = {
+		.time = (cdw11 >> 8) & 0xff,
+		.thr = cdw11 & 0xff,
+	};
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1305,6 +1326,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		nvmet_set_result(req,
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
+	case NVME_FEAT_IRQ_COALESCE:
+		status = nvmet_set_feat_irq_coalesce(req);
+		break;
 	case NVME_FEAT_KATO:
 		status = nvmet_set_feat_kato(req);
 		break;
@@ -1349,6 +1373,30 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	return 0;
 }
 
+static u16 nvmet_get_feat_irq_coalesce(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_feat_irq_coalesce irqc = { };
+	u16 status;
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req, ((u32)irqc.time << 8) | (u32)irqc.thr);
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1383,13 +1431,14 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_ERR_RECOVERY:
 		break;
-	case NVME_FEAT_IRQ_COALESCE:
-		break;
 	case NVME_FEAT_IRQ_CONFIG:
 		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
+	case NVME_FEAT_IRQ_COALESCE:
+		status = nvmet_get_feat_irq_coalesce(req);
+		break;
 	case NVME_FEAT_ASYNC_EVENT:
 		nvmet_get_feat_async_event(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8325de3382ee..555c09b11dbe 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -906,4 +906,14 @@ static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
 {
 	percpu_ref_put(&pc_ref->ref);
 }
+
+/*
+ * Data for the get_feature() and set_feature() operations of PCI target
+ * controllers.
+ */
+struct nvmet_feat_irq_coalesce {
+	u8		thr;
+	u8		time;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


