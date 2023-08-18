Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15146781374
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379663AbjHRTkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379667AbjHRTk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F8421E;
        Fri, 18 Aug 2023 12:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO5iOTQL6IVORtMtUvNbGs2aQ16pOEm5Y1NYlSTB1+6JpieSimAsN8t9GPuSE8cimwsJTH14IRxGFoQotli4AnmAtoYO8XQkV/yJKbVyXznLBkIjcubsXW4mFs+2PeAGRde7OPOtN4qpRn0v75ox0lvSE8228mo/4KzUCKfGOkl0Lru38mr8/v4wFgj6zgiv+nwn9Lx98NTFu7I9HMNUnsB9ZwyV3SPggq3VqYHOcdyJDh6kh5llJKd3L8jlLbr+MhVUAAidiWaJ4pBTa3uUYbuKH0Eddb3kVHi6XXizXyijtnUE4uG9cpZ+gWnd1H+00ukjn74D8mudzhRRdKMetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=iciA2fpFPo4wllXtEMXXF/2BBDC6Do6IwMZjjH5Cl7YqztfyUqcsErcIBTC6dCNblQXmwKoSH0/jn0T4J7lcjCYoJIXJ4M2GJk822GjtWtJ2Amu1wuP5ye95v8C/0RecNN7BExO76ZZXx0QieqQon5Am+BSHVvS/qsmu+9VoxMM26im2VR8GdrVoBcJLmf1SRIpcfQQVH4rcGN4vDwXca0e8oozli3G50nOny26K9GeSobwcEwjXyT7c5KFtw//06XFiExwwbq47FGJuL74GhAKh2bssvEe8P8LRSWQiZZiaBTcHm3/LjqZzWjc2PtrZOIYNABD+9yx+TwqgFPx0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=znUZS3gU83tRK0N9kLnPSfl00cEv36itSTQk++mbQRrEXiNL69X1etdXg/U5jiP4vH6NMt3IcRbUQjkV7mHbOQBg7qeXwL4maANqhSE2M+/ywQW+X5H1WqrwYuLw/okg94ax6HWS/X2T9zYt1EoUotUcIJ3IVLETKWk2Xhdjv7M=
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:22 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::b0) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:20 -0500
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
Subject: [PATCH v14.b 3/7] ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
Date:   Fri, 18 Aug 2023 14:40:03 -0500
Message-ID: <20230818194007.27410-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e24d7dc-f4aa-4913-32c8-08dba022f641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFc1apC1jvk353TILoeRDNf9u+DtgA9fKLRCfzB0NrAl6uHRFTY4fTx63gpL5Cotz/hjPNK8j/we3zwrgP0ddHffELhKN0lm+IL4v2D2ZjI7YZ2ocwYL07G3Vq+gJUira9HqUSGJtE7DbxlMYof/O67yZI4hxl+UO9Qh2iXrLPX/C5XpRX67RpdX+P9BF3S56sCo7zoZNMZSwuxCGnEeIRpxlKcYDoaHEUFmofDNoMd6Di9krlMjDYh/u4/sBYiNC6yhogsAlTHGRIa4e2fFFJLyXC0jAJNIqqXW2kdtBfMDiiZbGnRc3jdGoRWUKeWMzJ2uhXZCcPz8PuxLVJ7fN7OWYtzV+jfvnySiyaBKfGKLeDrNKPmjltGAArLDiD7+J3b4Ji/fbNhaMyO6WdfigiIeYbJeq2FMDQBRYf9U/IvQsdlIqo3abDP30odSDMb5wKpWuqoEivwFfYLcb97SCrxVPgwuIkO8cJqB0xHP+qRs1Rr0R+A0M/zLXAPnS9lBnhqAXVrsFWEtBbM1WrIB15BYVAjv8e9nWgw4I8X4ZSWW5g7d3sQBZaq4msZTgShEDDosC4PYSCyRaL/YP171x+EI4HV6s/ucpGKpD2KC3gDUCoMg4ywEgkUK0KSzahvrM5KHbsxPt8YvD8wptrAhZrMXt/5vAeNXdZCN58pPI082nRSVDGKiAbmVB5OfVhMV/M5Py0bYeRMTeIQSYuvBfdeoAGVeoe5zQdhXMN/cOBK4T+ls0oViDdABgGYISfSHgkq1wWDNKZT5jUvUBOyBmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(40460700003)(40480700001)(8676002)(5660300002)(4744005)(8936002)(44832011)(2906002)(4326008)(41300700001)(26005)(1076003)(16526019)(7696005)(6666004)(336012)(2616005)(47076005)(36860700001)(426003)(82740400003)(478600001)(356005)(70206006)(81166007)(70586007)(110136005)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:22.2138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e24d7dc-f4aa-4913-32c8-08dba022f641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

