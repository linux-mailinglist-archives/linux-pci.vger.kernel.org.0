Return-Path: <linux-pci+bounces-19044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6CC9FC432
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C691883CA6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0371547E4;
	Wed, 25 Dec 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBjJi9zK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A948153BC1
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115460; cv=none; b=HbpveWFozsJqQmWiuXfyT7bDUFe8jk346Q7lLTVKoUFKsiNv0+8xZ9BcefrJU1arN9yKTekRsqjyC+VNlGEEiKRStCrBTn4WAdBTmnswD0ceNNdj9taMJacyJcYC16zxFpQTHJ8t6EaF6EieyTjSU7AjADJZewCSe7A7XG6NqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115460; c=relaxed/simple;
	bh=q849AePXaFCf/fHVfK60tMqj++sI4p7Q8hGgHnmF3oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlTm/KPlIYZrdZq10IBwAq5tKpqEqerZkwZ3nkhiD4unPYRLRKyiFd0gyaVVUhqz7z+iAJDD+XEXXAqgFuMm01BBEbKtDaLpu357guE6brM284heXpX10lYwNcSpo8J0wnlD4TKj+41A+AcCWzk4LdHO6Ct3O9nlnWREAQMpxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBjJi9zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4462C4CECD;
	Wed, 25 Dec 2024 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115460;
	bh=q849AePXaFCf/fHVfK60tMqj++sI4p7Q8hGgHnmF3oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBjJi9zKeLW3jl9N5U3vw2h601L7/QHgAaKNx2ZfQ67T9oK6FcpFuG0yoMwvTuwZB
	 AZwEGzw7XqlMbDviTIBhRcSch6C6LIiSBprkdU0id8+e+Zc6nNb7h2pbb8Uy5RvGGO
	 3mPeJmHz92Uv5ObY0AH+Ru1uysmWChtSKYaXfTzEqbB6CHE9ki+lI7MVAlEbmuaCPO
	 R8MyEtQudZRv/p0GWQK7FzG3/uQNfMH2bXKXe2QG2JwCpBupjjgnlu3I93Htorzdcc
	 qQNwz3SdOt1pgKD9KFiL/1vjN2P/nv3wxUBAGCprARRYYrp7v6nnRGfrBaLaV4Yo4Y
	 mHMIe2Fr222lA==
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
Subject: [PATCH v8 15/18] nvmet: Implement interrupt config feature support
Date: Wed, 25 Dec 2024 17:29:52 +0900
Message-ID: <20241225082956.96650-16-dlemoal@kernel.org>
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

The NVMe base specifications v2.1 mandate supporting the interrupt
config feature (NVME_FEAT_IRQ_CONFIG) for PCI controllers. Introduce the
data structure struct nvmet_feat_irq_config to define the coalescing
disabled (cd) and interrupt vector (iv) fields of this feature and
implement the functions nvmet_get_feat_irq_config() and
nvmet_set_feat_irq_config() functions to get and set these fields. These
functions respectively use the controller get_feature() and
set_feature() operations to fill and handle the fields of struct
nvmet_feat_irq_config.

Support for this feature is prohibited for fabrics controllers. If a get
feature command or a set feature command for this feature is received
for a fabrics controller, the command is failed with an invalid field
error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c | 54 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  5 +++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index eff9fd2e81ed..8b8ec33330b2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1303,6 +1303,27 @@ static u16 nvmet_set_feat_irq_coalesce(struct nvmet_req *req)
 	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
 }
 
+static u16 nvmet_set_feat_irq_config(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_irq_config irqcfg = {
+		.iv = cdw11 & 0xffff,
+		.cd = (cdw11 >> 16) & 0x1,
+	};
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1329,6 +1350,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_set_feat_irq_coalesce(req);
 		break;
+	case NVME_FEAT_IRQ_CONFIG:
+		status = nvmet_set_feat_irq_config(req);
+		break;
 	case NVME_FEAT_KATO:
 		status = nvmet_set_feat_kato(req);
 		break;
@@ -1397,6 +1421,31 @@ static u16 nvmet_get_feat_irq_coalesce(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
+static u16 nvmet_get_feat_irq_config(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 iv = le32_to_cpu(req->cmd->common.cdw11) & 0xffff;
+	struct nvmet_feat_irq_config irqcfg = { .iv = iv };
+	u16 status;
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req, ((u32)irqcfg.cd << 16) | iv);
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1431,14 +1480,15 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_ERR_RECOVERY:
 		break;
-	case NVME_FEAT_IRQ_CONFIG:
-		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_get_feat_irq_coalesce(req);
 		break;
+	case NVME_FEAT_IRQ_CONFIG:
+		status = nvmet_get_feat_irq_config(req);
+		break;
 	case NVME_FEAT_ASYNC_EVENT:
 		nvmet_get_feat_async_event(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 555c09b11dbe..999a4ebf597e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -916,4 +916,9 @@ struct nvmet_feat_irq_coalesce {
 	u8		time;
 };
 
+struct nvmet_feat_irq_config {
+	u16		iv;
+	bool		cd;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


