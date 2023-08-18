Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC46780577
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356237AbjHRFO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353052AbjHRFOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11561171C;
        Thu, 17 Aug 2023 22:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec3IVGMXZNCUYKBpOoXbcRy5lcHyfTQZ7baDBSnx77G3q3D4RFxGQTNVN5NcEfYFh+uohitcvim2ndUN7Ua/wx5RDkVIp1YU2aNweM5lmwpzLtf21taxWh16KRm1XlctzkZ6wsMTor8lK7SCZ62eNqzsd6EojtiGRfT9/lh21QypCG/eL1kxUMYj8VH0cVoO3lwxAQeFOmPUQXPqLCSicgk9l4/aWP6a+k7rskaYT0a7yCVFOCP3qLZ1byNy5wL2Dw/IA3/nGtdKWPTh3UwmiFpo36IPBLjWGC8SfKDU7dpdGPT4OlGMBLAjMvlVJEPMW4MAiYIeOQ9W710r5/MJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2LWCT/TRlS+8s8NwTCM0zoeA6pv5LGXIVx+et5JjS0=;
 b=npFFCNaSb9s3Xep4/Z3wGxspl3BhkO3fG9jDfecYYhLYROn/sqp96S6B9aiG6GaMNHQXQSW+1arh+31eJyualsfnibuQy9TiyyQrGuSFQGu5LTkRd0PFXETMhIpxOU4TbmpuLo3rA2SP/ozFj+MIBUa7pjWgiGWIFNLDdZUpGHfdMfVLV2w6RrPVjff8o3ZZToeM3M0HkHQpj1SR5pcEFz2vQPPfRr4smOWqUdlvtC6XtqqnKR31B7jVZwshhlwcjYgxADqp/BZUqA5Ee/ifS2lqDBQtV0yAmeBBbt3rHB4YuGUn+H1BVpcatbRiv0vl8GlmNgB3h0GaZLlKzvfjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2LWCT/TRlS+8s8NwTCM0zoeA6pv5LGXIVx+et5JjS0=;
 b=SrYHZTwdSSG331NtV/9JzZPFjILiyyxM8W8Df6wqu8ix44Bm8Evn96iGp1Y6QYCUyVkHmPdBUaoCO8VsaT+ABkoW5aRYAQNNYO5R7Q2TMuMvbbtmjjAdERcxvWhGTfkgNNCfaiNokjzsCTKRZQfrEMH3nBBHhg4JiKg8+h5LVU8=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:14:48 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::1a) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:14:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:46 -0500
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
Subject: [PATCH v13 03/12] ACPI: Adjust #ifdef for *_lps0_dev use
Date:   Fri, 18 Aug 2023 00:13:10 -0500
Message-ID: <20230818051319.551-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c6a6d0-6fc6-4864-998d-08db9faa0ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12JgZ79XFUcSPNv8jhzqWQ1QInNuuCChhKlCsfCQ2l5tjuucf4MJ1aAJ/xUQ0mZvzjbIvfGq5ze04ZDSVpsX9ZdMpMCXIBz+E9OPRxzE08cUZMjPTtzBymy/m8c/4TUkzsWcmwuTx14CtZDteikNGtjMMEtR6Ol00adhdonZYjfxSkmvIh7Yoc52wQmSn0bVA2aw1Wl3LKmkJDWibFvief/ea54H9O2kX3pZnPD/xJEgbeFqn9hMM/7q947PGvc8jumCrtkZGAVHOmhjYDz67LMHJWuuI/HToM6aSiOo6veQl/R0uYQYpKWKQUFMJpb/aCt5z17DL0TdDN6x2+rzr3t7tSEeB73VvP9MKOHbqJ+PwbIuXNK27WWUUWIQA3pw56o47YEVVk1GysZy3qgh0TEw4RgYjB8H/qclc/qEQRKbWD1YirhVk59C70/Q34vCad6w39DalQnloqqDfqDaEWm+224I4tZBuPKt0mllnsjhodtOXLMkAMpSVn+pFJFTyViF+8bzRmjXnXXQr/yOJGmG6Hq1/Z5/og91FA3OKaKEa98AyUOnxOpE64RGMWfJIqTWC2buwt2dQpMpp+Xa3qwbSGTHKSQGBj7BVQcPwvDR5+ydXGuGoKCuLx7ELW262d1Juu9JtCldlUNqNJjPlUmGXB/XOxL0p8Dc66tfrssCc/yXj/tk2Vx9oiVAc7lZNwTP4Nfw0PjF2YqSI4d2AwGGnkLrr9yCVzBETE3Qs8lvtGzg0oyU/yoSSW99W2GjdgZytPSb7IG79mz/LEQ6ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(44832011)(316002)(5660300002)(16526019)(26005)(426003)(336012)(40480700001)(4326008)(8936002)(8676002)(110136005)(54906003)(41300700001)(70586007)(70206006)(7696005)(2906002)(40460700003)(6666004)(2616005)(36756003)(36860700001)(47076005)(1076003)(83380400001)(81166007)(356005)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:47.6007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c6a6d0-6fc6-4864-998d-08db9faa0ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The `#ifdef` for acpi_register_lps0_dev() currently is guarded against
`CONFIG_X86`, but actually the functions contained in the block are
specifically sleep related functions.
Adjust the guard to also check for `CONFIG_SUSPEND`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * Adjust commit messsage
v11->v12:
 * change to CONFIG_SUSPEND
v9->v10:
 * split from other patches
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0d5277b7c6323..f1552c04a2856 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#ifdef CONFIG_X86
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
@@ -1109,7 +1109,7 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_SUSPEND && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

