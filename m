Return-Path: <linux-pci+bounces-14716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E7A9A1848
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF794B23483
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370D28E0F;
	Thu, 17 Oct 2024 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHTPXQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C1224F6;
	Thu, 17 Oct 2024 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130356; cv=none; b=rby5InIjOwV4RW7ybUdwlvSYXjPrG7aBmnlgTtftayZypcy9XqQUsQe/4Cx/kaTckYpbANOoOqaKzeEaApxm3ET9JbeW98rJIvF/LC8q2A2v0eEj935HBHAYt3vk+68M/0HxIJJom3YOZgJ9MBb5Kyg3XR5qDQXaGDFhgdBG604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130356; c=relaxed/simple;
	bh=dmpBL/Eag2R+tT+zgAEIXVdK7rcTFEEG1GUcLmDTrGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2vIWkY8oQLF5odb+I3SRAtUD80d07QfjFogc9Tj+h3p0eMc41DZU8qf0iXkdyVN0fI1QCQjW2dFIM/1YkZ2YO3/SA5BirVeAXuY5qpjzHD9dZs7Mkmo+WM+ykUs/Hmyo9zQp6kza6ioq/HrCPRfQZntxrqqdnbEvWWlOsvE/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqHTPXQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B18FC4CECF;
	Thu, 17 Oct 2024 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130356;
	bh=dmpBL/Eag2R+tT+zgAEIXVdK7rcTFEEG1GUcLmDTrGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqHTPXQkH0ys04cEqEcg0Pp4VrxeUdiDk/euqNZf1Vf08D008lHRprDuWcrZD5hGA
	 EbX2XGiUQ/Hc1a7BB0/dcgyafAmXiF0znf3AQE7FpIaaWSKb/fNmUPIbNKswg14+Fa
	 zU6x6x+gzJTwjLqyzszCayie06FUURBMU59754rgZFJrYDcujQLMw3OYIqITMP3UTL
	 6NiK82Pu/BOlOOO8V1AWfXuA9cJ4wYa+Afh/AYDoGPLcpa4LaU0ReOuQhE9SWEkTSQ
	 5sBeBLRoLaNKqMCcDueEv6LgTPMJOSdQcoblkBL4M8byMjm6xoSvSh451p+opXAHKk
	 5DXU2mHMk38xw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 12/14] PCI: rockchip-ep: Improve link training
Date: Thu, 17 Oct 2024 10:58:47 +0900
Message-ID: <20241017015849.190271-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip RK3399 TRM V1.3 Part2, Section 17.5.8.1.2, step 7,
describes the endpoint mode link training process clearly and states
that:
  Insure link training completion and success by observing link_st field
  in PCIe Client BASIC_STATUS1 register change to 2'b11. If both side
  support PCIe Gen2 speed, re-train can be Initiated by asserting the
  Retrain Link field in Link Control and Status Register. The software
  should insure the BASIC_STATUS0[negotiated_speed] changes to "1", that
  indicates re-train to Gen2 successfully.
This procedure is very similar to what is done for the root-port mode
in rockchip_pcie_host_init_port().

Implement this link training procedure for the endpoint mode as well.
Given that the RK3399 SoC does not have an interrupt signaling link
status changes, training is implemented as a delayed work which is
rescheduled until the link training completes or the endpoint controller
is stopped. The link training work is first scheduled in
rockchip_pcie_ep_start() when the endpoint function is started. Link
training completion is signaled to the function using pci_epc_linkup().
Accordingly, the linkup_notifier field of the rockchip pci_epc_features
structure is changed to true.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 82 ++++++++++++++++++++++-
 drivers/pci/controller/pcie-rockchip.h    | 11 +++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 2f7709ba1cac..43480706b8f4 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -10,12 +10,14 @@
 
 #include <linux/configfs.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/pci-epc.h>
 #include <linux/platform_device.h>
 #include <linux/pci-epf.h>
 #include <linux/sizes.h>
+#include <linux/workqueue.h>
 
 #include "pcie-rockchip.h"
 
@@ -48,6 +50,7 @@ struct rockchip_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
+	struct delayed_work	link_training;
 };
 
 static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
@@ -470,6 +473,8 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 			    PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	schedule_delayed_work(&ep->link_training, 0);
+
 	return 0;
 }
 
@@ -478,6 +483,8 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
+	cancel_delayed_work_sync(&ep->link_training);
+
 	/* Stop link training and disable configuration */
 	rockchip_pcie_write(rockchip,
 			    PCIE_CLIENT_CONF_DISABLE |
@@ -485,8 +492,80 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
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
+	/*
+	 * Check the current speed: if gen2 speed was requested and we are not
+	 * at gen2 speed yet, retrain again for gen2.
+	 */
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
+		 "Link UP (Negotiated speed: %sGT/s, width: x%lu)\n",
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
@@ -644,6 +723,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	rockchip = &ep->rockchip;
 	rockchip->is_rc = false;
 	rockchip->dev = dev;
+	INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_training);
 
 	epc = devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 0263f158ee8d..24796176f658 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -26,6 +26,7 @@
 #define MAX_LANE_NUM			4
 #define MAX_REGION_LIMIT		32
 #define MIN_EP_APERTURE			28
+#define LINK_TRAIN_TIMEOUT		(500 * USEC_PER_MSEC)
 
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
2.47.0


