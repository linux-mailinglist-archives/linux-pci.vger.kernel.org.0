Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8360C40B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJYGxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYGxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AFDCD5F9;
        Mon, 24 Oct 2022 23:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI60PHmMkysWpm39Wqcklfiyq83cq17iN19WfTIZvCpuc6mYae404THXfontYE0vxtZpndzwQphrutckXEQ3tJlKantkNkBB3zxJCeT1xDh0m3CNEd4cqWSjHZWmzGBCMGXzKDt7GHan6gLw292gdv39UE3JaEfQdyNuajFcwvspe+YNjLcDPFiFQbJuenHJe9zfRof2t8Pht8cmUnrpHIvLlsVeG1dMlWDjNMqgLtYNwvkjmrdD7uGpiP5vDxkB91eCIcKM1J5swsw9xaZfr7JuB9oCXyHD6AhGiF25VzjfQ/7cTdYiP22GlsrGDbNcceHtOHVluN7ReoLIBbN1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZPJJahAvYM9GOhoWjDEhyPeof8yzWTmQGoD3VO4gT0=;
 b=SzH0qbxfi5OE075RebsPeSks2m9Rd5p7qAv6iwgJU9njkBxz7y4gzzAB9+pldkKSHX+BLOa7wUDofVUTZ5oc9RgnRnGynYLPqEqXmYOXz3I1wk6kJiL5JStNsGMjH04VwjytPAsw9JUNzeu/dy/elEG5STvHjAtr+98ThsV5PTcPas6pWoi7f3PplU9mJ/2CzG6OxXhjGkeJRdS5g1WewLnCT0WSrSdNDsnusBDeHqbovEp72DxImWpK74QGkz0NZIjkO4y6frkfcNn9f9fthfv54Q5n0+ScGr4kXOkFRfewgWx84+rkBQjagA4hy+zDhQyarP4lCgIACN+Y7cadbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZPJJahAvYM9GOhoWjDEhyPeof8yzWTmQGoD3VO4gT0=;
 b=Kp+oDLCNrQxFWWRCGMzs5JZY/KRRjn9bV14J8odbGPlIU5pz+8pEgHjWiev7Itkr6SUGKWfMWTikgMJnVYur2ZCvQRm58CCwQqioc+6KNi7S031pEr+VEevIS6hImtxNcpxno4z8wwuBBpF+2EUftCOaN5zPvt5n1ZJYcfpdjF4=
Received: from DM6PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:333::23)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:53:03 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::13) by DM6PR03CA0090.outlook.office365.com
 (2603:10b6:5:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:01 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:52:58 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 01/13] microblaze/PCI: Remove unused early_read_config_byte() et al declarations
Date:   Tue, 25 Oct 2022 12:22:02 +0530
Message-ID: <20221025065214.4663-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|SJ0PR12MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f3855e-6741-46e9-8afb-08dab6559008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCZ+WoypvesvjAKU1Vab+mCx/XZV+mRCXdvz+NoS8ZC6Wnz9Fn6mutkDWjWE/4soNuAxm7V46MVM24KBDCIvlz2rbDfByugMTOxoG1+52jlzYrmI/KRi4/niSXT0WMVXjT6Hpx9bWP5/35/gMptwPWZfXpIv5iE/XAVIowEsNd49ZprMNsQYj+548Ir2cEwGrvwW6EHL6f/OM+qNSqJ7+wukrnv+ij9CLjy/OkmenE9E7RuJEW8IiXF0i7JYS1jhsoz6/5YkKysIjacnjSl44NgnK2hv9AuTeA2pZl8vOoM7P+tF17i32PnqhGVofWAMt7/zh1IIdMHvnFy9sLIbEGr3FyXSWEePJBJjSU8eAAP9CGLiwsS/3DTozBJahD6GZ+E3U4f2s47QDk3zxBNgbW1P7tmAWMeIq13hx1sVCk7RJ5DmE6zydFFQyc9vkTmUQfDLwZ2miLRA66vAxQZWJc173bvQHdHXoukywH7wvRoa8wcWQdCNEUTUYrLrlxec5+j90BYnvs0yOxyFTa2647KAzjrUP/tEl6qyZHrdAJ/om1XAZvyWEncfVn40aTkOOSoL0KX3XECw924vkc7whTVXjs+IuvJ0m0auvPuyMd7TbzKDtMKFtLdoGmKg9/PA8KMGUoUw3beAoQhj6KKSpiCaR4OzNWK9Gz0hdeENJqiZ0ftNopf17cGk3Rd+mvPi5rb0EIdUd4PpQ5ybk7oaS7QW2Q8YHflMSGwm5KJYQrTlvtAn4PntqN4x5tTaGQGnfrMU0i1rWOvuX9Tilq4TvJGqOrMcXBH4YKQfleizf2nP2i+V1+SU/l6oABo4CTnk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(316002)(70206006)(70586007)(40480700001)(82310400005)(36860700001)(336012)(44832011)(82740400003)(356005)(81166007)(2906002)(4326008)(41300700001)(8676002)(26005)(6666004)(36756003)(478600001)(110136005)(54906003)(47076005)(426003)(86362001)(8936002)(5660300002)(83380400001)(1076003)(186003)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:03.0519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3855e-6741-46e9-8afb-08dab6559008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

