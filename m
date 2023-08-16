Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3A77ECD3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbjHPWK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbjHPWKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E20C26AD;
        Wed, 16 Aug 2023 15:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM591bejp9/kl31M06PQGsOQJBKjfg2O8o2T66jloHa9KBjdRj5M+kYxuf9NWISmp17oFW2CfZDIaCEDvxHJ2sqHuBQq6S1+BEx+f0Bh3edvMWOOctshEkr+HvZvmMF58JJJ4oce0VSljqOOLi1KNgqNqFsD8T+yHQZefmYzdQA16x4xWUPgHuDuBP8yzFxE5nPx5i/gBMvpE2qVrPSelRg8o8M38is1jY8lSLuN6rcPmoQJe6V6gsFfhttC/GdeB8uz3uUFdSK1QJosjl8diHXMa5J47K1Sse57rJHeDIKbuety8RTXWM2V4r2zJt+0cWYP1/LzI5+x9L/V5ceueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw+XV7GtgEUwRkSV6AQqTr6LaCctBOfdlfpI+jarcDg=;
 b=RHz11aqmsul2jupRWir72fZQe47RVleQkR5IrXh9tWwS8O4tuSyrHySWqYRIqv+9w69uH8q5uhGSePtniMXYOSy2xalh/G6CMYhvvb+VrVznAho6AaeWsMMDNX5Ef5qdEYxGGaJv4was8SbAu9yladMJiUEtw/Ralk0n5VLj4rNt8C8oYe2OOs4pMH2Sb3znFJm8cUZsnybzu6LMFeGwJwMqe7pNElwfo/Skk0+ET4wGaqNgedpty/p7mfQAS8nBOCw1Urn2Ap9TC4HOuOlOaVV3md6FsnrPJTXiQgHuYr8xiSMToxW8YdxGc/WSQv2XdUnjdIXk7drUUkBuWHU8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw+XV7GtgEUwRkSV6AQqTr6LaCctBOfdlfpI+jarcDg=;
 b=O7MfdqLjLm1aSZQOSPwl6ZTG8W4H+Pj7j4oDt/jMmLv89nxeJcluAFoWod7o9sHF3RPJ23b7Zxn82Oyxm7YTz2PTEcJ1aPE0ItcRHSRZnbE6eQMuemyI3MVFEcXuQarhR07MKRRlZevIirontJhKbWXRHHBF/SUv0ZL3wTT13D4=
Received: from CY5PR15CA0225.namprd15.prod.outlook.com (2603:10b6:930:88::26)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 22:10:40 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::76) by CY5PR15CA0225.outlook.office365.com
 (2603:10b6:930:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:40 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:39 -0500
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
Subject: [PATCH v12 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
Date:   Wed, 16 Aug 2023 15:41:36 -0500
Message-ID: <20230816204143.66281-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816204143.66281-1-mario.limonciello@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fe3edd-7507-41cd-5b35-08db9ea5a095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0nQ210cAhXz5cHQ7ci+RtuSJQSBVimsLtORQckDKTBkSqUWVyq9p0W9Bj31H/EeSBN6GTDdK7bII1jEID9muY+zYtTJuGmBgqYjSu8HSw/HU6CH6vB9lIG8DriZhHRUuJfDAYsoN+89f7Ao8euYlmJYIfVwcncm4csGffg+tK7pY5k9y6m/RV+ikeai8OAORySm7Djr7N6X1DYQV/z5uLecDNVNe/Jjl9GWf7jsV7MThUIfQpQ1otndzX2A3ZzXuKBsGxSQUi9TiraZgMOIhTcYOiu+XE3tzV/Xhso54Qg52qCHThEpqvv4Z42gryodZWgdkpbuCOcBKfr1rnwAfRwEjcgRLHTjEjnpg9KeSUq6A6hEHAlZSRprm4RbuCUzSRR2u2y74VGbU8wfK29PjG6Y6fFdWS48uB8YMLbAnAn56pPfjOmndwmkV4wWwbX3MSK9kzrTdTZjNPpeAFgXFuQlNuU6L3gHeI8FXyLcQ+o3xYRGX/1MyM9aB3zjEABIn7aFyDTG6ga8f3gwp0OQ4evjuKJvZJmbuzRrumsbA8QXeAO3a9AWhlZ9W+fIkvcpJHPlbVf3xD9lJwQHyhh8wMeJMFlOv6AIw3Wn209oA4yJNPH2pqThGxEDC2SSCHce3pYJwzQ7nbX33ALMeh2Wbn38fQHZ4+00IeiOn8bbmFg4Od3zOuZyR8VczMWw+BxXadMuh4/yNY5kMULJ1NX99lEq5jEt7qGuhQJ/DOeahqVKfjGj62a+Bxje0tTmyfPFjg4uwBTBvjjOfnxp4RRM1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:40.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe3edd-7507-41cd-5b35-08db9ea5a095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The #ifdef currently is guarded against CONFIG_X86, but these are
actually sleep related functions so they should be tied to
CONFIG_SUSPEND.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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

