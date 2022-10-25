Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42E60C421
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiJYGyK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJYGyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E743323;
        Mon, 24 Oct 2022 23:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKGZ+hVHz7CM13uZavl4ohtF0qeaJHaXHI+imRaNqSxkKP4GDG7FqRi1jwcOC1MFTF1aP/RNLmSIPhy7Ciahiry+F5VVLWpeSpHknDDcNgop68rjNVkG4vX+hpQdm5XLmt/wTsJo3ueB61cYi+5h8+JRySPPl0XqzhSurn598YrUhQSFmQxfuFYZszfoPTShpKKfs0BuDVbfJxeEISiDFLtSex0LGUtT9xpUOWs27NySb8XFd5c0VWULp5JMJNBDMimFXNPFr+zKkhi95CxZQ0P+cSK9lP7Cz751KJ4EeEBQb8nbAmhPImM3ecX3CMOGYaZLYEgZSn2qnCW8Nqf/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htx3gIc80b32CjNddX8xJD26o9LADLRUJpXyr/y/+3g=;
 b=NBVMOLD1GtoemfPwAGKd7LK99nt2770w1oSy4Q61qA3s/WghKVi5FQBheBmq+yFzQ8gloh63/g3syJyTIfvsmjShTSj0rf/TNqik31SUBsyU8vXHfGn2xuu4j7HOOqEj/nBJjdNufNK5o0p3RASqFQZLyb2J4VmHe+DYDD/85qoc1VRNSVbFMGbTHmPTsa7uvyVRWpPvNQsTbT66pphzSsE8EFKn/ic6SXxm0frupQVNWxFfh9Giu3g1fDIAhMPFTH+iM58EvFgR42b5M/apejkgj4ip87LxwZi6s8xzTRQ7DMfNMomBX3Hvd3fNLs9frjGFekbQZXO3jtlf8vR19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htx3gIc80b32CjNddX8xJD26o9LADLRUJpXyr/y/+3g=;
 b=gpb0C4PnMtl72DCdW1azN3Kq6+oZ9TS69tEG1GqkXeAV3nIPLKy8PlIzc+afEz6MQQNFymx7t3VR9Ples7sUTXy9zVqMmjQtSuKLXUCyMetMp2gkyCl9K7fgqM811yOzHGoHEfCJIlWW+rI+38c8fWI9vA9tVZVWBDK/BVPE7UI=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:54:03 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::79) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:54:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:54:02 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:59 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 10/13] microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al declaration
