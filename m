Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704660C434
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJYGyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiJYGyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ED9F5CDD;
        Mon, 24 Oct 2022 23:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5mF3Lgar9S5JjJ6yChDrncPaFLvpbFk0Wfb+5WKcp33gMN5r8VMdtUE5ac0hnEmu8u1WnP+JU17KXBL2vCtQJRSA7ZRgdM7tEgkcjVqhi4fX7cH7yUHI0sla5ZxXCjOzngKB+rK+ZEbkvEK22AXaetzi/PmtCf3czBmfpJ7wbVM0In9QLYLEJMTjJBB1CldmJ0ODsQoPiisyE8gyInXom0xRtqeDEPG7qlAP4d915qWbgnbiBL+7A4RQZQLzMoMnvJw7wBsUv0wUYK6oTRYz2Vax1v+G5QcWNkKjlAkigmJvq1lqYFc2P91IJCZHUKgIl5t1SwAFep4vEBjg6PS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNmc0ViRQ0BiI9dEUPMNkAPWKmquEQOo/ZcNAn88p18=;
 b=YScW3la8+xSGKmZS491lWYDklUBdSMlImineQnIA6LFLGZWQL8FwjvkzZkSRKnyFkCzNhHo0VTbJKBIJcJ8J4FNU93+NeRB5JdI1Ic2Q0dyrGQ3ZRWVH50IVm9QV25rAZiHXp0r8q/6neOQnDsWhrjJictCyLqECkMMXymyOwfpcxnHjJoDpgyzb5fOQU2GNn8GWSf6SEcGFO5e7vd1PLL6ts5e03pCAxcN9P7n9/WGUuTrkncE7nwckoO7Z7PykAJ+u/FnyxTH07tdQP++GJTO0Uc9XujH7Oc5YeebIfycPS9+Z7T/OHDtFyhPGA6zh3w0T16e4kjEnVmwmiJKsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNmc0ViRQ0BiI9dEUPMNkAPWKmquEQOo/ZcNAn88p18=;
 b=x4niXnQUxNmm44Wp255fB1L7EOEdPkVJk2lbhIV9c8RLO80m9LCRBxZ2pSXL8oZrtDohl6mrznlcU+yuNoXFE85DJ8SaTBe13EgN4cu0gWpEjWKXpMenoIOx6z4MX6qOJ8avTNbJH22zjUpM4UXCmZ3I8adttY6xuCh9GV3NL7E=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:54:09 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::31) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:54:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:54:08 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:54:05 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 12/13] microblaze/PCI: Remove support for Xilinx PCI host bridge
