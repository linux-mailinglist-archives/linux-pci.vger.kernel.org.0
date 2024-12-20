Return-Path: <linux-pci+bounces-18845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B239F8ACB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3B4188B45E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED913AA35;
	Fri, 20 Dec 2024 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+huBBrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCC2594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666892; cv=none; b=Au3lhBbBHl9vZwvLUR1T4IU/tRp9luBkNZ69nHeH9+YWGfOjVdUiV9P7fMmU5jABazCalV8qoNeAn8INLKjecK3+YaYq3XKHVp/8v/yZi5e0YMqXO6kYi1fTuvweW9RFuWBQI5lPcI8nmzN0Gqb8V6IAhLviQJxr3tysAOLGeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666892; c=relaxed/simple;
	bh=g/QDBHQyttOxZZtzqO75xNJmVtK8xvqODSyt8y5XPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4iVAc4nLBWS2AAdkKRejkaWnd4r0ks9HU/v/3V+BGaGVUPpWmPLcZpYuwVzWIjTjeMUi1CNSOKJ3UebvNoYF/8G2H/59MthSPRSls1ohnoHigbf1kyob+QfEeZYkkoMTg1PLHHsMJo4VOLbHbEE/tkCG290j10dLcRdwxIZCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+huBBrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C8C4CEDE;
	Fri, 20 Dec 2024 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666892;
	bh=g/QDBHQyttOxZZtzqO75xNJmVtK8xvqODSyt8y5XPq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+huBBrJKghfO0cgTMfKVlIuJxuk82cVAqIAw5K+c01qzAjtTRXyFQt5K5mUyBSZa
	 ahP8IjnoBRByUFfZ+ymJGyodgYzXyE8sB+p8XVB9we8ccMoeiDrh/fQWixjMG/h06/
	 yaiUjOLMRhFqCLOF6Q51b+5D5LIontwvecB4piu8CbyXiqkigxyvsbJY/w0HjOzwfL
	 i6twVQkCvvxny3CplOQRMhKcZI+kotdShkdR/tW6jtnzBFSEw+hxwqa/goCTsmQZtv
	 oyY8rDetAtO+cU75fLFa/awF45DJHP9LwKIpG9ia6SlzjvB9X/dmIFWE6sFoLik3zY
	 6xEycxb+iL4aA==
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
Subject: [PATCH v6 16/18] nvmet: Implement arbitration feature support
Date: Fri, 20 Dec 2024 12:54:39 +0900
Message-ID: <20241220035441.600193-17-dlemoal@kernel.org>
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

NVMe base specification v2.1 mandates support for the arbitration
feature (NVME_FEAT_ARBITRATION). Introduce the data structure
struct nvmet_feat_arbitration to define the high, medium and low
priority weight fields and the arbitration burst field of this feature
and implement the functions nvmet_get_feat_arbitration() and
nvmet_set_feat_arbitration() functions to get and set these fields.

Since there is no generic way to implement support for the arbitration
feature, these functions respectively use the controller get_feature()
and set_feature() operations to process the feature with the help of
the controller driver. If the controller driver does not implement these
operations and a get feature command or a set feature command for this
feature is received, the command is failed with an invalid field error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 51 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  7 +++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8b8ec33330b2..3ddd8e44e148 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1324,6 +1324,25 @@ static u16 nvmet_set_feat_irq_config(struct nvmet_req *req)
 	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
 }
 
+static u16 nvmet_set_feat_arbitration(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_arbitration arb = {
+		.hpw = (cdw11 >> 24) & 0xff,
+		.mpw = (cdw11 >> 16) & 0xff,
+		.lpw = (cdw11 >> 8) & 0xff,
+		.ab = cdw11 & 0x3,
+	};
+
+	if (!ctrl->ops->set_feature) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_ARBITRATION, &arb);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1337,6 +1356,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		return;
 
 	switch (cdw10 & 0xff) {
+	case NVME_FEAT_ARBITRATION:
+		status = nvmet_set_feat_arbitration(req);
+		break;
 	case NVME_FEAT_NUM_QUEUES:
 		ncqr = (cdw11 >> 16) & 0xffff;
 		nsqr = cdw11 & 0xffff;
@@ -1446,6 +1468,30 @@ static u16 nvmet_get_feat_irq_config(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
+static u16 nvmet_get_feat_arbitration(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_feat_arbitration arb = { };
+	u16 status;
+
+	if (!ctrl->ops->get_feature) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_ARBITRATION, &arb);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req,
+			 ((u32)arb.hpw << 24) |
+			 ((u32)arb.mpw << 16) |
+			 ((u32)arb.lpw << 8) |
+			 (arb.ab & 0x3));
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1472,8 +1518,6 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	 * need to come up with some fake values for these.
 	 */
 #if 0
-	case NVME_FEAT_ARBITRATION:
-		break;
 	case NVME_FEAT_POWER_MGMT:
 		break;
 	case NVME_FEAT_TEMP_THRESH:
@@ -1483,6 +1527,9 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
+	case NVME_FEAT_ARBITRATION:
+		status = nvmet_get_feat_arbitration(req);
+		break;
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_get_feat_irq_coalesce(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 999a4ebf597e..f4df458df9db 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -921,4 +921,11 @@ struct nvmet_feat_irq_config {
 	bool		cd;
 };
 
+struct nvmet_feat_arbitration {
+	u8		hpw;
+	u8		mpw;
+	u8		lpw;
+	u8		ab;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


