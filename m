Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F6665E70
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjAKOxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbjAKOw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:52:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A3CF;
        Wed, 11 Jan 2023 06:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjKNuB/r2PUHWdKXAGL/0zKgoab4qL8EaDuBWayX2SXcc7MwFjRsNblOTVB3Bm4A4lDOu1C2fLf5ErwHTC7uwC4I+7heT3hWmJlEvAqbDWLUems98W85z9n8OCCIOtOJ1qhHnKIm3bso6G70FkNw9U9gfvB5P/UubWMeVCin1fnSidgBChT1WNzySZDaSRs9xvQE7teqWiaLdmYSXUnPNR0PDlT+XmB+OqGziGok2X1eBeT377UM/miuqCkButbXC25sMLd9eMgNi+eqqBm3ktslm3f7WR5iuavbU5L8jaN+vcHTsg4h3Y8W1WVQ9wPOvtYGQ20TaRmocR5rh1rAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p+tQZ/7hYwAld1RJnxsaq6V4kpTjYBCm7S+aPFvkNc=;
 b=U8VDnmvxiXMowjbR8pDKmm8HrZJsNd4xU1QFAV2oLv2JkqBlolh/7rl+QZltoo81VdP6aufPfKVg4tRmM317jEynORLoj/OF2AUIoG8qvw8jZUClr1Zlji13E/Um3hsodLExU7zpGM698/sfhiLfgUll8dwbA9tRe2v0lwhAENXAY74MCggtX27AJojgLWimOMWLAEPYkrhfXUg27/iyn3BfvN0RE/G2sxldGR9tlzWH6+sMf2PPVGlOvmU4uuJu+QcyigJ6reeT6XgXLPeUIV/Szi72Dbtz0WZ+6iqk7lVv9zLaGX2yJ/2HI6Fub0KYdUu++gGfMsoL2lKJMxjS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p+tQZ/7hYwAld1RJnxsaq6V4kpTjYBCm7S+aPFvkNc=;
 b=YhWPqU8XeJQZzq+TgI27f3NHdpODJivnvPEcZnTCFv9VsEhzsVQq8SuXSOQ3hTY3Igd2uqa962ODvhUI9kmBT+Nweyghmf3TU+V70XNYXb8qJv0P6jVTWxrJDufjEvLJC7tzGb4tT98Abx+PfG3B+UQu9+Gkw7FFuIok8c2gTv/WqjPRDHb81zm4UQoAPtX9wqODg7k9K+gu3bZr9cyzOxWaZLnxdtWKi/1aLYxl6cbVSUnIT5YOYSWP7mnV65P9izfNchgmuTgbd4ZGY45daaVvpu/pqMafZgCE8PGvQEKgWbSbEBFqEy0Dgrf6m1m8YWJaL5SSH70iAnz8WGn/aQ==
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:52:24 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::eb) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 14:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12 via Frontend Transport; Wed, 11 Jan 2023 14:52:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 06:52:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 06:52:15 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 06:52:13 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: pciehp: Disable ACS Source Validation during hot-remove
Date:   Wed, 11 Jan 2023 20:22:06 +0530
Message-ID: <20230111145206.23919-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: af1345b8-36d7-4b5a-73cf-08daf3e3731b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6F31A1UD6Tk64dK0wu7ynFAT4ZZQ+/B/vxCFNoEELFRs+/y5TGDfUdmV0HVwwYMMW7PSnTZwReLJewRpUiH0ndIuVgFFiaCBrIi68RCQAoVrNT52GWf3Z6Cc6AW0c7zmfj6cqzITv8mwbBIgKTY8uQkkWFxuQwASkn9SE69Z24M2t8H8kWaZ8e2EYnYKiGQbOYrBWHRcdKRrkYcIH5vVn5Kue1Eb2nXojsquaV45puTco2GEMq1wh1xrJ+NCJVckKz1xaroDw+Kb5cPbriLvZRjETmPxts9I+Zymh4i29Ls52RCouUa6MfZlDC4Jg95sKErRbxxDwEi4gN/3tppaj9h9xvmoZEgNRrnv3Ku1oBLo47TmwFAACDNjfXSrlH6uNEGVA+bv8stYL1BUaeBCuCi5x73PRp3+J9uBpy3BsP2daKa1llH1kIjaH2ph79cY7fSe656eyzMlgFpARpce855gLoW8J4b/SQeNS522T8NYGnezKgUJ2KdhdtrgYNJ+4RdYOB4kw7sB2+BdRn2FXoPZV/2zSp1/lZ2Yv5Au2wK0+VAf8dBfK86K/Ha/CcUGn0Utk8aoADDBem3zwycjr/SpVUO3H6/QqsxDNfTOwAlYf5eWuHC5p+aI8I2//kBeOD2dWJislPPqwvUzKqhf0uIHrbmBDaGfwkc/9jqmWpNSj70fZdaiGTj4lMl0eLTo1/p6GtfeAqigCuabIt3Zw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(426003)(47076005)(2616005)(4326008)(41300700001)(8676002)(316002)(6916009)(70586007)(36756003)(336012)(70206006)(82310400005)(36860700001)(86362001)(7636003)(356005)(83380400001)(8936002)(54906003)(5660300002)(40480700001)(82740400003)(2906002)(478600001)(186003)(7696005)(26005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:52:23.9557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1345b8-36d7-4b5a-73cf-08daf3e3731b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
send upstream messages before they have been assigned a bus number and
such messages have a Requester ID with Bus number set to 00h.
If the Downstrem port has ACS Source Validation enabled, these messages
will be detected as ACS violation error.
Hence, disable ACS Source Validation in the bridge device during
hot-remove operation and re-enable it after enumeration of the
downstream hierarchy but before binding the respective device drivers.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 13 ++++++++++++-
 drivers/pci/pci.c                | 20 ++++++++++++++++++++
 include/linux/pci.h              |  6 ++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..ad90bcf3f621 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,6 +63,7 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+	pci_configure_acs_sv(bridge, true);
 	pci_bus_add_devices(parent);
 
  out:
@@ -117,6 +118,16 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 		}
 		pci_dev_put(dev);
 	}
-
+	/*
+	 * PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted
+	 * to send upstream messages before they have been assigned a bus
+	 * number and such messages have a Requester ID with Bus number
+	 * set to 00h. If the Downstrem port has ACS Source Validation enabled,
+	 * these messages will be detected as ACS violation error.
+	 * Hence, disable ACS Source Validation here and re-enable it after
+	 * enumeration of the downstream hierarchy and before binding the
+	 * respective device drivers in pciehp_configure_device().
+	 */
+	pci_configure_acs_sv(ctrl->pcie->port, false);
 	pci_unlock_rescan_remove();
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..d3d0246fddd9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -991,6 +991,26 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag)
+{
+	u16 cap;
+	u16 ctrl;
+
+	if (!pci_acs_enable || !dev->acs_cap)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CAP, &cap);
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &ctrl);
+
+	if (flag)
+		ctrl |= (cap & PCI_ACS_SV);
+	else
+		ctrl &= ~(cap & PCI_ACS_SV);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, ctrl);
+}
+EXPORT_SYMBOL_GPL(pci_configure_acs_sv);
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..c36ac3eb2843 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2239,6 +2239,12 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot);
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
+#if defined(CONFIG_HOTPLUG_PCI_PCIE)
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag);
+#else
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag) {}
+#endif
+
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
-- 
2.17.1

