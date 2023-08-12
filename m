Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9577A2B6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHLUpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjHLUpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 16:45:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6AE10F2;
        Sat, 12 Aug 2023 13:45:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37CKiwGw095270;
        Sat, 12 Aug 2023 15:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691873098;
        bh=KDMPwakXHnBm1lyuJMieItLxASOIXvE4C4DW6HKNztU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N2dGHaG0b7qGs71o83Dcd1oQhPZnCuFkpcq6a2wqH2mPQ92TZAUCqJeqBXJhyAQS+
         n2IAGwjqFnvfzm6lqvcqj08fAUfu5pitI2o3zGBXhcUpkBP0NcXEmso2+M2AjQFO3P
         prCoYumRq3So1Af0lry08atYCRxIqQf/lZRAuSsg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37CKiwbk127046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Aug 2023 15:44:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Aug 2023 15:44:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Aug 2023 15:44:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37CKivss067879;
        Sat, 12 Aug 2023 15:44:58 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 1/2] PCI: cadence: Advertise ARI Forwarding Supported
Date:   Sun, 13 Aug 2023 02:14:54 +0530
Message-ID: <20230812204455.479510-2-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812204455.479510-1-a-verma1@ti.com>
References: <20230812204455.479510-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J7 PCIe Root Complex has ARI Forwarding Support (advertised by
PCI_EXP_DEVCAP2_ARI bit) which means support for forwarding of TLPs
addressed to functions with function number greater than 7 but for some
PCIe instances on J7, PCI_EXP_DEVCAP2_ARI bit is cleared which prevents
accessing functions with function number > 7.

Setting the PCI_EXP_DEVCAP2_ARI explicitly, resolves the issue.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  4 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 2c3b3af59271..7e94eb94f29c 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -73,6 +73,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		set_afs_bit:1;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -292,6 +293,7 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.set_afs_bit = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
@@ -304,6 +306,7 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.set_afs_bit = true,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
@@ -393,6 +396,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
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

