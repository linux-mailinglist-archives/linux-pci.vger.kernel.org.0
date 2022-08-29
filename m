Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E95A565D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 23:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH2Voe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Vo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 17:44:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430678BF0;
        Mon, 29 Aug 2022 14:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0tbMaIeZJwmleNwvu//873nqyqZyKaQUfH0+uEO0J2NecnxeUxTxYJ7NDnyw7i2SyhbO1AWPBgoO8rMQvn5iA7CzJ6q2d/Z5G/zNXXO/gJaSuI5QhYWPgesS63Au1N7fSQK9z/nyMH8sXqw82Pbmq0NY4pbCqLAXOm1NPMDwYzFatopH4R5hCSVNrIF3Bs2eyTa7c+QE6ZklpJ9OFNeZbIi3WcbBzVtGYr6F5BXwnUeZhio97/AgTiX3Jsrrngs8gL495p6sm6SJnG2XjOYaXAxrKlxlU8PUizzDKDMGKy4p4lB7bKnpCXGCou1hfoXnI0QBZNaZQYtQZmqcH9hdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsq6Dc8sIFisVZ8h1yPHlWAdbv9oJsTUz4ru+CfRVMY=;
 b=Jcxymb1rtYqMpSoHikjxznqs/eBI+LIPYT1XsMFrlVBEbmWkQUKGQHsbBlvLnATPbkG9dS3E0IYcS6YBwR9AFE0ORN82PW5iT0m7/MkgenvxK9yYNwnMbcleC5Z7TVZqXtp+rpV4vZ5IQHM6U8mKbdFjpRRLfqesygfwxSSt+N0ImpwyzkUioolPK8D1P0H94e+SYUPfbMpmA98tmeR+L89vpUbdx+kqPve/mvtoJI2Zeu/rz7P/Cfvr/D5FYJ2X2rOPO6D8fjYBUi1GKbB1eyrCLeCHGVXbdf1npIh3ibhWML9zqdsjm/i6c96eFPFCV7OfjnOrcyGrCqffdKMPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsq6Dc8sIFisVZ8h1yPHlWAdbv9oJsTUz4ru+CfRVMY=;
 b=FA2Gn+qBBwb4d6JhqEbpCLcnYxNSFF9GakBip6pF5pkZXAV8yQ7dMZrqReTT5M5BGtPiX/kGqC3RNkf3Y0RddJYfzCrqWqmoePaqmHk231BLFaq9CZDOcnkavQNEVUMD+1fblZQ11vXIsnwHx4J5xkNjfMXzQ9HBs5clmArN5CA=
Received: from BN0PR04CA0194.namprd04.prod.outlook.com (2603:10b6:408:e9::19)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 21:44:23 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::e9) by BN0PR04CA0194.outlook.office365.com
 (2603:10b6:408:e9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 21:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:44:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:20 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 29 Aug 2022 16:44:18 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC 2/2] pci: create device tree node for selected devices
