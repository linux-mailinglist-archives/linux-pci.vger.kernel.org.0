Return-Path: <linux-pci+bounces-35030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C0B39FA1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6FF985652
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A0314A80;
	Thu, 28 Aug 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TrgOd+he"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8223D298;
	Thu, 28 Aug 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389665; cv=none; b=eUUSK16FwSEacC43H2meoKcOyABrItpp5nYVQ6DHwGkO1TeBG7KsyD7JVvhadlJP9xoBVaW1sZklr1TAgL3M6Myh34gtjBsoWKNkT7vBpH7DPTSmSLY8tduJjksSM8DcVeCLj9zfW1cVBQLDItj2DVEVUGaHi7TXIjlnmDTbXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389665; c=relaxed/simple;
	bh=IlENoHFxr7WOhjsE5a54eDOP6was89Ngzuhf4EVvmhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbSYTyvuW97xZ+BI93XfHVKs5qSKJQ1HTHsVAC/YdF1Du+K4jS2zincnf50PlPrOZSbnfbI7Y+4rC6QrPna27zAAaW+cZy6vd84VxYl1zK1tWAcJyYozh1164BZvF9MDCPrd9jW4ej6HCeNaKb3MGiA1AcjIuY4pM9Cy62Mo3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TrgOd+he; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zy
	0wvfRRI0LApPMuYe3zBdc3lkExdk1jM0KvRsbczRc=; b=TrgOd+hesp03+lMqYf
	lNgMRGE4PIW8ZG9UAcCiCMFnbtc4ooK9iVlmuSFK66NcgTVyXTX1r6nIO2xpykOi
	dtKHz0gd66pT+n9cjsim9vuVZUhN6Zw3biEssDyqMYBmDnXXthmC6yoccpewGnU+
	dL39q/Z/XWWfOYaurQAvaV924=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S8;
	Thu, 28 Aug 2025 22:00:41 +0800 (CST)
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
Subject: [PATCH v5 06/13] PCI: armada8k: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:44 +0800
Message-Id: <20250828135951.758100-7-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyrKFykJF1xKF1kCw48JFb_yoWrCFy3p3
	s8AFyYyF1UJw48Z3ykCas7XFy3AFZxZFnxCan3Wr1vv3ZrCrZrW3yFvFySgr1SgFsFqrWY
	vw4rtry7Cr1rG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-eOtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxe3o2iwWuaXtAABsG

Armada8k PCIe driver uses explicit bitwise operations for global control
register configuration. The driver manually handles bit masking and
shifting for multiple fields including device type, domain attributes,
and interrupt masking. This approach requires repetitive read-modify-write
sequences and temporary variables.

Refactor global control setup, domain attribute configuration, and
interrupt masking using dw_pcie_*_dword(). The helper replaces
manual bit manipulation with declarative bit masks, directly specifying
which bits to clear and set. This eliminates intermediate variables and
reduces code complexity.

Standardizing on the helper improves code clarity in initialization paths
and ensures consistent handling of control register bits. The change also
centralizes bit manipulation logic, reducing the risk of errors in future
modifications to device configuration.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 43 ++++++++--------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index c2650fd0d458..1b2879f89c61 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -155,54 +155,43 @@ static bool armada8k_pcie_link_up(struct dw_pcie *pci)
 
 static int armada8k_pcie_start_link(struct dw_pcie *pci)
 {
-	u32 reg;
-
 	/* Start LTSSM */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg |= PCIE_APP_LTSSM_EN;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_set_dword(pci, PCIE_GLOBAL_CONTROL_REG, PCIE_APP_LTSSM_EN);
 
 	return 0;
 }
 
 static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
-	u32 reg;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (!dw_pcie_link_up(pci)) {
+	if (!dw_pcie_link_up(pci))
 		/* Disable LTSSM state machine to enable configuration */
-		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-		reg &= ~(PCIE_APP_LTSSM_EN);
-		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
-	}
+		dw_pcie_clear_dword(pci, PCIE_GLOBAL_CONTROL_REG,
+				    PCIE_APP_LTSSM_EN);
 
 	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
-	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_clear_and_set_dword(pci, PCIE_GLOBAL_CONTROL_REG,
+				    PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT,
+				    PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT);
 
 	/* Set the PCIe master AxCache attributes */
 	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
 	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
+	dw_pcie_clear_and_set_dword(pci, PCIE_ARUSER_REG,
+				    AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT,
+				    DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT);
 
-	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+	dw_pcie_clear_and_set_dword(pci, PCIE_AWUSER_REG,
+				    AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT,
+				    DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT);
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
-	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
-	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	dw_pcie_set_dword(pci, PCIE_GLOBAL_INT_MASK1_REG,
+			  PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
+			  PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK);
 
 	return 0;
 }
-- 
2.49.0


