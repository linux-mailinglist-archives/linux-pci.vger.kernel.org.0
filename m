Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA777943B2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbjIFTQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbjIFTQr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:16:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8845199B;
        Wed,  6 Sep 2023 12:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkRpO5SWfMGY8sAMKAZbYvEFBhq+JYnP7lG9DLNf62zTRiHE0gLU/+E3IWfhKhA4kMx8I5F8XK5jm8CezE0HmII7zK8ANukG9TJ5wQ7GfGfylLbfSNjSuLr8BhHdsZei9Iwi1TSPXuFNcddC+LmQy77ArZlb3H/msWQflYbeESVPwIRXQ/8YqMp4FKbTiCDBfNOND0ZRyTL85o6WHqh+PonBG53kV/NhOI8FXuB3ez0qpWMwLr9tpZKJ8+fcZOP2XHhQ0Z3vmm3rCeFZwR7OOa7wCpqa8UuaMlAsJIHi/Fjtzp77HW8dslN24KNwlSLLUUmxli4750f5c1sOGIB0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hsrSL5Gg1qBLVBtbtx/99Vig8rSi+bhsVPhCskMjbc=;
 b=SczAoLmMuBPTKuyTq1Ep2jcIi6M7nV1B+QaYkOt8Pl+6EkoLIynVA8X+nATdf4iBNaR/beE6AXkUsPPKsKlenHvoeNld9dCXTP4FD0fmKpf3RhI6iWS+0Zz+qEa4lYJWaGnnXJzz2ZBRPASkcampMTIfgUDJADfxiLAfbpRR0MKd0f/1PjROIV0N5yKHVX6F3V9TUULeITjO3NSnJMeBAocCfffnrhC8D/szwZKjXDYXwFkV1VwDQK7l/xZALfFlLRTRO6Zl8I4uobEPLenkwR5NirUxAmp49XvMNYialr4gRrdj4ASvdwhBPG2xrDQqGxK3K16q7XIySXCFgpK2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hsrSL5Gg1qBLVBtbtx/99Vig8rSi+bhsVPhCskMjbc=;
 b=bi4dOJMml1hMNws/5OKaWpRCDBTpVC2cdhAudxAZ8qD/AKnxOkRxkVtst6Fn/e4znOe5TvTUovrCG3HJtLaAnKPsf717us0sZuGQaXIQwIyM5jewKYZ6rnkz1zb3nGzr8MvRBnkBD8/cJIigyzCbvUztKkEq3RvGLfIQAhF3xMY=
Received: from BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) by PH7PR12MB6905.namprd12.prod.outlook.com
 (2603:10b6:510:1b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:16:38 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::8b) by BL0PR1501CA0026.outlook.office365.com
 (2603:10b6:207:17::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.29 via Frontend
 Transport; Wed, 6 Sep 2023 19:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 19:16:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:16:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v17 4/4] platform/x86/amd: pmc: Report device constraints
Date:   Wed, 6 Sep 2023 13:43:54 -0500
Message-ID: <20230906184354.45846-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906184354.45846-1-mario.limonciello@amd.com>
References: <20230906184354.45846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f54e7e0-7f72-41f1-19c9-08dbaf0dcb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJ7hktQiTRi9McI5UrF+ML5T0vHAkYRkOP1DPvdIWPUH9v6jHDNZfPGKRAJZHvwC0IvK3i1Y6tSoRm2U7WxTlKboeActK+TTCzOz8agEKFpkf7EAimWxb4i5CyvEQm71sIEnhARwoWll5l1tWpD80nnDamb0bn8kMKXaSOuJAfY+UjTBBYS+1UwepCIZyqwp8YIfapoQCSjJYoJuq+F2QHql/R8kcDh9ZCofVOha3wjyLz1L+lyTQfyeH+xprfH5K0G7odt+DIBxd3Sk4hAf8AsCF4l02QJjw+wO2diPXaOT0jBBovHWEkr05ASrmDb0CkQ6l51XEh7MVYOIOu2m830M6mj/sTmBxfnqN9axXv1gWnfL+5Z2bB2i6vOONrq0sHjkVAfsDAjpvhMuWdJQBCb0IzYOl5tuEjpm5VO0Sqm/hml7dWs1xTbNWUntKHxH4GOdSCZLEVE4KIKGCKzwW7oqvbl1NJuW659sXE8G48cT3j1caTYUaNn6z115t+qopxCfOyauKnPvLfG3tUYu69Pw69tbP10J/A33PzX2JaI6Y8YtEb4Rol7d4ZKsZUPB8TokUCUeq8KeECajAaq0+58TA0HUPAnXMzyK1IudRHh2n8xsHJL8y9gFpvDwntwN8xWtjj5y8bVtFfe/Zizw0r/ygO645P4R5KL44PmOXQlpOISu45Hhud4MsYCCwPw5l7HmX5dt+I7y66l9+jg2s7zN12ltuq/4ugXgwtqse3uLzrMyMhIJ7R+RzNDzrXwddeaUMRm8q7WNDkbSYj1g+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(44832011)(336012)(8676002)(8936002)(426003)(4326008)(2616005)(41300700001)(26005)(16526019)(5660300002)(36860700001)(47076005)(1076003)(2906002)(83380400001)(110136005)(6666004)(478600001)(966005)(316002)(70586007)(54906003)(70206006)(7696005)(36756003)(86362001)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:16:37.9050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f54e7e0-7f72-41f1-19c9-08dbaf0dcb13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3hot and AMD's platform can't handle USB devices waking from
a hardware sleep state in this case.