Date:   Mon, 29 Aug 2022 14:43:37 -0700
Message-ID: <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b6812f9-c59c-41f0-e0bb-08da8a07a2b9
X-MS-TrafficTypeDiagnostic: DM4PR12MB6255:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeHGkhlgcCFikIKrBIgMB6abMw/M4USBMAlXEm+HK+q69gFHq732nB2OeOCFk16jHemBYLmM10HYRr7jHbTZM2MiEH+i8IJLaUXJD73WJC2Zf1v/uck3ur51bnaJRnWkU8qQifjIM8Om9wmz9cKpgpDlCnzY+CH1967a3WoA0TWEZ6QlZt/IgIKA+GedmEBNBh2W4mXq8a6ydcVZxJcixk3gJ33NGhUZIKriSJf5duEKMnnuSQBd5zMNuqtNvAfjmF07sZMxKRIRPd5e5GY28I940NbUkrpU7qd9NJJ/MiVC4qj+gBGMkpYGQnixgwFHvy6i0S+qrtSJh/pCvg11wgMjs1tWICivv7t+YYmzc76LX1yw6waezj8RMtI2aliCJlneFtXIOBvx01Euz26VpRgfR+wMhnr6d3N9o7ZtCs+a31adXJSF+4E+fGcI5r7H908P9JH853sOyqhCBSkhgZamQ3kVwVzVhqj30767pENUkW1okNoYZhEj3IOXG1GlGR6DSlgJwQj6tDtm611Jzg2fekwKN/sUvJNHjip4u2QHZ9bpM6z8nCWHLwZPdnSnouR3IgRSheJPlQoN27R5i7dmMOxelGkHhtjZfmO7Rvy7mTFpzETFIL3tcZZxSDjXBUf1kI2CnWIPe1ILcBpXuaqHMb+d9WQTIaoso+JGuaomLPdCgc+bXPd0ULaMIqFCIaf5lyjAeV7Ugf5eswq/EBi48p3LGsiRHOBDDFpMhNtp3xysus/3Rhd8zsD91LFT9OlUhZCWkd9U+j1mrmH9lZY13naMNRQCjx8stHlGK5o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(46966006)(36840700001)(316002)(356005)(110136005)(4326008)(41300700001)(8676002)(70206006)(70586007)(36756003)(86362001)(5660300002)(8936002)(54906003)(478600001)(81166007)(26005)(82310400005)(2616005)(2906002)(82740400003)(44832011)(6666004)(36860700001)(83380400001)(336012)(426003)(40460700003)(40480700001)(47076005)(63350400001)(186003)(63370400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:44:22.5060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6812f9-c59c-41f0-e0bb-08da8a07a2b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI endpoint device such as Xilinx Alveo PCI card maps the register
spaces from multiple hardware peripherals to its PCI BAR. Normally,
the PCI core discovers devices and BARs using the PCI enumeration process.
And the process does not provide a way to discover the hardware peripherals
been mapped to PCI BARs. For Alveo PCI card, the card firmware provides a
flattened device tree to describe the hardware peripherals on its BARs.
And the Alveo card driver can load this flattened device tree and leverage
device tree framework to generate platform devices for the hardware
peripherals eventually.

Apparently, the device tree framework requires a device tree node for the
PCI device. Thus, it can generate the device tree nodes for hardware
peripherals underneath. Because PCI is self discoverable bus, there might
not be a device tree node created for PCI devices. This patch is to add
support to generate device tree node for PCI devices. It introduces a
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
 drivers/pci/Kconfig         |  11 ++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  16 ++++++
 drivers/pci/quirks.c        |  11 ++++
 drivers/pci/remove.c        |   1 +
 8 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..9eca5420330b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -198,6 +198,17 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_OF
+	bool "Device tree node for PCI devices"
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
index 3cef835b375f..f752b804ad1f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
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
index 196834ed44fe..19856d42e147 100644
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
@@ -599,6 +601,110 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
 
+#if IS_ENABLED(CONFIG_PCI_OF)
+struct of_pci_node {
+	struct list_head node;
+	struct device_node *dt_node;
+	struct of_changeset cset;
+};
+
+static LIST_HEAD(of_pci_node_list);
+static DEFINE_MUTEX(of_pci_node_lock);
+
+static void of_pci_free_node(struct of_pci_node *node)
+{
+	of_changeset_destroy(&node->cset);
+	kfree(node->dt_node->full_name);
+	if (node->dt_node)
+		of_node_put(node->dt_node);
+	kfree(node);
+}
+
+void of_pci_remove_node(struct pci_dev *pdev)
+{
+	struct list_head *ele, *next;
+	struct of_pci_node *node;
+
+	mutex_lock(&of_pci_node_lock);
+
+	list_for_each_safe(ele, next, &of_pci_node_list) {
+		node = list_entry(ele, struct of_pci_node, node);
+		if (node->dt_node == pdev->dev.of_node) {
+			list_del(&node->node);
+			mutex_unlock(&of_pci_node_lock);
+			of_pci_free_node(node);
+			break;
+		}
+	}
+	mutex_unlock(&of_pci_node_lock);
+}
+
+void of_pci_make_dev_node(struct pci_dev *pdev)
+{
+	const char *pci_type = "dev";
+	struct device_node *parent;
+	struct of_pci_node *node;
+	int ret;
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
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return;
+	of_changeset_init(&node->cset);
+
+	node->dt_node = of_node_alloc(NULL);
+	if (!node->dt_node) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+	node->dt_node->parent = parent;
+
+	if (pci_is_bridge(pdev))
+		pci_type = "pci";
+
+	node->dt_node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+					     PCI_SLOT(pdev->devfn),
+					     PCI_FUNC(pdev->devfn));
+	if (!node->dt_node->full_name) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	ret = of_changeset_attach_node(&node->cset, node->dt_node);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_apply(&node->cset);
+	if (ret)
+		goto failed;
+
+	pdev->dev.of_node = node->dt_node;
+
+	mutex_lock(&of_pci_node_lock);
+	list_add(&node->node, &of_pci_node_list);
+	mutex_unlock(&of_pci_node_lock);
+
+	return;
+
+failed:
+	of_pci_free_node(node);
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
index 785f31086313..319b79920d40 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -678,6 +678,22 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_PCI_OF
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
+of_pci_remove_node(struct pci_dev *pdev);
+{
+}
+#endif /* CONFIG_OF_DYNAMIC */
+
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..58a81e9ff0ed 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+/*
+ * For PCIe device which have multiple downstream devices, its driver may use
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
2.27.0

