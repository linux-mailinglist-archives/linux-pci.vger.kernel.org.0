Return-Path: <linux-pci+bounces-42002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25188C830D3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 02:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0EF3AE576
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464C49659;
	Tue, 25 Nov 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TABvJh0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12CA95E
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035662; cv=none; b=mFmsr6E68W8wsgNcHAsXrRQ92PdVH9kpb8yw2POG2RBpuxI78kaCZ0cJyQpXbl45brmXiVFfgCpH4X7OUBQiGYPlTQdpf3tGO7KmdyqboLu6dJ45h+0T38vYkoXYMLfvfhg4iwmALixzeKom2hDzFpBCeXKhLbPCWncmwTAjJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035662; c=relaxed/simple;
	bh=tUHtVabB9N95cbVfo0Ugq69hm4/IeooLOpHHK2DJORo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sbmFk2lntvBDh/M/v7KKoXBV3u/gFM5ejKT1Tj5WkFIlLVrfcx1i+r09Efb87DrYfSnId5gEtc3PVldjoHcZ75mKpm03Ht3DTP+yz/KApg30cV1GrU7pOFFsG9WMbB7KwTagNewGB1Tz/+2/LbLPkjoK8zglOsxPmZwuAt5qtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TABvJh0q; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ac10623c;
	Tue, 25 Nov 2025 09:54:08 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: dw-rockchip: Change get_lttssm() to provide L1ss info
Date: Tue, 25 Nov 2025 09:53:52 +0800
Message-Id: <1764035632-180821-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9ab8b7dc0309cckunmc92cec9842ee22
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1KGFZLSh9NSU5OSkIdSBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TABvJh0qHjzd3Lb+zpJlIggejrNAsVMBZmrRWtJ0irroVGIMnT2iIuNSLl/cSnPlIyaLPb3qSmUmH7ADnoVhnohuIPxX7hU3zwJch5ikTOqMZWd8xMylxig4cfYCUh6lvAnVrC5t3cRZF/6hcV8BxzuzZKoWoyLav6A4YveNbKM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=IBwPvR/OW/JxFxvLDwrXC009YY5nSw2ucnUS0x3GS4A=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This patch renames rockchip_pcie_get_ltssm() to rockchip_pcie_get_ltssm_reg()
and adds rockchip_pcie_get_ltssm() to get_lttssm() callback to in order to
show the proper L1 substates. The PCIE_CLIENT_LTSSM_STATUS[5:0] register returns
the same ltssm layout as enum dw_pcie_ltssm. So we only need to tell L1ss apart
and return the proper value defined in pcie-designware.h.

cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
L1_2 (0x142)

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f8605fe61a41..019d4f4f26a6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -68,6 +68,11 @@
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
 
+/* RASDES TBA infomation */
+#define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -181,11 +186,25 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
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
+	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN);
+
+	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_1)
+		return DW_PCIE_LTSSM_L1_1;
+	else if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_2)
+		return DW_PCIE_LTSSM_L1_2;
+	else
+		return rockchip_pcie_get_ltssm_reg(rockchip) &
+			PCIE_LTSSM_STATUS_MASK;
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -201,7 +220,7 @@ static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = rockchip_pcie_get_ltssm(rockchip);
+	u32 val = rockchip_pcie_get_ltssm_reg(rockchip);
 
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
@@ -485,6 +504,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = rockchip_pcie_link_up,
 	.start_link = rockchip_pcie_start_link,
 	.stop_link = rockchip_pcie_stop_link,
+	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
 static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
@@ -499,7 +519,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
@@ -526,7 +546,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");
-- 
2.43.0


