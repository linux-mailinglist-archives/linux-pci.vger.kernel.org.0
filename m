Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213F781376
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbjHRTkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379668AbjHRTk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CDA4220;
        Fri, 18 Aug 2023 12:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/cIonBeHEz88q8i0Yfuv0sluG8s5Cf7PELyWVatDtF4+NZmgDF0IV7U+7OWD4+980fYIVGhdGqmuZglT/tqGYDEWS2qtKh60tYVlo8n0Rv+l7HbCH2dp7kiIvdVLiLJnwhwwNgBir+xaJqlo1DnjhIBpKMX25ZCArpuGVpuRVRsXl+nAnGEZwYmm6tSk0E0Qxb75XaEQOKqMsgCbjLPlPFHNFjtWXnEi2pBKmWKjroYZhz4xw2FktCb6ryPG2ujNTD/LtQM3Fb+hEuiM7h80hPngkprg8LP5OjGCcF6mOVkBLMr53mzOJgEMSggsreu6WT5v3Sy5+EKjOyYAPsS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2LWCT/TRlS+8s8NwTCM0zoeA6pv5LGXIVx+et5JjS0=;
 b=KRTZ2jDCH1JojxBbQzIsb5NBtkn/Lx0zw3I3Ca4tfDAup9DWK2PiBLvypLXjAxOIzUWVzsym049QZHBk/kEwP2OC1M4zF8pJ/f/kq4+aH/7N5UmNunaA8phuhLUV9buwFsNrfVytxv8xVYVDOQOn+8jF/aMrySzH2GNuXKWrujYQGiU3dx+nzcVdaDGm2Gf9LG7shUsahwzvCFgjrVE1VxwzO9iB+VF7J7QdDm3/toju4DyoY5cD/UFGbyR01qM63f5RMch0g8080nB5VqONDDdsojPjksBsEqagfDdY/Ic7Nmupk0/O2i/GoIIBO71cNGli7le+KJgAgtomoZOvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2LWCT/TRlS+8s8NwTCM0zoeA6pv5LGXIVx+et5JjS0=;
 b=LlgWZXC39LOwphlZ70n3sXuK8l0xHwNrzQIL1GAYEKdfO41X0PqWHkDUPmKVAyHEqnYTYso5munghseGYFtHqyfDS2hVT9ZHFpkrZEyjXDFemG2qKttRBbEIOgfOXZjybB36eYrqxowQy6MyzGJ/NTCvbvZEDrAKeoHUinweANA=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:40:21 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::74) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:20 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:19 -0500
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
Subject: [PATCH v14.b 1/7] ACPI: Adjust #ifdef for *_lps0_dev use
Date:   Fri, 18 Aug 2023 14:40:01 -0500
Message-ID: <20230818194007.27410-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 05942ba8-b49a-4076-9f14-08dba022f56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdd9YE+JndRJH8JSfuHqhc7px2Uz9o3p9Mwki2kynwJ3pRSyX+Zut1OAx50jLLl/BZ9irW6uo6134sDeM2hyXKDo8cQiyXgxU97WH4bKIrg+cIDoQn5+XtnbaUf5773x7Kla5red3UYjjoG1PQ6wyPIZqTDWYwQ5uRZR2Dleyn4GNQ0LxhhXAhEq3GGSszLqwis2HMgzdpspejP7rLyKzzI2oDO6XbOCZo9kbTDmdzHE8kRSv08gAboioIsX7NTLsCdVmbQmMJMWcoL3Qk06lcUAhenXU0S8d0aMF/LGEg9briV8GqUQ6UAO7VrZdIgB4D3/IBSjIrTWJ/2KqIX7OGWff21Qb7l9gv+UrZfL/VVsiDzjRPQSoqxDOcyPRfY0dYU3M/SvPtE5Ajw3KiVgu5auJ+vP9diVCw0OIY1ugzPbQBEB7pkCvlGxakK/yNVjIcDlf207kXLa1yeDavdj3uzBvfidsePVSAso+j4Zq1DNz5BnQByufZ9tn/oqJ0ihq6OLNjageRXthtNRWrQR824c6QwsQvPDq4a47VZWVPa/6PJ6glk124yXUqQqE5Vs64qdz893iBBVYLAB/3AMVJ4Blhi6ocxt2G9WgMHqqwaTfWTM9pJHN+rQkF8jZsoTRnRRrR/A1DEBzK0eJZ6TiSE1J4XIP5ibS87sS/TBr3AV4r+/8FTfwAsiObPDOW1eYPl8/gaHSGlemzKKJPyVoqKJrL81b+TItbD/DABEnNLA0Bn/h4sx9+t+vBwVWbTE0Z+0G+SnWjJtm+MVlONAOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(36860700001)(16526019)(426003)(336012)(40480700001)(26005)(1076003)(83380400001)(36756003)(47076005)(81166007)(82740400003)(356005)(2616005)(316002)(2906002)(54906003)(41300700001)(70206006)(70586007)(86362001)(110136005)(5660300002)(44832011)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:20.8076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05942ba8-b49a-4076-9f14-08dba022f56a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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

