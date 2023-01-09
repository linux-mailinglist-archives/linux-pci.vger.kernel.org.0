Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE500662FA4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjAIS50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 13:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbjAIS5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 13:57:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F3A1CB31;
        Mon,  9 Jan 2023 10:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9MPG059XasOrKLZn0mCTIAakfBLnQ9MTLiNBC4vN5fuflT35azXYcVPDtKklfzusbwb+q+zEUI03bcVQQhK8IV+iXT+nbUhy2KSqx6kVNrUT9ccmh8f4u2VgwRs/7VdqC0jhyK/o3EQRjx8KmGNSXAtoVA1o3ESa7RS7acTm9ys0o3vcWBUEIAgfDqToz0l/l/hqPc4v+VdX5dl+zizKvOwmDf4pSheu7guowWt2OtBMner1pOmOrASz77h8ImZzFbtrJanpEFINavb4YaVxbXcmXiyAVG1TrYRn5lK89J8KZETZAkO7iewXTIuP6SCIi3RlyOXa666GZl9bEwEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vi9viLlV5GcqHXFOZeKB8rDT1/5a/IEyM9YfTSFcyg=;
 b=Jm+kkFtnavkJGLkm+REgx8yBisbJCseUloPjEudQu47ykDXNNjCLNTo//rEY0+Sy4SjA5vtNl5i1AIqnJ3s5DljPbJoG2DmQd0kAt/Ws9yjhWA5994TmjlIbLwnQa1eXBJUQhuX8u/1dFtLiCp2KxYgM2/2AJ5EgmxBMJhfMbG9WsE/OD6mIVDnhpSE/25ULS/3QwAR3U80gyjxYsfcP3GanZ5nF5yUrx26U1nys8zNeaEQUIYHTc0T+okbJeYQOwwiDXOSxA4jkS8kTD1boSMx4YwlFumI6TL6QLAhuCS0VO339PA6PxZ580nqbKmVJq2j4k+5od6BP3QYPqDgaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vi9viLlV5GcqHXFOZeKB8rDT1/5a/IEyM9YfTSFcyg=;
 b=Ig6von+BQ5p90yr337UDF3v2N3+YVt6E3Hex+pKLSYeNsupsX385YftfznxkDM94zKUvX8iXuMutRh1mBlXYvC1kTwO80q0/QAu6SMxaQ/u3qdIbiqO/T1aXo/oQp3vRDIqiEfv8Snqvr+PBH0GIcdRemU5vEMksy1rtv22wYyw=
Received: from CY5PR15CA0087.namprd15.prod.outlook.com (2603:10b6:930:18::13)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:57:09 +0000
Received: from CY4PEPF0000C96E.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::4) by CY5PR15CA0087.outlook.office365.com
 (2603:10b6:930:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 18:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96E.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 18:57:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:08 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 9 Jan 2023 12:57:07 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V6 2/3] PCI: Create device tree node for selected devices
