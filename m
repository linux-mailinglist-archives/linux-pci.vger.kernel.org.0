Return-Path: <linux-pci+bounces-18001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE49EAC70
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58402188B6BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022F223302;
	Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDI6fJnf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CF21579E
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823283; cv=none; b=bMlCq62kukR60HbzrMqwP11qeq+ODvmwFfu+5wiZmgoE7CEyxteZITZYDpYYu2T86pWJCRZY2QVPUp9H6Q9TEjTddLGvRpsVbrls+9Anzd9QK90JP6HyWTnAEjUn7eC2r09Aqh/quOTVWnk3N0aITGyv/V++CxWzOwnL06NhQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823283; c=relaxed/simple;
	bh=L4TUu+qtqsgC9jpXKIPNTrbBpIS2hOuPcFK8PMS9V6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANXbd0++lNMek71mzglcjJMSP0kyfk2wmRVDPqERspiXm8Sbk49Q/A2bcdlLhWMlqcvuVrOffRgECx2arUKkvmTFztHf53SAIL196XrPNZTahVfoB3QfEUP+aZ7rcc8sy+TFpp2+UBXxXEE6yZCEPH7OXeBNG7InCvy2IWYA93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDI6fJnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A87C4CEE4;
	Tue, 10 Dec 2024 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823283;
	bh=L4TUu+qtqsgC9jpXKIPNTrbBpIS2hOuPcFK8PMS9V6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDI6fJnflJ4/k65Wj/KqpjaRx5WZ599uYCDTVZVLOkzrlmdGGL54BzYEQAw81skTt
	 y1h7VIB6BjxT9GtU8SdiTqBMzz1tMlTru+LY6jf2O7WETwVBeTnOe0R7uIKUUeSW3A
	 1P8U5LAJcOCz5KC6OY8shhJph2wXE/sLDdkTDeS1g1oVf2+H6+oO+as+/tbJ4TfmxW
	 JF0owterC1RKJux3TCvA4pkCAweH0hssifUQSSfR5h+mD+9S8p0C1or56jGQaV924y
	 oHATuYJv+MRJv9FmyhO3Q143NphbKqz+OkavXr+pDFH4h00oHp+SjWn3r7SOwqttoL
	 oQGWrJ37YfLvg==
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
Subject: [PATCH v3 03/17] nvmet: Introduce nvmet_get_cmd_effects_admin()
Date: Tue, 10 Dec 2024 18:33:54 +0900
Message-ID: <20241210093408.105867-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
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


