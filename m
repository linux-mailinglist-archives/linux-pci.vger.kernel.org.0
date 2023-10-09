Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02257BEEA2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378939AbjJIW5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378969AbjJIW5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDFA4
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl5B+LlPlFtvzqh5LMT20Clk2SwkvXFzDkaXDAGfSusSAPgSeMzsZ50cU0Qx6yn2XmeFq1n46CVuWKKeop8Xt2euDBz0RsmjE8ShPUF1goDAE2f+e3a2DifQMuQtPh6f1jhdiy+YBQ6ldIODvtG/kvTfDNn1luGoXJC707ps/WHt/wrVLOWGB9I1t3qVHP/Wka7blvpR3p9zSMH3NNO5k7XZnIw3QKhLth88uNywK9UKUBAa+a2+RCCn3C0lzCHQQZXffF+ogrwPJ4/IuGCyNSWIABQxvJv7nBJhkG1gMTxZ9kMavicshROSO/UDJcGL35i2nAW7wqTcp0FdqiMrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eUOlWTBTZZ1yFaKhYhblqOSQt2cmKckGswEOxIwRR0=;
 b=QwGkopXZezZsTWdtVOGkew0oK3PWdrxdtZxM/9XvBD1H5vvdLDrM6TI0Wona0flqRZn2CO6rPJaQKdVOUp8oyaPqPQNcbFFxMmntwT699BbsrdIlDlqscbqxn06wh+dIfGoR7euligmhbC1ZpKWSgdU+gkekEpNcewa5QVHD5UbC+yOxpyO7UQyrVYJynXEotG49iRpU2eKgE8o7hOpWqLF8hLZ8KfQV1NA4irKhMhzAiZOi5k9XQXtlWSRCyNKkBfOwY+4IEkrJiuav7t/XLEX160xmJ95stIBYuf0i5f9y3O5EfBnT41pD6W1xZLuxgUcGIrBpFdePakUtyCaNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eUOlWTBTZZ1yFaKhYhblqOSQt2cmKckGswEOxIwRR0=;
 b=p2NctkrHFEhn6ePAcnrjXBJh3zABxoUq+l77KwlmEX6vqYb8oDV79mo814PAT66nJ8/Hyad+KP2WG4VrD8S62Kao6V0JU99UKWg5CmKA2xLvRyzzV3IiiROrZpB6Zr0I1nyNg9kToEq2Qo2jvR+8weAOhTxtn1nIaCnrjcxv0aI=
Received: from CYZPR05CA0043.namprd05.prod.outlook.com (2603:10b6:930:a3::25)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 22:57:28 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::4d) by CYZPR05CA0043.outlook.office365.com
 (2603:10b6:930:a3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 22:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 22:57:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:57:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v1 4/4] platform/x86/amd: pmc: Add support for using constraints to decide D3 policy
