Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD95738D2D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjFURef (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFURee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 13:34:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916819B;
        Wed, 21 Jun 2023 10:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1WE7GWQiWCCJZRPS4s/BQHbCn4doWhAUlTkFWjluzfVcc0Yi83kfuV2CoFAbEFjH0RyyrTQwqhBzcIvdAtje1ms+jsCXdj0PlBgrcFuEQPT/zkvdLwbaiRfwpc+yLg1VHwd7ypK1LqX8d7CYv1AwghFftmVnFXBuGIFgE5VqwkzdvRa1AG1xSwJuslZVzD1YGjWyg5jJMSo1V++kdetGDkRdGyWdj1voyMfhU8rATahoyx9/L8mtZ5I7u6tCv3i01evOwDgUi3uBmsvTlmsYlOjObAEX+P/5LXFBVkuzX5fRJsOamXcg4fjTbYBWut8dS/yaZF2CA4PovtLT/61Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW1/oSQDSphji/rUkzPLn/1rBrc8yx5SebGOCiqvVU4=;
 b=Zq4VMfTs/+iqWSzS7DFY7Rzz2xafv4v9PM3JencRVxR8kdVa4tb2ByvamBXdnpv+dVqfS1GJ+j6F6YP8QkBGpEck4P9uwuiOvEhuNa1d0cq3giBcQtrFC1P6o4XVq0UOcqw9WzHAjq3Ng38xXVrEoNdy9TFBbAnzEZxK9pqLgRgDimymxvAUWt4f8tgG/a0UTR1Hd+2VXagXsi5yblYefL1oAEXAM1Afz3351h3XJvulfGGBaMQ5CxSJaTF8V51w9S1ryow/gMDXeP4T7jqnLwtVmnvdBMJVBPOl29/Bq4cPiN2pi9/teSP+mR+VsRyMo/Q1IWALU1sVnChJXOuVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW1/oSQDSphji/rUkzPLn/1rBrc8yx5SebGOCiqvVU4=;
 b=z/u5KchPCTiuFlWIseIcYWBRPbzJQpqwmjmugkWPo+UIc4zKs8dmfuf+p5O/Zzfu31upcV8qfCTVk8XazXFyM+BT78KF0oqprTL4ODLBBgR2YXLiDgwE19abFoeLtTvZDhSlsRmLzyEtPG33tLdT+Qz6ebctDlknDhb9IpYSgYY=
Received: from CYXPR03CA0055.namprd03.prod.outlook.com (2603:10b6:930:d1::22)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 17:34:28 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::69) by CYXPR03CA0055.outlook.office365.com
 (2603:10b6:930:d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 17:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.21 via Frontend Transport; Wed, 21 Jun 2023 17:34:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 12:34:28 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:34:27 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 2/5] PCI: Create device tree node for selected devices
Date:   Wed, 21 Jun 2023 10:34:06 -0700
Message-ID: <1687368849-36722-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
References: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f22cd8-bb3c-45e9-49ac-08db727dc3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11x4a+eTKEcBUTirHTIPYn2f5JMxdM89dSp3pwxoctcFNeql1F5M8vwajpTZIZsAzZeqSyEGcGV5U3wgTRhAh27hYIwm15NGpczDapx1ajJjp8kabrrRYw+qOyigpzkDP8Z7CU6FyqccADfhQLHz0Wafefo+3I2yLBGFvVyn0aNrH9tf86eRkPKTWdkgv/6T6siWAFuUcCc++rdTRQp2PZS5dPEEdPIe4I+1KFzB+rpvQe95szxqH278xr0Pr5jVjN4OpBnVp++q+RMj8OLpx8+wypw1yAQl+QCvOsU2JNlzp6vDDimZWLg60Qhe0XdSACLfmikGmU1rQquoCICxnbwUFMUqhRLuvAjvLmYiCMeSmzx9s/QU/9H73+dcprBA+YaHNjOJXUiGsMFPOSHp5Le6bjX9IR5SIG02wKjqILa2hP955GwF0ANQ2lhgZiDVic1iDAvI+1Gxci/YYUevqn8zII5lOHLEA2EeBsYvvo/d1gTHONsghnf2W2iTFI9Wct/r8eu1QSEGRkll8Rgx/Yv2degRpMeQ8E2KryrLgqk26QAq8vEq3VDShzQEA9QPQTDhqdbSozUE21KQrL6fWiWXmbWBIbmrpN1hlg7Rx8ZM1Q2xoJup/RtDTl1YwA6moetIUUGTkv9ad3Nk1fdWmnFVVKturohC7zOmOBKvX7pqxcGe8yA5mrAaV4YUS8UWMUCMC+Cbz/V95txsY46S1Jyxd2RYPNKhQB9Gz+o20sw0preGpF8nXQ7+kBsZpPbrkq0niZrmBUx+VQi8DaIOsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(70206006)(4326008)(83380400001)(2616005)(356005)(81166007)(82310400005)(186003)(86362001)(36860700001)(82740400003)(47076005)(110136005)(26005)(426003)(336012)(478600001)(54906003)(36756003)(6666004)(40480700001)(2906002)(41300700001)(30864003)(8936002)(44832011)(5660300002)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:34:28.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f22cd8-bb3c-45e9-49ac-08db727dc3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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
---
 drivers/pci/Kconfig       |  12 +++
 drivers/pci/Makefile      |   1 +
 drivers/pci/bus.c         |   2 +
 drivers/pci/of.c          |  81 +++++++++++++++-
 drivers/pci/of_property.c | 194 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  19 ++++
 drivers/pci/remove.c      |   1 +
 7 files changed, 309 insertions(+), 1 deletion(-)
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
index 2c25f4fa0225..01818b27a8da 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -501,8 +501,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		 * to rely on this function (you ship a firmware that doesn't
 		 * create device nodes for all PCI devices).
 		 */
-		if (ppnode)
+		if (ppnode && of_property_present(ppnode, "interrupt-map"))
 			break;
+		else
+			ppnode = NULL;
 
 		/*
 		 * We can only get here if we hit a P2P bridge with no node;
@@ -617,6 +619,83 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
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
+	of_changeset_revert(np->data);
+	of_changeset_destroy(np->data);
+	of_node_put(np);
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
index 000000000000..a48d3a5a3685
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,194 @@
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
+static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
+			      struct device_node *np)
+{
+	struct of_pci_range *rp;
+	struct resource *res;
+	int i = 0, j, ret;
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
+	for (j = 0; j < num; j++) {
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
+	struct of_pci_addr_pair reg;
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
+	int ret = 0;
+
+	if (pci_is_bridge(pdev)) {
+		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
+						    "pci");
+	}
+
+	ret |= of_pci_prop_ranges(pdev, ocs, np);
+	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					 OF_PCI_ADDRESS_CELLS);
+	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					 OF_PCI_SIZE_CELLS);
+	ret |= of_pci_prop_reg(pdev, ocs, np);
+	ret |= of_pci_prop_compatible(pdev, ocs, np);
+
+	/*
+	 * The added properties will be released when the
+	 * changeset is destroyed.
+	 */
+	return ret;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..82cc2b35ff6d 100644
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

