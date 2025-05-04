Return-Path: <linux-pci+bounces-27117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64025AA875C
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED733AC599
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376D1A8F9E;
	Sun,  4 May 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d/ttsc9l"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934691A23B1;
	Sun,  4 May 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746373472; cv=none; b=gU3549DM6fiQgMVHuSLhKr8xgLvkrC8o/jbVVriXD8+d190lkVGRXc8MvH0cageXUPkbB5pxGbcHNqRishfoWCQe86e/NWnjlv0vO906V9Fs0rPaWOGzhvaQ7vDlTlOzeHw9+ippjKQPrL6iTbbJ6BRCQpEdw6BFp1WRxH5wU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746373472; c=relaxed/simple;
	bh=2XXDdPRHzLVwXzTES3eVASsN/SiaDfbjCVCtAAcX52I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G95pMR0nFQI6GwWqaTjVzkxbS4bsAfam7kkRLx87W0GgpMa6fYnu+EM0zie02GY9V/UFRxwevbrsgJiBN1tkDClu4swayEOFSru5gpj5km+ZtyZyzrY6nMQl0wTfu3LjFCGvIgeJC72yA4WVxPxA4RxB9nBy2cF0y1NzLwOJaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d/ttsc9l; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iZJH3
	2h/nY81Ou36LPNReN8OUgsRTOeKJQp89h9i674=; b=d/ttsc9lYiDA8NMzyl89q
	ySKoYflxeMqwgisxmNc/BVipBDxkrGD49MIigHPfvkhcYcRqidjIzTlqfziKFDTi
	hWRKK60ylDV7sFwDoTu42gawnEq5mvCA8pLnGI8DG2bYlJa2wo708vtVp+s2tszI
	7tfColQKtOGeE6Uoi17mG0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXIWtAixdo8td6Eg--.52915S2;
	Sun, 04 May 2025 23:44:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	manivannan.sadhasivam@linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI/AER: Use pci_clear_and_set_config_dword() to simplify mask updates
Date: Sun,  4 May 2025 23:43:53 +0800
Message-Id: <20250504154353.180844-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXIWtAixdo8td6Eg--.52915S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1fCw1xCr4fGw4UWrWrAFb_yoW8GFyxpF
	W3AFy5Gr48Jr1YvrWDXayktFn8Gas7t3y8KrW3Gas3ZF43ZFZrtryavr1UJ345tFZ0qr45
	Xw1rKa18XF45taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zt-e58UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwVDo2gXf9nrMQAAsp

Replace the manual read-modify-write sequences in
pci_aer_unmask_internal_errors()with pci_clear_and_set_config_dword().
This function performs the read/write operations atomically and reduces
code duplication.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aer.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..20d2d7419fa4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -953,15 +953,12 @@ static bool find_source_device(struct pci_dev *parent,
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

base-commit: ca91b9500108d4cf083a635c2e11c884d5dd20ea
-- 
2.25.1


