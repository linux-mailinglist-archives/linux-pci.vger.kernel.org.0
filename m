Return-Path: <linux-pci+bounces-29133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA9AD0E43
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624B316244F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E8B1B4248;
	Sat,  7 Jun 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GhXVN+L7"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAA13AD05;
	Sat,  7 Jun 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311562; cv=none; b=Wa57WqhXgB/aDlXM3zGWhZCEcxiODfQ8Hl0ojSEBJHUuMiwYW9NyWeja5zTaqdtRzdkkuPi19/Rqlwyd46Zgbj4zIIGP3aLniNWvBDEAiydBh1ohhsk08wSHDphINDrjfrBzCF2f6bors6ioEQJPHl8Ggya6UizaRzwM+30qx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311562; c=relaxed/simple;
	bh=TXILFu9/mk5P8ay7BUtsp1FAJk1pZTISkb8vZbLV3Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXuAwgyBV13+Yse4B4lXEEmhO5c0izG+fB1kaU9tGA6/qYfR/VdUMId0jbDexQSflU3uXmpxP0nfpOiGj52vh8rBX6xrIGJxMv21EpTj+380bAqt2XFh8qXxwoM81TOdGYjWe3DQAah/tILY7y4bXfzn7L4AWIDAKT3g9QcUXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GhXVN+L7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UK
	Da40I0u1fLgDBEqwi9HdVUgYBePD5D6X2Frp4VUjc=; b=GhXVN+L7/RTx1R9Z60
	yyriw21vGGe4kF9td2SU3KTuR3r97iwbUVXHCmeBzpam9B5ChUnHk3rKdMMBjrF0
	eyKxfDATDtbC30bVWLWKDwZTt96TQ0756D+Er37SOIPllQqfB9xJ5kzgcAFuYF4H
	XNswf7L/m8R3RB5N5HVUz0brQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXM_kjYERoFeepHA--.4808S2;
	Sat, 07 Jun 2025 23:52:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	manivannan.sadhasivam@linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2] PCI/AER: Use pci_clear_and_set_config_dword() to simplify mask updates
Date: Sat,  7 Jun 2025 23:51:59 +0800
Message-Id: <20250607155159.805679-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXM_kjYERoFeepHA--.4808S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4fXF1Uuw13Cr1rZr4DCFg_yoW5CFyrpr
	W3AFWfArWUJF15urWDWaykJr1rAas7t3ySgryfKwn5XF4UuFZrJr9avw1UJ345KFZ3Xw4f
	Jws5Ka1ruF4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKYLkZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhVlo2hEXNpMQQAAsO

Replace manual read-modify-write sequences in multiple functions with
pci_clear_and_set_config_dword() to ensure atomic operations and reduce
code duplication. 

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes for v2:
- The patch commit message were modified.
- New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
---
 drivers/pci/pcie/aer.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac66188367..86cbd204a73f 100644
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
@@ -1101,15 +1100,12 @@ static bool find_source_device(struct pci_dev *parent,
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
@@ -1555,23 +1551,19 @@ static irqreturn_t aer_irq(int irq, void *context)
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

base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1


