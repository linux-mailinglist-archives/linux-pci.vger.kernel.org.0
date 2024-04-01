Return-Path: <linux-pci+bounces-5471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECE8938BB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C54C281BBB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C4BE5A;
	Mon,  1 Apr 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgJuT+u/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B48F6E;
	Mon,  1 Apr 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957859; cv=fail; b=YfVBQbDGx7p8WokxyhQY+J31T7Ufb9hTXv2faxqRKbWX6fpLBL4d34VBbwOwby9PSXu1X96wV/w4vhWpLUDjkC+bcvNtQpM2xhhMbSN/GFTAzwuOVnteXqTvY3BE5jVBj7yGJHkxHIlWbm0gKmNIWDfm3DKRhFqXtPMSsY2S8eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957859; c=relaxed/simple;
	bh=jgFHj3qiSLFcJFxXdC3zxhNuQ80k/X+BgFFqRAieLdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBbtcqw+ZM92lwPeY36aficv40Goj2gV7gvQ8tDac41QfFf/Kqjx6LU0z1NhOq805K0VpIWAx5bAUP/JxQQVIRIy58POwQwSWmVlgDcNs5NA6a7AnniAL0lvOyNOllhX4ACtxvmPjgZ+k1K4V8l3LW2MPsTjF/uAeJFZSCXOngk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgJuT+u/; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHQ+5lMxMWTV41zussCkH556YMiG3tr7phAjX8yH0jaVRrg7EX/DYs+c8VuiknlY8rm8eXnrMr5rLXT7P2WKeL/pVOSNaWzx4CCccoBQu07f3DYIFgGxguQWKZ4FM4TXNdCBUpkMcz3/any1Vc1ehP9IvThN4BIgcyHtge1jqJCUSkdT1cDVDpj7QBFNmi4d3Qf6oY/HH6BKattoxiI1WWgSTHEA1Crk3wh3a7BD+AgjM0lJog2LVEPRdrH7AE+DtSu601CSsr6D4LyYofReO7JhXe7UfVmV/07NPeUOSD01HBZdZThbVAXoq9pfy3a1HrOJ2tToAaQ+fZAUi4ZF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9V0GBqhHQjFSFE9w39pM+ud3CIjfsI7vAyicIAi6Fs=;
 b=k325FBmU+pAwI3eGxIUTHd2cZprse70SN3BzKEFna2d2OPykj34mlyCOCwa/V6sgmlh2pZq7mmcMZmI591HY1eLEJM17u87WwT/JhIEAj3I3I8/CAnVK2VFNzMV+viYVN1jhnAt4qY4mqYKPiCuij21HhgBLai0xmo3OZPgG7pNIcZAD/sqXxOxozc/MUzHdhEeqNrMezk3fXKQjFGDe3L1EGc4WJI5bdMMhDmpLvxJNHIIm4MtJ87WCmNplCLNqOnMOwi5GeCZL0QT7pRzNGKo8rjbPUcPUaIqtyjKiMTltiVjMBVdwKCBfWoh9PkfLuI9s6BsAR6O/L1CkD4splw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9V0GBqhHQjFSFE9w39pM+ud3CIjfsI7vAyicIAi6Fs=;
 b=AgJuT+u/6Bco82O1VpPBHcPKR9C5N7O3FPgBxQGp85E0kwFE2+5BjK1sMoNZ0+DsGGxadRA30hDaSmL019HLiUeRkPNa3Ul74uI+E0zi1jkuIfJFFl56bQuQ4rQ2AuZyvvQvP5LyA7fGkHsGNcllf+hPuZiqRpzs6LboFTKMTOSWoyeGCAZrxisshErDSC/9aF0c0bAzcjcflzibJF62h/4O0gqa+U1o3lfhxM1GLxt8s/byg5yzSWYejxmL1dgaNcxfP6dbRMfJxK05c+eoo2U0zOx9X220fvwnbQFDjYDThrNCnpaaBTYIxBUMvuquLwUwpI2y1tvnqSJFyenQug==
Received: from BN9PR03CA0250.namprd03.prod.outlook.com (2603:10b6:408:ff::15)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:50:52 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::ee) by BN9PR03CA0250.outlook.office365.com
 (2603:10b6:408:ff::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 07:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 07:50:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 00:50:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 00:50:39 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 1 Apr 2024 00:50:33 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V5] PCI: Add support for preserving boot configuration
Date: Mon, 1 Apr 2024 13:20:31 +0530
Message-ID: <20240401075031.3337211-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223080021.1692996-1-vidyas@nvidia.com>
References: <20240223080021.1692996-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a448785-3522-44c9-105c-08dc5220747c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RJ7o/2DrPXRqKjks9ImCk7tUIVWQNKgs53qS3HDmiilkP1G4iu3Uuy15sLW/fLFdQIMUsmQk/4j0yv9TpJ69Xa74xWu34SsHKwf4nUwDBH66HVQ2+d9pj/rWP/nJ+8f7ujtr2UCebP8XJ1WntT1/iJLpBTPIyGxLXKczLZRV02Dyf5wLghGTzEw/VX0RwI0llivdKZWCXAkTUD8huqxtnjZlSjH+O1srJMaRHaBd2ov2HsiLU8Ri7ziLGqotHVYzEjvxfmfuK7gNhmOaVSoUK8b2xieRPGeJkW+xl+1Yw1k2asnPvk8dYSYGWkZ5S5P282Z7xfk+u3L265OF5IabQqW0ABzOd1hhxkpRDNasFpbepC74a3WYjTBAnG53Bj6NDjMJpCepcgUroaHaaP4RFBi2XCJTeEOLqmh/8lsOYMXclGejNtGzI8+rY2rCpbtFEvK4SgCXA+FnTEM1V20eNJzQqnM2cvj08lsU6GhngzI5ASwHt/gfY1wcq0XPnzAM2tsau5ESa1WNmlU+VIzhqRConYz4/rtUqwGaXa2YfsoIlY8duVVkXiFI9dfsTil3nj11NfuIrUdKpHUvF07I6sYkUZWfBJqkAmB1koqjV3s7+cH8P6y+/ZmfIS3YQs72iZE8OnvCyppTGQCJE4v01ArFhheA7tFs6N/ET2wvO+WhaD7vPD+rPmif7cAFNOvVCJrlVQejBRuvOKAGtr0NUhkcd5eRgma6YpcGuZjecHynjQQ9meEydeO2VnOKgC7E
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 07:50:52.4455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a448785-3522-44c9-105c-08dc5220747c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

