Return-Path: <linux-pci+bounces-26992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF09AA06AD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB57A30C5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC329DB6C;
	Tue, 29 Apr 2025 09:11:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA5EEAA;
	Tue, 29 Apr 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917870; cv=none; b=p/9dLTV1iXeHhWfHSFJvL6rPO4f+ZtZm2wVakT/iSmxyA+ODz8sLKpKGD8BMXCRe42XhDnnFnR6jNr5WiGdPBPB8xNc7ueriykwZ4AzxRUTM2OMvU/DSJPOKULfYR6a7m3USQ7hb2MIxva4sfyVW1CbfhcxioXKPapr5girjiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917870; c=relaxed/simple;
	bh=r4peHXIo6sy7zN1e3ALPfyjtV364TvEDwLkMOGZlq4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNnDdSbMerbKbGTIErknYElMHoXmsc1qwnLYSXhWehTeK83anOE2Cxgn4LqjUoDVH1WbE0kwKJFgkqEaVqRYqVYFh/GRUhc4+OWY9d4uz8I8TXPdAlFdEGjI7BesNXz8LUl+X/Et7b1pSaXnpLl/r5lP/BYgLDPdG8JBFyHX/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.1])
	by APP-05 (Coremail) with SMTP id zQCowACn4wudlxBobHGZDQ--.10875S2;
	Tue, 29 Apr 2025 17:10:54 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	will@kernel.org,
	sunilvl@ventanamicro.com,
	qiaozhe@iscas.ac.cn
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: PCI: Release excess memory usage.
Date: Tue, 29 Apr 2025 17:10:51 +0800
Message-ID: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn4wudlxBobHGZDQ--.10875S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15KryxWry8Aw1DAF1xAFb_yoW8Ar15pF
	4a9r1UCr4kJr1UXFs5X3Z5ZF13Wan7KFWjkrWxAws3ZFsI9r4UtFZIyF1F9ryfZrs3Aa13
	ZF4qyFyUCF1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoX
	o2UUUUU
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

In the pci_acpi_scan_root() function, if the PCI bus creation failed,
the allocated memory should be released to avoid memory occupation.

Fixes: 789befdfa389 ("arm64: PCI: Migrate ACPI related functions to pci-acpi.c")
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>

---
V1 -> V2:
Modified labels for better readability.

---
 drivers/pci/pci-acpi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..bde104ecac80 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1677,15 +1677,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
 	if (!root_ops) {
-		kfree(ri);
-		return NULL;
+		goto free_ri;
 	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
+		goto free_root_ops;
 	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
@@ -1693,7 +1690,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		return NULL;
+		goto free_root_ops;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1710,6 +1707,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
+
+free_root_ops:
+	kfree(root_ops);
+free_ri:
+	kfree(ri);
+	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
2.43.0


