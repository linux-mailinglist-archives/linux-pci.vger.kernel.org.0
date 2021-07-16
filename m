Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70243CB9C2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhGPP1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:41 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:11488
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240950AbhGPP1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqG8EthRYljiWL6tWFlrRC10Fm0nMpX93Pwxgv9yRo+6F4BU65O2MeQEVT3LYgf7dzJBNbf9Hl0Ue+rFnILz92EXcDTo8AAAW+Zys7KyZ/rB67bELtGiiXmIH0odw+5J05lR2rOIA4TbFkSBG0e3ewUt+qeb3TmrWWLhc8gsFxamx4GzCR13IZ2SmgfzDg0bIXTGz0ut18R9yay08lW9557o6c62assxJsJR54CiMdPHK3qnbxirD/IwJFE+g5NH5RQlso74qoCVR7uH2csLXkp6Tmc/av6kB3uVLmTpNggBMAtE7SMz4nWWWrfN/2EEMxB3gbFtIQxA/kr+vF3kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgX8pxJBCFIwVSUfnLxjuJM10cAnpiQahGUcJ/gQyvg=;
 b=QCUenMsos9+02k8x+ZpRbgstQOpq3NVnTOTfbk2OptyytdkfbTbGXeVgqsY7oHJkVxJTKHBVLPKDSr3CwjcuYOspoAOePib/coXGzYK5Z8edSQjZ/+xFlazMT4Q9epN9sxS/SB7ajOsqbYQTwYHpEe+dP08GVBPoXUX2hkqZ8dIYY4zdZTBy6Tkb5icUlpuMeRWWWYNoAS+7Xy0tpozX0BsI9nS/74SvW0maZr6Wai+9ugdSetVzhRQlrnxSfUTPZuXf/Ckj4jU1CamGXQR7TlSM26qg+VOjDI0AHuvP7wk7ZVhFcRKU93gn442xntOKksmeGn8VlGAWqqXGy1ip8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgX8pxJBCFIwVSUfnLxjuJM10cAnpiQahGUcJ/gQyvg=;
 b=NJiSvVyYpSUrZmYcG+4zogSP8Q+0zYVX/0W9jS3qrknupM0SQNlla6/ggWET6/z5+WH4p9t1EzsB69rWl1ARoS5Mz9IYm1aPDfrai4u1neyHW3KZxVvd7qmlKpHRzVTgpsY6VR+BvnUWcQYwttW8tu70OCFOlvATlIUQZlyOPXWL8H1RIuVl9MA5yPAzAFOmJNRBPdWWbP4v3d8EN6y23kw3PI/TzG3HB5CnqGF9p5EwK00CYhxSdzdvNkRd/sFO1Vf41wuwy3doxVLMSoosZ9y2bKRf7wi7jIe+ZJVIEVRA4i0xH9IIBO9+fD8M6DB6PoCkOSvjWBso5ipUi2pLKw==
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 16 Jul
 2021 15:24:40 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::c5) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:39 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:37 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 8/8] PCI: Change the type of probe argument in reset functions
Date:   Fri, 16 Jul 2021 10:19:46 -0500
Message-ID: <20210716151946.690-9-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
References: <20210716151946.690-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac60ad82-e9e9-4423-517d-08d9486dd44c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1723CB5CD325CF1A717C5FCFC7119@DM5PR12MB1723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4S/Mr7uMqBVYnQsaIRhgESvr0QRWiGqo2ExKQBWcUWBYRLGI/2x32zUgzI26SzCp1QfrRt74ve8bJ0JlQc7K9WOn88Escsw6mF7C4SVsvld+ipHxYREVu11eoCCtDyHTUZT0VQMzqKuy4js2cKav/5Rqb9BWKoUhHlXTWPq3QvbNHQiDAyhDBi1gmcz8qX+oIus01yoh1HDksoa1jetFhpS3WZfH9cU546PrVFAarvsJLRk4giZjqfmXNZG7IqCojRxTEf1/c9L6FDmeTskCXwy0gVMHNSwjF5Ihz+U+q+FkKAgqbRH/jQeibHACkytdJISlRl4BIlpSNMsIWf1aqQAn4Wleh7o8+DejenfkdFAkP5XeMGrQcsX801bg0fwDbkrAJxphoQ8F6pmIM+L4/9kHt3B0FRlP4gOdFC0+lXjElH/zWTAUjPjLyxbjkHRbfL9H2KB8a0akFyxpKFAlrJEyZOBYA4jTQjWpPyVbpXuGetfXWQcGGBD7DS0H9BpZDy/iPXlNigdWB9uPz2HQ3cD2HYoBqmJm3Mr6rRYHj/KgA28KGVZFvF2du53r8WjrKEhtSbsSK9wlZ5IJK6k8z4mniXkV55ExwPDnqFOXLuhV1YQjT6rFcQZi5Q6EZVePDsv3HHv3ng/bekkYlyfPTGOr6Q9vkS1V9l3ZLg7vyEbqNPDoxpmojzWqgYi/d8AV9uLFKkU9tskehav4tsaFxv9p0kJ15mMXEFjGqtB6wD29B3NM/nd5USehDT3JcwOro7L94DftFIJ161BlFwImV1T8B/5gwyJq7DGfAOdwm1H8edGiKY5cBS61v2jfJFb/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(47076005)(5660300002)(16526019)(8936002)(966005)(6666004)(2906002)(26005)(186003)(4326008)(478600001)(336012)(83380400001)(426003)(70586007)(7696005)(70206006)(6916009)(82740400003)(356005)(7636003)(34020700004)(66574015)(54906003)(107886003)(2616005)(8676002)(316002)(36756003)(36860700001)(1076003)(36906005)(82310400003)(86362001)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:39.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac60ad82-e9e9-4423-517d-08d9486dd44c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Introduce a new enum pci_reset_mode_t to make the context of probe argument
in reset functions clear and the code easier to read.  Change the type of
probe argument in functions which implement reset methods from int to
pci_reset_mode_t to make the intent clear.

