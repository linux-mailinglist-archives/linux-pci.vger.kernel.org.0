Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41560C414
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJYGx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiJYGxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAB57225;
        Mon, 24 Oct 2022 23:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7nmNeANpyECj6UHhLNT5RgfUI3ksdmkQNz6eqJH4ZdOKaLgI2tYfR/c6zW1JxiQi440PCRqgpwB464eer/dlZLWFRwPsXdmiNu3PO5rVrvV2Dqv36EDURwzYdStp2gwl3ODaH2Fvj9lyRH+7PSPGLG5xLWlZVwI2kdhjI07bCGwr1C2p3QrzeeNrf+YscrIp8zps+FdtELyjyN4wjJpy/FPA86TgHVJwghEj3myYCAKKhm7hkUFvib6lgouWkhjI1aBbC8KxvJ+F31l/NKJ4N/7Ngm7DccJpuASLe/TQA42fKpOZhupiFTnMupCQEW7UEMVngCzx+JpGmVT/mEjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7Ch1D7H4JfsRTBSbPRLM8rYC0XAUY7OwecvH+SsaXQ=;
 b=goVIIVk1MWrHoeChqLSygC0b+35FE7IujF03wyA/jr1tSrAnpj50yn3wdcwokf3lcOGROPaj+ZjloNh+IfKppM8nWTUwsMT3pWd/vngaPRcvB41a/H4AbUq1zKObi1Kzj2Wlm7q4br1on8iKxCpRLcsCXjGALdLzhMKW7LbB8E0j/7H6IMg0BZoUHq2f0dPTDL+vwQAVtx0C36UVlSbW4ZaFVB2gg6YxVnBIyH6wv8yqDD1RyCmaqbAPQdOv9pz/EGMzY2nzRGwcX2bmrvfSo7MFpe1wsI0/eiaL0JHxYZwx7CDQDTQye5A/RkgulB0kIFtC3x1tfkXgTSujg0Ku3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Ch1D7H4JfsRTBSbPRLM8rYC0XAUY7OwecvH+SsaXQ=;
 b=eDJLoSnJUSU8bNc3NwwcnJsPJUfse7/YHLjEShZn8Ic1Akk9GxGHVqOXYzOZmttBDPPlfUDzGl3OCdqngYObRy4Y56+tBN0x2mERm1t6P+YQwbuTs6rV27pQ0DaQsUHs55Qu0MCBnShyviicl64vKf043PqHuutHCTZXxLphR5U=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 25 Oct
 2022 06:53:47 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d9) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:46 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:43 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 05/13] microblaze/PCI: Remove unused device tree parsing for a host bridge resources
