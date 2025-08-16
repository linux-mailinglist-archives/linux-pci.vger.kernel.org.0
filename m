Return-Path: <linux-pci+bounces-34131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486FB28F61
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99159AC4EC1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC61F8ADD;
	Sat, 16 Aug 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LndG2yDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042ABA4A;
	Sat, 16 Aug 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361110; cv=none; b=cmpYNkPE9OTjJA1th5Z249McCupm9/Vfw7+dLEqF7oOYkyYND1ZjZ0eW07TPt6qzYqYO4RXNWPYZo1yWic9fg+M9bY9A3SpMG1dU7HeyJAfWANRH6cO/s/loWuDBX1HPJvgaP3UcxT046DkJM1y4TiCgD1k6JvvRo1F/8bTLd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361110; c=relaxed/simple;
	bh=DLGSX65STygYHE+Pi9D4IKiSoKgjyIjqDwQCK/jBT6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNDrhCMxTsARP7fv7Q15D1YDF8UfztMPhos1Txlj4Oh40IMk+k5fEWA12i0KGdSqNIBDRzvWk198Mi1aCx6IgFWDsDVcbD3B8QpWUV7kXUWM/kTroE110bv4xKw8iDpQc1WUphRTfMianoMWJMGCABQ01Pb5j8vf4bz1YbbSFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LndG2yDG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=a5
	iiUaG3yzqBazOOhbSc8BcO1MW4L1VVCUInIq8Mejw=; b=LndG2yDGVWUZgKf/E+
	IJYxXlVB9hfzmp5RjWIpjWrCoglZ63g/C26bgEordPGppJPEvm9Lc2kAIdha54xp
	ms/bbpps4oKREZYB/Epid2bvuKXs8VkBAxvdsizoJ+gXHVM2JiRe5UiOw3I/VPrW
	8uf1gQJSxycJMXdoUu/sKMaDY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3ORMpr6Bo6AZqCQ--.35081S2;
	Sun, 17 Aug 2025 00:17:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3] PCI/AER: Use pci_clear_and_set_config_dword() to simplify mask updates
Date: Sun, 17 Aug 2025 00:17:43 +0800
Message-Id: <20250816161743.340684-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3ORMpr6Bo6AZqCQ--.35081S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry8WF1kKrWfAw4rAFyrJFb_yoW5ur1fpr
	W3AFWfAr4UJF15urWUWaykAr15Aas2y3yfKr93Gwn5ZF4UuFZ7Jr9avw1UA345KFZxXw4f
	Jws5Ka18ZF4UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEKZXUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgero2igp0CpeAAAsL

Replace manual read-modify-write sequences in multiple functions with
pci_clear_and_set_config_dword() helper to reduce code duplication.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes for v3:
- Rebase to v6.17-rc1.
- The patch commit message were modified.
- Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Changes for v2:
- The patch commit message were modified.
- New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
---
 drivers/pci/pcie/aer.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d716..3d37e2b7e412 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -176,14 +176,13 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 static int disable_ecrc_checking(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 reg32;
 
 	if (!aer)
 		return -ENODEV;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
-	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_CAP,
+				       PCI_ERR_CAP_ECRC_GENE |
+				       PCI_ERR_CAP_ECRC_CHKE, 0);
 
 	return 0;
 }
@@ -1102,15 +1101,12 @@ static bool find_source_device(struct pci_dev *parent,
 static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 mask;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+				       PCI_ERR_UNC_INTN, 0);
 
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
+				       PCI_ERR_COR_INTERNAL, 0);
 }
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
@@ -1556,23 +1552,19 @@ static irqreturn_t aer_irq(int irq, void *context)
 static void aer_enable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+				       0, ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static void aer_disable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Disable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+				       ROOT_PORT_INTR_ON_MESG_MASK, 0);
 }
 
 /**

base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.25.1


