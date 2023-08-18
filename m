Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E537D781391
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379673AbjHRTlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379708AbjHRTk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696C422A;
        Fri, 18 Aug 2023 12:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6BnGn6jfhfCdf0Y5T0HZFpcHyktHGzMVxjK2CmoPM0AGARnrxZMcvA0alK2ML3O3xb1bBXKk9H/F8f1wPP1QRHNSi2uHC1Zsqmm9tfyxca59tyHkLizizv5ief4uHLcLqMLLkrQ0yLYu5E/bTP2u2FDWi8s33lubr9YHnULGWGRqlR/Gk7ERKoXdFO9zYE8dRZsXQ9ydTDGNaZ9I47RjJD1yZLF4ZimzL8hf7/g0dAa0fZf5l44IKq+T6pbO5DGkEL55wIurQMpEGUNXXAfqC8Vfg3wtz2WnEG+FOwj2ybqyMPH0Z3STM90/M+WHmtxFAyIeY/n1vvQwjsLqU6Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Sayu4PEU9K07ryNQslCaryOHfbIA30KHQDdC6fFVw=;
 b=Pg6HPpNmBRsZ6i4dDD2gQmlnht8txlv01DmL7gd1hQnMQ3vvXM+INZKIWtnUkf5mMdDtKd2K9bFSZ8Zr2fsFRgvdGrudSTeTSjodYifHrhDRZX0yiO+fhyGrzVNeJmLu9oy1ql7jC+uy6bRt1o0Idtu5w5+9QN026/8GTAkPPXdeYpE2h9LlBG04VFQCcOMQ9pe5RO3uh0Hraxcz4IKOH/QoeyRE+vziJ85vhCHw9fuoOvZOPWW16tYpy2Ux1n+uB8ylCIcpS84XggDL/ocl7raaLsMgYz0WguM26ziEA69FRHj3sIHyiLNAaM05dUwwDMyL+6pcJosuwjfsJjj1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Sayu4PEU9K07ryNQslCaryOHfbIA30KHQDdC6fFVw=;
 b=ARdzCqsPP+8WBPNPP5bhoaoqR86SbCCuM3ZMjTlX53ExEVB2d1wRFn2DhkWwMwU6nMkKg6B1AvHDBF10jjLfCDtNwNSknjy9hHlh3K62jpkYpXBez3kuO/pvb4b9aMqcgweCHCjkygBSJuochl0oFLn9H7kCi41QUXAOsfvkMZs=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 19:40:50 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::80) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:47 -0500
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
Subject: [PATCH v14.c 4/4] PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024
Date:   Fri, 18 Aug 2023 14:40:27 -0500
Message-ID: <20230818194027.27559-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194027.27559-1-mario.limonciello@amd.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f41c213-d296-4309-cbb4-08dba02306ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZnqqU9Bwopuqsz2FkS4Xdt3JVy9iDlT/k1a7xkLQqiCXRrHYR1tRxWr8LNlqxS0pSJuwiyEsyKGK5LbvrUzTHMfIVKLDni68+odDJaDqkZfmzipJBVzudgc/uOM2KpFDvLcnpH4VCo5x87+BVrHRjAQHjW9hV0ii9/Zt2F8PK2mC/y1+RKrWIwDEnPt4ifxSXQPAGfQB2CI0BSJGwkCUqvfhs/ZMLSEbicGO/g3Mgub0Bs5CsjoUbR1CeLQVDquQDPAud1RcqFH/XNih4HI06ccOqhJo6Hd9YeDUfeKW4RvlfTddC3oxvtzz8YgcnPG2R/f2zz7xywwmZYFcZCL6z1jrmhmWgB6QsyT1XIz+Mv+Ej8nu26KB8P3oV2q+jM2kGhqtUXCEJq1nfihW6HSk4XR5jPGHKE9RQ6HZMfEJeqPc21RKXdQXiZIjU6wlTWhZq2D/hW/XzhBqrTCc75r+sW50lLVDJ5GK4xtIlmX0Nw3D40I8TklM6VbMWlTPon++1StqdsaP05Dm0XmnJyBK3wCGi9DWsG9Ldbztd1Z8bc/XylZVgE7SqqpBwgOPHbYNDGBZ24bXGj+QOJCBOl2mMF1wyEZEMrP0yFmy9yiLiDnkcjdH5TH1fcls6En+41cLVIF1yzNypHZA5ukVRAzEJ8yA75L9sO08TmpGXBSk2BLp4341H6pe4g1kGu/UOWrcu2unM95qEnwucNR0lumUxF9lKDl0l9jp9E8A6Dj+e67a9kWZshHLyqp7ugFVyzlVC2YbWtaF9YZGusXC1ILmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(110136005)(70206006)(70586007)(5660300002)(44832011)(2616005)(41300700001)(2906002)(316002)(54906003)(8936002)(8676002)(4326008)(478600001)(40460700003)(6666004)(7696005)(86362001)(82740400003)(356005)(81166007)(47076005)(36756003)(16526019)(426003)(336012)(36860700001)(83380400001)(1076003)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:50.2041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f41c213-d296-4309-cbb4-08dba02306ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel systems that need to have PCIe ports in D3 for low power idle
specify this by constraints on the ACPI PNP0D80 device. As this information
is queried by acpi_pci_bridge_d3(), limit the DMI BIOS year check to stop
at 2024. This will allow future systems to rely on the constraints check
and ACPI checks to set up policy like non-Intel systems do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v13->v14:
 * Use a variable instead
v12->v13:
 * New patch
---
 drivers/pci/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfdad2eb36d13..c8787d898c377 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3037,16 +3037,22 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * Allow Intel PCIe ports from 2015 onward to go into D3 to
+		 * Allow Intel PCIe ports from 2015 to 2024 to go into D3 to
 		 * achieve additional energy conservation on some platforms.
 		 *
+		 * Intel systems from 2025 onward that need this are expected
+		 * to specify this in an LPS0 device constraint instead.
+		 *
 		 * This is only set for Intel PCIe ports as it causes problems
 		 * on both AMD Rembrandt and Phoenix platforms where USB keyboards
 		 * can not be used to wake the system from suspend.
 		 */
-		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
-		    dmi_get_bios_year() >= 2015)
-			return true;
+		if (bridge->vendor == PCI_VENDOR_ID_INTEL) {
+			int year = dmi_get_bios_year();
+
+			if (year >= 2015 && year <= 2024)
+				return true;
+		}
 		break;
 	}
 
-- 
2.34.1

