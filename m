Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A19781370
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379633AbjHRTkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379658AbjHRTkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F03C3F;
        Fri, 18 Aug 2023 12:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzApI4cNn5jahxd114qic1k0CUxd6eXSxr/2NUhiK3zNLL6+3Iko5LAZSB034ysOsflkRshiTXryFwTEU1/rxe+odHUjEryn9QTBHO2Nd8inFr/CxPjoFdpExuWybLmH9+7QH35x1YcCF/QW/tIaW/nnAgLqonDdpflzZU1rgspphTzHOBwhQpgYeHe1y3Q4raDLp+Z+zGZwZLNlyzBLo6klZaAei3YQajCnJfR4fQ6hRcWkPhIiWsjZSjEy/iKU8zT5U0WF3ycpuf/5EZQf0fc+fS5AnHqU0ECZclBLB0Pqw2nr3zYY1oK99NtQCnHEvtzMJ1w6z1DunWnS6wWXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6ZKgrHOqIXPWweiZ3YaRGMVfgKIDuQZQKDAPFCYsMs=;
 b=ENGBR3qRaDNut5w0q1Dq0X8b1ICcZQPitQEXzQSS1owtrhiRmbRRHDzEM5Nn05WhgCaf89op5mPDUctfL1IRbyKw8UtSjJAiJzw4rZP3+tRoL27dalwJsuVWr38PaeUMezRvZweZqrOVAIUUzL1XUKbXA07VvLiPQgwQmEAJAehtduqf4IYCeHzIBdw6BEhBPgNCInVIY2GnO+Pm2nblq/pP9u4w6AttpU0juCXobQzv+0iRKLoz4qmC7Q0TgN48jzkb5Mvr1Yg/J0RKd0NSNoe3Beggy+MSIeBbm5QP2u3AKaCSt79Xv0JUWAdFbH2b6iqBulVwbB3lrKZylfpV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6ZKgrHOqIXPWweiZ3YaRGMVfgKIDuQZQKDAPFCYsMs=;
 b=XtwatXd1Ra3FdScQy6Xy8jecPRsW38N10sswt+ibXiNe0Y0Cyrcdla2aMhLeS4+tbKrhJF63MOzcyvjDaY7y+yTB/VN3av1u3IP43qEsjgpmiyTqXbYILJBgEI2UjG9N/Gt7J/h8CG0n7R0dy0tq49/VAQ1CBpdp8w8ZnkLY3e8=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:39:57 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::19) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 19:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 19:39:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:39:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Date:   Fri, 18 Aug 2023 14:39:32 -0500
Message-ID: <20230818193932.27187-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: cc626ac1-2bd6-46dd-b6ea-08dba022e747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uWw1rQttwnBY/YcMAHnNvxPDWcqBu3gOqUHF9Es29lfN5skUcWMf4Jf9I4arkTD4ZuJ532WpcvrlEO0vTfhsrn4l/XmkDjA0qoOo3dzGLY0x5JOYJA7QGbxS0J3zSKR9bJR+B47Xc1/Zf6qdcr1sEAm0OCC9ps26kUIMaoG8ua4rKTH7BwrcRfcZTKdawtBCca1NbgQSGAuQZ3PVlF5ZGZtBfUObg2erASaATu+a0DwR2eo6liIv0rrB1+j8bJcGPayvw/k7RrC+PAxFc2eCmRCMoksBe8ljJIAqryJ+j4JJUW5ogAYEfojFowgYfTKvgn2svAPxzedXvpIfYFXBcLwfp40WIU0nfgacmKzqqTXz/N+XjOlZzOtTV0f7BdH3a95M7ypq+G/iG/Kq4xDRSjosuT9JB+E3iU1KIx7MYso6YX5KorXgEWhSnDSJWwkt+QubtuMqQH9iyAko9dYOQisAcw7XCdeu3lTfdg39kE6ci0DFaKUcas6zr4RqPDnsSe+e7zoJl2/DXbIeWt5A+kPmPxF+v8ahX9FLzcY6CwqQGBX1CEKBBV9xXV4zl/eiTXlgo4Oj5fJNMDJ1JNyor8DtA3FFHwrGtMgW2LvpQtmW7KVcoKMrj4LYsXM4uWZQBqcJid7ZwfCHhV4UgdRvLoBz6GQ1fpXEt1+FZPh3E5IWK2Q4HrjZxYwFDt0gD58kXe3gdGGxcqdOxonLt1fcDbjla8oqWhtvBJpMh663F5tGvn8w74pb20yfpX6RWfC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(110136005)(70206006)(70586007)(5660300002)(44832011)(2616005)(41300700001)(2906002)(316002)(54906003)(966005)(8936002)(8676002)(4326008)(7416002)(478600001)(40460700003)(6666004)(7696005)(86362001)(82740400003)(356005)(81166007)(47076005)(36756003)(16526019)(426003)(336012)(36860700001)(83380400001)(1076003)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:39:57.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc626ac1-2bd6-46dd-b6ea-08dba022e747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
changed pci_bridge_d3_possible() so that any vendor's PCIe ports
from modern machines (>=2015) are allowed to be put into D3.

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3 and AMD's platform can't handle USB devices waking in this
case.

This behavior is only reported on Linux. Comparing the behavior
on Windows and Linux, Windows doesn't put the root ports into D3.

To fix the issue without regressing existing Intel systems,
limit the >=2015 check to only apply to Intel PCIe ports.

Cc: stable@vger.kernel.org
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
In v14 this series has been split into 3 parts.
 part A: Immediate fix for AMD issue.
 part B: LPS0 export improvements
 part C: Long term solution for all vendors
v13->v14:
 * Reword the comment
 * add tag
v12->v13:
 * New patch
---
 drivers/pci/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..bfdad2eb36d13 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
+		 * Allow Intel PCIe ports from 2015 onward to go into D3 to
+		 * achieve additional energy conservation on some platforms.
+		 *
+		 * This is only set for Intel PCIe ports as it causes problems
+		 * on both AMD Rembrandt and Phoenix platforms where USB keyboards
+		 * can not be used to wake the system from suspend.
 		 */
-		if (dmi_get_bios_year() >= 2015)
+		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
+		    dmi_get_bios_year() >= 2015)
 			return true;
 		break;
 	}
-- 
2.34.1