Date:   Tue, 25 Oct 2022 12:22:06 +0530
Message-ID: <20221025065214.4663-6-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 86879a29-65a0-462e-8025-08dab655aa78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/auqdwrSr9w9UNOfKucILuWp51mCqRP0xyw8wj8qz0S6musgX+BhEJyQZz8AswZXWjoUaya0bQLEWiEvlX/XxRjW6NqGE+VFyhb9iN+CGbKhijsVvPaZvtypzv934aHQfk9bQihu7rqgUZH8+ND8n4XhvJaRx43W+QUlJXxIIrixc35ff396tyTseAJ/WYDOWjHZRyJBn/G9BMs+h02AsGm95lm4tef2Iw0mgucYJfru7y73EzlCV4nsMwWpteLsTzvCFEEhi+9rIji9VfSEXxC0senDioPmFf862H3tIGMFAZ7zsI5geBo5moUJtUEaKGzVu6UaaJSlatv5bE6NyhCU54WIWmUBnHR/t97pMEmLQvqV6lxwkKvM1TNO6nXXpIOqxsKVSbgaOvaHN2tEK293H/lcfvlV7QXS26cmRkdlpZFxg0auadFtNOEaeYhyjV3V6a50+P3l+s6qR5LKKrkD8BnCG4fKndw18WYd+LasgB/zlTMd63840ISKE4xzEIT6niMBkIUi1cPVQ1AtihnlbV7lAjU/mnhaEBsqGdj5rKpDozbVGIEOhotAhK3n/xPcdMmmq7MQ9dorHx//1vDJo96aaCq4eweVyTD2dxsZAp+56jRhImMguEg9dp33zx6tyXIH/TikKag8HxYK2HMTTk7BR6BdwNL4EgDXUBDj7Q/XmcrB2hPybrM1PNsaE3Rnh2XBaP+TWWXKQY43LmwtKZ5QQuFeGXgpcxQpfD/KL5IwUdYTlPQTzm1dYuKty7+HmNqwWubO0oyX9jC/hDbEM+ITJ0az6KsAZx1aRa9AMhQMQ8L/W8VQVUYWeAG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(6666004)(4326008)(86362001)(70206006)(8676002)(70586007)(36860700001)(336012)(82740400003)(186003)(83380400001)(1076003)(2906002)(40460700003)(41300700001)(426003)(47076005)(26005)(356005)(81166007)(8936002)(2616005)(5660300002)(40480700001)(44832011)(36756003)(478600001)(66899015)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:47.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86879a29-65a0-462e-8025-08dab655aa78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused pci_process_bridge_OF_ranges function, used to
parse the "ranges" property of a PCI host device.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  13 ---
 arch/microblaze/pci/pci-common.c         | 163 -------------------------------
 arch/microblaze/pci/xilinx_pci.c         |   5 -
 3 files changed, 181 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index ce74b0c..252bcc1 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -38,20 +38,11 @@ struct pci_controller {
 	void __iomem *io_base_virt;
 	resource_size_t io_base_phys;
 
-	resource_size_t pci_io_size;
-
 	/* Some machines (PReP) have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
 	 */
 	resource_size_t pci_mem_offset;
 
-	/* Some machines have a special region to forward the ISA
-	 * "memory" cycles such as VGA memory regions. Left to 0
-	 * if unsupported
-	 */
-	resource_size_t isa_mem_phys;
-	resource_size_t isa_mem_size;
-
 	struct pci_ops *ops;
 	unsigned int __iomem *cfg_addr;
 	void __iomem *cfg_data;
@@ -107,10 +98,6 @@ extern void setup_indirect_pci(struct pci_controller *hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
 
-/* Fill up host controller resources from the OF node */
-extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-			struct device_node *dev, int primary);
-
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ef4a9fc..12764df0 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -171,169 +171,6 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*end = rsrc->end;
 }
 