Date:   Mon, 9 Jan 2023 10:57:00 -0800
Message-ID: <1673290621-22888-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
References: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96E:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e97902d-0d5c-41f2-3c22-08daf2734f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiVsoqxE0ZmZC5D9OOxqfvFic9665Ey7iDpBgw4m8gEFwiWQ38jCEKPdAUy7TuI3OWhpTPyRt2vs8cZ85XHoj7rL1WDBUpGB2VLensLfZiIixPDVZSAcR3ZSpR8PouPpWJYvQ+X/I4iG3hW8ashyqJ8AY8Jk4qL9igp4ff98l3OF0NlVTU2nq9IKfqcfxdxEMbLBIw+kD70anYutXtj6w/4egUa6x1oW6bTCQmibh5kwbYuMjHXwrQTVA6CwLtGB/XKXJVQ1bwYNwzMBSZh5OTjL8J41Dlc74FpthKL/nWap7WsPPc0qBgHEHaPN32xvSPVe/hUKZBYSMuRRAcxmyj107s7/MdCAxeFLOBrald5sMktk2BpLsseKQ5ywGjOUgFVkxe6OJPFUIYtS3mWaoko+jF4QtIWfsuaTLdD6Y/z7gwgapWrjmwTs1USdyQYak5S8cD2r4hyNmYMm0hCChXvbRS6yMNIOcVhqzJEZR0MK9DPRBV0rWwEorveosxwlVzghJ5xDjTDXZrPUrvA5rjn/bMU32YMj9syn9mIKjth/CoKQVODkzz2hMpm2uBo6ctpAfhm1D3ahBgmKHe86pSZTq3AF70KTcehejmj3WUXjvYAxxMChW6O/cQjp9Ua7dE7Uy+/zZSYOVKyqoJDr8z1+emkJAFbZycvWe8VKkfBTDTx3a2oxXXRcYi9pcgIjpFFsmahO+KquP+VJpl0KG0WpevvlWYCkkpYpVRr1mFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(41300700001)(44832011)(8936002)(36756003)(30864003)(5660300002)(2906002)(8676002)(70586007)(70206006)(316002)(110136005)(54906003)(6666004)(40480700001)(478600001)(47076005)(4326008)(336012)(186003)(26005)(2616005)(426003)(40460700003)(86362001)(83380400001)(36860700001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:57:09.1923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e97902d-0d5c-41f2-3c22-08daf2734f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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
 drivers/pci/of.c            |  71 +++++++++++
 drivers/pci/of_property.c   | 229 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 +++
 drivers/pci/remove.c        |   1 +
 9 files changed, 341 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9309f2469b41..24c3107c68cc 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -193,6 +193,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DYNAMIC_OF_NODES
+	bool "Create Devicetree nodes for PCI devices"
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
index 83ae838ceb5f..e913c7fe8630 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -320,6 +320,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
+	if (pci_is_bridge(dev))
+		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e33bcc872699..cd73d2250305 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -456,8 +456,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
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
index 196834ed44fe..cb34a73ac8a3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		} else {
 			/* We found a P2P bridge, check if it has a node */
 			ppnode = pci_device_to_OF_node(ppdev);
+			if (ppnode && of_node_check_flag(ppnode, OF_DYNAMIC))
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
+	struct device_node *np;
+
+	np = pci_device_to_OF_node(pdev);
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+		return;
+	pdev->dev.of_node = NULL;
+
+	of_destroy_node(np);
+}
+
+void of_pci_make_dev_node(struct pci_dev *pdev)
+{
+	struct device_node *ppnode, *np = NULL;
+	const char *pci_type = "dev";
+	struct of_changeset *cset;
+	const char *name;
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
+		ppnode = pdev->bus->dev.of_node;
+	else
+		ppnode = pdev->bus->self->dev.of_node;
+	if (!ppnode)
+		return;
+
+	if (pci_is_bridge(pdev))
+		pci_type = "pci";
+
+	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!name)
+		goto failed;
+
+	np = of_create_node(ppnode, name, &cset);
+	if (!np)
+		goto failed;
+
+	ret = of_pci_add_properties(pdev, cset, np);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto failed;
+
+	pdev->dev.of_node = np;
+	kfree(name);
+
+	return;
+
+failed:
+	if (np)
+		of_destroy_node(np);
+	kfree(name);
+}
+#endif
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
new file mode 100644
index 000000000000..eab18d0d63ea
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,229 @@
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
+#define OF_PCI_ADDRESS_CELLS		3
+#define OF_PCI_SIZE_CELLS		2
+
+struct of_pci_addr_pair {
+	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
+	u32		size[OF_PCI_SIZE_CELLS];
+};
+
+struct of_pci_range {
+	u32		child_addr[OF_PCI_ADDRESS_CELLS];
+	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
+	u32		size[OF_PCI_SIZE_CELLS];
+};
+
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
+enum of_pci_prop_compatible {
+	PROP_COMPAT_PCI_VVVV_DDDD,
+	PROP_COMPAT_PCICLASS_CCSSPP,
+	PROP_COMPAT_PCICLASS_CCSS,
+	PROP_COMPAT_NUM,
+};
+
+static int of_pci_prop_device_type(struct of_changeset *ocs,
+				   struct device_node *np)
+{
+	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
+}
+
+static int of_pci_prop_address_cells(struct of_changeset *ocs,
+				     struct device_node *np)
+{
+	return of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					 OF_PCI_ADDRESS_CELLS);
+}
+
+static int of_pci_prop_size_cells(struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	return of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					 OF_PCI_SIZE_CELLS);
+}
+
+static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
+			       u32 reg_num, u32 flags, bool reloc)
+{
+	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	prop[0] |= flags | reg_num;
+	if (!reloc) {
+		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
+		prop[1] = FIELD_GET(OF_PCI_ADDR_HI, addr);
+		prop[2] = FIELD_GET(OF_PCI_ADDR_LO, addr);
+	}
+}
+
+static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
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
+	*flags = 0;
+	if (res->flags & IORESOURCE_PREFETCH)
+		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+
+	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
+
+	return 0;
+}
+
+static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
+			      struct device_node *np)
+{
+	struct of_pci_range *rp;
+	struct resource *res;
+	int i = 0, j, ret;
+	u64 val64;
+	u32 flags;
+
+	rp = kcalloc(PCI_BRIDGE_RESOURCE_NUM, sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
+	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
+		if (!resource_size(&res[j]))
+			continue;
+
+		if (of_pci_get_addr_flags(&res[j], &flags))
+			continue;
+
+		val64 = res[j].start;
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+				   false);
+		memcpy(rp[i].child_addr, rp[i].parent_addr,
+		       sizeof(rp[i].child_addr));
+
+		val64 = resource_size(&res[j]);
+		rp[i].size[0] = FIELD_GET(OF_PCI_SIZE_HI, val64);
+		rp[i].size[1] = FIELD_GET(OF_PCI_SIZE_LO, val64);
+
+		i++;
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
+					      i * sizeof(*rp) / sizeof(u32));
+	kfree(rp);
+
+	return ret;
+}
+
+static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
+			   struct device_node *np)
+{
+	struct of_pci_addr_pair *reg;
+	int i = 1, resno, ret = 0;
+	u32 flags, base_addr;
+	resource_size_t sz;
+
+	reg = kcalloc(PCI_STD_NUM_BARS + 1, sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	/* configuration space */
+	of_pci_set_address(pdev, reg[0].phys_addr, 0, 0, 0, true);
+
+	base_addr = PCI_BASE_ADDRESS_0;
+	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
+	     resno++, base_addr += 4) {
+		sz = pci_resource_len(pdev, resno);
+		if (!sz)
+			continue;
+
+		ret = of_pci_get_addr_flags(&pdev->resource[resno], &flags);
+		if (ret)
+			continue;
+
+		of_pci_set_address(pdev, reg[i].phys_addr, 0, base_addr, flags,
+				   true);
+		reg[i].size[0] = FIELD_GET(OF_PCI_SIZE_HI, (u64)sz);
+		reg[i].size[1] = FIELD_GET(OF_PCI_SIZE_LO, (u64)sz);
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
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np)
+{
+	int ret = 0;
+
+	if (pci_is_bridge(pdev)) {
+		ret |= of_pci_prop_device_type(ocs, np);
+		ret |= of_pci_prop_address_cells(ocs, np);
+		ret |= of_pci_prop_size_cells(ocs, np);
+		ret |= of_pci_prop_ranges(pdev, ocs, np);
+	}
+
+	ret |= of_pci_prop_reg(pdev, ocs, np);
+	ret |= of_pci_prop_compatible(pdev, ocs, np);
+
+	/*
+	 * The added properties will be released when the
+	 * changeset is destroyed.
+	 */
+	return ret;
+}
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a2ceeacc33eb..995c32728231 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1634,7 +1634,8 @@ static int pci_dma_configure(struct device *dev)
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-	    bridge->parent->of_node) {
+	    bridge->parent->of_node &&
+	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
 		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9ed3b5550043..ef092af6717d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -681,6 +681,25 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
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
index 0145aef1b930..1462f2d9b194 100644
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
2.34.1