early_read_config_byte() and similar are declared but never defined.

Remove the unused declarations.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/include/asm/pci-bridge.h | 18 ------------
 arch/microblaze/pci/pci-common.c         |  5 ----
 arch/microblaze/pci/xilinx_pci.c         | 48 --------------------------------
 3 files changed, 71 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 171b40a..a9d3940 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -103,24 +103,6 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 }
 #endif /* CONFIG_PCI */
 
-/* These are used for config access before all the PCI probing
-   has been done. */
-extern int early_read_config_byte(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u8 *val);
-extern int early_read_config_word(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u16 *val);
-extern int early_read_config_dword(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u32 *val);
-extern int early_write_config_byte(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u8 val);
-extern int early_write_config_word(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u16 val);
-extern int early_write_config_dword(struct pci_controller *hose, int bus,
-			int dev_fn, int where, u32 val);
-
-extern int early_find_capability(struct pci_controller *hose, int bus,
-				 int dev_fn, int cap);
-
 extern void setup_indirect_pci(struct pci_controller *hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 33bab7e..69ce51c 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1060,8 +1060,3 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
 EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
 
-int early_find_capability(struct pci_controller *hose, int bus, int devfn,
-			  int cap)
-{
-	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
-}
diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index f4cb86f..7ed6647 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -76,44 +76,6 @@ static void xilinx_pci_fixup_bridge(struct pci_dev *dev)
 {
 	return (bus != 0);
 }
-
-/**
- * xilinx_early_pci_scan - List pci config space for available devices
- *
- * List pci devices in very early phase.
- */
-static void __init xilinx_early_pci_scan(struct pci_controller *hose)
-{
-	u32 bus = 0;
-	u32 val, dev, func, offset;
-
-	/* Currently we have only 2 device connected - up-to 32 devices */
-	for (dev = 0; dev < 2; dev++) {
-		/* List only first function number - up-to 8 functions */
-		for (func = 0; func < 1; func++) {
-			pr_info("%02x:%02x:%02x", bus, dev, func);
-			/* read the first 64 standardized bytes */
-			/* Up-to 192 bytes can be list of capabilities */
-			for (offset = 0; offset < 64; offset += 4) {
-				early_read_config_dword(hose, bus,
-					PCI_DEVFN(dev, func), offset, &val);
-				if (offset == 0 && val == 0xFFFFFFFF) {
-					pr_cont("\nABSENT");
-					break;
-				}
-				if (!(offset % 0x10))
-					pr_cont("\n%04x:    ", offset);
-
-				pr_cont("%08x  ", val);
-			}
-			pr_info("\n");
-		}
-	}
-}
-#else
-static void __init xilinx_early_pci_scan(struct pci_controller *hose)
-{
-}
 #endif
 
 /**
@@ -146,15 +108,6 @@ void __init xilinx_pci_init(void)
 			   r.start + XPLB_PCI_DATA,
 			   INDIRECT_TYPE_SET_CFG_TYPE);
 
-	/* According to the xilinx plbv46_pci documentation the soft-core starts
-	 * a self-init when the bus master enable bit is set. Without this bit
-	 * set the pci bus can't be scanned.
-	 */
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, PCI_HOST_ENABLE_CMD);
-
-	/* Set the max latency timer to 255 */
-	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0xff);
-
 	/* Set the max bus number to 255, and bus/subbus no's to 0 */
 	pci_reg = of_iomap(pci_node, 0);
 	WARN_ON(!pci_reg);
@@ -166,5 +119,4 @@ void __init xilinx_pci_init(void)
 					INDIRECT_TYPE_SET_CFG_TYPE);
 
 	pr_info("xilinx-pci: Registered PCI host bridge\n");
-	xilinx_early_pci_scan(hose);
 }
-- 
1.8.3.1

