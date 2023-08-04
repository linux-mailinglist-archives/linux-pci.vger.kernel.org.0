Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D54770A51
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHDVCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHDVCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:02:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE94ECF;
        Fri,  4 Aug 2023 14:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0dbideA9pr1+wlfb8IXzss3QfEfnSpTUKIrfcK5BfELVmv6MGNSBt1pxbAS5GcSYooKm7rxKpTrcTcYG0VhLwivXtqqjNxh5xCvxFUqEWwt0OUZ5wa+quPN8Z466O7cxIm0IWxa4Dc0B215XR7I4Xsdyy3h72IACKuhtiPq6X1w3S/zsctG5gyC/39UtJkSgSH5RIWCTwp8r4OUvM7Oc+va9EatMdx7JLty1/GjxquZXGgUU5QZN+2E4Skb+QAuJHrJWxyav5/7SIud2P1Ep948IGn5+FARoMzGmVWyBDchLN28dM8Dsc8NAt5ca+09iECYOUmyUueXv6cWDiZzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVzSB8XhG7EkculefJ5zANMspQtK8AhiENAPpnu4IMs=;
 b=c8Itve3125iFjcYqnEtS/V5VNOzfpsWdEVIGV4iLfWkIyJbSV4ahXP5LToeajpYSHsN3x1T+qnqBSpO5fVSBnGzkR1tmy5KieRX7HyqLoJ1oZguzjCS/z1olLb2+Dd2IBf900finbCUZHvqSrhOkzgvNuz8+jYdnHUcn2QILvLXnRHtGTY26mBYouI3J5qkyoQjcg2t5R/wkUh3r3mIbEyGKq8/uqXl8yQ6BmDWiY2uWOt0W/k4yTVICcQtId5qYGKtyBounlMoWPYuTAPFeMmzBPGbBpidzIObBJGSr1tzM9Sm/uOy7cIAFgEku6qTLhZuc7P3PDojtlLYhzueo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVzSB8XhG7EkculefJ5zANMspQtK8AhiENAPpnu4IMs=;
 b=GEZEizw5IjfxUW5cb5SK4uVPCHMlKi5U0Bc2HEOAYb0Hl+TBTz1d1ZH+1xk5a29cvTqhdX/NkQGbboeBuCaabTpRqzaljFaVuEENgqMRm1CHC11OVBOAuMBHR+5M3QCoCRhc3kvd3/uyKv/bptWhvxo7Ap/hTtR5KFrnU+mvgRc=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:01:50 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::8d) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:49 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:48 -0500
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
Subject: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target state fallback policy
Date:   Fri, 4 Aug 2023 16:01:29 -0500
Message-ID: <20230804210129.5356-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804210129.5356-1-mario.limonciello@amd.com>
References: <20230804210129.5356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: be9ce5ce-d491-4873-8e3e-08db952e05b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Q8yLEn4KTH2hgcJUhWl+OFhNZ1OoClzypJnSk+GlVP2JYmWIkov8r7l0FcGX3h7KqG00+mO6H7mLq58q80efBWrIoASgqXW4H+bT72crYgW9vGg7JTmodn0oJ/A+8xeq4oZ9mV1U4km8i1EDOBebRVpduZe+jK2mXALcaWryWvcS9/OctzMbpGbO9S4srNAaB3eZmaWNGy9RA4JZNqo1vK8uUe6BBuXA+LMZye18MC/KkzHCWV5pH5AP23fj89VbILrEEzB5cD3PpeT3W9JDRTqwp1Hs+P0il7ru64WeUmjRu9CTGzzaAdP9UkDYyGrWdkAmCcXDOxodBC0TevqgU+P6QgZETwLJSaT0WF8507bktkK8h9XKUTkcI6dHpEF9rYxk1hwxiilD9651DPi5up2fcpWWqjaheLfaVjE+vr/iUrg13+2qUJkhGr6yorbMldEcPZ/3EBOB/J7wygYqE+GOuW+TiuJ2/wORVBuTQuhid19C0E/ypK2TZMqwGlxc3sQt4s4ttYAwhEZlboeMJbUnTd2pROh1JoUR4L4TMwuQVEttr3VCa/QuyRVHMMS4srDQnw5RsBSSNugV6wzJErYV5qOf49kw7jkTnWd4mvIee4L9BroDzTBnekamQlimZVXmhjnzUBGaAMHKO6JRde1chnkuRA9KaR80ZFxKbYSKKgk2XGtfcenslECHyZ+q22pmkxz+ty2WjuyPp3yk6QOTOwZhNBfR3xTMXbSeFgz0FnRRFKMGrzG2lWdzlLPyO8ODloOOVbPV/wC6fP4SW49A3DqXeXeayQVU6v/t70=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(82310400008)(1800799003)(186006)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(16526019)(2616005)(1076003)(26005)(8676002)(47076005)(4326008)(2906002)(36860700001)(316002)(426003)(70586007)(81166007)(5660300002)(70206006)(40480700001)(44832011)(8936002)(41300700001)(6666004)(966005)(7696005)(110136005)(478600001)(54906003)(356005)(36756003)(86362001)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:49.8716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ce5ce-d491-4873-8e3e-08db952e05b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
v9->v10:
 * kerneldoc fixes
 * split into more patches
 * adjust return variable handling
 * Adjust call-site to avoid problems for devices already in d3cold
---
 drivers/pci/pci.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..108eacc4f8dd9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline int platform_get_constraint(struct pci_dev *dev)
+{
+	if (pci_use_mid_pm())
+		return -ENODEV;
+
+	return acpi_get_lps0_constraint(&dev->dev);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -2660,6 +2668,20 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 }
 EXPORT_SYMBOL(pci_wake_from_d3);
 
+/*
+ * Find the deepest state from which the device can generate
+ * PME#.
+ */
+static pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
+{
+	pci_power_t state = PCI_D3hot;
+
+	while (state && !(dev->pme_support & (1 << state)))
+		state--;
+
+	return state;
+}
+
 /**
  * pci_target_state - find an appropriate low power state for a given PCI dev
  * @dev: PCI device
@@ -2671,6 +2693,8 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
+	pci_power_t constraint;
+
 	if (platform_pci_power_manageable(dev)) {
 		/*
 		 * Call the platform to find the target state for the device.
@@ -2701,23 +2725,20 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 	else if (!dev->pm_cap)
 		return PCI_D0;
 
-	if (wakeup && dev->pme_support) {
-		pci_power_t state = PCI_D3hot;
+	/* if platform indicates preferred state device constraint, use it */
+	constraint = platform_get_constraint(dev);
+	if (constraint < 0)
+		constraint = PCI_D3hot;
 
-		/*
-		 * Find the deepest state from which the device can generate
-		 * PME#.
-		 */
-		while (state && !(dev->pme_support & (1 << state)))
-			state--;
+	if (wakeup && dev->pme_support) {
+		pci_power_t pme_state = pci_get_wake_pme_state(dev);
 
-		if (state)
-			return state;
-		else if (dev->pme_support & 1)
-			return PCI_D0;
+		/* pick the lesser of any specified constraints */
+		if (pme_state < constraint)
+			constraint = pme_state;
 	}
 
-	return PCI_D3hot;
+	return constraint;
 }
 
 /**
-- 
2.34.1

