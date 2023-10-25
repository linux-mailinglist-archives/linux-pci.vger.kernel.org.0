Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9307D5FBC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 04:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJYCGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 22:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 22:06:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3932110E3;
        Tue, 24 Oct 2023 19:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AETvowjEV1G3G+W0+S+7bdlX2BK3EhbRwer9hDRYPC1At+ujcRzMW0llAeWWfvel0Xx5d+PI/P5gdRV3Ph2Q35unvGTQsSeXnzieC7b74AhsK6g+jaq2uSb8kYwAygMNDLg0XHWwU0BClEmc/J9+0HIZLYREi4nLbph2Q1GUe1Nhvsnlx5/OPJU1wHu9vH00BLt+Ak9AH6paeaXpvUJ20BJhJINgysHL9mmE9UZBhjPCn9iznLzsPQipo28D8xEd9tAMPXXsAZdcVC0LHxlgwO3RcTi9tca9vy5KlIXRwXPbv661tTyq5LD2lwWLC5Uxl9aF5j4Hc1gTnNftiOYxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F3uO+5IWBcf7q6yTe2ZhI9rXKBglfqAeJ41mJytnzo=;
 b=DeSj4FrdRvoRlhcWG+GqX0xedrooCWALk+sN7GxcZkC3xir26j9iX4GbXznx8htzfXLP5fJJV9JJ8aZc7dB5Sj4olhuQJMsLQ4Kuw/kqIfoemuflmOO3uN9iCXVCBfmL7bqHsyOhbHbqQWj9WxyoR/rNihwQPzp0ZmGUaj5I2s6XH3yqKxUoX9TWEOsmllwtG8vMnaP8R+rQaHYjNoS6zPF088WGeDPqQb1SkGnBt7MUYmIB8dV1TwdMcon54Jx7AyWP45MY3J1cnTeH7bvDoFLF19jA9JOzxV8gMhMNr7ufsfSEDMJwQKACKnC2yIY05Rvohi/vHZ7owRDlchw7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F3uO+5IWBcf7q6yTe2ZhI9rXKBglfqAeJ41mJytnzo=;
 b=Re41GFkRETwo0vzHdyHGBzWRaOafIBR6pIxj9vCP2pX9TePkW9hrtFrRivCSY5s36VaeFsuAd1OIlR/1j1UpWJexyIiHKFH47CZzvIGcwqntVHJojoG1fsrovDccUVOBR0NH1rRflTetkABbxzXi2vbye+JyBpECQMbEd8CZrJI=
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 02:06:12 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::63) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.32 via Frontend
 Transport; Wed, 25 Oct 2023 02:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 02:06:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:06:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] platform/x86/amd: pmc: Add support for using constraints to decide D3 policy
