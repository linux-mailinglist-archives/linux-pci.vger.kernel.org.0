Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D378056E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjHRFO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352334AbjHRFOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665810C8;
        Thu, 17 Aug 2023 22:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNTJxBxp+iSjgByzcI8EPv8DtnY2IwTTtrj/14/i6u+2iwN9ygW9HMsRozJZSxl2iXT0EMSJJ3r3xP3b+ivsvqvpOJPPgWV2pqnK0z9ARVApMuXEBCbIEtfWf3xQKtmwTzpoHHOleuN8k6IQyGdNmB9hp9HRnw7rl6yn2KTG6zGTwxA6TJR+M9attQ+alseoPw5YrtfngIGr1zc4R3k5t2LIJlRMs53Y4BujL4vqIByzKfak+/FTwRRmGQkN02UkY7p7a56qB3Yrx5t2Dl2UKnsn7RPZ3t0s+J8D6Nm2o2UfG9abaq8kDtNsDukuP2RlmW+ed6Ul4MmsclrBIiHLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nubf76jY+v8EjUmA2sf3PE3mZp7CYUrOFXK6b2nb75I=;
 b=jt0b+daBGePtlcQEc0dyx7SFaa3KjiFdLOKy2S/36yMEK38VE9qOePI20VQaskkPIsUpjcTTA43hWFMBq9gqzbFoxhHR0sCbp6QIjN4jrgWPSv3gNN8UmU47G2kj/nag37bt2CnXcXDxAhNl2x084I6ZwMACITx7F42r5SDXuz2Vq/eZ5+N69WM84RXMOSTya+L5EKvCtYImXUBfYMK5tkk2Fvs+lBmiMwUtVezMSqNE/dSiVI7juopDc9G0zkZSBQE4yh6900cf2lMm9rmWbNXdN1harei8hPUFxXxFs7Xto+Lpjk4smMNNB3S5pZ+fS/5BIMSnZWqLUdDV3DTa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nubf76jY+v8EjUmA2sf3PE3mZp7CYUrOFXK6b2nb75I=;
 b=cxsyTz/ogS7/KL87aMU2+vpUK3AMZ7t6ADlG4Zib33z5ooOFHT6nXGy/HkaE3lEjVHVI/rNhXW2upgXl0w6RT5TWzduZDalyRaAOxFg8U3voVPEOSsBmZst6Ls9kN92a15ZkMRKwC6P1qleMD1a846bBdqcdU0t9D5pacwxrbGk=
Received: from DM5PR07CA0101.namprd07.prod.outlook.com (2603:10b6:4:ae::30) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 05:14:46 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::26) by DM5PR07CA0101.outlook.office365.com
 (2603:10b6:4:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:14:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:45 -0500
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
Subject: [PATCH v13 02/12] ACPI: Add comments to clarify some #ifdef statements
Date:   Fri, 18 Aug 2023 00:13:09 -0500
Message-ID: <20230818051319.551-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: a19ede08-661e-4918-fb7b-08db9faa09ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8FdOtwZQQILlLEfd6FMrl+VQryapByBK2xZa0+d6R5y4PRmitPdT7QS2ynWVIgbUZSgxXzfe85t48imvspv6qS3lFLOg3S0DFHbzpiUdssci2OJTe8gcna3GHho+cUn504RwPb4JGvWvgbiiDKl2Y4I/225MXBdaGhp/myMt004RPigLoeOFlrKL/1a1meb28KaVFNcSgwCIe84g938dmXGJ8/psSH1R7NXtJ+Dax4KD+OtEH5HSgZClojufTdp7Mk/R6uotm/24t4nB41Vo319LyJRXCAyOGoEhgz3Z923sehshCtSuZdj6EXqKXrGBnbgqoEe7LgpYQ0aGyiajHBcSJaG8LVdI+v5oEidUOLB2beG8yiRfOimOxHm6w3ShqwpKoGgBhgwynULs2FFMb2RJKzgAv4GrxfXoJXZqvIf2qLFNCfjtLNIjtc/P8RJEHKgVHOAEwGmYUPyEruHVZoMvaKaJM/nYu7f/MLac+iVjAthDMBksOeHGILGZ69Eh7wp2gwScxQiTPlLLa4WOngwGo3wRrg9at+wpP7vtxBiBJO5ceC0jGxb6w/gEvw7TXWi0KtMnyz9DRHjU5XDvn/CjxjEg2G+f4hKJWBGW7Hlpbso/9u4b+XuZtUybkJpaP+JE29AfRvwaz5S+ZQhLBqJaDz5I5rHWcVp9Dru8eq8a2rZJLPPhS8xBhc7kgYHqSgAnIOrJ60139wSm8lRQxyli/9am2lBGMbXpJX9A9nFrwIyOhjhDgYUD/CyIIcROn5xF6tM1+zXW26CaglbVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(86362001)(40460700003)(81166007)(356005)(54906003)(316002)(70206006)(478600001)(110136005)(70586007)(41300700001)(82740400003)(16526019)(6666004)(47076005)(36860700001)(7696005)(26005)(426003)(1076003)(336012)(2616005)(8676002)(4326008)(8936002)(5660300002)(2906002)(44832011)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:46.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19ede08-661e-4918-fb7b-08db9faa09ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With nested #ifdef statements it's sometimes difficult to tell
which code goes with which statement.
* One comment said it was for the end of a CONFIG_X86 block,
  which was wrong as it was actually a CONFIG_IA64 block.
* Another block for CONFIG_ACPI didn't have a comment.

Fix the comment for the CONFIG_IA64 block and add a comment
for the CONFIG_ACPI block.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * Commit message improvements
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

