Return-Path: <linux-pci+bounces-6452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539D8AA14B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC12B21D91
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6E175560;
	Thu, 18 Apr 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rPY1wW8h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CA1649D1;
	Thu, 18 Apr 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462089; cv=fail; b=gWh2Vg8tPPQtg9sKsTpt7r0XzgkZhGCP54zvZta1YjPDobCW4n0YLJbBqN/NRzdVMLdBeNM2kWYyTPFkkQsK+RuV13JeGBXkO22O5mWqU8zLFzILMSZSUHQ0YfTlONPkv2Zt1zIhe2SiFpVUFW/utAoh0NmP6MHhVkpd6LY4a0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462089; c=relaxed/simple;
	bh=iJ1EmQVvOIq/mD53630GTuVyWQYchcgYsYl4xPwnLjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atCbWwuRGITzdmQTFkjVgQDSZRlkOwCkDnefAM5ORbUxWAO3TlsPTHz2a0DVHqlppQ9eQDCR7cL0GLU7ccjIajSYhr4UiybrhpBNYj0lXqOkKKIPRdZZn2bJY2IjyHHo1EkRj8rj/Zwbb0dedBUFwg9kSFNKshCCSKylW4ACZTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rPY1wW8h; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlkGqc0ealK9Cy0AAdsCnPlciIOPeHoUVKuV0xfbgQikKZFiLIPiA3zgBYyGvwXS62FbKnONRKDOdo4tipiBahQ1OLMUSZAfiWP8IZSTXfgmjyS+rS1XF1KH31JKPFu6ep0Gsp1irRIBstDkhcjPVg4za7KljtQxQiPe2ywTpFj5vKvTkRC+cJ08JzZxb/Dxpfr7YEHwP9gF/30n07XJAh1k5REtVW1ItURaStTkPqvMTwXcpHqoS1vN2cT/cVANvH04aTpKBdSX+C2HH623w9tsDnHDy26GfeosOb4hy4hNYJEVUhpOx3Xbe895Lus2GbJcmNztbbYVMQ87F1QeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AynsCg8GMI/Qc1YwTGlrUd8DnCnrI7ujfRB4x0Y8s/Q=;
 b=YYbEgkbbxCfojiV0Ijy3BnAqrG0t4N4AMOwdJd58TN17yQDVTeC1OENHbDOMxtUNvlpxKNtF9vtqutBYWATgODfyuLfAykf55kctovmqJllBrFPhG5BcFQlhURhRfF49eTxoMZ40cgmqst4WCSOZiWjUBr8o/r6OT+b1uh2YgE89BBhKi9xfXFyUvLJ5m/sqAxH7H0k66jzeXNkar03qZDKPgUZzm+/ML8s7GzAQ90BJC2NXcbOv1z+BBJ70rjZ4nqBByHcLjKKmvv2Y1SHLVIPRn+Ymj7AUoYUwewiHlIdTnQNC8xzq+YQ1xRcuoQkV2RdTH3QSPnwPR80P6d8JUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AynsCg8GMI/Qc1YwTGlrUd8DnCnrI7ujfRB4x0Y8s/Q=;
 b=rPY1wW8h3Cv+2JPZWCWojtKyeUhCi1kwq1z2LYRv3LzUSqMCxmV79HNIl6ptZFhSQCOYZWB+DT9Cba6zQ39+GW9XllMoXc475LyjJ+hLk6JzHOLDsvmT9P9gw8RFaG9k5HYhTovlPA+8ARlaZ64LjZe7uZ2QEgyQs0Gn4/deR7vkLNscAlwzoEynF5YoO4M2e0XgJ9r8dxmOUXPm3ybVEAkn5a5I4ATautYRF+1ckvvxD7xqDjsv1q0uFV8T5/uPNH9NJFs9M1g2Awb9Z/sTGdn6qolSxtr7bXnG1tjbV9w6yuihVC35rmGy6kSjaJnacQFXdT8SMtZoQ8IbIvhP1Q==
Received: from BYAPR11CA0046.namprd11.prod.outlook.com (2603:10b6:a03:80::23)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 17:41:22 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::b8) by BYAPR11CA0046.outlook.office365.com
 (2603:10b6:a03:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 17:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 17:41:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 10:41:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 10:41:01 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 18 Apr 2024 10:40:56 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V6] PCI: Add support for preserving boot configuration
