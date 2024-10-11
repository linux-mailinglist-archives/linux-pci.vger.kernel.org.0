Return-Path: <linux-pci+bounces-14308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8A99A3BB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F21C1C23029
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CD213EEB;
	Fri, 11 Oct 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byNuwZgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF1802
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649197; cv=none; b=oP8wCh/aTnc7LoKMkR+fJmEZgRVe/q/TY0iFXmaQUBcnYjV5xejNxucXczKNaCMkBg71RLDySXZNFH1UsN334aqytfDx4nrZdJtay3hmUx7RGB6d7FLT2bPnwGMZUy6Ol40FR3MQSI7nQ5X3NY16OzVRXGdaX+CaKiKyf+65ubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649197; c=relaxed/simple;
	bh=d7+U9CxxyPqSKY2n/y+GDBVMjr19oSCqwuEa33sYgf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWwwIfi/oMVfb+P9itg2Nwdw60+cav60EdutZECpFkRsjO/I2ynhAKBWnpwCqxUCgxBREzkVZV1qB5/aEKCNzfP2we1nPwxaqx+E1pnu9FJvqL39GJE3eRRHV9hosORYWl5QCuNf76ihLZv4d1SWsBHsp6uB3O5db4e1f+wU68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byNuwZgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AEDC4CED1;
	Fri, 11 Oct 2024 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649196;
	bh=d7+U9CxxyPqSKY2n/y+GDBVMjr19oSCqwuEa33sYgf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byNuwZgTyvV3fYCB0bsicI3k6znK8ufQlD5nM7G4u5gArpT7bG8WOdn+l3M6tKNnA
	 6zGCwGhzozfl2qvM+ESXJQxTOhpRCtXcrEiPagwvlBJwqM1521rLlltDkeAl1lkSSW
	 nMzYUzuC/CctZIPLII1DpDqBlgL5fwwjozJpca0xCPnAbR1HyPiTX2SfJjug/XE49f
	 Wj0AclgPK3KwTvnmopym2jD2eJHjNLQiSM2XGZ0cD2lYOOqT8HrjM7H3LWa1tMyqbr
	 AWvzkvTBE42ZIawOgeuQ+tkiXrXUVbfx3tsh+pCLLE0/nuiOGw+CiLy0qCWC8QmSZV
	 0Y3fVRO0NXogA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/5] nvmet: rename and move nvmet_get_log_page_len()
Date: Fri, 11 Oct 2024 21:19:47 +0900
Message-ID: <20241011121951.90019-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121951.90019-1-dlemoal@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for nvmet_get_log_page_len() has no pedendency on nvme target
code and only depends on struct nvme_command. Move this helper function
out of drivers/nvme/target/admin-cmd.c and inline it as part of the
generic definitions in include/linux/nvme.h. Apply the same modification
to nvmet_get_log_page_offset().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 20 +-------------------
 drivers/nvme/target/discovery.c |  4 ++--
 drivers/nvme/target/nvmet.h     |  3 ---
 include/linux/nvme.h            | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 081f0473cd9e..64434654b713 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -12,19 +12,6 @@
 #include <linux/unaligned.h>
 #include "nvmet.h"
 
-u32 nvmet_get_log_page_len(struct nvme_command *cmd)
-{
-	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
-
-	len <<= 16;
-	len += le16_to_cpu(cmd->get_log_page.numdl);
-	/* NUMD is a 0's based value */
-	len += 1;
-	len *= sizeof(u32);
-
-	return len;
-}
-
 static u32 nvmet_feat_data_len(struct nvmet_req *req, u32 cdw10)
 {
 	switch (cdw10 & 0xff) {
@@ -35,11 +22,6 @@ static u32 nvmet_feat_data_len(struct nvmet_req *req, u32 cdw10)
 	}
 }
 
-u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
-{
-	return le64_to_cpu(cmd->get_log_page.lpo);
-}
-
 static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
@@ -319,7 +301,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
-	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
+	if (!nvmet_check_transfer_len(req, nvme_get_log_page_len(req->cmd)))
 		return;
 
 	switch (req->cmd->get_log_page.lid) {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 28843df5fa7c..71c94a54bcd8 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -163,8 +163,8 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_disc_rsp_page_hdr *hdr;
-	u64 offset = nvmet_get_log_page_offset(req->cmd);
-	size_t data_len = nvmet_get_log_page_len(req->cmd);
+	u64 offset = nvme_get_log_page_offset(req->cmd);
+	size_t data_len = nvme_get_log_page_len(req->cmd);
 	size_t alloc_len;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..6e9499268c28 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -541,9 +541,6 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 		size_t len);
 u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 
-u32 nvmet_get_log_page_len(struct nvme_command *cmd);
-u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
-
 extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..1f6d8cd0389a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -10,6 +10,7 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <asm/byteorder.h>
 
 /* NQN names in commands fields specified one size */
 #define NVMF_NQN_FIELD_LEN	256
@@ -1856,6 +1857,24 @@ static inline bool nvme_is_write(const struct nvme_command *cmd)
 	return cmd->common.opcode & 1;
 }
 
+static inline __u32 nvme_get_log_page_len(struct nvme_command *cmd)
+{
+	__u32 len = le16_to_cpu(cmd->get_log_page.numdu);
+
+	len <<= 16;
+	len += le16_to_cpu(cmd->get_log_page.numdl);
+	/* NUMD is a 0's based value */
+	len += 1;
+	len *= sizeof(__u32);
+
+	return len;
+}
+
+static inline __u64 nvme_get_log_page_offset(struct nvme_command *cmd)
+{
+	return le64_to_cpu(cmd->get_log_page.lpo);
+}
+
 enum {
 	/*
 	 * Generic Command Status:
-- 
2.47.0


