Return-Path: <linux-pci+bounces-18261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF919EE524
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003FC2829CE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641A1211702;
	Thu, 12 Dec 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpAU+dkd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12F1F0E57
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003311; cv=none; b=Lx1GP5OBE5A7PpUJA67cJ6ox883Ol1fjHkTJ7kOfYEvb502CFF7tuea6D2AmgR+9vAaXMRS2A4o59HM1XrrTZJHR36e+OZirz01R4PHMA/8eU+3NFkPUFt7sdLDTx4Ims0ja/RisaL46dYF+VqY5gnA8Gp7ulR0aH2Y3rgW/y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003311; c=relaxed/simple;
	bh=N/B1pRo6hOVQWHt3ZbjWuweqtwlmHGsn/bfBCzS3Z8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBCD3Ip9Z64H2zA//y/InSkmTE3RSvModCg8ljTeuA0OMtvz5f1N7a6h67blN2wULH8OcjdApDtmxm+xKABW3+R8nGGdY/Bq6agQl7YVIiTZWqf8mChTCS5e9aM7QIx2ZAiYDQd0+CdS5PRnTHohg1SZoGsqXLfZ7n7rCEcR7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpAU+dkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27CDC4CED7;
	Thu, 12 Dec 2024 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003311;
	bh=N/B1pRo6hOVQWHt3ZbjWuweqtwlmHGsn/bfBCzS3Z8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpAU+dkd6TB5CMRUYW9cy0uD1zZNT5vXDnhurLoIEpRQjD/Fqb1WMv585fJ/BNrRZ
	 0qPF7RKlXGTjDX/6xWJQpZ/+AGV+VLa8jUZGQdoij+bJdgdFt5ZD8nGUWTGlC000Ka
	 Lz9xU0j6E4VnxWZxqsUzwKyH3bMlWh2VOIIsl2mtMyqoDSq6/cEv7RBjMI1txziCDz
	 XvDFhHGS/8lH49ph1VStxD4Y4aprXZaJ1RqYSkfKxbPqDqEiFDZm1yQcGnMLrogt7b
	 2dG9e1OBgGS145W6CS2X1D0fAlfz8EBOkUCVhduZivBB6pt+gWGHIEK/3eVIa29SEy
	 XwN16K8qjGn/A==
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
Subject: [PATCH v4 02/18] nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
Date: Thu, 12 Dec 2024 20:34:24 +0900
Message-ID: <20241212113440.352958-3-dlemoal@kernel.org>
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


