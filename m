Return-Path: <linux-pci+bounces-13925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD39923AE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A81F21331
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87E12DD8A;
	Mon,  7 Oct 2024 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSNNkHhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823443ABC
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276236; cv=none; b=WbfvEE44oEj6vz7/AZWw6yLJnHIEwMaCzy21jePiZe4/jg5bfLPQOETtWYR+QZBKVX0UW+fHH6tW1DGssl05OJnDyzHGAFtQp49TyUmIzpUN/SyyZIcoSo+9qjM796VE50+7JKp/nYJabmj0nMfL64S34L3Xn0ypM9TyX0sMUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276236; c=relaxed/simple;
	bh=vfUOd45XU/XxutZyW6nJEnB0x4D/3FMkZDnFt4MKos8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGd8Tnaj62XPqe5ceiR9MpeI/vbh3V8pQjgT76eac72qf87U5Rgmdg/DoxJ6eYfbOgKC1UW4HjhV3+lkvK0ML5SSLQEfiTW407TbXzTElVp6OpdnX9u0yNZjixBHjO0EqViXEHR4Qq1M0RuTouXLdaNXAuM2pw3t4UA5hAULJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSNNkHhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448ACC4CED0;
	Mon,  7 Oct 2024 04:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276235;
	bh=vfUOd45XU/XxutZyW6nJEnB0x4D/3FMkZDnFt4MKos8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSNNkHhCzpQBZtqIoBqgdOZYO2asdfp+8w7pJB4t/Z172qFdLAKMgcZk+fwq6HI+M
	 hMpNxrZIr4f/bLTXI3ezRKpmNdSM7LfLzAY8IxS4FhaTiwp1A2wmSuBtM3KMrmrWC6
	 dtPCgf043bqSbstafIDWEBCVig8LC7wlb+Vz/NiHTgYEDuDYIYx2oT4CD54utsTLP3
	 q2+wNYCjio1fZFW7Jm3FaZogkufnpgl6h3Xa5O9NhgIy0tYaNNvt/1q7oNMr/NnMDo
	 1Z6xwVxJRUVNfzLpNXfpBcDYFxv8XPqLc0iRsrvYlJP5B2DFWJn5f4+o6I9lWnZy7Z
	 mEZNaCgTOJLIg==
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
Subject: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
Date: Mon,  7 Oct 2024 13:43:47 +0900
Message-ID: <20241007044351.157912-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007044351.157912-1-dlemoal@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
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
---
 drivers/nvme/target/admin-cmd.c | 20 +-------------------
 drivers/nvme/target/discovery.c |  4 ++--
 drivers/nvme/target/nvmet.h     |  3 ---
 include/linux/nvme.h            | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 954d4c074770..b20cd1dba207 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -12,19 +12,6 @@
 #include <asm/unaligned.h>
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
2.46.2


