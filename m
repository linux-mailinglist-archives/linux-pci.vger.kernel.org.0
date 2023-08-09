Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE877691F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHITri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjHITre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E8268D;
        Wed,  9 Aug 2023 12:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuthpxLLtB15KBDSn3BfYU+IhfHIlK25XWlqAeKOeoUZABl6he+VeJZfmi2H1Fo5k+xMpNOqoXOXdxFYPjZQyX2LQqaVz7MZzYXdTwuqcj9qwv4v+tfUdTaojUkBAVI81H3Ju3EsAqjqlhTBzAJgwCAsPbzwdcNW8iCQwo4i7EoADK1cyVNlb66LyEEVwKuFjWypwuTSqt2ujU/CTfNW91RHjPHupxPzg+t1qOCgv6X8xwQJr0bRCp4SYSbTy4AlOTZFScDJp5BZnVbAXKR3rRA/JMv6pl1/1FaZ61tJduMPOuqzqsLzSR/CPyhBL3Wqt3fhzJR/drDMR7E3nmP4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8wy8q3IOgcBEWWi5OVXq9YyjyJNeJK0uA3uWwtwarQ=;
 b=CyTDbMfLE04qJ3eZvJSvpqIaVzNMTP3ADvo+o1UPQGu8UUf5tApomh09a3u3Z8Gx8Iw6xRTVk39Fy15Nse7VwxTYrwtH+eX6UKreFYd/hll7w6M9Ijv4d0TQ/A3dvjYpk/vfrj8Etvhw0N5cBNOxFTjAuF39SiOmNEDbkZtnMDHv47ZHL+cc+z2zSfpuMJKZHlAv+ye9p/SlVFgvHNxjJOGZwi25QLcoqFIl+94YYA6ca4HMDRwrNvU82PGYYnyPktJMlV+holEsP5E3oTpKzJZrQBKGPSJaSdOpybn/SrwZEy0YwesgMcAaEw57LTUVfVfEzVmwXaP3k2eGHU6eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8wy8q3IOgcBEWWi5OVXq9YyjyJNeJK0uA3uWwtwarQ=;
 b=HnXufxSu5sUOow1AK8XBmtRyokksX5MhVJJUGWx/EPODPk9lClt6nG/TtIk4p77tNiS3pI6cSW6meo/cqq1aPPgEx4UTLym6JtzCaqHN01tJwQZG1o96PPwCWJTbqRBoPdYS+jumkDGyA5TJDBrNWy4Ns4/UavgyVSOT1TPf3Rk=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:47:16 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::58) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:16 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:13 -0500
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
Subject: [PATCH v11 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
Date:   Wed, 9 Aug 2023 13:54:46 -0500
Message-ID: <20230809185453.40916-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 543ba54d-72e8-4927-82fe-08db99116f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqfSwu8uUdEb3wc0i8UMCox6UtH9w9FkGFjo5tBLzI8jBLOOsv1g9kccqgngvx8S6rp2HRGnA5v3GUpUtuZH29WCRhn1MNL9LYos0GtVYVEdlRHuHsHV69QpD/ZxYonIKVFk0NTQfuSKCrUzWYgU/eH0ga1nw67hd+a0BRFpZyU6psYR6fO9zxwj2jdd2tGj5/xrVtKt0lFWUDwGLRKn3ztYNKEUlBydSGnbCukEb0A1y/IMIhm55FsqIy5B6Cp/60Q8Z89HyzgOsSQWVllD+9F4Tf7xuI7iow/G1Z2OBm7VvxOAhDAiX/AADzmAlTgNLJbvXkKRTObJrDR7f6VsVAa+HbchZSkaspWMPrWmAJTwzHahT2jJMpXtjY2NW6wKuz/bTHXur5UtnSUOD7BSNyRIm8azod3IviHXNFZUTSQJlmJrJHGatA+GHtjdP9AK3tyy0tZUE1clvz3uFHuSAH3JYjjy4Q+QaoBy8ejRjFReCm48ydjxC6q+IRJ3PeN7nCj35K9hyfDXQuDwU38h4deIhYVWKm1z0+bHHt1S/4jcWCaZNvn5X6qlHURd7JXqCzlM4bfcgEP9/JgfrNcMV34IblMdgGTfo2INmqMl3qja3kVtgmVxpfoZjv/QPsfgwCA/UBSONsJ4BbaSvbGdDRw81IEL1U9D41kHc/ixMvOsfh6jIsrfEZQMMIpQcNOjUuK9Hk7N26zIPigTdF6wwTiL/xInTbecBj1NV78+kH5EyzJDjqExTTGy/oy3GE1Lo2vxFErshCXjygP8Ztvs3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(82310400008)(1800799006)(451199021)(186006)(36840700001)(40470700004)(46966006)(356005)(81166007)(82740400003)(36756003)(86362001)(40460700003)(40480700001)(7696005)(44832011)(8936002)(8676002)(6666004)(5660300002)(426003)(83380400001)(2616005)(336012)(1076003)(16526019)(47076005)(110136005)(316002)(70206006)(70586007)(36860700001)(26005)(2906002)(41300700001)(478600001)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:16.1184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543ba54d-72e8-4927-82fe-08db99116f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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