Date:   Tue, 25 Oct 2022 12:22:11 +0530
Message-ID: <20221025065214.4663-11-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CH0PR12MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b62dc9-3d1d-4093-9e29-08dab655b3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fsz3MJwfAkv9I0dkM3T8DYXFooPFMF6ov1JwdnybMybVPov5EwHuzf06U0hAf/+LtbsRSdcennCgcFZ0yTWdT16UqYDAoURjuXpdEUQxTFmPne+PZ2gxmFY17RU1VSjAe1QToarKndSX2Jr/xr9PkUzqe5/iRg1UDNjHkLpymBu0CHIOhJLTRdyJYMJifX/GuAExkQye62HfciJjWiF6xMM/YTyjEQBU8J+SPFGCuJqStURTQxxlv95REV/6JoObFgAP6XhCTfPVY6b4Q6YLdcTm8HygT2zzIN9jkbUM1QZFfvIcPVPjs3GP+TQoD0cXC2A4b34uWcpmKRvmgc1iVwMi0ezBw1DqtI22ROhpRHb3C+6ZjkUkXoph9nGywZEz/y2HG10WWx03BSHbxvn/dq9Lninw+gbWsoy4Sm8HseA3QHViKvthWgDUisKeVZigiL+wz3Tgwkyr0GlK6ZFh2eX5F8eIXZnXgj9jHSY3m0ZdVfTfLPviNJNJzftgjS4jfT01zEc1hTB5BI2nH+RM9LDm1Jn3j61uQOr6jZOSoGqA8vwSDvyuITkddyqPgmxV+Hf2obTV1odiQ5nu2w6aJ4DVaXZpFb6K9rYfjf7HR+wURtVb0023s+BKnDXRIxLxeyFrH4ed9ZJlAxEClaBcLfEOitoAi636YjfvBqTSmumG9QEBpD3bYeexFa+HgnhoCl/b6G49Gu6YOWyal8Ku8z9zUcGBpqEwNivQgH9U4uticFQ9wtMDgiktP8TdS1alPhHjNs/ueWJv9cLzLgEz9ZJCWXDOz90T8y/K/e9HVnTt1tU77M+EM2mpsXR7ECOE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(86362001)(478600001)(1076003)(70586007)(36756003)(4326008)(6666004)(8676002)(41300700001)(316002)(5660300002)(26005)(8936002)(54906003)(110136005)(40460700003)(44832011)(40480700001)(426003)(47076005)(336012)(186003)(2906002)(2616005)(82310400005)(70206006)(356005)(81166007)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:54:02.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b62dc9-3d1d-4093-9e29-08dab655b3b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Removed unused code which provides information of various
I/O regions.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  8 ------
 arch/microblaze/include/asm/pci.h        |  7 -----
 arch/microblaze/pci/pci-common.c         | 44 --------------------------------
 3 files changed, 59 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index cd9ae71..9c89ae4 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -29,17 +29,9 @@ struct pci_controller {
 	struct list_head list_node;
 	struct device *parent;
 
-	int first_busno;
-	int last_busno;
-
 	void __iomem *io_base_virt;
 	resource_size_t io_base_phys;
 
-	/* Some machines (PReP) have a non 1:1 mapping of
-	 * the PCI memory space in the CPU bus space
-	 */
-	resource_size_t pci_mem_offset;
-
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 6da7523..52d572d 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -21,13 +21,6 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
-/* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
-#define IOBASE_BRIDGE_NUMBER	0
-#define IOBASE_MEMORY		1
-#define IOBASE_IO		2
-#define IOBASE_ISA_IO		3
-#define IOBASE_ISA_MEM		4
-
 /*
  * Set this to 1 if you want the kernel to re-assign all PCI
  * bus numbers (don't do that on ppc64 yet !)
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 555281c..a1de853 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -38,9 +38,6 @@
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
-/* ISA Memory physical address */
-resource_size_t isa_mem_base;
-
 unsigned long isa_io_base;
 EXPORT_SYMBOL(isa_io_base);
 
@@ -92,44 +89,3 @@ int pci_proc_domain(struct pci_bus *bus)
 {
 	return pci_domain_nr(bus);
 }
-
-static struct pci_controller *pci_bus_to_hose(int bus)
-{
-	struct pci_controller *hose, *tmp;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-		if (bus >= hose->first_busno && bus <= hose->last_busno)
-			return hose;
-	return NULL;
-}
-
-/* Provide information on locations of various I/O regions in physical
- * memory.  Do this on a per-card basis so that we choose the right
- * root bridge.
- * Note that the returned IO or memory base is a physical address
- */
-
-long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
-{
-	struct pci_controller *hose;
-	long result = -EOPNOTSUPP;
-
-	hose = pci_bus_to_hose(bus);
-	if (!hose)
-		return -ENODEV;
-
-	switch (which) {
-	case IOBASE_BRIDGE_NUMBER:
-		return (long)hose->first_busno;
-	case IOBASE_MEMORY:
-		return (long)hose->pci_mem_offset;
-	case IOBASE_IO:
-		return (long)hose->io_base_phys;
-	case IOBASE_ISA_IO:
-		return (long)isa_io_base;
-	case IOBASE_ISA_MEM:
-		return (long)isa_mem_base;
-	}
-
-	return result;
-}
-- 
1.8.3.1

