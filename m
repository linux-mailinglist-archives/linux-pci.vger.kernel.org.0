Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E307625BF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 00:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGYWPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGYWPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 18:15:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37499BC;
        Tue, 25 Jul 2023 15:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USUbog6hZ1LtCXRSCkg1HAPuatt2LvAO+51VDi6OpZTVe4fN/zdcqaUYBW+jnUN/H/EN5SPyqed3H7R80omwOtqkwQM1MW3kmpkxBJh/pEslHFCuUiWsNbldCv8TkUWjtA56XgUrjeUBTSs2rVVcv4NcPhREzYIv0o1DcCRA090DYhTKWw6jpEh3wt5My87vDAjzf8BcRBlocPnOaXJDbUjvZK+uCKo/lCZBPZIGikMkPTCh6b94M/i05ZtfSTT5fXjkd0kSaOaKPFXIGnjXEFEz41s4GMubMCIo9L69PguP5ckSvN8+evOF96SJHRNoKgCgJaibZN9c803pwLd+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn+bwasJNwaFGTA5o/gwX4FAgQz7CJJpFbOPWqbHbfQ=;
 b=aKq3CalNRaI2v2ab8YWZ5azbBma6fU7fJiNHEqI6LbnCdN/uzcciWy1Ggs6SgGrM5iwVTWH9GyokKcKZJ3UDTeiNURSI9cwavqM3gBUnhl3F2SKzBMMkBfecGRveG0AndNtj5SosQjSzeN6c6HIt/Nc3GfhZ2ibFKdCaCBIfbgmR/rC/KfJ29YFT25VcsJ1XaeHIPHskMsa+Ta81wwvK/+Xza8wnhWRvzlPP2AWpLCqgmCHcUsYUGfceAyxf+cYplm0aIw5PJmYQhd7qEnEvpkvulmP6snnAyOtDNDOuxGkb73X3QDwBa2VFhhtSZ8LsOB5cfRsN1n6y40Xj9bPYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn+bwasJNwaFGTA5o/gwX4FAgQz7CJJpFbOPWqbHbfQ=;
 b=V+g4cgFX3AuWx/3HdiRVpN2eDbOL6EmPZ09ykpVznHG7tHRPMQCSofuD8KHZleBt1plAaq6VRrgRfVFk0fOMUGMprNo7+bYr3zdpGwhMHfk4/YzqTqOk0pr8ppz6lNxY7OUvU4VWwRXo10aCuZ0EbxU79J8KuPiLx+dWEpvjK/s=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 22:15:33 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::27) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 22:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 22:15:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 17:15:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 15:15:31 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 17:15:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V11 2/5] PCI: Create device tree node for bridge
