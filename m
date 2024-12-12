Return-Path: <linux-pci+bounces-18263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF39EE527
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DA8282835
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15717211A1B;
	Thu, 12 Dec 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDc8s0Le"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC9211A1A
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003315; cv=none; b=emoHdwNywzj5eqSv6cHky+KLzgfaZpbfYESkdZJurxnnJBbVrbuyI4tsUIX2vM6YVe2fz5rMf40CMFjBmW7m/3vK1qCXnITDIZ4+uhQ3JKy2n5ZJE33+S5F+a1tKA42/2EHARPJppDlD5/23rOzrzb9E/OTBNsauFfUwQaOiJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003315; c=relaxed/simple;
	bh=x9emvNbxppL57XSEYLJvuQyzwgCrDumjN41+fc6H01I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC97v0AHRRYxDpDFR2cVQwHJGLh8FKwF+YA5NiM8YrF1HqSlN3jD4xSuTqi40H7WhnW1iBlCUj1lmOLxCZS/WLO9cfmsdtzGGPnsDyVeIgYm6SDMB+PrOER9cbScGF2x78ECacLgbLxBv6UuVhB2xDezYBEzD3pyF5h+cH+M/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDc8s0Le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCF4C4CEDE;
	Thu, 12 Dec 2024 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003314;
	bh=x9emvNbxppL57XSEYLJvuQyzwgCrDumjN41+fc6H01I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDc8s0LeNghnB0Vimq+ZZszZol8uyYhk51cN2goxUzVCyhmSzGcc3L4Vg0xPk2ai2
	 cQvIt54wNJ3YVnfs+1PAaU/t1UgCtKD6Nq2uVk8VMMnYrcy5rGWhyhV7orV0VWEN7T
	 2DPvqMfE1YXNEuH8+0DG4b4fa0KQI6TKsaB9K1eoBXt49Dz4AUvxJwG8raIj1BpjS2
	 ZZhme4syLnKlhcinZ9z/MQqAwYBwnsOt1itHWukpsP4eFK1eIVDiQUfiB3xip6R8TH
	 hrcjcjDqH+7kDwhqSyMrzzDvuIP1EdoHXQvcY1tYLGXhCz5YbRKQwzNLNG2M8ev978
	 JJ2+b9sazatzQ==
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
Subject: [PATCH v4 04/18] nvmet: Introduce nvmet_get_cmd_effects_admin()
Date: Thu, 12 Dec 2024 20:34:26 +0900
Message-ID: <20241212113440.352958-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to have a logically better organized implementation of the
effects log page, split out reporting the supported admin commands from
nvmet_get_cmd_effects_nvm() into the new function
nvmet_get_cmd_effects_admin().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b73f5fde4d9e..78478a4a2e4d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -230,7 +230,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
+static void nvmet_get_cmd_effects_admin(struct nvme_effects_log *log)
 {
 	log->acs[nvme_admin_get_log_page] =
 	log->acs[nvme_admin_identify] =
@@ -240,7 +240,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->acs[nvme_admin_async_event] =
 	log->acs[nvme_admin_keep_alive] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+}
 
+static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
+{
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
@@ -276,6 +279,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
+		nvmet_get_cmd_effects_admin(log);
 		nvmet_get_cmd_effects_nvm(log);
 		break;
 	case NVME_CSI_ZNS:
@@ -283,6 +287,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 			status = NVME_SC_INVALID_IO_CMD_SET;
 			goto free;
 		}
+		nvmet_get_cmd_effects_admin(log);
 		nvmet_get_cmd_effects_nvm(log);
 		nvmet_get_cmd_effects_zns(log);
 		break;
-- 
2.47.1


