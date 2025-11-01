Return-Path: <linux-pci+bounces-40039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5868C28276
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A657D4E220D
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2862566FC;
	Sat,  1 Nov 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LXJ0jJPg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46E19049B;
	Sat,  1 Nov 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014258; cv=none; b=MpWyZyEQn9hyvCLh1/zM2nFDg/CgAXq4NZw7YUlilif2t+frfUC5Z33eg7ykj+5B1ORPyzoRP6GJXZ66D22/PgfUzF0TKKDUPXAsK1qeBRjTPaB5/dPj5NWYMItLh5i4ZAwANgq0kNWVuaSxOgW+GdDHIotKv5MMr5nBJXAMgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014258; c=relaxed/simple;
	bh=W1Ad/Hpmi05kW+LkYpX9iXeR3vzD1qS/oR7rcvv5ZMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFF+OQiuUSMrWTohaFS7vhH4xOeiePAsx7XlNg5o9s/E6mx9yrJ3QRdm+CMj5Ms5HST1iZ142ET1xLpakpiQrZFV3vuXX73UAyCMJFb7yV/9VkJ0jzlrtGCVUc8UzqADtTA2PzKiJF/gS6U5fevoCzuNJwnIKm2xVX12BqSWQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LXJ0jJPg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rT
	eDMOibmlghpQVXp52MOWLYZFEzyWAti7xjOoZt1/I=; b=LXJ0jJPgsEbN8jsn3g
	j7upqizSVegB/eDdNnZhbBIspuKLiGJThtOBLiXg7L6BWlV6VqKrjDLBc+PTLVAk
	jVirPP6XtUUMTAi6phZ1nGhBIHfcseWp0vjw0Avu5deeySv8l1tDysOit+kQO+F0
	OBlwNtc9NvBnoAojmi2mKMtrU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHBDkQNAZpNmGwAw--.59274S4;
	Sun, 02 Nov 2025 00:23:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH v4 2/2] PCI/AER: Use pci_clear/set_config_dword to simplify code
Date: Sun,  2 Nov 2025 00:22:19 +0800
Message-Id: <20251101162219.12016-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101162219.12016-1-18255117159@163.com>
References: <20251101162219.12016-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHBDkQNAZpNmGwAw--.59274S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDAFy7AF15tw1kJr4ruFg_yoW5Xw1UpF
	W3AFWfAr4UJF15ZrWDWaykJwn5AF97t34fKr93Kwn5XF48uFZrJ3sav34UJ345KFZ5X34r
	Jws5Ka1rZF4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE2YLgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiFQj4o2kGMU41FwABs1

Replace manual read-modify-write sequences in multiple functions with
pci_clear/set_config_dword helper to reduce code duplication.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d716..468d4a726a20 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -176,14 +176,12 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 static int disable_ecrc_checking(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 reg32;
 
 	if (!aer)
 		return -ENODEV;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
-	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
+	pci_clear_config_dword(dev, aer + PCI_ERR_CAP,
+			       PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
 
 	return 0;
 }
@@ -1102,15 +1100,12 @@ static bool find_source_device(struct pci_dev *parent,
 static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 mask;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+			       PCI_ERR_UNC_INTN);
 
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_COR_MASK,
+			       PCI_ERR_COR_INTERNAL);
 }
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
@@ -1556,23 +1551,19 @@ static irqreturn_t aer_irq(int irq, void *context)
 static void aer_enable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			     ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static void aer_disable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Disable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_clear_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			       ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 /**
-- 
2.25.1


