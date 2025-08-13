Return-Path: <linux-pci+bounces-33916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A0B23FCC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814BF7AD397
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B892BE629;
	Wed, 13 Aug 2025 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQ9q+M6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF972405FD;
	Wed, 13 Aug 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060352; cv=none; b=aD1IsVRDVxbDAg0U5j47EczJL0Qv135eer/lomMqwwW+rKr9Ok3qAS3MqHjXQGOfBZwnWWSvs139/8Tu8Gd27iJjpKVwUTDcNtfHflNhBOgI5MH9hkrh/VQ4/hbDcHfvTIB9Lf1+FM9DiIODzarmx4SGL/+e2Mx/1tpd1umMiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060352; c=relaxed/simple;
	bh=AyIyci4j3t9tsor39WcVZgT1McAoZZhyUuqVb5im41U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fI9SfnsY0+U6Vb98Bdeu5Ff1kPHI4pV4yvYz1Xf2xzbdULIvfkGR05adqF8XoM0gJvjprkSjArGaTaNOASLwgU/nuoDz+duNInxZKyusosU0DEYlzvgaX0WKrYAqnyQI8vzNGpSSCozucvqP0ObG1m1RoHfvnUFpWPQvtoNh+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQ9q+M6m; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mf
	cah2+ycb2ydogLnZ0AlJX/f7/lygCdHxTFUi3RV7I=; b=qQ9q+M6m6fBmLOuLLl
	q00Sd6CHnoWlHurAgM7Trp1eEBpYSiwQoz3fYUpXbfzdEoU300srI44hQKnH85TI
	Rxx7Imfm0QMc3UZdpDB7uya5JBp9k/AJWmQ2fv0LCYcYFKtfd2PnXLc/gIRbRWI6
	UUHkAAqEF6ESV/22vF7KpgXWk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S8;
	Wed, 13 Aug 2025 12:45:39 +0800 (CST)
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
Subject: [PATCH v4 06/13] PCI: armada8k: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:24 +0800
Message-Id: <20250813044531.180411-7-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyrKFykJF1xKF1kCw48JFb_yoW7Jw1Dp3
	45AFyYyF1UJw40v3ykCa97XF13AFZxZFnxCan3Wrs2q3ZrCrZrW3yFvFySgr1SgFZFqrWa
	9w4rtrW7Cr1rG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-BMiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQx6oo2icD7Tg6gAAsT

Armada8k PCIe driver uses explicit bitwise operations for global control
register configuration. The driver manually handles bit masking and
shifting for multiple fields including device type, domain attributes,
and interrupt masking. This approach requires repetitive read-modify-write
sequences and temporary variables.

Refactor global control setup, domain attribute configuration, and
interrupt masking using dw_pcie_clear_and_set_dword(). The helper replaces
manual bit manipulation with declarative bit masks, directly specifying
which bits to clear and set. This eliminates intermediate variables and
reduces code complexity.

Standardizing on the helper improves code clarity in initialization paths
and ensures consistent handling of control register bits. The change also
centralizes bit manipulation logic, reducing the risk of errors in future
modifications to device configuration.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 48 ++++++++--------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index c2650fd0d458..67348307aa28 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -155,54 +155,44 @@ static bool armada8k_pcie_link_up(struct dw_pcie *pci)
 
 static int armada8k_pcie_start_link(struct dw_pcie *pci)
 {
-	u32 reg;
-
 	/* Start LTSSM */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg |= PCIE_APP_LTSSM_EN;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_clear_and_set_dword(pci, PCIE_GLOBAL_CONTROL_REG,
+				    0, PCIE_APP_LTSSM_EN);
 
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
+		dw_pcie_clear_and_set_dword(pci, PCIE_GLOBAL_CONTROL_REG,
+					    PCIE_APP_LTSSM_EN, 0);
 
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
+	dw_pcie_clear_and_set_dword(pci, PCIE_GLOBAL_INT_MASK1_REG, 0,
+				    PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
+				    PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK);
 
 	return 0;
 }
@@ -211,15 +201,13 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *pcie = arg;
 	struct dw_pcie *pci = pcie->pci;
-	u32 val;
 
 	/*
 	 * Interrupts are directly handled by the device driver of the
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_GLOBAL_INT_CAUSE1_REG, 0, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1


