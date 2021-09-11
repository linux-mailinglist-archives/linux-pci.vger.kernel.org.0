Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC5407746
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhIKNPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 09:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236204AbhIKNOO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 09:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F97C61214;
        Sat, 11 Sep 2021 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631365974;
        bh=jlGzUnLLGPZ/GN7qFUtqh+dVe31/uGc/lqRKJ4Db2nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8lwXucedcmvNKf3P6aitKfsgLdkFrmaLGwWX2OXf2k7Md89AZyJnXgX7CfCCeHoX
         xfQvQXJicmksEF0oOj8BCI/uer7Rg4bTYtPDlRzDh6ZdtahepuVysf67VVz70IsgaC
         vK7NK4udXlsU5m9SX/B8id0+nnkEQ5BcvMPOA+zklS64nKr30IAPsxQHYgbc3G0wqG
         JkGK0np+MJ9T9u/lx6flwazRYEl+8Dw+LRcs+3KJuXDK3DaiPxKIK19QL5rJST3oma
         1O/gM/fCudvq6h/oFiLkjLtqFhhqHaPhzHv5J2ktOmHZHacCNWBauKg0/+bRkVEyR1
         +oVXV/Jsx58SA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nadeem Athani <nadeem@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 15/29] PCI: cadence: Add quirk flag to set minimum delay in LTSSM Detect.Quiet state
Date:   Sat, 11 Sep 2021 09:12:19 -0400
Message-Id: <20210911131233.284800-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210911131233.284800-1-sashal@kernel.org>
References: <20210911131233.284800-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nadeem Athani <nadeem@cadence.com>

[ Upstream commit 09c24094b2e3a15ef3fc44f54a191b3db522fb11 ]

PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
another protocol. For example, link training fails if lanes 2 and 3 are
assigned to another protocol while lanes 0 and 1 are used for PCIe to
form a two lane link. This failure is due to an incorrect tie-off on an
internal status signal indicating electrical idle.

Status signals going from SERDES to PCIe Controller are tied-off when a
lane is not assigned to PCIe. Signal indicating electrical idle is
incorrectly tied-off to a state that indicates non-idle. As a result,
PCIe sees unused lanes to be out of electrical idle and this causes
LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
occur. If a receiver is not detected on the first receiver detection
attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
again moves forward to Detect.Active state without waiting for 12ms as
required by PCIe base specification. Since wait time in Detect.Quiet is
skipped, multiple receiver detect operations are performed back-to-back
without allowing time for capacitance on the transmit lines to
discharge. This causes subsequent receiver detection to always fail even
if a receiver gets connected eventually.

Add a quirk flag "quirk_detect_quiet_flag" to program the minimum
time the LTSSM should wait on entering Detect.Quiet state here.
This has to be set for J7200 as it has an incorrect tie-off on unused
lanes.

Link: https://lore.kernel.org/r/20210811123336.31357-3-kishon@ti.com
Signed-off-by: Nadeem Athani <nadeem@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  4 ++++
 .../pci/controller/cadence/pcie-cadence-host.c   |  3 +++
 drivers/pci/controller/cadence/pcie-cadence.c    | 16 ++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h    | 15 +++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 897cdde02bd8..dd7df1ac7fda 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -623,6 +623,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
 	/* Reserve region 0 for IRQs */
 	set_bit(0, &ep->ob_region_map);
+
+	if (ep->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+
 	spin_lock_init(&ep->lock);
 
 	return 0;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ae1c55503513..fb96d37a135c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -498,6 +498,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return PTR_ERR(rc->cfg_base);
 	rc->cfg_res = res;
 
+	if (rc->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 3c3646502d05..52767f26048f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -7,6 +7,22 @@
 
 #include "pcie-cadence.h"
 
+void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
+	ltssm_control_cap = ((ltssm_control_cap &
+			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 7613c0f67f72..98413754b142 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -189,6 +189,14 @@
 /* AXI link down register */
 #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
 
+/* LTSSM Capabilities register */
+#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x0054)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -292,6 +300,7 @@ struct cdns_pcie {
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -301,6 +310,7 @@ struct cdns_pcie_rc {
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 /**
@@ -331,6 +341,7 @@ struct cdns_pcie_epf {
  *        registers fields (RMW) accessible by both remote RC and EP to
  *        minimize time between read and write
  * @epf: Structure to hold info about endpoint function
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -345,6 +356,7 @@ struct cdns_pcie_ep {
 	/* protect writing to PCI_STATUS while raising legacy interrupts */
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 
@@ -505,6 +517,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	return 0;
 }
 #endif
+
+void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-- 
2.30.2

