Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A376CAF0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHBKf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjHBKfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 06:35:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837E3C26;
        Wed,  2 Aug 2023 03:31:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372AV03e087357;
        Wed, 2 Aug 2023 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690972260;
        bh=/MHuGroEMLFbmSZMPPGGvJ55f3Ob1498wHHAUU9f2Jk=;
        h=From:To:CC:Subject:Date;
        b=EcNEJOivYiUABdA25H4TtqL3cZOZ4J/WMpw8Wg0tsQhcEK/5r/BApZ7kgpUyf77Gu
         QwcBxAdLnbIXLUguDK26R0Y6tNQViA+Gbffu0RInV+Zq9yHJZAtOgtbkVsrisDBCEp
         zRLrstDlQQPq1B8f873xysNnNUKFL8yQREyJqiPo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372AV0BV013219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 05:31:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 05:31:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 05:31:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372AUx60016890;
        Wed, 2 Aug 2023 05:31:00 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH] PCI: cadence: Set the AFS bit in Device Capabilities 2 Register
Date:   Wed, 2 Aug 2023 16:00:59 +0530
Message-ID: <20230802103059.3492181-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J7 PCIe Root Complex has ARI Forwarding Support, means supporting
forwarding of TLPs addressed to functions with function number greater than
7 but some PCIe instances on J7 have this bit cleared which results in
failure of forwarding of TLPs destined for function number > 7.
Setting the AFS bit in Device Capabilities 2 Register explicitly, resolves
the issue and leads to successful access to function number > 7.

Some observations:
1. J7200-EVB has single PCIe instance(PCIe1) for which ARIFwd bit is not
   set. Enumeration gracefully fails for funciton number greater than 7 but
   later read/write access to these funcitons results in a crash.

2. On J721E-EVB, PCIe1 instance has ARIFwd bit set while it is cleared for
   PCIe0 instance. This issue combined with errata i2086
   (Unsupported Request (UR) Response Results in External Abort) results in
   SERROR while scanning multi-function endpoint device.

Kernel panic - not syncing: Asynchronous SError Interrupt
Hardware name: Texas Instruments K3 J721E SoC (DT)
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x1a0
 show_stack+0x18/0x68
 dump_stack+0xd0/0x12c
 panic+0x16c/0x334
 nmi_panic+0x8c/0x90
 arm64_serror_panic+0x78/0x84
 do_serror+0x38/0x98
 el1_error+0x90/0x110
 pci_generic_config_read+0x3c/0xe0
 cdns_ti_pcie_config_read+0x18/0x38
 pci_bus_read_config_dword+0x80/0xd8
 pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
 pci_bus_read_dev_vendor_id+0x4c/0x70
 pci_scan_single_device+0x7c/0xf8
 pci_scan_slot+0x74/0x120
 pci_scan_child_bus_extend+0x54/0x298
 pci_scan_bridge_extend+0x29c/0x580
 pci_scan_child_bus_extend+0x1e4/0x298
 pci_scan_root_bus_bridge+0x64/0xd8
 pci_host_probe+0x18/0xc8
 cdns_pcie_host_setup+0x534/0x8f0
 j721e_pcie_probe+0x494/0x820

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  4 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 32b6a7dc3cff..e890fe9ca89d 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -71,6 +71,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		set_afs_bit:1;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -290,6 +291,7 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.set_afs_bit = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
@@ -302,6 +304,7 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.set_afs_bit = true,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
@@ -391,6 +394,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->quirk_retrain_flag = data->quirk_retrain_flag;
 		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+		rc->set_afs_bit = data->set_afs_bit;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 5b14f7ee3c79..fc696d94f7a2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -507,6 +507,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
+	u32 pcie_cap2;
 
 	bridge = pci_host_bridge_from_priv(rc);
 	if (!bridge)
@@ -536,6 +537,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (rc->quirk_detect_quiet_flag)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
+	if (rc->set_afs_bit) {
+		pcie_cap2 = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2);
+		pcie_cap2 |= PCI_EXP_DEVCAP2_ARI;
+		cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2, pcie_cap2);
+	}
+
 	cdns_pcie_host_enable_ptm_response(pcie);
 
 	ret = cdns_pcie_start_link(pcie);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 190786e47df9..7a5d05f3febc 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -329,6 +329,7 @@ struct cdns_pcie_rc {
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		set_afs_bit:1;
 };
 
 /**
@@ -457,6 +458,17 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
+static inline void cdns_pcie_rp_writel(struct cdns_pcie *pcie,
+				       u32 reg, u32 value)
+{
+	writel(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+}
+
+static inline u32 cdns_pcie_rp_readl(struct cdns_pcie *pcie, u32 reg)
+{
+	return readl(pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
-- 
2.25.1

