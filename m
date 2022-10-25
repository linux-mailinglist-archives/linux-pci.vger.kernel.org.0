Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC59260C41B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiJYGx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJYGx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC728437E0;
        Mon, 24 Oct 2022 23:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLYCC2ZNnYFzwNAMsXHL1lZbTD138xgIncNDQFAyvd5qW/i4RsQGzwHWB8adMCHdSgSQ6/jzxh+XVEXUMcmXvC7ZJbqraSUz6C4jqrSCfnE9yrlm/uCnFU2EmduMWXGBmabtNF2GXZ6wk98Kof/e9XjkCmQEpPr2Gjhpx3/Cuhc1K2i+WhNCz3B/q3ZHVNGKksSvWjwwL5J0k3Oqt9xU2IzYRpbElzuf3ftm+a8QGWbhtyB9s9V5oQt6pGW8HSRqQ/8gjOyxepxKKRGLHZv5r6c67WiShkcUwUcMbcZ50YgThvlQbLvti87x7WuOzglh/qxdXfkU1ACxdXpzU7VyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r424ozFlp8CoQXRkRVuBvLkXFlZUchFIHoYw+54Td3I=;
 b=USlvQ02H7PkbBn8K8hAttsIys/NR0G8Kf6h8UF9vtR2OLo4GYoaII/ZR2CBB+uA2y7iNRWHEZWfeNcE7SjKyQwBLiNHImSPRzssASLYguSUFkkULwli9xSuFASkfmsYaBlEbllSACeoqIjjehhC6fBnGafOrAIKJ46CiTVmRzgHA0T3PUcxtu2JQsCymd/6NdtswUxnwn4lBr32chlhz6EgWZ1Zxb8NGhJrx0TmPmP8NCI9IxcY/ntk+qyuFW9BeMFy2ntJU2nCfPo2oeqwIDPm8xjTBoQWq2tB9KSFz1MaxV3khyxbK73KUerDhC3dmTNcHWugBabPIVprE3I1vFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r424ozFlp8CoQXRkRVuBvLkXFlZUchFIHoYw+54Td3I=;
 b=IZjqIaWSUhKPD+1N2GfbLHHhaZjkJcVIRHCguyauZEIBfyqXH2GRx7jT+WZ0mZPJZ1TnGVrqr/9YL2M2L3zDMOe6Q9KTCrCvPAHksZCyAR19PpTpVqw3mo9XDeC7D7pwhftdfwCcGdP9lM2aAgaosDDDEVaiGfm701Xxu0S9DuE=
Received: from DM6PR18CA0019.namprd18.prod.outlook.com (2603:10b6:5:15b::32)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 25 Oct
 2022 06:53:53 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::7f) by DM6PR18CA0019.outlook.office365.com
 (2603:10b6:5:15b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:52 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:50 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 07/13] microblaze/PCI: Remove unused PCI BIOS resource allocation
