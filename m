Return-Path: <linux-pci+bounces-18877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F179F8F4B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F314163C36
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215671B6D08;
	Fri, 20 Dec 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLjndots"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD2199E84
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688247; cv=none; b=XvvK/gQoVqN35PtXPvStNz+KpdkBLxDkAZuS1ztyF7cz0DSXE7pqCAOZFjr165dWvPNRhzGxoPnEzWrCjOSmU5lgL8Ymnn1CCZaWwTp4LvtVb8BxipU07j1v/QLYC9Z+QvdFsH/oq+qDH5l3p4nLhTNk78lQ42m6pYQs21b+sYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688247; c=relaxed/simple;
	bh=N/B1pRo6hOVQWHt3ZbjWuweqtwlmHGsn/bfBCzS3Z8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m24fCBymI5T2zCs1hmcD1fcr8FZk4xGiJBIwXwlwZTmaci+/a3l69ZqYcChlhYGx4F5UMDQmxbz3scORB1FAh2vq0SeCXcCve5o+CLmS+8fWUXZKwToJepg13JH2KmmhumnFq4hZNgKH8brhp+UBiNKeYswmiznLvv0z6lT9SMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLjndots; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21D9C4CEDC;
	Fri, 20 Dec 2024 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688246;
	bh=N/B1pRo6hOVQWHt3ZbjWuweqtwlmHGsn/bfBCzS3Z8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLjndotsiIgpGeTTVF6KtlAjSELISK6g3jiUNKWcIgWGXxBTZ2fV063NcMEh+7OZf
	 3vRmbW0IqYAfcPt25apJLso8ukw+9oxIHr+gY492CZ4zwqFOFXT9ACmNXGoLCqqsHs
	 nqFm/W2JlzzEHji0vPJgNX9eVIDVlqmHzzROdcjNzcrMAI6qGZXmiEG8wS74wTFhQq
	 8wJOb06dCY/qDLyETmYtlYoCkV+TKfMB6ztVqPjFKfQ5aNaLVDvNm3qfC84uvpJ1lx
	 PUUXgfUINjvb5eOvNAWBZjAxQlVITSMNek+kJF7fhni4mBYM4JjN5/sfWs8vwZmUtg
	 Bpwlq7wDeMN8w==
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
Subject: [PATCH v7 02/18] nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
Date: Fri, 20 Dec 2024 18:50:52 +0900
Message-ID: <20241220095108.601914-3-dlemoal@kernel.org>
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

Define the new vendor_id and subsys_vendor_id configfs attribute for
target subsystems. These attributes are respectively reported as the
vid field and as the ssvid field of the identify controller data of
a target controllers using the subsystem for which these attributes
are set.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
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


