Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940466329E4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKUQng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKUQn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 11:43:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272911D65D;
        Mon, 21 Nov 2022 08:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR8keTTIn3qj1eY2+ynA0I/W59G9x0EoCY0i2+OEt/a8rN65FYDLgSl4zxG3TdVNOoLdHNu3stHrVdx4+4JKOa2kay0e4vfetqu0Hdj8/LNUXj3uwKiHUvTaYmhUzfBN1ynicbAUMLU3k+iU+tTowAwR+0S95iU/Z5R6yePNZElMMbTnoFG7a/a6ZlHROA6jHGo5yiaDjGrk09X88jKtRcoxXMO8WuHpv5JLX1zJTjYpzH0CoNEDeFz4jaZc9Sbu0RiBFVtIcS7Roorj2L9vmeET86Rne2/YMY3esDs4YVSyPtOeYVxZGkvNZrxWOoMAAtxENJ4CdRGuvVskcggeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJIodgobuFSEiYutNZJPpoYNjCH+jxg0AXEvGGQuU24=;
 b=AOAoEJb3KWHVW45FkybtwsSirZoDxVuDsz9kw7/PA1Gdjv9sIjDnSQsIBeXZJo9YD8drNJ81A6B/69QM/CWwmQhzXAOYtZ5NL5oKKe//TyWbGsrvD0z2tx9bddYYuUpj+4wPzbBodHwHCgtXhsqQMqtDTtLrxaU1iIIKzcnhObWtVIy6aM1qnjy8/Iufvqt7BZRo2SudgmbFYK/FftloINEfmo9pQB0478U7gLp1h3I3FFbwmc0ySMn/RYhDqiMFY/6HGZ1Y23Xim+dlgadNIYYH9ME225CKMfWSPRAXlBP1LLBNbU0w59nMiOAnMcvMBiasq5KcXVtlCtZAstukNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJIodgobuFSEiYutNZJPpoYNjCH+jxg0AXEvGGQuU24=;
 b=eR52sJuHSEPaGhf3thjkacVh+mI7jTN1dYOEBaOL6ArFB2T22lcmESk9wt0EdLVwT0vI/YjiVWbKgPteVJIiwgmogZ8nwJgVDit2dYml4A21zNnWcJ2zJRf7qd5qBbvMI+hqhph2Z3iGLtgIuaUjhCE2dXJfKP9YEz90qMbZcMs=
