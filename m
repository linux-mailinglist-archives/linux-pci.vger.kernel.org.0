Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53C77ECD0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbjHPWKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346783AbjHPWKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE42705;
        Wed, 16 Aug 2023 15:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlsAmYOZ8ZyXxllrDSb0W5NkRdVmqkd0KYPgO7P1GrodcEB3qXscEeqQ+W/VVcmZKG94Cz9HCzC+sAOodwzqdkoHEjhTLaG1ErJlqhntajEPG31aoy259JrnARvikabtDcSE7oc7aqCnHOtXXAdvp9MYFjIIIOxVccTAhDVM8UkFIBqSppmwdQ78XShKPiQf5g+61dEg2HneaPdDfsJ/xDPdifm4hIVMfYPtyQQxUvCCTvk3rbh0/ZD2DSRDX2FKRTnUL3aIk2vdJaZ65TqvigpmNEU9W/Yq53iguHgPlbO6y98ls/LvCC/b4ThW/GNuwClR+rs55tVj7g8fJ3hYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=gojrmQe0oMSxo8fKEOfFyeY57kRMGKmdGy2narGpftpQEp/jB8xEx47npgMkkK2aYfP45PGjs0eUk6b5PbIozjQ+gbSKobMavMno5ZMseVYGph6TwGf2ESOAILSyImzTwvSCAJlSFz9F1YbSo+lDh7bCTnXM9grX4ty9AUziW2X+tiq3mhUCFN3JMPW5+bpY0hgcHdOwmWzvWNMEsbUbxeU3a+gtofalbhLp/h+lATGBsa/lQmwNQRzEtarDq32SsMLChPIVkinHFj9EJaHM60C7IKqC2slX7PiSfmfavFB+c8rnTyTfagL5celcR4L70i0xVKZ6gvXayHbsmyPMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=DN0z+qgT1P285eeiVk6rUprXUDSGrpj7+hSGg/nZYH6aeIV1tpEt9YtHIT5xdUcxIaYEKxRggDk+e8mV4anwgDN1QOQipPmE2E56qQDOPTAoI3aompxGle9CflXcK+DVrHjbtjaIW89GHTirsgGqZMgqBrQHc0eTie7kpIvazNg=
Received: from CY5PR15CA0212.namprd15.prod.outlook.com (2603:10b6:930:88::12)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 22:10:40 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::61) by CY5PR15CA0212.outlook.office365.com
 (2603:10b6:930:88::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:38 -0500
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
Subject: [PATCH v12 1/9] ACPI: Add comments to clarify some #ifdef statements
Date:   Wed, 16 Aug 2023 15:41:35 -0500
Message-ID: <20230816204143.66281-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8bbc7b-98ad-4d55-724b-08db9ea5a04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7yaY2sI7RuXY9dJv5kL3XEX4ypJwEalu26cbouMHFIzEtc+xa8OcKAQmo53IAIlnYIRwllkKRWWG9n5DkGOx2tacpxvay6C+W4Gty3FNJ3XRDq+ZUyhqrX17tGmlifXBAq97cN6LZRp7/sicVJnC5DrQNOc+SBphhfPNQ7YRKx/Ap4IYjvHK2NvF9j0/P3vQAMYYcQLqrkPne/SAID/jLmyI+V6TG28V4fSwgt4rFvYgWDVbkYxkCn5vy8cnIKSoPOJKfPomp43ZRVHC9mvmWkZtKrfjl5P526qio2wzYDe9F6ry+YsFbYSax5g0t+t9o6YyLA1GozoiJAlQ/ul6TLWysqyihYPnCJx6NrHnNrdzysB96wvus+BcEKXbRf1eHWZrAVEqyt52/AaJvBjoO29uom4RROPxykMwg1JQHrTfm9/rE5oCtkEn3UChbRsPxRmCPCx0Zh3O/ST8u8yD4wrefzALQZ0HhkwSX61DqfFZFKVejaBQYIcAhQs9JvFseUJECyTqH0MyGZCUGOJQtROy1UIsvd43HHaIXB7Qq7VlYsgbElejeX94zk4Y7lXecKmnpNhFKNqQ49PpU+ADKQYrLqlkoo1szP//t2v837FncN++JDoqCgSq0EXxVysFHxCCHSWh+/bJcS44cJVlN2wsO/PQSOipvAX4o39Pp8g3+/93qohiz58V7trmzDn9F8aRlhxv/IVvDdYS7tfcJi3zpDlcdgt9j7FnuBK1zcEptN4Xu2l0yHT+/ZHepBNKYZzchTIYxqIGkumI9mOKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(336012)(2906002)(4744005)(1076003)(2616005)(26005)(16526019)(86362001)(426003)(36860700001)(36756003)(6666004)(7696005)(356005)(81166007)(82740400003)(40460700003)(47076005)(83380400001)(478600001)(40480700001)(70206006)(54906003)(70586007)(110136005)(8676002)(44832011)(316002)(8936002)(4326008)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:39.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8bbc7b-98ad-4d55-724b-08db9ea5a04b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