-/**
- * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
- * @hose: newly allocated pci_controller to be setup
- * @dev: device node of the host bridge
- * @primary: set if primary bus (32 bits only, soon to be deprecated)
- *
- * This function will parse the "ranges" property of a PCI host bridge device
- * node and setup the resource mapping of a pci controller based on its
- * content.
- *
- * Life would be boring if it wasn't for a few issues that we have to deal
- * with here:
- *
- *   - We can only cope with one IO space range and up to 3 Memory space
- *     ranges. However, some machines (thanks Apple !) tend to split their
- *     space into lots of small contiguous ranges. So we have to coalesce.
- *
- *   - We can only cope with all memory ranges having the same offset
- *     between CPU addresses and PCI addresses. Unfortunately, some bridges
- *     are setup for a large 1:1 mapping along with a small "window" which
- *     maps PCI address 0 to some arbitrary high address of the CPU space in
- *     order to give access to the ISA memory hole.
- *     The way out of here that I've chosen for now is to always set the
- *     offset based on the first resource found, then override it if we
- *     have a different offset and the previous was set by an ISA hole.
- *
- *   - Some busses have IO space not starting at 0, which causes trouble with
- *     the way we do our IO resource renumbering. The code somewhat deals with
- *     it for 64 bits but I would expect problems on 32 bits.
- *
- *   - Some 32 bits platforms such as 4xx can have physical space larger than
- *     32 bits so we need to use 64 bits values for the parsing
- */
-void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-				  struct device_node *dev, int primary)
-{
-	int memno = 0, isa_hole = -1;
-	unsigned long long isa_mb = 0;
-	struct resource *res;
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-
-	pr_info("PCI host bridge %pOF %s ranges:\n",
-	       dev, primary ? "(primary)" : "");
-
-	/* Check for ranges property */
-	if (of_pci_range_parser_init(&parser, dev))
-		return;
-
-	pr_debug("Parsing ranges property...\n");
-	for_each_of_pci_range(&parser, &range) {
-		/* Read next ranges element */
-
-		/* If we failed translation or got a zero-sized region
-		 * (some FW try to feed us with non sensical zero sized regions
-		 * such as power3 which look like some kind of attempt
-		 * at exposing the VGA memory hole)
-		 */
-		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
-			continue;
-
-		/* Act based on address space type */
-		res = NULL;
-		switch (range.flags & IORESOURCE_TYPE_BITS) {
-		case IORESOURCE_IO:
-			pr_info("  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
-				range.cpu_addr, range.cpu_addr + range.size - 1,
-				range.pci_addr);
-
-			/* We support only one IO range */
-			if (hose->pci_io_size) {
-				pr_info(" \\--> Skipped (too many) !\n");
-				continue;
-			}
-			/* On 32 bits, limit I/O space to 16MB */
-			if (range.size > 0x01000000)
-				range.size = 0x01000000;
-
-			/* 32 bits needs to map IOs here */
-			hose->io_base_virt = ioremap(range.cpu_addr,
-						range.size);
-
-			/* Expect trouble if pci_addr is not 0 */
-			if (primary)
-				isa_io_base =
-					(unsigned long)hose->io_base_virt;
-			/* pci_io_size and io_base_phys always represent IO
-			 * space starting at 0 so we factor in pci_addr
-			 */
-			hose->pci_io_size = range.pci_addr + range.size;
-			hose->io_base_phys = range.cpu_addr - range.pci_addr;
-
-			/* Build resource */
-			res = &hose->io_resource;
-			range.cpu_addr = range.pci_addr;
-
-			break;
-		case IORESOURCE_MEM:
-			pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
-				range.cpu_addr, range.cpu_addr + range.size - 1,
-				range.pci_addr,
-				(range.flags & IORESOURCE_PREFETCH) ?
-				"Prefetch" : "");
-
-			/* We support only 3 memory ranges */
-			if (memno >= 3) {
-				pr_info(" \\--> Skipped (too many) !\n");
-				continue;
-			}
-			/* Handles ISA memory hole space here */
-			if (range.pci_addr == 0) {
-				isa_mb = range.cpu_addr;
-				isa_hole = memno;
-				if (primary || isa_mem_base == 0)
-					isa_mem_base = range.cpu_addr;
-				hose->isa_mem_phys = range.cpu_addr;
-				hose->isa_mem_size = range.size;
-			}
-
-			/* We get the PCI/Mem offset from the first range or
-			 * the, current one if the offset came from an ISA
-			 * hole. If they don't match, bugger.
-			 */
-			if (memno == 0 ||
-			    (isa_hole >= 0 && range.pci_addr != 0 &&
-			     hose->pci_mem_offset == isa_mb))
-				hose->pci_mem_offset = range.cpu_addr -
-							range.pci_addr;
-			else if (range.pci_addr != 0 &&
-				 hose->pci_mem_offset != range.cpu_addr -
-							range.pci_addr) {
-				pr_info(" \\--> Skipped (offset mismatch) !\n");
-				continue;
-			}
-
-			/* Build resource */
-			res = &hose->mem_resources[memno++];
-			break;
-		}
-		if (res != NULL) {
-			res->name = dev->full_name;
-			res->flags = range.flags;
-			res->start = range.cpu_addr;
-			res->end = range.cpu_addr + range.size - 1;
-			res->parent = res->child = res->sibling = NULL;
-		}
-	}
-
-	/* If there's an ISA hole and the pci_mem_offset is -not- matching
-	 * the ISA hole offset, then we need to remove the ISA hole from
-	 * the resource list for that brige
-	 */
-	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
-		unsigned int next = isa_hole + 1;
-		pr_info(" Removing ISA hole at 0x%016llx\n", isa_mb);
-		if (next < memno)
-			memmove(&hose->mem_resources[isa_hole],
-				&hose->mem_resources[next],
-				sizeof(struct resource) * (memno - next));
-		hose->mem_resources[--memno].flags = 0;
-	}
-}
-
 /* Display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index 7ed6647..f1a5112 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -114,9 +114,4 @@ void __init xilinx_pci_init(void)
 	out_be32(pci_reg + XPLB_PCI_BUS, 0x000000ff);
 	iounmap(pci_reg);
 
-	/* Register the host bridge with the linux kernel! */
-	pci_process_bridge_OF_ranges(hose, pci_node,
-					INDIRECT_TYPE_SET_CFG_TYPE);
-
-	pr_info("xilinx-pci: Registered PCI host bridge\n");
 }
-- 
1.8.3.1

