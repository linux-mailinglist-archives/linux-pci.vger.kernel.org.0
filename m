Return-Path: <linux-pci+bounces-35027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21919B39F9D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268E5564FBD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1428313E1A;
	Thu, 28 Aug 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mM+ZKc+W"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC722F386;
	Thu, 28 Aug 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389662; cv=none; b=rhV0wjfuQ2CxcgkV5b5lDREtQie8gyDEqJev3+ZaLmKINpJSmugyONk8QoUqO09zKguut+XrXdeALM6/HoM4g5Yz4dFTEzBedTOdILeHmwPUBK1YSrU6pfL5jh7txq5y6yBCPyK8tC6LjGLbYCxAt13PMT8cKTiwKmGUkVNjLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389662; c=relaxed/simple;
	bh=5df3RGho6r42QWkTtUye6qzUG6TBAaDxuOqzpAayFxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3MO/3Hr816ubvRLnjD219Z1HPjXxuiCXOALSR6wKCvafOSSV7Wg62IH5MxrkwLppfNBp3C2dvUYukNl5rTaCPrqBIapJ1Gvadhx3Wtf++hKjRW02QG/nJNYX6Ww5kSgITw/w3htWhs0eVxZocxrubpJaDlR3jC9BsaR2XjBbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mM+ZKc+W; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6R
	oicKHemQL4qB4DOeBZeDg8XqBSHJedP0pmE3ET/74=; b=mM+ZKc+WnavRvuXZnX
	4zD+qtdjqvGnF1TTiYc25VRFd8gV+gZSMKGeDzZ3Qi7fEF3zToML9Oec15UuvMdW
	PQtn2bR85UraUfpMEQsyHo7NNxsri/TTf/Jnrw2M7BU6QKkrUKbr08xiALZXlA8j
	/EFvUSjyr/jp4EyRGHiGhHyPQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S5;
	Thu, 28 Aug 2025 22:00:48 +0800 (CST)
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
Subject: [PATCH v5 11/13] PCI: qcom-ep: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:49 +0800
Message-Id: <20250828135951.758100-12-18255117159@163.com>
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
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17Kr17ZF1UGr4rtrWUArb_yoW8tw4Dpr
	9xXrn0kF1xJr4rur4vka1kZF15JFnxAFy3JFWDKw1avFy7CF9rtas0ya4aqFn7GrW2qr1j
	9w1YqayrW3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0ks9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxS3o2iwWlmlWgAAs-

Qcom PCIe endpoint driver implements L0s/L1 latency configuration through
manual register manipulation. The current approach reads LNKCAP register,
modifies specific latency fields, then writes back the value. This pattern
repeats twice with similar logic but different bit masks.

Replace explicit latency configuration with dw_pcie_*_dword().
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
2.49.0


