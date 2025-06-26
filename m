Return-Path: <linux-pci+bounces-30791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E4AEA1F8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848AE1763D3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDC302041;
	Thu, 26 Jun 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OBe9f+xP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA52FEE32;
	Thu, 26 Jun 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949554; cv=none; b=QRtfmnd2aH/y7VCH+Z5bVO9LCvX6vOwouOpLn55D/24RL3i9+mSmkhtJv+xdkXHEKYCZUPLHe2e5h1pZGhe1oGhgGYbhMuzmpjmfFPUjRhN3SyJw16nxV+3YRWqMsSQPT0Ngbg0KAE80g+Y7aNtCVJUODi8ucbOy0pTUycB4aGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949554; c=relaxed/simple;
	bh=X2ULA3wtv07dwjO/8i4ptLUuuyTx6rDSdQW4HnYB9Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsngeaM9hMwOH30meQMvSuP4hg2ExYIEkb/46W0sxP79NWLAUtc9AIcxRx9FFDdZkkhlHviwFyuCCBTdg5Rza/KHvLYhQfma8nkxVZFW1IUUKepD9FGSvZShsEZooD7PrDUKf9uMgOjMy1aOpK/HG2ZH7qeH89ydyGwk5wzYHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OBe9f+xP; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+B
	Bjrc0EVkwRmuejXLpU8+j4fD1/hPN0cQ6RirtS1XI=; b=OBe9f+xPal9mr63Xyp
	ksf/wSsz6MTgjSTdxLoSrDQkv/f5+N8wc9VumCA7hEwYuS9MDOS/944JuFynRK6Q
	uX9uDT5nBzGubhwbWpeQjLRdEyyj2oFehmo0oerq6g97QEG4EaKEaU2mroz1suMH
	6ehHC2NanoelCD8RqxxPVf08g=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnboqkXl1oRfOTAA--.15779S3;
	Thu, 26 Jun 2025 22:52:21 +0800 (CST)
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
Subject: [PATCH v3 11/13] PCI: qcom-ep: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Thu, 26 Jun 2025 22:50:38 +0800
Message-Id: <20250626145040.14180-12-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnboqkXl1oRfOTAA--.15779S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17Kr17ZF1UGr4rtrWUArb_yoW8Kr4Upr
	9xXrn0kF1xJr4rur4qka1kZF15JFnxAFy3JFWDKw1avFy7CF9rtas0ya4aqFn7GrW2qryj
	934YqayrW3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMD7aAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwl4o2hdXLQsPQABsc

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