Date:   Tue, 25 Oct 2022 12:22:08 +0530
Message-ID: <20221025065214.4663-8-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b11959b-26d4-47f5-25ae-08dab655ae34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfGebZlJ86LDXKmseJBQWBGsoLyqpxTe+W0NnxvTOJMHyLEPv2zncKlqulWxRIrcQ+c9HOCi3gsFaeddjIuLTVGj98vZqtIOCv5dX28ZZPzbAautX9KQGRUoNxc2XktQF+9M4LFHFgNZKgPP9czp4l16IK60dJMScKZwA10fMdZQSEaZO4iSuwxBKyBvPvpErXb4YQLz9hx0mBCfFGTIfTEsIFZfcPpYDCvNbFhj0J9AeqO7O5PJACMCmdTiksZiqNMpojk24/2B5dmFwu1kvvuOp19d0hpgemELYZaMTodQ33cIKZO2YLNLjfQZpXabntb+kXHUyvofuTv33/5smeKdrprvmcvjVpKIJu9wBZBXwpAfSEK7kLQIpMW6BlFN7Cx7WoPB1yZfvGpXx4Q7rdrfc9fkEOCh76RJhwsHT+6CypDh6F31cWlXSElSMXGwQqKyz05pvea6Crqbc4pedGv18VX70pLKXeqOJI6ne6fyt4ZgIGxnHNqb9+P3j0gt4q/3GBlWOv4Z3X4lM4NY/9S8XTLhionYGCewLxLimLgdYrIEz6+1wEeIXUNXD3csarKeuOG+pAwMI1Kc2ZOFTqFEaQ4N8uAJAKO0eJX6R3QbZxdCsMMFyEkNzBQS52Lp1ifPeOEib1n80Hl9BFD/EIAkBmT2KhmLdQYBGh8XmBiBbxQzyT37UmNzTTkfGzTaUuBOUOrIt+HifpNSsmpZA3RwuCknLFLqEgdLEisw8EfoXJJEwTZoWM9qYMDXZn/aYLtIL+p7Da8lZa6EQj0a6e+OhB2sbLCtrAZ2NE5UjcZnt++APzyX+xYqiJAp979+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(426003)(2616005)(336012)(40480700001)(356005)(81166007)(40460700003)(36756003)(478600001)(110136005)(316002)(54906003)(82740400003)(86362001)(6666004)(36860700001)(30864003)(82310400005)(83380400001)(47076005)(1076003)(186003)(8676002)(26005)(8936002)(41300700001)(44832011)(4326008)(2906002)(70586007)(5660300002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:53.6693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b11959b-26d4-47f5-25ae-08dab655ae34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove PCI BIOSn unused code which provide's resource allocation for
all pci bus and pci host controller memory initialization.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |   2 -
 arch/microblaze/include/asm/pci.h        |   4 -
 arch/microblaze/pci/pci-common.c         | 489 -------------------------------
 3 files changed, 495 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 018c632..170369d 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -74,8 +74,6 @@ struct pci_controller {
 	 * ranges since the common pci_bus structure can't handle more
 	 */
 	struct resource io_resource;
-	struct resource mem_resources[3];
-	int global_number;	/* PCI domain number */
 };
 
 #ifdef CONFIG_PCI
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 34337e2..6da7523 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -28,8 +28,6 @@
 #define IOBASE_ISA_IO		3
 #define IOBASE_ISA_MEM		4
 
-#define pcibios_scan_all_fns(a, b)	0
-
 /*
  * Set this to 1 if you want the kernel to re-assign all PCI
  * bus numbers (don't do that on ppc64 yet !)
@@ -48,8 +46,6 @@
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 #define arch_can_pci_mmap_io()		1
 
-extern void pcibios_resource_survey(void);
-
 struct file;
 
 /* This part of code was originally in xilinx-pci.h */
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 2965892..085e673 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -44,8 +44,6 @@
 unsigned long isa_io_base;
 EXPORT_SYMBOL(isa_io_base);
 
-static int pci_bus_count;
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 	return resource_size(&hose->io_resource);
@@ -93,11 +91,6 @@ unsigned long pci_address_to_pio(phys_addr_t address)
 }
 EXPORT_SYMBOL_GPL(pci_address_to_pio);
 
-void pcibios_set_master(struct pci_dev *dev)
-{
-	/* No special bus mastering setup handling */
-}
-
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s.
  */
