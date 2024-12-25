Return-Path: <linux-pci+bounces-19030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4E9FC420
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA211883BD5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DC85628;
	Wed, 25 Dec 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osq5guKz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B70347B4
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115437; cv=none; b=DbbdMQ29b4Wq3zqdVdMYxanSjcw9iCxfzjM5JU0ivwsFaIByJwfUBdD2eUZDh0KhCHmN7uHGSKFk/E/1sdRfE/OqO4y7IEGLNH8NpwDcMivj8CUwk9vvw6B4zm5JwQYQQIkNEEcnejz/+3SkisoWSCjqKjdDwbtj3befneT1pwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115437; c=relaxed/simple;
	bh=QcsZ2eXp0y8LpgyHEuBlgIhISW+stJlEMf70fl8qcHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1sSGa2waWuPAs/EdLoDb2P2yM8LjN1L1M6j7nEvjvoeh9vLthQzXX3YA8BGxhelPgH9KwnuNZhH9mhwgktBGLD2UIjcO6yua2UfcTXBqo0v7kBEmnocAnxMupIiJ6xC6FFAiticnkpucS030RYdmumiq4Ta/1ITueVA0sG+/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osq5guKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1F1C4CED7;
	Wed, 25 Dec 2024 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115436;
	bh=QcsZ2eXp0y8LpgyHEuBlgIhISW+stJlEMf70fl8qcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osq5guKz0wGD8181pheDNKrqaMckYjxoZC0Iv09/bc0cp+1p1QDOfXIUII3LrJXg/
	 +S2LPB324828qRMMOeK26ZAYNgNRP55iYtalIuCQtxLpH3fP9/Lz2wsisSbbIsr4Cd
	 wJXM/wE/0Z4wAwgkiPJgFOyvU8MDDamf+XCjqNx+Tq+m24R2KE6+XArU5MmV4PXRql
	 bWSXJciIkUi5W3qMMBbL7ZwXlmGHqRPXc4io1znIUaMC/QIp9uGEgkV1jlmCfIECJh
	 98vnttNbLUo7GV1vKh0s5+IvZKYke3oa9dJqY8FyGH59UdP4qXKTDsnZqb+zSJo+kN
	 W+FM+xX61nFrw==
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
Subject: [PATCH v8 01/18] nvme: Move opcode string helper functions declarations
Date: Wed, 25 Dec 2024 17:29:38 +0900
Message-ID: <20241225082956.96650-2-dlemoal@kernel.org>
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