Received: from BN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:ee::10)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:43:16 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f8) by BN0PR04CA0005.outlook.office365.com
 (2603:10b6:408:ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 16:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 16:43:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:43:16 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 10:43:15 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [RESEND PATCH RFC V4 2/3] PCI: Create device tree node for selected devices
Date:   Mon, 21 Nov 2022 08:43:03 -0800
Message-ID: <1669048984-56394-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c3decd-8c42-4af3-2b01-08dacbdf7d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaHcEP9sK1A4xNqM4qZHdCW2SFdB2RrbJHr3ltRS+lvXEqJdK233mMNuhRqN13nd0dbfsZdhitp+hVcdbdhE9lnFsfZ4V9X4c6uIROqQmkeOHYta8Vf5PpvJXw/zROznMS2cEmhMshAfHXl7E7xxdPV1BdKFl4Eodco3HUzMBRb2WfUjkqYybM56RdWv9RvvOQjMV5170820D/eZOgd9C1FWUkjQN6jejl+hmnJWSZsh4pcY2a5SJQKjlMyjfdHpPE8xxnL2BCqyAqNzOzMSWTMAMw7KYtutfcs+PlLY50iBYeKaZuY+KfFUUEyXJwN1qUiahxr+s/vbKPUXnxyRAjXVv8zDLKFbtPFTI2XelRQEVmCCKCNyrd+zCRdSYOD3BLD6ZHwSKXmlFOOr8oD+YhJ/lHHQ8sg0lAVBdI1DuYeJAYrqZjz2e3voAWW9ngV0MIBchF/lWyO+B5LZDV1sW5vzEV3EV0NHMQz7TRrr74TyZrXdUUrdegeUYMiL1k0dxDLAE1cnIEQ7KDYPBoXRKlAyL8ISLbnNEFIzfB8C4FVHvncnfoOp+JcIVivKq+W9tO4qAddqxoCAPnzK91/DUFmiYaJf3BBe/QOsFyfuwfQ7svwYHqbLz9dLRuLXJx2k2BO9AZ0gWSBiHKcMg00ku/yM9OrENU9srGCECjIkjpoW9/6DBdLBXOGI+An8bLV3n0zuDqRGVVW8BucmVm1GBJwSYrZ2bYRlz8G5im+KLfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82310400005)(4326008)(70586007)(40460700003)(40480700001)(41300700001)(70206006)(2616005)(426003)(47076005)(186003)(5660300002)(8676002)(8936002)(336012)(6666004)(478600001)(26005)(316002)(44832011)(30864003)(110136005)(82740400003)(54906003)(81166007)(356005)(83380400001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:43:16.7608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c3decd-8c42-4af3-2b01-08dacbdf7d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI endpoint device such as Xilinx Alveo PCI card maps the register
spaces from multiple hardware peripherals to its PCI BAR. Normally,
the PCI core discovers devices and BARs using the PCI enumeration process.
There is no infrastructure to discover the hardware peripherals that are
present in a PCI device, and which can be accessed through the PCI BARs.

For Alveo PCI card, the card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. The Alveo card driver can
load this flattened device tree and leverage device tree framework to
generate platform devices for the hardware peripherals eventually.

Apparently, the device tree framework requires a device tree node for the
PCI device. Thus, it can generate the device tree nodes for hardware
peripherals underneath. Because PCI is self discoverable bus, there might
not be a device tree node created for PCI devices. This patch is to add
support to generate device tree node for PCI devices.

Added a kernel option. When the option is turned on, the kernel will
generate device tree nodes for PCI bridges unconditionally.

Initially, the basic properties are added for the dynamically generated
device tree nodes.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  71 ++++++++++
 drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 +++
 drivers/pci/remove.c        |   1 +
 9 files changed, 368 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..126c31b79718 100644
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
+	  for all PCI bridges.
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2680e4c92f0a..cc8b4e01e29d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
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
index 196834ed44fe..fb60b04f0b93 100644
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
@@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
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
+	struct device_node *parent, *dt_node = NULL;
+	const char *pci_type = "dev";
+	struct of_changeset *cset;
+	const char *full_name;
+	int ret;
+
+	/*
+	 * If there is already a device tree node linked to this device,
+	 * return immediately.
+	 */
+	if (pci_device_to_OF_node(pdev))
+		return;
+
+	/* Check if there is device tree node for parent device */
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
+	full_name = kasprintf(GFP_KERNEL, "%pOF/%s@%x,%x", parent, pci_type,
+			      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!full_name)
+		goto failed;
+
+	dt_node = of_create_node(parent, full_name, &cset);
+	if (!dt_node)
+		goto failed;
+	kfree(full_name);
+
+	ret = of_pci_add_properties(pdev, cset, dt_node);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto failed;
+
+	pdev->dev.of_node = dt_node;
+
+	return;
+
+failed:
+	if (dt_node)
+		of_destroy_node(dt_node);
+	kfree(full_name);
+}
+#endif
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
new file mode 100644
index 000000000000..cc66fa7517e0
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include "pci.h"
+
+struct of_pci_addr_pair {
+	__be32		phys_hi;
+	__be32		phys_mid;
+	__be32		phys_lo;
+	__be32		size_hi;
+	__be32		size_lo;
+};
+
+struct of_pci_range {
+	__be32		child_addr_hi;
+	__be32		child_addr_mid;
+	__be32		child_addr_lo;
+	__be32		parent_addr_hi;
+	__be32		parent_addr_mid;
+	__be32		parent_addr_lo;
+	__be32		size_hi;
+	__be32		size_lo;
+};
+
+#define OF_PCI_ADDR_SPACE_CONFIG	0x0
+#define OF_PCI_ADDR_SPACE_IO		0x1
+#define OF_PCI_ADDR_SPACE_MEM32		0x2
+#define OF_PCI_ADDR_SPACE_MEM64		0x3
+
+#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
+#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
+#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
+#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
+#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
+#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
+#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
+
+#define OF_PCI_ADDR_HI			GENMASK_ULL(63, 32)
+#define OF_PCI_ADDR_LO			GENMASK_ULL(31, 0)
+#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
+#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
+
+#define OF_PCI_ADDRESS_CELLS		3
+#define OF_PCI_SIZE_CELLS		2
+
+enum of_pci_prop_compatible {
+	PROP_COMPAT_PCI_VVVV_DDDD,
+	PROP_COMPAT_PCICLASS_CCSSPP,
+	PROP_COMPAT_PCICLASS_CCSS,
+	PROP_COMPAT_NUM,
+};
+
+static int of_pci_prop_device_type(struct pci_dev *pdev,
+				   struct of_changeset *ocs,
+				   struct device_node *np)
+{
+	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
+}
+
+static int of_pci_prop_address_cells(struct pci_dev *pdev,
+				     struct of_changeset *ocs,
+				     struct device_node *np)
+{
+	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
+					 OF_PCI_ADDRESS_CELLS);
+}
+
+static int of_pci_prop_size_cells(struct pci_dev *pdev,
+				  struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
+					 OF_PCI_SIZE_CELLS);
+}
+
+static int of_pci_set_addr_flags(struct resource *res, u32 *addr_hi)
+{
+	u32 ss;
+
+	if (res->flags & IORESOURCE_IO)
+		ss = OF_PCI_ADDR_SPACE_IO;
+	else if (res->flags & IORESOURCE_MEM_64)
+		ss = OF_PCI_ADDR_SPACE_MEM64;
+	else if (res->flags & IORESOURCE_MEM)
+		ss = OF_PCI_ADDR_SPACE_MEM32;
+	else
+		return -EINVAL;
+
+	*addr_hi &= ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH);
+	if (res->flags & IORESOURCE_PREFETCH)
+		*addr_hi |= OF_PCI_ADDR_FIELD_PREFETCH;
+
+	*addr_hi |= ss;
+
+	return 0;
+}
+
+static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
+			      struct device_node *np)
+{
+	struct of_pci_range rp[PCI_BRIDGE_RESOURCE_NUM];
+	struct resource *res;
+	int i = 0, j, ret;
+	u64 val64;
+	u32 val;
+
+	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
+	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
+		if (!resource_size(&res[j]))
+			continue;
+
+		val = OF_PCI_ADDR_FIELD_NONRELOC;
+		if (of_pci_set_addr_flags(&res[j], &val))
+			continue;
+
+		rp[i].parent_addr_hi = cpu_to_be32(val);
+
+		val64 = res[j].start;
+		rp[i].parent_addr_mid =
+			cpu_to_be32(FIELD_GET(OF_PCI_ADDR_HI, val64));
+		rp[i].parent_addr_lo =
+			cpu_to_be32(FIELD_GET(OF_PCI_ADDR_LO, val64));
+
+		val64 = resource_size(&res[j]);
+		rp[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, val64));
+		rp[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, val64));
+
+		rp[i].child_addr_hi = rp[i].parent_addr_hi;
+		rp[i].child_addr_mid = rp[i].parent_addr_mid;
+		rp[i].child_addr_lo = rp[i].parent_addr_lo;
+		i++;
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
+					      i * sizeof(*rp) / sizeof(u32));
+
+	return ret;
+}
+
+static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
+			   struct device_node *np)
+{
+	struct of_pci_addr_pair *reg;
+	int i = 1, resno, ret = 0;
+	u32 reg_val, base_addr;
+	resource_size_t sz;
+
+	reg = kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg_val = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	reg[0].phys_hi = cpu_to_be32(reg_val);
+
+	base_addr = PCI_BASE_ADDRESS_0;
+	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
+	     resno++, base_addr += 4) {
+		sz = pci_resource_len(pdev, resno);
+		if (!sz)
+			continue;
+
+		ret = of_pci_set_addr_flags(&pdev->resource[resno], &reg_val);
+		if (!ret)
+			continue;
+
+		reg_val &= ~OF_PCI_ADDR_FIELD_REG;
+		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
+		reg[i].phys_hi = cpu_to_be32(reg_val);
+		reg[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, sz));
+		reg[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, sz));
+		i++;
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)reg,
+					      i * sizeof(*reg) / sizeof(u32));
+	kfree(reg);
+
+	return ret;
+}
+
+static int of_pci_prop_compatible(struct pci_dev *pdev,
+				  struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
+	int i, ret;
+
+	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
+		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
+		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
+		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
+
+	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
+						 compat_strs, PROP_COMPAT_NUM);
+	for (i = 0; i < PROP_COMPAT_NUM; i++)
+		kfree(compat_strs[i]);
+
+	return ret;
+}
+
+static int (*of_pci_endpoint_props[])(struct pci_dev *pdev,
+				      struct of_changeset *ocs,
+				      struct device_node *np) = {
+	of_pci_prop_reg,
+	of_pci_prop_compatible,
+	NULL
+};
+
+static int (*of_pci_bridge_props[])(struct pci_dev *pdev,
+				    struct of_changeset *ocs,
+				    struct device_node *np) = {
+	of_pci_prop_device_type,
+	of_pci_prop_address_cells,
+	of_pci_prop_size_cells,
+	of_pci_prop_ranges,
+	of_pci_prop_reg,
+	of_pci_prop_compatible,
+	NULL
+};
+
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np)
+{
+	int (**prop_func)(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np);
+	int i, ret;
+
+	if (pci_is_bridge(pdev))
+		prop_func = of_pci_bridge_props;
+	else
+		prop_func = of_pci_endpoint_props;
+
+	for (i = 0; prop_func[i]; i++) {
+		ret = prop_func[i](pdev, ocs, np);
+		if (ret) {
+			/*
+			 * The added properties will be released when the
+			 * changeset is destroyed.
+			 */
+			return ret;
+		}
+	}
+
+	return 0;
+}
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
index 785f31086313..bd81dc4ca04f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -678,6 +678,25 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #endif /* CONFIG_OF */
 
+struct of_changeset;
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+void of_pci_make_dev_node(struct pci_dev *pdev);
+void of_pci_remove_node(struct pci_dev *pdev);
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np);
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
+#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */
+
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
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

