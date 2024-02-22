Return-Path: <linux-pci+bounces-3868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCF85F86A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49E9B255E8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF212D779;
	Thu, 22 Feb 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1rGqdtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA63F9ED;
	Thu, 22 Feb 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605705; cv=fail; b=jCX0urtOIDaIbSifn/kO8p2daiWmGRfaPEGDqdHigThRkj2aE+vO3VKLRcEaWLK364KCkQKjq31/iTA74v7LhSPrtpCKKOwNJRvetwlhWJi3MPPbAIB+9i4OR9DgJKGqoy9G2VT6OL4xY+PsmFVXD0YINRiH2mqcoitNwhlsKCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605705; c=relaxed/simple;
	bh=/8iim6Odnq3bniuyxvsPqDgvjcGqDABgif97Nybskx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXfo0dx0iRSH5b8C2R6xc818sGT9bJzGpwWbbaZ+DYD2XNNvSgwfAAT2IZawzYWcnsYYqoiX9BPA8hnOqqgGLrkCjyLfe0bejK4ug/wI4KreUjxcOgWHGz/yIyKGU25YPwRzvVOvD5rDdGuR+LSOQ5BKz24fmcEra1wKeA9eeVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1rGqdtO; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Ey4PYF+O1xpMc33t5efCYAqB/cQYzJeFGU+NYbxCvM/G1S+ZOurr9bgJc6/ghLInXkBFXDqRmIHmKID3hFROmQTA+u419VR6w8V2lv4jMxFXd+FfkZQAR1XoFQkWKYtmWnEt5FiYDlEHTYRn3rgJsvR7OQLJPKkUK4ceaqVb7LjLLgXeYIv7/OTYiCYaZwETujkrHvYD2unOlnUwNLy0fiBfcUpw4+QRnTsNIEiygaFxVgjYHaqtBjwfignztlILZ1acIrJJzqGqP6g6McDPyEDIKdbAh6LtXEaQ0F7SDRGaV6PIVvsPqpq2aTlWPu1fUIMA2F0MZK7FW4o8e2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyh6oaCu+k3fo/EjEA/8BsFuywQUjll2qpTNlLMJvhE=;
 b=iRTfmd+qkuN8RxOh7/bT7OVVly16ILsswxskt6v+YgZ0wi00Cc6Lo4wiFuemmozaJRDKyJYP7jbcyA9oZWqGMRs7wKY/FTNKYRW64cXpD/LM5gINm4mHtRLOtDMSSmlvf2kKo8bsE/EWwB3Conl8QMYoNa1dUjlSDYK0/kI/88k0n3yyynV3o2NiuWP99Oe2sWmmZVYXH3C/O+vqfYOy9DpBzWRNj5BdCyiR/ratEYSvW50N//p26oGDQtRfsnsJdXQDqj5MPo8KUD3ZpkBz3DFSuy+GXZmkf09p5hcVPnOrIoeuEeWJU1Z/LEAu27VjuglLcHwsV14Hru7BPAHhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyh6oaCu+k3fo/EjEA/8BsFuywQUjll2qpTNlLMJvhE=;
 b=k1rGqdtO139urIsyTFvCKejm73NE98tMJsyM/+TlvCtSFGoyzhjrdjQY34ouf3iAcaPo5u1IP83Arggalizof1/1eNmGZjR1Yehw78ZwYRoH05EZoIksF1t2C+JDA5SJOrNYH0Gc3DQMJKc1BLCi53czXNPfRJduPNEFHI47l1VRR8hC9E8oa64SoKVdskiXXV0UkNLDd6HExYW9rtozYYKr7KBqky7G/7xhvExmvhvP3Wmv0ulmYBbxFwqinxVssxI0E61OsGBt8kgpv325/KNj/7SL3GMcTRVa7bqG+1TmkR20sszdaxY4Zf59Zrt6YqCfxEncVsx41grohUqibw==
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 12:41:40 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::be) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Thu, 22 Feb 2024 12:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 12:41:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 04:41:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 22 Feb
 2024 04:41:18 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 04:41:13 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V3] PCI: Add support for preserving boot configuration
