Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B160C41E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiJYGyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiJYGyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5DA43301;
        Mon, 24 Oct 2022 23:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKFvQBEZfEDR63gRjhomQ3lidc7TFn6I1+IVDu0J9sBaPJK5hFQU+5lZbH4NxXZIZ2IvZq8EZ6uNluf6Wx/4xIOahgvigGO6h9zaa6x0qKQvrbnDI+6hrXY3FGVezVtYqnB6+6GjFpAN8fUcotIEvnWovgfwKdGOxGFPew0ffYQSeiKLFNeLzBMIThmxVXjxyEw+O326dto7hoQm/iw7IAY03zNeUSz4nOYtAcsJm3MwRGt1e+1CKYU8fr2QofZncIJMiyhKXppGVXpZsIVOzlLAPRjgM2f74y0al/0VaHIHnHWcBG2TPURpRPzcobKD/zaENPsiWcrQNoGf2P4d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OlJneRi2U1pLc3VrOTJl+hE6sjfNt4he202WZf6aDQ=;
 b=LQrPSsl0vEMmw9Q8iUnHMF02J8l4opiYEwkKtQTPxSOSWrQsfHDasIukY4QnrSpPKEUMiAGMupYHrgHM8t6IrZ0cQc+8CvFYzn14LdhRv6G8OcK5HT7EyLn6tERgsfP7RTU/7TyY3qArwF+rnKJw2GZTgqG12eM+LUvJyf3rNj+eiwQ467W4rQ/2ToABdhSjA66ZWvh52qeBWs4+I773Lezvgvu1WKnFzd0FIpKVrEQLMHzfqj7jIy9oaryoncl8criSINCpATU2e4z7lFTuRFwX4Qcw0ANGBa44dMrznmlGRBdvPlp0erlQGV7WJXI2XygenfWDzpkx5GtCA7WY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OlJneRi2U1pLc3VrOTJl+hE6sjfNt4he202WZf6aDQ=;
 b=O3ojNyFSMX6HBr8p6MiMvOK7uv4K9J9v98wXfPpiScnE9r6LrnhLwwOjeIjCX+Pa6CSmlvNEN2fx8wwYibteFsdbVfLDbZQ71Pitof4ua8SCpVTHvCakhw1PnF7DTtv3NgArusKnVhpko+k4xF5mdT/gv4iBSZm6VdmuOhQ4p5U=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 06:53:56 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::79) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:55 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:53 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 08/13] microblaze/PCI: Remove unused PCI Indirect ops
