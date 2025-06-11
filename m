Return-Path: <linux-pci+bounces-29476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E878AD5C45
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E103A9450
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D91E0083;
	Wed, 11 Jun 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XDKjam24"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B62040B0;
	Wed, 11 Jun 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659580; cv=none; b=tfkbsaSlojwYkdyB/HfKypBufjqztpbOlUmN2jgT8zG/8ifr6RqFf0Z5JuD/ukBh62vyx1pJSK/IvoZV63P9p7ylerT4po2D5zjp/YANpMvkbnE1mZ+iJ6w0xMS8Dvj/S9GZ2T/9TxnsUyGzQ6+haYcTErtb9XZDhMkda5BTt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659580; c=relaxed/simple;
	bh=X2ULA3wtv07dwjO/8i4ptLUuuyTx6rDSdQW4HnYB9Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCPntJz20gk0kCVQR91nMwZN9kpDPnFHFVu2AkANXYg+of+Cr2sUUDk5+IOy51s+Xa9ONycEV5/o9AvpopO07xcTZi7z1ZfdOHMFlt32cyAJrqhqA2cVqCnRnk6OosobOcYCiRv2dxivbynKVrmJ2yKxC1n9K/PaXfxWUHrv3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XDKjam24; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+B
	Bjrc0EVkwRmuejXLpU8+j4fD1/hPN0cQ6RirtS1XI=; b=XDKjam24g2lXEV3TNW
	KHLXiTW6IEgYIC2VB/JGFKdTB3ZXyTHHTovxAEk71eufsuuuKMBcF6y0nCPLQpxL
	3jnJYCSLrFJ9L6mUIHcQh26nMI6htB5flP/1g1OzTmYYvkwlF+irGLfIVKxtZo/K
	Eg4ii4zuvFNjxtTRrHysMlfJg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnOl+Qr0lo+p9OHw--.15261S2;
	Thu, 12 Jun 2025 00:32:17 +0800 (CST)
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
Subject: [PATCH 11/13] PCI: dwc: Refactor qcom-ep to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:32:15 +0800
Message-Id: <20250611163215.861242-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnOl+Qr0lo+p9OHw--.15261S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17Kr17ZF1UGr4rtrWUArb_yoW8Kr4Upr
	9xXrn0kF1xJr4rur4qka1kZF15JFnxAFy3JFWDKw1avFy7CF9rtas0ya4aqFn7GrW2qryj
	934YqayrW3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEnYFAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw5po2hJpj-j+wAAs-

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


