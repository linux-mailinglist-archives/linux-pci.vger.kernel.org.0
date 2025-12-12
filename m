Return-Path: <linux-pci+bounces-42986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91ACB7CE6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 04:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411EA302A135
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 03:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797328E571;
	Fri, 12 Dec 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ajQUAVgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A152BE02D
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511774; cv=none; b=CtzmC/8dqnl9WaL3Us9FfSHKqx2j7YSh5D5bETfghLXTKsNm1TDAhdvRAzHqt9csy3R5zrk+wGxj4NDzYL2pe5mjpDlC2ejTsaYIi9Wg8FYPTc+4bDXMMUccnYhygUdzIVRV7vC49BPnErRrtjF1mEdt/V5wi7U+GQGLTA7GFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511774; c=relaxed/simple;
	bh=TNptboRnam6vEcrO0MOY6j+NO+MkGFge0RvWs+Nr4Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nKo1CIs2fEEy2P1MSAl3ILoF+MmDHSkIUjUtOJRzY8gGh57GeisIcGHyCw54kg08JL5/LknpC2VHvJFqwX+dCh1SISMNeg3oGltolJfR0ib3ggikznDylZ9NkYXIElTSyjgmjbQdmEJYFAo5p+kj+R14IKHv8Pj2qw8jSGqhQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ajQUAVgH; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ced0dd4b;
	Fri, 12 Dec 2025 09:33:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] PCI: dw-rockchip: Change get_ltssm() to provide L1 Substates info
Date: Fri, 12 Dec 2025 09:33:25 +0800
Message-Id: <1765503205-22184-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765503205-22184-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765503205-22184-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b10313f1309cckunm8cda450e102e7a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5MT1YaTEsYGUlJGRpIGENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ajQUAVgH8Ox37c0AT3i2esq/AcI/Z8PID6uXJQhx5hO8Pror4pLqOvoEyzWPtxDmTs/uLC02hQ8PPrSW78eSrntRBNh+ldOyVl9Zm8Q1nGDyG6mFJg/AxOR3LG4Enlb603XD0QcgiA6OTYHepHnfF8SP5lKd2FM6lEME1SwdNKs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bjvekfuXKUY/QHrOhNIiT7hEMtDBUtJGLlM17jv1XzM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Rename rockchip_pcie_get_ltssm() to rockchip_pcie_get_ltssm_reg() and add
rockchip_pcie_get_ltssm() to get_ltssm() callback in order to show the
proper L1 Substates. The PCIE_CLIENT_LTSSM_STATUS[5:0] register returns
the same LTSSM layout as enum dw_pcie_ltssm. So we only need to tell L1 PM
Substates apart and return the proper value defined in pcie-designware.h.

  cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
  L1_2 (0x142)

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- fix commit log and subject(Bjorn)
- remove "else" and wrap to fit in 80 columns(Bjorn)

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f8605fe..8c1c922 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -68,6 +68,11 @@
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
 
+/* RASDES TBA information */
+#define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -181,11 +186,26 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
+static u32 rockchip_pcie_get_ltssm_reg(struct rockchip_pcie *rockchip)
 {
 	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
 }
 
+static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 val = rockchip_pcie_readl_apb(rockchip,
+			PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN);
+
+	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_1)
+		return DW_PCIE_LTSSM_L1_1;
+
+	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_2)
+		return DW_PCIE_LTSSM_L1_2;
+
+	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -201,7 +221,7 @@ static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = rockchip_pcie_get_ltssm(rockchip);
+	u32 val = rockchip_pcie_get_ltssm_reg(rockchip);
 
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
@@ -485,6 +505,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = rockchip_pcie_link_up,
 	.start_link = rockchip_pcie_start_link,
 	.stop_link = rockchip_pcie_stop_link,
+	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
 static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
@@ -499,7 +520,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
@@ -526,7 +547,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");
-- 
2.7.4


