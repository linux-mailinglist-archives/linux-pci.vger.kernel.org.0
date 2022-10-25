Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5E60C418
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiJYGx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJYGxy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896D58507;
        Mon, 24 Oct 2022 23:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXawekAEqTzoUq4gje3kqpdRcdSrsv9ms2O/4i7nTAKAp8uInH0c9t6+E0oBZqACrJZGl6nCafTjn9AuS2CdEP2214SSRp5qCr/6ztCNyvQnVGvYMVsgblfP9wWfGi/TDhyaq4SLrWem55t874x0p7o7XGUCfVY3RUqSSslQk89o94+UzH97/nncozNSvgJtQB1alUicugeLtpDfzZBQd0KUJsIK/EP22MKTVpCxHxiF1Wi6hntb2VrEjndPA6fO6UNfkYJjPXNP3Ol/hcOGMOIWYhBW5xa+HVtjMwHv7n+U1F0Z2XrFLxqS9IR1dHbvJBptIQYDytFRBGRSLbMadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goNxu6pBKIuoYleAH24z7RYLds0YoEJz6olkIaC6uB4=;
 b=PMmTgjDmLxwXhcSatUG7lVMyKce9G2XOv99/gWiB4hCcbac6PmWFlDra3kQ8lkAQnWw+f5MbJecUqECzb+TsKBwa0obTwKtlGlaP7wygUnkHu/f7cq7M6Hwr4UhOUt1OPiMgIDtm6td28Ay/tvio0MJWyJzlN03A84oySZmcAEIPiYzLNz+ZN+dBw/GLFy5fcICkuDYwD/GmePIIa7Q9JANFHuoGjL32TBJFNA4JuXasn0iAWAD+BcMU7O6lYFxNLBmEE32bHrYHLSkhurmop06Tt6pIuRvZWnwZX7W2gUHG4dZ9jJr4Cl2sBpoMReiM2wOJoiEqTTAD26dpm9LxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goNxu6pBKIuoYleAH24z7RYLds0YoEJz6olkIaC6uB4=;
 b=IhwpJW3iSptmWA5IGQ/VP6OIjPLbL+YwJIO06sE8aHyuSvgcjNN3IVVj9csu5Oz9FT/FL7kTNHOq4tysUaMdKXywiaKIbBs7dXNKw+BN4E3tzI0VgoY4ZwdBgZuGgo2gXbzlsmcp87a0KF1syW2RRnYhv+0MUdB37vSGkQKg22E=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 06:53:48 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::13) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:43 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:08 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 04/13] microblaze/PCI: Remove unused PCI legacy IO's access on a bus
Date:   Tue, 25 Oct 2022 12:22:05 +0530
Message-ID: <20221025065214.4663-5-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: f83630a2-5429-4c3c-b347-08dab655ab1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Qs+qBJPEwld0JyuqBDlet/QhSDpBW6TMElngewMZHfUzQcTdAMuRzY5mS9RuyXZM+vGS/PCFjSlUYl+Wej5mnNo8Xr04/7I79ZcDvqJGYZw6lBM61NrUE7op2sGREReQow7LYRiC+TUv01JvYaEHzazJUj+PQzp5oO7K2CeUAh+Snw+QlxS6Ah+jvPTcDKIpItcT6TTnp4uonIFd8e8R3fnrLxiFnWvDrbRLqv/IkwKy4vIGEvj1ANIo7hGhq1v8tsZ5WNZ2BQztwC4EuQE+3EmPtx+Amsrn7GrdWqM5m85HTQkImGo0sSmdx2X6HGbrN3FGteYxxBhVHbkrwxIwxA+0JugW/Qp7joFYDvmkhxMUN143OJz5w+BNb6l4NBwWkAKc4kiLsnd5aY7ghG7zsj2qdncdpDvDav2mQzdCkmvmXfAKilU14IzuRnSgkrQ+e0VtVYddZN7RlXs+GjNMcwiUiSx7cA8d9v4kVFLH3bO2rQVjTbLIpEyPHulGfagg1/NtySYPiUxB8VEGDDxV+aosPz/aYyih+Ovc2oNms+nODCoXGMPUu9O3WesMQOM9AZHVALkDH4MtUVMtn3mbEtvIvytfF4WfqfbLDJ++IbBMuzdA4OdnYZPCFuaS3uiskSF2k6wwRH0t/WWmxUxbP9yElpnK6yP8VFfDpJXfKx4GbbkoEqjw4YC3r2lCty5dMc1fQzfq7wrHCSRlWVggoB+6K1+uwllb80LMAnS9/AFlSm5KtWOM5b5e34/gYUiX5BlFi9amkhUDcySf7UNE/AOWFy00VY68p1+Xb83XyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(1076003)(2906002)(83380400001)(186003)(47076005)(336012)(40460700003)(4326008)(8676002)(81166007)(26005)(41300700001)(356005)(82310400005)(86362001)(36756003)(110136005)(316002)(82740400003)(54906003)(40480700001)(36860700001)(8936002)(426003)(478600001)(70586007)(44832011)(2616005)(70206006)(5660300002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:48.4759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83630a2-5429-4c3c-b347-08dab655ab1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove PCI legacy read,write and mmap access IO's
on a bus

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci.h |  10 ---
 arch/microblaze/pci/pci-common.c  | 140 --------------------------------------
 2 files changed, 150 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index d905280..34337e2 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -48,16 +48,6 @@
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 #define arch_can_pci_mmap_io()		1
 
-extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
-			   size_t count);
-extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
-			   size_t count);
-extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
-				      struct vm_area_struct *vma,
-				      enum pci_mmap_state mmap_state);
-
-#define HAVE_PCI_LEGACY	1
-
 extern void pcibios_resource_survey(void);
 
 struct file;
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 6ccaf33..ef4a9fc 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -146,146 +146,6 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 	return 0;
 }
 