Add a new line in return statement of pci_reset_bus_function().

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 drivers/pci/hotplug/pciehp.h                  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  4 +-
 drivers/pci/hotplug/pnv_php.c                 |  4 +-
 drivers/pci/pci-acpi.c                        | 10 ++-
 drivers/pci/pci-sysfs.c                       |  6 +-
 drivers/pci/pci.c                             | 85 ++++++++++++-------
 drivers/pci/pci.h                             | 12 +--
 drivers/pci/pcie/aer.c                        |  2 +-
 drivers/pci/quirks.c                          | 37 ++++----
 include/linux/pci.h                           |  8 +-
 include/linux/pci_hotplug.h                   |  2 +-
 13 files changed, 107 insertions(+), 69 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 2db3fd5815c82..6c61817996a33 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
-	pcie_reset_flr(pdev, 0);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 
 	pci_restore_state(pdev);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index d185df5acea69..ac821c5532a4e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (!pcie_reset_flr(oct->pci_dev, 1))
+		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index d4a930881054d..6c5de749ece82 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -184,7 +184,7 @@ void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_t mode);
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9d06939736c0f..67fd7024a29aa 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -870,14 +870,14 @@ void pcie_disable_interrupt(struct controller *ctrl)
  * momentarily, if we see that they could interfere. Also, clear any spurious
  * events after.
  */
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_t mode)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	down_write(&ctrl->reset_lock);
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 04565162a4495..77df598c8deaf 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -526,7 +526,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	return 0;
 }
 
-static int pnv_php_reset_slot(struct hotplug_slot *slot, int probe)
+static int pnv_php_reset_slot(struct hotplug_slot *slot, pci_reset_mode_t mode)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	struct pci_dev *bridge = php_slot->pdev;
@@ -537,7 +537,7 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, int probe)
 	 * which don't have a bridge. Only claim to support
 	 * reset_slot() if we have a bridge device (for now...)
 	 */
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return !bridge;
 
 	/* mask our interrupt while resetting the bridge */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 31f76746741f5..4cb84ce6829f7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -944,16 +944,20 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 /**
  * pci_dev_acpi_reset - do a function level reset using _RST method
  * @dev: device to reset
- * @probe: check if _RST method is included in the acpi_device context.
+ * @probe: If PCI_RESET_PROBE, check whether _RST method is included
+ *         in the acpi_device context.
  */
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!handle || !acpi_has_method(handle, "_RST"))
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 65791d8b07aa5..87dbe33fb149e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1393,7 +1393,8 @@ static ssize_t reset_method_store(struct device *dev,
 
 		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
 			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
-			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
+			    !pci_reset_fn_methods[i].reset_fn(pdev,
+							      PCI_RESET_PROBE)) {
 				reset_methods[n++] = i;
 				break;
 			}
@@ -1405,7 +1406,8 @@ static ssize_t reset_method_store(struct device *dev,
 		}
 	}
 
-	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
+	if (!pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE) &&
+	    reset_methods[0] != 1)
 		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
 
 set_reset_methods:
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8aab4097f80bc..5a2452d0f1771 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4660,30 +4660,36 @@ EXPORT_SYMBOL_GPL(pcie_flr);
 /**
  * pcie_reset_flr - initiate a PCIe function level reset
  * @dev: device to reset
- * @probe: If set, only check if the device can be reset this way.
+ * @mode: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * Initiate a function level reset on @dev.
  */
