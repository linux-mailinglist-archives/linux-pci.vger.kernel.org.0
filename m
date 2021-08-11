Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F303E917F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhHKMee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:34:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52856 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhHKMe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:34:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXqBJ014891;
        Wed, 11 Aug 2021 07:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685232;
        bh=XtuvWthdCIKdMNXqtepjb4Ycn1MAXAsmL0B0bltcYB8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UL1+16HT26PYi15C8NSbXtOCjxHo5UOzld757WXOt72vaEai8aLhput5rPviku61U
         wxhop0UMp/lgWONpYhLjNy5WxfIePDKBNIsT4Mwt3m2rVPNSdHwP7qcgmJZb1vI8Vg
         unLIioazCXXcAKT/jCvaxR+z3lr0W1JxOAfo8lKI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCXqI3060190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:33:52 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:33:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:33:52 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXbiw083813;
        Wed, 11 Aug 2021 07:33:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v3 2/5] PCI: cadence: Add quirk flag to set minimum delay in LTSSM Detect.Quiet state
Date:   Wed, 11 Aug 2021 18:03:33 +0530
Message-ID: <20210811123336.31357-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
References: <20210811123336.31357-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nadeem Athani <nadeem@cadence.com>

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

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  4 ++++
 .../pci/controller/cadence/pcie-cadence-host.c   |  3 +++
 drivers/pci/controller/cadence/pcie-cadence.c    | 16 ++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h    | 15 +++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 443dd06dfcfc..f021ca0b5f01 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -711,6 +711,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
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
index 6f97fb4e58a6..5bad4542b8a9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -198,6 +198,14 @@
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
@@ -304,6 +312,7 @@ struct cdns_pcie {
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -313,6 +322,7 @@ struct cdns_pcie_rc {
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 /**
@@ -345,6 +355,7 @@ struct cdns_pcie_epf {
  *        registers fields (RMW) accessible by both remote RC and EP to
  *        minimize time between read and write
  * @epf: Structure to hold info about endpoint function
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -359,6 +370,7 @@ struct cdns_pcie_ep {
 	/* protect writing to PCI_STATUS while raising legacy interrupts */
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
+	unsigned int		quirk_detect_quiet_flag:1;
 };
 
 
@@ -519,6 +531,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
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
2.17.1

