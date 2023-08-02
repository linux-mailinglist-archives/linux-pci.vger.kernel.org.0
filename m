Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81A76D869
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjHBUKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjHBUKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 16:10:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2071734;
        Wed,  2 Aug 2023 13:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz2St7KdlFn0PmDQvdMqdmyAFs1wLrNbg1iae8hfH7/+xGacn3qcbRc42r/1qokHlVMHGr2M6MFWKBI5kjGZ5hz7m8Gqp9nsSnvx5MpwQycaavGCcF4kOvopR2KaP9Cxiu4Oo5YnPTevtDx+DlH75/KVx5JYk5yn+m9v8bV1zVmmU+Ol1XBfLzZTEL4vOnOD6H3nOZAZUl6gRufBNT4OV/dCLxV4lRRAyA6qIzK7zrRrjmfsM+Be1e/TTfYPdnC37/mjamqE7BRvwfjCc/N0q4MjKRxc5mrpnXuZzHSIicsO/fHAERd12jRjyEVZgC/Dok6Xwc6Z6tRdwSueFHHHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPMfbYgRS7/o9DUVQZ2uly5uA9Rb4iMXgTZF2x17Yc8=;
 b=igU1YXCHNPMPxmurtBLnunoGEVweJVqK3Qpr+tL7CNssTaLInOyIiFl2EVK/RI+dnUZ25C/Z3PFQU5tuj3HwjYxVY/0FkIqS2AE1erXXqx7NU+3lk3NvFZWJLpvjyqLz8JsruuR2NuO7kBsIF/PPeW75JaWkJdXayA3M1vBgKEZw4lmtURyHmEALswGeAR2OVs8DOKa3snfjRVc/S+xDWHAbisZJP3Jvyb86jWMrny/DXSf4SQDoCgSh3GL06mqYrEyf2Yii0jnrtDR51347tY90Nm3nmRuv5P1bdPp9aHj2H6HfdWDhfMsXgK75nRdkBBi3/5COCT9hjT4fhnqaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPMfbYgRS7/o9DUVQZ2uly5uA9Rb4iMXgTZF2x17Yc8=;
 b=HHwaBLZiJs2/+yCrdwcja+bzevc38711FuyYb64CKJGwKPSKPaI0lOVKOIYRDMkfELv8sWJmLE+WKt4Bi8FrQTTQibFgUKTTbuYwJdkZ2TCy7HSKJXYqIyBvT2+Jf8+r5vKeByVa5n+w9lISFVgeINhJNKm68z2JPPVdNPnnhS0=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 20:10:42 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e9) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 20:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 20:10:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 15:10:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates to opt devices into D3
Date:   Wed, 2 Aug 2023 15:10:13 -0500
Message-ID: <20230802201013.910-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802201013.910-1-mario.limonciello@amd.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 91afcb88-e95b-4096-4e9c-08db93948ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUZxPDpB61v/OEShB5JEkjFN8AamgBLRdN7PFiD20eHoUQd01OKfWNFY/ouYCjnHP6Ej18Ql2drJxC7fqVfr8S8fOR9L1QzPAeDtFvL5+XnsySrprNM4qBllxq7qcvZqP4H3c0E0p0MXBmF1bj1T8ZqIxMZKB30SQp4z/CF+TJUpELehrMuTMyXhCC698vfkjmihwFmNRxD++fS6a01j/yzxJTr1uc8NabJeJlCwEimaPG9FM0bwS8oseCreQ3qsQrquWPoaQmRiNPWH6StXayl6MYcVT8KBzHhvGU3R3bnfqStTFbCQYw3L5HalBlSDVWZmb9PA0bLoWidIt8wJw6M0WakaNllZdyODc2ta4zfdpeD72ciYGKW70ndp7KwhcS9+4wiZyJZyAYFLMfR7MIa+BhXYxHZ9iGGoql7vV5+LLlBCiV3y/blR6y4BgfD7QvMZEnUCC0RQDhXGBUGqd5L8hXNpjNnZo6OjA3lnylgTakXKjIvCTKQCrUCtiWw9uUGBET/lusbSbP3wuN5weZiW9ZOF0P/chwPPfW0mkDCJ9LV0YTE1SzS0AyI3HtMOm0tTik8Um5Ruxl+hozMSge4c/yhjhOWp1km+GG9yaY/M0wua1FnE0sAkGAismH6Lrg37IWkh2vH3iRu70igKTsd3OhAgM7G/1VNmGJgVUgZqcQM+7nMq8gX8bLwh1SZlfYdlC4xzkjYS7UCgJlTgc8XU09Lhg3wac6JHN68DMYleGZqaQBf7Bp4QERPzMafcr7fHBRl++TfMsSH7DGAGxHTjmaUDke1LFIdsUgFo+NE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36756003)(86362001)(40480700001)(478600001)(966005)(6666004)(7696005)(8936002)(8676002)(41300700001)(316002)(5660300002)(44832011)(4326008)(40460700003)(36860700001)(83380400001)(110136005)(54906003)(47076005)(2906002)(70586007)(70206006)(426003)(1076003)(26005)(81166007)(82740400003)(2616005)(336012)(356005)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 20:10:40.8713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91afcb88-e95b-4096-4e9c-08db93948ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
storing a value to the `bridge_d3` variable in the `struct pci_dev`
structure.

