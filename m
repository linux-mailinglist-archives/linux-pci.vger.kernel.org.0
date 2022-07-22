Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073757E5D4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiGVRsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGVRsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:48:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC293C04;
        Fri, 22 Jul 2022 10:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Xowwj79DoA+NBJUQhLtXJU82Mo3SlDfkIWXCCMPDUxO8TDqGlUO3h3WQ/i2uhOdaJRJeHxiTQdqQnd6rOuj4CRN3UoSzXeLhfDzeO06GA3Z2Zq23alXJkmE0ZejKHfhaBq7VH5qlh5zAv4ylNpHmB6aCTZLbgIhmlc6Da8sTW2jbfaX4ITsW1PeMgz9Qps0Ay7PRsI1smB757ooA6Chwz1V3d1UXcAjRpOdb+YFm2gBFWRvDJMyR8/C1zWPlMkqJ0DZ8NJ98PK0tl9tBqKE6FCS4mj/oJDov8OOv17L5W168VXPAaTWWiJ/E1VgGwkqwIrrHvhUn4ry3Av0LrYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDVkfP59YA22YJz8tFI/A/zeGNjajA/m0NEf3idJbVg=;
 b=XJdqMB8uvTDyR9Rb/6DJgC+QmYa2O6oEVfKQEJbgZT4hgLDYrjZ9Vj59c0iDRIv4KxLo3THuFIFveNtqxxQnpY8ucYaSCzZSRljGt++qp9mxJEGCGfsBwnWeDnwdvb7pgPcNU7mqX7TuQ7D6fTT94XdO4xKJjMylGaMwL0v8fDfpCDccvdd9PRegigt3AHkqNOZvGjFvljVIJMSIFwe/uej2UPedVyk2s3s8t3v3S2K05qhtejyW948YlVLpMpDLC3EMren4Dq1qyBHMrktb2xg+rz8ty2DAA46bgIab+JcaZMR6n/XOGo/Q8bvYwlBvV2qSpI7zCUpKcQuMtfPuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDVkfP59YA22YJz8tFI/A/zeGNjajA/m0NEf3idJbVg=;
 b=yaqCjcUM1bFycoAn/WZeSgImhI0aqOY1kKr6JS3Qbe5mKGf3LmmOuQ88RK0+kwDxE4WO5KGDC2h4F5luHt+KRT2neRjn9hKGD7nH7WBBCm4+GgXnsyMfPfZJlWm1wo9A5nT/WeZGDyBVLbaq72UTcXlbxut6x/ixuGLZvPEvx3M=
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 22 Jul
 2022 17:48:06 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::1) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Fri, 22 Jul 2022 17:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 17:48:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 12:48:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/ACPI: Update link to PCI firmware specification
Date:   Fri, 22 Jul 2022 12:47:54 -0500
Message-ID: <20220722174754.27921-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d17e137-dd99-4482-0ac4-08da6c0a558d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1194:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPn3qdt2qRgvQY8eEx/Gs3Y9QukAEa/QwdJxq1cw9o4M9Cfm8XFv6Xr7DKW3iGAx4pQJbpuK1ETCMYmSEIVYNZuUg9c7AS9Wr4UeAndJTP+lPNKhnJMWT50n0xLNZNOlBqjVKOJPfYaDwLM63xVZQEEKVHuwEkpKyICT6krdu+7NBHZ7K0vLSm61UzeZ9NQl5TknN8J+/xRK+0PCuSIJcl5B2bJionyQ/oHROu+VWOoN9B1/pdVHCtNkU3uKcqcMF4eqnxWNsB9rYYkaYzBbmT1jjlecf0SVzsHkn17bB/l9db/XqEFm94Az76Cu8qzPjGmF3G+B+j5oqsS89uytAX0+7IHzn43rgfk9/KOID5VEZhNO+hx+3MoH2YOE7owrlHv3Jvq7J3lihvNUonirGMHYNnIG1u5Pcb5C9RkwmLw+6hPKgwdmzeuzPJBT43nTBY9oL8S9YfqilvlLnYm6wGqA24jiCJ9xOZnOeR68cHt/Q/fzvEHTXsEgwe2EhVMUtuCr9CIrNOi1ucxx7Qa3FXJGP3wUrD5F7s11TzaJJyvKPOs7raWMVScfl7ie4dlxxiPwpjdjo963xd+0xs8mo/BbVvaQxQqL4gYTIDgueGeNH1hx4J9Rp1MjmIWi0QtyM8mq8DYyI0mT7O+d8J6QNtFBcne/3S5RJbBMahF5RQOb7HXT/ivXIHLbV3/OH4+wnSDwOtHJy5pPLeh/LqAF1pk08ADOAYdxX5eXZumCpHJzI4oGDxn0zOYO9FXSQl64sJaTiCERcMHhIW1779aZRRUjbbpqVzcBLunNVu+ayYdyV79YQfvAKPL92WY8qcz88Eu+BjRGMgCG8LOwhaFrtcirzl4MpADFxFpUVyTIV9pVCcxnBOSW+ngWm3NgA+eH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(36756003)(54906003)(5660300002)(8936002)(15650500001)(8676002)(4326008)(44832011)(40480700001)(70206006)(4744005)(70586007)(478600001)(47076005)(6666004)(86362001)(26005)(83380400001)(40460700003)(82740400003)(110136005)(316002)(41300700001)(2616005)(1076003)(7696005)(966005)(16526019)(336012)(81166007)(426003)(36860700001)(356005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 17:48:06.6344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17e137-dd99-4482-0ac4-08da6c0a558d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The previous link to the PCI firmware specification in the comments
for drivers/pci/pci-acpi.c no longer works.  Update the comment
to a current link to this specification.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 3760d85c10d2..a46fec776ad7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -21,8 +21,9 @@
 #include "pci.h"
 
 /*
- * The GUID is defined in the PCI Firmware Specification available here:
- * https://www.pcisig.com/members/downloads/pcifw_r3_1_13Dec10.pdf
+ * The GUID is defined in the PCI Firmware Specification available
+ * here to PCI-SIG members:
+ * https://members.pcisig.com/wg/PCI-SIG/document/15350
  */
 const guid_t pci_acpi_dsm_guid =
 	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
-- 
2.34.1

