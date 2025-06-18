Return-Path: <linux-pci+bounces-30083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8972ADF151
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FEC1882967
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43A2EF673;
	Wed, 18 Jun 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KcaorCMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB42EF66B;
	Wed, 18 Jun 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260113; cv=none; b=IWMJ8nMgRWsM4G/jFmikJJVh7qmYFPE3EgijBK07SzG7/lgz+AxeeUGO/Jfb9jCEbl29NQGSFDSaR174ayP/FK2Mevp19sTINW9DaOghGMgW4VkOmAmY1iYEZh7J+4auXNekQnLqn2WQkEupzpuxCm2M3Yr3bOLVSoiB8cKdN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260113; c=relaxed/simple;
	bh=X2ULA3wtv07dwjO/8i4ptLUuuyTx6rDSdQW4HnYB9Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVX7wCGXblyrw8Y7NOUF8S6G/xmqF2zvWiJkRqvz5d1XygGU8cBB9C1rZWN+m5eTYU4OF7+XxCmK+Jx9s7/E0sDKRrjd7/sN/W6aF/tDSUVbhU33Og2RCnhiAHFOJNPnQchLcHemLkyLtVxIf42VAeEKdKCW3M4lKMSXhBZIxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KcaorCMr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+B
	Bjrc0EVkwRmuejXLpU8+j4fD1/hPN0cQ6RirtS1XI=; b=KcaorCMrMFuRM/1zlu
	OHLf+evk0XJyD3HX2bQUrhNY/FuVSCPewIMGarw8vFlw+lKmqTtjZdaFPvHfMKsO
	YUrKUcJUsELOByva+DP0UK0H5FDDarnCs/tfujCcwIHHirmjurVMQY4auXATjVcJ
	uw1X/cjwX41GH65wCrcZJMNZY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnr96E2VJo_+eqAA--.17078S3;
	Wed, 18 Jun 2025 23:21:41 +0800 (CST)
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
Subject: [PATCH v2 11/13] PCI: qcom-ep: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 18 Jun 2025 23:21:10 +0800
Message-Id: <20250618152112.1010147-12-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgBnr96E2VJo_+eqAA--.17078S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17Kr17ZF1UGr4rtrWUArb_yoW8Kr4Upr
	9xXrn0kF1xJr4rur4qka1kZF15JFnxAFy3JFWDKw1avFy7CF9rtas0ya4aqFn7GrW2qryj
	934YqayrW3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_wZ29UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwxwo2hS1CaEpwAAs3

Qcom PCIe endpoint driver implements L0s/L1 latency configuration through
manual register manipulation. The current approach reads LNKCAP register,
modifies specific latency fields, then writes back the value. This pattern
repeats twice with similar logic but different bit masks.

Replace explicit latency configuration with dw_pcie_clear_and_set_dword().
The helper combines field clearing and setting in a single operation,
replacing three-step manual sequences. Initialize the set value with
FIELD_PREP() to clearly express the intended bitfield value.

This refactoring reduces code duplication in latency configuration paths
and improves maintainability. Using the standard helper ensures consistent
handling of capability registers and simplifies future updates to ASPM
settings.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index bf7c6ac0f3e3..c2b4f172385d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -475,17 +475,15 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_L0SEL;
-	val |= FIELD_PREP(PCI_EXP_LNKCAP_L0SEL, 0x6);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
+				    PCI_EXP_LNKCAP_L0SEL,
+				    FIELD_PREP(PCI_EXP_LNKCAP_L0SEL, 0x6));
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_L1EL;
-	val |= FIELD_PREP(PCI_EXP_LNKCAP_L1EL, 0x6);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
+				    PCI_EXP_LNKCAP_L1EL,
+				    FIELD_PREP(PCI_EXP_LNKCAP_L1EL, 0x6));
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
-- 
2.25.1


