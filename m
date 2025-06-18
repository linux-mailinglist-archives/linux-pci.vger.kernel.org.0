Return-Path: <linux-pci+bounces-30077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA118ADF11E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FBB169196
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043D2EFD8A;
	Wed, 18 Jun 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I+HIC5oP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293B2EF9DB;
	Wed, 18 Jun 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260101; cv=none; b=CoGFXMBcCKFxDWFeF3RmXnH8LERO2DVMjK9PpHNEgJoDINRI+UZMRcdJ0KzkDBIbjdBev+CGNrSaL75EYH5Dufl4JZnAPzLgRe9/4i0cracdSRctYVZFiM3cqjcb44N0EyN66P3cK8pZCsp1hyA/D5ZtlR+WOILFxv5GvfntKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260101; c=relaxed/simple;
	bh=Aval5zk1VgFJgPoCb1Z+VYhn5vHXyVwG2wThqQn9Cg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddAz50O3ZQzfJPg0rx6LVGr6p+kmaVUeif6HzqVObLfBiR5ANYmfXTxVi7MzHe9DNi9I3TRdcPZSG5FYzObX8hY+7a5aoXduoEWiu/3mhY0lWuUSgiaiwuAspZYM0D9hpYF6bTvh9bSrzHw/Ccmxiol3WS22dWYKJMqJM9K4MH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I+HIC5oP; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6W
	NamUFnScGmcGW4V2poSQwnw1TE8eT2FVftvMi/L8E=; b=I+HIC5oP1Px6bfE+S7
	WHNZZVDbNDqNFgufwydaOr31k1ODwwm3hTtGJwPGf7pNq1/2VBehEfZCdZFfj4yd
	N8ofrT7ABz8ghyKZwmiRnABkru7kOPAtqXrQ2XLZlrcsaNHm5hDilUhxvsS0PDK3
	d7cXoRxKx7gOPSmv5KWGGcdBs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHoedq2VJo3qQFAQ--.15407S5;
	Wed, 18 Jun 2025 23:21:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 03/13] PCI: dra7xx: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 18 Jun 2025 23:21:02 +0800
Message-Id: <20250618152112.1010147-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618152112.1010147-1-18255117159@163.com>
References: <20250618152112.1010147-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHoedq2VJo3qQFAQ--.15407S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkGrWkKr1xuFyrXF13Jwb_yoW8uw4xp3
	y3CFZIk3W7Jan5X3Wqv3Wku3WSvasavr4Utan7Kw1fZF9Fyr9rtrWFyry8tF4fuFWj9r12
	ka15t347Xw4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhSdkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxBwo2hS1CaCCAABsD

The dra7xx PCIe driver implements suspend/resume handling through
direct register manipulation. The current approach uses explicit
read-modify-write sequences to control the MEMORY enable bit in the
PCI_COMMAND register, declaring local variables for temporary storage.

Replace manual bit manipulation with dw_pcie_clear_and_set_dword()
during suspend and resume operations. This eliminates redundant variable
declarations and simplifies the power management flow by handling bit
operations within a single function call.

Using the centralized helper improves code readability and aligns the
driver with standard DesignWare register access patterns. The change also
reduces the risk of bit manipulation errors in future modifications to the
power management logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index f97f5266d196..9cbba1b28882 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -867,15 +867,12 @@ static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
-	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* clear MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
-	val &= ~PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
 
 	return 0;
 }
@@ -884,15 +881,12 @@ static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
-	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* set MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
-	val |= PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, 0, PCI_COMMAND_MEMORY);
 
 	return 0;
 }
-- 
2.25.1


