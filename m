Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACE786405
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjHWXnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjHWXnX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 19:43:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1054C10DB;
        Wed, 23 Aug 2023 16:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbcoupKUsGjvypmL5essOVDI7a6z4zH29CRCrS4dwbZS0xMDyTySFNVJ1epJE+fdVK+T1kWMHIQ8csuRj4ulR0wHJWqeKtU/DQCshMwNh2kh11H1Z5ZaKlYPEysrbZcWmFXSJWasmCd2WVq35UCUaaaIqlgHprq7o4gez2magcYoWip+AGfqdSgAIJ5GHfKuqBb/1KMM1NxAnjYtcQe02j5QBZScBrmfxQo41rik4eSf4ZB7ArwimcxJH+qjfRIADN77Fuj57vjOuA8l08GbCk0X+K8lMmb+4oR51uNrBn1zKWOUfbDSGH3HwhdzpNigwdEi18dokJz3NemtKUmb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEQDOtofzDNcuxxkpsvWr6bA/oWY/SgrOHxI+YzZGuw=;
 b=eAHS/RVDnKMikXtYnCgf38afjJibytjmrCYANj+sauxrW0td0VHtlZYSnldGTZ//UMzKH/pGnVX54/OrY6Z+m5Osh0ws0BXjWYx3yPFiy3RY4soJWZVYISTWwXuQzD2hfo+q7ZKhXDz/ejpuCnM9A/rgGe4pnIuki4k3cTnIy+LhFCrts6R1RoFoy35Yc0kzMt+CWsDSWShmL7gTb2j7QAjHKkdyqROHvGpz1j7F9tqku4qj2/LrQjK/w09kPKFMguZVtXC2yD4YyTiqTYao3xE30QqfEdITKvPWayhqpum0VddCk2bubhUuwVvwr+IRz6zMaDlQ05udGft7szWnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEQDOtofzDNcuxxkpsvWr6bA/oWY/SgrOHxI+YzZGuw=;
 b=x1JMHoE4opoBaVHrCHJIs5bNRm0HxU2FY6cDzlSlAeOovhYkqz4ZlFLbxH/y/A7z2yrhpu6/RxZAMxD1vVSZQLl8niRSEm0qiltFK3MEAg1di3SIUDr64tJMgw5eVRY19jt3HLhL8Rw6w6YVWbU2aPma8HowKFLj3GRrFseAdVY=
Received: from CY5PR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:1c::34)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 23:43:19 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::f8) by CY5PR10CA0015.outlook.office365.com
 (2603:10b6:930:1c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 23:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 23:43:19 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 18:43:17 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 1/3] cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
Date:   Wed, 23 Aug 2023 23:43:03 +0000
Message-ID: <20230823234305.27333-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 15127256-14bb-4600-20a1-08dba432bb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxGWf6s0Ikq6YdrCE1HnjSEiyCxk2QCc4cEMeELWHItQyFJ4IE6i55noODRA+d88ek2dIVqAl8yqbgmJL4vDzJb/pW8ezBkYh+eJo5ffsXd+A/gooxXgzU89JZUNDcH+Bx1Lofx9eoTu45fMw2HozXVQQKk7uV6PYARmtiEww8GywULIks+WLmdVrqqfIooj9I/DHnNb+qfACbFnz/1O8DEcjZThNWfGTwqPPg2ECbDaJ1nzuXC4cArzX2KsHCoWY2R29yM0YqoSy8Y07EdoI1tew9kdnnNzE6PKkGFVprPNH4mwheacnOUwgNHhuVrvB3LgwRKNz7Iyqtx+DigZlKpq0NTMxuifHeahstskwjvYYA2BxvTm7oVjulC8dOLeVCdjEN+bWvKFE6CwD6sv1WvUj0j/D7+tTgZCdOo/TjSPwiKiggjvWGpFAaztxOdz8dfV04JsY3+73XPTef9YL9NrPxCHRSEReLXiwSo9V84eW71ybXe2LbV0ofoIrliVgs30sNdMt5FOY/hlLRUJKRlzbYuraQqoEcVkTsLHg6LruxtP7S6add/JRdpnZsxrQvO2C4P8mBwlMSfBv6ngbK+j3KMj4Uah8UXBPieMNb2m69+P2jHXW3ePznNiwTi09RJHtqA8iwXc+bY6viSPaotYsSVOCsOPPTLNHNv8+ht9PT1w7Rkt69vbxKDEkAhpqzizqRgeXfwEqGhAsWy7v/dvh9zOHFHAU+4pbQOR0zKRzx2YKUaI7x3xvG7JhvIsGE3IM3BEFnTiddZ2xkDlEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(70586007)(316002)(70206006)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(7416002)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:43:19.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15127256-14bb-4600-20a1-08dba432bb03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

cxl_pci fails to unmask CXL protocol errors when CXL memory error reporting
is not granted native control. Given that CXL memory error reporting uses
the event interface and protocol errors use AER, unmask protocol errors
based only on the native AER setting. Without this change end user
deployments will fail to report protocol errors in the case where native
memory error handling is not granted to Linux.

Also, return zero instead of an error code to not block the communication
with the cxl device when in native memory error reporting mode.

Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
	Added fixes tag.
	Included what the patch fixes in commit message.
v3:
	Added "Reviewed-by" tag.
v4:
	"Reviewed-by" tags.
	Complete rephrase of the commit message based on Dan's comments.
	Added a comment why the patch is returning zero.
---
 drivers/cxl/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..2323169b6e5f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 		return 0;
 	}
 
-	/* BIOS has CXL error control */
-	if (!host_bridge->native_cxl_error)
-		return -ENXIO;
+	/* BIOS has PCIe AER error control */
+	if (!host_bridge->native_aer)
+		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-- 
2.17.1

