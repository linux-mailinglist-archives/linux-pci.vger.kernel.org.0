Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729BE62390F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 02:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKJBmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 20:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiKJBmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 20:42:42 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E827902;
        Wed,  9 Nov 2022 17:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1KPW4SFLcekNfRbTuJa/3gbLwkODTVhif6YdQFq7moYOL11m5nDABcbvoj62zWATsTXxlSdglhQ1cruzdueUEE1tKqk0lY+IEtOhQGfBDuW0/gz6rJ0wR0zxcGFND0lMNFrgKBwOXltjZVlVxtOmjPstdK4MTIiSwnWG6d9/jTLSEIfXN3swdHeAx2roTPxMGmIExWD/y/0yi4KcUEelVydVYx0xQQw6yJGKtXMi7v0MmgHT5N6c7Ucustv2cxpDF/dqVx4az1uKqVrDjPVAGUxy6hs08GVWehhP1qAWijYMW1jZpUt7oEvoR3zhQ1ISGWH+ZTsR0RB6yo41oEXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJIodgobuFSEiYutNZJPpoYNjCH+jxg0AXEvGGQuU24=;
 b=Z78dPOAtH15Sg6FMKZitCr7KpmsuvcXf7UYf+52zZlsspuRbgUTPL+MRlp2epVJyUTM2yI1gom0O2FcZEjGUIiTRGsJlu4JOfFMvtTYL1YjhDzS3ELVcnacpXa4/3ElAxzhlSgvovZ/bZwbU+bVtvDHWiqrS/pqhG4ALMQ0x/tFUwh6gN1pQIom5xlTI9kdHCtt/Rrt8u9c4CBkuPSh3fXG34wzJVHKgPsCIB3Qp7mpu5hiz1Lt5Wwh3gX03Th8w6+sWixc+EoIWkBOpvdygdyfsJMVApvAoI7+9Itc5eD4y4skFBNyjUK4/LZ9MMUdZQiUojLjYbv3aFvNLzJSPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJIodgobuFSEiYutNZJPpoYNjCH+jxg0AXEvGGQuU24=;
 b=ZZlcFBdR54ciql+qyKWgYcN7WRvVjpwnBKhOD+zk66pJJNtvCikSbAo3aVjwAUXqoSSg7VAj2JgqSoE/cuuFOjOlS6aiwfIc0HeJGkoDOk12j8HxZdENFO6z3C7O3uUYSpunwEMcY9Ci1ZR5Yt6s4+1h+ZsFLvxHdewOeqftIB0=
Received: from CY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:930:12::10)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 01:42:36 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::1a) by CY5PR17CA0056.outlook.office365.com
 (2603:10b6:930:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 10 Nov 2022 01:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 10 Nov 2022 01:42:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:42:30 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 19:42:29 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V4 2/3] PCI: Create device tree node for selected devices
Date:   Wed, 9 Nov 2022 17:42:17 -0800
Message-ID: <1668044538-27334-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
References: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fb3631-90e9-4c9a-ea28-08dac2bcd85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQim75+hwsqBv6lQcdAbXdOoc2CE48LmqdtN4W4jwvYUyqUhOjNOgiKYvxryf5i1EKNuM4mIl2rQi1Zpkh2yvbmCzWrGl444Z5EGTKcL+i9m/VYX7A5q2oqSAsN35FsaTEXMmLJiaCdiIfHZd8+/ZEf26hghVnS3Pylxq1l7JlqCX2EuGyP6qK0qBXFVcdNJ0TzqVeklQJHzdEyDnPFC0BaRaT9ZOaqeFmcGWvohsXH3srkNScmzltX6TEwH58gHq0H5OeiCP+Gawc2lFEXOHAwWp9WYQ+ek0mJmdPXc0qiGSa6qxpvBn2UaqM++d+DB6h6x6Tz96mbx50UjP3ZbVbDmiz4vDePTmnPUXoVa21kWGkKofWA9pKDpsV1VcsmUdF99H2HBZurupaFpuvb097p+kmL/105QEQKAB7Ilo7S7Tc6z6t44hc/1hOphWIZe6wNtYVrfBDQYLZ3lfJDYut80DrlKr5Pd3UEkDpN7Byb5vqtuDO0nKgGkiVIK6mmp7CHWzD4ePeyEPVppnb8JVAxRF+WnlBo9LCjkZfH+8RDfd3gVIRgZtuNX/LpBsqeX+d65YDkWC02EBHakxIVhr5yf7sMnMSopow3sx8HdV1yYHz2jP5DBJvETziBspFlizqS2to+uv6QPviMLzq32Yv0yYVFYynhWTSWM+wAVTjaYv4850GjSzrpm2TbChUF9lbvxrpg3zKvUvPIgCvmiMDX8jHBxseuVlklbVBq3GgHkkNMchEVbnzoeA49JtZj/1Xq7viCnAFHOYmGorhoG18RIxCzwvMepHecMSUGv524bdx2l9V+f0u0v6+rX/DOx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(2616005)(8676002)(26005)(54906003)(40460700003)(110136005)(316002)(36756003)(8936002)(2906002)(82310400005)(356005)(82740400003)(81166007)(186003)(36860700001)(30864003)(40480700001)(70206006)(41300700001)(70586007)(4326008)(44832011)(336012)(47076005)(83380400001)(86362001)(426003)(5660300002)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:42:36.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fb3631-90e9-4c9a-ea28-08dac2bcd85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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

