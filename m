Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D005FCA4D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJLSOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJLSOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 14:14:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD2FE75A;
        Wed, 12 Oct 2022 11:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp7CpRyCnsXlFtEOtRi+kcPk5/aSNWtQ7YXXkjeJF9pHAAJ0Fi5qX5DheqBhogD719pPs7TKVykE2SE9AJLCgDmKfI+ZKCn1TqeLT+7DleUlpY9WNDLhFfGG0x/cUbuc103OjtxAWx3YyRnjwI9EcIy0uNYM7pbSWFHAHhhQZQFsOJTyFIC8e16sZtRHIGjYEnL2jC/UnrMqI7EMzVv0REdx85Fm6QaOLR9JgKv7S7yvTOEOvQW0K8GbCOkpm1eIdUTDVqJCSMwLh2j5AE9MIV0CKDiHacHJkEarY/NlbtbaaYJZGg15DbPXYJz7F23je+GUixp0wwi7RBTNy895WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyFfnoyng2I6wWzTJJ3eMqzGxm8D/1xhnn35e0+/7Tk=;
 b=FEJ4DmlBnoHgWKQhAx3KL+L+cSbjbx+l1WKu8kymqgQm81w+WDNY1zBacuWt21Mscbhmk1HwjvGe0HA8Rb7Ez0AB0eqCapgYooNlCrAe3auFLAXA2uuLQezMQen0eerE1QvHjtFEed8b2NClNFtfWucFibhE66hzRd13wURQ2Rq7TRWbV2WehXCV5FSweygKfcZcnL/auc5EoRqBx5iJFDH4oESE1tjNvR46YH6bkHGv1wLbdNaEQGkTGfqZOOpUrThxUcfrHlvwUCv+8cyc37Xk8cK6WPEdy05WmgMnAoUCvub4oKFqqxJ8Ttsi/8sSjG9edcjEBjJx019Ifwa7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyFfnoyng2I6wWzTJJ3eMqzGxm8D/1xhnn35e0+/7Tk=;
 b=fsNI4SVDcuLi6WsXCVKnawOH4m8AvxItajYsJY9wYiPpeMWKMVqNzobANnH0MyG9UGye6Ne2cQX+UUhVQp1mPy3+PQaDjH1J/UUTMJjbXarWKBVCTzNyshXapx163EWXvS2syPp72fPa/mpRI0Qauug+8R/yULzJ6nLmjuv05QY=
Received: from DM6PR18CA0033.namprd18.prod.outlook.com (2603:10b6:5:15b::46)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 18:14:32 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::11) by DM6PR18CA0033.outlook.office365.com
 (2603:10b6:5:15b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Wed, 12 Oct 2022 18:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 18:14:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 13:14:32 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 12 Oct 2022 13:14:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V2 2/3] PCI: Create device tree node for selected devices
Date:   Wed, 12 Oct 2022 11:13:59 -0700
Message-ID: <1665598440-47410-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2169858a-9368-476f-ebbf-08daac7d9cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVZOqaIWVf6wcKoeVnq/NEigEHwo6YO/pvJfJ+Afv96qXd8G+rBbyB+n3WOh4K1DA/jNoo5ZqrAJUwV/uqG0SHuFWY24ewFzDrRuPuTORjRegmoJBU5CgkG/UL0w6MyokS9R+E61Q1CK/mnakZQjaxqUw58lmyMXuo6gOnWcl3ihdA8wyEHETTyq5bt8VhzKMoJWI/rN4Jv1eXG24ZG4fw21gKBAWBtjKq+XwT7VNsD4IvP7XrGnacUnoUakdGJxUm/yRXU5v3Gw2Fywkc3YYrFuWFT+5iGYN9ZYy1McTnPJ9r8vsMJ/Gv4aSPy/lhLgRHFBktRd2wEFXr4/TACH5HeKv5GTownaBKZEYeVtN53vRG023MG27V7G85kQa9FseqO+btp14mvzO8UJ5qUSIsrFK37ZV/UL+IkqaEooQn3w/KDNq4v1cSiWzYyg6FNOxuQL/oNkyUgR6MU5nxCTl/LOZJo9QlAa4cm0Fl64vdnw0IYYZQAoru63i+QdfeFL1h/tLtB4pMlgpCAOSLgOan9XJYjeydXjR41PptDyXekjUbnxqED1lcigmC4yTxA/QioO8/NhjG6KbXP9dbdS1M33lNNjfGfn9XGt63pmtCK5jeah/m39b/PzTRLzTLqsbBgyD0hpmfmTaS2hL2SoVsdTRfOHnWx1jH0+5f7T+vWJL0kxI8pc6NdD8lev/ngrpDY3rJ8AQi1TRItG+GqeDSiw9rj99xen7/b7Y1aO2oQJ4pjx+XyT8KzqnBEZt1XjkJyBOiNIVe2IVjqtTizLE3K4Y+fml/TuCGK/SEz8EQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(426003)(54906003)(316002)(83380400001)(356005)(2906002)(47076005)(82740400003)(82310400005)(81166007)(44832011)(86362001)(70586007)(8676002)(70206006)(4326008)(8936002)(5660300002)(41300700001)(2616005)(40460700003)(336012)(186003)(26005)(40480700001)(110136005)(478600001)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 18:14:32.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2169858a-9368-476f-ebbf-08daac7d9cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe endpoint device such as Xilinx Alveo PCIe card maps the register
spaces from multiple hardware peripherals to its PCIe BAR. Normally,
the PCI core discovers devices and BARs using the PCI enumeration process.
There is no infrastructure to discover the hardware peripherals that are
present in a PCI device, and which can be accessed through the PCI BARs.