-/* This provides legacy IO read access on a bus */
-int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
-{
-	unsigned long offset;
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct resource *rp = &hose->io_resource;
-	void __iomem *addr;
-
-	/* Check if port can be supported by that bus. We only check
-	 * the ranges of the PHB though, not the bus itself as the rules
-	 * for forwarding legacy cycles down bridges are not our problem
-	 * here. So if the host bridge supports it, we do it.
-	 */
-	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-	offset += port;
-
-	if (!(rp->flags & IORESOURCE_IO))
-		return -ENXIO;
-	if (offset < rp->start || (offset + size) > rp->end)
-		return -ENXIO;
-	addr = hose->io_base_virt + port;
-
-	switch (size) {
-	case 1:
-		*((u8 *)val) = in_8(addr);
-		return 1;
-	case 2:
-		if (port & 1)
-			return -EINVAL;
-		*((u16 *)val) = in_le16(addr);
-		return 2;
-	case 4:
-		if (port & 3)
-			return -EINVAL;
-		*((u32 *)val) = in_le32(addr);
-		return 4;
-	}
-	return -EINVAL;
-}
-
-/* This provides legacy IO write access on a bus */
-int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
-{
-	unsigned long offset;
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct resource *rp = &hose->io_resource;
-	void __iomem *addr;
-
-	/* Check if port can be supported by that bus. We only check
-	 * the ranges of the PHB though, not the bus itself as the rules
-	 * for forwarding legacy cycles down bridges are not our problem
-	 * here. So if the host bridge supports it, we do it.
-	 */
-	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-	offset += port;
-
-	if (!(rp->flags & IORESOURCE_IO))
-		return -ENXIO;
-	if (offset < rp->start || (offset + size) > rp->end)
-		return -ENXIO;
-	addr = hose->io_base_virt + port;
-
-	/* WARNING: The generic code is idiotic. It gets passed a pointer
-	 * to what can be a 1, 2 or 4 byte quantity and always reads that
-	 * as a u32, which means that we have to correct the location of
-	 * the data read within those 32 bits for size 1 and 2
-	 */
-	switch (size) {
-	case 1:
-		out_8(addr, val >> 24);
-		return 1;
-	case 2:
-		if (port & 1)
-			return -EINVAL;
-		out_le16(addr, val >> 16);
-		return 2;
-	case 4:
-		if (port & 3)
-			return -EINVAL;
-		out_le32(addr, val);
-		return 4;
-	}
-	return -EINVAL;
-}
-
-/* This provides legacy IO or memory mmap access on a bus */
-int pci_mmap_legacy_page_range(struct pci_bus *bus,
-			       struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	resource_size_t offset =
-		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
-	resource_size_t size = vma->vm_end - vma->vm_start;
-	struct resource *rp;
-
-	pr_debug("pci_mmap_legacy_page_range(%04x:%02x, %s @%llx..%llx)\n",
-		 pci_domain_nr(bus), bus->number,
-		 mmap_state == pci_mmap_mem ? "MEM" : "IO",
-		 (unsigned long long)offset,
-		 (unsigned long long)(offset + size - 1));
-
-	if (mmap_state == pci_mmap_mem) {
-		/* Hack alert !
-		 *
-		 * Because X is lame and can fail starting if it gets an error
-		 * trying to mmap legacy_mem (instead of just moving on without
-		 * legacy memory access) we fake it here by giving it anonymous
-		 * memory, effectively behaving just like /dev/zero
-		 */
-		if ((offset + size) > hose->isa_mem_size) {
-			pr_debug("Process %s (pid:%d) mapped non-existing PCI",
-				current->comm, current->pid);
-			pr_debug("legacy memory for 0%04x:%02x\n",
-				pci_domain_nr(bus), bus->number);
-			if (vma->vm_flags & VM_SHARED)
-				return shmem_zero_setup(vma);
-			return 0;
-		}
-		offset += hose->isa_mem_phys;
-	} else {
-		unsigned long io_offset = (unsigned long)hose->io_base_virt -
-								_IO_BASE;
-		unsigned long roffset = offset + io_offset;
-		rp = &hose->io_resource;
-		if (!(rp->flags & IORESOURCE_IO))
-			return -ENXIO;
-		if (roffset < rp->start || (roffset + size) > rp->end)
-			return -ENXIO;
-		offset += hose->io_base_phys;
-	}
-	pr_debug(" -> mapping phys %llx\n", (unsigned long long)offset);
-
-	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end)
-- 
1.8.3.1

