Return-Path: <linux-pci+bounces-44345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39793D0822F
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A6623038308
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D2352931;
	Fri,  9 Jan 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="k0eDM6eq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEB32FA3D;
	Fri,  9 Jan 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950008; cv=none; b=ST+rECWTaZ1xgcEMExjzEZNw6TFXrkypEsClYMpGG2YSSFbAOYTfdgRD4ivTlVC1eUr9o6sE9RAHAOyc/Mlxd6DgIXIX93q2VshwJGfBp2yRvNhq9Cfb94KoqeqqWYc1hdkyPWCaiC3auMlhcg1SC4e8bPC9WD7BGG8tBn/lk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950008; c=relaxed/simple;
	bh=S/MQWbxy8Jf9kjh2xBJ/I06kUtwJ4EHwni4njMhHItI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ho21yYgtCthISxspMWSiI5UkE7aYx6U4qU2Pg1i0gOe3rMJ7uYaEApHqkLMSO/GhqFtRqjDPpGVKFkHtB+nUQGBSYsSVIZKGwf63aQtXeE10OLVoNkwabUTguJ2wJ6ZlYAw6hazbF0YrtOwZVIclyDLdTvuIRJn/F6dCIpKp7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=k0eDM6eq; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30079385a;
	Fri, 9 Jan 2026 11:30:23 +0800 (GMT+08:00)
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
Subject: [PATCH v2 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
Date: Fri,  9 Jan 2026 11:29:49 +0800
Message-Id: <1767929389-143957-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9ba0ce27fb09cckunm22b4d6c66ba6e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpIGFZOQh9NGR8YSUMdS0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=k0eDM6eqwZSeX/Oc3KneGFr36hVDHx4oK87YiANv3ixOzw3KbPKihQOEtAZLoklyPwopRdxI5ArBMIE50MgX4N++zQMw5PGEeGMQGIKPKCP/Tw7zUkJ1mktXqmjYvmNBEtTwnwb232Zg4HD8f9FhcURt0STdYXjA2ULvJS8CXMQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3OqxevSjKFpVpGpcQ3zo/K+tGfL1K3Z3iA/7SQlFIiM=;
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

Changes in v2:
- use tracepoint

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 92 +++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 352f513..be9639aa 100644
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
@@ -73,6 +75,18 @@
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
+#define PCIE_DBG_LTSSM_HISTORY_CNT	64
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -96,6 +110,7 @@ struct rockchip_pcie {
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
+	struct delayed_work trace_work;
 };
 
 struct rockchip_pcie_of_data {
@@ -206,6 +221,79 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
 	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
 }
 
+#ifdef CONFIG_TRACING
+static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
+{
+	struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
+						trace_work.work);
+	struct dw_pcie *pci = &rockchip->pci;
+	enum dw_pcie_ltssm state;
+	u32 val, rate, l1ss, loop, prev_val = DW_PCIE_LTSSM_UNKNOWN;
+
+	for (loop = 0; loop < PCIE_DBG_LTSSM_HISTORY_CNT; loop++) {
+		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
+		rate = (val & GENMASK(22, 20)) >> 20;
+		l1ss = (val & GENMASK(10, 8)) >> 8;
+		val &= PCIE_LTSSM_STATUS_MASK;
+
+		/* Two consecutive identical LTSSM means invalid subsequent data */
+		if ((loop > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
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
+				      bool en)
+{
+	if (en) {
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
+				      bool en)
+{
+}
+#endif
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -289,6 +377,9 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	 * 100us as we don't know how long should the device need to reset.
 	 */
 	msleep(PCIE_T_PVPERL_MS);
+
+	rockchip_pcie_ltssm_trace(rockchip, true);
+
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
@@ -299,6 +390,7 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 
 	rockchip_pcie_disable_ltssm(rockchip);
+	rockchip_pcie_ltssm_trace(rockchip, false);
 }
 
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.7.4


