Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F915731E7C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjFOQwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbjFOQv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6802D6B;
        Thu, 15 Jun 2023 09:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHAEr3BgrOdrU4FYaUxFLXAaryFAqW+RqC3aaZGVRR0WB2HICtVkx7lqr/tVMQ2iEb+1S8h4HGS8FOFFwvcdsi33qYeht3TKah3kolMn29cScKIQDYyjRsskkOXHMeNwE2fiLNEfok4ixKYknuFJZZRf+czpBT1wM60VRVHFvBelIjPX/K9vnuCRh0ygvliW8djQ6SN9qEnP7zJcYtxbDMDfPiQjTIxfcgMW4YhWEW/uBlgdbCAkJUtqMzEa+++2qboy4lNTascMSckV2BII0VrFJiYY8ahKKsrGS4UgDto5dXX39fKkSvEcRipSGYO4OpyIUssAwfgpwKXvLpjv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9Ml6QllioUuSg0OlDBw+zw4sxqSM/3ZBX0guX5mnqE=;
 b=C/hNQMXSGlLCAuBlvn2f8Kp9qg/x7xnlTti7l5/20GnroEmi0R6TcuGmCBac8yOpaZ/zxNZ41m0YiYhhOjuHXMq0zqOsla8b2mTgE4/q8WZjUM41Z8dl98Tx01J5SXVQW3WZ24oE1NpahkPHiW+TPOyqPku4XOrydrnC9mPHL8VxwZStvsx+Qmh3prj8An2/exCSB6pViWTMzKeASVP1FM4ETiCiCqwmS8d/GFFiZzUP8hmFzs8KpD+OK2ub7KIXUmsCDooQtpmbtUiDx0vfsFm338EnvTUBa+iM77Z33SKWLObQ1ETWDnhe8yiijUKpV5iw8DuR0xoAFtTscmMRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Ml6QllioUuSg0OlDBw+zw4sxqSM/3ZBX0guX5mnqE=;
 b=ftZcMuaMceys1TujnUt73YXaSdecDAogZkxr+TE1rIs6d+Vyf+LA6uc9GcQlDgJOLGMIvzrqg5jNSio9lqh8UGprFe/b18adhY4VUGCEra9dTYnRVymC7uOIO2oGglyFSY5rR1PR+Bjm/LfTZzYrG2r6mvjcjOGTZOX9re7uujo=
Received: from SJ0PR05CA0159.namprd05.prod.outlook.com (2603:10b6:a03:339::14)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 16:51:16 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::11) by SJ0PR05CA0159.outlook.office365.com
 (2603:10b6:a03:339::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.9 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 09:51:14 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:14 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 2/6] PCI: Create device tree node for selected devices
Date:   Thu, 15 Jun 2023 09:50:38 -0700
Message-ID: <1686847842-33780-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf5bc2c-97f6-42d5-c14d-08db6dc0bbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPMo489tvJfeCrdNd54d10OuVo8xpZPFs4FF7j2J+3kcNFclu8bXgEeGkPqZ/M7/BJiqGoOcd4TefaKgB0sGtJc/KsW0UtvzYjvZFMVYGSDXaRJOwIG2eVWAeZr4nhHHnWpIPNkeFJA24sVhhgvPXqE75Hv7kNi3wGZzb2WuoPigel68Ybg361pllBkOOUO/6tPXkZJ0Kkcgz+TcXWcWMQLb1F5yCcg48afF45DaCzdImFikmF5CwIppQN9uuh1AyML3D/hW9N63rDj22/ixPn4Q1yzTyvIZmHpDEajIMTA8ZmPt9epssNOG84vRZf1JS2lVJ6G1we42ye/Jw/QcRBlnNKqHB6PwE5M6DKP6ib8oZuUqgz05lowlJSKp13TpRF+9fZ9YIqWtoYgg0LliQkE8pzzG1rWvOM3RQtCwNpZYUqGWX7b5vh7rYJ7GXRoagkSCpXw61dyP2rT/zHlSj3UBgKxl+eZAKQ2zPU3qWofLSnpkL+y0MznRe9hAGBlRVv0aTcq5pt2R3l40uSFzRS76sZQ0cSkFEu2Wzr+O2lCE953GlUcw4WD2AXtGGi2GoNRb1rLrVAauVWreheQlQ6iOECWBvvrtT5xbsjjAmUdGV9buyLwbPNSoCiZwP866KQGgubrhfXrd1MBn+6XIeLGT7jcoTrTvpdiZX6OwPwZRo8jlIoiiYKvcGHDfUIUMlkuyx2iVtOdCw6UYHdP+teOtTe41omiiRG6jlaPFpYBm+ArwiYe+cAlYVyiNBtah7goz5jC/7FgJx2ImKkKjXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(54906003)(110136005)(478600001)(8936002)(36756003)(5660300002)(6666004)(8676002)(4326008)(336012)(426003)(40460700003)(41300700001)(316002)(81166007)(82740400003)(356005)(86362001)(26005)(47076005)(44832011)(40480700001)(186003)(36860700001)(2906002)(30864003)(2616005)(83380400001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:15.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf5bc2c-97f6-42d5-c14d-08db6dc0bbd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/pci/of.c          |  81 ++++++++++++++++-
 drivers/pci/of_property.c | 179 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  19 ++++
 drivers/pci/remove.c      |   1 +
 7 files changed, 294 insertions(+), 1 deletion(-)
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
index 000000000000..bdd756c8d7de
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,179 @@
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
+		ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
+						 OF_PCI_ADDRESS_CELLS);
+		ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
+						 OF_PCI_SIZE_CELLS);
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

