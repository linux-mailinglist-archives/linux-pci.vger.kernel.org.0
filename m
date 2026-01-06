Return-Path: <linux-pci+bounces-44088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B343ACF784A
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA82D30409E4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D430DEB2;
	Tue,  6 Jan 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U5VxXzFo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862221C4A20
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691140; cv=none; b=hLTDYPb8DPSn4F5H8iY3g4ICDqYzMUGONSecEg2w4tKBIqQZi+z5HZ8NAO20gbrk9fqVDKdODq2Oi6elKq5YCzAYggrFwaAbGUdRjE40MsC8v4M4sOF4g32JzWIIlONYaDei3TNEJ3zS7KncheFD31yyG2J++M3/TRzuVUHAR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691140; c=relaxed/simple;
	bh=UoG0KJjRxvjfgq53qrgkl4ujMJdLjDHkfv06Ap2wqko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oZ05mMREZrS9tuLDcHD1Y4YAuo9nEZ5O1XYFnNBHR5XM3jQWowfvzLwwpZwQ6i+75TwScNvC4Bc41290N03oA2VApLb5/trfgio/mibSu5gGUo+CWu2fclyKdJKlrsAPf+BDJ+Lth4Aw68PFMRcuzHgQF4+SJIm8ykN5RhKpL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U5VxXzFo; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2faab483a;
	Tue, 6 Jan 2026 17:18:52 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: dw-rockchip: Add .ltssm_trace() support
Date: Tue,  6 Jan 2026 17:18:39 +0800
Message-Id: <1767691119-28287-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b929a1fc709cekunm960b3024166f970
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pOHVZCSkxOHR9ITE8ZShlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=U5VxXzFokA8wim/vURXU1f/ILfuF1UrB9Kx+nGGb4K3V46t/EF6upYHhwNLrha0RF+Cf0VtqFDKJ5NtoNPB69C458kgOX16Fg+mTd2EM8lUTbOQPmMXbo0UA1YJNAf281pER0sErsHNc2qO8UhAEnOZ6oDY65fimfyLF4J9bIhI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=IP58kk+Qem1BCoFGvpUji/gld40XYbln6qdHAO2WZdw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
LTSSM history. Any LTSSM change will be recorded. It's userful
for debug purpose, for example link failure, etc.

  cat /sys/kernel/debug/dwc_pcie_a40c00000.pcie/ltssm_trace
    DETECT_QUIET (0x00)
    DETECT_ACT (0x01)
    POLL_ACTIVE (0x02)
    POLL_COMPLIANCE (0x03)
    POLL_ACTIVE (0x02)
    POLL_CONFIG (0x04)
    CFG_LINKWD_START (0x07)
    ...
    RCVRY_IDLE (0x10)
    L0 (0x11)
    L123_SEND_EIDLE (0x13)
    L1_IDLE (0x14)
    RCVRY_LOCK (0x0d)
    ...

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 352f513ebf03..0f7430e686b2 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -73,6 +73,17 @@
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
 
+/* Debug FIFO information */
+#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
+#define  PCIE_CLIENT_DBG_EN		0xffff0007
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0	0x320
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1	0x324
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0	0x328
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1	0x32c
+#define  PCIE_CLIENT_DBG_TRANSITION_DATA 0xffff0000
+#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
+#define PCIE_DBG_LTSSM_HISTORY_CNT	64
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -96,6 +107,7 @@ struct rockchip_pcie {
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
+	struct dw_pcie_ltssm_history ltssm_history;
 };
 
 struct rockchip_pcie_of_data {
@@ -206,6 +218,34 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
 	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
 }
 
+static void rockchip_pcie_enable_ltssm_trace(struct rockchip_pcie *rockchip)
+{
+        rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_TRANSITION_DATA,
+				 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0);
+        rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_TRANSITION_DATA,
+				 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1);
+        rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_TRANSITION_DATA,
+				 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0);
+        rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_TRANSITION_DATA,
+				 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1);
+        rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_EN,
+				 PCIE_CLIENT_DBG_FIFO_MODE_CON);
+}
+
+static struct dw_pcie_ltssm_history* rockchip_pcie_ltssm_trace(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 loop, val;
+
+	for (loop = 0; loop < PCIE_DBG_LTSSM_HISTORY_CNT; loop++) {
+		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS) &
+					PCIE_LTSSM_STATUS_MASK;
+		rockchip->ltssm_history.states[loop] = val;
+	}
+
+	return &rockchip->ltssm_history;
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -277,6 +317,8 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	/* Reset device */
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
 
+	rockchip_pcie_enable_ltssm_trace(rockchip);
+
 	rockchip_pcie_enable_ltssm(rockchip);
 
 	/*
@@ -506,6 +548,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = rockchip_pcie_start_link,
 	.stop_link = rockchip_pcie_stop_link,
 	.get_ltssm = rockchip_pcie_get_ltssm,
+	.ltssm_trace = rockchip_pcie_ltssm_trace,
 };
 
 static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
@@ -645,6 +688,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	rockchip->pci.ops = &dw_pcie_ops;
 	rockchip->data = data;
 
+	rockchip->ltssm_history.count = PCIE_DBG_LTSSM_HISTORY_CNT;
+	rockchip->ltssm_history.states = devm_kzalloc(dev,
+			PCIE_DBG_LTSSM_HISTORY_CNT * sizeof(u32), GFP_KERNEL);
+	if (!rockchip->ltssm_history.states)
+		return -ENOMEM;
+
 	/* Default N_FTS value (210) is broken, override it to 255 */
 	rockchip->pci.n_fts[0] = 255; /* Gen1 */
 	rockchip->pci.n_fts[1] = 255; /* Gen2+ */
-- 
2.43.0


