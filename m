Return-Path: <linux-pci+bounces-18879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C209F8F4D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C618B165DB2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A021AB6E2;
	Fri, 20 Dec 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0tyRjEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA381AB533
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688251; cv=none; b=LVutZVCpWv6VcXgXQgA+fWYcvEaFobDk5j803AuTzNUWZASjgVeeGn7z4BturJyofad4wSyvFqFbh7uscBuPPw2/UgwBTbNLKHr+dzT0N2SApAjubtukFPg/bcSaUolNi1isV4uzdqyvoXYgDPMOcv+CHOiCiXJ5IuLNdGbomi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688251; c=relaxed/simple;
	bh=x9emvNbxppL57XSEYLJvuQyzwgCrDumjN41+fc6H01I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3owYBk5pkE/876v6p7aPU0Ls4j6ll/VeLZMkZxkNPBqfVSscckLypQflBh7NqTfUoEVZjst9vdtUwyIN1JVvTXP6dIF477MSjaxYgBcRdxs6C8ZHeP0EZQ9s+Ee8gLeP7c3X2C+m2/VqkRFZkwgo9napJdAkzTUSW7uxxiHLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0tyRjEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3DC4CEDE;
	Fri, 20 Dec 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688251;
	bh=x9emvNbxppL57XSEYLJvuQyzwgCrDumjN41+fc6H01I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0tyRjEZLFWITcamGoFADYIrJzsW5aGUkryeHnpNnXudVa/YZs9NrknGl1A0vl2Bs
	 1uA7LBUvhd5KDCwEEv++x6up7mVhtSPvRnv51/snaWi6Tmss808vIpyq8g9pXXydhd
	 iaj9LXeDOOf5jF5rPM6ul0Gg7cXN//TW4yaeR5VCi+ha/F6K8/Pq0EXBFxSCJgzJxx
	 +6DVhkZJNaTfz/CEiVlPehoNsAEBIrNQZCGaKfSM52xivXQvdfUVCuGA2C1e6M+zcZ
	 7Gy1aDlq1a2TGavVwgPCwIugmiMR2hGEJaky6A9FDS6T7NiIBcFWixybCtqGp/Q8Dd
	 ATRiDx2d30w7w==
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
Subject: [PATCH v7 04/18] nvmet: Introduce nvmet_get_cmd_effects_admin()
Date: Fri, 20 Dec 2024 18:50:54 +0900
Message-ID: <20241220095108.601914-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
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


