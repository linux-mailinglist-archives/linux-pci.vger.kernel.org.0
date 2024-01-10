Return-Path: <linux-pci+bounces-1964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF2A8292A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 04:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B369C2894D5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6021B3FE4;
	Wed, 10 Jan 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDJPbSoV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE97484;
	Wed, 10 Jan 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV25UR8uYyH8MJhSFIG6tfsZBxh4yj3Jw3avR0RNBH3ounOIcMZcBRHF/8N2AOb3s9gVWxMx+1fdz23cEmKyS3Eou3VMMhkt29rDNwxBd+zr/IIuPjxqMshjKPv3UmOpxIJiS+duEylEoz2e1RJ9T2MXodE1CGmTHmUCJQ5WYnFL6qZzcW9COuEV16VxsEI0ZjaHReZwFwjXwrs1nNPoyeo6wULc3UFEZhFdJ2fsbwovak9ucqPf6w0PpHkY5rFc6nGqhg3P22kKMut/xL6XRyobev5QWLlxv+bz3EwoC80Dt48NrUrWu8udNStiDz2jUA3Tq2Sz2MmnxWZ3A91PHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws8eUAUXvLKzq5m+4Z1rBqx1wHa1LCUR+6dLSrIMg6I=;
 b=KoV6ZdjAYD0ZFUWMM1acw8IoR4wfxOsWrj2XnjUkKr9jyJ1b0ErzZPS/BTWiGnDFSx/4D/6u3X1KFePoBJ1srmlpAynGKjLHs2c3gagWX7ByZ7m6ieMRhR+iFYT+YfcbQpCtjopbHUy02KrW1msGtXvIg8jhIK5kIYVczzaNP25DgUX9lInxafMW/aiUsdApg3utXdcETXCzp2BUeQmP6CSheTrhFsP9OJBu3EJgivWrV69u6KOuXFLal6/S2HZ5PPuWwK0LzL2Ag+B3tLJeULY2ujVaQqG+Q6nGnmMts08HNpS9KcKJu1Qybfruq2/s/b/7AbI4NU+2LrzgEncfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws8eUAUXvLKzq5m+4Z1rBqx1wHa1LCUR+6dLSrIMg6I=;
 b=DDJPbSoVOrpRNAVREZ086WeDp1WMxXvC+0C0g+wzYTRyBbnORXZgGzwmoWaQcMZgq30P6yMphMjw9wjW5si1BlUP14myjkuyMdTA8029wgRIAtk57sqq0PreZ3Fj5DQmWfRGRn4pcb9ko30v3OCBG+o+8QbpqlLV4nsvaLOdgsNHDPnQ+06+31WbySdk2uy7G5DCYwV6RKMsKGCCo8zZVsKPesXSRIT1U4XuR+Y5PZ/c51K1+RSv9BNtOVeRBaCFSrU4jka+K9gjvMTaNe7hKuK715KcU7lydsxBxDkQQNKrAyC3xND6o14lZsGqDMASrtQR3jyHPnBkcijROvlxGg==
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 03:08:03 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::c) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 03:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 03:08:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 19:07:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 9 Jan 2024 19:07:46 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 19:07:41 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>, "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config" property
Date: Wed, 10 Jan 2024 08:37:25 +0530
Message-ID: <20240110030725.710547-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110030725.710547-1-vidyas@nvidia.com>
References: <20240110030725.710547-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0f881a-afac-48cb-888d-08dc11895c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1E1a+0fgxta8HwcKIG9QY46PMrMzrCKPt0gfK1vK9sAgtPwOE3htC9q/iy4CMFYzFDGxRydSp94li+zxZkK80mFUonEhFMEgQ3UBfeYI2t+wY9TxwXr4nT3LJqDOzVvj5PZAFw1ToqmZ+Mj+V4gH/bHhRFPPI0rf03aptd1nD1pJuEWs3RXEYravO8zOh17w65QsFxhtKXZz99ei1uoZXaJVwqCpoT/o4ljzKvnFq0D47lrSPjQs4Ki5L632ZvoGhwdm9w9ndQSLJq4H8keT1HBhvnE17Dfsm2LePz60K6/qOF6CzFjDSOukP47vPH48Rq2fn3RN0XxAhCMp0Vz6v54xGzlDeLXLTD2JWzkV3yEkLVjvLjreBXuyLz80GbRSykZz5qpyMWX9qWNBO+yvEtWHrWM9+8J6Zt44F8cClGguksePkU4WMric7FhWpbimEjZc4NVxTpMWX7ylV2nAIQnbppFNN1A32JvdjFu9aWwer9XLI9s5cID/rkDgdUB6lchgrc8oRQXS/RZj0PTHi1tZxJr5V1li2NEB4+//AQcHZRGE9eoypec/IXORCOdSf3ZLB7uQjrUagJ5/FPZ6a8/wKXmgTXLreI1lksiWz0ocm49cliFRVQp9bINeNqAkMH5CJysJHwphxcx9uztUgxcoXb84+JBuYBVXrU+0iAJvhwJ+nQ6+xLUzkTCkbro2NLReSnqDPF/TZfpZxwLsWyd18M94ydlcHD/r6ptzEBHjBxlVbf7Tp+JSwjWT1XSY
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(7416002)(5660300002)(41300700001)(83380400001)(40480700001)(40460700003)(336012)(426003)(1076003)(26005)(2616005)(36860700001)(47076005)(7696005)(6666004)(478600001)(86362001)(356005)(7636003)(4326008)(70206006)(8936002)(8676002)(54906003)(70586007)(82740400003)(36756003)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 03:08:03.0747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0f881a-afac-48cb-888d-08dc11895c0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

Add support for "preserve-boot-config" property that can be used to
selectively (i.e. per host bridge) instruct the kernel to preserve the
boot time configuration done by the platform firmware.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed issues reported by kernel test robot <lkp@intel.com>

 drivers/pci/controller/pci-host-common.c |  5 ++++-
 drivers/pci/of.c                         | 18 ++++++++++++++++++
 drivers/pci/probe.c                      |  2 +-
 include/linux/of_pci.h                   |  6 ++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

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
index 51e3dd0ea5ab..ed3c0dd9804e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -258,6 +258,24 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
+/**
+ * of_pci_check_preserve_boot_config - Return true if the boot configuration
+ *                                     needs to be preserved
+ * @node: Device tree node with the domain information.
+ *
+ * This function looks for a property called "preserve-boot-config" for a given
+ * PCIe controller's node and returns true if found. Having this property
+ * for a PCIe controller ensures that the kernel doesn't re-enumerate and
+ * reconfigure the BAR resources that are already done by the platform firmware.
+ *
+ * Return: true if the property exists false otherwise.
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
index 29658c0ee71f..ba5532005125 100644
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
+static inline bool of_pci_check_preserve_boot_config(struct device_node *node)
+{
+	return false;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.1