-int pcie_reset_flr(struct pci_dev *dev, int probe)
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!dev->has_pcie_flr)
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	return pcie_flr(dev);
 }
 EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
-static int pci_af_flr(struct pci_dev *dev, int probe)
+static int pci_af_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	int pos;
 	u8 cap;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
 	if (!pos)
 		return -ENOTTY;
@@ -4695,7 +4701,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	/*
@@ -4726,7 +4732,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 /**
  * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
  * @dev: Device to reset.
- * @probe: If set, only check if the device can be reset this way.
+ * @mode: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
  * unset, it will be reinitialized internally when going from PCI_D3hot to
@@ -4738,10 +4744,13 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  * by default (i.e. unless the @dev's d3hot_delay field has a different value).
  * Moreover, only devices in D0 can be reset by this function.
  */
-static int pci_pm_reset(struct pci_dev *dev, int probe)
+static int pci_pm_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	u16 csr;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
 
@@ -4749,7 +4758,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	if (dev->current_state != PCI_D0)
@@ -4998,10 +5007,13 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
+static int pci_parent_bus_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	struct pci_dev *pdev;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
@@ -5010,44 +5022,47 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 		if (pdev != dev)
 			return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
-static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, pci_reset_mode_t mode)
 {
 	int rc = -ENOTTY;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!hotplug || !try_module_get(hotplug->owner))
 		return rc;
 
 	if (hotplug->ops->reset_slot)
-		rc = hotplug->ops->reset_slot(hotplug, probe);
+		rc = hotplug->ops->reset_slot(hotplug, mode);
 
 	module_put(hotplug->owner);
 
 	return rc;
 }
 
-static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
+static int pci_dev_reset_slot_function(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	if (dev->multifunction || dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
 
-	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+	return pci_reset_hotplug_slot(dev->slot->hotplug, mode);
 }
 
-static int pci_reset_bus_function(struct pci_dev *dev, int probe)
+static int pci_reset_bus_function(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	int rc;
 
-	rc = pci_dev_reset_slot_function(dev, probe);
+	rc = pci_dev_reset_slot_function(dev, mode);
 	if (rc != -ENOTTY)
 		return rc;
-	return pci_parent_bus_reset(dev, probe);
+	return pci_parent_bus_reset(dev, mode);
 }
 
 static void pci_dev_lock(struct pci_dev *dev)
@@ -5169,7 +5184,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * mechanisms might be broken on the device.
 	 */
 	for (i = 0; i <  PCI_NUM_RESET_METHODS && (m = dev->reset_methods[i]); i++) {
-		rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
+		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			return 0;
 		if (rc != -ENOTTY)
@@ -5204,7 +5219,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 	might_sleep();
 
 	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
-		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
 		if (!rc)
 			reset_methods[n++] = i;
 		else if (rc != -ENOTTY)
@@ -5521,21 +5536,24 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	}
 }
 
-static int pci_slot_reset(struct pci_slot *slot, int probe)
+static int pci_slot_reset(struct pci_slot *slot, pci_reset_mode_t mode)
 {
 	int rc;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!slot || !pci_slot_resetable(slot))
 		return -ENOTTY;
 
-	if (!probe)
+	if (mode != PCI_RESET_PROBE)
 		pci_slot_lock(slot);
 
 	might_sleep();
 
-	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
+	rc = pci_reset_hotplug_slot(slot->hotplug, mode);
 
-	if (!probe)
+	if (mode != PCI_RESET_PROBE)
 		pci_slot_unlock(slot);
 
 	return rc;
@@ -5549,7 +5567,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
  */
 int pci_probe_reset_slot(struct pci_slot *slot)
 {
-	return pci_slot_reset(slot, 1);
+	return pci_slot_reset(slot, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
@@ -5572,14 +5590,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
-	rc = pci_slot_reset(slot, 1);
+	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
 
 	if (pci_slot_trylock(slot)) {
 		pci_slot_save_and_disable_locked(slot);
 		might_sleep();
-		rc = pci_reset_hotplug_slot(slot->hotplug, 0);
+		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
 		pci_slot_restore_locked(slot);
 		pci_slot_unlock(slot);
 	} else
@@ -5588,14 +5606,17 @@ static int __pci_reset_slot(struct pci_slot *slot)
 	return rc;
 }
 
-static int pci_bus_reset(struct pci_bus *bus, int probe)
+static int pci_bus_reset(struct pci_bus *bus, pci_reset_mode_t mode)
 {
 	int ret;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	pci_bus_lock(bus);
@@ -5634,14 +5655,14 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 			goto bus_reset;
 
 	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_slot_reset(slot, 0))
+		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
 			goto bus_reset;
 
 	mutex_unlock(&pci_slot_mutex);
 	return 0;
 bus_reset:
 	mutex_unlock(&pci_slot_mutex);
-	return pci_bus_reset(bridge->subordinate, 0);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
 
 /**
@@ -5652,7 +5673,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
  */
 int pci_probe_reset_bus(struct pci_bus *bus)
 {
-	return pci_bus_reset(bus, 1);
+	return pci_bus_reset(bus, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
@@ -5666,7 +5687,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
-	rc = pci_bus_reset(bus, 1);
+	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 699d14243867a..cc480c238db9c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -608,19 +608,19 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
-	int (*reset)(struct pci_dev *dev, int probe);
+	int (*reset)(struct pci_dev *dev, pci_reset_mode_t mode);
 };
 
 struct pci_reset_fn_method {
-	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	int (*reset_fn)(struct pci_dev *pdev, pci_reset_mode_t mode);
 	char *name;
 };
 
 extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
-int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode);
 #else
-static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	return -ENOTTY;
 }
