Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2768780582
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356786AbjHRFPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356493AbjHRFPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8A26A8;
        Thu, 17 Aug 2023 22:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYcRZVs40BQbuozWxFEij9XtUGzPQHnU+fZgChUK7XoyL2clgXV6Fpi2yWCI/ItNztqeB6S/hfoWCo1cISSsP3LmJexSPSP9f+ksrTqYxNJ5BfvpJHvaWn2N0trbDqmsRHoOa/q6mFVWIxw9/m6+d3HLrI0eZR4P0Nt45rHaFKBM23FAB/UMPCgaYC0jCCmQLK5VdIKVxCkfRTr32gXWnA8bOMS+RL3gCryZgHLaDQaaBlLz/3720NT9dTLipDcJwSFUUBan9BjDEQ+y4mLebTL37zD3v7yRlI9LIvVffHJp0ueHUGio+hRQSjLMk7FmOSXWBruRfdP3Nxzn17Qz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YuM/Sqk8U1Vs5QgWnHntvfb2qSkzjwojLanSNntx0w=;
 b=hqKjthu4/cSSz4OeL8tYXxmlI/Ri1kqGoynLM/OvHTYef7gtu8CpWfHsHydDzBrCuqdL411vxmbZyZ6P6nmlofVrCBjjWgJP2BfMYDjPv861kV4NxcU1DJkFyI2qS36+OXMyupaN7ZFkn6gI1y5YIpkLAqVeGHwF+5RBoYz4QCBNv3Y3VKuylcH+83o6YwZfpH0XL8VHvED88EPdAf/j2UxLWZpVO5NtJe8sU8eCkxEjJUJZ6vcYsBADZvBTl196xMXgYX8XMwc12gZHnx8h5hR31oMDXlNVQjVjS4xYTrC7UlmoMmzZsYJtPhLC7afp/8JFADGZJOOjOxefuMDL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YuM/Sqk8U1Vs5QgWnHntvfb2qSkzjwojLanSNntx0w=;
 b=Xw7OTaY/7AxoL4prHydDTWCXGiiqf2eQHlOfWlnAmShnjiHZPwhCu5n9grdkWAsPLazr2w3mm6n+zAGj6Vqh+vdRvaR2MiLW+hcUVeelDVT1cdnYtJ/e0vfiHxvNNaPaY/ONMbQ9iuh/k6ATOF2zb8FyfkC96HJZhbqhonltu9I=
Received: from SN7PR04CA0205.namprd04.prod.outlook.com (2603:10b6:806:126::30)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 05:15:05 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::dd) by SN7PR04CA0205.outlook.office365.com
 (2603:10b6:806:126::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:15:05 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:15:03 -0500
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
Subject: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get constraints for a device
Date:   Fri, 18 Aug 2023 00:13:16 -0500
Message-ID: <20230818051319.551-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BN9PR12MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c28048-0627-404d-4363-08db9faa1543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l204H1twffMidFE659CcoPdMvwlJ+OyjFFg2atIWnCtP1LZxH+wm93u8Vr/NwPvz1c8bxKw/096pQiwXsgMa+V70jytwwzhDMykuUjhLN75ofHAjIE3+2NbTQk1KYNtO3EHUR95tJy3SmpsZsTu2jAqbEMfMmwrDlsuNSS6Y6YvqPQcFgrhfWwuwlAKgfR5unqGpDcdp7M5JZvUTMnXFafK9oGHnOrYKLL6t9RLAhWVWaUrAVkBtbQF8OltG3AnCMntfbRfpKDsGD4ujPYY8KOH5kw6zPATtqVKwLcaLp/U13Q3BHs3srLODmhGPfsT2P/RwT5Jff6OGLKlN/dIfATuQ/0/ubs3LGeixczOCH8swYy+gKIA8ej93O8nf7KkBVjatODeJHw1dI0G1TRc1JcPFJf4EHGkvSkrY2BICKte9c5H6teFIx/dcPKjswKb06TBUiu/Gtq5T4RxHRvkAyRSCKC4RUItm3yFGg/Ltd4vGMWdNjYTYxkkusZ5tWIqmr0qWreDb6vV6zhU007LJiFHQl3bM7hCUORt0RzS/pgj675Go1nfcoRyslOy/ZlI0NslX0WMnWgnIdnsf2x/XW54QBUvm7PesSotgdbZJQKt94Z7wxwlQAyzS8yiouFzha5bo/y+WOY3IZ7t67o5FYMglbEhxmPE37Cyn838xGwMFRSmB0Z1Vjc3J2RWdpCVNkzTOCQwC/KEQzs8dgZ+cDDJjr1Qcpp96PscSXK9ZCXexUe40H95U0DHKQwl3n1Vnt2NWboSnVsME4+ug9MYaVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(16526019)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(81166007)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:05.2418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c28048-0627-404d-4363-08db9faa1543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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
 drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
 include/linux/acpi.h      |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1aa3cd5677bd8..dd961f3a60577 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -299,6 +299,30 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
+/**
+ * acpi_get_lps0_constraint - get any LPS0 constraint for a device
+ * @dev: device to get constraints for
+ *
+ * Returns:
+ *  - the value for constraint.
+ *  - Otherwise, -ENODEV.
+ */
+int acpi_get_lps0_constraint(struct device *dev)
+{
+	struct lpi_constraints *entry;
+
+	for_each_lpi_constraint(entry) {
+		if (!device_match_acpi_handle(dev, entry->handle))
+			continue;
+		acpi_handle_debug(entry->handle,
+				  "ACPI device constraint: %d\n", entry->min_dstate);
+		return entry->min_dstate;
+	}
+	dev_dbg(dev, "No ACPI device constraint specified\n");
+
+	return -ENODEV;
+}
+
 static void lpi_check_constraints(void)
 {
 	struct lpi_constraints *entry;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f1552c04a2856..6745535444c76 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1109,6 +1109,12 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+int acpi_get_lps0_constraint(struct device *dev);
+#else /* CONFIG_SUSPEND && CONFIG_X86 */
+static inline int acpi_get_lps0_constraint(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
-- 
2.34.1

