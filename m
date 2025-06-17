Return-Path: <linux-pci+bounces-29911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B36ADBF3F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F2C7A14E6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03237214A9E;
	Tue, 17 Jun 2025 02:38:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DD2BF014;
	Tue, 17 Jun 2025 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127902; cv=none; b=EgtbWwNzlkNP6Ufpl/nrXMXxi14R+7WdSRk0zyyen0gOKRQnSFjvbjtPmd/5OVZZSIZ8Q3WNOnQBFG+jJz2WraMBCoIX3PXQzNlUXtmN8hvKt0ZgVqAaRt+puZpe0smPZE124Lget+MuZKCKLrOHjtCm4B+DkaHlkfQruHeeNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127902; c=relaxed/simple;
	bh=r0BIgDO0Z8ZbJ8RcYgA6ji/k7/gGIKduFudNuXuBwZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIcnKv2k4+biTCBQhubCP2Ah1EkiVpfaD19n/XZPjn3EuNYhQ6+7u8Qt4BnPh5j8jfTo9+go4Skd9PyWzkBipulu75kwxOYpoyMzlSOLkO9pNnGW9PMyy3LvOqGVbnKHhO6qQQUp5JA+E1CAZqclAC59GlhdRRbUNhcGYigA5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowACHCgkS1VBop6IkBw--.5577S2;
	Tue, 17 Jun 2025 10:38:11 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: rafael@kernel.org
Cc: bhelgaas@google.com,
	lenb@kernel.org,
	kwilczynski@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	qiaozhe@iscas.ac.cn
Subject: [PATCH v2] PCI/ACPI: Fix double free bug in pci_acpi_scan_root() function
Date: Tue, 17 Jun 2025 10:37:38 +0800
Message-ID: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHCgkS1VBop6IkBw--.5577S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fZr13trWfAF18JrW8Zwb_yoW5Xr43pa
	1Sqw4UAr48Jr48Wr1kA3WkZF1rZFZ0krW7KrZ7t3ySyF47ur1jvFZrAFyv9r98Zws5Ja1j
	vF4qqFyUJF1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUC2NNUUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

The patch "PCI/ACPI: Fix allocated memory release on error in
pci_acpi_scan_root()" introduces a dual release issue. When
acpi_pci_root_creat() fails, the pci_cpi_can_root() function
will release 'ri ->cfg' and 'root_ops' in the error handling
path.However, acpi_pci_root_creat() will also call
__acpi_pci_root_release_info(), which in turn will call the
release_info hook, causing the same block of memory to be
released again.

Fixes: 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()")
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
v1 -> v2:
 - Restore all changes from the first version.
 - Remove unnecessary release info hooks.
 - Add a NULL check before calling info->ops->release_info().
 - Delete the currently unused pci_api_geneic_delease_info () function.
---
 drivers/acpi/pci_root.c |  3 ++-
 drivers/pci/pci-acpi.c  | 12 ------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..83628adbc56b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -974,7 +974,8 @@ static void __acpi_pci_root_release_info(struct acpi_pci_root_info *info)
 		resource_list_destroy_entry(entry);
 	}
 
-	info->ops->release_info(info);
+	if (info->ops && info->ops->release_info)
+		info->ops->release_info(info);
 }
 
 static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..6e85816ee1c3 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1652,17 +1652,6 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 	return cfg;
 }
 
-/* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
-
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
@@ -1683,7 +1672,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!ri->cfg)
 		goto free_root_ops;
 
-	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
-- 
2.43.0


