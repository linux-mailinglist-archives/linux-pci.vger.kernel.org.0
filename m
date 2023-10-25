Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743F7D5FBA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJYCGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 22:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJYCGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 22:06:17 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3C10D4;
        Tue, 24 Oct 2023 19:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNuNnuYVB++XFLuelNVqlqi6NXhhjc7o3hVUhtlFVpok5TUu/SVpvAj8p9xK4YUE7eqouzOEfqDMdtfLTyg/ryYDbYx2sHo8ynbzl9BPy63j8lOenHnB57lGw8y/dQbAFkbXEYdbo9zCtkAymL5Q6PYNyqmeUBJE2zRuin7QLjj+27K9yco04tkZHGhdrm02Lflqeo/SxU0Zex34JkdbWLLSvTkVTgvMegbDLU92Jew16ffnieukpVTNEfZgm6CnlNZSum9OCgqzreco+orkZY/4kFRr3pIUfA2Y2HfIz6PGTlUMWOmnF02nMeWJzU2/K4NtyFFqT2AbgTM5uWUynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=jDp0bSMRNIYskS7eXXWwVsx1cBIhgnfGjexCwgXvgfJwR+keSHJkAMBRkh/EC3WhogLnwOP5X5CBgIWHxTIZn2GqNwajxkd57fkBgcUtW7WJtEdzCj7+L3EMR0q8OlPBOqEvHxZsVwuRhxXBQcvkYaKcH2caISa2UiaI83rNtE/67cS1VcZEB3hD8QQGZsx5mBYOdTQ4GHElpfuNUEHxeveL0egcg9XVh8k6nT/WnXf50SnmIqmbDW8vSSxH2MDVtoh6dYNJy0dVIvZsgVhk7EK2t04UHb7wWIBeE7YGICAlkF1d/4sDjBrE9wqtygXl/nFcY3cWLEYN3L/8eyb2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=H4zmO76hEKeEdGHk/bAWcEeA4yLSSF4oY/a1yK+Fo/Wkglerw7s9jgSVVLkylNF9UVkmYYCMO7+6ScOOJp2rXS/XRstBYN6xZnzPslfeDwC602QHzV7CLJTdCO8vkVqPUpOwHdxXooP6QDdAOM/d/VgMRlXQaYmJa8QSkF2jQZE=
Received: from MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::13)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 02:06:11 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::3c) by MW4P220CA0008.outlook.office365.com
 (2603:10b6:303:115::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 02:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 02:06:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:06:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 3/4] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date:   Tue, 24 Oct 2023 21:05:45 -0500
Message-ID: <20231025020546.504-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025020546.504-1-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e85683-1086-4a60-c3cb-08dbd4fef59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAoexHCSxfGf8GuVoEK1YR1+PAudWXLucExOK8PAuHSe4N7Vtr6l5MN0ZtMDokSgriSKkTav8UxJMEGqpHiU6tebjg1kljOUjipEd8ke3r9xyfnVjUCQg4x+40LHnMTRHlqguCNf7J48lcPoE4rY3TxwUABnM0AFbP7EsoGm92zVB3XUvCOkBAQWusxgKk2IYaPK8gwUTt3ObfywfO705ZsIyCqLB4vfSM5xa00VrahR5vDMmy4sWiW9OYXcURjkiDnCtGxVJQchJpc/LPPjqL9O9kfqB/ZjoG5yJucdWG4wJD5IYAC1jP0Kz5CFXTr9oJhN6MOY+3jMPn2T5zjfypgC/qGp8X2yZcCXrkGkxNLSFa1+cg3yo+49YEL8z1/NsYilOkIVJA1a3WhjOpkEApO0NWjvpEKYrVcyOxhHtkzNWjzNJqZKyf0qG5Wp0fJTIEbgxQ7w/O/j3ZOzNf/FapO/IewZPYrUz+EAwVBksyYG0iX2WbYIvQakAj2fzMsFqTCZAGy6IdWJlASfXrNAyshNuG1KLJp/uK24FnwE3Rk3HFIpy4nJ3eC9t1EP5Q8z7+e5noqNKbrTfJEFlDnLWVTx60eS+n0ezfVppHqTWktmdnPofk+rj7JSMEELLDlt1f3KaAIoXdCbyol1mNvfsJ3bhzAg51CcDG6q8acrBRuU+hhahx1ydAA/4jP/KJY1DSjC+8zMP4vUZEKTOlvHYNfpMCn/NNDzQQZcq+nblf0N+5MfQTLB+32khuEAtI0bYbLoVs0SAZZjt+XpuGNDww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(86362001)(478600001)(40460700003)(47076005)(5660300002)(316002)(2906002)(6666004)(70206006)(110136005)(54906003)(8936002)(70586007)(4326008)(36860700001)(426003)(41300700001)(44832011)(36756003)(4744005)(1076003)(2616005)(81166007)(7696005)(8676002)(82740400003)(16526019)(83380400001)(356005)(26005)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:10.8993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e85683-1086-4a60-c3cb-08dbd4fef59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..de9c313c21fa 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1

