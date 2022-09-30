Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A05F126B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiI3T21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiI3T2Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:28:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521AC7459;
        Fri, 30 Sep 2022 12:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmdl49NgKIn1CfDbNpJ+t+WyREKw762kT6jfj9DdexvvYimqYzn9f/uOC9ZjO17tyvO2SPVkyl51aPXk0rFDsuyJHBqcElcoK4suMdlFsHTBAWHgwpbSUYPkqBziGptcwhS2g8GSDlHtj/TSC1ooDYc93upoBPqkesTj5gej5EB4ISuMxqP5XtMnl5wwaHumTD7cvmgzKeOpXhL8l16E6k6KrGMiDZeclTZkqjD2/vwMlCfAu0WMgG1p1r6UklpBOFSiD6LAbu8ex4Q/owkctW37AGoal9aqbeuDI1iFscTmLt7vB75GUIhtbLp37lXkXawszRn7JTmMAS1lHp/lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPSAcInsKaOpLc48CP4cuF5Zh17mKqDt8tkFS36bN7E=;
 b=UlDurnaZ+BIVBKDa8jySSlabQS0US2T15uqxxJg5HgjYMSIsTBFZ1R86m2B+pYl6LYZCojbp/Ox697CIVvmM29K/yM/q4xb2odKyqwl0yrmeuoW3EP/3yYjfqD+cE+N0cgR1vGZm3P8wtDlssQ0lQjjIY5GpVewV5buuaa0Qk7dYRU9SOn5i6NjGp3faFp7BtP7tNsLKcZTI7uNjTfI9FtO0njaO+tVMmdCfHP6BGZLr6dytHaS0tY1p8otduUuLZj0DUG3v8ZCAF+X6cSSF1OfQ7F6/OlzdK8WtWnyc3d5con1YBD1Dyyz/bigcUwgZh+heUK/1VFIO1pFA6kwQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPSAcInsKaOpLc48CP4cuF5Zh17mKqDt8tkFS36bN7E=;
 b=BPxx6nJBb+sTkdm6ql71pvnlJGTp6dthd4votv0zHWck1udHVAkcaCx2wzPYwXPyCdbiq//IIxFSfeRwkYEehSabB57mBSBuverN0q6jxqoW4FTC6+4opZz81uMgYg4zTcinUa2294xpT8HWb06QpdNaACLKH1/Rt7Ydx2Ts/+9fIrZDYp71ZylgaLTb3/wWcllnbd4KAEPywkkVjG+DnrJ/4PbLG8/4VPiKn4Rk+n52SW0GMRnAHxStOEUatocozk20VQRtV+aJFHex+dztf5kxxjb/IjtPHmtEgDdljYf3RJNfxRVM082hVLqxOOZ7yBNr6zeLRhmCtsRbBSSjtg==
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:28:21 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::1a) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 30 Sep 2022 19:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:28:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 12:28:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 12:28:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 12:28:06 -0700
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
Subject: [PATCH V1 2/4] PCI/hotplug: Add GPIO PCIe hotplug driver
Date:   Sat, 1 Oct 2022 00:57:45 +0530
Message-ID: <20220930192747.21471-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
References: <20220930192747.21471-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffccc90-00a0-4120-39a2-08daa319efa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlTrJcWKrvScnlL2RIaRpTO8SalWxK8/lYaTY5bvB46fECwaxmyPt7GBS6ke9zcYYjBOJM0u8yq6Q3Ou4jKmHuGFTekJO5DvK0b7mjuK5+gsvzFwBcMXuijbXkCL/Rasfmn4wqybUytOkDmPBBLNsyFNycYBkt8SGTbWtw6c0q8eEGLnF2akucleXrb4iFD10Lwxal77DWJ5e7EN+E46ym3glg0u6jieWn1KC8BzyKaR3a4/EcWumjDF2kd3ob54uSyMKUA01wF3U/QnM21jarUoa7Oq/zAWobuBEvs136MlD9NgKKWy0YUJyGvZR+BsiMJLUtli197snDYNZV7Ld+2SS9Mb1oKFgb2K4X1sGs6M5kYGav0mpNt5fTJZMJFkv+VzHIjD3b87AmE1Kstrntq1FjZEptyeMs7lWcyp1d3RMsrwbxiyB7I+vTYohCmBilcByKcLk5mvNNTbswaZlvnSwZ2fXkhtSQ8CDD5w0G0mVG88tEHStV5hPP/p71gfN7TKalFDi0/gY56zvTT+8DFHXx+KMXOcwK28l1Hc8hAQoua3MY9jSjiTfsgZAXZ0j2xl07nB5+OSOqN/tdANAqCr9E8GyaABbaaEYJ4+1KyI61IB4tOvJZJghSw8YS8yGd6e6qw0UU+uoOjOUfm1L3JA8lytrrTK9W5hz90gaA8XmVfyOVO0Un7pZ177sk9QTdLrDOda6PauxksHpKg6qx666EPwTPeI+KeWFclENxIZ58MfpQ2WQKWOf6vdiBwWvKvSdvsnuOhk3UZxi1LzoOBJ0vZ5qNCsYGbf4Llxbaw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(54906003)(110136005)(86362001)(36860700001)(336012)(921005)(7416002)(2616005)(356005)(1076003)(186003)(7636003)(82740400003)(47076005)(426003)(26005)(478600001)(6666004)(70206006)(8676002)(316002)(70586007)(8936002)(4326008)(7696005)(40480700001)(82310400005)(40460700003)(2906002)(41300700001)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:28:21.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffccc90-00a0-4120-39a2-08daa319efa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds a standalone driver to support PCIe hotplug functionality
merely based on a GPIO indicating the status of a downstream device
connectivity. It looks for "hotplug-gpios" property in the corresponding
device node to get the GPIO information.

