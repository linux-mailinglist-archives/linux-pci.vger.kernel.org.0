Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE276F873
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHDDn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjHDDnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 23:43:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962794219;
        Thu,  3 Aug 2023 20:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC+X5jB1iOk9Hp5Rlq4EUZSVxGn3yaZNCYfD/G3vaWQ1cBgRQVCT2ni71w75kFdd7mSc1pVXZzKVjESVYgTorP4EK4OY4Var17mIzLR1Uo8k2DoUt/9tEPLOnfFAtsqzWP8j7S22sN9gRULvxqQFkJRgSxc5/8lVmk6g6gkjL5sjysg8QhiftizY/JD/rNlJmuciMlDRzPEIuXoy1j/W4lxvMx1GhzdaeyYO5zSVNJsStixXRMezL75wC8SAPblgxgH9nkTX9lUYQs1X76ldBmUR4sCOZ/NFMQkSFRsMNgL+vjuEt3B6ier4GpuPSxAcruX1fyz7lRfzL9XtsGldxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWAuQpJfuKQnyXal3hynJoRUMAvfqfp7TTBdzgQZnqU=;
 b=jdfH2XyJ9C5y/w2k+5pZf3JGvhPazBjCBo3dLN4n+FcJaGRGu4d6+rxYBIt40ILG2XDqg6w+Fc9nxBnv13QZynADlweWeD61/iKXtycx0HY8SrwJkX/XbGiLVcMSaxZ3QKEWz2mgh7kwVW2jru6ORXqJ4i/vjJzQiC8rXSJyIJUBORrG/ek4N2i21gAREcCxwvyHSBcDl9fnxzq4H0xFo0u7zyeRwyPq0UYi+9LNlSv/ytEGVrboNRI9bUsoBtb6HdDU1WffTP4L2zDmXmw8pH/nrJ7aJk+sj131kN3xQudHnqio+mbSMUUMuRDjzQQdu1s5PqNJPu4kfgO3u3ZDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWAuQpJfuKQnyXal3hynJoRUMAvfqfp7TTBdzgQZnqU=;
 b=XSvjBF+RG8H1Djv5ibdC5dA+Ad+UIXRW32IF5zkBoMvKSy7EfzjNDoJZ9rpwrHYlNztf7MO99veKub7mjoh5LD/kzE3CGhpIao5JpAtFXrSP4Yax1iFwyCOCxzfFb+Gk52CS/3QYK8VQR4BLPLSfmPFTStmxQmzKFqrUyMMo5AI=