Date:   Tue, 25 Jul 2023 15:15:15 -0700
Message-ID: <1690323318-6103-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
References: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a623d1b-9629-45fa-b091-08db8d5ca9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DE/L3MYB6iD4kl7G22HbZ0Ynj0vYus/BtGC15UkDDk2Hk9lL+eYK2XWWh+/gKPfH/048ZwhICAnI0+2UZV52JaW23mvTXEdcMk7z69Ms9MnrD1qeG/OLYaG+DATpn2uMLl4rpdBeu2zkS2q55UL80b1SZjvqOUlFdP61TKmvVmM9la7lj/iN/cyloIP/qfIPU+i47jFIA3KFBCb0RF1ybc/bwRJNwHhJKhfTYLpU9CIO5SXWmp/BJIeIxFNLAlVEH4cJ8+PRsWVJvbKJwF63Eto9jmiCpuLIfeJFTeeJxs5+v21JVtqZCWshUXONTuKgMZkMR3SsSI7kKzbIVUF3rOMZLpu+Fcm6cHma0qTjk7jF5llMbmAN+NuwEqVYR3FrS/Crbo8o+sXCzs+hAOLA+Lu6JvTVZUdL1ZShx8r1KzCPAeVzObCsPn0EKSH/flmwY1ESyYVJ5QXSRv4I++QeWiGqhIcuWb7BEBOpqn0Sip6ZEuI/sILPuro0txlFJ0uKUJDqEYQcZPdOsFHsS0k/nM9T3FLe81VX99NobnuvdnGoYbRYr/4qkDBZu2i+6gua6zS17GPlO0sxz3xpjo/9OJOpU7cbJ4yjRSF2ZHIjyrsAf/INunLCIWLrvRYZiqW72s4TTHDR4Lbb7skldKxNesfGfFrMOXC7yfWCtEUWOBUMdozi9RD3buCqCMzZ8xw/ag+pViuNWezWayWe2F56n3QINX/vKBb4PX/RnxH21b1csla2+UbHDC63IphkszI3n+ngTf2xATnJz1YMApKTtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82740400003)(478600001)(336012)(186003)(26005)(110136005)(426003)(54906003)(6666004)(2616005)(4326008)(70206006)(70586007)(47076005)(83380400001)(36860700001)(44832011)(5660300002)(8676002)(8936002)(40460700003)(2906002)(41300700001)(30864003)(316002)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 22:15:32.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a623d1b-9629-45fa-b091-08db8d5ca9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Apparently, the device tree framework requires a device tree node for the
PCI device. Thus, it can generate the device tree nodes for hardware
peripherals underneath. Because PCI is self discoverable bus, there might
not be a device tree node created for PCI devices. Furthermore, if the PCI
device is hot pluggable, when it is plugged in, the device tree nodes for
its parent bridges are required. Add support to generate device tree node
for PCI bridges.

Add an of_pci_make_dev_node() interface that can be used to create device
tree node for PCI devices.

Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
the kernel will generate device tree nodes for PCI bridges unconditionally.

Initially, add the basic properties for the dynamically generated device
tree nodes which include #address-cells, #size-cells, device_type,
compatible, ranges, reg.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/Kconfig       |  12 ++
 drivers/pci/Makefile      |   1 +
 drivers/pci/bus.c         |   2 +
 drivers/pci/of.c          |  96 +++++++++++++++-
 drivers/pci/of_property.c | 232 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  12 ++
 drivers/pci/remove.c      |   1 +
 7 files changed, 354 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 3c07d8d214b3..49bd09c7dd0a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -194,6 +194,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DYNAMIC_OF_NODES
+	bool "Create device tree nodes for PCI devices"
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
index 5bc81cc0a2de..ab7d06cd0099 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -340,6 +340,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
+	if (pci_is_bridge(dev))
+		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e51219f9f523..11d3be165e32 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -495,8 +495,21 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		 * to rely on this function (you ship a firmware that doesn't
 		 * create device nodes for all PCI devices).
 		 */
