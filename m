Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA860C40E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJYGxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYGxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88D42E4E;
        Mon, 24 Oct 2022 23:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHd/lfKBZIC6SnrNJIanSQ3Njxotlx/6WtCXPui5tx+OcdUnqa5Fal0eJx9csZRPDR2XPQRVXJKIuBprJ1sPeyMyR3ZDEJFTyx8whQW4nsqj9S+0ABQ+Zf9RbbN19ZE4Yqvr5So8Hhfhx+ETFObKceziGdqzYf7rvMfgRZyOfqemu29ymMeIKUrWkVMcWGFqrLuHeJ7XPJCQmVRV9Sr7VjFhIsG/JocE1KuNu6kRKJpk4EpuWeLXPu3/N/3Yf/SeeHwY1RQ08Wv+DhXRvTQ2y14e0kiAQPj7eemXp9ecAXvp228YtZLGMdGif5aMeHRy222djZ6JIcPp3AKrQw53Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qim3nbKB+i4XowF4RwWsvHZ41O/PxAGFMo24XcwqCc=;
 b=Mu21/BlmQzkcbil1Si1NlDT6Trtkt8NafeZCpOv+zTC+X65soKNhEU/SHLB7shxa/liMXqsLBUr5tJFoMct9SLgncdtrkZTwG2rh7kmYC0NSFwrb787347B4IfQdmJ/chlXRehIgg5hSSpikx0+jDDRcWRPNIdZml/CpAkuRb4QL33FeIlKzNnN3T27Ul+EiApcaetGD6FOCbwH24m135GUFhmrrD6ztvh/IQRvCCxtq5SQscLONkxRxQPnOkbXYNN+1wpW/2/VGIl0RPCJkJOVUBTKRrRZN9QjvkU1gLGWh43VcWES3d5ZCNrYB3R4t7xg/hBIMrdhEgimAhzSBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qim3nbKB+i4XowF4RwWsvHZ41O/PxAGFMo24XcwqCc=;
 b=k1jXzYMbNWO5R/re9ACEjCpF31OIrBb0vGjGl1Yov6eNAnJQy7aNPymobf7aGD9S3oyLwaSgZ3PTt+KWtMaQ58gcuy51l+wnlyXsUtNY1HMRz6fwYsV1LXx6ud8TCM2Mz7JCJw92nI5GXFYUBQck8/UQjLbeV/Z8KKdiUIkRWnI=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 06:53:08 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::13) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:07 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:05 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 03/13] microblaze/PCI: Remove unused PCI bus scan if configured as a host
Date:   Tue, 25 Oct 2022 12:22:04 +0530
Message-ID: <20221025065214.4663-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DM4PR12MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: a511c590-84fb-46a7-0505-08dab655932e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Od4pOhVnl3uK97cbtJwnzH91FsnyeYiMUXjcaYDlLdSnuvRiNpiW5Nk2cHoCBXq0sKBDwgiur9dnnVcJwZaY3S8wvrmPnQI5edRILrIjVlmpzxRxTiJSPfysAuJW+Ww86jNr2sUkLH/MFMjUy/WXGQbxgMSARPcdAIAJX+hPfotejdJjmVDYYQaDBfPG4l+XdqiPsfqmaSlMTXfskyPkrV0JvIhGGLbkgkK7Kr/IQeS3frXysJhVa/ReXVu4GzXvkDoOJw/ANsdyn0ep1wQ512+sr5MkFLfxpA7bGes1CvCNHQK1pPvX+DRqjeR8ygZ6gqfvCDaygwokTKYMZJsOD4cchmYAgxt6ocYm24UIhDcchpqrz/NGt3jRxTiXrZdScZNTGgNC2uSxvf+vpEUM8deuTgWyrbKbg0v7Y/od1AFUiF8s2zcYEEFWBarplMnKXTZbe98AC2cZJl5L/CoEKEkZ4IPk9b3rhR3NE//vW5CnKaNJS+XnZBCaJ1mVRmiuPMQl87XlOosQpfRxaLn03AnnzfqeXPTYJEmexckNX/S+ZNmN+lar/R2YtKZJmQCKSGxdEnDOR7DncGdgeXfItDRgvWcYbGb+M5VbgU4fLCoZ2wuLE10HXuUWwJAOOOslRsWdpo6826biuJg98hWFxt9DFfL7bmtGAnQdJDE7AnptuR3yNPlWSpOL98DiLBzVHUbwnS578znW5MYQdr1wI1WiW2/oOtrzfNbMFkgVTrxArgskaRJ+Eo61WUHBJDlVzCwYFeZWAGpKYrUu7RnhoMhd6F90Keg1chhRO3X0iKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(36756003)(40480700001)(2906002)(54906003)(1076003)(70586007)(36860700001)(110136005)(336012)(41300700001)(316002)(70206006)(8936002)(82740400003)(81166007)(86362001)(5660300002)(8676002)(4326008)(44832011)(426003)(40460700003)(478600001)(26005)(82310400005)(186003)(47076005)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:08.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a511c590-84fb-46a7-0505-08dab655932e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This routine is meant to be used early during boot, when the
PCI bus numbers have not yet been assigned, and you need to
issue PCI config cycles to an OF device.

It could also be used to "fix" RTAS config cycles if you want
to set pci_assign_all_buses to 1 and still use RTAS for PCI
config cycles.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  4 ----
 arch/microblaze/pci/pci-common.c         | 19 -------------------
 2 files changed, 23 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index a9d3940..ce74b0c 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -107,10 +107,6 @@ extern void setup_indirect_pci(struct pci_controller *hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
 
-/* Get the PCI host controller for an OF device */
-extern struct pci_controller *pci_find_hose_for_OF_device(
-			struct device_node *node);
-
 /* Fill up host controller resources from the OF node */
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			struct device_node *dev, int primary);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 58397cf..6ccaf33 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -122,25 +122,6 @@ unsigned long pci_address_to_pio(phys_addr_t address)
 }
 EXPORT_SYMBOL_GPL(pci_address_to_pio);
 
-/* This routine is meant to be used early during boot, when the
- * PCI bus numbers have not yet been assigned, and you need to
- * issue PCI config cycles to an OF device.
- * It could also be used to "fix" RTAS config cycles if you want
- * to set pci_assign_all_buses to 1 and still use RTAS for PCI
- * config cycles.
- */
-struct pci_controller *pci_find_hose_for_OF_device(struct device_node *node)
-{
-	while (node) {
-		struct pci_controller *hose, *tmp;
-		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-			if (hose->dn == node)
-				return hose;
-		node = node->parent;
-	}
-	return NULL;
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
-- 
1.8.3.1

