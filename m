Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086D4407799
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhIKNSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 09:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236313AbhIKNQr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 09:16:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 346E461251;
        Sat, 11 Sep 2021 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631366008;
        bh=nq3+PgcD+/F89hhQbhqDzmqSNQLztjCr/D27c90jXuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qk/34n/VMrjGGXdBZ4MBvltVX/45Zi2GEJgA8AD+BbOtP3W4iXO0E9ax/sXojPpqT
         dtaXd+uX9KvMuUpTlhnATQ/DhZt7TqmJsdhimNA7DxJneAlrZu7DoKwUPbc6HRrd7i
         lO7Eh28pu+k8T40vE5UQaq6IYprwyz+B8s6AyjaAUipX1GVE76fT/cOfavvgGycatJ
         NU8SMVPsOaX3WzlLDneZHG0928fbpILSbBGm974/akbHqCv8/YYYDHwQ+/PJPM+z0i
         n6nLeTrVQVJ+A4tWkZs+MWQvAyoJ3T49vMF5pT2S6MdOsAh/hqkbqT2pnmmbGU2KPv
         cmTng3r5cXXvA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nadeem Athani <nadeem@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/25] PCI: cadence: Add quirk flag to set minimum delay in LTSSM Detect.Quiet state
Date:   Sat, 11 Sep 2021 09:12:59 -0400
Message-Id: <20210911131312.285225-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210911131312.285225-1-sashal@kernel.org>
References: <20210911131312.285225-1-sashal@kernel.org>
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
index 84cc58dc8512..1af14474abcf 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -578,6 +578,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
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
index 73dcf8cf98fb..a40ed9e12b4b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -497,6 +497,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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
index 60981877f65b..e0b59730bffb 100644
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
@@ -291,6 +299,7 @@ struct cdns_pcie {
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -300,6 +309,7 @@ struct cdns_pcie_rc {
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 /**
@@ -330,6 +340,7 @@ struct cdns_pcie_epf {
  *        registers fields (RMW) accessible by both remote RC and EP to
  *        minimize time between read and write
  * @epf: Structure to hold info about endpoint function
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -344,6 +355,7 @@ struct cdns_pcie_ep {
 	/* protect writing to PCI_STATUS while raising legacy interrupts */
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 
@@ -504,6 +516,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
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

