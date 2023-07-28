Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB537672E8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjG1RHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 13:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjG1RHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 13:07:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27135AD;
        Fri, 28 Jul 2023 10:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0rH/kQv4IFakW+Q1LtCP/6kxqYF0EUD3X5lR7bx0e+KCJuQMFYFnkyGRjmucxpGGwn0noP1r1Bhs0pS0uoYVsIusjQIu/CGrK3udOy0WH346qnt0UoMVRBaOZ7K4OZz8OuBqDvIEyUThFJnZWjO54gn4n+rkh5HY5KeCFWVnLn8j0PJKdisL4YBe5P6E83onf/m+778hWCohr7fpaWmNZ6itqnmO4waGf2/9pWwWmKGAVoP6vh8/I7gTXTtEYDGOI9Vbx//H+BJ3qHhEcLLki+ri069A0w4rojX5X7257zGxDrWsvDJxTuD5iVd+DXk37Zc8Sn1wF3p1hxM3HbmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79dkGWcSIrhJEKzd6bcfhZO6P7zkHLTsROnq2ABASVY=;
 b=nzRBVOi8Qt/AS6JQOoPUXuYxfsAu8LxuILaK0HD8pc//j0elvkQRSaASSYpe5VYh4b3KrP1lac0FGkxfIXyxyB4lJ3IZeuaqqBTLcGqMhZPA+9rZ5tv2cX2mSlBPFX3jHTV0tR13tK50mc9uxftOK6jIWjNiQkh5N9Qv4rxoarnBtfGy58su+JZ7xBg+ykClphmbz2yijp6D8p9wX4wi+D6Rpw97XndA4AYBCzz3TkG0A/yDev7vrcaaM4o0YtY65zeoIfN/wed97nFnFDA1QSDGOR/5LqhwsHT2HAPfkH7k27bhHBlU6Lo29FzpwndSXRgsEr6C2fU2DmkO7wy2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79dkGWcSIrhJEKzd6bcfhZO6P7zkHLTsROnq2ABASVY=;
 b=AaA4dJ4gRI8CGHOrpboQSYpkBhEzImi7ZYto4Ic6cSM5exIpIN15xypLHAlh+pFiJ+z1/zcwm2eqD3mOXGV1FVZbr2CZ7p6QHGUqT9eaucopK1pGwb09u+bOyzNQTVVjYxNm25lS3zuI4FmcriGGYnWnSKJWCJ13lEdtXJxXDm4=
Received: from CYZPR17CA0023.namprd17.prod.outlook.com (2603:10b6:930:8c::29)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:03 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::58) by CYZPR17CA0023.outlook.office365.com
 (2603:10b6:930:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 17:07:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:02 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:01 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V12 2/5] PCI: Create device tree node for bridge
Date:   Fri, 28 Jul 2023 10:06:55 -0700
Message-ID: <1690564018-11142-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
References: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BY5PR12MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e201777-98c1-44eb-c19e-08db8f8d109e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQsD9De8P8M1h8UvAvQtG6TnMA6CrkSFkNTs5G9EbH/owevqmJICBgpfM364YL0ORaJqh+hKPVKmKAN1yYqQBWwMfILuUhd3NJZzj8DoxbCRMzJIJOF2mGKsKwsE5fen1rl8okOVYBnaARIrKfw39E5jvQo4DNaBuy31HI9rb5PjRQgTcGN84duNuh6tNpgYeeNnPuug189fh1lp6IgkIsea+Z3NAWfe3EsjLFCYid/EBqtnk1q5s7n9zlp5jlX/5mtsLo7YsYWo+rkvVWPwBREg7viG34ZLMOWsIeyBel5rYHlcID4YqTa9Zo/Pb+ekLkaV4JXzfv+DlOWxLEs4R+f5Ac0hE8C5iphrXDjEs9GVr+Xe8QvP0u6l34g5PS+vY4+uXc58XyIXgMkCpOxoIe63MI0bw4uiXBiHcFJvy+ugfVbVtz7KpE7UTxURFDx1/LyogtKKu2pDY4EBcdaFOcj5PAsw4Kj9Ha6XbvQO+B67U7bTfh2Q6BggDNZv1nNAfeOv0roiGou9RVtOtWdCSJFRoOWXRkmBm92EZorgPun5ChKbV6DjYkPrO0xuZ+52gHaCAn2f2H8wsNJAHkodaQjfav/oqZ6QFpYUnDqm22ZxsQUp2FtCHiR1e9rKWTPuVYpn8S2eW/48zUPMk/yKhUDCudlgfM7EFaK5ChCD+p2LLUYn6wqy6sTQX44qmNDxIWOGKUDs99pMQdMDfyMtdgQsQAr1XHDhc04BYTtFVLxspEGsx9Tl6ygMfFx6D3Sr0+q7Tjlkwyj9GIuvNliz1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(316002)(26005)(8936002)(41300700001)(40460700003)(54906003)(110136005)(81166007)(82740400003)(4326008)(70206006)(356005)(478600001)(70586007)(8676002)(40480700001)(30864003)(6666004)(36756003)(2616005)(2906002)(426003)(36860700001)(86362001)(83380400001)(47076005)(186003)(44832011)(336012)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:03.3964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e201777-98c1-44eb-c19e-08db8f8d109e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
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
 drivers/pci/of.c          |  79 +++++++++
 drivers/pci/of_property.c | 355 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  12 ++
 drivers/pci/remove.c      |   1 +
 7 files changed, 462 insertions(+)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 3c07d8d214b3..49bd09c7dd0a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -194,6 +194,18 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DYNAMIC_OF_NODES
