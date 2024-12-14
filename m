Return-Path: <linux-pci+bounces-18433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 657429F1CF2
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4390188E1C5
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E287E76D;
	Sat, 14 Dec 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwPlj+6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83327450
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156465; cv=none; b=Du4MaZjTgm8uO8AZMcUUXGqiiWOK/90FIJIC5Nt0VElCm+NqxKiIpKMTcAqlIWFq3E+fjrXFtwYzTmA2TY/PLbj6hpKzIztdM08LgysrCVQTDDKBZ6l0cdA3Tke90KaHqnexu6X3KIpWJCE3kzhMIAuY2Wo4ak7xC4h7XYRube8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156465; c=relaxed/simple;
	bh=ubd1JlQoe83cyVIqW71e80goPXSHt5tGASSZnTCs3v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FliBOQRFi34yjA3DKOdXG8NxaewQoKrrnv/wVypsyXQ84beA/AQeR/oJ6xgvUx8+VDSIqxiLxTlzH4HE2GkL0ROg5GOBBoW7GNvAYgbBfl4SsJJ0OZTiS85mhDLcPzpU9iS8iosCAMgxK2+H1KbqBD66lc3FdwzdPoYiiSNXPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwPlj+6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0216C4CED4;
	Sat, 14 Dec 2024 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156465;
	bh=ubd1JlQoe83cyVIqW71e80goPXSHt5tGASSZnTCs3v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwPlj+6aJGkM5rbRdddLXGv5GIpmn2LVC59Ri9TYePLgBYZ+2039AwkdHyxtBDRSr
	 1kaeMP3iotU/FR/I+Kz5xplDtFUZ4VK5DWpIZHYlUPchmeFCkg3V4+iKwlJRcFee7C
	 CWkQGQtzzWc/GMRog0qPqCIXaGOsRnO7IdJM4YU/pplvIxYbVuCUwUgSUzzGfvCgGf
	 5XKVlC8VS6Xcm8Njzl0tTOUNeCi9pLwtr5h5z1aLf0xNbjoKkEI5a+LjwmSrQPiJKy
	 cTT6zq7FDn4FPXLv5Lotkje2mXqHMopmrNSH57icnZFRuD0aYcAYkoZ0IoVM2zOGDx
	 3xId0n5Met4Ww==
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
Subject: [PATCH v5 13/18] nvmet: Implement host identifier set feature support
Date: Sat, 14 Dec 2024 15:06:50 +0900
Message-ID: <20241214060655.166325-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NVMe specifications mandate support for the host identifier
set_features for controllers that also supports reservations. Satisfy
this requirement by implementing handling of the NVME_FEAT_HOST_ID
feature for the nvme_set_features command. This implementation is for
now effective only for PCI target controllers. For other controller
types, the set features command is failed with a NVME_SC_CMD_SEQ_ERROR
status as before.

As noted in the code, 128 bits host identifiers are supported since the
NVMe base specifications version 2.1 indicate in section 5.1.25.1.28.1
that "The controller may support a 64-bit Host Identifier...".

The RHII (Reservations and Host Identifier Interaction) bit of the
controller attribute (ctratt) field of the identify controller data is
also set to indicate that a host ID of "0" is supported but that the
host ID must be a non-zero value to use reservations.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 35 +++++++++++++++++++++++++++++----
 include/linux/nvme.h            |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0c5127a1d191..efef3acba9fb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -659,7 +659,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys *subsys = ctrl->subsys;
 	struct nvme_id_ctrl *id;
-	u32 cmd_capsule_size;
+	u32 cmd_capsule_size, ctratt;
 	u16 status = 0;
 
 	if (!subsys->subsys_discovered) {
@@ -707,8 +707,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
-		NVME_CTRL_ATTR_TBKAS);
+	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
+	if (nvmet_is_pci_ctrl(ctrl))
+		ctratt |= NVME_CTRL_ATTR_RHII;
+	id->ctratt = cpu_to_le32(ctratt);
 
 	id->oacs = 0;
 
@@ -1255,6 +1257,31 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 	return 0;
 }
 
+static u16 nvmet_set_feat_host_id(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+
+	if (!nvmet_is_pci_ctrl(ctrl))
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
+
+	/*
+	 * The NVMe base specifications v2.1 recommends supporting 128-bits host
+	 * IDs (section 5.1.25.1.28.1). However, that same section also says
+	 * that "The controller may support a 64-bit Host Identifier and/or an
+	 * extended 128-bit Host Identifier". So simplify this support and do
+	 * not support 64-bits host IDs to avoid needing to check that all
+	 * controllers associated with the same subsystem all use the same host
+	 * ID size.
+	 */
+	if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return nvmet_copy_from_sgl(req, 0, &req->sq->ctrl->hostid,
+				   sizeof(req->sq->ctrl->hostid));
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1285,7 +1312,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		status = nvmet_set_feat_async_event(req, NVMET_AEN_CFG_ALL);
 		break;
 	case NVME_FEAT_HOST_ID:
-		status = NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
+		status = nvmet_set_feat_host_id(req);
 		break;
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 42fc00dc494e..fe3b60818fdc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -276,6 +276,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_RHII		= (1 << 18),
 };
 
 struct nvme_id_ctrl {
-- 
2.47.1


