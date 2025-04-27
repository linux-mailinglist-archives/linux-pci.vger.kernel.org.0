Return-Path: <linux-pci+bounces-26863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A813A9E316
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B4517825A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD2433AC;
	Sun, 27 Apr 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E93R1CwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1C610C;
	Sun, 27 Apr 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758446; cv=none; b=r6xvmQcZWgTo5rHkWl0tRv97DXw4jXmnOV+XkFqEpRfbjeb6fA3QBlj2c3rejTxdb4HEpyJqMJQO4kiAK5614cXAyD1LX/vodfvobIZcnx+Ibkfi2ViXWOzqVbz5dyKXr8C35BfV9ig8Jt/OuVMvqa7xfxibjIm88+JwegBG5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758446; c=relaxed/simple;
	bh=FdTjp+dk1xGjoVbBoFe//xPsEZun+tS/AecF7pRBh4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ypw4/vsjYSgniaQf/Yovptq4DRMXQs2viFSfxynKtaAWuMD/54ZDENF+cRT8ainLHS/6vlBrNatynmaqNX0pWIHybOHaOPnLQevNxdAG+l4HMJhWSurf8NTTH0muDSygrfCJNA0qTAymnzcZaref0CB9cKPiXlfLGbItwcJy1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E93R1CwM; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=97YC0
	bzVCpna+dBptpsih7bsJjCrsnz2SlPWFzXL9qY=; b=E93R1CwM6aYHsBlhNWRy4
	oUbPkInEGGdbzRBsbmfPwroTnew/QJNyptGQlkyZKnWR0ISAeM+AwxuepBQ4NtQ4
	WENWpE36mwMSmYXte5fi5WzvlC4IYgkkEm54ww0oCSJDMAA4DYHXrJVfRzGCdkcw
	7dt5VJq2KODqbVJzSSmZjY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3LwC9KA5oNqx8Cw--.63816S4;
	Sun, 27 Apr 2025 20:53:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 2/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Sun, 27 Apr 2025 20:53:15 +0800
Message-Id: <20250427125316.99627-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250427125316.99627-1-18255117159@163.com>
References: <20250427125316.99627-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3LwC9KA5oNqx8Cw--.63816S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWxWryktw1DKrWxuw4fuFg_yoWrur48pa
	4DAFyIkr45Ka1av3s3CF98ZFWIqrnIkFW7Jrsag3yUu3Z3Zw18Gw1UWF95Wry7Jr4kCFy3
	uwn8C34xWF4akrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoE__UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgQ8o2gOIuqhhwABso

Register definitions were scattered with ambiguous names (e.g.,
PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
hierarchical grouping. Magic values for bit operations reduced code
clarity.

Group registers and their associated bitfields logically. This improves
maintainability and aligns the code with hardware documentation.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 49 ++++++++++++-------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index e7d33d545d5b..a778f4f61595 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -33,24 +33,37 @@
 
 #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
 
-#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
-#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
-#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
-#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
-#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
-#define PCIE_CLIENT_INTR_MASK_MISC	0x24
-#define PCIE_SMLH_LINKUP		BIT(16)
-#define PCIE_RDLH_LINKUP		BIT(17)
-#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
-#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
-#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_CLIENT_GENERAL_CONTROL	0x0
+/* General Control Register */
+#define PCIE_CLIENT_GENERAL_CON		0x0
+#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
+#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
+#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
+#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
+
+/* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
+
+/* Interrupt Status Register Related to Miscellaneous Operation */
+#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
+#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
+#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
+
+/* Interrupt Mask Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
+
+/* Interrupt Mask Register Related to Miscellaneous Operation */
+#define PCIE_CLIENT_INTR_MASK_MISC	0x24
+
+/* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
+#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
+
+/* LTSSM Status Register */
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
-#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
+#define  PCIE_SMLH_LINKUP		BIT(16)
+#define  PCIE_RDLH_LINKUP		BIT(17)
+#define  PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
+#define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
 	struct dw_pcie pci;
@@ -161,13 +174,13 @@ static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
-				 PCIE_CLIENT_GENERAL_CONTROL);
+				 PCIE_CLIENT_GENERAL_CON);
 }
 
 static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
-				 PCIE_CLIENT_GENERAL_CONTROL);
+				 PCIE_CLIENT_GENERAL_CON);
 }
 
 static int rockchip_pcie_link_up(struct dw_pcie *pci)
@@ -516,7 +529,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
-				 PCIE_CLIENT_GENERAL_CONTROL);
+				 PCIE_CLIENT_GENERAL_CON);
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
@@ -562,7 +575,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
-				 PCIE_CLIENT_GENERAL_CONTROL);
+				 PCIE_CLIENT_GENERAL_CON);
 
 	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
 	rockchip->pci.ep.page_size = SZ_64K;
-- 
2.25.1


