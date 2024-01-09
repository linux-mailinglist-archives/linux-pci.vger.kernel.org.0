Return-Path: <linux-pci+bounces-1871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5379A827E11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 06:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D951F245E2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3F63B;
	Tue,  9 Jan 2024 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEsYCVSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3948947A;
	Tue,  9 Jan 2024 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRCFEvHvQdk+R+XNF1wmmq4TI5Wc952FvV9paveWbQf6baHMac0LIqfGSt7OyaErN1BF0R68b9NkM27kzZsWfMlOwnxJtHJT1in0lhdinm55qDWlw+T84stDb/vk3Y9UsFDmnBi3BJRj9pGDLmnwOyYZC5WIahOBwzn+Xhuc3NMp1BEgwV0FxiLlwv1RIvGfNiS5DXp5a8nPHQpVOmAmtgWLsVgIA9FGCb3TAMB7gVcBBZ7wPM/8alQDV3DjC5riS/xjU5vAMhYWfjFRhkBW8GUg3LJWm9gCWT/7pN7YPbMrjwsxQmJq3HwaM0yH5Sf+blHpoGYav966ItDyR/0/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IpyctZh/IFGJOzw+MMxJer9JbYzhMAU0rI2sPgS6Zk=;
 b=gooRzIZ4XmSsOVbrq5v8Eio9xYZgZ60+CySTZQjMXThRPFjq0em3XphZvj2PlQuC2+RN1DfOdFVcmjVSGmI7A4xY2f6l883UHOC9p1Fihp/2jtSfCh7vsPQ+xplwf7BFeGrcuEGJ+xs8ZBXWLGco00hOf6dQc1i9mFVD9gMY488h5Aj9errDTmBTDNqSOqH8GsU66Rc+8aZHtvzxArU/XXw3p2C2pJVKoVz4JGLaN0t+iv5BEIjK4ZkQFaVxFTdb1VV9/OvCWnUb04FJJEy8iv2p9wZjyTchvv2hdrYpSClMJJ5/YfjYg1iBolOURpAHtJNRoR+dE/+Tdj4jcUz8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IpyctZh/IFGJOzw+MMxJer9JbYzhMAU0rI2sPgS6Zk=;
 b=mEsYCVSVZWD3C/Bt9H6Pa+zrusXagHU0+Hye76IYQ5PiU2QFk+9pN1xO/rgbvjlQz5T9q2qrH1D8W/ow2gn6NUJHuIl7NgGb+jmyOiq7LV+18JSf1Ptwu3XR7cXl3YRGW0zhmj/Uv2O06h68uLJ/BhLPCZdXtYv9ihE2M+MgL1BmvfdtRBftYdXI3qChCkE9S1dZpz16uIwoMZh0sj6l0GCJMK1ANMBun04Eyt6dkDvU+drq1L13MRht2WvAAlwTtgV/qo2wk5kNZ0ddCKhWzlv3rm82rccn6PXmNvQH8OltIKOuZ5S0Ps9xS4j4epA4okjPCgsFNnnMBmtUlyDCww==
Received: from PR3P193CA0039.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::14)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 05:07:30 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10a6:102:51:cafe::80) by PR3P193CA0039.outlook.office365.com
 (2603:10a6:102:51::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 05:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 05:07:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 21:07:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 8 Jan 2024 21:07:11 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 21:07:07 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 2/2] PCI: Add support for "preserve-boot-config" property
