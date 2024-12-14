Return-Path: <linux-pci+bounces-18431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47779F1CEF
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F005C16281E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97371369B6;
	Sat, 14 Dec 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZfjNFqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B012D1F1
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156461; cv=none; b=b7H4iv3Bza9qus+YZDgfeIYs/NLqigJ7Lxpqugqxnq2YBj4Tu3Uit+5oj09GneQgB3LDfpA2AGAdEa8V4Eg/24fuTakPfwoBe8K4cM6ob2mzjiFVetiwmsrp+CdD4IkXW0Ogs1bFUEBsV5yFuWdtZd3CoV7Inb89rhXT//HmjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156461; c=relaxed/simple;
	bh=ObnK18IrbXCCXHeUn9M9sRVoVKrc3aKyRqhRFeq9/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLhn8pvBn23d0y3cx2VHi8i5s72N7x8jlZHpTvCrz17zQo8opA1sq4dZ/FGlXXU5618pkSbWGSHkCVAmDdR6GHXsdGdeoqhGNdS62CGgwUo5E3DZPJt7sfl9wsb6bTClS0EYF3EZqjaW/g+qJfaFaARKbl87jQxV1hkHZuwg+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZfjNFqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30646C4CED7;
	Sat, 14 Dec 2024 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156461;
	bh=ObnK18IrbXCCXHeUn9M9sRVoVKrc3aKyRqhRFeq9/WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZfjNFqV243nw6FyDBnwB4qtcVdRznanLrstcMCr9rmyLaRHUiGErct6lleic+F0X
	 kJnO2mMEb7UcW4EnNgWXcXWGK81YI63+u/wzi7iExMxuyaIzOTBlWFttxOCCzoWDna
	 6iRoImFMcF+Se0bbrb8vYG7yB8D/VBHbGfAk4zHS5kzrzEs+qiqzVCy4PoPH9mfXS7
	 hWN1rBxvdGdBr0nY0aiRZsB8v0S4wgV3UuyAyvFD38hy+84yEVbAXmiwOsSJjTTm0j
	 3dqNtZbYYXl6XAXv40r/SbH40nFofs/twELgD9/e6CcrhskDqRQM3eDUt/8T+u/Iac
	 /HzeRfd5+wrEw==
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
Subject: [PATCH v5 11/18] nvmet: Do not require SGL for PCI target controller commands
Date: Sat, 14 Dec 2024 15:06:48 +0900
Message-ID: <20241214060655.166325-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
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