Date: Thu, 18 Apr 2024 23:10:43 +0530
Message-ID: <20240418174043.3750240-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401075031.3337211-1-vidyas@nvidia.com>
References: <20240401075031.3337211-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1f5f52-7d8d-468c-f9bc-08dc5fcec32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDpJI0ziY6d71lwoIG4IOYbglCgfU+J93CQCqs/sr6/jQuJyWD7Bp1GBrUabyj6q2ZcA8/P5YGzHX6hX2/gW93BnSPftDHDLLd/jxoNIpLtMHNv/pI9oPyUlyw7ITTKrUx9y5cIb6yV3D6uirOBoqKeA02gx/7CSPAEWoYNRj8vPphZbDEQicTP4xY7pmdilZ4XzpRo+Ycnd9an6aNncMAs8TDCzPXX2/u4pLdQ9yHKFQ55b0Y+yVymBVXs+0aZI+mFSayZ95VQTwQEAIuSJtvT/F4ixeYlOiruD8oaW3OQzbxzOorZK2lydoIOG+82n0bEG4cB1l1lARts2hhw+b2qESuC2ahCPnWpsKkn0Fd5NXsKsjfpQsleXjym7+EIvr3/pVcyhUpa6KHGekgGveshCd/DKYBtKu10XQrLSKpaVymI2pvi4DZNrNtsJxeiGAQWPiPF6KEnS5+cEZsavs6EIT5ELbx9PR0eeunT78ehe9ciQoKQlXUQ/n4jUYP1WXnHUU2HWmBhiHCs9IvjzWqhPh7urLYYTf6tlXVpymEihxXAJq3NiHVF0SeodftCdB722EV8kQalR4Y4VeEuKU8im6t2UgNGXkez95dfoaO4rvEGkLjVz4b1yFIpOYLxSBD8Ey4G1MHQA2Tww+fyuZKiswrOfT64cyZS6QHFiqFmFLhsXVfmkBe3OIR0FrBJEEdZ3uu5XMfiWUOt4W65J10BPK1tFN4bvuialJbvAW2nUGpJvQzGZ2AMnwdXUDozF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:41:22.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1f5f52-7d8d-468c-f9bc-08dc5fcec32e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

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

 drivers/acpi/pci_root.c                  | 12 ------
 drivers/pci/controller/pci-host-common.c |  4 --
 drivers/pci/of.c                         | 54 +++++++++++++++++++-----
 drivers/pci/pci.h                        |  7 +++
 drivers/pci/probe.c                      | 48 ++++++++++++++++-----
 5 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..ddc2b3e89111 100644
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
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
-	if (obj && obj->integer.value == 0)
-		host_bridge->preserve_config = 1;
-	ACPI_FREE(obj);
-
 	acpi_dev_power_up_children_with_adr(device);
 
 	pci_scan_child_bus(bus);
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 45b71806182d..c96b2de163b5 100644
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
index 51e3dd0ea5ab..aeacff742706 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -234,27 +234,61 @@ int of_get_pci_domain_nr(struct device_node *node)
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
 /**
- * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
- *                           is present and valid
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
  */
-void of_pci_check_probe_only(void)
+bool of_pci_bridge_preserve_resources(struct device_node *node)
 {
-	u32 val;
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
+			pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n",
+				node);
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
+		return true;
+	else
+		return false;
+}
+
+/**
+ * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
+ *                           is present and valid
+ */
+void of_pci_check_probe_only(void)
+{
+	if (of_pci_bridge_preserve_resources(of_chosen))
 		pci_add_flags(PCI_PROBE_ONLY);
 	else
 		pci_clear_flags(PCI_PROBE_ONLY);
-
-	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..1da54ab18534 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -650,6 +650,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
+bool of_pci_bridge_preserve_resources(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -688,6 +689,12 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
+static inline bool
+of_pci_bridge_preserve_resources(struct device_node *node)
+{
+	return false;
+}
+
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..ceb9129823ee 100644
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
@@ -889,6 +890,30 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+static bool pci_must_preserve_config(struct pci_host_bridge *host_bridge)
+{
+	if (ACPI_HANDLE(&host_bridge->dev)) {
+		union acpi_object *obj;
+
+		/*
+		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+		 * exists and returns 0, we must preserve any PCI resource
+		 * assignments made by firmware for this host bridge.
+		 */
+		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid,
+					      1, DSM_PCI_PRESERVE_BOOT_CONFIG, NULL,
+					      ACPI_TYPE_INTEGER);
+		if (obj && obj->integer.value == 0)
+			return true;
+		ACPI_FREE(obj);
+	}
+
+	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
+		return of_pci_bridge_preserve_resources(host_bridge->dev.parent->of_node);
+
+	return false;
+}
+
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
@@ -983,6 +1008,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Check if the boot configuration by FW needs to be preserved */
+	bridge->preserve_config = pci_must_preserve_config(bridge);
+
 	/* Coalesce contiguous windows */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		if (list_is_last(&window->node, &resources))
@@ -3074,20 +3102,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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
-- 
2.25.1