For Alveo PCIe card, the card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. The Alveo card driver can
load this flattened device tree and leverage device tree framework to
generate platform devices for the hardware peripherals eventually.

Apparently, the device tree framework requires a device tree node for the
PCIe device. Thus, it can generate the device tree nodes for hardware
peripherals underneath. Because PCIe is self discoverable bus, there might
not be a device tree node created for PCIe devices. This patch is to add
support to generate device tree node for PCIe devices. It introduces a
kernel option. When the option is turned on, the kernel will generate
device tree nodes for PCI bridges unconditionally. It will also generate
a device tree node for Xilinx Alveo U50 by using PCI quirks. The generated
device tree nodes do not have any property. The future patches will add
necessary properties.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/Kconfig         | 12 ++++++++
 drivers/pci/bus.c           |  2 ++
 drivers/pci/msi/irqdomain.c |  6 ++--
 drivers/pci/of.c            | 61 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |  3 +-
 drivers/pci/pci.h           | 16 ++++++++++
 drivers/pci/quirks.c        | 11 +++++++
 drivers/pci/remove.c        |  1 +
 8 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..8243a92fd97d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -198,6 +198,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DYNAMIC_OF_NODES
+	bool "Device tree node for PCI devices"
+	depends on OF
+	select OF_DYNAMIC
+	help
+	  This option enables support for generating device tree nodes for some
+	  PCI devices. Thus, the driver of this kind can load and overlay
+	  flattened device tree for its downstream devices.
+
+	  Once this option is selected, the device tree nodes will be generated
+	  for all PCI/PCIE bridges.
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..8507cc32b61d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
+	if (pci_is_bridge(dev))
+		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e9cf318e6670..eeaf44169bfd 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
-			iort_msi_map_id(&pdev->dev, rid);
+	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
+		rid = of_msi_map_id(&pdev->dev, of_node, rid);
+	else
+		rid = iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..83e042f495a6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		} else {
 			/* We found a P2P bridge, check if it has a node */
 			ppnode = pci_device_to_OF_node(ppdev);
+			if (of_node_check_flag(ppnode, OF_DYNAMIC))
+				ppnode = NULL;
 		}
 
 		/*
@@ -599,6 +601,65 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
 
+#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
+
+void of_pci_remove_node(struct pci_dev *pdev)
+{
+	struct device_node *dt_node;
+
+	dt_node = pci_device_to_OF_node(pdev);
+	if (!dt_node || !of_node_check_flag(dt_node, OF_DYNAMIC))
+		return;
+	pdev->dev.of_node = NULL;
+
+	of_destroy_node(dt_node);
+}
+
+void of_pci_make_dev_node(struct pci_dev *pdev)
+{
+	struct device_node *parent, *dt_node;
+	const char *pci_type = "dev";
+	char *full_name;
+
+	/*
+	 * if there is already a device tree node linked to this device,
+	 * return immediately.
+	 */
+	if (pci_device_to_OF_node(pdev))
+		return;
+
+	/* check if there is device tree node for parent device */
+	if (!pdev->bus->self)
+		parent = pdev->bus->dev.of_node;
+	else
+		parent = pdev->bus->self->dev.of_node;
+	if (!parent)
+		return;
+
+	if (pci_is_bridge(pdev))
+		pci_type = "pci";
+
+	full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+			      PCI_SLOT(pdev->devfn),
+			      PCI_FUNC(pdev->devfn));
+	if (!full_name)
+		goto failed;
+
+	dt_node = of_create_node(parent, full_name, NULL);
+	if (!dt_node)
+		goto failed;
+
+	kfree(full_name);
+
+	pdev->dev.of_node = dt_node;
+
+	return;
+
+failed:
+	kfree(full_name);
+}
+#endif
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 49238ddd39ee..1540c4c9a770 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1628,7 +1628,8 @@ static int pci_dma_configure(struct device *dev)
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-	    bridge->parent->of_node) {
+	    bridge->parent->of_node &&
+	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
 		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..e0a11497b1ad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -678,6 +678,22 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+void of_pci_make_dev_node(struct pci_dev *pdev);
+void of_pci_remove_node(struct pci_dev *pdev);
+
+#else
+static inline void
+of_pci_make_dev_node(struct pci_dev *pdev)
+{
+}
+
+static inline void
+of_pci_remove_node(struct pci_dev *pdev)
+{
+}
+#endif /* CONFIG_OF_DYNAMIC */
+
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..5d76932f59ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+/*
+ * For PCI device which have multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 4c54c75050dc..0eaa9d9a3609 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -23,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
 	}
-- 
2.17.1

