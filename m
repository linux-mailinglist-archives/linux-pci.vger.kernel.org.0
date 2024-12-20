Return-Path: <linux-pci+bounces-18840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF19F8AC8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D24188C12B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD73FB1B;
	Fri, 20 Dec 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clw74aVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCB2594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666882; cv=none; b=HojB1Yt+5KXIHKf7kCGA9k8JaFwdXF12AB/SlEBvtNUgdeC39taXe5lNWJBO6Mo/DRoBc8SbiKauUW+bQ66rXzXgD0N/JiH9MatJ7hd8q6BU0nSna/aICu66S1FnzS7d1xxlu/e4RdISiQ9oCYLfj5Wy9huuNwuseHALvRoci60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666882; c=relaxed/simple;
	bh=ObnK18IrbXCCXHeUn9M9sRVoVKrc3aKyRqhRFeq9/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTOSURW08KAzAHk9gwSoyDwxn2PAYnYx1eOlAeyEj+OxiJs2wQ8vir36iLwafYgw6PjYJcLi+4zmkUuxY68WuWeKgf80cVYTWQoVPFr7DC59cEhRuIXK74bpqHwhxHw57IlmE+u4etDt+ersgEmwLotKv6j7fSG1PTmdinPMZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clw74aVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F2DC4CECD;
	Fri, 20 Dec 2024 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666881;
	bh=ObnK18IrbXCCXHeUn9M9sRVoVKrc3aKyRqhRFeq9/WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Clw74aVS0hgAtCrJg553buMLMnhR2vaXV5SDP36pZz58sbgkWIg34STsGvujyjtjR
	 g2i/iyw6/CvtRpc2Z83S26feGVMsydfvEmvwzAgU0pn9nyQgL1HJHe3J797l3WKhbW
	 ie+YdV0NO2nvPEU4SzP7nybfH5so/zUHnk8+1Lvv1lpGD56MXMFnT94hIYmx8FQWk4
	 T22totwXovLqdPac8HpPBC8ogHVfYaAJLdY5BcVaAasSUBvmOPbh5wWtjHW0SADfq9
	 tjQv6BwtV1rCAGPTvuy/HWxA3JkPQhhN6P3rkGHzM3oIHzj8YMhuhQ2Ps9hBc4Mvfw
	 GumuKE46w+waA==
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
Subject: [PATCH v6 11/18] nvmet: Do not require SGL for PCI target controller commands
Date: Fri, 20 Dec 2024 12:54:34 +0900
Message-ID: <20241220035441.600193-12-dlemoal@kernel.org>
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

Support for SGL is optional for the PCI transport. Modify
nvmet_req_init() to not require the NVME_CMD_SGL_METABUF command flag to
be set if the target controller transport type is NVMF_TRTYPE_PCI.
In addition to this, the NVMe base specification v2.1 mandate that all
admin commands use PRP, that is, have CDW0.PSDT cleared to 0. Modify
nvmet_parse_admin_cmd() to check this.

Finally, modify nvmet_check_transfer_len() and
nvmet_check_data_len_lte() to return the appropriate error status
depending on the command using SGL or PRP. Since for fabrics
nvmet_req_init() checks that a command uses SGL, always, this change
affects only PCI target controllers.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      | 27 +++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c91864c185fc..0c5127a1d191 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1478,6 +1478,11 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
+	/* For PCI controllers, admin commands shall not use SGL. */
+	if (nvmet_is_pci_ctrl(req->sq->ctrl) && !req->sq->qid &&
+	    cmd->common.flags & NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+
 	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_admin_cmd(req);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a92e3a81b46..43c9888eea90 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1122,12 +1122,15 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	/*
 	 * For fabrics, PSDT field shall describe metadata pointer (MPTR) that
 	 * contains an address of a single contiguous physical buffer that is
-	 * byte aligned.
+	 * byte aligned. For PCI controllers, this is optional so not enforced.
 	 */
 	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
-		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
-		goto fail;
+		if (!req->sq->ctrl || !nvmet_is_pci_ctrl(req->sq->ctrl)) {
+			req->error_loc =
+				offsetof(struct nvme_common_command, flags);
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+			goto fail;
+		}
 	}
 
 	if (unlikely(!req->sq->ctrl))
@@ -1182,8 +1185,14 @@ EXPORT_SYMBOL_GPL(nvmet_req_transfer_len);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
 	if (unlikely(len != req->transfer_len)) {
+		u16 status;
+
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
+		if (req->cmd->common.flags & NVME_CMD_SGL_ALL)
+			status = NVME_SC_SGL_INVALID_DATA;
+		else
+			status = NVME_SC_INVALID_FIELD;
+		nvmet_req_complete(req, status | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -1194,8 +1203,14 @@ EXPORT_SYMBOL_GPL(nvmet_check_transfer_len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
 	if (unlikely(data_len > req->transfer_len)) {
+		u16 status;
+
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
+		if (req->cmd->common.flags & NVME_CMD_SGL_ALL)
+			status = NVME_SC_SGL_INVALID_DATA;
+		else
+			status = NVME_SC_INVALID_FIELD;
+		nvmet_req_complete(req, status | NVME_STATUS_DNR);
 		return false;
 	}
 
-- 
2.47.1