Date:   Tue, 24 Oct 2023 21:05:46 -0500
Message-ID: <20231025020546.504-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025020546.504-1-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: b6264cc3-ca17-4cc5-df3c-08dbd4fef699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXlWUXDIr+ZsYF1yu3p975niA66x/MacU4CpMv1+UulsuZHIz5hvw6McKuEywU9b7gxq6kFxEP0ocSRBV2s8aIlYwmHpbXfD6bqpjSa1ix1OJdAaSpqyxZCs4n4q5HOppJyr2NrvJEvBqPe9ex3J/u2nlAUl2BmtIjipJwIm1wgQcPr4K8jw/05vTCWfOUO/KGdwftCDVG4h3YeMGHsFutLXl8lJOy2UyvUn4/3sHevjQURMvxXbFzMz6E1AoD42s7eDp2Q6jliVJkAxkqWXU1mxFby5tv/vr22G7+BlY/Jva1Q8qAw3wPg7DlOkacB43JZoCeIillF7Wq2Uia1bVOOM9e4ryumm6jXFCS1BFXfEk0ff74oqbq6YwiqkS8x7BAYE8mM65olB4KbOoG75YOXPUpnN0hSIh3W+bJRmEYQ92zOeR3HLqoR/mzxELFFQNBuqLxl6XkrUXD4g2ISFhlQeLvq9BjJX5D+u9F6XQ+co5pTAFmXJWSWoGLHW0LQlvhV/7HwDQsJt/BKx7ZfCjGQ991p3aCucWSFrm337kP3a59/ebxtZXljzBAW/v3joWmQMTVObF0b14n26xaywS9cqhmKw1rD+VcuVTSbwzDL4Pmmovxj+mSAWVbr0EupioaqtrxKbayHdossEvznvt2mS7g5EsUuc2Jz4rjOOwxi5nyWP69ItoG2LTJqds1gN9ytZ6VbRnFPJ+deXOD5dcjJJ+W8yFrOLuk1GyuUmz2/tSffALwuYk5hOvls39ADJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(5660300002)(316002)(8936002)(8676002)(36756003)(4326008)(40480700001)(44832011)(478600001)(110136005)(70586007)(54906003)(82740400003)(6666004)(86362001)(70206006)(356005)(7696005)(426003)(41300700001)(2616005)(26005)(1076003)(83380400001)(81166007)(336012)(966005)(36860700001)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:12.5711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6264cc3-ca17-4cc5-df3c-08dbd4fef699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The default kernel policy will allow modern machines to effectively put
all PCIe bridges into PCI D3. This policy doesn't match what Windows uses.

In Windows the driver stack includes a "Power Engine Plugin" (uPEP driver)
to decide the policy for integrated devices using PEP device constraints.

Device constraints are expressed as a number in the _DSM of the PNP0D80
device and exported by the kernel in acpi_get_lps0_constraint().

Add support for SoCs to use constraints on Linux as well for deciding
target state for integrated PCI bridges.

Disable existing production SoCs by default with this change.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1:
 * Use pci_d3cold_*able() instead
---
 drivers/platform/x86/amd/pmc/pmc.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c1e788b67a74..346564517667 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -741,6 +741,61 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+static inline void amd_pmc_apply_constraint(struct pci_dev *pci_dev, bool apply)
+{
+	if (apply)
+		pci_d3cold_disable(pci_dev);
+	else
+		pci_d3cold_enable(pci_dev);
+}
+
+/*
+ * Constraints are specified in the ACPI LPS0 device and specify what the
+ * platform intended for devices that are internal to the SoC.
+ *
+ * If a constraint is present and >= to ACPI_STATE_D3, then enable D3.
+ * If a constraint is not present or < ACPI_STATE_D3, then disable D3.
+ */
+static void amd_pmc_check_constraints(struct amd_pmc_dev *pdev, bool apply)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct acpi_device *adev;
+	int constraint;
+
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_RV:
+	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_YC:
+	case AMD_CPU_ID_CB:
+	case AMD_CPU_ID_PS:
+	case AMD_CPU_ID_SP:
+		return;
+	default:
+		break;
+	}
+
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
+		adev = ACPI_COMPANION(&pci_dev->dev);
+		if (!adev)
+			continue;
+		constraint = acpi_get_lps0_constraint(adev);
+		dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
+
+		switch (constraint) {
+		case ACPI_STATE_UNKNOWN:
+		case ACPI_STATE_D0:
+		case ACPI_STATE_D1:
+		case ACPI_STATE_D2:
+			amd_pmc_apply_constraint(pci_dev, apply);
+			continue;
+		/* use the logic pci_bridge_d3_possible() to decide */
+		case ACPI_STATE_D3:
+		default:
+			continue;
+		}
+	}
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -1074,6 +1129,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 			amd_pmc_quirks_init(dev);
 	}
 
+	amd_pmc_check_constraints(dev, TRUE);
 	amd_pmc_dbgfs_register(dev);
 	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
@@ -1089,6 +1145,7 @@ static void amd_pmc_remove(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_SUSPEND))
 		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	amd_pmc_check_constraints(dev, FALSE);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-- 
2.34.1