Date:   Mon, 9 Oct 2023 17:56:53 -0500
Message-ID: <20231009225653.36030-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009225653.36030-1-mario.limonciello@amd.com>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 0860477b-cb3b-4c74-1e62-08dbc91b195c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +psbvEoq+U/oNfc1MWeRR7/KrsWGJPW8VgiFRdbQWmtSryY9KKXMxxH02TnUuB/W20B3GJ1YN3GOpK4kDarNjLPmiZNig2Yw7ZwAq1ajuPUnET5ETr65KYVpSB9M7UEQ9QYcjG8iVxPfHh3LBWaZ9igcXLQJgftNwa396TVl13sIhcx1l9V404FyZIrn66fGK/mWklQn50+OlLBOScGtuhKHQCDdGBgW9QyWHIMm6p+DLd0F6iw64LDbGZSgJuQ0wZIgGfMPfzsdIhm/J2tnf/5ysdH4ks19Shof4LpUfFcSl6LET5ZuP/inc+BfRjX4wPHEW+JoQ+5/rJTWul6KHbq8o4ecghtHpjKD0z0S8znyApvtdwqH6pcJYT4JNha3wD6zwjoAVDEsvWjUC4K/LBe/CzmEJyinvRRvDkPdWb/OO0ve/57iesI4JjtnShBs76HhxNbeb6/4fSdKvizlC4gE4h+93k5E+ReBNLFAAHzWbFEr1nk7XsX/oYRuzd1xNifDV8QjZ4DmfOCCEVwgmyAXKrwOrrW2dvM0eSHQgeTMArdPuNXUyZvqjxfb7AoX/ty4dn07xz2/YQ2ju2nhiPakVOzJza78+/BztBiaVAlNX41LCWClN6Cfg38uRC+JcfS86lya0JRxXOzrOKwhHM90IV31egQWFK3T/Vr8QDRrHO3e6kq2Tr5RbaU5AMMf3lnNTAOwGfI8AOwlIO/YOnuimhxVQYdIu54wf9pJoLMaesygU2ZmWu+LhcS/LHWl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(7696005)(1076003)(478600001)(41300700001)(316002)(336012)(83380400001)(966005)(47076005)(426003)(2906002)(70586007)(70206006)(54906003)(110136005)(5660300002)(4326008)(8676002)(8936002)(16526019)(26005)(40460700003)(36860700001)(44832011)(356005)(36756003)(40480700001)(81166007)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:57:22.8887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0860477b-cb3b-4c74-1e62-08dbc91b195c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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

No SoCs are introduced by default with this change, they will be added
later on a case by case basis.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c1e788b67a74..34e76c6b3fb2 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -570,6 +570,14 @@ static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
 	debugfs_remove_recursive(dev->dbgfs_dir);
 }
 
+static bool amd_pmc_use_acpi_constraints(struct amd_pmc_dev *dev)
+{
+	switch (dev->cpu_id) {
+	default:
+		return false;
+	}
+}
+
 static bool amd_pmc_is_stb_supported(struct amd_pmc_dev *dev)
 {
 	switch (dev->cpu_id) {
@@ -741,6 +749,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+/*
+ * Constraints are specified in the ACPI LPS0 device and specify what the
+ * platform intended for the device.
+ *
+ * If a constraint is present and >= to ACPI_STATE_S3, then enable D3 for the
+ * device.
+ * If a constraint is not present or < ACPI_STATE_S3, then disable D3 for the
+ * device.
+ */
+static enum bridge_d3_pref amd_pmc_d3_check(struct pci_dev *pci_dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pci_dev->dev);
+	int constraint;
+
+	if (!adev)
+		return BRIDGE_PREF_UNSET;
+
+	constraint = acpi_get_lps0_constraint(adev);
+	dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
+
+	switch (constraint) {
+	case ACPI_STATE_UNKNOWN:
+	case ACPI_STATE_S0:
+	case ACPI_STATE_S1:
+	case ACPI_STATE_S2:
+		return BRIDGE_PREF_DRIVER_D0;
+	case ACPI_STATE_S3:
+		return BRIDGE_PREF_DRIVER_D3;
+	default:
+		break;
+	}
+
+	return BRIDGE_PREF_UNSET;
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -881,6 +924,11 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.restore = amd_pmc_s2idle_restore,
 };
 
+static struct pci_d3_driver_ops amd_pmc_d3_ops = {
+	.check = amd_pmc_d3_check,
+	.priority = 50,
+};
+
 static int amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
@@ -1074,10 +1122,19 @@ static int amd_pmc_probe(struct platform_device *pdev)
 			amd_pmc_quirks_init(dev);
 	}
 
+	if (amd_pmc_use_acpi_constraints(dev)) {
+		err = pci_register_driver_d3_policy_cb(&amd_pmc_d3_ops);
+		if (err)
+			goto err_register_lps0;
+	}
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
@@ -1089,6 +1146,8 @@ static void amd_pmc_remove(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_SUSPEND))
 		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (amd_pmc_use_acpi_constraints(dev))
+		pci_unregister_driver_d3_policy_cb(&amd_pmc_d3_ops);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-- 
2.34.1

