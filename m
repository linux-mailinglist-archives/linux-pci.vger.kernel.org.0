Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06EE74706D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGDMGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGDMGQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:06:16 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA51723
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:05:50 -0700 (PDT)
X-ASG-Debug-ID: 1688472346-086e23149614910001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id OHwx3kSIB8K6RgBO (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 04 Jul 2023 20:05:46 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:46 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <leoliu-oc@zhaoxin.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>
Subject: [PATCH v3 4/5] ACPI/PCI: Add pci_acpi_program_hest_aer_params()
Date:   Tue, 4 Jul 2023 20:05:44 +0800
X-ASG-Orig-Subj: [PATCH v3 4/5] ACPI/PCI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20230704120544.1322315-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1688472346
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5685
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110906
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

The extracted register values from HEST PCI Express AER structures are
written to AER Capabilities.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/pci-acpi.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  5 +++
 2 files changed, 97 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49cb..cff54410e2427 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
 
 /*
@@ -783,6 +784,97 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
 
+/*
+ * program_aer_structure_to_aer_registers - Write the AER structure to
+ * the corresponding dev's AER registers.
+ *
+ * @info - the AER structure information
+ *
+ */
+static void program_aer_structure_to_aer_registers(struct acpi_hest_parse_aer_info info)
+{
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 root_error_command;
+	u32 uncorrectable_mask2;
+	u32 uncorrectable_severity2;
+	u32 advanced_capabilities2;
+	int port_type;
+	int pos;
+	struct pci_dev *dev;
+
+	dev = info.pci_dev;
+	port_type = pci_pcie_type(dev);
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+		uncorrectable_mask = info.acpi_hest_aer_root_port->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_root_port->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_root_port->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_root_port->advanced_capabilities;
+		root_error_command = info.acpi_hest_aer_root_port->root_error_command;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_error_command);
+	} else if (port_type == PCI_EXP_TYPE_ENDPOINT) {
+		uncorrectable_mask = info.acpi_hest_aer_endpoint->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_endpoint->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_endpoint->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_endpoint->advanced_capabilities;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+	} else if ((pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) ||
+				(pci_pcie_type(dev) == PCI_EXP_TYPE_PCIE_BRIDGE)) {
+		uncorrectable_mask = info.acpi_hest_aer_for_bridge->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_for_bridge->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_for_bridge->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_for_bridge->advanced_capabilities;
+		uncorrectable_mask2 = info.acpi_hest_aer_for_bridge->uncorrectable_mask2;
+		uncorrectable_severity2 = info.acpi_hest_aer_for_bridge->uncorrectable_severity2;
+		advanced_capabilities2 = info.acpi_hest_aer_for_bridge->advanced_capabilities2;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncorrectable_mask2);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncorrectable_severity2);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP2, advanced_capabilities2);
+	}
+}
+
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct acpi_hest_parse_aer_info info = {
+		.pci_dev	= dev,
+		.hest_matched_with_dev	= 0,
+		.acpi_hest_aer_endpoint = NULL,
+		.acpi_hest_aer_root_port = NULL,
+		.acpi_hest_aer_for_bridge = NULL,
+	};
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	apei_hest_parse(apei_hest_parse_aer, &info);
+	if (info.hest_matched_with_dev == 1)
+		program_aer_structure_to_aer_registers(info);
+	else
+		return -ENODEV;
+	return 0;
+}
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..37aa4a33eeed2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -713,6 +713,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
 int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
 bool acpi_pci_need_resume(struct pci_dev *dev);
 pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
 #else
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
@@ -752,6 +753,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	return PCI_POWER_ERROR;
 }
+static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM
-- 
2.34.1

