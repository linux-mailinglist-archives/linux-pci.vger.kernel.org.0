Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27740770A45
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHDVCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHDVBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE484C3F;
        Fri,  4 Aug 2023 14:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV78pjsOmBMmCY57qfe4gPqZjk9A21htGdS89Sc7CaeKHeSfcHhI2AHZBmppxbsr/tRbcSHlK1vPlcqrOxJnu1ehIg+qXVRKa88mBEU+//lQq71QkiV+Yh0HG4DZBcBQOTnsxIQNRu1LrYvLOpUDfQZ3pHUQ0r8OZJwj7HTded5hwU9s+O81Rv5Uh+eRo5sy1Ur+jKBJf2c3BLxgLvMxF7kPWKwpJ+DDvlSQrJfVRV2ONB5Yv9LR8KWIyg5XomPbozYoeokj3HwvRlHCGf0izP6r/9Y2Tc2V+39/FvbAQlN54PmoXGUmnda1GLZIHcv1LX0xk1PKZgvEczXR7IZZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8wy8q3IOgcBEWWi5OVXq9YyjyJNeJK0uA3uWwtwarQ=;
 b=UK45pmuZz/Tkco0+lKSu3lKqnF42OVHhntWZwDnE3k+8CmF5JvKNPovUw2gpVldgVIDaTmmwxBLJxP/DeJPBcRXdmZLPGoFQ9PCgDARakcJqG+kV+r5ejk/Sz0xjxoJXCKMDk+Pt/wscy3tx3t08yfdjc/1KD7UtQcJY3v0FnJr35rFxjI/qgPn+M9ZuS9Q9GBbxz2GrrPh2TqztxyWPdP76UPiqUtGuIEZ8Ocp8V0R2yQ5WgnajR3sI42Uc+zlAR4HzfjlTTb+kwR5Y2m9UubGBbeQHijZf3UQTWkcedeRAKhBE1dzMN9UPxzDVb5z0FSqYzCM4pB+XhZqHt2uIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8wy8q3IOgcBEWWi5OVXq9YyjyJNeJK0uA3uWwtwarQ=;
 b=5gVf/tYDZx7epYqBsnxFI8GiBg0Yjivbd+bT8E/LI89CGckHQPoNOrb6ZEC0MXf68fX0N2bTA9+uVJUFwy0epqYObx7Y8dK+OJXU1ftGUIKbkpszr+TnVVBQApuvDtiFBhUrC5DHhU2JuM9udLkjFqqJykb9hS/vVpIjZ1NwqXU=
Received: from DS7PR03CA0241.namprd03.prod.outlook.com (2603:10b6:5:3b3::6) by
 SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:01:45 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::33) by DS7PR03CA0241.outlook.office365.com
 (2603:10b6:5:3b3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:43 -0500
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
Subject: [PATCH v10 2/7] ACPI: Adjust #ifdef for *_lps0_dev use
Date:   Fri, 4 Aug 2023 16:01:24 -0500
Message-ID: <20230804210129.5356-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 374a5de3-d96c-435d-e653-08db952e02e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xkOlRQMtCfkwMBmo3OkytxErwLQ5fT4hoPWeph6Xc+fzzr9WwLitoZ0cGyjCZwih/GYn7uCopLiMIfUhyGwPZVs7KyVTBbUuRHQD4X4l2Zp9od0090wrO85IqkxG3wAfe6YXQdc3c7oWmBSRZZ0qBqWnjlaesZWwsWVfHx4ihh62g20odsnk+JQqXzjL02stUuHDNmALWnxBc0+x608eE+4XCBCKMhI1hMORygBdqPHLEadOqEGu5zksNLJo7eTtyJsjOkydsR4vRYDko8ozStOfvthzRZ0SLlANS7adPIQPCTy04uUJaL7QBb6+GuNh8NcNJKWEtkgDZsBmwDF6JcWvghio7XC7SOUxgC3aXcZjOGSB5mjIGp60YKueYj8+wm5buLJB76G4hCxohvWidZYebGInC3pHaJkeuX5ayOh56ZxpfIFTwllUVRNdbnhyp5qzlEJViQqh4RqOGZLNbAu0t3XexyhAV/SgjnqDHP/V4igULB6Zsb78P/a7spfC+WDbso81XpZWQVFliibbhSqtVMLfOc8jeVVspN+FiIeg8VfDTfCocAiKNnvnwQ0FV3OkHEwPKx2xX+5tIJgK3sIgKMuXeGz7cWDLzES+4BYgg9bdX6lTIqzgtxOLKIE25mBjb59DKhwmEGubpPEgoAqpxI4Zyn3tLxvhDYQ9GLkH/2ev9mdQMFVw2HBMg5cEMjPSMG2ZhlY9btRo1MOJCM9UGcpLOCMOi6ehJKk3nNXF38SV6cufSm4iGcllOmBQwEMs52dHlKlJPRkuTUvFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(1800799003)(186006)(82310400008)(40470700004)(46966006)(36840700001)(41300700001)(40460700003)(8936002)(8676002)(83380400001)(36860700001)(47076005)(86362001)(336012)(16526019)(26005)(2616005)(81166007)(426003)(356005)(1076003)(82740400003)(316002)(6666004)(478600001)(40480700001)(7696005)(70586007)(54906003)(110136005)(36756003)(4326008)(70206006)(2906002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:45.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a5de3-d96c-435d-e653-08db952e02e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The #ifdef currently is guarded against CONFIG_X86, but these are
actually sleep related functions so they should be tied to
CONFIG_ACPI_SLEEP.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0d5277b7c6323..13a0fca3539f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#ifdef CONFIG_X86
+#if defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
@@ -1109,7 +1109,7 @@ struct acpi_s2idle_dev_ops {
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