Received: from CY5PR19CA0046.namprd19.prod.outlook.com (2603:10b6:930:1a::20)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 4 Aug
 2023 03:43:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::f4) by CY5PR19CA0046.outlook.office365.com
 (2603:10b6:930:1a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 03:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 03:43:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:43:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI target state fallback policy
Date:   Thu, 3 Aug 2023 20:02:29 -0500
Message-ID: <20230804010229.3664-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804010229.3664-1-mario.limonciello@amd.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 121b03fc-b9a6-47de-b002-08db949cfaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRM09h+GocxDDwkEkGlb4zILNYidUQlpd2hsVJVugnuMm7lEWei7hOfe85PKfrN0S5Wjeq+LF8/+BOxciScbIdye5lIt/2QUw8fL80IKHWGVHyyydEkfzOn3Uo8D+jIVMoZ4E9sFpHjdW8Pg2LC/uGje0qKWcroYCezeO24iPy3xTnqcFAiWmf1fPtFzL7yDyeZmzc27rtOCMwvODy+Jwy5KOTSpG8esNWCeKbSWmG8IjKe3aYqp/TZSy73vZU5UThahUb1RunMzd+CIkOLgXfUdsm/Ra2glQZzYMzVKUtE3o2ssMUbZGKgXJ7wYMqhErNDfXL2pzKq8uybiJI+P+4LmAB5/sQMdK1tsCN5wnDCBFA1Rz3JnqHZwgznwpta9P0H/go+CzcRDQrjyjcbHiPOFarYekc1wbqMJuzmTgUBJlSEb72Nv2xUWtOgM74rry11icpVbQaMgcH4HOyk8WW1sUKsnEo1Y0Y9t5pWIs3wEtz6F+QdaOiYSXYwxiQFF3Bt+4SKl1Uwk/uJaC16Eli6bLWcNhpkFh0RIHZo5a3JVPYdj8sNnnd5fS9nPdO7ejuKaTjHBCP+7WNcbq8uTyQ9zxz3QVBSbIvZXnV5bJ8LxqMg/0EHVg/WUuK+ZLER8Vgp5x5X5UC6g3MNZKRu+cYa8BZMOY7+ggbYYmG3b3jm80nAQSFxGeQ8rlt3pi10/GE/DyEbo+ObRHXUUul31oRmTp0J4UFGUeGr3TvTpqdi++/L9t1/mJOgt6Cak3pdTo2jFGbiZWkLj7nwwepvneG4KGtVXFslh8Hne8KCp2Fs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(1800799003)(451199021)(186006)(46966006)(36840700001)(40470700004)(47076005)(1076003)(7696005)(966005)(6666004)(54906003)(478600001)(110136005)(41300700001)(2616005)(81166007)(336012)(44832011)(16526019)(70586007)(5660300002)(356005)(2906002)(4326008)(8676002)(316002)(82740400003)(8936002)(70206006)(86362001)(36756003)(36860700001)(83380400001)(40460700003)(40480700001)(426003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 03:43:34.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121b03fc-b9a6-47de-b002-08db949cfaf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
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
to what should happen.  In this situation Windows 11 leaves PCIe
ports in D0 while Linux puts them into D3 due to the above mentioned
commit.

In Windows systems that support Modern Standby specify hardware
pre-conditions for the SoC to achieve the lowest power state by device
constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
They can be marked as disabled or enabled and when enabled can specify
the minimum power state required for an ACPI device.

When it is ambiguous what should happen, adjust the logic for
pci_target_state() to check whether a device constraint is present
and enabled.
* If power manageable by ACPI use this to get to select target state
* If a device constraint is present but disabled then choose D0
* If a device constraint is present and enabled then use it
* If a device constraint is not present, then continue to existing
  logic (if marked for wakeup use deepest state that PME works)
* If not marked for wakeup choose D3hot

Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8->v9:
 * Use device_match_acpi_handle instead
 * Move the logic to run at the state selection time
 * Small fixups suggested by Andy
 * Call from pci_target_state() instead
v7->v8:
 * Use device constraints instead
 * Update commit message and links
---
 drivers/acpi/x86/s2idle.c | 23 +++++++++++++++++++++++
 drivers/pci/pci-acpi.c    | 22 ++++++++++++++++++++++
 drivers/pci/pci.c         | 14 ++++++++++++++
 drivers/pci/pci.h         |  5 +++++
 include/linux/acpi.h      | 10 ++++++++--
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index cb2ea92af3eb7..c0e2c82e9ef63 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -293,6 +293,29 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+/**
+ * acpi_get_lps0_constraint - get any LPS0 constraint for a device
+ * @dev: device to get constraint for
+ *
+ * If a constraint has been specified in the _DSM method for the device,
+ * and the constraint is enabled return it.  If the constraint is disabled,
+ * return 0. Otherwise, return -ENODEV.
+ */
+int acpi_get_lps0_constraint(struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		if (!device_match_acpi_handle(dev, lpi_constraints_table[i].handle))
+			continue;
+		if (!lpi_constraints_table[i].enabled)
+			return 0;
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
index a05350a4e49cb..499dcb7fa3651 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,28 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+/**
+ * acpi_pci_device_constraint - determine if the platform has a contraint for the device
+ * @dev: PCI device to check
+ * @result (out): the constraint specified by the platform
+ *
+ * If the platform has specified a constraint for a device, this function will
+ * return 0 and set @result to the constraint.
+ * Otherwise, it will return an error code.
+ */
+int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
+{
+	int constraint;
+
+	constraint = acpi_get_lps0_constraint(&dev->dev);
+	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);
+	if (constraint < 0)
+		return constraint;
+	*result = constraint;
+
+	return 0;
+}
+
 static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
 {
 	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..6c70f921467c6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline int platform_get_constraint(struct pci_dev *dev, int *result)
+{
+	if (pci_use_mid_pm())
+		return -ENODEV;
+
+	return acpi_pci_device_constraint(dev, result);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -2671,6 +2679,8 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
+	int val;
+
 	if (platform_pci_power_manageable(dev)) {
 		/*
 		 * Call the platform to find the target state for the device.
@@ -2691,6 +2701,10 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		return state;
 	}
 
+	/* if platform indicates in a device constraint, use it */
+	if (!platform_get_constraint(dev, &val))
+		return val;
+
 	/*
 	 * If the device is in D3cold even though it's not power-manageable by
 	 * the platform, it may have been powered down by non-standard means.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..8001f34ec535b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
 bool acpi_pci_power_manageable(struct pci_dev *dev);
 bool acpi_pci_bridge_d3(struct pci_dev *dev);
+int acpi_pci_device_constraint(struct pci_dev *dev, int *result);
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
 void acpi_pci_refresh_power_state(struct pci_dev *dev);
@@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	return false;
 }
+static inline int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
+{
+	return -ENODEV;
+}
 static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0d5277b7c6323..024075cce09e5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#ifdef CONFIG_X86
+#if defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
@@ -1109,7 +1109,13 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
-#endif /* CONFIG_X86 */
+int acpi_get_lps0_constraint(struct device *dev);
+#else
+static inline int acpi_get_lps0_constraint(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