Date: Thu, 22 Feb 2024 18:11:10 +0530
Message-ID: <20240222124110.2681455-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110030725.710547-3-vidyas@nvidia.com>
References: <20240110030725.710547-3-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e0c21f-e981-46b9-b2c1-08dc33a39e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CunnjSPOpz9Lx6vS6ASsf4GLvpIxfFci8Uc3EuB7qvoW9z+gbV37PHSVDaXKZm6Jtru9z0asF2QzJraJoFSGdqbRil6pgYzyHf+DHEq3ApJcvUfLhlMy+nwBOB9m7U9by/ns5J9SerJc9O3d7Gm+p91sqOqexCSEx0lAEYBkIS23GIAbHfpXXW38NvjtiR9MAFb3nT3XlDxSZ0zvBHtUXYU1/WMIPACGTLxWC7mF3g4SQsKloQKeJgvfWOBBBJ37r5R+chA8e4Wt/gofXmDY162KT6gHTeFIouLN+W5NCE0PVP8h2OhM9pTQGduJbopjgOk6HW/MiN5RzgnAzHh+1TS5z0feEQHs210DvuRorALnGt9hveK4sMSzoTje4C00aiGz9u4kqNge72Kn5bGGFLxjaSokHHtFjZTgEdenyI8VutRvKBTLnez+k61Dm9tfjcWliSOXJqjfBscyQQypXU6HqfbsBf0HZgziaeg4xKRPYC2OTyjBlezw+vymcAcRdilRNLNV30dK+UTiZTV3Z3G+DeYjNzDOkQLnHtHKMefV+uIl68+51oM14c2Y6undejO9wq4HGaeE92wCRgP8TSPd70oMEQzn1EGSYeOsJ1lTOH/kmxd+BpH+2OxYEFpqjoUrMJuvpBu25w3pqcBDHjmHd1xRV7B03VVUTgJfJQE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:41:40.1172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e0c21f-e981-46b9-b2c1-08dc33a39e14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

Add support for preserving the boot configuration done by the
platform firmware per host bridge basis, based on the presence of
'linux,pci-probe-only' property in the respective PCIe host bridge
device-tree node. It also unifies the ACPI and DT based boot flows
in this regard.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Unified ACPI and DT flows as part of addressing Bjorn's review comments

V2:
* Addressed issues reported by kernel test robot <lkp@intel.com>

 drivers/acpi/pci_root.c                  | 12 -------
 drivers/pci/controller/pci-host-common.c |  4 ---
 drivers/pci/of.c                         | 22 ++++++++++++
 drivers/pci/probe.c                      | 46 ++++++++++++++++++------
 include/linux/of_pci.h                   |  6 ++++
 5 files changed, 63 insertions(+), 27 deletions(-)

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
index 51e3dd0ea5ab..7b553dd83587 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -258,6 +258,28 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
+/**
+ * of_pci_bridge_check_probe_only - Return true if the boot configuration
+ *                                  needs to be preserved
+ * @node: Device tree node with the domain information.
+ *
+ * This function looks for "linux,pci-probe-only" property for a given
+ * PCIe controller's node and returns true if found. Having this property
+ * for a PCIe controller ensures that the kernel doesn't re-enumerate and
+ * reconfigure the BAR resources that are already done by the platform firmware.
+ * NOTE: The scope of "linux,pci-probe-only" defined within a PCIe bridge device
+ *       is limited to the hierarchy under that particular bridge device. whereas
+ *       the scope of "linux,pci-probe-only" defined within chosen node is
+ *       system wide.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+bool of_pci_bridge_check_probe_only(struct device_node *node)
+{
+	return of_property_read_bool(node, "linux,pci-probe-only");
+}
+EXPORT_SYMBOL_GPL(of_pci_bridge_check_probe_only);
+
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..d62d1f151ba9 100644
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
+	if (&host_bridge->dev) {
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
+			of_pci_bridge_check_probe_only(host_bridge->dev.parent->of_node);
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
index 29658c0ee71f..9e045de3be44 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
+bool of_pci_bridge_check_probe_only(struct device_node *node);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -26,6 +27,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline void of_pci_check_probe_only(void) { }
+
+static inline bool of_pci_bridge_check_probe_only(struct device_node *node)
+{
+	return false;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.1


