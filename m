Return-Path: <linux-pci+bounces-35020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117EB39F8A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186E1563D6F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD761E98F3;
	Thu, 28 Aug 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JRDV18nZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9881E832E;
	Thu, 28 Aug 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389654; cv=none; b=qkDB8ObBqnSX9EX8+THZuK5OiS6kg2sK5CH+0IeTDJWApIyKw9jBgmPsIgpMzY4Brlv4McvyLFe0HQOuiRXU9teAEHmNq8A2lZIjphAmZDDu2dL3CIqgL9sijklFXXkcrpdhMMuRb7Y/OqY2X8gp814tTVnz8WnK/17xnp4nraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389654; c=relaxed/simple;
	bh=0hsAwdZcPAE8109DLO0fnD5sMW8/O2GLi22R2B/RC90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8Vnb9eqy9yff6alC2XggLTmFi2sDViUUe5vIPpfz5YyaPX20bRRkG8CxemKc87swZ/u87WPP3bPr8Fk7fzEXQecZaYTU1ttE+4FJ37sHckArYD8I03+1Yy9mkjow9hWJCaEzhclVZhgi1WAPZ5mViwWP8MPiAiy5rcsmrlbd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JRDV18nZ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oc
	jlTfawx1uBp25HtMisxcsc9MSmpuwcJgDpomBHE9Y=; b=JRDV18nZRmWY/h/0gi
	AxG9kSc/IoQT/MFQ0jakMy8kA0wo4MLkyLOHkjju05Cge7sOIxh3zlXc6gbLayrI
	Xd2X5+Vt+vX7c3iNAptdSHTfwWpznHXwelxq3JZ0oo7t+tPfjbyhWy4Hw00ngBkg
	HBTpq1+7WTupdD8fHFHRitpRs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S5;
	Thu, 28 Aug 2025 22:00:38 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 03/13] PCI: dra7xx: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:41 +0800
Message-Id: <20250828135951.758100-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkGrWkKr1xuFyrXF13Jwb_yoW8uFy8p3
	9xCFZay3W7Jan5X3Wqv3Wku3WSva93ZrWUtan7Kw1fZF9Fyr9rArWFyryrtF4fuFWj9r1j
	va15tw1xJw4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRcVyDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwS3o2iwWuaXkAAAsw

The dra7xx PCIe driver implements suspend/resume handling through
direct register manipulation. The current approach uses explicit
read-modify-write sequences to control the MEMORY enable bit in the
PCI_COMMAND register, declaring local variables for temporary storage.

Replace manual bit manipulation with dw_pcie_*_dword()
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
index f97f5266d196..44fbd6751004 100644
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
+	dw_pcie_clear_dword(pci, PCI_COMMAND, PCI_COMMAND_MEMORY);
 
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
+	dw_pcie_set_dword(pci, PCI_COMMAND, PCI_COMMAND_MEMORY);
 
 	return 0;
 }
-- 
2.49.0