pci_power_manageable() uses this variable to indicate a PCIe port can
enter D3.
pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
decide whether to try to put a device into its target state for a sleep
cycle via pci_prepare_to_sleep().

For devices that support D3, the target state is selected by this policy:
1. If platform_pci_power_manageable():
   Use platform_pci_choose_state()
2. If the device is armed for wakeup:
   Select the deepest D-state that supports a PME.
3. Else:
   Use D3hot.

Devices are considered power manageable by the platform when they have
one or more objects described in the table in section 7.3 of the ACPI 6.5
specification.

When devices are not considered power manageable; specs are ambiguous as
to what should happen.  In this situation Windows 11 seems to leave PCIe
root ports in D0 while Linux puts them into D3 due to the above mentioned
commit.

In Windows systems that support Modern Standby specify hardware
pre-conditions for the SoC to achieve the lowest power state by device
constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
They can be marked as disabled or enabled and when enabled can specify
the minimum power state required for an ACPI device.

Instead of using a time based heuristic to decide if a port should go
into D3 use device constraints to decide.
* If the constraint is not present or disabled then choose D0.
* If the constraint is enabled, then enable D3 if the constraint is set
  to 3 or greater.

Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7->v8:
 * Use device constraints instead
 * Update commit message and links
---
 drivers/acpi/x86/s2idle.c | 28 ++++++++++++++++++++++++++--
 drivers/pci/pci-acpi.c    | 19 +++++++++++++++++++
 drivers/pci/pci.c         | 15 ++++++++++-----
 drivers/pci/pci.h         |  5 +++++
 include/linux/acpi.h      |  6 ++++++
 5 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605e..60f681fa05ed3 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -133,7 +133,7 @@ static void lpi_device_get_constraints_amd(void)
 					union acpi_object *obj = &info_obj->package.elements[k];
 
 					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
+					list->min_dstate = -EINVAL;
 
 					switch (k) {
 					case 0:
@@ -244,7 +244,7 @@ static void lpi_device_get_constraints(void)
 		acpi_handle_debug(lps0_device_handle,
 				  "index:%d Name:%s\n", i, info.name);
 
-		constraint->min_dstate = -1;
+		constraint->min_dstate = -EINVAL;
 
 		for (j = 0; j < package_count; ++j) {
 			union acpi_object *info_obj = &info.package[j];
@@ -291,6 +291,30 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+/*
+ * acpi_get_lps0_constraint - get any LPS0 constraint for an acpi device
+ * @handle: ACPI handle of the device
+ *
+ * If a constraint has been specified in the _DSM method for the device,
+ * return it.  Otherwise, return -ENODEV.
+ */
+int acpi_get_lps0_constraint(struct device *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	int i;
+
+	if (!handle)
+		return -ENODEV;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		if (lpi_constraints_table[i].handle != handle)
+			continue;
+		return lpi_constraints_table[i].min_dstate;
+	}
+
+	return -ENODEV;
+}
+
 static void lpi_check_constraints(void)
 {
 	int i;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49cb..40900754404ff 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,25 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+/*
+ * acpi_pci_device_constraint_d3 - determine if device constraints require D3
+ * @dev: PCI device to check
+ *
+ * Returns true if the PEP constraints for the device is enabled and
+ * requires D3.
+ */
+bool acpi_pci_device_constraint_d3(struct pci_dev *dev)
+{
+	int constraint = acpi_get_lps0_constraint(&dev->dev);
+
+	if (constraint < 0) {
+		pci_dbg(dev, "ACPI device constraint not present\n");
+		return false;
+	}
+
+	return constraint >= 3;
+}
+
 static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
 {
 	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..dce313cd3b8f0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline bool platform_constraint_d3(struct pci_dev *dev)
+{
+	if (pci_use_mid_pm())
+		return false;
+
+	return acpi_pci_device_constraint_d3(dev);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (dmi_check_system(bridge_d3_blacklist))
 			return false;
 
-		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
-		 */
-		if (dmi_get_bios_year() >= 2015)
+		/* the platform indicates in a device constraint that D3 is needed */
+		if (platform_constraint_d3(bridge))
 			return true;
 		break;
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..2162f243bcc25 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
 bool acpi_pci_power_manageable(struct pci_dev *dev);
 bool acpi_pci_bridge_d3(struct pci_dev *dev);
+bool acpi_pci_device_constraint_d3(struct pci_dev *dev);
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
 void acpi_pci_refresh_power_state(struct pci_dev *dev);
@@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	return false;
 }
+static inline bool acpi_pci_device_constraint_d3(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0d5277b7c6323..353c0b910c2cd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1109,6 +1109,12 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+int acpi_get_lps0_constraint(struct device *dev);
+#else
+static inline int acpi_get_lps0_constraint(struct device *dev)
+{
+	return false;
+}
 #endif /* CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
-- 
2.34.1