+	bool "Create Device tree nodes for PCI devices"
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
index e51219f9f523..ec132fbf5c69 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -611,6 +611,85 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
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
index 000000000000..710ec35ba4a1
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include "pci.h"
+
+#define OF_PCI_ADDRESS_CELLS		3
+#define OF_PCI_SIZE_CELLS		2
+#define OF_PCI_MAX_INT_PIN		4
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
+static int of_pci_prop_interrupts(struct pci_dev *pdev,
+				  struct of_changeset *ocs,
+				  struct device_node *np)
+{
+	int ret;
+	u8 pin;
+
+	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+	if (ret != 0)
+		return ret;
+
+	if (!pin)
+		return 0;
+
+	return of_changeset_add_prop_u32(ocs, np, "interrupts", (u32)pin);
+}
+
+static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
+				struct device_node *np)
+{
+	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
+	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
+	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
+	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
+	struct device_node *pnode;
+	struct pci_dev *child;
+	u32 *int_map, *mapp;
+	int ret;
+	u8 pin;
+
+	pnode = pci_device_to_OF_node(pdev->bus->self);
+	if (!pnode)
+		pnode = pci_bus_to_OF_node(pdev->bus);
+
+	if (!pnode) {
+		pci_err(pdev, "failed to get parent device node");
+		return -EINVAL;
+	}
+
+	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
+	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
+		i = pin - 1;
+		out_irq[i].np = pnode;
+		out_irq[i].args_count = 1;
+		out_irq[i].args[0] = pin;
+		ret = of_irq_parse_raw(laddr, &out_irq[i]);
+		if (ret) {
+			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
+			continue;
+		}
+		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
+					   &addr_sz[i]);
+		if (ret)
+			addr_sz[i] = 0;
+	}
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
+		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
+			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
+		}
+	}
+
+	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
+	mapp = int_map;
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
+		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
+			*mapp = (child->bus->number << 16) |
+				(child->devfn << 8);
+			mapp += OF_PCI_ADDRESS_CELLS;
+			*mapp = pin;
+			mapp++;
+			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			*mapp = out_irq[i].np->phandle;
+			mapp++;
+			if (addr_sz[i]) {
+				ret = of_property_read_u32_array(out_irq[i].np,
+								 "reg", mapp,
+								 addr_sz[i]);
+				if (ret)
+					goto failed;
+			}
+			mapp += addr_sz[i];
+			memcpy(mapp, out_irq[i].args,
+			       out_irq[i].args_count * sizeof(u32));
+			mapp += out_irq[i].args_count;
+		}
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map", int_map,
+					      map_sz);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
+					      int_map_mask,
+					      ARRAY_SIZE(int_map_mask));
+	if (ret)
+		goto failed;
+
+	kfree(int_map);
+	return 0;
+
+failed:
+	kfree(int_map);
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
+
+		ret = of_pci_prop_intr_map(pdev, ocs, np);
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
+	ret = of_pci_prop_interrupts(pdev, ocs, np);
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

