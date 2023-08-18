Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B0780573
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356295AbjHRFO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354040AbjHRFOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2610C8;
        Thu, 17 Aug 2023 22:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjJsJc8tY1WKcAg2H86ONtIji3xaLuN7mPgcQPQdoP3qeQdD11JhLBZV0DcHjXIZOGHIn0jzvr5MrSVSOsjxYyfbNyxbbTpKtfudtj5iTbkrgqHJGTD/h3PMZfjOKVCo7n6yQ2YRUN6D21dmZYyxDULt8o82kHAth+ZGN3SaUCP4DqG4aEBOOMYIf5RAcgYcegVY3OKSGb29HhFNSEe+llaetsPnVZhhpb7pUc+JmT7NWJplPzXlxwYkVefQ1dq1u0SHigOfki3znJJtGNZVt3M91yfl6h9gdB3zZGzASJ0IdttZIEKNWY/vekaRA735dYvvNQ3acMEFN+gvZ4VQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=Luxw8bUCLq7X+D5frLVYEX1wPbQ+Bp7p+GIAk+utiRvnL57nIkqn8h3sa6pGnMh2MMaI+ELGF17MQGRYUKr3nCZPusZIjm1+SOaSpdxUMld1B/9RsyinV5HL3IREZKy2JDCOtM86VUiPlZzDaYcS71eBSrbOQW771p4qO8viUQ6yCuScRD2TygGYCyWs0r3NQayoNb58GVAEHZ30Z5MlgCoVZewcVTrb4x5Xfcb9tOkgrcHxTVOUoXTR+hUrmtStjHOk97vACO8IhLAmJmXwlzxMm1+/ztxsaHgKw+B6pikcn6B/0reSFYiky8eusogXjnHakJCTpWQcAbZuxSQ24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=fTh4LhorJOZwrD0cKNw9VuasaZtTNPahnw9OBDXF1bmoBl8xl2Jz/v63fqk1oUmReaGkUtX25YZyuMzIHWZCOz8Nwwy41pxzj4RnJdvc/TZAj5ZY+G927908HQBed6Sf80UsWlN4be8zhjH5XIzaUs623KkN+JDozO9MMUKy0BA=
Received: from CY5P221CA0087.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::30) by
 DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 05:14:50 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::1c) by CY5P221CA0087.outlook.office365.com
 (2603:10b6:930:9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:14:49 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:48 -0500
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
Subject: [PATCH v13 05/12] ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
Date:   Fri, 18 Aug 2023 00:13:12 -0500
Message-ID: <20230818051319.551-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM6PR12MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 07476418-982a-4b66-37fe-08db9faa0c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW1C6qtRzBelK356F7gNX97+JkHQysLj2DUeUij7VUTIl6pBgpmw+yfHTjH7QMSGldfknwJqczWZ+jxVmmpdIvterS4kmqdtpjzdxH8lT+nb7eb5Rn6aYt5pAsuN/8aGQH09GJOJv7z3ab1PRIL5nKepiinZxljYgJm6449uLFeu3SD2iCJHZSZ4v6phr873FlLBSSihGzDlaKjyY/fN8HNGkA2n0KOV/z2JCp7AsIJrpMxY8zRUJIF5VRjK2bZzMo3hhbCQXCZkduWNJo+mON8U9ACDjmgindtB+/JDsCgqF2EJodAz+5NIs+I7jisyBxXih2X8MjzxugU/0b3q1365/MfzQD3i91ndUiuqYzSv7BS7k+jWgeM239OYwVnxQMUGjaPZUne+1q/1vpUFhffRivFfrRaKwPcaeGA6UxU16hAhEeihXeHj0+rWQF7tKjDpiigs7Jb5120fCmhD5y7nrzgijt8d1Aiqa7pUuSbWRCsCIz7W7sh8TIKx5+gmbw231rucLBUTN6+1Ny7T27bpYhFgkM+XYaYo3mBUHoZSlFKJP0LWXe+YKXUBjEg7b6fOoboYjx4SM3HK9Fq2IrPXJqyEcdXot4tXTOqTEDzwZqKBosVDQvc2hn/B8Pz5w7f71kHv8bwh4lHT2/q9bP3gyt/clR8vgWhCIrKKdu0pNfIFX+GMMywO8AryZrLvT74MFW0vTTeVipYkI75u7sJBZv9hGUkLfH9CMkZsirJLDqvTI/AE+xx5Rc3am3JFIeZe3YvNfvfrhgDErmduFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(316002)(70206006)(70586007)(54906003)(478600001)(110136005)(81166007)(356005)(82740400003)(44832011)(2906002)(4744005)(41300700001)(8936002)(8676002)(4326008)(5660300002)(1076003)(36860700001)(47076005)(426003)(7696005)(6666004)(16526019)(26005)(336012)(2616005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:49.8421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07476418-982a-4b66-37fe-08db9faa0c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a badly constructed firmware includes multiple `ACPI_TYPE_PACKAGE`
objects while evaluating the AMD LPS0 _DSM, there will be a memory
leak.  Explicitly guard against this.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7711dde68947f..508decbac2986 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -113,6 +113,12 @@ static void lpi_device_get_constraints_amd(void)
 		union acpi_object *package = &out_obj->package.elements[i];
 
 		if (package->type == ACPI_TYPE_PACKAGE) {
+			if (lpi_constraints_table) {
+				acpi_handle_err(lps0_device_handle,
+						"Duplicate constraints list\n");
+				goto free_acpi_buffer;
+			}
+
 			lpi_constraints_table = kcalloc(package->package.count,
 							sizeof(*lpi_constraints_table),
 							GFP_KERNEL);
-- 
2.34.1