-		if (ppnode)
-			break;
+		if (ppnode) {
+			/*
+			 * When PCI_DYNAMIC_OF_NODES is on, a device tree
+			 * node will be generated for PCI bridge. For the
+			 * dynamically generated node, interrupt mapping is
+			 * not supported. Thus, it needs to check interrupt-map
+			 * property and set ppnode to NULL to do standard
+			 * swizzling if interrupt-map does not present.
+			 */
+			if (IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES) &&
+			    !of_property_present(ppnode, "interrupt-map"))
+				ppnode = NULL;
+			else
+				break;
+		}
 
 		/*
 		 * We can only get here if we hit a P2P bridge with no node;
@@ -611,6 +624,85 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
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
+	of_changeset_revert(np->data);
+	of_changeset_destroy(np->data);
+	of_node_put(np);
+}
+
+void of_pci_make_dev_node(struct pci_dev *pdev)
+{
+	struct device_node *ppnode, *np = NULL;
+	const char *pci_type;
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
+	else
+		pci_type = "dev";
+
+	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!name)
+		return;
+
+	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
+	if (!cset)
+		goto failed;
+	of_changeset_init(cset);
+
+	np = of_changeset_create_node(ppnode, name, cset);
+	if (!np)
+		goto failed;
+	np->data = cset;
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
+		of_node_put(np);
+	kfree(name);
+}
+#endif
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
new file mode 100644
index 000000000000..8d485759de26
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
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
+/*
+ * Each entry in the ranges table is a tuple containing the child address,
+ * the parent address, and the size of the region in the child address space.
+ * Thus, for PCI, in each entry parent address is an address on the primary
+ * side and the child address is the corresponding address on the secondary
+ * side.
+ */
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
+enum of_pci_prop_compatible {
+	PROP_COMPAT_PCI_VVVV_DDDD,
+	PROP_COMPAT_PCICLASS_CCSSPP,
+	PROP_COMPAT_PCICLASS_CCSS,
+	PROP_COMPAT_NUM,
+};
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
+		prop[1] = upper_32_bits(addr);
+		prop[2] = lower_32_bits(addr);
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
+static int of_pci_prop_bus_range(struct pci_dev *pdev,
+				 struct of_changeset *ocs,
+				 struct device_node *np)
+{
+	u32 bus_range[] = { pdev->subordinate->busn_res.start,
+			    pdev->subordinate->busn_res.end };
+
+	return of_changeset_add_prop_u32_array(ocs, np, "bus-range", bus_range,
+					       ARRAY_SIZE(bus_range));
+}
+
+static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
+			      struct device_node *np)
+{
+	struct of_pci_range *rp;
+	struct resource *res;
+	int i, j, ret;
+	u32 flags, num;
+	u64 val64;
+
+	if (pci_is_bridge(pdev)) {
+		num = PCI_BRIDGE_RESOURCE_NUM;
+		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
+	} else {
+		num = PCI_STD_NUM_BARS;
+		res = &pdev->resource[PCI_STD_RESOURCES];
+	}
+
+	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; j < num; j++) {
+		if (!resource_size(&res[j]))
+			continue;
+
+		if (of_pci_get_addr_flags(&res[j], &flags))
+			continue;
+
+		val64 = res[j].start;
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+				   false);
+		if (pci_is_bridge(pdev)) {
+			memcpy(rp[i].child_addr, rp[i].parent_addr,
+			       sizeof(rp[i].child_addr));
+		} else {
+			/*
+			 * For endpoint device, the lower 64-bits of child
+			 * address is always zero.
+			 */
+			rp[i].child_addr[0] = j;
+		}
+
+		val64 = resource_size(&res[j]);
+		rp[i].size[0] = upper_32_bits(val64);
+		rp[i].size[1] = lower_32_bits(val64);
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
+	struct of_pci_addr_pair reg = { 0 };
+
+	/* configuration space */
+	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
+
+	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
+					       sizeof(reg) / sizeof(u32));
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
+	int ret;
+
+	/*
+	 * The added properties will be released when the
+	 * changeset is destroyed.
+	 */
+	if (pci_is_bridge(pdev)) {
+		ret = of_changeset_add_prop_string(ocs, np, "device_type",
+						   "pci");
+		if (ret)
+			return ret;
+
+		ret = of_pci_prop_bus_range(pdev, ocs, np);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_pci_prop_ranges(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					OF_PCI_ADDRESS_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					OF_PCI_SIZE_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_pci_prop_reg(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	ret = of_pci_prop_compatible(pdev, ocs, np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..ba717bdd700d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -679,6 +679,18 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #endif /* CONFIG_OF */
 
+struct of_changeset;
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+void of_pci_make_dev_node(struct pci_dev *pdev);
+void of_pci_remove_node(struct pci_dev *pdev);
+int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
+			  struct device_node *np);
+#else
+static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
+static inline void of_pci_remove_node(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d68aee29386b..d749ea8250d6 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -22,6 +22,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
 	}
-- 
2.34.1

