Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4219E77ECDC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbjHPWLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346762AbjHPWKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:52 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7C2705;
        Wed, 16 Aug 2023 15:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+1HjORXII7uy8/EM6/g+yIPKJ4mj0q7YpSnnle30ERqRt/wPmbshVxhqXKgZWDLD0VI6IOEEH4DZFNETBbtN5+VbK0d1h7Zugldn9FlWI7bTPC3XKoFjvrdI8NyXbFAk4hOdc1yZBEYs6JJwqxcuFfCCExVd7iN1ymZXGcP9Vpua5Cd4O2JZFfNDSiS5uGcPB9y/sFOWcQuAxptzRLX7SU1P03BqdFYqNIkHsdwM55yICtJehNVYp4qxjMzs0uaEtWHIeNsTQlFQ9IjkQZRi72ZCEIr2rrLprE7GxZAWyzfLmFpK3aeQKh0j+hIQXa3vs3H+2jqO6keKtwJyyxnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOT/bDPHPcfmfuiAYg/h8hEQjF+5iXFTsYFLQAxyyDs=;
 b=LveWGoZOuXT6buHQsmaI86Ol9ubNc0A9YlI0fYLQbaLhizS7lAmowPIBQjAU+hioPCIxpiQxbYj1xQOxYQU6NIIKrMqW/PWG2QiwX36yxOCPagMmxt4xEeN4xXBK7ZZPTRAseEJ/RuoB0gzZO429AP7/2Y0dJ5LzX0H3FKbvmuc0LM1DTa6fGQu5xuNAIJx7ZvgMfzZlmdMb2jKuX7kUnRhb5j73Ywnjs+ii3llQUk6Kv8lM1WY++Xw5r3GqSOzKOMAmJBSUJvonkWd78+SHNARtt8ryTGZgnOqiI1mb4iR+sSmFmYOTgV6ekljWQiBnFrbcbm1DwSXA3WvTPIuYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOT/bDPHPcfmfuiAYg/h8hEQjF+5iXFTsYFLQAxyyDs=;
 b=KIj3aj292xepIxjuiOfgKhMtFMVke2DavGCQ83IqYkCA6bWr7R+zPUhD+myF+zXkGNPnt5MosVk5TXuz812xKu+KGCHlEmxOQ4uFcFQG2GgEyXgHUujxgv6b67AaRZgKFO2xmyJA/8g3xAHkx5h+FNigV9sxiO/Nvr+IP/6a7+A=
