Return-Path: <linux-pci+bounces-30161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81389ADFEA2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFFB1898F5D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D124EA8D;
	Thu, 19 Jun 2025 07:26:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F18253B59;
	Thu, 19 Jun 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318014; cv=none; b=MR2l4OT0vOi++a6pyKTCPkSeoUWWf3PnpcksU/JcO59NFHJ6/I0EU8Jeh3jTH8KZYsAxn+w6WPLlfOtjOOG3V9JH6qHioQBr6ufXQB+rVrMwhoTJRnH41geg3MjSOLOn5caBL5eiEjnromr5cLKZmktomNPhyCbyWhKEYanBta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318014; c=relaxed/simple;
	bh=iCpk4Ta2PbMcNo7ezJMGauoRfwQ+nTHFFTqam5P1KPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBOm78nXrfqjmvkRy64SaPosZ085SGUbki7K6mbx/5XeE/jV/5T1cLWKoQF6TR9+Lc0OBURli6PpBahSn1fjifPuJ+8fzbUorOrpmhic4mpc0gJm9cN04fN7gWVKwKfTr/d/6P0TnSD8G1UoBQ+s3B+jaFLECspZAbdu33vuuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowAC3Kdiuu1NopOqNBw--.6183S2;
	Thu, 19 Jun 2025 15:26:38 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: dan.carpenter@linaro.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	lenb@kernel.org,
	kwilczynski@kernel.org,
	sashal@kernel.org,
	qiaozhe@iscas.ac.cn
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()"
Date: Thu, 19 Jun 2025 15:26:08 +0800
Message-ID: <20250619072608.2075475-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3Kdiuu1NopOqNBw--.6183S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kJr1rZF4ktr4kKry8Krg_yoW8uw4rpF
	Wa9rW5Jr4kJr18XFs5X3WkZF4rWFsIkay7KryxJws3ZF4Dur1rtFW2yr1F9FZxArs5Aan0
	vF4qyF1UCF1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj_b15UUUUU==
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

This reverts commit 631b2af2f35737750af284be22e63da56bf20139.

The reverted patch causes the 'ri->cfg' and 'root_ops' resources to be
released multiple times.

When acpi_pci_root_create() fails, these resources have already been
released internally by the __acpi_pci_root_release_info() function.
Releasing them again in pci_acpi_scan_root() leads to incorrect behavior
and potential memory issues.

We plan to resolve the issue using a more appropriate fix.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aEmdnuw715btq7Q5@stanley.mountain/
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
 drivers/pci/pci-acpi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..af370628e583 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1676,19 +1676,24 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops)
-		goto free_ri;
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg)
-		goto free_root_ops;
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		goto free_cfg;
+		return NULL;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1705,14 +1710,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
-
-free_cfg:
-	pci_ecam_free(ri->cfg);
-free_root_ops:
-	kfree(root_ops);
-free_ri:
-	kfree(ri);
-	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
2.43.0