Date:   Tue, 25 Oct 2022 12:22:13 +0530
Message-ID: <20221025065214.4663-13-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: a47f1b61-5d91-40df-a81d-08dab655b76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqHu0DFl6j+xHnqgMfMgaBnNspr7fy2AspCxllqB97t/aTO7+n7cH2yAoqOJ+vDc2GmXinUtbg0udpsTuz7S5ob41bPAOXNyQeY1b1EEoaMu3dKvkyNLxCmX2IgxgoygrXyI86cRaqyN/zPbo6PrcOhDabaQV8udOwuZr5vq7YYO2TGcRxyTxwOoGT8qlmI/3N3xgkMNkw6ujEcaHXl3ey62Hci251ciyeV5CIYZxbgreBq3jS0zCCPxRxiXWp08NL9/VvX3q1xsNLPYwJ4r03vHKLRZ3EqaExgRQrje72x8V9aGYcKYFWIusZUx159qtSc+CaImQ4ObYbB4YPHlnIvHU2UdXubqJFQDfcV0F8A2Tyz6GhjEvFy6rBMgwflf4kLGauaHhv5nYxJcfMeFNtbEjJ0zmlE1HV6/FHxJpq6XKgsK6ONp0RB/sZVUqWFsepWGzWOZIk5mrKD/m6N7wpiLJb2NqetQRbdM3KizyTXWavzm2YIHJWeJhlBRyz/I9FjRIDI2t6we8mSUYz3aHHqmaCaryvevY/qahB/XzR4VC3tnyCk2qw7zVUCqdATiv0j44xVsYEGpKkR7uPrRfAR1KStekiUEBxlao5sOMtk/WtSoAkGZnOv3sBpGBG8orOdxPZplijwX7hrW/HeKJZsECYtsn4Bl14haF9SkWh08TPvX0DJcu/QDS2jfHj3atybsMuOv4svyQ28xXh68aaRANNJYjASueP6TGSaY/4HTT5gDBp3AJmmWKj7fU9ZpQef54bsfPS67Ubfowcpxmo/j7Juo4H9GVzrtGUSmm0pTYv66gm6p6CD7mSlZEMCC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(316002)(81166007)(40480700001)(54906003)(110136005)(36860700001)(356005)(5660300002)(82740400003)(4326008)(70586007)(70206006)(8676002)(8936002)(41300700001)(426003)(26005)(86362001)(336012)(6666004)(478600001)(1076003)(186003)(40460700003)(83380400001)(2616005)(47076005)(82310400005)(2906002)(36756003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:54:09.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47f1b61-5d91-40df-a81d-08dab655b76a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch removes support for the Xilinx PCI host
bridge IPcore.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/Kconfig                  |   8 ---
 arch/microblaze/include/asm/pci-bridge.h |   6 --
 arch/microblaze/include/asm/pci.h        |   5 --
 arch/microblaze/pci/Makefile             |   1 -
 arch/microblaze/pci/xilinx_pci.c         | 105 -------------------------------
 5 files changed, 125 deletions(-)
 delete mode 100644 arch/microblaze/pci/xilinx_pci.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 996132a..9bacdab 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -205,11 +205,3 @@ config TASK_SIZE
 	default "0x80000000"
 
 endmenu
-
-menu "Bus Options"
-
-config PCI_XILINX
-	bool "Xilinx PCI host bridge support"
-	depends on PCI
-
-endmenu
diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 5db2c66..be5f504 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -25,7 +25,6 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
  */
 struct pci_controller {
 	struct pci_bus *bus;
-	struct device_node *dn;
 	struct list_head list_node;
 
 	void __iomem *io_base_virt;
@@ -37,11 +36,6 @@ struct pci_controller {
 };
 
 #ifdef CONFIG_PCI
-static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
-{
-	return bus->sysdata;
-}
-
 static inline int isa_vaddr_is_ioport(void __iomem *address)
 {
 	/* No specific ISA handling on ppc32 at this stage, it
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index a75bf3b..91f1f71 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -38,12 +38,7 @@
 
 struct file;
 
-/* This part of code was originally in xilinx-pci.h */
-#ifdef CONFIG_PCI_XILINX
-extern void __init xilinx_pci_init(void);
-#else
 static inline void __init xilinx_pci_init(void) { return; }
-#endif
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_MICROBLAZE_PCI_H */
diff --git a/arch/microblaze/pci/Makefile b/arch/microblaze/pci/Makefile
index 3cbdf25..293b416 100644
--- a/arch/microblaze/pci/Makefile
+++ b/arch/microblaze/pci/Makefile
@@ -4,4 +4,3 @@
 #
 
 obj-$(CONFIG_PCI)		+= pci-common.o iomap.o
-obj-$(CONFIG_PCI_XILINX)	+= xilinx_pci.o
diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
deleted file mode 100644
index 5dc4182..0000000
--- a/arch/microblaze/pci/xilinx_pci.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * PCI support for Xilinx plbv46_pci soft-core which can be used on
- * Xilinx Virtex ML410 / ML510 boards.
- *
- * Copyright 2009 Roderick Colenbrander
- * Copyright 2009 Secret Lab Technologies Ltd.
- *
- * The pci bridge fixup code was copied from ppc4xx_pci.c and was written
- * by Benjamin Herrenschmidt.
- * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/ioport.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/pci.h>
-#include <linux/io.h>
-
-#define XPLB_PCI_ADDR 0x10c
-#define XPLB_PCI_DATA 0x110
-#define XPLB_PCI_BUS  0x114
-
-#define PCI_HOST_ENABLE_CMD (PCI_COMMAND_SERR | PCI_COMMAND_PARITY | \
-				PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)
-
-static const struct of_device_id xilinx_pci_match[] = {
-	{ .compatible = "xlnx,plbv46-pci-1.03.a", },
-	{}
-};
-
-/**
- * xilinx_pci_fixup_bridge - Block Xilinx PHB configuration.
- */
-static void xilinx_pci_fixup_bridge(struct pci_dev *dev)
-{
-	struct pci_controller *hose;
-	int i;
-
-	if (dev->devfn || dev->bus->self)
-		return;
-
-	hose = pci_bus_to_host(dev->bus);
-	if (!hose)
-		return;
-
-	if (!of_match_node(xilinx_pci_match, hose->dn))
-		return;
-
-	/* Hide the PCI host BARs from the kernel as their content doesn't
-	 * fit well in the resource management
-	 */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		dev->resource[i].start = 0;
-		dev->resource[i].end = 0;
-		dev->resource[i].flags = 0;
-	}
-
-	dev_info(&dev->dev, "Hiding Xilinx plb-pci host bridge resources %s\n",
-		 pci_name(dev));
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, xilinx_pci_fixup_bridge);
-
-#ifdef DEBUG
-/**
- * xilinx_pci_exclude_device - Don't do config access for non-root bus
- *
- * This is a hack.  Config access to any bus other than bus 0 does not
- * currently work on the ML510 so we prevent it here.
- */
-static int
-xilinx_pci_exclude_device(struct pci_controller *hose, u_char bus, u8 devfn)
-{
-	return (bus != 0);
-}
-#endif
-
-/**
- * xilinx_pci_init - Find and register a Xilinx PCI host bridge
- */
-void __init xilinx_pci_init(void)
-{
-	struct resource r;
-	void __iomem *pci_reg;
-	struct device_node *pci_node;
-
-	pci_node = of_find_matching_node(NULL, xilinx_pci_match);
-	if (!pci_node)
-		return;
-
-	if (of_address_to_resource(pci_node, 0, &r)) {
-		pr_err("xilinx-pci: cannot resolve base address\n");
-		return;
-	}
-
-	/* Set the max bus number to 255, and bus/subbus no's to 0 */
-	pci_reg = of_iomap(pci_node, 0);
-	WARN_ON(!pci_reg);
-	out_be32(pci_reg + XPLB_PCI_BUS, 0x000000ff);
-	iounmap(pci_reg);
-
-}
-- 
1.8.3.1

