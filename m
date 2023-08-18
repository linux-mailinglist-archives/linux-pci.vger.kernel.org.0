Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECC780584
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbjHRFPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356521AbjHRFPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDED26A8;
        Thu, 17 Aug 2023 22:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLQ7ed/+00mE+7yMQAXAwTOmM3HSt+L0/q+apUkPQnZDMCE0Rhj/AoPCeRDeHmD7kUmWtbMoRJIXH7UpQE8VeFqCvQeroelO9rS6AwMXmscL+SpAEafP89LLFBYRRMu6nTvV1RlBXJatSci54be+8su5Ozbw5sFvaUZqc6A2AjtDEZCBPj3byWFZciEyjfGSSDK2KHPULv1KBhWfRmOs1ve5PC3RxeL4DYG8bWXw7A5B8I8G7OXrx25CPXWFtlus94peOPtqh7YHa7zJBvOOlCrknVeTbwfTQhtCp+sJWNg2TDSrzaOSHF9dqs6nSUJP+vO6kKLpGtcbyed22BGtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/GLBpTALHfSqTaJk2XKOp4/BksOjAi5Q1lEo7YK8fw=;
 b=Qt1N2qjcQWW4+fcEXKHq9fGg7WwhLwkw3+gVGaPpPKgn6DdGOddKxAUGmh62tOpzcvfhC3TVqRDZglj96ccGZeeEeR9t0IVHex2yZtXcQCPXS1LED7yuqia9qnBgUFOhp+/NF5gmf5lJG29Oq4e9lvV4QlJUO4R1Ptr4R2J4aveHs2qkYMXfUa0s1vn69j9qqUOZ0A3H3AF9uN9PJAF8JX4PYdvm67/K3dD1x79J4cRN4s1tuq2ZG0y4SMoBAYU/Br51/NKQljMWUFDV2L2E32WeiIVvdsfwJHOCg2He0q90CTLBK8ArvxAplMDKUEargDolgt3/A+4xChI+zarFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/GLBpTALHfSqTaJk2XKOp4/BksOjAi5Q1lEo7YK8fw=;
 b=QMdR7UtsS9SkEuYWerrBs9Er0gph2R8TNS9seFkylWXWiHR1ossAvJCc3HErvhTLXC+NZwJ2mrDqJMnA+CWh5qxLtPCJ8kQrtBB5WfVBvuOnr1TgDdTSpxIe5S6pPj7Vna2fM9BFlDeu44EExE3FEGZB7JPPzJ50nfD644nxnyE=
