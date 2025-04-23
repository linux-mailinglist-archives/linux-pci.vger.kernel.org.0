Return-Path: <linux-pci+bounces-26555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B03A99372
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFC6923E01
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B228B500;
	Wed, 23 Apr 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hVNDd8sK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81B2BD5B0;
	Wed, 23 Apr 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422385; cv=none; b=QkFAgFK8O8Cb0GrspnO5eqKPdUTtdwx09wdESuNRrCyW9XhaYJ4Rrg5gZcdfOE0/taY+1RZWWqqBOyzr0XDn9r3akb0y/ABOcyRi1L6Chj5VVIZAsh8ZjRln7PybxoFzjJd/DfBT5PiNna7LW+Pffek8Xv3V8WcH00gzmHl3f6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422385; c=relaxed/simple;
	bh=svfuyLBCEv8k1uCrOACXnEv5v6T38vEtpARUGCx9ehU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/CEuEVhIHESqM1B34XS8FrloTMxWDvoxJ6e4tD48IMHxzkbslKJ+HFkJR0sdw8oYv4FKFiP4Hxaj4ZYUgLLI0V9R56xeE1CkGPn0XNxOma1QKXAfI2OTA67DnzCS9uQ8Wvpbg1syH54MKNYxLcMAKkGNuVFjFhoSe3BZbazzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hVNDd8sK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=A0sm3
	yCG2xo4YaewR2G18cCyYOO9P0b4G0YtDHiuAyI=; b=hVNDd8sKMYhY//m9OFMlC
	Q+APhnrx2ekOH6gOkXFBZVPFc/a58sBgixTqDFcP13mEnaewT1tO6WRyVd/HOE+R
	Tv94vEqlnvSvLGJrO+JrMEwTIAu8i9iybBzGoPQX9kX4qmv7OfKMZhqCom0jxxGP
	5Qo5gYoGPTBZKeTA4kZeaI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnosAACAlogeYfCA--.9428S4;
	Wed, 23 Apr 2025 23:32:20 +0800 (CST)
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
Subject: [PATCH v3 2/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Wed, 23 Apr 2025 23:32:13 +0800
Message-Id: <20250423153214.16405-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250423153214.16405-1-18255117159@163.com>
References: <20250423153214.16405-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnosAACAlogeYfCA--.9428S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar48Cr4Duw1kAFy5Kr13twb_yoW7tF47p3
	yDAFyakr45ta17u3s5CFZ8ZFWxtrnxKFWUGrsag3yUu3Z5A3y8Kw1UWF95Wry7Gr4kuFy3
	uwn8C342gFyakrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEZ2-5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg44o2gJB+UC-QABsS

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
index fd5827bbfae3..96ca394da42c 100644
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
+/* Power Management Control Register */
+#define PCIE_CLIENT_POWER_CON		0x2c
+#define  PME_READY_ENTER_L23		BIT(3)
+
+/* Message Generation Control Register */
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