@@ -117,494 +110,12 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 	return 0;
 }
 
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end)
-{
-	struct pci_bus_region region;
-
-	if (rsrc->flags & IORESOURCE_IO) {
-		pcibios_resource_to_bus(dev->bus, &region,
-					(struct resource *) rsrc);
-		*start = region.start;
-		*end = region.end;
-		return;
-	}
-
-	/* We pass a CPU physical address to userland for MMIO instead of a
-	 * BAR value because X is lame and expects to be able to use that
-	 * to pass to /dev/mem!
-	 *
-	 * That means we may have 64-bit values where some apps only expect
-	 * 32 (like X itself since it thinks only Sparc has 64-bit MMIO).
-	 */
-	*start = rsrc->start;
-	*end = rsrc->end;
-}
-
 /* Display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
 	return pci_domain_nr(bus);
 }
 
-/* This header fixup will do the resource fixup for all devices as they are
- * probed, but not for bridge ranges
- */
-static void pcibios_fixup_resources(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	int i;
-
-	if (!hose) {
-		pr_err("No host bridge for PCI dev %s !\n",
-		       pci_name(dev));
-		return;
-	}
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		struct resource *res = dev->resource + i;
-		if (!res->flags)
-			continue;
-		if (res->start == 0) {
-			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]",
-				 pci_name(dev), i,
-				 (unsigned long long)res->start,
-				 (unsigned long long)res->end,
-				 (unsigned int)res->flags);
-			pr_debug("is unassigned\n");
-			res->end -= res->start;
-			res->start = 0;
-			res->flags |= IORESOURCE_UNSET;
-			continue;
-		}
-
-		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]\n",
-			 pci_name(dev), i,
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned int)res->flags);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
-
-int pcibios_device_add(struct pci_dev *dev)
-{
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-
-	return 0;
-}
-
-/*
- * Reparent resource children of pr that conflict with res
- * under res, and make res replace those children.
- */
-static int __init reparent_resources(struct resource *parent,
-				     struct resource *res)
-{
-	struct resource *p, **pp;
-	struct resource **firstpp = NULL;
-
-	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
-		if (p->end < res->start)
-			continue;
-		if (res->end < p->start)
-			break;
-		if (p->start < res->start || p->end > res->end)
-			return -1;	/* not completely contained */
-		if (firstpp == NULL)
-			firstpp = pp;
-	}
-	if (firstpp == NULL)
-		return -1;	/* didn't find any conflicting entries? */
-	res->parent = parent;
-	res->child = *firstpp;
-	res->sibling = *pp;
-	*firstpp = res;
-	*pp = NULL;
-	for (p = res->child; p != NULL; p = p->sibling) {
-		p->parent = res;
-		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
-			 p->name,
-			 (unsigned long long)p->start,
-			 (unsigned long long)p->end, res->name);
-	}
-	return 0;
-}
-
-/*
- *  Handle resources of PCI devices.  If the world were perfect, we could
- *  just allocate all the resource regions and do nothing more.  It isn't.
- *  On the other hand, we cannot just re-allocate all devices, as it would
- *  require us to know lots of host bridge internals.  So we attempt to
- *  keep as much of the original configuration as possible, but tweak it
- *  when it's found to be wrong.
- *
- *  Known BIOS problems we have to work around:
- *	- I/O or memory regions not configured
- *	- regions configured, but not enabled in the command register
- *	- bogus I/O addresses above 64K used
- *	- expansion ROMs left enabled (this may sound harmless, but given
- *	  the fact the PCI specs explicitly allow address decoders to be
- *	  shared between expansion ROMs and other resource regions, it's
- *	  at least dangerous)
- *
- *  Our solution:
- *	(1) Allocate resources for all buses behind PCI-to-PCI bridges.
- *	    This gives us fixed barriers on where we can allocate.
- *	(2) Allocate resources for all enabled devices.  If there is
- *	    a collision, just mark the resource as unallocated. Also
- *	    disable expansion ROMs during this step.
- *	(3) Try to allocate resources for disabled devices.  If the
- *	    resources were assigned correctly, everything goes well,
- *	    if they weren't, they won't disturb allocation of other
- *	    resources.
- *	(4) Assign new addresses to resources which were either
- *	    not configured at all or misconfigured.  If explicitly
- *	    requested by the user, configure expansion ROM address
- *	    as well.
- */
-
-static void pcibios_allocate_bus_resources(struct pci_bus *bus)
-{
-	struct pci_bus *b;
-	int i;
-	struct resource *res, *pr;
-
-	pr_debug("PCI: Allocating bus resources for %04x:%02x...\n",
-		 pci_domain_nr(bus), bus->number);
-
-	pci_bus_for_each_resource(bus, res, i) {
-		if (!res || !res->flags
-		    || res->start > res->end || res->parent)
-			continue;
-		if (bus->parent == NULL)
-			pr = (res->flags & IORESOURCE_IO) ?
-				&ioport_resource : &iomem_resource;
-		else {
-			/* Don't bother with non-root busses when
-			 * re-assigning all resources. We clear the
-			 * resource flags as if they were colliding
-			 * and as such ensure proper re-allocation
-			 * later.
-			 */
-			pr = pci_find_parent_resource(bus->self, res);
-			if (pr == res) {
-				/* this happens when the generic PCI
-				 * code (wrongly) decides that this
-				 * bridge is transparent  -- paulus
-				 */
-				continue;
-			}
-		}
-
-		pr_debug("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx ",
-			 bus->self ? pci_name(bus->self) : "PHB",
-			 bus->number, i,
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end);
-		pr_debug("[0x%x], parent %p (%s)\n",
-			 (unsigned int)res->flags,
-			 pr, (pr && pr->name) ? pr->name : "nil");
-
-		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
-			struct pci_dev *dev = bus->self;
-
-			if (request_resource(pr, res) == 0)
-				continue;
-			/*
-			 * Must be a conflict with an existing entry.
-			 * Move that entry (or entries) under the
-			 * bridge resource and try again.
-			 */
-			if (reparent_resources(pr, res) == 0)
-				continue;
-
-			if (dev && i < PCI_BRIDGE_RESOURCE_NUM &&
-			    pci_claim_bridge_resource(dev,
-						 i + PCI_BRIDGE_RESOURCES) == 0)
-				continue;
-
-		}
-		pr_warn("PCI: Cannot allocate resource region ");
-		pr_cont("%d of PCI bridge %d, will remap\n", i, bus->number);
-		res->start = res->end = 0;
-		res->flags = 0;
-	}
-
-	list_for_each_entry(b, &bus->children, node)
-		pcibios_allocate_bus_resources(b);
-}
-
-static inline void alloc_resource(struct pci_dev *dev, int idx)
-{
-	struct resource *pr, *r = &dev->resource[idx];
-
-	pr_debug("PCI: Allocating %s: Resource %d: %016llx..%016llx [%x]\n",
-		 pci_name(dev), idx,
-		 (unsigned long long)r->start,
-		 (unsigned long long)r->end,
-		 (unsigned int)r->flags);
-
-	pr = pci_find_parent_resource(dev, r);
-	if (!pr || (pr->flags & IORESOURCE_UNSET) ||
-	    request_resource(pr, r) < 0) {
-		pr_warn("PCI: Cannot allocate resource region %d ", idx);
-		pr_cont("of device %s, will remap\n", pci_name(dev));
-		if (pr)
-			pr_debug("PCI:  parent is %p: %016llx-%016llx [%x]\n",
-				 pr,
-				 (unsigned long long)pr->start,
-				 (unsigned long long)pr->end,
-				 (unsigned int)pr->flags);
-		/* We'll assign a new address later */
-		r->flags |= IORESOURCE_UNSET;
-		r->end -= r->start;
-		r->start = 0;
-	}
-}
-
-static void __init pcibios_allocate_resources(int pass)
-{
-	struct pci_dev *dev = NULL;
-	int idx, disabled;
-	u16 command;
-	struct resource *r;
-
-	for_each_pci_dev(dev) {
-		pci_read_config_word(dev, PCI_COMMAND, &command);
-		for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
-			r = &dev->resource[idx];
-			if (r->parent)		/* Already allocated */
-				continue;
-			if (!r->flags || (r->flags & IORESOURCE_UNSET))
-				continue;	/* Not assigned at all */
-			/* We only allocate ROMs on pass 1 just in case they
-			 * have been screwed up by firmware
-			 */
-			if (idx == PCI_ROM_RESOURCE)
-				disabled = 1;
-			if (r->flags & IORESOURCE_IO)
-				disabled = !(command & PCI_COMMAND_IO);
-			else
-				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled)
-				alloc_resource(dev, idx);
-		}
-		if (pass)
-			continue;
-		r = &dev->resource[PCI_ROM_RESOURCE];
-		if (r->flags) {
-			/* Turn the ROM off, leave the resource region,
-			 * but keep it unregistered.
-			 */
-			u32 reg;
-			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
-			if (reg & PCI_ROM_ADDRESS_ENABLE) {
-				pr_debug("PCI: Switching off ROM of %s\n",
-					 pci_name(dev));
-				r->flags &= ~IORESOURCE_ROM_ENABLE;
-				pci_write_config_dword(dev, dev->rom_base_reg,
-						reg & ~PCI_ROM_ADDRESS_ENABLE);
-			}
-		}
-	}
-}
-
-static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	resource_size_t	offset;
-	struct resource *res, *pres;
-	int i;
-
-	pr_debug("Reserving legacy ranges for domain %04x\n",
-							pci_domain_nr(bus));
-
-	/* Check for IO */
-	if (!(hose->io_resource.flags & IORESOURCE_IO))
-		goto no_io;
-	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-	BUG_ON(res == NULL);
-	res->name = "Legacy IO";
-	res->flags = IORESOURCE_IO;
-	res->start = offset;
-	res->end = (offset + 0xfff) & 0xfffffffful;
-	pr_debug("Candidate legacy IO: %pR\n", res);
-	if (request_resource(&hose->io_resource, res)) {
-		pr_debug("PCI %04x:%02x Cannot reserve Legacy IO %pR\n",
-		       pci_domain_nr(bus), bus->number, res);
-		kfree(res);
-	}
-
- no_io:
-	/* Check for memory */
-	offset = hose->pci_mem_offset;
-	pr_debug("hose mem offset: %016llx\n", (unsigned long long)offset);
-	for (i = 0; i < 3; i++) {
-		pres = &hose->mem_resources[i];
-		if (!(pres->flags & IORESOURCE_MEM))
-			continue;
-		pr_debug("hose mem res: %pR\n", pres);
-		if ((pres->start - offset) <= 0xa0000 &&
-		    (pres->end - offset) >= 0xbffff)
-			break;
-	}
-	if (i >= 3)
-		return;
-	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-	BUG_ON(res == NULL);
-	res->name = "Legacy VGA memory";
-	res->flags = IORESOURCE_MEM;
-	res->start = 0xa0000 + offset;
-	res->end = 0xbffff + offset;
-	pr_debug("Candidate VGA memory: %pR\n", res);
-	if (request_resource(pres, res)) {
-		pr_debug("PCI %04x:%02x Cannot reserve VGA memory %pR\n",
-		       pci_domain_nr(bus), bus->number, res);
-		kfree(res);
-	}
-}
-
-void __init pcibios_resource_survey(void)
-{
-	struct pci_bus *b;
-
-	/* Allocate and assign resources. If we re-assign everything, then
-	 * we skip the allocate phase
-	 */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_allocate_bus_resources(b);
-
-	pcibios_allocate_resources(0);
-	pcibios_allocate_resources(1);
-
-	/* Before we start assigning unassigned resource, we try to reserve
-	 * the low IO area and the VGA memory area if they intersect the
-	 * bus available resources to avoid allocating things on top of them
-	 */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_reserve_legacy_regions(b);
-
-	/* Now proceed to assigning things that were left unassigned */
-	pr_debug("PCI: Assigning unassigned resources...\n");
-	pci_assign_unassigned_resources();
-}
-
-static void pcibios_setup_phb_resources(struct pci_controller *hose,
-					struct list_head *resources)
-{
-	unsigned long io_offset;
-	struct resource *res;
-	int i;
-
-	/* Hookup PHB IO resource */
-	res = &hose->io_resource;
-
-	/* Fixup IO space offset */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	res->start = (res->start + io_offset) & 0xffffffffu;
-	res->end = (res->end + io_offset) & 0xffffffffu;
-
-	if (!res->flags) {
-		pr_warn("PCI: I/O resource not set for host ");
-		pr_cont("bridge %pOF (domain %d)\n",
-			hose->dn, hose->global_number);
-		/* Workaround for lack of IO resource only on 32-bit */
-		res->start = (unsigned long)hose->io_base_virt - isa_io_base;
-		res->end = res->start + IO_SPACE_LIMIT;
-		res->flags = IORESOURCE_IO;
-	}
-	pci_add_resource_offset(resources, res,
-		(__force resource_size_t)(hose->io_base_virt - _IO_BASE));
-
-	pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
-		 (unsigned long long)res->start,
-		 (unsigned long long)res->end,
-		 (unsigned long)res->flags);
-
-	/* Hookup PHB Memory resources */
-	for (i = 0; i < 3; ++i) {
-		res = &hose->mem_resources[i];
-		if (!res->flags) {
-			if (i > 0)
-				continue;
-			pr_err("PCI: Memory resource 0 not set for ");
-			pr_cont("host bridge %pOF (domain %d)\n",
-				hose->dn, hose->global_number);
-
-			/* Workaround for lack of MEM resource only on 32-bit */
-			res->start = hose->pci_mem_offset;
-			res->end = (resource_size_t)-1LL;
-			res->flags = IORESOURCE_MEM;
-
-		}
-		pci_add_resource_offset(resources, res, hose->pci_mem_offset);
-
-		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n",
-			i, (unsigned long long)res->start,
-			(unsigned long long)res->end,
-			(unsigned long)res->flags);
-	}
-
-	pr_debug("PCI: PHB MEM offset     = %016llx\n",
-		 (unsigned long long)hose->pci_mem_offset);
-	pr_debug("PCI: PHB IO  offset     = %08lx\n",
-		 (unsigned long)hose->io_base_virt - _IO_BASE);
-}
-
-static void pcibios_scan_phb(struct pci_controller *hose)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *bus;
-	struct device_node *node = hose->dn;
-
-	pr_debug("PCI: Scanning PHB %pOF\n", node);
-
-	pcibios_setup_phb_resources(hose, &resources);
-
-	bus = pci_scan_root_bus(hose->parent, hose->first_busno,
-				hose->ops, hose, &resources);
-	if (bus == NULL) {
-		pr_err("Failed to create bus for PCI domain %04x\n",
-		       hose->global_number);
-		pci_free_resource_list(&resources);
-		return;
-	}
-	bus->busn_res.start = hose->first_busno;
-	hose->bus = bus;
-
-	hose->last_busno = bus->busn_res.end;
-}
-
-static int __init pcibios_init(void)
-{
-	struct pci_controller *hose, *tmp;
-	int next_busno = 0;
-
-	pr_info("PCI: Probing PCI hardware\n");
-
-	/* Scan all of the recorded PCI controllers.  */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		hose->last_busno = 0xff;
-		pcibios_scan_phb(hose);
-		if (next_busno <= hose->last_busno)
-			next_busno = hose->last_busno + 1;
-	}
-	pci_bus_count = next_busno;
-
-	/* Call common code to handle resource allocation */
-	pcibios_resource_survey();
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		if (hose->bus)
-			pci_bus_add_devices(hose->bus);
-	}
-
-	return 0;
-}
-
-subsys_initcall(pcibios_init);
-
 static struct pci_controller *pci_bus_to_hose(int bus)
 {
 	struct pci_controller *hose, *tmp;
-- 
1.8.3.1

