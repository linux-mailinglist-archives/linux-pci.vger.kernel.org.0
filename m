Return-Path: <linux-pci+bounces-33925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B43B23FE4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E263ACAD7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084322D0623;
	Wed, 13 Aug 2025 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oZIvmgky"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB4029A9CB;
	Wed, 13 Aug 2025 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060365; cv=none; b=sX7t/a5SbfjqDRmkEfVyJlpamWCxyYpQI8k2L0W0yjtvut2u/VhavshW6CiXMYjfLfP5wNPQFXJEak5UpspWfd/jn5CCqk1aVPUb3pk5oZrplwbXBOUnB/pG1xGFPSEH/4PYFVQACYJUWxnnX/td4pop3h+HlWVBWzO57piWz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060365; c=relaxed/simple;
	bh=X2ULA3wtv07dwjO/8i4ptLUuuyTx6rDSdQW4HnYB9Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AU/7RVj11svOdxSlTppiSeljnkDDpxgL11agmHa1cmj544GvliO5lh7JykGrZ4LSuN9/WW10K76hsWKrSi3pJezfKemiVT0O8tJi0dtz86aRxINyZv3J04VBOjRr6yd+8O+Jhi2FXMK5r9G6eSFgS03iL05sZ3LaiZuyMmP1tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oZIvmgky; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+B
	Bjrc0EVkwRmuejXLpU8+j4fD1/hPN0cQ6RirtS1XI=; b=oZIvmgkyi2n1c3gxam
	x8iTBYVz44vhGnlDdZGHpBSr/JQ6CqanXVLvf9HUcTQ6xcTwb8VqRMv4fBWN0zIY
	YhyrvSuR55afBg39MKzwegrdQiBsaa0RjHWbzNQIxhkih7i6QrN81KJnPWimtitl
	YarlnFPnlJxHZM8Kr8DApOOxs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnCKx4GJxoOGujAw--.23777S5;
	Wed, 13 Aug 2025 12:45:47 +0800 (CST)
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
Subject: [PATCH v4 11/13] PCI: qcom-ep: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:29 +0800
Message-Id: <20250813044531.180411-12-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDnCKx4GJxoOGujAw--.23777S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17Kr17ZF1UGr4rtrWUArb_yoW8Kr4Upr
	9xXrn0kF1xJr4rur4qka1kZF15JFnxAFy3JFWDKw1avFy7CF9rtas0ya4aqFn7GrW2qryj
	934YqayrW3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0fOcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgmoo2icEADWQAAAsK

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


