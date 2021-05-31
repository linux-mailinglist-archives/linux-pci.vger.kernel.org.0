Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05143956B1
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaIMc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 04:12:32 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:38081
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhEaIMa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 04:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktrS1jW/E9QF7GiScuxMCVZv6Pt2LJs57aWalHBhjO52iC39L+HbM49TUNdUmWslyFEKz9DvRUcwSk5klfT2o/2nzne6JVIGATdueT3bv2s3hYp61G4zpa/K/VUZqRvdyopKF3EcCQMZ4UvraDBw3RHgSu2IzawpF7pU6EtdwSLuScZY2rqvpvaU62L65/lP/Br4mArbsnocaHT8ZsaKcQngdY3EX8zgnbO2X3rmG4rKfmVGtHmPbWcDkf/z31BdgLhZwuO6o7ROv4etMR/LVEajdYNPJg075uH281Uz1gXKWZxEMiqxz3SJ/Z8tweECeY3Eczhrv6n46vgbf45iYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxYVkgCoxwb2XJ/Oc6jl/pNYzw9kOnLvr7g7DaHQ2ag=;
 b=kzce0pTKFQlL+u2WAhHg076xWsjKO8o9FTAOb9nl/HB8ver6jepb3zpWbf7iWN2lRinMsPtc5e/PmWruBaL5TBGepFLbs6AMs7rcDUBY27PFnBGWKvW47r2S1FGia87RK/FRaImWukTCQA4tAewwIfmGjwQlk1HYFTfRN0G0Pd8pHsuGEzB4cAaAjhR4BVhZy4F/ChAbVF43zYEWvZmi1diLSgwZSV8fyZPuNCSkVWUwl7aaNATh9ya6dHtnYdbQEFZa+2LzgbMi84LfWKvhh2jRT7jrte0q3RzqtKbKUt85UaHhsIHJQ2L6fGbpZPCpxhjuDfdgWoIZ1QFI3fakWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxYVkgCoxwb2XJ/Oc6jl/pNYzw9kOnLvr7g7DaHQ2ag=;
 b=M7AAuMDVulNbcuXMn8qJpBIy3a/rezZB/vi00bJDr52KlM6Dhsv+Pf13DJUi2Ys9EU//iOOY2JeuFY8KacC5ZOr0vAgdhFWZL1QDnE07l7Bl8hgFnLxawT6yy6jnM3H/GhCkJOttJegFPWZPbbUdcOapErvmvPGlISUm9ILHnUA=
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 08:10:49 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::bd) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 08:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 08:10:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 31 May
 2021 03:10:47 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <linux-pci@vger.kernel.org>
CC:     <Alexander.Deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH] PCI: Mark AMD Navi14 GPU 0x7341 rev 0x00 ATS as broken
Date:   Mon, 31 May 2021 16:10:31 +0800
Message-ID: <20210531081031.919611-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e81c64-3a7f-4400-8d2d-08d9240b99a6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00929E63C0F1BE9CB80C4A5EE43F9@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrGaEIVJq1kvpu233dcSeH67lvy0toVHBw2KrDmmiMAJvJbAyz//Y5W9nMJqWYaeHJwkL0RHSV5uFH34Q77DqdtdnMI2/vjyr73ziOoRe2CXAEOklFz7OaB7FLf1bD92R9+4QA7CpOwGAQNG+KBKKv58DP12eHoHUKkZy7v3dsc6lkMIxY0+IdjzY6vJvqrvChNPOqi4thFOLraW+f2hP0XrBgo4hdgsW2q+kmdq+LkCK1sDjI0BkUdjCpbfjMC8ttpXvPdp7v7LYXVgo4zIU+q9y1mzD4eCzzXuVHXmlF0E5fItTLrjvgkMdL39nGqdHkb4ilEz5fW9XUFUyvAXF2nDyNgl+NxUxUqjhmZ//FxMPX4xX4j7QY4VjNrd9lwbfJO49aaIzaSM2dG3QsDzGXq/F/BFVI1jJuocioZOXr+5Zaadl0gJYyTrOVMUdih1J4EBmSj4v8UFzpX64R1cpVhqgmW5d5ZCwJ0iZEjc75c/NmdUNJ5uFChcr/LOeFK1Qp9N5x4E5eGNOFUGhQlRsHxepn6DRiUTanWivn3W6PjS+VRBir2CaS3SA9fXiFBlStAxScnD9QL0IECUNq608QOh2ov389PIvfvhVrYF0rXYA826d/HbJ7ri3pwiG4s5bBdues6GjUvX+nmEgN99PWtlp8ooJcRAzg8LWn+YwMhJKSFtDdRT4FwutFuXBrG8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(336012)(6666004)(6916009)(70206006)(186003)(47076005)(2616005)(8676002)(81166007)(82310400003)(8936002)(478600001)(356005)(426003)(5660300002)(82740400003)(7696005)(54906003)(4326008)(26005)(36860700001)(36756003)(1076003)(2906002)(316002)(86362001)(83380400001)(16526019)(44832011)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 08:10:49.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e81c64-3a7f-4400-8d2d-08d9240b99a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unexpected GPU hang was observed during runpm stress test
on 0x7341 rev 0x00. Further debugging shows broken ATS is
related. Thus as a followup of commit 5e89cd303e3a ("PCI:
Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable
the ATS for the specific SKU also.

Change-Id: I3d9d570bd473762e3bfbb251cf8abaf5af38ced9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/pci/quirks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b7e19bbb901a..70803ad6d2ac 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,7 +5176,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
-	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
+	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
+	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
 	if (pdev->device == 0x15d8) {
@@ -5203,6 +5204,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
-- 
2.29.0

