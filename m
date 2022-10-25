Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EA60C424
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiJYGyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiJYGyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2013A5AE;
        Mon, 24 Oct 2022 23:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ecFPbqgjnaUNp9wKoqPtFxFQIzREskmZXT/+2T0iTZ4nI1BBaXPome5g6lgUKkem501NJ+R9k9wgejXfYKVdt9H/zwL5H6FyuPkoPYLhqEZwm6/oovB4EAZLt2gEaxGHeg8cI4Y7PtRYaCcQH8X/elCI+p9RmnAXytMcVAevvKNFwTK0X+Fa0Sk2VtxiF2Z8mdP8n8En9XIqlozSEEsCaDYYU91c4TXVIK9Ho1elEMOsjWM0paD9afyTEG/ZQVB/YDvSCIn3fQLC99baxMPZD6KKS2/2oWaFpMTYxtUuqoWyesvPDCjUwPNvLouLEGR3RFmol7fDfN5YU45Ze3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUctBlJERuwrSI3gA8HvJQePg/GtTmxRoBwMQwLiI54=;
 b=PeK3aYdzePizLWz8uq0n0K3e19O/W8RGmRVE2g6iS38QqyyzYew6QDqunDtT7ri8BpbKjwyDWGu0aGDfUhg99IavICP5pMn91HuuyH3xCUofZGuMupb6fVWJclkvHwp8A9vMihBxEaJhqLOQ1yIaoDtrMJsQNSguNrNsrz6xHd8RpcO7PM6WgG18P9QyxdVLSceTF67W5uEurmJfl2E9ENuLnAc8qItK3upJr/lDR9sh6Bw0vV1z1T3LoEriavZ463DmXSDydNKrNhAYkdptjSHB+OERnVKyqiklQX7Ozpc3kUpwjJgckq3aOj5rNLCO3BGhGcATlQiyQalT6N35+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUctBlJERuwrSI3gA8HvJQePg/GtTmxRoBwMQwLiI54=;
 b=Q/xmM9QqU2fIQN2SqOmqP2L5I6/LBweqnTRZP93JgSnNSMa8Ha4Oc4Sorg4TWCLKYNXI47WtedN30fog8exyBvjJWFNtCRSGdwOT7Xs0QV3fX0ixlnmpgJNPgc8xXq0XQJlLhT4sDNeREKdgZPmkv7aWvCx2ewizZu9T7w0/zYs=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 06:54:00 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::1a) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Tue, 25 Oct 2022 06:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:59 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:56 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 09/13] microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU address to I/O port
Date:   Tue, 25 Oct 2022 12:22:10 +0530
Message-ID: <20221025065214.4663-10-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffda11d-ee2c-4756-9a18-08dab655b1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k12s6wiOd5e28g1YzE0D6Mtex7tkfrAvlbSc7oqwO6TyTGUZygOv7VcAfzw4x1B4TEnHusCmGJ3B0If6RU6jOdtopErfzbJGUl1rOdNG+yWfSVs23OC++g0cs+rLg8akZsH3CrqP51IawJDwNbC7Su1uFEEJ9fHxBM5RfEEMPQOnJkvPyEq7EojgrILzq4V9r0aaTtV4Jc7s7EigV7aTT2bSwoy2FnXedt62hz38FNKJ/oXIs0GKKIyuq/DYEBdSXjqbsK0BbKNVvsjkZm/i7ofNEufJXt5wR9qiiceLp83dMCj4Z+gmLeWRolW9fSM3UOXYAVI1EYdbRunChKl+G7hnQEDcGyMZeWsjGXIB1eynNPam0PBbmMfRXiVE2ZgzVF1dpXKBcX+onc4WqQMqBq8ttjNNgPU8m0rD5NsJXVAh0gXi/dztUadtloCp36awqCC7YX8ywQcOPNeqpM9i2HeJERu0HqvjPvVs3Fh/pth2uwOwq6P1MeDkJN0MQ0qhL3HZyzGCr19MMceWNPUSdCrsRV3NJh4A4K5LkitOaFYaNx2dp4RR32OgE0OfuuLJR9B6+HPEXK1uG6CPIEZJPVE7jHtT6LFgmlfUQkkAv85m0+2L9CPbey0FQv3LKN4LkuRyXntQhYieYLUWFVz6n6wEDMkcJwbC68U3RRRT/nPL+KHgrtyT3/xFuiyM9yGT+rr1LKR7fSYZgbuUPDg1Uf6yusSkIDLIkGScGslqForMeuc5oPhIreGJHe2V6nBfm3WOgh16cQMGuXLD1R7w38LJKERwdCbD0uS1imBtKiWD+ds3XDTy26WhH4dl8LMC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(356005)(82740400003)(81166007)(5660300002)(70586007)(70206006)(8936002)(47076005)(426003)(83380400001)(36860700001)(86362001)(54906003)(110136005)(2616005)(26005)(40480700001)(186003)(336012)(40460700003)(1076003)(316002)(478600001)(82310400005)(44832011)(41300700001)(8676002)(4326008)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:59.9900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffda11d-ee2c-4756-9a18-08dab655b1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused pci_address_to_pio() conversion of CPU
address to I/O port function.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/pci/pci-common.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 085e673..555281c 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -68,29 +68,6 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
-unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	struct pci_controller *hose;
-	resource_size_t size;
-	unsigned long ret = ~0;
-
-	spin_lock(&hose_spinlock);
-	list_for_each_entry(hose, &hose_list, list_node) {
-		size = pcibios_io_size(hose);
-		if (address >= hose->io_base_phys &&
-		    address < (hose->io_base_phys + size)) {
-			unsigned long base =
-				(unsigned long)hose->io_base_virt - _IO_BASE;
-			ret = base + (address - hose->io_base_phys);
-			break;
-		}
-	}
-	spin_unlock(&hose_spinlock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pci_address_to_pio);
-
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s.
  */
-- 
1.8.3.1

