Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC32C78137C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379692AbjHRTky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379675AbjHRTk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E84221;
        Fri, 18 Aug 2023 12:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+yMy3NvM48ZgfwZOaiwpbw3E+AioSJh02NpdXEOqHwH5ehaIHJmBn31fAobY4Fnuegg7VeOoOC1fNiW3YdVDmQ3LsquQizsptigIQyrXFK1rlXpgMbr+LIAEwfeFpXo7RLEkodaHH04x5BFW7aB4fEjLW0wS/K5wMJ9D7QIFgXMPMuS20PP1THQV++V5nsruykdJ7SZFiv6thBcDkQ+yzjvxGGK2MrAXlmB59u1ZLxK3fl/PRyTM3JplObqKdqhNLPlZVGDygB2qz0DD06zYLtGbU4NKoFcbcgZUfat3pZTGF+RU6BlHVDAOZuii/HxL3F/uLzQNgQ8e5xo5nb6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irFH7+vZKhEXTu8K/folZo2P2pj3lGNa34VIcEc1g6s=;
 b=X3fNY1ig9w1G3j+B+Qlgb3gpFu2kjIIvil0N2hUVMrqLx1XqEQQRJ+LiKdMV+9m5qfqj5F0oD2B+PbII1FOqDWZMb9Fr92c+0wjYX//a4nuKyYmYF6Wfm9iPz6nWV3woT/R6t1SRaUYNqNN/zimdn64Qaaae8F2pTf8BuqiKZUYKqnYPQbk5m3w/zZsx4w/DYNASCjtcg6pL6zueR5XxXuZHIixynOemf60wldFFgzo1UaiDHSPIJKhIuablvCwvSfBwVoF/0uArU7ThKN+teVOLB8PRSWz1iJUJOXwl0MoR5dyiSOtC6uTEIcwQfB5+jQjk4Gmm1VrpZPVW0N+pNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irFH7+vZKhEXTu8K/folZo2P2pj3lGNa34VIcEc1g6s=;
 b=gcNO7WZcKj//RNe971EkHo7QNqPyQuoDh6ai7SIJ8YFQw4TkPWWPC1ikgfcpjwvvq5Wdrh0AvjmWQW5P17k+Iw6o3p+hZ1CL+86ugsFt2acocch2HbrBrYlZYdaPrGvEOILhuuXSa0wNfGmQAAUkyRgii3nNQ4oVID23mNOVGoc=
Received: from MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 18 Aug
 2023 19:40:26 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::80) by MW4PR04CA0258.outlook.office365.com
 (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.b 7/7] ACPI: x86: s2idle: Add a function to get constraints for a device
Date:   Fri, 18 Aug 2023 14:40:07 -0500
Message-ID: <20230818194007.27410-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194007.27410-1-mario.limonciello@amd.com>
References: <20230818194007.27410-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: d8472c3a-857f-48e7-67bc-08dba022f87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9Fxy5+ZWV+NtJbG34Daxxt81Cv+FLMB2cCstrP3szsFq1hL+il5LkyGwam3TR3BBx80Tyq3iINRg5z6aCgAR8mR2FYzalbiYdI7oCyczqiaepjWy7ldhzyen5rDKMhNuiy/O39JR1ncvYSxMyxr5PHhspyNeIA8gFmaOq58FkPjHR1esqj/XKHMSufD07uHhVkPHCymcjBRZs50webBHiRderhBkp+CV2VtiXL6wnX8+zbx9r9cfet9ingIZZBMt2n/BTntv7ThyVWMup2S5t210lxbYuxnxKrY9qdVufCnnHv7E8/B+5MVsdi56cZErdViOdj/dRFSv97xSbRSvyKyWwSIG0aQmXMZEJXzbDSgs39ewZadnyXw6kXH7o+NJ6CL9DGa9ELLu0FDogzCKHIwCPhgpC2jHZbhVQQVARJoLxCtihXocPsjsWtcW6xhfeQtqp9IT/UTJsEywS0eStIeF9AxxgyrD5Fu2MfIBGv2y8ieTbrHKk9/ZzI1+mg/TdBp9gB4RyJEr1KmV4xwKAjgkehI3KX5LrOxYzVXbhTrpmtqQc0KNy7Q24Z2n81SXYSBqqeUtp9trvlcUrxv7KL6TxQ3V0qqKpqwr3ozFf31e8OZH6N/ShuDBscENmkZD22bWOoNIDb9qX/StejSqAmVUxmMZuSgMw0By+RiX9W3A446DyV8OI0cxf41iyF+BtxbsaoMBwZ3H+RNgwuXeO0bPHqQLor8yoivHap8IN/BVzljGgezT2JabCACO+6++XO3Gfxla8O/PYvzL4UULw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(83380400001)(26005)(86362001)(336012)(478600001)(40480700001)(426003)(7696005)(6666004)(1076003)(2616005)(36756003)(16526019)(44832011)(41300700001)(5660300002)(36860700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(110136005)(316002)(4326008)(8936002)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:25.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8472c3a-857f-48e7-67bc-08dba022f87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
v13->v14:
 * Use acpi_device instead
 * Drop debugging statements (will be used by caller instead)
 * Return ACPI_STATE_UNKNOWN on no enabled constraints
v12->v13:
 * Drop checking for enabled, just return constraints
v11->v12:
 * Use for_each_lpi_constraint instead
 * use CONFIG_SUSPEND instead of CONFIG_ACPI_SLEEP
v9->v10:
 * split from other patches
 * kerneldoc fixes
 * move debug statement to this function
---
 drivers/acpi/x86/s2idle.c | 21 +++++++++++++++++++++
 include/linux/acpi.h      |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1aa3cd5677bd8..3019ca760ac1b 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -299,6 +299,27 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+/**
+ * acpi_get_lps0_constraint - get the LPS0 constraint for a device
+ * @dev: device to get constraints for
+ *
+ * Returns:
+ *  - ACPI state value for constraint.
+ *  - Otherwise, ACPI_STATE_UNKNOWN.
+ */
+int acpi_get_lps0_constraint(struct acpi_device *adev)
+{
+	struct lpi_constraints *entry;
+
+	for_each_lpi_constraint(entry) {
+		if (adev->handle != entry->handle)
+			continue;
+		return entry->min_dstate;
+	}
+
+	return ACPI_STATE_UNKNOWN;
+}
+
 static void lpi_check_constraints(void)
 {
 	struct lpi_constraints *entry;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f1552c04a2856..2212668ce60b7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1109,6 +1109,12 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+int acpi_get_lps0_constraint(struct acpi_device *adev);
+#else /* CONFIG_SUSPEND && CONFIG_X86 */
+static inline int acpi_get_lps0_constraint(struct device *dev)
+{
+	return ACPI_STATE_UNKNOWN;
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
-- 
2.34.1

