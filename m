Return-Path: <linux-pci+bounces-33914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E57EB23FC7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99431627E39
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A62BD5BC;
	Wed, 13 Aug 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mPRd4J/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8B23D7E4;
	Wed, 13 Aug 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060352; cv=none; b=DvZIa5WJPLCJL5RMu/S2yK/9yBeq0BAXYPHjAI1kdDXBnxPa/0PbkfEGn9JmywIaNIgiXjK4vjez4BTaM+fBsa03xFpeV89s0igxpKwW6DBNjaF2coMu5SRf3whL92LifU/YZwTTec6Dx1Rzsst1hpK0hNjqgeIXYXRCMeyXtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060352; c=relaxed/simple;
	bh=Aval5zk1VgFJgPoCb1Z+VYhn5vHXyVwG2wThqQn9Cg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOW2Q7/64I7bW/mecvUyUgA/JYJwip3+2P5AFkG8Ehu3mjHEQ/gz/XeJSOWfFIg1DxShMxSLSErXvrS1hxDBlqKRZpXrNjlwO1mde1OfoHsii5vBRNrL51awNDaILFw9CIGSNuTDwlX5NDbO2C3tGQaiMCXnuLzpyBtXP0/3DKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mPRd4J/O; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6W
	NamUFnScGmcGW4V2poSQwnw1TE8eT2FVftvMi/L8E=; b=mPRd4J/OvYr5NQf9M+
	Qekf5Ymtc2hLwQCH2pHiPTHYTPRJgg5LQYyFRxscBfik8nZzsFb/bRImJAUQUg9C
	fte+8fjKZwgAFEJY4ng9wQOvAGLEMnDqwrfwBlwGb3KDY7pq+sDAwGCbln4ErzwY
	U0dpZqS9kX0h6Z8kNSOQ/6Aa4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S5;
	Wed, 13 Aug 2025 12:45:36 +0800 (CST)
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
Subject: [PATCH v4 03/13] PCI: dra7xx: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:21 +0800
Message-Id: <20250813044531.180411-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkGrWkKr1xuFyrXF13Jwb_yoW8uw4xp3
	y3CFZIk3W7Jan5X3Wqv3Wku3WSvasavr4Utan7Kw1fZF9Fyr9rtrWFyry8tF4fuFWj9r12
	ka15t347Xw4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRczV5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwyoo2icD7TgrAAAsH

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


