Return-Path: <linux-pci+bounces-27023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44870AA42D5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 08:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F2F9A571B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 06:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED151E5710;
	Wed, 30 Apr 2025 06:06:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE561DE2A7;
	Wed, 30 Apr 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993187; cv=none; b=AKShaDfWlYKok1LzjAb/+xcFbToaep0oA5pkRyYBDS9RIXvOw2dy7VU1m8LVFld9iSDhl8Mg49uxaeB53psJKLlbM4phec9kLnyn6BG3UY1wrgvfrlDDYNY/M5AAiHr2Xbhb/saGTV3h41GZUP/QSnj9wR3lH30AM7+eppjT2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993187; c=relaxed/simple;
	bh=/9EuBGhLDAqDWQh+uj7p2pD/pn0f2ryUU4Pg0EoxAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6UvdZlkUkJW/Dnx02ycc/B+wcGu3gmvXX7wZ2HGlCSLPj4ovrVqUnocIxrIy9z/y4gjLe3/enMRwCETMeUjfMNWd4toDTuLntwG7mWVC9spKrfB3ga0UZ/qA806v+7spZHt6OVjzbI/pvd8Ol0w+dNXH4UyZ3QtdrS73C1ioJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.1])
	by APP-01 (Coremail) with SMTP id qwCowACnTP3YvRFoamrYDQ--.4752S2;
	Wed, 30 Apr 2025 14:06:16 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	will@kernel.org,
	sunilvl@ventanamicro.com,
	Markus.Elfring@web.de,
	qiaozhe@iscas.ac.cn
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ACPI: PCI: Release excess memory usage.
Date: Wed, 30 Apr 2025 14:06:03 +0800
Message-ID: <20250430060603.381504-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnTP3YvRFoamrYDQ--.4752S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15Gr1UWFWxAFWUZr4fZrb_yoW8CrW7pF
	4SvrW5Jr48Xr1UXFs5X3WkX3WfWa97KFWjk3yxZws3ZFsI9r40yFZIyFyF9343Ars3Aa1a
	vF4qyFyUCF1qyaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8AwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUK9aPUUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

In the pci_acpi_scan_root() function, when creating a PCI bus fails, 
we need to free up the previously allocated memory, which can avoid
invalid memory usage and save resources.

Fixes: 789befdfa389 ("arm64: PCI: Migrate ACPI related functions to pci-acpi.c")
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>

---
V2 -> V3
    1. Modify commit description.
    2. Add release operation for ecam mapping resources.
---

 drivers/pci/pci-acpi.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..e00790ecdc0f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1676,24 +1676,19 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
+	if (!root_ops)
+		goto free_ri;
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
+	if (!ri->cfg)
+		goto free_root_ops;
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		return NULL;
+		goto free_cfg;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1710,6 +1705,14 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
+
+free_cfg:
+	pci_ecam_free(ri->cfg);
+free_root_ops:
+	kfree(root_ops);
+free_ri:
+	kfree(ri);
+	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
2.43.0