This problem only occurs on Linux, and only when the AMD PMC driver
is utilized to put the device into a hardware sleep state. When the AMD
PMC driver is enabled it will notify the hardware that the OS is ready for
it to try to enter a hardware sleep state. Comparing the behavior on
Windows and Linux, Windows doesn't put the root ports into D3.

This is because the Windows uPEP driver takes into account constraints
that are advertised by the platform in an ACPI device. The constraints
are available for individual devices via `acpi_get_lps0_constraint`.

Add support for the amd-pmc driver to fetch constraints for devices and
report them as either an 'optin' or a 'veto' to the PCI core when it
evaluates whether a device should support 'D3'. This interface
intentionally doesn't specify D3hot or D3cold, it's collectively 'D3'.

Any enabled constraints set to ACPI_STATE_S3 or greater will be reported
to the 'optin' callback to ensure that they policy is set to select 'D3'.

Any disabled constraints, missing constraints, or constraints set to less
than ACPI_STATE_S3 will be reported to the 'veto' callback to ensure the
policy matches the Windows behavior of disabling 'D3'. This behavior is
necessary due to the policy enacted by commit 9d26d3a8f1b0 ("PCI: Put
PCIe ports into D3 during suspend").

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c1e788b67a74..ed5d2a0c6a55 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -741,6 +741,49 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+/*
+ * Constraints are specified in the ACPI LPS0 device and specify what the
+ * platform intended for the device.
+ *
+ * If a constraint is present and >= to ACPI_STATE_S3, then enable D3 for the
+ * device with the 'optin' callback.
+ * If a constraint is not present or < ACPI_STATE_S3, then disable D3 for the
+ * device with the 'veto' callback.
+ */
+static int amd_pmc_get_constraint(struct pci_dev *pci_dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pci_dev->dev);
+
+	if (!adev)
+		return ACPI_STATE_UNKNOWN;
+
+	return acpi_get_lps0_constraint(adev);
+}
+
+static bool amd_pmc_d3_optin_check(struct pci_dev *pci_dev)
+{
+	int constraint = amd_pmc_get_constraint(pci_dev);
+
+	if (constraint == ACPI_STATE_UNKNOWN ||
+	    constraint < ACPI_STATE_S3)
+		return false;
+
+	dev_dbg(&pci_dev->dev, "Opting in to D3 due to constraint %d\n", constraint);
+	return true;
+}
+
+static bool amd_pmc_d3_veto_check(struct pci_dev *pci_dev)
+{
+	int constraint = amd_pmc_get_constraint(pci_dev);
+
+	if (constraint != ACPI_STATE_UNKNOWN &&
+	    constraint >= ACPI_STATE_S3)
+		return false;
+
+	dev_dbg(&pci_dev->dev, "Vetoing D3 due to constraint %d\n", constraint);
+	return true;
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -881,6 +924,12 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.restore = amd_pmc_s2idle_restore,
 };
 
+static struct pci_d3_driver_ops amd_pmc_d3_veto_ops = {
+	.optin = amd_pmc_d3_optin_check,
+	.veto = amd_pmc_d3_veto_check,
+	.priority = 50,
+};
+
 static int amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
@@ -1074,10 +1123,17 @@ static int amd_pmc_probe(struct platform_device *pdev)
 			amd_pmc_quirks_init(dev);
 	}
 
+	err = pci_register_d3_possible_cb(&amd_pmc_d3_veto_ops);
+	if (err)
+		goto err_register_lps0;
+
 	amd_pmc_dbgfs_register(dev);
 	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
 
+err_register_lps0:
+	if (IS_ENABLED(CONFIG_SUSPEND))
+		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
 err_pci_dev_put:
 	pci_dev_put(rdev);
 	return err;
@@ -1089,6 +1145,7 @@ static void amd_pmc_remove(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_SUSPEND))
 		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	pci_unregister_d3_possible_cb(&amd_pmc_d3_veto_ops);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-- 
2.34.1

