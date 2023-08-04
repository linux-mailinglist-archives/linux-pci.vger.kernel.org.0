Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56293770A41
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjHDVBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHDVBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7637E42;
        Fri,  4 Aug 2023 14:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OerpOx9LOsVd44fB4AZNoraRmO4MxGfKyQeJIDZO0oKBpSnzlOwSnpwlKCCYxhRuTjZvYDmZoCYmlQuLzpG2IrN4X+oOQMEW63IaQj45r9j3sfwNRSdMndxre7mnferRUUE3T3utZUKN4jeIARvzvA8NUstVClKN0ByZSdgk9gSCR5SfmDn7rt85yYzstWgjEYbpZejKuOGSvR6PRNwn2yx4TRUzsc2wP7AhQ4Wvy17RJcYVRJ1cANZfjbfg0a16GpPWX2E7fgrahJHi4UAeMYAAhvvdybHptMUUZg60jjk77h6PpOGYix/LNKyZ/qFHcchd/YyMWgbTXc1Hc4grsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=ZtarmMnVdeYoi+Ck+OrwWE3kO5pbEMBF7896bVsiNNcf8L1EOnUNRDaoxWiCZ8XEBw7KOhgiJ5QkV+RihvOmkUa/Eb2el3DtFHLHY/jFMpylo21p3uF+lpbftFU43mG2wzTD/yVOijSBcnBevqPulOUYV5eqo5vWdzv7BSnmFres3/5oxfDFIKlArKRvcX61ep8TYZKM0Y3zjsjdw7UEfVJj9dgIHw48/nj+pmjeetycE4Gt1KZULEDtqm79J5gtJSzbFshZG1LH719HDTLZtt9T2Wtby3B3ZbdpRxTmVfvpzSfCXOBTo2Gn2lAZATP1LUoTa3ZDbU5G+jiJ5wsQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=0sZaw2dN4hlLARP022De2CzPdTxmupCjYSYGaK/3yvqavTCwJCarsYkNjVJSF0KpMuIWvPZTiOSVldruXB5FmI3gV3tCmWTTezpNERpMOkOa+8jyZI74RJLQJS0SiLDThTGn4sRDvNpd+pgwA7hEj6U/kd0zh7IrQfD4nJNFZcY=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:01:44 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::7c) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:42 -0500
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
Subject: [PATCH v10 1/7] ACPI: Add comments to clarify some #ifdef statements
Date:   Fri, 4 Aug 2023 16:01:23 -0500
Message-ID: <20230804210129.5356-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc7da14-2752-4883-d656-08db952e0294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjJgV5Cp2F+lKZ0bh6NB8cFXWxjY6hDpxROd8EQVjrczwVU1YqzkYsZCed34rI/vEeqT8QsVdTOS2Bh+3dNjloX7EjHUQW3phABxKfJbVt+UvIZjs1rw0l1OVLIWDKUt7Hdcep5TLXb0HU7mU9N3ir5gp65vwMGXaTyTRMnbU7JJ7gxm5pVbLc+dUsLp+y4eih0hyhRm8sRZ86apU7YUWVPhGUpEA+K2PBngUX7TvkAqDxkaa5DjpesTCG42KAL1irThQdqyj0Us1a+u7riDDrUmHWGMMxjOs1aY/NMSOb0qD+wtoeOO4E5CGomN26qw4eiF7EenX+EqQAB8+NUfKV+7igwsA0qXQeQpKywTMCCJYCBXWtHb8/wRxpIYZJKJ5voE2CzOEu5eLjYjv2Nx8VyeZ4IGyr9WhD066M54pVg0ex2DvXO0F2B2+3wnyXniZ25J2Di2gSQF87N/UGHrMGj6fDlLD8s3MD5Wl+vHB1juX3dlZt8jxkVCb8QOssRGNWF1L0c78NCHtUkrmOs6SzvEkqKtiRiXgC765H9MtlHJBXtIh3HqggcStZitauuIRkV7UGlBffK01uX0RZqoStGKL8fF0ZTMND9lz69qmYQWxnBbykCsa0nXqz8shs2VUaWfctTH5zXLdMVbRLJ1nWOmEb+VPpBnQImpqgzZjjo34Hhk+yApoNnUiyZan0AtpPQ1Y2oMnEwmYizdRQ5Z2y6Abdpybk/T5RH9ZwYuKZde115NmbY/XaiXjd65UZaxL0NgAR5RnbiSnCn/wNDduQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(1800799003)(82310400008)(186006)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(44832011)(4744005)(426003)(2616005)(36756003)(16526019)(47076005)(83380400001)(40480700001)(26005)(1076003)(336012)(86362001)(70586007)(70206006)(4326008)(41300700001)(316002)(7696005)(82740400003)(356005)(81166007)(54906003)(110136005)(6666004)(478600001)(8676002)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:44.6306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc7da14-2752-4883-d656-08db952e0294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
v9->v10:
 * no changes
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

