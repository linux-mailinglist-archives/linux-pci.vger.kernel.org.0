Return-Path: <linux-pci+bounces-18006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E929EAC79
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3579188B392
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55228223335;
	Tue, 10 Dec 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSnfk5Wi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC4223331
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823295; cv=none; b=UElcTDaWTVir3mOc0JilqqYgichArrFx0effiVzYlKH9qoNZxQcywAw12AAXcI2zM1NdcHayJauwOBLbjwp8Bhrn2F6gWeugoT0CGHtGYDte7RheQl+oB3czDDf0ubrQm5LsCoI4f0KChzpf+S9q+cbTYPx7q0uMildACYD+lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823295; c=relaxed/simple;
	bh=heTPMOMl5mYWVpDpgTy+nBLbiNdKAt9ZXGmkNYM2BwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pyr4XtdVH8CISJeVD2d6iNYl7mWkkIeGm13Ig2rHutYiKs+iBg9SwVtmo13vs7Ppm8NKerYSlAIMXqMyd4mbRfz/eY3w32sxdGOjf6IJ5IGBvRaxOhh9IQAVPgqT7OhlIKvY7OqsGoRhYKUUhVmiW/5zaqXNKpOv4Db8NPPY7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSnfk5Wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA9C4CEE1;
	Tue, 10 Dec 2024 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823294;
	bh=heTPMOMl5mYWVpDpgTy+nBLbiNdKAt9ZXGmkNYM2BwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSnfk5WiccYORUX9elGFexlSmV/RhFjMwZ8SILr9ogypSu7Pt3yudwwkIpcVYgDmQ
	 0Zy0r6Z0ddC5dxXjvOmcMYvXCMe7u3Y5dl8DRRBL75fUL2q4BUwc/krkvZbpSWzEXE
	 virBsFkKDUzq/R/WEYclme0BRsSvD9dVo1sx7FU4VzpXQOmvGLvCnjtcSVd2SEg4rO
	 RFNEj02tHTrYt2L//bnqcFUZiGCVq2ENQqPtN9k4f7Kvxl2ZoN0jlD6N37EJ8eiY0F
	 p+GfPSlCwtL4zz91J5p8eKmKO/M/ymNfQTYjRocNcnlQ+WrnjmMKUfVLljO/rll9aJ
	 2WVlXwxufxsbQ==
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
Subject: [PATCH v3 08/17] nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
Date: Tue, 10 Dec 2024 18:33:59 +0900
Message-ID: <20241210093408.105867-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the new functions nvmet_sq_create() and nvmet_cq_create() to
allow a target driver to initialize and setup admin and IO queues
directly, without needing to execute connect fabrics commands.
The helper functions nvmet_check_cqid() and nvmet_check_sqid() are
implemented to check the correctness of SQ and CQ IDs when
nvmet_sq_create() and nvmet_cq_create() are called.

nvmet_sq_create() and nvmet_cq_create() are primarily intended for use
with PCI target controller drivers and thus are not well integrated
with the current queue creation of fabrics controllers using the connect
command. These fabrices drivers are not modified to use these functions.
This simple implementation of SQ and CQ management for PCI target
controller drivers does not allow multiple SQs to share the same CQ,
similarly to other fabrics transports. This is a specification
violation. A more involved set of changes will follow to add support for
this required completion queue sharing feature.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/core.c  | 83 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  6 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9bca3e576893..3a92e3a81b46 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -818,6 +818,89 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 	complete(&sq->confirm_done);
 }
 
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
+{
+	if (!ctrl->sqs)
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	if (cqid > ctrl->subsys->max_qid)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	/*
+	 * Note: For PCI controllers, the NVMe specifications allows multiple
+	 * SQs to share a single CQ. However, we do not support this yet, so
+	 * check that there is no SQ defined for a CQ. If one exist, then the
+	 * CQ ID is invalid for creation as well as when the CQ is being
+	 * deleted (as that would mean that the SQ was not deleted before the
+	 * CQ).
+	 */
+	if (ctrl->sqs[cqid])
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	return NVME_SC_SUCCESS;
+}
+
+u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
+		    u16 qid, u16 size)
+{
+	u16 status;
+
+	status = nvmet_check_cqid(ctrl, qid);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_cq_setup(ctrl, cq, qid, size);
+
+	return NVME_SC_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_create);
+
+u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid,
+		     bool create)
+{
+	if (!ctrl->sqs)
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	if (sqid > ctrl->subsys->max_qid)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	if ((create && ctrl->sqs[sqid]) ||
+	    (!create && !ctrl->sqs[sqid]))
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	return NVME_SC_SUCCESS;
+}
+
+u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+		    u16 sqid, u16 size)
+{
+	u16 status;
+	int ret;
+
+	if (!kref_get_unless_zero(&ctrl->ref))
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	status = nvmet_check_sqid(ctrl, sqid, true);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	ret = nvmet_sq_init(sq);
+	if (ret) {
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		goto ctrl_put;
+	}
+
+	nvmet_sq_setup(ctrl, sq, sqid, size);
+	sq->ctrl = ctrl;
+
+	return NVME_SC_SUCCESS;
+
+ctrl_put:
+	nvmet_ctrl_put(ctrl);
+	return status;
+}
+EXPORT_SYMBOL_GPL(nvmet_sq_create);
+
 void nvmet_sq_destroy(struct nvmet_sq *sq)
 {
 	struct nvmet_ctrl *ctrl = sq->ctrl;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 96c4c2489be7..5c8ed8f93918 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -545,10 +545,16 @@ void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
+u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
+		u16 size);
+u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid, bool create);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 		u16 size);
+u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
+		u16 size);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
-- 
2.47.1


