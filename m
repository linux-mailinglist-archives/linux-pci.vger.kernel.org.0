Return-Path: <linux-pci+bounces-26896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF0A9EB3D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885B2167A4A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06B25EF84;
	Mon, 28 Apr 2025 08:56:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BC1FFC45;
	Mon, 28 Apr 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830586; cv=none; b=gRORRpCV1XpvrKyX7RENZ0fAetlPafxmtEVQVyKOqhcZgkjGD+7c8eOwvQl3RdfBxj7RegV8ji/RV7HuBMtIb6+9cvTnaYTNmvJT6/1MF5JUVBEQ8SWY4TEHdBiqNkfgea2WMvTE+olzbAgjRPMuiGpvZUP6cixUZ88wGUtUdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830586; c=relaxed/simple;
	bh=kQp2bHzjlTCRxi6vyy6/FtNiSB0ejqxY2qjWlveqdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xj9UkFGSOmd17rmm95ZAF8R3BDDsV7mSIzezaI2tVUxK4vGktOIPGO2bw7stuJKLFLfix7/qpgseSi3huk5PN8xVTyswtMwkHQo7j53cKuwdhMa2cNEdHzGzGt73knsI11m+F4mqbwV4JUXjMrzTIcTSTji626tezy+yDJoeBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.1])
	by APP-05 (Coremail) with SMTP id zQCowABXlAyrQg9okMAZDQ--.14298S2;
	Mon, 28 Apr 2025 16:56:11 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: qiaozhe@iscas.ac.cn,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: pci: Release excess memory usage.
Date: Mon, 28 Apr 2025 16:56:10 +0800
Message-ID: <20250428085610.727327-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXlAyrQg9okMAZDQ--.14298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr17Cry7tFyrWw47GF1ftFb_yoW8GFykpF
	WaqryUAr4kJr18WFs5Z3Z5uF4FgF4vkryakrWIywsxZFs8ur45tF9IyF1F9r9xurs3Ja1a
	vF4vyFyUGF1qyaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUvAp5UUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

In the pci_acpi_scan_root() function, if the PCI bus creation fails,
the allocated memory should be released to avoid memory occupation.

Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
 drivers/pci/pci-acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..b008dbed7077 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1683,9 +1683,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
+		goto cleanup_exit;
 	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
@@ -1693,7 +1691,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		return NULL;
+		goto cleanup_exit;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1710,6 +1708,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
+
+cleanup_exit:
+	kfree(root_ops);
+	kfree(ri);
+	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
2.43.0


