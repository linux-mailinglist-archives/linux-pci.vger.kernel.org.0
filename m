Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA260C416
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiJYGx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJYGxy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61C4332A;
        Mon, 24 Oct 2022 23:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb74m58qKYf33zF2Is5CSesvCtN5VkQ8gAOOtCi1zZ1wESv8YS5ZHYnZ4XbU/6CtPVvmzlhP2Mp0h+sXcD32qVJ8YTdG0DqpjKjIdfOFifaBK/oF8ey4PcUy++WCi2tOxWHrnNYcsJzjNN8zMzGr8bNUWDykJoz8nfHw4RFbYZySJC1PFXj8MBFDYiPZ/CbARe7Bk58yGBfTH6CpJ1F5J7w/KqmYLMUyA9vITQXtHFQ8WVO53SLYz90UxvN4Bt2YfEDEp3TAp+t8MKxs5K3uIQHqicRdr+t+znCZ+0PW+vhDa5Nuy22bSdm6+ZS2pAHLvn5QLyPWwpH/jt4YZwJyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH/cfqf9ieuKLueHLHhaOcJB6Bv30CVf3bh3wwEhjIA=;
 b=N2IBSDXvaweFkbKW6GR2LlV2HzZnaTBtFqf4z/pX3gj4BJZCvTBla6ePo3qzTuIVdXftRt15El+ERgCP6IPP4rWL9x8wDp/toQ9G5FGuL0zFg17YRf4zGVFodDHm4dzA+lLtl7RpBfEVCx3tMdjYukDhVLbDP1toak+Bk4UTf1Q4gsu+mAUE6qKmHbB56cZc2V/eNVtN85/uKghvsvv7ju+wbeBn5s6v8kJyjXFRSm13LJjoNn1JyojGIZt5ZkF1UeialRJQ+G+YWwRbsnrnG9tWPLiLvzZ/gp3ejXMDoxDysECHH0xoo2DbJd6DcyZN+iJRUEpVU3wAKsC7pri+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH/cfqf9ieuKLueHLHhaOcJB6Bv30CVf3bh3wwEhjIA=;
 b=miZDp6/SVgateYEdAUper6stg5CKenVfiw/Pt1lfqR/GOvaYLdzP63ePofIBBWq8s8aZnDDxHt5BSdcjM6u0RYCqLIZ6fxUFQMCxr70og4w8M4eBjGsGPZ2YAlvAG38EQW91Lo93kctX8MTQCzI+IYPml57oyIuSFna8Tc24Q7c=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:53:50 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::b6) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:49 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:46 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 06/13] microblaze/PCI: Remove unused allocation & free of PCI host bridge structure
Date:   Tue, 25 Oct 2022 12:22:07 +0530
Message-ID: <20221025065214.4663-7-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|BL1PR12MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 304f5851-1a0e-4d50-9752-08dab655ac3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Gw17mJxEDPptZf/ce2yGk1qGPeBaZXmAsJ4etBikbIeN0NYwhHgg6aeyiTLd279vlbba8E+GTbPI+mgPepX7hOI05yVAwUSvq6IJTt4pgz4JR02OGzBpMMDMWOjEHfCJXnVG8hUWBpNZOM7dq6zaJxh16FvEr3RZejDhOryPmoZagZcPkLAc4aEY7avSzHLEqhIuwYir4SkXMR+Jxzc/7Rv9y4eOKVzLWYq6jp0D2M7gvEXQySngm1Rvz/OxLiuODZzzQWo6duUHD+BoIj5ftjT6m4Jkec7M1lNf454/QRrg/WAcuYlSTKR3QBN18nYtRAZQLug+E3mW9KgqFCA2pueFUV3y8lO/UJZa8c8I3mQLmpH6Kq6nVz9cmkxhLHc391f7N6fo6Nd/Aq7iwV8Z722jMteKZ05dIpW6LrI5pLvDEsfYDlLEO0WlApjd4Ra0i41PO41kfHhxZJIKydci5gvGbzqNMs3CRGtlIteoImJl1nnXIn4oyxchmMcjxdMdfaugO736L1sh0/jBW4RWFcV9dOnQmI2czLBSi20Yeubzs6GVzpWDp5DoNw2fE+LGKIrT4ZGjiOrGWoov686SJ15gTST0A2N6me9zSLG9pEtzVPwD13iyKFrhIty2U0Bzl4yqRFFW0WN1AImcgxDj8NPWqwL2a+YOtZFHXAWKsQhby2S36Ls87MfzQ+J1utVU4rSU2nl9CMwxulITPZQkmdniOs3zTb5YD9Kj5XpHCHONx81fipnwQZPguMlUbTAMgMBsY8imimrvMnz3Y9bdnWALXkzEjZy0LkGJNcZLVS8DhuiCaU35L4jTzL+Nq0LupgHwgpse7THoKNtafGMZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(36756003)(2616005)(70206006)(70586007)(44832011)(5660300002)(82740400003)(8676002)(36860700001)(8936002)(41300700001)(4326008)(110136005)(54906003)(6666004)(40480700001)(86362001)(47076005)(316002)(478600001)(26005)(186003)(1076003)(336012)(81166007)(356005)(40460700003)(426003)(83380400001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:50.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f5851-1a0e-4d50-9752-08dab655ac3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused allocation and freeing of PCI host bridge structure.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  5 -----
 arch/microblaze/pci/pci-common.c         | 29 -----------------------------
 arch/microblaze/pci/xilinx_pci.c         |  6 ------
 3 files changed, 40 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 252bcc1..018c632 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -25,7 +25,6 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
  */
 struct pci_controller {
 	struct pci_bus *bus;
-	char is_dynamic;
 	struct device_node *dn;
 	struct list_head list_node;
 	struct device *parent;
@@ -98,9 +97,5 @@ extern void setup_indirect_pci(struct pci_controller *hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
 
-/* Allocate & free a PCI host bridge structure */
-extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
-extern void pcibios_free_controller(struct pci_controller *phb);
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_MICROBLAZE_PCI_BRIDGE_H */
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 12764df0..2965892 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -38,9 +38,6 @@
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
-/* XXX kill that some day ... */
-static int global_phb_number;		/* Global phb counter */
-
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
@@ -49,32 +46,6 @@
 
 static int pci_bus_count;
 
-struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
-{
-	struct pci_controller *phb;
-
-	phb = zalloc_maybe_bootmem(sizeof(struct pci_controller), GFP_KERNEL);
-	if (!phb)
-		return NULL;
-	spin_lock(&hose_spinlock);
-	phb->global_number = global_phb_number++;
-	list_add_tail(&phb->list_node, &hose_list);
-	spin_unlock(&hose_spinlock);
-	phb->dn = dev;
-	phb->is_dynamic = mem_init_done;
-	return phb;
-}
-
-void pcibios_free_controller(struct pci_controller *phb)
-{
-	spin_lock(&hose_spinlock);
-	list_del(&phb->list_node);
-	spin_unlock(&hose_spinlock);
-
-	if (phb->is_dynamic)
-		kfree(phb);
-}
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 	return resource_size(&hose->io_resource);
diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index f1a5112..3fa16e3 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -97,12 +97,6 @@ void __init xilinx_pci_init(void)
 		return;
 	}
 
-	hose = pcibios_alloc_controller(pci_node);
-	if (!hose) {
-		pr_err("xilinx-pci: pcibios_alloc_controller() failed\n");
-		return;
-	}
-
 	/* Setup config space */
 	setup_indirect_pci(hose, r.start + XPLB_PCI_ADDR,
 			   r.start + XPLB_PCI_DATA,
-- 
1.8.3.1