Received: from CY5PR15CA0170.namprd15.prod.outlook.com (2603:10b6:930:81::9)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 22:10:48 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::eb) by CY5PR15CA0170.outlook.office365.com
 (2603:10b6:930:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:45 -0500
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
Subject: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for PCI devices
Date:   Wed, 16 Aug 2023 15:41:43 -0500
Message-ID: <20230816204143.66281-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816204143.66281-1-mario.limonciello@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c71411a-0aa7-4108-bab8-08db9ea5a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BH6MJlzG7o7IXRhDVcNRV+Zj/+eta0tOza/lIZ/BC24I2QFygNO0JU4d3V/z9eaAqxK43EZFz2jy/E8zSbP2bQcmuaJZrOEgDwYYRu2PGNF7Rpu5A9Y+SaEwaxBuAt+fv9cYVMC+LG6EjZixbCZuq7NYIQ4nnap2eHFUfdPkfQ/7s8Sjw11V8bgjB9BMcoa+fwVIXX5TW3M0QedjaMeWmDOB0UxsW+z6JMw7yFc8ziF+eYBGw2tGt/5z8GXrVzVnbhC4MFLpPMSVGrtSRPW8vt/QR9N+YJpVD7Ie4jfWr0jXNUVUzpkwEt41ks53KBpRPNXfPP2liOJsuxYs47eRin6jHolCa9sN622MJ5iMw4QGL7XvTFg0jSb/JW4BojZ1cDs6iTlEyTjEXeu23Jd12r/cZ5RjgVzAmdzOUWnoArBGbSUnjov+514JtQ36GM/skBQxyCtBSOBcFI+WLHY2PGmTG+OtoOhtmFxQjtyWAtA/8CwbBoAB7Qpu4nJWCSOzGePVMI9emrAn4DykB0neeQXvE22lEeWwSSBFmnMM2LDRL1ZEg0W4+TPxyL6DxIHR3zLI248hFJssDeQDiMTsHKHIOm3rmUJgZP7U7YWHIm40AB26kX8vstKXT/NGmPpls5t48aCiNhwh184kKZZtgbljpnulRC2x+0lCUQnFP9SVzuLpHUeHWZeRFFKAQ38ChahCD6itYLdH+2chgO/U0gRt7Jd07RZY/9L3/f7UTCbDY6iAUzOi/GTizCubVmbTjZvP+yzvdQL3C+BHaxEwQ8x+Bp71GxQAbnoU5JV1M98=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(966005)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(45080400002)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:48.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c71411a-0aa7-4108-bab8-08db9ea5a569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
specification [1].

When devices are not considered power manageable; specs are ambiguous as
to what should happen. Linux puts PCIe ports into D3 due to the above
described policy.  Windows 11 uses the PoFX framework to let the an
SOC specific Power Engine Plugin (PEP) [2] [3] [4] to decide what to do
with those devices.

Specifically Microsoft documentation says:

```
Devices that are integrated into the SoC can be power-managed through
the Windows Power Framework (PoFx). These framework-integrated devices
are power-managed by PoFx through a SoC-specific power engine plug-in
(microPEP) that knows the specifics of the SoC's power and clock controls.
```

Effectively this causes PCIe root ports on a variety of AMD systems to be
put into D0 on Windows 11 but D3 on Linux.

Instead of only using constraints for debugging messages use them to
enforce that PCI devices have been put into the expected state when
the system is being put into s2idle.
* If a device constraint is present but disabled then choose D0.
* If a device constraint is present and enabled then use it.

Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-power-management#device-power-management-in-windows [4]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 51 ++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 8bda45579d44a..5192a7147655d 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -300,28 +301,61 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
+{
+	pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
+
+	if (pdev->current_state == target)
+		return;
+
+	/* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
+	if (target == ACPI_STATE_D3_HOT &&
+	    (pdev->current_state == PCI_D3hot ||
+	     pdev->current_state == PCI_D3cold))
+		return;
+
+	if (pm_debug_messages_on)
+		acpi_handle_info(entry->handle,
+				 "LPI: PCI device in %s, not in %s\n",
+				 acpi_power_state_string(pdev->current_state),
+				 acpi_power_state_string(target));
+
+	/* don't try with things that PCI core hasn't touched */
+	if (pdev->current_state == PCI_UNKNOWN) {
+		entry->handle = NULL;
+		return;
+	}
+
+	pci_set_power_state(pdev, target);
+}
+
 static void lpi_check_constraints(void)
 {
 	struct lpi_constraints *entry;
 
 	for_each_lpi_constraint(entry) {
 		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
+		struct device *dev;
 
 		if (!adev)
 			continue;
 
+		/* Check and adjust PCI devices explicitly */
+		dev = acpi_get_first_physical_node(adev);
+		if (dev && dev_is_pci(dev)) {
+			lpi_check_pci_dev(entry, to_pci_dev(dev));
+			continue;
+		}
+		if (!entry->enabled)
+			continue;
 		acpi_handle_debug(entry->handle,
 			"LPI: required min power state:%s current power state:%s\n",
 			acpi_power_state_string(entry->min_dstate),
 			acpi_power_state_string(adev->power.state));
 
-		if (!adev->flags.power_manageable) {
-			acpi_handle_info(entry->handle, "LPI: Device not power manageable\n");
-			entry->handle = NULL;
-			continue;
-		}
-
-		if (adev->power.state < entry->min_dstate)
+		if (pm_debug_messages_on &&
+		    adev->flags.power_manageable &&
+		    adev->power.state < entry->min_dstate)
 			acpi_handle_info(entry->handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
 				acpi_power_state_string(entry->min_dstate),
@@ -512,8 +546,7 @@ int acpi_s2idle_prepare_late(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
+	lpi_check_constraints();
 
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
-- 
2.34.1

