Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710A60C428
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiJYGyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJYGyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636944574;
        Mon, 24 Oct 2022 23:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqWwrE3pgnb2oVGQVIQlfkfjbs04vRBsRh/t1NrDh7GLTAdpdoxBPgD1v2KxKYDINqVbMPkCGpip5HeM2kyQ3Lt9m/cjk11wleepmuzrjqNRSBQsihybK+6lJDMZlXKrSBb9jd0KA3UOuzPF3s3fVDimhTKnfFq+EGni0ON+QJKxNQ+lZPzk6Mq07w5xB3cI81AkS9nqZse00vlZurkIrMJavTyzQxgmLVtKsxksCoSs/EOXm6Ae80zg/M6LkjKJeT7jVG/qrdgHPutop/Ctq+8eU4Isi16HJ1TxAhjSJtTXxqXdz9yWEhJxSC4Yp8oLTTB89F3Yum7hnoORVPoRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d96QDtTe1aiAT6E0PjQywwcdCdDnBkq+Cp4QiSx0sWs=;
 b=SYNQR6x+YVGvugkx/5+RqpWjUtEKKPTREEuL4Ob9zWOo2YCipCwcXDmC90JyInf9x+Nv+p/mxmPOd+AyH4z6eEBv6FY0vfBCsK817cVBnICLZ6NyNYNEqOGg8vr9jgqHo9rmzxAm0vxbIIXdWyZ5QIMRu6FRqkpLQ960Jp1cTaSGSOcSIVUfDklf4qYnvndPvzZlzp64tbm9eqzRZKy9Ej2YGB3n2/uMBP5Zy99u3MZtb1rDqZBcsku5mszBzI1I+8D9+7+HyxgopiLf520iSFR32mYXebWBa7ABIoFrMTlG0YLqL2jtJqfD2VLil2gUK9Dq3KCDf/0f6oTAyWu92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d96QDtTe1aiAT6E0PjQywwcdCdDnBkq+Cp4QiSx0sWs=;
 b=Y51ejOFr9fUIh9kgIuvz/C9ZqJehIOegbsfhJfqvWJxcmikU92hw3Pca0LJATB8MRpQtTrMBM3wg2gtRw21rqXgy4fab2yZTX1AMftsKXvpl1NFOo8AwqvjjkaDW1hE0QwHHtNJHELASPYzpnsITU69dGBWPOcDuAh4y2WdRWvI=
Received: from DM6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:100::45)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 06:54:06 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::fa) by DM6PR03CA0068.outlook.office365.com
 (2603:10b6:5:100::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:54:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:54:05 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:54:02 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 11/13] microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
Date:   Tue, 25 Oct 2022 12:22:12 +0530
Message-ID: <20221025065214.4663-12-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d3776a-5825-40fc-16c7-08dab655b58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h22axXyyCRB3nIpP0D7iLOqNjU15O87XWLl+lxo07HXLTrKcaotB2CBlUY+8pHutlxrlC7gLHXN9qhCbxZKK2R5Y3J1s9QE5wfwV98qdHb8r6lXjdPT337LQP4s2ksnlFxd+eopBqnRt6wNKizvlb0fGSE6rpiUqKt0H+ulZfwQzH8xFm8vZwSCyLUPlvzl1pyedc/hofdEOv6CisN6A5iT4vLo4QxHWFCQSs+JzaGyHVWXBc6Ld4msXzz1XmEFeoSXuJUdZKTRJdqDKNdkLT9qqeRAG+N4OH0rB4FCs9Sx998kxWo6nKxa/NQwQi3X5BZYE1GhoK170yQFVAKGKOnpkD2I5Aakm1ZphhumOexQLZHWPKKX/fnoFq6TRunKNYqWUXQGP8wRi0yPybArt8dK8SPVT9gx8HWpvcBCU3mUGOtEuL4qC6ECEaUxnJsMNs3CMnI2JZn0jmtr9AFOEQ080VbHc/jOmSJVNJugi5oF3L5rVuYhNftrWeCTu71wuT90ENa0Z2qexsYqQpSuDjrXpeLn2xspxtcD6wpAcbJhP/SMvpTLQKB8/+zbpXy7OdZUxRMEXtAPrVeJop3yap6lK9zbjIcLsZXt38hO7rh9obVx188UfId19hVo1m9QItJtLz87hiOwcb1jl1bGftcjw7pGWgIuGW7TUtuvW3x6KR9M90BjmXZqpLKMNiEt9XydP2H9rC44lKpgm/0sSPtebbp/Y/OdR0KTAFRK0Qxl9K/rAwq0jWWYvaaeRf2UNteWhJPeX2bA9uGaomTXFaYQHUCRthDYcYKcIPtAtyzvPR6+izoGcJT3F/U+jDkeH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(40460700003)(426003)(110136005)(54906003)(70206006)(83380400001)(6666004)(8676002)(36756003)(70586007)(36860700001)(4326008)(316002)(26005)(5660300002)(40480700001)(8936002)(47076005)(86362001)(2906002)(2616005)(81166007)(82740400003)(1076003)(478600001)(356005)(44832011)(186003)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:54:05.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d3776a-5825-40fc-16c7-08dab655b58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused pci_iobar_pfn() and et al declarations.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  2 --
 arch/microblaze/include/asm/pci.h        |  3 ---
 arch/microblaze/pci/pci-common.c         | 19 -------------------
 3 files changed, 24 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 9c89ae4..5db2c66 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -27,10 +27,8 @@ struct pci_controller {
 	struct pci_bus *bus;
 	struct device_node *dn;
 	struct list_head list_node;
-	struct device *parent;
 
 	void __iomem *io_base_virt;
-	resource_size_t io_base_phys;
 
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 52d572d..a75bf3b 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -32,12 +32,9 @@
 /* Decide whether to display the domain number in /proc */
 extern int pci_proc_domain(struct pci_bus *bus);
 
-struct vm_area_struct;
-
 /* Tell PCI code what kind of PCI resource mappings we support */
 #define HAVE_PCI_MMAP			1
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
-#define arch_can_pci_mmap_io()		1
 
 struct file;
 
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index a1de853..e5c2051 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -65,25 +65,6 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
-/*
- * Platform support for /proc/bus/pci/X/Y mmap()s.
- */
-
-int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
-{
-	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	resource_size_t ioaddr = pci_resource_start(pdev, bar);
-
-	if (!hose)
-		return -EINVAL;		/* should never happen */
-
-	/* Convert to an offset within this PCI controller */
-	ioaddr -= (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	vma->vm_pgoff += (ioaddr + hose->io_base_phys) >> PAGE_SHIFT;
-	return 0;
-}
-
 /* Display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
-- 
1.8.3.1

