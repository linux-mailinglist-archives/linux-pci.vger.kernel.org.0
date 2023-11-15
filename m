Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7F7EBF94
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 10:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjKOJfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 04:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKOJfo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 04:35:44 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458BFC
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 01:35:39 -0800 (PST)
X-ASG-Debug-ID: 1700039780-086e236fef1c3d0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 5SdqimNHpXjnmrhD (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 15 Nov 2023 17:16:20 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 17:16:20 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 17:16:18 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linux.dev>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Date:   Wed, 15 Nov 2023 17:16:12 +0800
X-ASG-Orig-Subj: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20231115091612.580685-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
References: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1700039780
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5254
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116772
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
Extracting register value from HEST PCIe AER structures and programming
them into AER Capabilities are implemented in this function.
The implementation of the function is an effective supplement to _HPP/_HPX
method when the Firmware does not support the _HPP/_HPX method and can be
specially configured for the AER register of the specific device.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/pci-acpi.c | 100 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |   9 ++++
 drivers/pci/probe.c    |   1 +
 3 files changed, 110 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..5d04068b490e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
 
 /*
@@ -783,6 +784,105 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
 
+#ifdef CONFIG_ACPI_APEI
+static void program_hest_aer_endpoint(struct acpi_hest_aer_common aer_endpoint,
+				struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_mask;
+	u32 adv_cap;
+
+	uncor_mask = aer_endpoint.uncorrectable_mask;
+	uncor_severity = aer_endpoint.uncorrectable_severity;
+	cor_mask = aer_endpoint.correctable_mask;
+	adv_cap = aer_endpoint.advanced_capabilities;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
+}
+
+static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root,
+				struct pci_dev *dev, int pos)
+{
+	u32 root_err_cmd;
+
+	root_err_cmd = aer_root->root_error_command;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
+}
+
+static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
+				struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask2;
+	u32 uncor_severity2;
+	u32 adv_cap2;
+
+	uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
+	uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
+	adv_cap2 = hest_aer_bridge->advanced_capabilities2;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
+}
+
+static void program_hest_aer_params(struct hest_parse_aer_info info)
+{
+	struct pci_dev *dev;
+	int port_type;
+	int pos;
+	struct acpi_hest_aer_root *hest_aer_root;
+	struct acpi_hest_aer *hest_aer_endpoint;
+	struct acpi_hest_aer_bridge *hest_aer_bridge;
+
+	dev = info.pci_dev;
+	port_type = pci_pcie_type(dev);
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	switch (port_type) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		hest_aer_root = info.hest_aer_root_port;
+		program_hest_aer_endpoint(hest_aer_root->aer, dev, pos);
+		program_hest_aer_root(hest_aer_root, dev, pos);
+	break;
+	case PCI_EXP_TYPE_ENDPOINT:
+		hest_aer_endpoint = info.hest_aer_endpoint;
+		program_hest_aer_endpoint(hest_aer_endpoint->aer, dev, pos);
+	break;
+	case PCI_EXP_TYPE_PCI_BRIDGE:
+	case PCI_EXP_TYPE_PCIE_BRIDGE:
+		hest_aer_bridge = info.hest_aer_bridge;
+		program_hest_aer_endpoint(hest_aer_bridge->aer, dev, pos);
+		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
+	break;
+	default:
+		return;
+	break;
+	}
+}
+
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct hest_parse_aer_info info = {
+		.pci_dev = dev
+	};
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	if (apei_hest_parse(hest_parse_pcie_aer, &info) == 1)
+		program_hest_aer_params(info);
+
+	return 0;
+}
+#endif
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..1fc28f7a5972 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -714,6 +714,15 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_ACPI_APEI
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
+#else
+static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..45a45ab72846 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2274,6 +2274,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
 
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
-- 
2.34.1