It also provides a mechanism for platform drivers of the controllers
to register ops to perform any platform specific operations while
enabling/disabling the slots.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/hotplug/Kconfig    |  11 ++
 drivers/pci/hotplug/Makefile   |   1 +
 drivers/pci/hotplug/gpio_php.c | 200 +++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/gpiophp.h  |  40 +++++++
 4 files changed, 252 insertions(+)
 create mode 100644 drivers/pci/hotplug/gpio_php.c
 create mode 100644 drivers/pci/hotplug/gpiophp.h

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..dbac64ff6915 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -158,4 +158,15 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_GPIO
+	bool "GPIO based PCI Hotplug Support"
+	depends on OF_GPIO
+	help
+	  Say Y here if you want to have GPIO based PCIe hot-plug framework.
+	  This framework helps to register a GPIO based Hot-Plug controller
+	  with the system where a GPIO can be used to represent device
+	  connect and disconnect states.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 5196983220df..70e11d698807 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
+obj-$(CONFIG_HOTPLUG_PCI_GPIO)		+= gpio_php.o
 
 # acpiphp_ibm extends acpiphp, so should be linked afterwards.
 
diff --git a/drivers/pci/hotplug/gpio_php.c b/drivers/pci/hotplug/gpio_php.c
new file mode 100644
index 000000000000..33c8105aade5
--- /dev/null
+++ b/drivers/pci/hotplug/gpio_php.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * GPIO based PCI Hotplug Driver.
+ *
+ */
+
+#include <linux/libfdt.h>
+#include <linux/module.h>
+#include <linux/of_fdt.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include "../pci.h"
+#include "../pcie/portdrv.h"
+
+#include "gpiophp.h"
+
+static DEFINE_MUTEX(slot_mutex);
+
+static inline struct gpio_hotplug_slot *to_gpio_hotplug_slot(struct hotplug_slot *slot)
+{
+	return container_of(slot, struct gpio_hotplug_slot, hotplug_slot);
+}
+
+static int gpio_hp_get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct gpio_hotplug_slot *slot = to_gpio_hotplug_slot(hotplug_slot);
+	struct pci_dev *dev;
+
+	pci_config_pm_runtime_get(slot->pdev);
+	dev = pci_get_slot(slot->pdev->subordinate, PCI_DEVFN(0, 0));
+	if (dev) {
+		pci_dev_put(dev);
+		*value = 1;
+	} else {
+		*value = 0;
+	}
+	pci_dbg(slot->pdev, "Power Status = %u\n", *value);
+	pci_config_pm_runtime_put(slot->pdev);
+
+	return 0;
+}
+
+static int gpio_hp_enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct gpio_hotplug_slot *slot = to_gpio_hotplug_slot(hotplug_slot);
+	int ret = 0;
+	u8 value;
+
+	mutex_lock(&slot_mutex);
+
+	gpio_hp_get_power_status(hotplug_slot, &value);
+	if (value) {
+		pci_info(slot->pdev, "Device is already plugged-in\n");
+		goto exit;
+	}
+
+	if (slot->plat_ops && slot->plat_ops->enable)
+		slot->plat_ops->enable(slot);
+
+	pm_runtime_get_sync(&slot->pdev->dev);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(slot->pdev->bus);
+	pci_unlock_rescan_remove();
+
+	pm_runtime_put(&slot->pdev->dev);
+
+exit:
+	mutex_unlock(&slot_mutex);
+	return ret;
+}
+
+static int gpio_hp_disable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct gpio_hotplug_slot *slot = to_gpio_hotplug_slot(hotplug_slot);
+	struct pci_dev *dev, *temp;
+	u8 value;
+
+	mutex_lock(&slot_mutex);
+
+	gpio_hp_get_power_status(hotplug_slot, &value);
+	if (!value) {
+		pci_info(slot->pdev, "Device is already removed\n");
+		goto exit;
+	}
+
+	pci_lock_rescan_remove();
+
+	list_for_each_entry_safe_reverse(dev, temp, &slot->pdev->subordinate->devices, bus_list) {
+		pci_dev_get(dev);
+		pci_stop_and_remove_bus_device(dev);
+		pci_dev_put(dev);
+	}
+
+	pci_unlock_rescan_remove();
+
+exit:
+	if (slot->plat_ops && slot->plat_ops->disable)
+		slot->plat_ops->disable(slot);
+	mutex_unlock(&slot_mutex);
+	return 0;
+}
+
+static const struct hotplug_slot_ops gpio_hotplug_slot_ops = {
+	.enable_slot = gpio_hp_enable_slot,
+	.disable_slot = gpio_hp_disable_slot,
+	.get_power_status = gpio_hp_get_power_status,
+};
+
+static irqreturn_t pcie_gpio_hp_irq(int irq, void *arg)
+{
+	struct gpio_hotplug_slot *slot = arg;
+
+	if (gpiod_get_value(slot->gpiod)) {
+		pci_dbg(slot->pdev, "Hot-Plug Event\n");
+		gpio_hp_enable_slot(&slot->hotplug_slot);
+	} else {
+		pci_dbg(slot->pdev, "Hot-UnPlug Event\n");
+		gpio_hp_disable_slot(&slot->hotplug_slot);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int register_gpio_hotplug_slot(struct gpio_hotplug_slot *slot)
+{
+	struct device *dev = &slot->pdev->dev;
+	struct pci_dev *pdev = slot->pdev;
+	struct gpio_desc *gpiod;
+	unsigned int irq;
+	char *name;
+	int ret;
+
+	gpiod = devm_gpiod_get(&pdev->bus->dev, "hotplug", GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		pci_err(pdev, "Failed to find GPIO for Hot-Plug functionality: %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_to_irq(gpiod);
+	if (ret < 0) {
+		pci_err(pdev, "Failed to get IRQ for Hot_Plug GPIO: %d\n", ret);
+		return ret;
+	}
+	irq = (unsigned int)ret;
+
+	slot->gpiod = gpiod;
+	slot->hotplug_slot.ops = &gpio_hotplug_slot_ops;
+	slot->irq = irq;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "slot_%u", slot->slot_nr);
+	if (!name) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = pci_hp_register(&slot->hotplug_slot, pdev->subordinate, 0, name);
+	if (ret) {
+		pci_err(pdev, "Failed to register hotplug slot: %d\n", ret);
+		goto exit;
+	}
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "pcie_gpio_hp_irq_%u", slot->slot_nr);
+	if (!name) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = devm_request_threaded_irq(dev, slot->irq,
+					NULL, pcie_gpio_hp_irq,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					name, slot);
+	if (ret < 0) {
+		pci_err(pdev, "Failed to request IRQ for Hot-Plug: %d\n", ret);
+		goto exit;
+	}
+
+	pci_dbg(pdev, "Hot-Plug Slot registered for %s\n", pci_name(pdev));
+
+	gpio_hp_enable_slot(&slot->hotplug_slot);
+
+	return 0;
+
+exit:
+	return ret;
+}
+
+void unregister_gpio_hotplug_slot(struct gpio_hotplug_slot *slot)
+{
+	struct device *dev = &slot->pdev->dev;
+	struct pci_dev *pdev = slot->pdev;
+
+	gpio_hp_disable_slot(&slot->hotplug_slot);
+	devm_free_irq(dev, slot->irq, slot);
+	pci_hp_deregister(&slot->hotplug_slot);
+	devm_gpiod_put(&pdev->bus->dev, slot->gpiod);
+}
+
diff --git a/drivers/pci/hotplug/gpiophp.h b/drivers/pci/hotplug/gpiophp.h
new file mode 100644
index 000000000000..77cc76976e0d
--- /dev/null
+++ b/drivers/pci/hotplug/gpiophp.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * GPIO based PCI Hotplug Driver.
+ *
+ */
+
+#ifndef _GPIOPHP_H
+#define _GPIOPHP_H
+
+#include <linux/pci_hotplug.h>
+
+struct gpio_hotplug_slot;
+
+struct gpio_hotplug_slot_plat_ops {
+	int (*enable)(struct gpio_hotplug_slot *hp_slot);
+	int (*disable)(struct gpio_hotplug_slot *hp_slot);
+};
+
+struct gpio_hotplug_slot {
+	struct device_node *np;
+	int slot_nr;
+	const struct gpio_hotplug_slot_plat_ops *plat_ops;
+	struct pci_dev *pdev;
+
+	struct gpio_desc *gpiod;
+	unsigned int irq;
+
+	struct hotplug_slot hotplug_slot;
+};
+
+#ifdef CONFIG_HOTPLUG_PCI_GPIO
+int register_gpio_hotplug_slot(struct gpio_hotplug_slot *hp_slot);
+void unregister_gpio_hotplug_slot(struct gpio_hotplug_slot *hp_slot);
+#else
+static inline int register_gpio_hotplug_slot(struct gpio_hotplug_slot *hp_slot)
+{ return 0; }
+static inline void unregister_gpio_hotplug_slot(struct gpio_hotplug_slot *hp_slot) {}
+#endif
+
+#endif //_GPIOPHP_H
-- 
2.17.1

