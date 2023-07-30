Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85945768752
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jul 2023 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjG3TPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjG3TPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 15:15:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28910FC;
        Sun, 30 Jul 2023 12:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGfyLPK6y53w8pZyLooUizPmniz4gLBcaeL0hbtuOpW3e69WLEWm4KrqaNQ0+OWSqRsZInBEWcHF54cGamcI6KGM0nHQw9A+ljf7wEcKaBtcqSTrq4ILnOZKNysp9xF1G0zP0enl/6bHhYKFYfYmeA/7yw/iKOY9uBqrH+iuovEBoQVkUy/wMboX7rlZblB/CsMG0MdB72s/QSlgaX4pz8En3/zDO+93EWqxINBTq6+bK9BFmbFlzR71oKl2uOXNbpoxbFo6hydiqEfVT36TXX5mRdEIu3ZmSqWcLs58hdT9HiUqa7uk+/WT0O02lqZ42zoZoiOYIFgcmTvsLZ0LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvjlgDBU8LF8hWtgWOuD2MFtdAosvxOMZAnoulcAA/I=;
 b=AhRGMHQrtUjSiTOKBZS1Fk29a1j+5ddZpkwJcT0LXFDvJn67H9K0FMmP+m2OXK/F8o1F5IWwwfrrGzOvUruI1Kzz9hQMP6a0+X0NdjbdpKAylZVKiD5wfETF20R7TgweFBPdyRT3Ibjg7EpRwHS1QZNxjoD+BsMPUy5WYfFf73Ul6zBMTtQayCkmtbFXRaSSr7Dz8asj9imBLYyjW8/lzHBsGs5a8KJSQOxzzHahDPiN5xWkG8vVtijU2VuW5OGKmdX4MtG3HBQbsUH3C4Dho4cLYgs4yxBo5d9ilZNYhrUtecewlqlPIz/+u+dOM7bsw95WTj9474aQrVUfUdhchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvjlgDBU8LF8hWtgWOuD2MFtdAosvxOMZAnoulcAA/I=;
 b=aR1d4oNN7JoRKk9WccKxJQ24NKW8o/faAYDifewMOcOYXvfaY9QUtDKgAUJ1m4OA8ejJSMVgAQRxOd0aRVm+oh5J6k+vYrVXxRQ+kKb+1Dqp/i6MCkKeVHlb2R6s4Ze4ABA+gA5Dc1n/N6lICYWnc23VbBhUrX5Tq42awPy2uAZfgkk3cZ2IJdGfpotun13UCUH5291bVgBrswveqvIh8ccutXb0Z8KTgSyDLv0bmyPNgUGGFyr7NQXwpUl8ujlmg8/wv0zcqMBvKbVjBWC+4EeOO+UM/sKw56e/tSDrFnLcxFDhJQIc0GAX5zsT1FSgK0ihk6rnyXzc3BSjrEhLZQ==
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 19:15:36 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::91) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Sun, 30 Jul 2023 19:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Sun, 30 Jul 2023 19:15:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 30 Jul 2023
 12:15:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 30 Jul 2023 12:15:26 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 30 Jul 2023 12:15:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>,
        <alex.williamson@redhat.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during hot-remove
Date:   Mon, 31 Jul 2023 00:45:19 +0530
Message-ID: <20230730191519.3124390-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111190533.29979-1-vidyas@nvidia.com>
References: <20230111190533.29979-1-vidyas@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 873e97af-8f93-405c-5d0d-08db91315a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6G6oXN6xb4CZeAPgp4hWMqgDht1v2z0qrXdbSdLo6WycOk9eoGazLpkITo4jaLZ7QHhOliIqWxSMBDq6ZJ7H/0752fBEd5SWz1/Ge89hJzVKfb36vcVaB0OgZTAmgQ6olCwD4BUns7JzFZKWAFVimipO8TGZ7njgmOGHWxtyVGCn/bpMp/iOo+fPXK1G1v6zZ873o5sN+WRPyRH5VOpgbVtQDh86gpXQ2rvZ/a/Slt4hO7WQvRiyvvuw7pCgvZCV9+wdFAOgMq+gsRLNIWmcX9ClBi5xN38qoPWnnFxvpoJ/qo8FRvRpWdU3wOdng7gOAoXYud0lgEtgkHz1yUeNTZga4+RgwBKkIGlalhx4L75VitGoUfHo9QCTzkvjWyGI78C6+haxljuTreGmywTjCQE/yusU7pR9Up9GEtzT6wP8zMLjpUSFyd6YEkuZ2DwqLDMwhHaiSkguTY1zNowf2c5qabQ+4bSz/TjarLaSJblAxmMSnJSChbmMI+wXnfEusqr9fXs2qlcpqfAY1hSs8PFmS2QMjUzAypeZKXjO1q/TQEsmKmAwrkGElXZdNqBCw3Cuq0ZojeGsAeXFks6siQaDBiab3dKkpAU177v32c7qpOgQKG5ZG2OzGvqyZ7RTABDGeUOu9xQgzGJtbxKrwzFzCGhwZqA8inFm8So9SkeZ/VxsZ1kCIGpafFyV9WpVZtDGx1rUQME+ku+KdfkKZER+Rg+2/0fXbJPZ15kRGBnliLW/MM/VLLm+0c7wl4X
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(356005)(7636003)(82740400003)(40480700001)(86362001)(36756003)(40460700003)(478600001)(6666004)(7696005)(2616005)(336012)(186003)(1076003)(26005)(8676002)(8936002)(5660300002)(70586007)(6636002)(4326008)(70206006)(2906002)(54906003)(110136005)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 19:15:35.6367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873e97af-8f93-405c-5d0d-08db91315a4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
send upstream messages before they have been assigned a bus number and
such messages have a Requester ID with Bus number set to 00h.
If the Downstream port has ACS Source Validation enabled, these messages
will be detected as ACS violation error.

Hence, disable ACS Source Validation in the bridge device during
hot-remove operation and re-enable it after enumeration of the
downstream hierarchy but before binding the respective device drivers.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v3:
* Addressed review comments from Bjon

v2:
* Fixed build issues

 drivers/pci/hotplug/pciehp_pci.c | 13 ++++++++++++-
 drivers/pci/pci.c                | 21 +++++++++++++++++++++
 include/linux/pci.h              |  6 ++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..42d4328f2a9b 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,6 +63,7 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+	pci_configure_acs_sv(bridge, true);
 
 	/*
 	 * Release reset_lock during driver binding
@@ -132,6 +133,16 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 		}
 		pci_dev_put(dev);
 	}
-
+	/*
+	 * PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted
+	 * to send upstream messages before they have been assigned a bus
+	 * number and such messages have a Requester ID with Bus number
+	 * set to 00h. If the Downstream port has ACS Source Validation enabled,
+	 * these messages will be detected as ACS violation error.
+	 * Hence, disable ACS Source Validation here and re-enable it after
+	 * enumeration of the downstream hierarchy and before binding the
+	 * respective device drivers in pciehp_configure_device().
+	 */
+	pci_configure_acs_sv(ctrl->pcie->port, false);
 	pci_unlock_rescan_remove();
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..5a21640de355 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1004,6 +1004,27 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
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
+#endif
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eeb2e6f6130f..b6d53fe28371 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2350,6 +2350,12 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot);
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag);
+#else
+static inline void pci_configure_acs_sv(struct pci_dev *dev, bool flag) { }
+#endif
+
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
-- 
2.25.1

