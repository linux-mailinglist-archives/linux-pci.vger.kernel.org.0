Return-Path: <linux-pci+bounces-3912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3A860BAC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 09:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E28284517
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01921642A;
	Fri, 23 Feb 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6+3MI2c"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F09455;
	Fri, 23 Feb 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675265; cv=fail; b=V9efAdqIvKcwM8369OI4FJYzxES2257HoGbFkAU7G1pp8uYx6xsQTcEFdWr48XrkmFgR/ILk6JiVkqE+6DPqMQg02ukkQD2lF2A47H7el2kBkMGOXpuFrxZ2oILyWSRxV38PxryIx4RdmYXg7GikSIXOXbH5tqWdseHDHFQdTMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675265; c=relaxed/simple;
	bh=i6wbDy7hv/RL0xCSQmB32T514/A9Ju1Y8CVq8IHZqg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNVtoJQxKHlRLaXpJKOCrBdrF+zgWYAI6fzBv48VCiIY8FpUB0UxsnkopyvHvdq71YGa4HIHzIgQc64UyOpAaZ1QKbLUo+dN8osak8qdCq1B3qI6LYB8h8oXWAL5h+ZebJW2EZajVZeYpIpFU6yGgEuogrTeV3QfstKgmRmhseg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6+3MI2c; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDwGQqGQbapY5ESxPMtYMv0B09abuvgseZmoMIZA+Aiaai/JfPUaTqoWMZ4SfOR16ii3/HGXPDES0V5z+BNhd5BeUd0XPXus/Tf5PP8sFlei9FqkAOpwRSz8k1MstfbDK/gzhT+7o6/5q5vwbdAPWnqngfYwXJLI6g+3m0ZdwEpx+u+dZ+3M53fM44FGmaGMmln8fk1E8KrDqc/ZTAuoz7lSrkzmv72ljXK/pUM7/e2ie78Lk4X8Yf4MjzY4bSUTscBPufIDzbXZbJMrYiVwSOoFJEy0CM7TcWxoDfH7UHJWDfDXgbozKwkjc/K26mn17hs0BXf5vGPhv6Z2oKjAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU8upKrV3q24FJE1fhuhGdFYswCFBHRRDgJEboD4/9E=;
 b=ATL+76O0wfnxiRvfm6A7lKUW61L+WGWnXRQbjriFg7gdkRyX4gKL+5e89IEnbBQ02BlmPs+YU53uZpuAhlnApUccB0fO134nj7Y0u4aJ5ZYhjY6XSFu89BIHP6PhKwQLKG7jv9+qg1LaaUVLzWOaz1UbEyT58hAf/dyQM0LmYKEh9FcAn6c4pxx/R67sWqs4l9ZtoWYNw89fM3ytM+a6X7lQnLBVs6fDoMdqMTsKj1AoE0icRm9WzLRMTfmSx4BNifX8f5yrM9rOyaUN37Gf+sO2dLmXTqjheKUtF+w9l1aLsMUURe7Zc7Aq3Ss2hDWd1ujwC9BrHvhzEHRJwCrybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU8upKrV3q24FJE1fhuhGdFYswCFBHRRDgJEboD4/9E=;
 b=t6+3MI2coVIFvmlqGN2frTyZGZ4NS2EOTTEfU1ql2C7ElDBAcxLzv4Ly+1kN3pdlJbYVoQ8+htkJNTObfHecz/gIohHThsFJrmOwx/tYv5cuYL5ptRzyd6S8v457itTRNh08WPqK0HZ5VHNPeBVdVPCmV1LlQ+fDbXyDkr2Pv5gamh2swXRKF2rsOTKMAh/rQnRSJNCARli797NweY2UDce61B077QVN0MuVPcB6cVY75NxaGUGjElNWKeY2+nida/rMOGP1puUGHOf0W2XVOc97mKmRJoSLTWBhxE7uHPKQoY5a3k9tShUwLI/tYEdZ7Js/yXzEMOBNQ7/o4XBW+Q==
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 08:01:00 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::7f) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.44 via Frontend
 Transport; Fri, 23 Feb 2024 08:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:00:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 00:00:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 00:00:28 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 00:00:24 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V4] PCI: Add support for preserving boot configuration