Date:   Tue, 25 Oct 2022 12:22:09 +0530
Message-ID: <20221025065214.4663-9-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddbd582-d17a-40f8-e37c-08dab655affb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5EnBRXirMoK9BpifcIfrVz6YsbyTABVfEvLFLNpQiBRGEJ/5s2nY5jMboUpmQgAN8e89VqwoNYF7hGb+Os0mwp0PBm5fT0RcfI9M/xz5f9JLwbJW7b6mq4VWKwyfiQwZ45kah403MNBjPsHA2Xl5hZSYWhpn84hFPhehtjU+ax9YpVibtCnDjJgtf+38ACz1zSnTdSFp6S+TxD6bAEy6DQyRRJymT2fPjSakm+GPheo3/IV513xmK2/rMHEKi34X4Zo0MKgbolixA7G7lPwzBkWC+7XATPDDeX6o1fmWCsoJ9DzZGhbYkPOlYCkG1YZYItS+GTwqPzrOgnHvgpzXlEkprw5LOrN/Y2M5brjlSEPFA5dKG7FwtV4yxlGeTLTWec5/7Sf/yQC2SWSv4TegQNaclHuFcfIHKpIz8sj/ye30PLfc+Ab40XO2XgWdmGMR667bGUasvjN+iGMBNgHDFGzIr29XMFrwCyr+pqHExBM6MwVcnvfImlh3owK6QoWeAmajJCXY/PwgRgd2TnNYFckLo8GDhS5Yr0i1Ct83HhB70q7GJg7u9XBBYT3LYSWUwVMxizhwi4Y37KN5qOhX4Sx2MxdpmkFnre8RnvaJny/7iOtdjNznk/Zb0agHYVoCzH9DZFhfgQYBFPI9B0OcPO8ug+Pfdu0/dxZTTbJNzBh3UEKG/cYWLnj+/68MWu4v0fArEVgNogaNeTeoxCwHaZJD+dMmmpJXkSkzF2xyLmGF5qS8hpSZ3lOiKe+rlEjNbbDiBA0zP+12nOM71i6fegs4rg+Qy4Cz7xQ631PC8WRbEwhX2UsyX061p5qyX3i
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(8676002)(44832011)(316002)(41300700001)(54906003)(110136005)(4326008)(40480700001)(8936002)(70206006)(70586007)(5660300002)(82740400003)(6666004)(478600001)(2616005)(1076003)(186003)(26005)(426003)(83380400001)(356005)(81166007)(40460700003)(47076005)(86362001)(336012)(82310400005)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:56.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddbd582-d17a-40f8-e37c-08dab655affb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused variants of PCI indirect handling.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h |  34 -------
 arch/microblaze/pci/Makefile             |   2 +-
 arch/microblaze/pci/indirect_pci.c       | 158 -------------------------------
 arch/microblaze/pci/xilinx_pci.c         |   6 --
 4 files changed, 1 insertion(+), 199 deletions(-)
 delete mode 100644 arch/microblaze/pci/indirect_pci.c

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 170369d..cd9ae71 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -32,8 +32,6 @@ struct pci_controller {
 	int first_busno;
 	int last_busno;
 
-	int self_busno;
-
 	void __iomem *io_base_virt;
 	resource_size_t io_base_phys;
 
@@ -42,34 +40,6 @@ struct pci_controller {
 	 */
 	resource_size_t pci_mem_offset;
 
-	struct pci_ops *ops;
-	unsigned int __iomem *cfg_addr;
-	void __iomem *cfg_data;
-
-	/*
-	 * Used for variants of PCI indirect handling and possible quirks:
-	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
-	 *  EXT_REG - provides access to PCI-e extended registers
-	 *  SURPRESS_PRIMARY_BUS - we suppress the setting of PCI_PRIMARY_BUS
-	 *   on Freescale PCI-e controllers since they used the PCI_PRIMARY_BUS
-	 *   to determine which bus number to match on when generating type0
-	 *   config cycles
-	 *  NO_PCIE_LINK - the Freescale PCI-e controllers have issues with
-	 *   hanging if we don't have link and try to do config cycles to
-	 *   anything but the PHB.  Only allow talking to the PHB if this is
-	 *   set.
-	 *  BIG_ENDIAN - cfg_addr is a big endian register
-	 *  BROKEN_MRM - the 440EPx/GRx chips have an errata that causes hangs
-	 *   on the PLB4.  Effectively disable MRM commands by setting this.
-	 */
-#define INDIRECT_TYPE_SET_CFG_TYPE		0x00000001
-#define INDIRECT_TYPE_EXT_REG		0x00000002
-#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
-#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
-#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
-#define INDIRECT_TYPE_BROKEN_MRM		0x00000020
-	u32 indirect_type;
-
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
@@ -91,9 +61,5 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 }
 #endif /* CONFIG_PCI */
 
-extern void setup_indirect_pci(struct pci_controller *hose,
-			       resource_size_t cfg_addr,
-			       resource_size_t cfg_data, u32 flags);
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_MICROBLAZE_PCI_BRIDGE_H */
diff --git a/arch/microblaze/pci/Makefile b/arch/microblaze/pci/Makefile
index 0251c20..3cbdf25 100644
--- a/arch/microblaze/pci/Makefile
+++ b/arch/microblaze/pci/Makefile
@@ -3,5 +3,5 @@
 # Makefile
 #
 
-obj-$(CONFIG_PCI)		+= pci-common.o indirect_pci.o iomap.o
+obj-$(CONFIG_PCI)		+= pci-common.o iomap.o
 obj-$(CONFIG_PCI_XILINX)	+= xilinx_pci.o
diff --git a/arch/microblaze/pci/indirect_pci.c b/arch/microblaze/pci/indirect_pci.c
deleted file mode 100644
index 1caf7d3..0000000
--- a/arch/microblaze/pci/indirect_pci.c
+++ /dev/null
@@ -1,158 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Support for indirect PCI bridges.
- *
- * Copyright (C) 1998 Gabriel Paubert.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/init.h>
-
-#include <linux/io.h>
-#include <asm/pci-bridge.h>
-
-static int
-indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		     int len, u32 *val)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	volatile void __iomem *cfg_data;
-	u8 cfg_type = 0;
-	u32 bus_no, reg;
-
-	if (hose->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
-		if (bus->number != hose->first_busno)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		if (devfn != 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	if (hose->indirect_type & INDIRECT_TYPE_SET_CFG_TYPE)
-		if (bus->number != hose->first_busno)
-			cfg_type = 1;
-
-	bus_no = (bus->number == hose->first_busno) ?
-			hose->self_busno : bus->number;
-
-	if (hose->indirect_type & INDIRECT_TYPE_EXT_REG)
-		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
-	else
-		reg = offset & 0xfc; /* Only 3 bits for function */
-
-	if (hose->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
-		out_be32(hose->cfg_addr, (0x80000000 | (bus_no << 16) |
-			 (devfn << 8) | reg | cfg_type));
-	else
-		out_le32(hose->cfg_addr, (0x80000000 | (bus_no << 16) |
-			 (devfn << 8) | reg | cfg_type));
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	cfg_data = hose->cfg_data + (offset & 3); /* Only 3 bits for function */
-	switch (len) {
-	case 1:
-		*val = in_8(cfg_data);
-		break;
-	case 2:
-		*val = in_le16(cfg_data);
-		break;
-	default:
-		*val = in_le32(cfg_data);
-		break;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		      int len, u32 val)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	volatile void __iomem *cfg_data;
-	u8 cfg_type = 0;
-	u32 bus_no, reg;
-
-	if (hose->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
-		if (bus->number != hose->first_busno)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		if (devfn != 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	if (hose->indirect_type & INDIRECT_TYPE_SET_CFG_TYPE)
-		if (bus->number != hose->first_busno)
-			cfg_type = 1;
-
-	bus_no = (bus->number == hose->first_busno) ?
-			hose->self_busno : bus->number;
-
-	if (hose->indirect_type & INDIRECT_TYPE_EXT_REG)
-		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
-	else
-		reg = offset & 0xfc;
-
-	if (hose->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
-		out_be32(hose->cfg_addr, (0x80000000 | (bus_no << 16) |
-			 (devfn << 8) | reg | cfg_type));
-	else
-		out_le32(hose->cfg_addr, (0x80000000 | (bus_no << 16) |
-			 (devfn << 8) | reg | cfg_type));
-
-	/* suppress setting of PCI_PRIMARY_BUS */
-	if (hose->indirect_type & INDIRECT_TYPE_SURPRESS_PRIMARY_BUS)
-		if ((offset == PCI_PRIMARY_BUS) &&
-			(bus->number == hose->first_busno))
-			val &= 0xffffff00;
-
-	/* Workaround for PCI_28 Errata in 440EPx/GRx */
-	if ((hose->indirect_type & INDIRECT_TYPE_BROKEN_MRM) &&
-			offset == PCI_CACHE_LINE_SIZE) {
-		val = 0;
-	}
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	cfg_data = hose->cfg_data + (offset & 3);
-	switch (len) {
-	case 1:
-		out_8(cfg_data, val);
-		break;
-	case 2:
-		out_le16(cfg_data, val);
-		break;
-	default:
-		out_le32(cfg_data, val);
-		break;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops indirect_pci_ops = {
-	.read = indirect_read_config,
-	.write = indirect_write_config,
-};
-
-void __init
-setup_indirect_pci(struct pci_controller *hose,
-		   resource_size_t cfg_addr,
-		   resource_size_t cfg_data, u32 flags)
-{
-	resource_size_t base = cfg_addr & PAGE_MASK;
-	void __iomem *mbase;
-
-	mbase = ioremap(base, PAGE_SIZE);
-	hose->cfg_addr = mbase + (cfg_addr & ~PAGE_MASK);
-	if ((cfg_data & PAGE_MASK) != base)
-		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	hose->cfg_data = mbase + (cfg_data & ~PAGE_MASK);
-	hose->ops = &indirect_pci_ops;
-	hose->indirect_type = flags;
-}
diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index 3fa16e3..5dc4182 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -83,7 +83,6 @@ static void xilinx_pci_fixup_bridge(struct pci_dev *dev)
  */
 void __init xilinx_pci_init(void)
 {
-	struct pci_controller *hose;
 	struct resource r;
 	void __iomem *pci_reg;
 	struct device_node *pci_node;
@@ -97,11 +96,6 @@ void __init xilinx_pci_init(void)
 		return;
 	}
 
-	/* Setup config space */
-	setup_indirect_pci(hose, r.start + XPLB_PCI_ADDR,
-			   r.start + XPLB_PCI_DATA,
-			   INDIRECT_TYPE_SET_CFG_TYPE);
-
 	/* Set the max bus number to 255, and bus/subbus no's to 0 */
 	pci_reg = of_iomap(pci_node, 0);
 	WARN_ON(!pci_reg);
-- 
1.8.3.1

