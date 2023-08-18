Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A203780568
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356214AbjHRFO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjHRFOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D828171C;
        Thu, 17 Aug 2023 22:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwwQoZPF563aQrA4Fn08vCwrywkzC/POUt/h5mzSMVZIEq8wxp7uvgdVGWBsD4Z1lwklRfQ/vMgkl9aiLc6unejDkP4M7NVrcu9XlEHVYVpninTgJuDSVlNnURSnMRwZfXgx0KIRiKk8Z7r+VLPmR9uhGJln0qXzYEt015M0J8XggVPApXiw8l56YsukoyZxVlOV/iA3PN08c5iHlB0l+w1AaS7RrVCGk6q6wKssmzXFIqyHeL5tWtxHwmbH16AQDjlBfu3jwOEE7UQgXJ2qo2GCzdITAvLaU07pPG7xIXcXAAn1hekRbRBLO7q574b45mTtJxoTBjoNa10gS0vpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEiDlO3T4brGDkVTEm6oj5nolg5lnzhnVukZlSHVBSI=;
 b=mI86wAE8Iel3Ud+uqjv8NWZTjtHAwDlFZBYU/KWnz9ICuH1ujOFv/X3al/G/wcg9H/7JKlhS6GvY2SR2NZ1SIWb1jtgR/tuW48+yS+yxRr14itwiRxLYzP/jViEGaozzat4yfpJSlMsCjNJ3NyzlaVoLv8nvlqLJfNgop3+qHE5L4vR0QfgJb39M6MfqfD79HO/clPz1NWBSefnTR4IFHJ9JKLerU5fVhQk+3b/YkY4oEaeoVsPJefof0vyXKBdPWqth492I5Zbgg9/+1ph9ZpKk3uQ3Vtg/b1EorB+kI9fnJwc2/l1Todz838yoGVgmFwKp1Abs2WbWq39xemeWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEiDlO3T4brGDkVTEm6oj5nolg5lnzhnVukZlSHVBSI=;
 b=rnpNERsoqZJ5QnA2WnKC7Jv/rkxCXBQylM9aj+SQfwBkVoE38j02DgtcnO3xLwRInPqspsuKAP1FcyYQovOQX3JqTrubalQByLHGPyLNBRDzNKBX+1kooHI0A2nAu0gDLIa3dNpLeoyLQVs0sxHfO8zl9H7kAV9aJrzcL8klXMY=
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:14:45 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::f) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:14:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:43 -0500
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
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
Date:   Fri, 18 Aug 2023 00:13:08 -0500
Message-ID: <20230818051319.551-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9bce19-cde7-4125-ee4b-08db9faa0970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOMXDw/cMAJ9xlSi/7k7kXLYe77jZ6kIxvIdSWpKi7iqDzXIh0ZsZC5slEsSzSkHT03GWBciC+E8C+oIcgMtX7DR4is+EfJ2wO2rK3hePdNPuWI2FqkVFgnUT3NSn6HD3R6rTgBpuRsr1PJsTQZdopJWSWzX8JZ4l0EamjP9dnIPIrhyonYg514lRywIZ/daHV8mEveX16JwPHXCFj2Tpd4nzxM9aBI8VzEX5akB7jwt8AyV2OzN49LowS3TWOmltNIzE0yLJl9Ljg/9XMl/fEuuJEUL4Hg/bQBVcbsK27/1woX2PtQY3uLh+DWcZ/njqyc40kmWKnHDg/ZodQcb45Y+LFKC91zpSVrO6K3zbyJm1X8L4q/oQ8ppkxVdBZH/JPRxGEuw2UX6U+/mxfcAGFDDcrwhT6ppmpX5tVMDyRo63KlZ76EjOrDMsdCgTGXUt+SCZts79RKX1GRYFWrfz6vSaDnM6Kk4kiC7lqcuLFtOUiQxVgLrz8MxkdgAFoyshdkqC597DzSRaarkmEFkQoeWj5TFhWUhNatKbfkEYi2rohT0qiJ2QtuuK7mHr5RRbBKeR5X9Ra5XMmgTyRJANgvJJqppH2vsf4YJxpmFiMYTWPb3Yps2GWcelAFlB7v5ysXDqRT1ryKRTWEe1ULh0B6Lvw2eOh4psEonIgxY50RcFLMyZru85LDf29zQRXxKagjyfe+0xPm9dJMDIHemyC+Eo4nJvsCLuOLJjdo0jKpHqAmIV0I4zMOi2n7fbZS8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(83380400001)(40480700001)(40460700003)(82740400003)(70586007)(316002)(54906003)(70206006)(478600001)(966005)(110136005)(81166007)(356005)(7416002)(44832011)(2906002)(41300700001)(8936002)(4326008)(8676002)(47076005)(2616005)(426003)(7696005)(6666004)(1076003)(336012)(26005)(36860700001)(16526019)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:45.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9bce19-cde7-4125-ee4b-08db9faa0970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * New patch
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..051e88ee64c63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3037,10 +3037,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
+		 * It is safe to put Intel PCIe ports from 2015 or newer
 		 * to D3.
 		 */
-		if (dmi_get_bios_year() >= 2015)
+		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
+		    dmi_get_bios_year() >= 2015)
 			return true;
 		break;
 	}
-- 
2.34.1