Date: Fri, 23 Feb 2024 13:30:21 +0530
Message-ID: <20240223080021.1692996-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222124110.2681455-1-vidyas@nvidia.com>
References: <20240222124110.2681455-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fc817f-d7f9-4873-a1c8-08dc34459286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2VAwk5qCHF4C145XPCkeCBSZ73Vk5CBbeD4PUh8RDt1gclNkEJAhbojVqONfGUBDOymPZnqhoALGlnQbE8P3I4SzbUjdF47dXoqCtZXIDIUwl2pimvbb2vIqCgL0pjO4JEIJHw4VaPBuroPOi5fdS8oEokvadMwX2WeuMF63WyMtzNyPeWGZgGlTSbT/6Yrfcrd2gqM4VdL5xHmKOgLgsCEwIO8FnanqJjTiomrGGcFCTnw1MuepxWuQns2B1M15Lp//fSW+T2Qyfqyrbkb74YQnF8gpg1XADNvkAh2LvtyGNmvc/TB4YR4m40rg2/SzfzlfOF/JU1geFtxQT/G0b1su0bYMfGJJQdsj7ZusezInrq7C7v6GwFHOUi8Lj2JdIUJeN3V3hrqy1M+w353LgHKSvCjVXXb3zrJnm4YfECtFBUOIN9LF35jZWdHmbY+qe0tzGmnXYmJIAa2VDAlSntnKeLgLDU7eJkiFxsJwUezekVYvghbxQAmkQMsPmEcTWMb/mtO3/urB++Ox3Rt1ZIEB27IQmn7sHgRY9gA31q5slLy8iuCwML+sBUNNLX5RR4dcocdiXinfVF4lyKk45VMZbYuzRQg/1nqhetZqv4jxmJXtJ5ve4GNK3kwxVCKsYoNBpjLbgXPHs3cv2NL1k/6Pfqp+YV7BCIIs9w2zYqo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:00:59.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fc817f-d7f9-4873-a1c8-08dc34459286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

Add support for preserving the boot configuration done by the
platform firmware per host bridge basis, based on the presence of
'linux,pci-probe-only' property in the respective PCI host bridge
device-tree node. It also unifies the ACPI and DT based boot flows
in this regard.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Addressed Bjorn's review comments

V3:
* Unified ACPI and DT flows as part of addressing Bjorn's review comments

V2:
* Addressed issues reported by kernel test robot <lkp@intel.com>

 drivers/acpi/pci_root.c                  | 12 -------
 drivers/pci/controller/pci-host-common.c |  4 ---
 drivers/pci/of.c                         | 21 +++++++++++
 drivers/pci/probe.c                      | 46 ++++++++++++++++++------
 include/linux/of_pci.h                   |  6 ++++
 5 files changed, 62 insertions(+), 27 deletions(-)

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
index 51e3dd0ea5ab..f0f1156040a5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -258,6 +258,27 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
+/**
+ * of_pci_bridge_preserve_resources - Return true if the boot configuration
+ *                                    needs to be preserved
+ * @node: Device tree node with the domain information.
+ *
+ * This function looks for "linux,pci-probe-only" property for a given
+ * PCI controller's node and returns true if found. Having this property
+ * for a PCI controller ensures that the kernel doesn't reconfigure the
+ * BARs and bridge windows that are already done by the platform firmware.
+ * NOTE: The scope of "linux,pci-probe-only" defined within a PCI bridge device
+ *       is limited to the hierarchy under that particular bridge device. whereas
+ *       the scope of "linux,pci-probe-only" defined within chosen node is
+ *       system wide.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+bool of_pci_bridge_preserve_resources(struct device_node *node)
+{
+	return of_property_read_bool(node, "linux,pci-probe-only");
+}
+
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..c57648084503 100644
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
+	if (pci_has_flag(PCI_PROBE_ONLY) || bridge->preserve_config)
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