Date: Tue, 9 Jan 2024 10:36:48 +0530
Message-ID: <20240109050648.1347255-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109050648.1347255-1-vidyas@nvidia.com>
References: <20240109050648.1347255-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a09ee4-ce29-40cd-399e-08dc10d0e0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SfkIGJepp2rt/EyQXLqWe2QOILWXuo1wr8Hg5s/omyYlGBxjAzsoaDWon2x8Uz/M/lC2OdRW8O0edg1ZpK4euhUIHpu5NIjuIcipgXEUGkMABhLL51U4I4CdaLu7fE41yflpVkXBmEK0vQjpIaEhty2pX6zL8XgWt3/6ngZ6HkjQKJciH5/1dwQ+KYt8PAhrt7/Id/+Q4cqHyVFUJeMnNpRPufOFtWDd+dx/cYrdj3BsMK2u2gBn5b/SHc3/FD6Sm+mf42ko+VWyTt3Hd/SHdocH6tcprbA5q5bvyKkzVcTeXvTeHw36D8lsUkB54rDQ4hZEEj7k5JvQ1e5QUTMOlSfIj0gd0jD1aCxC02cWxrb8p1X8mL+6qoDXyYU7HcdzWJMNKrDGpCUv9HgN1O5WeVbUHoNQDxlYjLt85Sp0qpMmc5/J77nVurdjN8VdphRJTxPLkTnVqqE65wHxtg/R71anWBV5myO83mLRJJErgn77R1njOo7a3Rjs/ZKY/vLfj3XkwmuS7zwks5/+SVj0jBtkPDSMPqU3jF6eoQ/Zniu3bIz5Ee0wh6Jhw7ItrHtBCX2QCoE/zXGUWftrfdVjT2uFK3biNE1BhowQQsOpc//LbIjbTfsTJx52YcpRUbywiEABaw+cK4wdGYiwsO16k0FjRu9REZ3h5iLckh6VvSSVxKm3fDf8UnnIPTcDnjFo5RfnaEuYHQBu8EyQEbgl1NGehTvaQh4/PIQDWUHDHXrygMzAq29ITWTn9bF746Ji
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(26005)(2616005)(6666004)(1076003)(336012)(426003)(7696005)(478600001)(47076005)(83380400001)(316002)(2906002)(5660300002)(41300700001)(7416002)(54906003)(70586007)(70206006)(8676002)(110136005)(4326008)(8936002)(356005)(82740400003)(36860700001)(36756003)(86362001)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 05:07:28.9698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a09ee4-ce29-40cd-399e-08dc10d0e0d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

Add support for "preserve-boot-config" property that can be used to
selectively (i.e. per host bridge) instruct the kernel to preserve the
boot time configuration done by the platform firmware.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/pci-host-common.c |  5 ++++-
 drivers/pci/of.c                         | 15 +++++++++++++++
 drivers/pci/probe.c                      |  2 +-
 include/linux/of_pci.h                   |  6 ++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6be3266cd7b5..d3475dc9ec44 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -68,13 +68,16 @@ int pci_host_common_probe(struct platform_device *pdev)
 
 	of_pci_check_probe_only();
 
+	bridge->preserve_config =
+		of_pci_check_preserve_boot_config(dev->of_node);
+
 	/* Parse and map our Configuration Space windows */
 	cfg = gen_pci_init(dev, bridge, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
 	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
+	if (!(pci_has_flag(PCI_PROBE_ONLY) || bridge->preserve_config))
 		pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
 	bridge->sysdata = cfg;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..3216d4557212 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -258,6 +258,21 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
+/**
+ * of_pci_check_preserve_boot_config - Return true if the boot configuration
+ *                                     needs to be preserved
+ *
+ * This function looks for a property called "preserve-boot-config" for a given
+ * PCIe controller's node and returns true if found. Having this property
+ * for a PCIe controller ensures that the kernel doesn't re-enumerate and
+ * reconfigure the BAR resources that are already done by the platform firmware.
+ */
+bool of_pci_check_preserve_boot_config(struct device_node *node)
+{
+	return of_property_read_bool(node, "preserve-boot-config");
+}
+EXPORT_SYMBOL_GPL(of_pci_check_preserve_boot_config);
+
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..79d0ac34f567 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3085,7 +3085,7 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	 * ioport_resource trees in either pci_bus_claim_resources()
 	 * or pci_bus_assign_resources().
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
+	if (pci_has_flag(PCI_PROBE_ONLY) || bridge->preserve_config) {
 		pci_bus_claim_resources(bus);
 	} else {
 		pci_bus_size_bridges(bus);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..a408e54128c6 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
+bool of_pci_check_preserve_boot_config(struct device_node *node);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -26,6 +27,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline void of_pci_check_probe_only(void) { }
+
+static bool of_pci_check_preserve_boot_config(struct device_node *node)
+{
+	return false;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.1


