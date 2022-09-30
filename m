Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862F5F1273
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiI3T2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiI3T2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:28:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D097D8E20;
        Fri, 30 Sep 2022 12:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrmwAME1rVcWGfn46boTY3UBMQmUOh/2QX7u/ALXFJByi58g6yQpu1Stns4zMlj8MO01gT4uYAgIp3u64LklWpCw3Xz21sHeRvIe3VFYf/BLIrEJmE/7j062immJ78qlgGbgVDarI/1WE8IRhAcRYD3un60Lw1NUwxvoT8vxQbyBhOj9vvSf3w2RKwySuSGeMEMk60YvrIKAki1+33u4Ab3Y9zH8+3o5yHAx/ZFYfpf9yGTGRQE37wqHEfwRsPtwZTTmkPz/C27/q6pRUUB7vdDwlHrQe7jaeW4G5OYmQ/T/7lXmOM3c8v96tU8oWoeUKu8V1WnJKPxGGIvAl6J1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pX3FGpQhQ5yt8hczR1TY1Xvr5ib0Vm/kZkQGf6Gl+Lg=;
 b=FFb+UxCcay1a8YCtEWa66+hbXRYPaoDY+8ZuvW8Xe6TeSWgCP9kcSywIcVXIPdQilZT+mpbF2i5H41MYhgz+yYNMtckNNSYPPhSlk/gylRVyLf8kf0Lhus7udRnmT7wVclJzKRCziSl+2UYuzvvHmpUcOFmHcDKtiAqRKTH1PaGuyAw6Q+qzzX9itkQifxI/9GzZcsL76vwJ6x2uwTblXMRtc0GM7X7pXmMxeiiEOHX7zMrbvpyBxy/Q1ak7rY6KWCyP2ZqZgf1wu296xVaCiMGXO3/LDyy20/c8kQxIk70bWL1p84beUNzXBCKGesRwJh7xv59L/QPm9HTv1/5gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX3FGpQhQ5yt8hczR1TY1Xvr5ib0Vm/kZkQGf6Gl+Lg=;
 b=Qrm4ZAavKRk+KJOLMBIG8FJ/hUIuuM94bRdvLTmn5uAtyWGwTAaa1VjTxmbjzYylOFzTr5pXcs9+XTBrxqlHuDXn5CGLZnPsEMclvTmq4TZhgujIRhfjaD+ew4YEBPIfiWkkzUtQtSmiByKHGPPYDnCcrrZEnTUR0aWG7OxCexkH87hND+pm9CZ581VTmO/TJ6R1qPjx3ALUcBNHcr8pF0OZh5tN48dYV32tmIy44+oMr3/fQOFPB1bnsAy8yd0l4gMxSilIJa9PPfYA6Gz62ujiPTKDwIfsVGgcFw34os3/yjlQw3x4ENRgB6US6uaBES6n0sO5Pi6dCznRvueVNw==
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:28:32 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::75) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 19:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:28:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 12:28:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 12:28:24 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 12:28:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <jszhang@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 4/4] PCI: tegra194: Enable GPIO based Hot-Plug support
Date:   Sat, 1 Oct 2022 00:57:47 +0530
Message-ID: <20220930192747.21471-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
References: <20220930192747.21471-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eea430-e602-4b2b-c644-08daa319f5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDqXc/jPTJVhA6z6NB3nb1zE582WPn0h6ZMPL78XdwxYGedySZM7QyHbOAEqbdrYS6UiPeOPKjlWJCvx6ESDV0URFFdRqzmmPBCdx3WyGKL+L9tKdlqDW1v92cJ7VWKCMBPwqYvLtdDGniQEyRKE1xr1FHpzDfVpjqX1djk7kt2zFZ8CwiOspwtE/DYJTPisF/E0Mse0Yp0PfauKJUAWTwI6Dm6rFWkiXKalMn3y6BYpjqaE0xOhEjWqbedrWrRsNT4lAMLlWY/ToBztV1X8zwcJA/SgGdzaQ5EjInWCZdrxiWqJeYD3C9O0ALbILe5BlB2qHJgDlI55hYZcTjW+/WjTU6EPsnuSIV1ocH8WOwEriiWRl694bRlNsjTcbvlp2KBFES80lqnrN9hfR9Y/H33QZQ0XD5wF1MEX84Pp2cBD1c58gZ18zRZZokcuerVLbqQn/XoPltkVCc9/8LCy5tHxPtWn6kO8Iqwr7DuvHuSC9nqZiGlN1Hw2eYhMVmOyMpZo4+82EQI5s1T3vg0ifpnxD8AjSji703d9CTBmLBAOAIx196PP68coLGCHjR7Q/0bo5RGl8qJKtIrfPNlgicTs7RojBsr/c6ZzDjvWmq+0IBgwYwdqRpcxHOJBQo2fgEvjubvLcc3aQZ95RYJtwUW/ciOE0Pd4910w6+0o0Q/7HL57fQvfxgjWdYzKmr7xtp5n7105xis/bGBBC+vycHIvnlG/dENaCVRIOiUHHRwRNvkf6lx5oK4j1lIfBZsK12ejqVFS+oXab1b2GGQCSkweTt6XUhANVwL77pLGmqY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(26005)(36756003)(2906002)(2616005)(8936002)(41300700001)(70586007)(7696005)(70206006)(36860700001)(8676002)(426003)(110136005)(86362001)(336012)(4326008)(54906003)(40460700003)(7416002)(6666004)(5660300002)(316002)(186003)(1076003)(7636003)(478600001)(40480700001)(921005)(83380400001)(356005)(82310400005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:28:32.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eea430-e602-4b2b-c644-08daa319f5f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the Hot-Plug functionality by registering it with the GPIO Hot-Plug
controller framework.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0370e881422d..1b70aba08473 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -36,6 +36,7 @@
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
+#include "../../hotplug/gpiophp.h"
 
 #define TEGRA194_DWC_IP_VER			0x490A
 #define TEGRA234_DWC_IP_VER			0x562A
@@ -281,6 +282,7 @@ struct tegra_pcie_dw {
 	struct phy **phys;
 
 	bool slot_pluggable;
+	struct gpio_hotplug_slot hp_slot;
 
 	struct dentry *debugfs;
 
@@ -296,6 +298,11 @@ static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 	return container_of(pci, struct tegra_pcie_dw, pci);
 }
 
+static inline struct tegra_pcie_dw *to_tegra_pcie_from_slot(struct gpio_hotplug_slot *slot)
+{
+	return container_of(slot, struct tegra_pcie_dw, hp_slot);
+}
+
 static inline void appl_writel(struct tegra_pcie_dw *pcie, const u32 value,
 			       const u32 reg)
 {
@@ -1046,6 +1053,45 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 	.stop_link = tegra_pcie_dw_stop_link,
 };
 
+static int tegra_pcie_slot_enable(struct gpio_hotplug_slot *slot)
+{
+	struct tegra_pcie_dw *pcie = to_tegra_pcie_from_slot(slot);
+	int ret;
+
+	ret = tegra_pcie_dw_start_link(&pcie->pci);
+	if (!ret)
+		pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
+
+	return ret;
+}
+
+static int tegra_pcie_slot_disable(struct gpio_hotplug_slot *slot)
+{
+	struct tegra_pcie_dw *pcie = to_tegra_pcie_from_slot(slot);
+	u32 val;
+
+	val = appl_readl(pcie, APPL_PINMUX);
+	val &= ~APPL_PINMUX_PEX_RST;
+	appl_writel(pcie, val, APPL_PINMUX);
+
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
+	val = readl(pcie->appl_base + APPL_CTRL);
+	val &= ~APPL_CTRL_LTSSM_EN;
+	writel(val, pcie->appl_base + APPL_CTRL);
+
+	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
+
+	return 0;
+}
+
+static const struct gpio_hotplug_slot_plat_ops tegra_pcie_gpio_hp_plat_ops = {
+	.enable = tegra_pcie_slot_enable,
+	.disable = tegra_pcie_slot_disable,
+};
+
 static const struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
 	.host_init = tegra_pcie_dw_host_init,
 };
