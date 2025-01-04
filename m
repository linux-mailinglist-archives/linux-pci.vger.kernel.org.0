Return-Path: <linux-pci+bounces-19292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645AA0126C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A83A4683
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE121494D4;
	Sat,  4 Jan 2025 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbC0pq3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAD149E17
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966854; cv=none; b=hYCTCbTTGwFXXVgpuQW0q4UgD4iW8khNcMtuEYM3MsX4S9V5whmN9y6Sn0GxjZo3Yga2/vBnw14TBb/s3VGcvlPJgEZn5hNydAEtHlry9l26AqV6ICx+F/9F6867yaoNVSnulc2N5Ryd2rrYaDuzIyOTEhZVwtfVaUg6bEa5uew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966854; c=relaxed/simple;
	bh=8+TXKB3bLrXck+w7epZz1zbTrmzuMX5pXx1qwUTtUnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuwVCDw52aMNqLE2kFXfIYLIueGHcVO4ke/hIVDZ8Td5iGBtt1VDgR/JprQBx5ktsyv3hXZkrPSJn1a0Iu3o6DZX9QJtMqGfBwmqiUfYP1OdnDCQoW16STD74NHHIQWDkLHf5z4E9PVSXKwhqHqBTxnPWR4zyMaOiTLp6XdPNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbC0pq3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B8C4CEE7;
	Sat,  4 Jan 2025 05:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966854;
	bh=8+TXKB3bLrXck+w7epZz1zbTrmzuMX5pXx1qwUTtUnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbC0pq3PYpov6r1ps0hJPc07aqwF84j+mePU+O3yBlgCnEiWntQLTufN3+pID+1H0
	 DvaWZpoU6oTb4+ZbDmj1GJaYx/KVnIGjMENteqS6mXxLqZ2or2EkKVfa32qzx1x0g8
	 GBgEVMSESx0j1PtTXrKbS+j29uXBgnzsObQcrzbxz7+130v9oo49pFgRibS9eTIAr9
	 8g1hEXE9VKJED/5wazxqj/bb2fT3/9yQqLRkZsyMr3VszwzsZFpKurvpTmpRzhGmYl
	 krtV60EPmtbFjoqbsdAxluYfsj/4Wc/clo93A8s98O51P5Iz34XgU2mQadJP8iAZMG
	 TsdiWDqf3Z8ZQ==
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
Subject: [PATCH v9 16/18] nvmet: Implement arbitration feature support
Date: Sat,  4 Jan 2025 13:59:49 +0900
Message-ID: <20250104045951.157830-17-dlemoal@kernel.org>
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