Add support for preserving the boot configuration done by the
platform firmware per host bridge basis, based on the presence of
'linux,pci-probe-only' property in the respective PCI host bridge
device-tree node. It also unifies the ACPI and DT based boot flows
in this regard.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V5:
* Addressed Rob's review comments

V4:
* Addressed Bjorn's review comments

V3:
* Unified ACPI and DT flows as part of addressing Bjorn's review comments

V2:
* Addressed issues reported by kernel test robot <lkp@intel.com>

 drivers/acpi/pci_root.c                  | 12 -----
 drivers/pci/controller/pci-host-common.c |  4 --
 drivers/pci/of.c                         | 57 +++++++++++++++++++-----
 drivers/pci/probe.c                      | 46 ++++++++++++++-----
 include/linux/of_pci.h                   |  6 +++
 5 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 84030804a763..ddc2b3e89111 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1008,7 +1008,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int node = acpi_get_node(device->handle);
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
-	union acpi_object *obj;
 
 	info->root = root;
 	info->bridge = device;
@@ -1050,17 +1049,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
 		host_bridge->native_cxl_error = 0;
 
-	/*
-	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-	 * exists and returns 0, we must preserve any PCI resource
-	 * assignments made by firmware for this host bridge.
-	 */
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-				DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
-	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
-		host_bridge->preserve_config = 1;
-	ACPI_FREE(obj);
-
 	acpi_dev_power_up_children_with_adr(device);
 
 	pci_scan_child_bus(bus);
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6be3266cd7b5..e2602e38ae45 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..e6da3654f9ac 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -239,24 +239,61 @@ EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
  */
 void of_pci_check_probe_only(void)
 {
-	u32 val;
+	bool is_preserve_config = of_pci_bridge_preserve_resources(of_chosen);
+
+	if (is_preserve_config)
+		pci_add_flags(PCI_PROBE_ONLY);
+	else
+		pci_clear_flags(PCI_PROBE_ONLY);
+
+	pr_info("PROBE_ONLY %s\n", is_preserve_config ? "enabled" : "disabled");
+}
+EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
+
+/**
+ * of_pci_bridge_preserve_resources - Return true if the boot configuration
+ *                                    needs to be preserved
+ * @node: Device tree node.
+ *
+ * This function looks for "linux,pci-probe-only" property for a given
+ * PCI controller's node and returns true if found. It will also look in the
+ * chosen node if the property is not found in the given controller's node.
+ * Having this property ensures that the kernel doesn't reconfigure the
+ * BARs and bridge windows that are already done by the platform firmware.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+bool of_pci_bridge_preserve_resources(struct device_node *node)
+{
+	u32 val = 0;
 	int ret;
 
-	ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
+	if (!node) {
+		pr_warn("device node is NULL, trying with of_chosen\n");
+		node = of_chosen;
+	}
+
+retry:
+	ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
 	if (ret) {
-		if (ret == -ENODATA || ret == -EOVERFLOW)
-			pr_warn("linux,pci-probe-only without valid value, ignoring\n");
-		return;
+		if (ret == -ENODATA || ret == -EOVERFLOW) {
+			pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n", node);
+			return false;
+		}
+		if (ret == -EINVAL) {
+			if (node == of_chosen)
+				return false;
+
+			node = of_chosen;
+			goto retry;
+		}
 	}
 
 	if (val)
-		pci_add_flags(PCI_PROBE_ONLY);
+		return true;
 	else
-		pci_clear_flags(PCI_PROBE_ONLY);
-
-	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
+		return false;
 }
-EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..b0e0226a8da8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,7 @@
 #include <linux/cpumask.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/pci-acpi.h>
 #include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
@@ -877,6 +878,28 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+static void pci_check_config_preserve(struct pci_host_bridge *host_bridge)
+{
+	if (ACPI_HANDLE(&host_bridge->dev)) {
+		union acpi_object *obj;
+
+		/*
+		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+		 * exists and returns 0, we must preserve any PCI resource
+		 * assignments made by firmware for this host bridge.
+		 */
+		obj = acpi_evaluate_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
+					DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
+		if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
+			host_bridge->preserve_config = 1;
+		ACPI_FREE(obj);
+	}
+
+	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
+		host_bridge->preserve_config =
+			of_pci_bridge_preserve_resources(host_bridge->dev.parent->of_node);
+}
+
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
@@ -971,6 +994,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Check if the boot configuration by FW needs to be preserved */
+	pci_check_config_preserve(bridge);
+
 	/* Coalesce contiguous windows */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		if (list_is_last(&window->node, &resources))
@@ -3080,20 +3106,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..3f3909a5d55d 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
+bool of_pci_bridge_preserve_resources(struct device_node *node);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -26,6 +27,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline void of_pci_check_probe_only(void) { }
+
+static inline bool of_pci_bridge_preserve_resources(struct device_node *node)
+{
+	return false;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.1