@@ -1676,6 +1722,20 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	pcie->debugfs = debugfs_create_dir(name, NULL);
 	init_debugfs(pcie);
 
+	if (pcie->slot_pluggable) {
+		pcie->hp_slot.plat_ops = &tegra_pcie_gpio_hp_plat_ops;
+		pcie->hp_slot.np = pcie->dev->of_node;
+		pcie->hp_slot.slot_nr = pcie->cid;
+		pcie->hp_slot.pdev = pci_get_slot(pcie->pci.pp.bridge->bus, PCI_DEVFN(0, 0));
+
+		ret = register_gpio_hotplug_slot(&pcie->hp_slot);
+		if (ret < 0)
+			dev_warn(dev,
+				 "Failed to register platform ops for GPIO Hot-Plug controller: %d\n",
+				 ret);
+		ret = 0;
+	}
+
 	return ret;
 
 fail_host_init:
@@ -2277,6 +2337,8 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 		if (!pcie->link_state && !pcie->slot_pluggable)
 			return 0;
 
+		if (pcie->slot_pluggable)
+			unregister_gpio_hotplug_slot(&pcie->hp_slot);
 		debugfs_remove_recursive(pcie->debugfs);
 		tegra_pcie_deinit_controller(pcie);
 		pm_runtime_put_sync(pcie->dev);
@@ -2398,6 +2460,8 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (!pcie->link_state && !pcie->slot_pluggable)
 			return;
 
+		if (pcie->slot_pluggable)
+			unregister_gpio_hotplug_slot(&pcie->hp_slot);
 		debugfs_remove_recursive(pcie->debugfs);
 		tegra_pcie_downstream_dev_to_D0(pcie);
 
-- 
2.17.1

