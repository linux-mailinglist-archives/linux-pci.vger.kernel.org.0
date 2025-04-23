Return-Path: <linux-pci+bounces-26527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F76A987F0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34E8443C56
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055326F479;
	Wed, 23 Apr 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FAUMcOeQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130BF26D4E5;
	Wed, 23 Apr 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405715; cv=none; b=KsCiI7iioDhFfg3PCmRoQmRlhqda5JEVBo1RXEE0KD7cziYHZYf8tjNgl4qcaPrCK1bTE/DER+3LgCQsUA2mGBfpjgUwZPqO4NAMUR3QpNoSgr1KZuF3A8tANQm1qA06ctpxpGbUxNfr5K5IR2Z8ozSBPut4RSaE2BXI8YC/buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405715; c=relaxed/simple;
	bh=wSWOEWuoGl4+ZAitPoBLcWPtEVzrYX0j9/qXxhOGsPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r37L+cb4Kw9mdZKLC75JmxK4EvtIt58NTL4nkryd+zXJSER8ptgWZEgDyTPslozXtjdxa42N0GsqklUzxHOiTl1PvceVPj6Y4WkWMpy6Ggc2EkwU+BzNn5lTZnxJN5skKurBq20wrJdPMdxDh37RY1yA9/lRyvyP0t1dCxX03MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FAUMcOeQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PPQOB
	H7/gKlgthck1rxpJW2qtf0NUOJEEwS0jt+8xHI=; b=FAUMcOeQsm05XMmcZSIPL
	IZ6p6zKprhAbCb8EwxHjXLOEeG3jbadkZxpBBnmIKONK7cNABzOxdra3J5WvNH+C
	kbrcwpoB8idmUwiZX5P3G2eKYa7DsafJc62TZLLAWsmrU7a12hImyDfOUJhXLThp
	e1QbJYEytQVM9wrrdU0Lko=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAnRTjYxghozJctBw--.58909S4;
	Wed, 23 Apr 2025 18:54:20 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 2/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Wed, 23 Apr 2025 18:54:14 +0800
Message-Id: <20250423105415.305556-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250423105415.305556-1-18255117159@163.com>
References: <20250423105415.305556-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnRTjYxghozJctBw--.58909S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar48Cr4Duw1kAFy5Kr13twb_yoW7tF47p3
	yDAFyakr45ta17u3s5CFZ8ZFWIqrnxKFWUGrsag3yUu3Z5A3y8Kw1UWF95Wry7Gr4kuFy3
	uwn8C342gFWakrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrR67UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx84o2gIwxtvPAABs1

Register definitions were scattered with ambiguous names (e.g.,
PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
hierarchical grouping. Magic values for bit operations reduced code
clarity.

Group registers and their associated bitfields logically. This improves
maintainability and aligns the code with hardware documentation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 71 ++++++++++++-------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index fd5827bbfae3..6cf75160fb1c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -34,30 +34,49 @@
 
 #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
 
-#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
-#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
-#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
-#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
-#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
-#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
-#define PCIE_CLIENT_INTR_MASK_MISC	0x24
-#define PCIE_CLIENT_POWER		0x2c
-#define PCIE_CLIENT_MSG_GEN		0x34
-#define PME_READY_ENTER_L23		BIT(3)
-#define PME_TURN_OFF			(BIT(4) | BIT(20))
-#define PME_TO_ACK			(BIT(9) | BIT(25))
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
+/* Interrupt Status Register Related to Message Reception */
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
+
+/* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
+
+/*  Interrupt Status Register Related to Miscellaneous Operation */
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
+/* Power Management Control Register */
+#define PCIE_CLIENT_POWER_CON		0x2c
+#define  PME_READY_ENTER_L23		BIT(3)
+
+/*  Message Generation Control Register */
+#define PCIE_CLIENT_MSG_GEN_CON		0x34
+#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
+#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
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
@@ -176,13 +195,13 @@ static u32 rockchip_pcie_get_pure_ltssm(struct dw_pcie *pci)
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
@@ -274,8 +293,8 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 	u32 status;
 
 	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
-	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
-	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
+	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN_CON);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN_CON,
 				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
 	if (ret) {
@@ -294,7 +313,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 
 	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
 	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
-	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
 				 status, status & PME_READY_ENTER_L23,
 				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
@@ -552,7 +571,7 @@ static void rockchip_pcie_ltssm_enable_control_mode(struct rockchip_pcie *rockch
 	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
-	rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CONTROL);
+	rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CON);
 }
 
 static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
-- 
2.25.1


