Return-Path: <linux-pci+bounces-19040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF09FC42D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82EB1883E77
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94214F123;
	Wed, 25 Dec 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIsDIfyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614813FD86
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115453; cv=none; b=R1O71jx8R1b01bM9YWOIz/h/WLqWM8orFOkOO49txVjshSB15HSi/Fgg+m5s6HS30P63VkRWATK23Sa5KeP+EoyVZyATqIKtWMDXfKDJEYxqAqamo5Oio4S6SXcAovaWYbqxBzGF5eLL5IKWDCI7m1ugjRD/uOwNT2aHzpZwQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115453; c=relaxed/simple;
	bh=7O20xJ1bzOCTYiTRyj88KWANfqYBEibS5Le/cdQeDco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl/a9wfR0LiHzXYV9xqlHirI6k2MXBBk9GuinoYM+66WsEZ7s2hA7bS2UYk7FoDuAyJHDn6f3QuP3MnuUzFA1pe4hNt+VszO2U6GnlrFaucvzBb3+n+QYHN2TbVhTWwCFkmPVGIKXVsVHqfZDd2Y4V5UNNCNnKb5LSoOuUsIkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIsDIfyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A41C4CEE3;
	Wed, 25 Dec 2024 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115453;
	bh=7O20xJ1bzOCTYiTRyj88KWANfqYBEibS5Le/cdQeDco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIsDIfylPvIAj8Eo2LEsTPZOLdbdvgbGaMctsmmCgq+7HXrtSWlVH5vhwMJsHXiWS
	 e0d73J056n+IQpZ+u9c8lOGdzcPv43CwzTPOMqJWp66yxaORcX7k46t5Hll8Nr2/Tg
	 4rfNaNMV9zSr0nphSyjIqCo28x1yoGQ5abTekCJjigAc7QkkUOHJTBU1MBeAIDd7h8
	 +94vrCWOPeaM01oiql2iXg+ybBXScchjdtB7f2Y7NITBVesD7qXEH+jD3sT+L4Hhg8
	 877hxhCsOjf08r7AF/Q6khlE2kyvJILREmRX6ti5up9ACGzolyuL+g5AnlJE0zfgMG
	 EqWl+0043OQKg==
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
Subject: [PATCH v8 11/18] nvmet: Do not require SGL for PCI target controller commands
Date: Wed, 25 Dec 2024 17:29:48 +0900
Message-ID: <20241225082956.96650-12-dlemoal@kernel.org>
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


