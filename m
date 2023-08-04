Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4224176F871
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjHDDn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHDDni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 23:43:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D913C2F;
        Thu,  3 Aug 2023 20:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKT7YQECg/HlBF00idCbQWHPMXytuzY2YUn4B3babDEPwnl3bwQgtyHXpTyDJ5PADnPXaI/7A+YHtFIWJtwkXWuWvx1CN5Or6DdBKgOGfk5F26h7Q6Ony86Dc6ON4iN7gVBVSyhCsk82vXmAqL7OkqziKauALeo0ac1CYG/2ntPeG2APceylIeNCJER0NhqZw6t0dSeV60UW68Gau5yVP1H+9uHyaE7KNyiUlAUUBFCkOEWQYmyNa3ayRW6dy2D3nFBp05XrijE+I3Ob2dJe7IpNKRW4ssVRmTrFpK5U3H5X0j6p18m1kD3gdLYn/Jm/sKcQ09KpRKNHjTid8AuXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3vLZQAndQUrsGXw591fgzQ/18EKgSFlfr/n0oMklM0=;
 b=a9m6SpWwo8e4nT1u57iEVQzUUeGelyxGFzVInkSdhoVe7/okIMl9OqvvluehDJZkrYejCVgF9+QlPwJczegKGnWAnEeEHFHlW8lb1lALn1DBaED70F3FF4VeqwW7Fw/ozTM9SdcFZBMe1maX2V2qSe0/iqGsGATpzHi91CcPl2BQN4aTBnKEBzp6hkuquKX3o48g9+E/PR8NllJeEfg8r8BJ9qJltr0Bok5un3ifT2xfBTMbK2gmGCiMeMTAQH0fm6H8s6LJQjsDv/OeV90TWd2FAjtxhLOeY7zfrviSbycfnMkeWnjOSHszSB0WKTnEXmgIhNCMX1m2Gk5aC+od/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3vLZQAndQUrsGXw591fgzQ/18EKgSFlfr/n0oMklM0=;
 b=mEktrbwMKxA88vyFs+o9kRA3JevPzCvQILOxRBgFKfoYJ6H6DcU2TK/tYoPtJFRiycC/ZBqjXd1Rn12ZPcVzebG7p16eKuvNsBBxW4Y9Oo1T1e3ul9cXZ/oWI3/mlqxkiwG6o1VuSTwLOn76peB+/ezW27pgvWrD5IkxzhqkIc0=
Received: from CY5PR19CA0048.namprd19.prod.outlook.com (2603:10b6:930:1a::21)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 03:43:32 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::f7) by CY5PR19CA0048.outlook.office365.com
 (2603:10b6:930:1a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 03:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 03:43:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:42:41 -0500
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
Subject: [PATCH v9 1/3] ACPI: Add comments to clarify some #ifdef statements
Date:   Thu, 3 Aug 2023 20:02:27 -0500
Message-ID: <20230804010229.3664-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804010229.3664-1-mario.limonciello@amd.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b09e89-10c1-40cb-d33c-08db949cf98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5ED2gheN4t1S8ZX5E+LnldNh0vDH7eFeGL39ySayFB11MbI37N+JFa/hwP4LkO3gmqpZA3G/hrNN1ncCZUlQtkk8DEJF5qsaj5RiLhkB0o8sk6rB0hUfxpGA6phAWDQ5Qm25iX3mBcXju4jcQuRxQCpjS4fuFhXezkGLZUUTq7tknsbqPLNTE4zwE65jpgfsM8QgJO25AM48Wl8mVjiO6WfKS2E/6kIy0rAIO8wMzNjlcBJ4pXUyXsHtoM1sst17LP9SV+7GNSlShC5zRygsAEg8cWdclTwMTnpc1kg6Njrn6eTOyMR7LRJwyhuWKguZICqdxEelAxYpowslYmLahSw/HMxElfB3uu6uar/y00HKVCI1XSWbOCded2ZXF2em2Zt5oUju6aVYXS71I0ymuZ5bVWVYLo1vrcQJHa4BU/yUdM4MhTQMqOaz1TVLFX4ZuWxzBOMoLmq71pePj67Npn+fM6l/medmbdChkQWb4g2SJJuz3BghrHf/SJ19OQ09kHNn5+y8wzHvs9uv71Oq/xux7JtkS2TXjkBzXKH4sujO0EEqAGcR9wePOWtrfFkPBFqkA1cuRUPpE0yyQLCPLeSB/M4eiWlZWXkHPtQh50MuWkWwuBP9jHDWe8d6kKFB07663lX4KAGgxAwqlYXxJMnhrC1jihDzcniCKLR5cnqTfzDel4WsqHwf4HLwuMcp5Ex0lWA86rlUeY5FqJ/HF8lMrlL+vsQAekq1vu7ItonmkaL97UYvy4rRi7/cEhytIqvQTE4MvlBbogmYGA/+AEzpIOwU6tkCDjD5J7yIrMiXN1/JV/hYt/f4CgFxx0P
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400008)(1800799003)(451199021)(186006)(46966006)(36840700001)(40470700004)(82740400003)(40460700003)(16526019)(2616005)(1076003)(8676002)(26005)(83380400001)(336012)(47076005)(2906002)(36860700001)(316002)(4326008)(4744005)(70586007)(5660300002)(426003)(70206006)(44832011)(8936002)(41300700001)(6666004)(7696005)(110136005)(478600001)(40480700001)(54906003)(356005)(81166007)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 03:43:32.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b09e89-10c1-40cb-d33c-08db949cf98f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With nested #ifdef statements it's sometimes difficult to tell
which code goes with which statement.  One comment was wrong,
so fix it and add another comment to clarify another.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc48439873..0d5277b7c6323 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1117,10 +1117,10 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 					  size_t size)
 {
 }
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_IA64 */
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
-#endif
+#endif /* CONFIG_ACPI */
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 int acpi_dev_suspend(struct device *dev, bool wakeup);
-- 
2.34.1

