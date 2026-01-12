Return-Path: <linux-pci+bounces-44457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F2D104DC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 02:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E7F5301A0DD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7B23ED6A;
	Mon, 12 Jan 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Oxd0oj2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DA24BBEB;
	Mon, 12 Jan 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182987; cv=none; b=qiGZD0+yeF8kLLYd7j5BCOfNgZIBiIelj2LqZb4V8418unNsJCAbBTEaUhHJ+hJtdK/qB5E81R6cjLYJVa1DfJd6HJ9iXOnyRF5tKcdnHvJdwcmq5BlaNWmFQbZ0B07U5uy0uoLN39J87t9/NK5dwWQ/WO/TmM9o7Y2lcgSQAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182987; c=relaxed/simple;
	bh=85V/kSD5DV50NM9PuhTGBYZFnOYu1dLPby/MWS87gM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UvvDYNSRDrSRgFZcCcBK2ZShxNYFk9KSSnHnT5nxYrilnPRpXKBh2OEMV3e8EPEkgeD3hX8dLdLjwXqY8ASRHdK8GvbEyFqgxLit8x1AiF+u/SFzwifuMUVuixtlzwdUZEFn/DSzrFp2CVqfdxxsydWm+POESbELfTl/UGUfa98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Oxd0oj2q; arc=none smtp.client-ip=45.254.49.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 303e91937;
	Mon, 12 Jan 2026 09:20:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
Date: Mon, 12 Jan 2026 09:20:00 +0800
Message-Id: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bafca5b9109cckunme7c7221b25b240
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksaTFZITBgfQ0hKSB9KTxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Oxd0oj2qIKPgVMH/gYNeLYzPhsF9UrEMkF0ZkPa2uQG/p5D0nhzXQPAdYuKasOkyj87H6dR8vc2E+xAPSGr0RMxCQfHp4nXgIeTOKtjhAmbZsYpSJsQ3bo9ochxnDXSfMnv9bBEdqA7wfDGHxM3QdczLRKI0g6CAMRV7rpl0KtQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ZgxJOYtEUZZ9lDjUn8KCpSUAe2bzrN8TYgmqnZ6nm/I=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
LTSSM history. Any LTSSM change will be recorded. It's userful
for debug purpose, for example link failure, etc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3:
- reorder variables(Mani)
- rename loop to i; rename en to enable(Mani)
- use FIELD_GET(Mani)
- add comment about how the FIFO works(Mani)

Changes in v2:
- use tracepoint

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 352f513..344e0b9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
+#include <trace/events/pci_controller.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -73,6 +75,20 @@
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
 
+/* Debug FIFO information */
+#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
+#define  PCIE_CLIENT_DBG_EN		0xffff0007
+#define  PCIE_CLIENT_DBG_DIS		0xffff0000
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0	0x320
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1	0x324
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0	0x328
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1	0x32c
+#define  PCIE_CLIENT_DBG_TRANSITION_DATA 0xffff0000
+#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
+#define  PCIE_DBG_FIFO_RATE_MASK	GENMASK(22, 20)
+#define  PCIE_DBG_FIFO_L1SUB_MASK	GENMASK(10, 8)
+#define PCIE_DBG_LTSSM_HISTORY_CNT	64
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -96,6 +112,7 @@ struct rockchip_pcie {
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
+	struct delayed_work trace_work;
 };
 
 struct rockchip_pcie_of_data {
@@ -206,6 +223,89 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
 	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
 }
 
+#ifdef CONFIG_TRACING
+static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
+{
+	struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
+						trace_work.work);
+	struct dw_pcie *pci = &rockchip->pci;
+	enum dw_pcie_ltssm state;
+	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
+
+	for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
+		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
+		rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
+		l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
+		val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
+
+		/*
+		 * Hardware Mechanism: The ring FIFO employs two tracking counters:
+		 * - 'last-read-point': maintains the user's last read position
+		 * - 'last-valid-point': tracks the hardware's last state update
+		 *
+		 * Software Handling: When two consecutive LTSSM states are identical,
+		 * it indicates invalid subsequent data in the FIFO. In this case, we
+		 * skip the remaining entries. The dual-counter design ensures that on
+		 * the next state transition, reading can resume from the last user
+		 * position.
+		 */
+		if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
+			break;
+
+		state = prev_val = val;
+		if (val == DW_PCIE_LTSSM_L1_IDLE) {
+			if (l1ss == 2)
+				state = DW_PCIE_LTSSM_L1_2;
+			else if (l1ss == 1)
+				state = DW_PCIE_LTSSM_L1_1;
+		}
+
+		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
+					dw_pcie_ltssm_status_string(state),
+					((rate + 1) > pci->max_link_speed) ?
+					PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
+	}
+
+	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
+}
+
+static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
+				      bool enable)
+{
+	if (enable) {
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_EN,
+					 PCIE_CLIENT_DBG_FIFO_MODE_CON);
+
+		INIT_DELAYED_WORK(&rockchip->trace_work,
+				  rockchip_pcie_ltssm_trace_work);
+		schedule_delayed_work(&rockchip->trace_work, 0);
+	} else {
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_DIS,
+					 PCIE_CLIENT_DBG_FIFO_MODE_CON);
+		cancel_delayed_work_sync(&rockchip->trace_work);
+	}
+}
+#else
+static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
+				      bool enable)
+{
+}
+#endif
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -289,6 +389,9 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	 * 100us as we don't know how long should the device need to reset.
 	 */
 	msleep(PCIE_T_PVPERL_MS);
+
+	rockchip_pcie_ltssm_trace(rockchip, true);
+
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
@@ -299,6 +402,7 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 
 	rockchip_pcie_disable_ltssm(rockchip);
+	rockchip_pcie_ltssm_trace(rockchip, false);
 }
 
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.7.4


