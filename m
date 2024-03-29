Return-Path: <linux-pci+bounces-5391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E569B891579
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9A7285849
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADB39AF9;
	Fri, 29 Mar 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="env7fnJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952636AE7
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703414; cv=none; b=CQ5VFkTxQhtFOZTuTh5D4E2JmuMGmEpR2OWVpSCYOjDZXBMRzNCVC1wEwnkiHFO4DrJY8WQMm/9U7lMuqnxPu2uzOjXbxNGu74eNpPl6/ZVvhErxWsc5glUyWbK1PtUofBnDGtQ/KJ+ZMUC/Rpti8tTJip4YQPT2O4SwTnxwgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703414; c=relaxed/simple;
	bh=+TmInabN37SfEhMgyX/p7nVgLz3hbajUkBFvvCUgxJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmd5cAhY0bxzeFfweVteevyVEMTbAUVf5RJ8Zw3mSsgmFD5Cx6GzXWSrMlh4w0y+E5uL78uFfIaeSO/5zWc4NfPfgKsuS7GtBGN/F0eYgdM7AdTEe2EX3KXiohTtqA6QFPh5pfunIfIgLFjYEet5TAccvm1IWMTzLuk5bBB2V/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=env7fnJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C3C433F1;
	Fri, 29 Mar 2024 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703413;
	bh=+TmInabN37SfEhMgyX/p7nVgLz3hbajUkBFvvCUgxJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=env7fnJMur239VcR6gPVXw7rC1BdzlLCS6Hjm+pdshs7w7u45zeiwvIgjhi/ZZF7F
	 /DdgykUQRq1i+X+Pf9A+bn3+8Kqr3U0h8KOBBqB7k/Ebym/1/10uOX6JsIJg+xl95h
	 9bURXPPnxl1pRtORkL63Pw5S5e/OGE01PhQdDJMKmAU+CdYY69dhdKiHcF9sUHIR5T
	 3lSY2SYSB5ZJ5i4juakmw07PExxaTVms6OGuEu4jtetq3PfMwWK4+zLQod4nmOb4WM
	 nfubqpPKqv10sdDvHreOhp/OZcjC01fPAZCC8PCxGUfa2BM576m+smnIOrOkkwySXl
	 SEgUvvXLcg/RQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 17/19] PCI: rockchip-ep: Improve link training
Date: Fri, 29 Mar 2024 18:09:43 +0900
Message-ID: <20240329090945.1097609-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip rk339 technical reference manual describe the endpoint mode
link training process clearly and states that:
  Insure link training completion and success by observing link_st field
  in PCIe Client BASIC_STATUS1 register change to 2'b11. If both side
  support PCIe Gen2 speed, re-train can be Initiated by asserting the
  Retrain Link field in Link Control and Status Register. The software
  should insure the BASIC_STATUS0[negotiated_speed] changes to "1", that
  indicates re-train to Gen2 successfully.
This procedure is very similar to what is done for the root-port mode in
rockchip_pcie_host_init_port().

Implement this link training procedure for the endpoint mode as well.
Given that the rk3399 SoC does not have an interrupt signaling link
status changes, training is implemented as a delayed work which is
rescheduled until the link training completes or the endpoint controller
is stopped. The link training work is first scheduled in
rockchip_pcie_ep_start() when the endpoint function is started. Link
training completion is signaled to the function using pci_epc_linkup().
Accordingly, the linkup_notifier field of the rockchip pci_epc_features
structure is changed to true.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 79 ++++++++++++++++++++++-
 drivers/pci/controller/pcie-rockchip.h    | 11 ++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c126da07bf0c..d8e56b4a5578 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/pci-epf.h>
 #include <linux/sizes.h>
+#include <linux/workqueue.h>
+#include <linux/iopoll.h>
 
 #include "pcie-rockchip.h"
 
@@ -48,6 +50,7 @@ struct rockchip_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
+	struct delayed_work	link_training;
 };
 
 static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
@@ -467,6 +470,8 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 			    PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	schedule_delayed_work(&ep->link_training, 0);
+
 	return 0;
 }
 
