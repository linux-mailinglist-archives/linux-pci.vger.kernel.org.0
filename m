Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127F2770A4B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHDVCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjHDVCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:02:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C24C3D;
        Fri,  4 Aug 2023 14:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMbtIAQxzS/uNwprGW+9T1qr492UcSpMNP/KXJGNyNwXu7rFP+4FrVI2HI3qaXenPVHUQESksxptD4GYkP2nL83tjzTUQk/Pah/czc4A2eAEkh9FbglW9X4Z83USf7bMdRGtjfhgIPfg9Bynw5d7o/OIm0/9Z+boGEs0zB33+xcYdBvP9NomvmXXgppXtuRV5UyPnJybWjddANYkxzZp2lfH0D1RMhVTG1KsMJqMs4kVh6M0MMhiPFbhjFnj6+vA2Rk1/lOwJajJr5ORg/kG1CubO5wbYoq+vxoGrUxj/PCZV5Nhr3cS/azFRkQrEjVTGpPqf1zU+xkFO51ebOXpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKNaYVBFM4Xk1GipR8RNik/wQAL5VS75hCyaNge9iE4=;
 b=hm/BOdYugYxwHSlQ1ZEW3M710pO9ixqin1ug+H38+ZANCJ7JLEtbyr5qhS8NSdu5TEhjg/tFWdLLrScoxRkQ4UWXUQaHlcqcEvsOWko1hsOPlRPKWjw4ycKS8EHCTWdc+BM7SNmLSjeWO8gnmQP27QNRqNxS2F+e2Qkp0fY1eh4l+YRc1MAsCZNPI6amEOk7WDanwqGwLFkFR++YqVMnfVmEDLJeByFfw4DsOJ22oT4+6XCxeM8/sONlJE07E0dM8X4GjbWA5vzJt5E64SUN0Hse4X8S+sn9f9EqAr8srZXNpxkxitOVBiN5ZRSCRDftVDAnjRu3s8xmWMsDwmmasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKNaYVBFM4Xk1GipR8RNik/wQAL5VS75hCyaNge9iE4=;
 b=B3zKHur+xjYN8ukBf7XcB8f9YghoG92N9c613CilGbptWUaiOq6u7E42ny+P6+7Ag0MOSP3J1Xjlkvrz4AUpogmERrP0eMctO5UPZPdrslPO0Ev4PcSC2s/QowNzSvZL/VdEmX0lOxtmBnQIV5pAuujfmJYYAV4CNd6nneCUVfQ=
Received: from CY5PR14CA0019.namprd14.prod.outlook.com (2603:10b6:930:2::26)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 21:01:49 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::d) by CY5PR14CA0019.outlook.office365.com
 (2603:10b6:930:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:47 -0500
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
Subject: [PATCH v10 6/7] ACPI: x86: s2idle: Add a function to get constraints for a device
Date:   Fri, 4 Aug 2023 16:01:28 -0500
Message-ID: <20230804210129.5356-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: b865b85d-1fb7-4dc5-bdca-08db952e051f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dO+Y0MWuABpwG7fwRFh4UPEdIMjkHgMipARy16HLjS2a5wzdqKY/HKUeD6NMHGj3cRoP70PkB6QWh4/7KkiU9OiST1XZNKFLDEii3/99YZ9NRBQDXxRHaJuV6j3EmC/WIEU+3voCOFldeCEn30CVHHLnsFtJaLlsWXelIG5AYnH8pKztEtaaMfpEPvPWFIWVVh3cZtpTlt8EHZ1iKAFaw2BKD1pUzJhYsH9hTuqg9WtUmKPvc5Wmqh89sTcfCdFF/nQk76cHXKs+BbmdaQ9BHiMQXc+T66H22Go1LQsPJ3FRRKSHAz/E9Zl/EyoG4uJKfXPlg4susK/kjYNR6TzLifyrhTqMZydP3i6c/4bxw1M31rJnCFsNIByVvHCyY24EwRBkKj85W0r6o7zlJVAaJBKT+WERyLr9OdYrEs0qMAdi4C3rH+wp1KuRVInOSEF2LzapMjSRXzCR3jy4FbppFnCxpuqdty3uJu/4BfBbzoTzpMWZgZzMZ+ss0j9Qla1hy7lHGIyatBCx7FGwh2HVGu/3BApnei3ErPyksak9a8255VKMeWUWkfqqVsyHNPzIFggRwKrNPZ/DKyQxlZw4hbQyPKSbOeGmE/t6VIABEpo/KDyw2tn3v4XUewf9NBZNH5D8EZgqssQG2F99exUdqIVWrfGa+RzKt4s8n22HHGzEKY3QsnMRYTY/6mdwecfu2vgM809HxLRGR86FyeHLrh7fkgjJsXPVoGmjKS34Mx0cDi3k69/c+QBhtpHpbAcPMBPj1kUizjKTi9EnojE8vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400008)(451199021)(1800799003)(186006)(46966006)(40470700004)(36840700001)(336012)(16526019)(40460700003)(41300700001)(6666004)(81166007)(82740400003)(356005)(7696005)(478600001)(36860700001)(26005)(426003)(2616005)(47076005)(83380400001)(316002)(40480700001)(2906002)(86362001)(54906003)(110136005)(36756003)(70586007)(4326008)(70206006)(1076003)(8676002)(8936002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:48.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b865b85d-1fb7-4dc5-bdca-08db952e051f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Other parts of the kernel may use constraints information to make
decisions on what power state to put a device into.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
 * kerneldoc fixes
 * move debug statement to this function
---
 drivers/acpi/x86/s2idle.c | 29 +++++++++++++++++++++++++++++
 include/linux/acpi.h      |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 0c8101acc92ef..2a1a482f4803a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -295,6 +295,35 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+/**
+ * acpi_get_lps0_constraint - get any LPS0 constraint for a device
+ * @dev: device to get constraints for
+ *
+ * Returns:
+ *  - If the constraint is enabled, the value for constraint.
+ *  - If the constraint is disabled, 0.
+ *  - Otherwise, -ENODEV.
+ */
+int acpi_get_lps0_constraint(struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		static struct lpi_constraints *entry;
+		int val;
+
+		entry = &lpi_constraints_table[i];
+		if (!device_match_acpi_handle(dev, entry->handle))
+			continue;
+		val = entry->enabled ? entry->min_dstate : 0;
+		acpi_handle_debug(entry->handle,
+				  "ACPI device constraint: %d\n", val);
+		return val;
+	}
+
+	return -ENODEV;
+}
+
 static void lpi_check_constraints(void)
 {
 	int i;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 13a0fca3539f0..99458502a7510 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1109,6 +1109,12 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+int acpi_get_lps0_constraint(struct device *dev);
+#else /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
+static inline int acpi_get_lps0_constraint(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
-- 
2.34.1

