Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC00776928
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjHITsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjHITrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539AE2700;
        Wed,  9 Aug 2023 12:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLhSdSVQkAD+V0r2DokewZ3/6TseT2B21zbWpIMmQ+N9doXeEWQv86IKTTBIlyEuHGvvxQuMXpNafANngqIB0SjXCOK9u8J9xc364XNg5dc7zA+LaEWxSi+ipZSZf052uM7G0pTs89v5CJ25bpXYhDsJGA8rBD3hj7BjthkLobc/DwTWvVJcI2jHzJs0mJVABVcf03UGr8gAfLDBqg2gk9SGPOYTMbwjEGiJ7fCDPKQLHdtoHUFzLoIAN3un0/91R0DGpznnpGPFApSNVcEtQQsFUF4ZYOYKSdI+fvfHKfhNHBYAtSk0AmtCNDU12NSlVspOMFMSQTfsVoEAyHGlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKNaYVBFM4Xk1GipR8RNik/wQAL5VS75hCyaNge9iE4=;
 b=oH/7AXLzjMdD5jno6+fxGPxW2Zv403s7qkNoP9TuH3mUmoPbHhfGKn05onRFW7LOLZH81DB5siSrlPSVrLlk1Ts9GxncsZPFzPwC0+w/k5cUkvYfjCGH/LtDIUiUqwnCUB42QavHsi0Wrdf0jkjrATGwakhpZDbDCT8wXb+PPR8BaPrDTwW9bCph4LYQLn3JVFKoxpwaIRuG6//HBMDzJRwzgEYbL26IZV4y6dF1Z3sQTh4zPfoojbyoUMI9d4+mDsuuTM5ib2Fs5q5+vsMVkZEhBl99NksnFL1b1Lm5FORxepNrNcJGhtRUBPWD9smel0kA46bggfaB1wH2QHQbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKNaYVBFM4Xk1GipR8RNik/wQAL5VS75hCyaNge9iE4=;
 b=UE/uKpJGXJvkz4vZ1K3BSmH2veH2jsZoNu5SZrQthCqGDJ8HDdVCX01RmcWZzw/kVNnT0TvaCfFW4Uah28nG0ocvAqLGPgd31CinlSbrZqJa+gyt7EBPgrSMf+t8JmDlq4d6PBgMG6IXqAuTz8fnkNcXHBVESemtFT1qdu4bKKc=
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:47:21 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::1c) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:20 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:17 -0500
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
Subject: [PATCH v11 6/9] ACPI: x86: s2idle: Add a function to get constraints for a device
Date:   Wed, 9 Aug 2023 13:54:50 -0500
Message-ID: <20230809185453.40916-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d15408-ff37-43f9-5290-08db991171ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYO5J0LkAdOWnsWp0PbTIeU1jkfMEt4DfvMGwpPcVZMWTdSGUkfYDMNy2BztJyTbF17A2hOfmdopkxfHBGpuYCnGSC5kHr7B9sdK7yiA3/oX4t+ekC6TvkLwInL1dvs/kAfF6TyC7WAEXx+WU/BiVpmDDPuwO2kJqX4DM1F9f/Dord+Z+qb1ngklfE5sAmDNrjqREaoWG01JqHtuyQ4bYNZSsPCsRi1EsulOpJ2jPHN9vJOtc2OFeQ0Vbx6iMGUZBbOP5ywlyiEK8eKjJCMVx/Ke9i2pTnwtp3TieLj6JnDM9BTG1JjyrSFI4c5nGUXJGzGXg8LuXP4GMt5By7oV1qJ9jph3ISzRKsKWm27GtFNeW4kq40LxWQYoZaU/xNVfYg/aGPnqrbHIG5919ZnaIztLYQd4cAB2Z7WK1ncMK+nfi6rg8ituXzI4CSYvai+FwAZHJQl2EgzQ8proRjj3KgYlYpSk3epktt8UxdWDv1vakv0RVIgnT5bbskZ8CvW+1jUlhthYjDx+1pqaUhaZKtOBK9eGXuSYvQr9xdmzEjq27QFmVowuiz2kUYkmBYSOOk+sbvzun+kBH6t7/Dol/l27avGWcgJc4DAByUlS7NMvInRPXEizbrwZUlXBsnIhbqxpQc41sPoKjZl4HzGo9pFIsGA+UF7J1rk9UHrx4IvV/3OdUdTdZMiEgnCup6mHIROPNMSvMW6as3+SvP1aEF6mP8u9oHcg9CeA0U0z1xLgBMFjXJCxNUPTmATGBhrCu+enMZs5N+puf38R6YfIOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(1800799006)(186006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(36756003)(478600001)(6666004)(70586007)(70206006)(54906003)(26005)(336012)(16526019)(1076003)(110136005)(7696005)(4326008)(2906002)(41300700001)(316002)(44832011)(8676002)(5660300002)(356005)(82740400003)(8936002)(86362001)(81166007)(47076005)(83380400001)(36860700001)(2616005)(426003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:20.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d15408-ff37-43f9-5290-08db991171ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