@@ -475,6 +480,8 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
+	cancel_delayed_work_sync(&ep->link_training);
+
 	/* Stop link training and disable configuration */
 	rockchip_pcie_write(rockchip,
 			    PCIE_CLIENT_CONF_DISABLE |
@@ -482,8 +489,77 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
 			    PCIE_CLIENT_CONFIG);
 }
 
+static void rockchip_pcie_ep_retrain_link(struct rockchip_pcie *rockchip)
+{
+	u32 status;
+
+	status = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
+	status |= PCI_EXP_LNKCTL_RL;
+	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
+}
+
+static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip)
+{
+	u32 val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
+
+	return PCIE_LINK_UP(val);
+}
+
+static void rockchip_pcie_ep_link_training(struct work_struct *work)
+{
+	struct rockchip_pcie_ep *ep =
+		container_of(work, struct rockchip_pcie_ep, link_training.work);
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	struct device *dev = rockchip->dev;
+	u32 val;
+	int ret;
+
+	/* Enable Gen1 training and wait for its completion */
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
+				 val, PCIE_LINK_TRAINING_DONE(val), 50,
+				 LINK_TRAIN_TIMEOUT);
+	if (ret)
+		goto again;
+
+	/* Make sure that the link is up */
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
+				 val, PCIE_LINK_UP(val), 50,
+				 LINK_TRAIN_TIMEOUT);
+	if (ret)
+		goto again;
+
+	/* Check the current speed */
+	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
+	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
+		/* Enable retrain for gen2 */
+		rockchip_pcie_ep_retrain_link(rockchip);
+		readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
+				   val, PCIE_LINK_IS_GEN2(val), 50,
+				   LINK_TRAIN_TIMEOUT);
+	}
+
+	/* Check again that the link is up */
+	if (!rockchip_pcie_ep_link_up(rockchip))
+		goto again;
+
+	val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
+	dev_info(dev,
+		 "Link UP (Negociated speed: %sGT/s, width: x%lu)\n",
+		 (val & PCIE_CLIENT_NEG_LINK_SPEED) ? "5" : "2.5",
+		 ((val & PCIE_CLIENT_NEG_LINK_WIDTH_MASK) >>
+		  PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT) << 1);
+
+	/* Notify the function */
+	pci_epc_linkup(ep->epc);
+
+	return;
+
+again:
+	schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
+}
+
 static const struct pci_epc_features rockchip_pcie_epc_features = {
-	.linkup_notifier = false,
+	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
@@ -644,6 +720,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	rockchip = &ep->rockchip;
 	rockchip->is_rc = false;
 	rockchip->dev = dev;
+	INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_training);
 
 	epc = devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 0263f158ee8d..3963b7097a91 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -26,6 +26,7 @@
 #define MAX_LANE_NUM			4
 #define MAX_REGION_LIMIT		32
 #define MIN_EP_APERTURE			28
+#define LINK_TRAIN_TIMEOUT		(5000 * USEC_PER_MSEC)
 
 #define PCIE_CLIENT_BASE		0x0
 #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
@@ -50,6 +51,10 @@
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
 #define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
+#define PCIE_CLIENT_BASIC_STATUS0	(PCIE_CLIENT_BASE + 0x44)
+#define   PCIE_CLIENT_NEG_LINK_WIDTH_MASK	GENMASK(7, 6)
+#define   PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT	6
+#define   PCIE_CLIENT_NEG_LINK_SPEED		BIT(5)
 #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
 #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
 #define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
@@ -87,6 +92,8 @@
 
 #define PCIE_CORE_CTRL_MGMT_BASE	0x900000
 #define PCIE_CORE_CTRL			(PCIE_CORE_CTRL_MGMT_BASE + 0x000)
+#define   PCIE_CORE_PL_CONF_LS_MASK		0x00000001
+#define   PCIE_CORE_PL_CONF_LS_READY		0x00000001
 #define   PCIE_CORE_PL_CONF_SPEED_5G		0x00000008
 #define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
 #define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
@@ -144,6 +151,7 @@
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
+#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
@@ -155,6 +163,7 @@
 #define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
 #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
@@ -192,6 +201,8 @@
 #define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
+#define PCIE_LINK_TRAINING_DONE(x) \
+	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
 #define PCIE_LINK_UP(x) \
 	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
 #define PCIE_LINK_IS_GEN2(x) \
-- 
2.44.0