Received: from SN7PR04CA0206.namprd04.prod.outlook.com (2603:10b6:806:126::31)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 05:15:08 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::51) by SN7PR04CA0206.outlook.office365.com
 (2603:10b6:806:126::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:15:08 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:15:06 -0500
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
Subject: [PATCH v13 11/12] PCI: ACPI: Use device constraints to opt devices into D3 support
Date:   Fri, 18 Aug 2023 00:13:18 -0500
Message-ID: <20230818051319.551-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818051319.551-1-mario.limonciello@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d6738d-c21b-47c6-059f-08db9faa172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRVwmhQLwmUE9PkHdyQdvA4DVZ1OzCosKlYZWaLHUhzGaLqF0K4dpoC5tpaVYNqsWY/cncPqCZe942Qo7lNrcIkNbwuEVzNWYl7tZppMOgyuRcRfgV4TUFJrCeQa2Rmq1w3r4GXnYmy49I4hc8/5BYWqJSk4ScwAHwDSd66P13yX0p+KgKvDhmpsLzOb3pyVSsYocSG51Yao01VUT8eVGJVJLmC3ByyI9wPo/ilk89HHYHdzRXKKXzX3lP5CZR484TddiSoF4MzdFQetPvtaxXLs5scHTCPIlWf4rnR7zm18ro6YHgiCttBHLt41Px5dUEGv8CGe5uYQQ4DDVEbxrCpcoB8Fp3nBjHw3rQcBOpAVI+9pBkXl8PDRTOeQDS7GYFyv8BRlBdsLvBE2W46TKKxmCaYFwkDm5PPodkJic1K2XCq2p4VXnzzi8Ku9dR6cl3f4iHfaKphZEw8gBJA1jgvkeHRhMR64pAGrsSbf5o0Z0RfhQ00UzsX+fsrbvcOlwvDyOvoX/nNFzee9JLFHYo1zfS+0G9xZLOkZTlQVbTMuqrBpwjuWKds0A1vnVg/N2izkMRXuJAvUJ95ZQX3Mtuve6pgSne3vMoej+AzI3pu7wNug4INr025Lqvb/rvQWlrs88A4drCiT031zkvvadJNSC3Wyp5aLg9MBZHMe7iMEs+hpqaaXfzVIzs1ppYWlTalE7bgcXnhhQkfcXV0wbcsDKBk8nL8WrwDGVKtbKkD+bOqMVd6v35fMw4ojF6d5Eoh1xqNf6zylRWjxN+m7CW1k2S9ob5+ShCpVYLByIfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(7696005)(6666004)(2616005)(1076003)(36756003)(16526019)(966005)(44832011)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(316002)(110136005)(4326008)(8936002)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:08.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d6738d-c21b-47c6-059f-08db9faa172c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Windows, systems that support Modern Standby specify hardware
pre-conditions for the SoC to be able to achieve the lowest power state
by using 'device constraints' in a SOC specific "Power Engine
Plugin" (PEP) [1] [2].

Device constraints are specified in the return value for a _DSM of
a PNP0D80 device, and Linux enumerates the constraints during probing.

In cases that the existing logic for pci_bridge_d3_possible() may not
enable D3 support query for any constraints specified by the device.
If the constraints specify D3 support, then use D3 for the PCI device.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * Move back to PCI code
 * Trim commit message
v11->v12:
 * Adjust for dropped patch 8/9 from v11.
 * Update comment
v10->v11:
 * Fix kernel kernel build robot errors and various sparse warnings
   related to new handling of pci_power_t.
 * Use the new helpers introduced in previous patches
---
 drivers/pci/pci-acpi.c | 14 ++++++++++++++
 drivers/pci/pci.c      | 12 ++++++++++++
 drivers/pci/pci.h      |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b5b65cdfa3b8b..bcc76e9d399c5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1081,6 +1081,20 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+/**
+ * acpi_pci_check_d3_constraint - Check if device specifies a D3 platform constraint
+ * @dev: PCI device to check
+ *
+ * This function checks if the platform specifies that a given PCI device should
+ * be put into D3 to satisfy a low power platform constraint
+ *
+ * Returns: TRUE if constraint for D3hot or deeper, FALSE otherwise.
+ */
+bool acpi_pci_check_d3_constraint(struct pci_dev *dev)
+{
+	return acpi_get_lps0_constraint(&dev->dev) >= ACPI_STATE_D3_HOT;
+}
+
 static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
 {
 	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 051e88ee64c63..0fc8d35154f97 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline bool platform_check_d3_constraint(struct pci_dev *dev)
+{
+	if (pci_use_mid_pm())
+		return false;
+
+	return acpi_pci_check_d3_constraint(dev);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -3036,6 +3044,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (dmi_check_system(bridge_d3_blacklist))
 			return false;
 
+		/* the platform specifies in LPS0 constraints to use D3 */
+		if (platform_check_d3_constraint(bridge))
+			return true;
+
 		/*
 		 * It is safe to put Intel PCIe ports from 2015 or newer
 		 * to D3.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..ac06c781a9b7c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
 bool acpi_pci_power_manageable(struct pci_dev *dev);
 bool acpi_pci_bridge_d3(struct pci_dev *dev);
+bool acpi_pci_check_d3_constraint(struct pci_dev *dev);
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
 void acpi_pci_refresh_power_state(struct pci_dev *dev);
@@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	return false;
 }
+static inline bool acpi_pci_check_d3_constraint(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	return -ENODEV;
-- 
2.34.1

