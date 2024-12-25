Return-Path: <linux-pci+bounces-19038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379579FC42A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47C3164B37
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B214D29D;
	Wed, 25 Dec 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMWDPp7D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA414A0BC
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115450; cv=none; b=bCi/1QTkQ3PFVP4VOOTrGyYipi3laPV5amJZF2srDlbV9RPIWbeil6X0nL96eZFPkHr6Qf//lCW7zn2IY828uA98x+o7b7EaeIMA0gOo5Sm+Akf6IhAxG5EkvKf2IguVyynBfbKUNb+FIotzHEniaNyJGl0MJ/QpM4w4d1lw0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115450; c=relaxed/simple;
	bh=2We+EatIdKvbBlcc+Qi+TDU+sQlvK0gyzoE4dj3NfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlYdzI3xB2PGZAte5UE0MT3BT+pO7FgSGFQedTCpiBkLRsudlAI2fGEKUz3/piQbHKDS9UcFi0HutUK/Uqzxyt6sJ436RzITkSz52Wi9SGnUb3ObBlf2hPEcmwCuEnIQd1qoVLndoHSQSV0a2oEoQ9lvoupi5B/hPyS4qX1QIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMWDPp7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E4AC4CEE3;
	Wed, 25 Dec 2024 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115450;
	bh=2We+EatIdKvbBlcc+Qi+TDU+sQlvK0gyzoE4dj3NfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMWDPp7D5mmH6krIKgweF86Ji42GV65PT8bUKI6qQ1c7tAT6V1c5IAJDqSsqNTW8L
	 KZZp7UsO9bkg+GsUzCatq6jlKah1hhfM1/0jNcmdn3oG6JKYr0A2kOf/fLXGjPEa2e
	 de0YWOtcXnKG+JhpQ0vk4XTSVoNF5D+sTMAp0CRKWs7LnF2H70IA3e3QhUw6DYSiQy
	 J42Ii7BTHAANiP0YjUzPEZM7RVjEdxQkwZkuY2CksuqGNzALPsQfsp1mteVmC2vHNP
	 akaJjiQsL1cnqmkdWMH5yfLWCOsbpDuOOkYNR0p6tjHpEVwq6eJkU8Opa5ype+DdSa
	 ZChf+gE5sdl1A==
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
Subject: [PATCH v8 09/18] nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
Date: Wed, 25 Dec 2024 17:29:46 +0900
Message-ID: <20241225082956.96650-10-dlemoal@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


