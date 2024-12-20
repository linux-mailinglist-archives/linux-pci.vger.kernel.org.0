Return-Path: <linux-pci+bounces-18884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98179F8F52
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D359165A99
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710E199E84;
	Fri, 20 Dec 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVSmN2oF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A81A7044
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688263; cv=none; b=GTUaMyd8lfXZLY/AS9LZUDw/avoxvDO2qgbLuONSrhXjQsN7QfoeSnUwyd8oq/QpZyrguf6kmAcp3kBaXyr9huYksEw/IgDJVyLws3w8rqQiGZOMttNVU472TuMjl8yuoW0G8OoZSnq46QHp0vIdu+r331QprQJfmwAkuk7NXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688263; c=relaxed/simple;
	bh=mwQyUgDWPHDk5FyOL3o2ssht9G9ehr6tuqOO3PQbywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG5+8g8YO1qYmQtJcq2AUlItxDSsyhsQ37QaI5uhQAha2qtD5BLQFGZkcEilKRlyQcHqeHROurAa5Zm9CJDexQKNA5c4EoiBhjXUhE7B4qherbyEBNEd2RTCd67Q1Rklr/CfLrfmr08gbculeP+BO0DX2gJkGO6i4nJuNhhc0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVSmN2oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432FC4CEDC;
	Fri, 20 Dec 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688262;
	bh=mwQyUgDWPHDk5FyOL3o2ssht9G9ehr6tuqOO3PQbywA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVSmN2oF+DrQNi8/w9ZePfsoPZZESg3s4IxvFHlM/sb0ti1/mhWDVMIwG/FJ/73sk
	 RNzlpVokYy1A63xMHUPn0ds4vr1gjsLyLv6/F2wxvjPxL4vqJfLTSNZnIlOZAwXQsK
	 9BhPTHl5DrW3CnRPi+WtQt1+gbR7F3zSwIkGFP+vJ2F3YOyXXxWyCyi2241HVWOzXe
	 qEL5DUsfRFKGIdAIf/mFh5rTbQN2pPEEo8xUK8odwWwybsYDKzWabRWxj/2XoM5EfU
	 LRq8/NP2n8V7Z881AEGHewVKLLjpNiPgIgAQ1XVjxG/QGoi0H7qJlbCDKw0xt3GsaZ
	 85auixtO7yl7g==
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
Subject: [PATCH v7 09/18] nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
Date: Fri, 20 Dec 2024 18:50:59 +0900
Message-ID: <20241220095108.601914-10-dlemoal@kernel.org>
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


