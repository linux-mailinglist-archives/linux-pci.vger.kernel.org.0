Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3F742B43
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjF2Rbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:35 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:45953
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229873AbjF2Rbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc94RFQLM1LL1e3Sf9mY/u4RrleI1SGh50HQussoskY1HQToYIKMkm+GfeyH0RYAdMDZmGBmXnFy0s42SvCW7kWhZY+PFDzYufhz1Wt16aAUsjRfdODyrE5ti4v6I9ISJO2SohDhKBj/ZZd+CaQeHwtoFGD1NKCooyEcF6szyeml+L4aaQaPFrdEb+AeMXJyNzUu7rHYlHgud0FU5qKmPBHMLZGKNLdF9QbaDEELV9EQ/I2WFA7pNmOl5NQx+V0j2MPjzb4JUz8t81t7SMXi2iw4XH+69RFgX9Ts5Q/Npzbi6970C+JYKHR7EUkazCj1NwAXlrRR21MMevzqCv7b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT1uNLWJ3yvts8S0GG3k3zEXGxHXnUF2KyS64kd+gko=;
 b=nz/qy1FdFePXq0n+a1wKWmTJ+uwmEmhWLp+S+iQsT8wmGv0PxCF1NhIJXOgpHgB+d9XWQ0hQS1lDrTUF1KWGefICahYfpkc2u8OWTvftknMfHl46VySMm5KH3KbtCgaLiy+Xlh6PBC9+iWnUCmK4AGnNufWY2tKtSXvcUVEwdpUC+krkteZs1li8FvrHjTMkgqoKqYuQIuq6ZsELw6D3Us/vqt4kfBDGyAvNtEbld7q+7pKBAaZ306UhM3OdW1BZTcAf1bUPAVGqLepTqxGOGoSBgVqP5JaGqyTBRntcJsz4NIbetXKlJ5aT5S0SJJ4hLJFmTC3IEbTG5LQd3DYTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT1uNLWJ3yvts8S0GG3k3zEXGxHXnUF2KyS64kd+gko=;
 b=e+vtumF4+4t2kZsAVltYAI8dliq2DCSEdiD7/7gy24+n6UObEPDO8yuCgQE0JrY8AHL9iPxnuo5IGVsfHVENNBySC1SIlyzd8K5BlRn+eLtGwLXhgFSY/ehj1lGZdbYPPNsENyFT7u/TBvUHRdWiG4VXC5ZU+RptCtrrx89yAAk=
Received: from BN9PR03CA0233.namprd03.prod.outlook.com (2603:10b6:408:f8::28)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 17:31:31 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::91) by BN9PR03CA0233.outlook.office365.com
 (2603:10b6:408:f8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 17:31:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:30 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:30 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V10 2/5] PCI: Create device tree node for bridge
Date:   Thu, 29 Jun 2023 10:19:47 -0700
Message-ID: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
References: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8172302e-a68c-416a-e5b0-08db78c6ada5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94+xg5/GolJ/jBZxFzSQcD85NesWzrP09TC2OynhrGD2wO5vRgXmIQzJziMOI86EApqZSTHuE6AOz3iNh4C71/dhCombWWYit4TGg+h6/NaGz94aeRasOrboaAiGTmMyTcJs8QYOVXP7NnGbdxzmrlacdVoBtlAaBKjiSh7CAt6D2RFdwFH5lh4uCM8Zd3l7FcD899rya6V/IZZQSgca6psdcipmL8p2NiluFDy5TpaC7Y7qhbtOF4Bbdlze8Q+O3fuD8BGxniP5jmUBUK7oln3vGuLtN7CEO9bVSpNbpGqksiR9SzD5uxNFYBCK0QgvgfuIi07wsb98Mp42rWUFeji42yfK16HIkNVUPcp7FfJ4NXKQiZaCMKoWld6l+L6cKT2G0zvRHEoMT1C19HfLy3/XzDaJt2plzjC6eNQJmka8Skm/Av5CVkGH1L6Zpf0j+D1Jj+PMPjGffezQnRgEXuVsnfcFF1Jz/tYKpPbP9WlgEZsxPYCPWs9YoP1zeueTwXOxzZGdCWLJRnbUDaaLgnnZh/JzMYkbsTAsfUAjAC2XsN1q2s2p6rnGIYz62XZJHkGFG4s7CC8fXeuFq7Io7Pgh9XfqlwIM+IQih85sfKJXKylZ6rc9zc9A4sEK6W1ok+vMlQubzE9o4RxLegvb5wc1SyNI1z97T00H30H1IaiQkltYiimxJShKvUthIVCIfHwdqO5+zG36YdhjcoI+FQxV0GPtApFNcvvc5uCjWNtnWK/Pfc1zzD/Bsjidaq01Len6O1V8dq36w9WI6+4E/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(40480700001)(40460700003)(426003)(336012)(47076005)(83380400001)(2906002)(186003)(30864003)(2616005)(316002)(36860700001)(70586007)(54906003)(4326008)(6666004)(110136005)(478600001)(26005)(44832011)(5660300002)(8936002)(8676002)(41300700001)(356005)(81166007)(82740400003)(82310400005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:31.4932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172302e-a68c-416a-e5b0-08db78c6ada5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/Kconfig       |  12 ++
 drivers/pci/Makefile      |   1 +
 drivers/pci/bus.c         |   2 +
 drivers/pci/of.c          |  88 ++++++++++++++
 drivers/pci/of_property.c | 235 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  15 +++
 drivers/pci/remove.c      |   1 +
 7 files changed, 354 insertions(+)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9309f2469b41..7264a5cee6bf 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -193,6 +193,18 @@ config PCI_HYPERV
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
index 2c25f4fa0225..9786ae407948 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -487,6 +487,15 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		} else {
 			/* We found a P2P bridge, check if it has a node */
 			ppnode = pci_device_to_OF_node(ppdev);
+#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
+			/*
+			 * Interrupt mapping is not supported for dynamic
+			 * generated bridge node. Thus, set ppnode to NULL
+			 * to do standard swizzling.
+			 */
+			if (of_property_present(ppnode, "dynamic"))
+				ppnode = NULL;
+#endif
 		}
 
 		/*
@@ -617,6 +626,85 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
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
index 000000000000..1432f9eed3af
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,235 @@
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
+	u32 flags, num;
+	int i, j, ret;
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
+	ret = of_changeset_add_empty_prop(ocs, np, "dynamic");
+	if (ret)
+		return ret;
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
index 2475098f6518..686836afee1c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -678,6 +678,21 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
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
+of_pci_make_dev_node(struct pci_dev *pdev) { }
+
+static inline void
+of_pci_remove_node(struct pci_dev *pdev) { }
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

