Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074D777692B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHITsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjHITrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D32C2706;
        Wed,  9 Aug 2023 12:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj5spEmeXGp2RpJ93ybJko6IZg4t4TxlfUReSyeSSlnND1m/Z0IARsNzTBuJi/R7n93aiaXx8wbqASCr80Fc1N8Lq7AZVLYjJ/jFapzgqYlRiJ2lR3mxQx6OBHQPjX0KILIQuSjFuff6JVyn9/PGIJKU83hR85apUOoKwMCTyKVKgs2Qe6586r8ISb0D9wHgy2rF1aNyDdG++JdUN3RxFUt26uV1R5vCXO1N7k5EF8F3xU9AiHWYsM7l8uBy0XgMy4bnPJnc/aNDpS1hsQRshVVMEUxK4lHjqPcFJyEaJU3pWCctaV6CkF6XfChM9ydafF+r1rihTcLzsvq4w2XyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4GfhYTjADv/+HmXUdgNqQPK/J5d9hVs6Fyt8og/gwI=;
 b=B5eTgZyNaxGiv+qAhOKup/KVEUamIwh+2+Pn9KoB0GmnmX01+6+VOudU8odglzZynDF07lLAdaGJQMBsgvXV9Hnlr1OXhXmAsPpK9DSOujhPGdM45euBo/C9DKtPwhom824KCiJhYh4giHozspbADnx/pC6ZNlL5wrZmm2QxxnICAGrNbLDnHIOYbjKkx/MU2KxQkCb6T7PmjA1zV1iQfR948sGf8+92ND/TVg7igQoFIotv7jTk5cfHbuXRuTPrXGVEgquGQOZpi1+nb18iTsXZ7ckZlRKUY46gdgOo65jFRYWVp4KMwz66zireknD8XrPAZq/Nz+x1FKZsPFWF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4GfhYTjADv/+HmXUdgNqQPK/J5d9hVs6Fyt8og/gwI=;
 b=yW1KkATkOp7Cd8XAPvKbqYya49VZg+nUpBZHW1lh77PAeLATyruWG0BUzSfCZ5j0FgviUmMVkGwDok42MajRSKNY8GsRhNMx/dWDnxj4cFYNStvLq4wq6i0JDMggfGYTd4zlEYuOtmAoPxNTP+QIIkED4wzqAsD4eHgCEHcSzmc=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:47:22 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::b9) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:22 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:20 -0500
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
Subject: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI target state fallback policy
Date:   Wed, 9 Aug 2023 13:54:53 -0500
Message-ID: <20230809185453.40916-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809185453.40916-1-mario.limonciello@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d59cd24-ddcc-41d6-6e19-08db9911730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOX3ZvHQ+i/ele5Mpqe7xGQDQotTJeb8OYt352QdUGF9VHIWDFRQJiFaocVYS1o+zVbSuJNXi+rMWHY6t9ssp5hMl0J5Rq6kkQAmxolFc+fpqUA1i9MkOrn7jOA74HDq16ePSVoA3JbwtRvsgSX1Ce3/Bi9PrMhCtv/hIQL547jz8TqenokwBqj975g/hFyv7u0a7iC4yHAEt2pfSMCo0bizQFr8KBpFaMP+1Fb1nX4W1yHkNko+J5r1jNUthppSiQoHg8TLPZfKJYKvf5BxF32CktJWC3m/qVmL2nv8n0PLNQZtloav8OhXFcPbwnrVNFNlFoSe7oZryS1WHwdnmRxficr1p4QHyAjVyAeUFhGigo9fcMyEKFA8uq4yD9s8GgLJl67xgcM3vmt5tYfXdLQBlLyivKKwtdAchKpSzZcc9vdgS+lvvconbM1ZQF0z03AhW22AZhpA9pYf0GgQrNLZlb88EVTADsLnHyqw/uF+Y6ki0wmWB48SokZznXcNLorQtuzz1KNK1mCfcp92ubinSj1zyR1IALXQzMn7VAbtUgIiEUz5F7NPJdcls+aPAXIjwTG5jXoIgKer/83QkFOtT2oHFmPjd0cjBDxeV6LPw1rbOUh2rgNKybhpDKGxstWEVhGqVBa2wFefwm+aqsQRIaEg4v0A2jfpZ92Pc6uucHaNVGKuTXxwTrQh54rnTqd+I0XQqQ8xq3PO0xrhbFdOElFoZlTkO1VWtfLd11l2i+KdnNr7mFpkQ2dr9wJd3qXZBgoLZRDpoPZopyzxKeWrKZdXOGbu8Vzn1h9nwDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(44832011)(316002)(8676002)(8936002)(5660300002)(40460700003)(2906002)(81166007)(356005)(1076003)(82740400003)(26005)(36860700001)(83380400001)(336012)(47076005)(2616005)(426003)(16526019)(36756003)(41300700001)(40480700001)(966005)(86362001)(7696005)(70206006)(6666004)(70586007)(4326008)(478600001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:22.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59cd24-ddcc-41d6-6e19-08db9911730d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
v10->v11:
 * Fix kernel kernel build robot errors and various sparse warnings
   related to new handling of pci_power_t.
 * Use the new helpers introduced in previous patches
---
 drivers/pci/pci-acpi.c | 12 ++++++++++++
 drivers/pci/pci.c      | 17 ++++++++++++++++-
 drivers/pci/pci.h      |  5 +++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b5b65cdfa3b8b..9f418ec87b6a5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1081,6 +1081,18 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+/**
+ * acpi_pci_device_constraint - return any PCI power state constraints
+ * @dev: PCI device to check
+ *
+ * Returns: Any valid constraint specified by platform for a device.
+ * Otherwise PCI_POWER_ERROR.
+ */
+pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
+{
+	return map_acpi_to_pci(acpi_get_lps0_constraint(&dev->dev));
+}
+
 static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
 {
 	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 693f4ca90452b..567443726974b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline pci_power_t platform_get_constraint(struct pci_dev *dev)
+{
+	if (pci_use_mid_pm())
+		return PCI_POWER_ERROR;
+
+	return acpi_pci_device_constraint(dev);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -2685,11 +2693,13 @@ static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
+	pci_power_t state;
+
 	if (platform_pci_power_manageable(dev)) {
 		/*
 		 * Call the platform to find the target state for the device.
 		 */
-		pci_power_t state = platform_pci_choose_state(dev);
+		state = platform_pci_choose_state(dev);
 
 		switch (state) {
 		case PCI_POWER_ERROR:
@@ -2715,6 +2725,11 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 	else if (!dev->pm_cap)
 		return PCI_D0;
 
+	/* if platform indicates preferred state device constraint, use it */
+	state = platform_get_constraint(dev);
+	if (state != PCI_POWER_ERROR)
+		return state;
+
 	if (wakeup && dev->pme_support)
 		return pci_get_wake_pme_state(dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..410fca4b88837 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
 bool acpi_pci_power_manageable(struct pci_dev *dev);
 bool acpi_pci_bridge_d3(struct pci_dev *dev);
+pci_power_t acpi_pci_device_constraint(struct pci_dev *dev);
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
 void acpi_pci_refresh_power_state(struct pci_dev *dev);
@@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	return false;
 }
+static inline pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
+{
+	return PCI_POWER_ERROR;
+}
 static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	return -ENODEV;
-- 
2.34.1

