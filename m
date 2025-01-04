Return-Path: <linux-pci+bounces-19277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818AA0125E
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2684F7A1D57
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCB14B08E;
	Sat,  4 Jan 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW4xlMHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2214A0A4
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966830; cv=none; b=hCRHK87kydCZ7ty1IyS9FW/xg9tN7hcsaP93NZ5ICH+dqqP8+Vt0UYfGZf5VhYkJD4K8N7ZIcr4nHKVEXUSaj3S+CrUOeGP53+x3P6KBcey988U0ATqxGhxY2IzSHMTnwU/lo2m7B0g5TGqygQEdGSZoZ3U3Hn1fAB7SkK+KDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966830; c=relaxed/simple;
	bh=QcsZ2eXp0y8LpgyHEuBlgIhISW+stJlEMf70fl8qcHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQFLI+EcknBbqmpW+dYnka/SWsSj4819ObxGVFwwWIa2QxYomDg9MxUzHMXNSQhbaTEtBjNeUvDuVyOAoiuSHJrD8tLJqaQ+r7CyPDu/ofx6x9jrXS1bfgIaiKdz8go2IkVh7VYfV6FX0W3//E12AAcustRq6/C5ZG3jIImASxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW4xlMHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E681C4CEDF;
	Sat,  4 Jan 2025 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966829;
	bh=QcsZ2eXp0y8LpgyHEuBlgIhISW+stJlEMf70fl8qcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FW4xlMHC8jbU3LksHwpJQDKdvDhl++KhP/+cNY4uddwZjZZQ7Wjx5L+hevus6OLZk
	 gMURUoV3aKeTTqyiVF0vum60iIC9XNH0HfADCS3fkirmkqbi+ZIg4aehwIF8fWKwMk
	 g73/cKOT0eQjKpJ1brUEbWCBSrlrcZVqnd56bGXpDAJYWbydLFQmt3an/8ftmXkAvd
	 JESerMn16ZxfQjKg9PIMNF3HHZSYyP6QnoCDXJBjH6KBeyXrWH6hogu3IiUn+nAIfF
	 DaKyBHb1zPIaIg4DavoVUnf+8NvAvY8DmF0RkWaqZb0ltjYVL9g4KcOU+FNbE245xH
	 g5u5+Ye5w0IFg==
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
Subject: [PATCH v9 01/18] nvme: Move opcode string helper functions declarations
Date: Sat,  4 Jan 2025 13:59:34 +0900
Message-ID: <20250104045951.157830-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the declaration of all helper functions converting NVMe command
opcodes and status codes into strings from drivers/nvme/host/nvme.h
into include/linux/nvme.h, together with the commands definitions.
This allows NVMe target drivers to call these functions without having
to include a host header file.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/host/nvme.h | 39 ---------------------------------------
 include/linux/nvme.h     | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b3..2c76afd00390 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1182,43 +1182,4 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
-#ifdef CONFIG_NVME_VERBOSE_ERRORS
-const char *nvme_get_error_status_str(u16 status);
-const char *nvme_get_opcode_str(u8 opcode);
-const char *nvme_get_admin_opcode_str(u8 opcode);
-const char *nvme_get_fabrics_opcode_str(u8 opcode);
-#else /* CONFIG_NVME_VERBOSE_ERRORS */
-static inline const char *nvme_get_error_status_str(u16 status)
-{
-	return "I/O Error";
-}
-static inline const char *nvme_get_opcode_str(u8 opcode)
-{
-	return "I/O Cmd";
-}
-static inline const char *nvme_get_admin_opcode_str(u8 opcode)
-{
-	return "Admin Cmd";
-}
-
-static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
-{
-	return "Fabrics Cmd";
-}
-#endif /* CONFIG_NVME_VERBOSE_ERRORS */
-
-static inline const char *nvme_opcode_str(int qid, u8 opcode)
-{
-	return qid ? nvme_get_opcode_str(opcode) :
-		nvme_get_admin_opcode_str(opcode);
-}
-
-static inline const char *nvme_fabrics_opcode_str(
-		int qid, const struct nvme_command *cmd)
-{
-	if (nvme_is_fabrics(cmd))
-		return nvme_get_fabrics_opcode_str(cmd->fabrics.fctype);
-
-	return nvme_opcode_str(qid, cmd->common.opcode);
-}
 #endif /* _NVME_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 13377dde4527..a5a4ee56efcf 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1896,6 +1896,46 @@ static inline bool nvme_is_fabrics(const struct nvme_command *cmd)
 	return cmd->common.opcode == nvme_fabrics_command;
 }
 
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+const char *nvme_get_error_status_str(u16 status);
+const char *nvme_get_opcode_str(u8 opcode);
+const char *nvme_get_admin_opcode_str(u8 opcode);
+const char *nvme_get_fabrics_opcode_str(u8 opcode);
+#else /* CONFIG_NVME_VERBOSE_ERRORS */
+static inline const char *nvme_get_error_status_str(u16 status)
+{
+	return "I/O Error";
+}
+static inline const char *nvme_get_opcode_str(u8 opcode)
+{
+	return "I/O Cmd";
+}
+static inline const char *nvme_get_admin_opcode_str(u8 opcode)
+{
+	return "Admin Cmd";
+}
+
+static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
+	return "Fabrics Cmd";
+}
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
+
+static inline const char *nvme_opcode_str(int qid, u8 opcode)
+{
+	return qid ? nvme_get_opcode_str(opcode) :
+		nvme_get_admin_opcode_str(opcode);
+}
+
+static inline const char *nvme_fabrics_opcode_str(
+		int qid, const struct nvme_command *cmd)
+{
+	if (nvme_is_fabrics(cmd))
+		return nvme_get_fabrics_opcode_str(cmd->fabrics.fctype);
+
+	return nvme_opcode_str(qid, cmd->common.opcode);
+}
+
 struct nvme_error_slot {
 	__le64		error_count;
 	__le16		sqid;
-- 
2.47.1