@@ -709,9 +709,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
+int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode);
 #else
-static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	return -ENOTTY;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 031379deb1304..9784fdcf30061 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1407,7 +1407,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	}
 
 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
-		rc = pcie_reset_flr(dev, 0);
+		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			pci_info(dev, "has been reset\n");
 		else
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f43883a2e33df..b230bd07a0295 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3702,7 +3702,7 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
+static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	/*
 	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
@@ -3712,7 +3712,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	 * Thus we must call pcie_flr() directly without first checking if it is
 	 * supported.
 	 */
-	if (!probe)
+	if (mode == PCI_RESET_DO_RESET)
 		pcie_flr(dev);
 	return 0;
 }
@@ -3724,13 +3724,13 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 #define NSDE_PWR_STATE		0xd0100
 #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
 
-static int reset_ivb_igd(struct pci_dev *dev, int probe)
+static int reset_ivb_igd(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	void __iomem *mmio_base;
 	unsigned long timeout;
 	u32 val;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	mmio_base = pci_iomap(dev, 0, 0);
@@ -3767,7 +3767,7 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 }
 
 /* Device-specific reset method for Chelsio T4-based adapters */
-static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
+static int reset_chelsio_generic_dev(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	u16 old_command;
 	u16 msix_flags;
@@ -3783,7 +3783,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 	 * If this is the "probe" phase, return 0 indicating that we can
 	 * reset this device.
 	 */
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	/*
@@ -3845,17 +3845,17 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
  *    Chapter 3: NVMe control registers
  *    Chapter 7.3: Reset behavior
  */
-static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
+static int nvme_disable_and_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	void __iomem *bar;
 	u16 cmd;
 	u32 cfg;
 
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, PCI_RESET_PROBE) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
@@ -3919,11 +3919,13 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  * device too soon after FLR.  A 250ms delay after FLR has heuristically
  * proven to produce reliably working results for device assignment cases.
  */
-static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
+static int delay_250ms_after_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
-	int ret = pcie_reset_flr(dev, probe);
+	int ret;
+
+	ret = pcie_reset_flr(dev, mode);
 
-	if (probe)
+	if (ret || mode == PCI_RESET_PROBE)
 		return ret;
 
 	msleep(250);
@@ -3939,13 +3941,13 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 #define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */
 
 /* Device-specific reset method for Huawei Intelligent NIC virtual functions */
-static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
+static int reset_hinic_vf_dev(struct pci_dev *pdev, pci_reset_mode_t mode)
 {
 	unsigned long timeout;
 	void __iomem *bar;
 	u32 val;
 
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;
 
 	bar = pci_iomap(pdev, 0, 0);
@@ -4016,16 +4018,19 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
  * because when a host assigns a device to a guest VM, the host may need
  * to reset the device but probably doesn't have a driver for it.
  */
-int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	const struct pci_dev_reset_methods *i;
 
+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	for (i = pci_dev_reset_methods; i->reset; i++) {
 		if ((i->vendor == dev->vendor ||
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID))
-			return i->reset(dev, probe);
+			return i->reset(dev, mode);
 	}
 
 	return -ENOTTY;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 698a668828f66..e6f34fbd19332 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,6 +52,12 @@
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
 #define PCI_NUM_RESET_METHODS 7
 
+typedef enum pci_reset_mode {
+	PCI_RESET_DO_RESET,
+	PCI_RESET_PROBE,
+	PCI_RESET_MODE_MAX,
+} pci_reset_mode_t;
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -1235,7 +1241,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-int pcie_reset_flr(struct pci_dev *dev, int probe);
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t mode);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 2dac431d94ac1..75e4e13887d0b 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -44,7 +44,7 @@ struct hotplug_slot_ops {
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
-	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
+	int (*reset_slot)		(struct hotplug_slot *slot, pci_reset_mode_t mode);
 };
 
 /**
-- 
2.25.1

