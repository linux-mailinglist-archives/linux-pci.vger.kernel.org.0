Return-Path: <linux-pci+bounces-19278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F9A0125D
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C901884AC6
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F459B71;
	Sat,  4 Jan 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDJjHiaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FA1494AD
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966832; cv=none; b=gLkI+UN3z2OgZYxjga3kIPfDpHYTMHQjVmwlnC52501tNK0F/iYR+YscydaX0smOpBspDTsQlF4yODdxRs5vPAcsI6LEu64A31dttszBc52ECHC56JSo/bJhEaFdxvbrySOcL0h8Vpgmqx+oE8zoHzS46ZtTiOwoGWUiTL1Tjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966832; c=relaxed/simple;
	bh=WsNcFOLFSIUgSlVfe8sm/txYpSk69r/6/ZOCmfjclDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgd0gVNx/u4bHBuTbHUuqGkApUf1OPzc4o6vIcDMduPP6d59ta8NpYfh9HjINa6gIm3RnAzBvBPSNKO7yIL1J/+mxgoSvi8GjWQuxWO6mwqyvznH5izK8nBCS6Dg+/bZK8CE677OB9TGEeVQTIb9ZCiwU5QKDX1jj6tfWnz+f84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDJjHiaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B137C4CEE3;
	Sat,  4 Jan 2025 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966831;
	bh=WsNcFOLFSIUgSlVfe8sm/txYpSk69r/6/ZOCmfjclDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDJjHiaq7bRt6YiiKnsNGd2gM1tf8WLJBpBKYKWhHO9dS9b3bVQ49xSYScVIy2I21
	 g8QkcfWKTat6vvaU40A2CexqL5sZgiiTRQjLybPVHGGvcvsyZjlztOd+1FNvOXHxuw
	 hpyi8VdBQkB8LDX63vzS7MpeLiC72z7/8Gu9YSQBe1tH6VUQ59BmpRxm0zHVjvrNK0
	 J9EJ9pwf7X2f1iayezJu2e/c1zbnf0KP0cQrG3VHWQEcQNT4waddbDHKe9z5kSM9dz
	 U/gVg7z3VHqfthG2Y2kaQlhRIRrNdeOMIh6bUq+9S8g+cOycTrHI1Qux2T2PNq3Wbv
	 /ps4Cgd7rgOvw==
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
Subject: [PATCH v9 02/18] nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
Date: Sat,  4 Jan 2025 13:59:35 +0900
Message-ID: <20250104045951.157830-3-dlemoal@kernel.org>
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

Define the new vendor_id and subsys_vendor_id configfs attribute for
target subsystems. These attributes are respectively reported as the
vid field and as the ssvid field of the identify controller data of
a target controllers using the subsystem for which these attributes
are set.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c |  5 ++--
 drivers/nvme/target/configfs.c  | 45 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2962794ce881..b73f5fde4d9e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -522,9 +522,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 		goto out;
 	}
 
-	/* XXX: figure out how to assign real vendors IDs. */
-	id->vid = 0;
-	id->ssvid = 0;
+	id->vid = cpu_to_le16(subsys->vendor_id);
+	id->ssvid = cpu_to_le16(subsys->subsys_vendor_id);
 
 	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..4b2b8e7d96f5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1412,6 +1412,49 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
 
+static ssize_t nvmet_subsys_attr_vendor_id_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "0x%x\n", to_subsys(item)->vendor_id);
+}
+
+static ssize_t nvmet_subsys_attr_vendor_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	u16 vid;
+
+	if (kstrtou16(page, 0, &vid))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->vendor_id = vid;
+	up_write(&nvmet_config_sem);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_vendor_id);
+
+static ssize_t nvmet_subsys_attr_subsys_vendor_id_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "0x%x\n",
+			to_subsys(item)->subsys_vendor_id);
+}
+
+static ssize_t nvmet_subsys_attr_subsys_vendor_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	u16 ssvid;
+
+	if (kstrtou16(page, 0, &ssvid))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->subsys_vendor_id = ssvid;
+	up_write(&nvmet_config_sem);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_subsys_vendor_id);
+
 static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
@@ -1640,6 +1683,8 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_serial,
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
+	&nvmet_subsys_attr_attr_vendor_id,
+	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 58328b35dc96..e4a31a37c14b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -324,6 +324,8 @@ struct nvmet_subsys {
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
 
+	u16			vendor_id;
+	u16			subsys_vendor_id;
 	char			*model_number;
 	u32			ieee_oui;
 	char			*firmware_rev;
-- 
2.47.1


