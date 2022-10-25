Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93BF60C441
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiJYGzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiJYGyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:54:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EC14DF07;
        Mon, 24 Oct 2022 23:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7vipnu1DgSPdzUjyua4fL+vBfzDllISKiCW/pxF67a8GTAYnp9BgnOrrGZgMxU5Psu+Ezl4zcQAvzwyS4mBMMvLDF9ZJZwTtkxMGoogP34Gb6y6DfoNhIkXaMe0N75acqobh8oF/Epa90QbAk7l45tWXTYQLHAY4FMdK5/A8Pc5mEADRXqj/vCLoY0nPF0bPkri9SNNK311yF1pHeC8l1dLEAZPF4HFSuLlbzTa2TxukqjQIorImYfzAZqv0qFj/xGcGcsqP7JacnyBpgKktkg54phQCxUpRz53lAd/7RNlxUAOxQ+jNrZ74SNfOLfoEPpoc/MwI2JjjsYj61C0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rUzid7b6GVMO/jRlFMvNVWbJt8BhirHY7i+auu5Qw=;
 b=dNK5lfHtdN2ZlAuK5lA6eOVkpotyTkcIPAZo+wXPim846wfqBrAqVrZvPQIISu0CJ+Si8zGgLLa16YuuEyCbwBQFwBzASOTCPaYwLE1Pxoo9gAyMyPdLVDUR3ShFLQGFMREIAbcAemEYk3cqs/ccLCbpgCtWIIklqrgUf/Tbr9GkDSRaQZU+CQi1FabZ1dc+vhGT5NPzw+lCHpa1800tmya15b0IUj67Hu4Cyo6C1RjzV3HKXSht9XWKseKQ0fuCN2x27Q0ccPIyrhXhqmv80BG7TLOmWsEZcOuiuZhNzQr5cmTftoUOpUg9uuxvUM5hOoIsThm4UZRyvIts3cQRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9rUzid7b6GVMO/jRlFMvNVWbJt8BhirHY7i+auu5Qw=;
 b=nCV4V/h6RdgUDQEdeLSRMvFPaWzMRw4Qd2retae9q+7oLjxS92AqjJ+qymVEdldsYy9YKf4xo5UYeTBvs0HI8boj7f648KQvwewsdBq0M1AxeLl9r36PXynZaL/6zu8isTDfAseEEYvuhNPD+xrPJWqkF9yzuPRJXfNzh55KUAk=
Received: from DS7PR03CA0126.namprd03.prod.outlook.com (2603:10b6:5:3b4::11)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:54:12 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::c0) by DS7PR03CA0126.outlook.office365.com
 (2603:10b6:5:3b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:54:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:54:11 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:54:08 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 13/13] microblaze/PCI: Moving PCI iounmap and dependent code
Date:   Tue, 25 Oct 2022 12:22:14 +0530
Message-ID: <20221025065214.4663-14-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 747400ca-ba91-4245-9a52-08dab655b94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iF+Xawzj20gL3bP7aLnE4VF5zJ19vOVDcm9zkAOMmW3oyhMgYFOV6gybx4JUeKjUqGExRANmD6IlHhtA0zVBtGCpGqG+kv2+j7gCqI9FwCo50y+IFeABkZy3enNlTy9sU7u/sNx+M2P4BYulmNYiph1w+sTMQu6lZ2lE3uovq/e7ro1Qjqop24+bUUDNvqjlR6Kzg8b6Tn3gKi0XQlK/A0u9T4oSDsDG5hXAqO/T3kGdzfwb4yMqUIoXFPzFxBcBmPn9pSGu4CtPzXIFe1NBfJz0GvGemlJ4yhDOdiFUblV+vAdNN+31TAbazWnwWS3fTFmQgvLUls3jXMBlPcKKznwwygG6Akh+3rEBkLnMxc3EqlsYF5NhSTs/b7EOkOTbCHsfwqHLTAbJJPTkMo6FqN6di8X5JGZJz8D0SdLvPpI9GZfR0a2cQmzvvDECOR9R3f+AWopGD8VmmLUFxgrtG0ofgxKEUGpHyukp1iXZFqqFfK+x398hgF+rTJUr8fBxEDsyItoAm50dQdwCD1ZUE/g9xI5Ft9IvpZmRSDSgAkbRQTYb0050QnlqubjY+9mPiU61QW1HVWUVkXULJs48lkjVLhLYnydUVPapdgm8eR1imVBtA986wVcrhAF+7GBlKCBTnXNrIz1C+iynsxmWfZaWch2mTxwJT3t/zp7ehG44be7RaXBRDimWloA1eJQuFlFaLibjosa7YBG3rGsGAhoTzUKmF6PYVFVIZ+gdKuHZns+RP15Z2yt6P7H3NqNsCmCesFfHUoQsefC4cBxaJsSo36Y+cGmL/04cuEvGptY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(2616005)(1076003)(186003)(426003)(47076005)(336012)(356005)(81166007)(83380400001)(86362001)(36860700001)(41300700001)(82740400003)(44832011)(2906002)(40460700003)(316002)(8936002)(5660300002)(82310400005)(40480700001)(478600001)(26005)(6666004)(70586007)(70206006)(4326008)(8676002)(110136005)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:54:12.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747400ca-ba91-4245-9a52-08dab655b94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moving PCI iounmap function and et all dependent code
to iomap.c.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/pci/Makefile     |  2 +-
 arch/microblaze/pci/iomap.c      | 36 ++++++++++++++++++++
 arch/microblaze/pci/pci-common.c | 72 ----------------------------------------
 3 files changed, 37 insertions(+), 73 deletions(-)
 delete mode 100644 arch/microblaze/pci/pci-common.c

diff --git a/arch/microblaze/pci/Makefile b/arch/microblaze/pci/Makefile
index 293b416..f8267d2 100644
--- a/arch/microblaze/pci/Makefile
+++ b/arch/microblaze/pci/Makefile
@@ -3,4 +3,4 @@
 # Makefile
 #
 
-obj-$(CONFIG_PCI)		+= pci-common.o iomap.o
+obj-$(CONFIG_PCI)		+= iomap.o
diff --git a/arch/microblaze/pci/iomap.c b/arch/microblaze/pci/iomap.c
index bde74af..b2ee8ac 100644
--- a/arch/microblaze/pci/iomap.c
+++ b/arch/microblaze/pci/iomap.c
@@ -11,6 +11,42 @@
 #include <linux/io.h>
 #include <asm/pci-bridge.h>
 
+static DEFINE_SPINLOCK(hose_spinlock);
+LIST_HEAD(hose_list);
+
+unsigned long isa_io_base;
+EXPORT_SYMBOL(isa_io_base);
+
+static resource_size_t pcibios_io_size(const struct pci_controller *hose)
+{
+	return resource_size(&hose->io_resource);
+}
+
+int pcibios_vaddr_is_ioport(void __iomem *address)
+{
+	int ret = 0;
+	struct pci_controller *hose;
+	resource_size_t size;
+
+	spin_lock(&hose_spinlock);
+	list_for_each_entry(hose, &hose_list, list_node) {
+		size = pcibios_io_size(hose);
+		if (address >= hose->io_base_virt &&
+		    address < (hose->io_base_virt + size)) {
+			ret = 1;
+			break;
+		}
+	}
+	spin_unlock(&hose_spinlock);
+	return ret;
+}
+
+/* Display the domain number in /proc */
+int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if (isa_vaddr_is_ioport(addr))
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
deleted file mode 100644
index e5c2051..0000000
--- a/arch/microblaze/pci/pci-common.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Contains common pci routines for ALL ppc platform
- * (based on pci_32.c and pci_64.c)
- *
- * Port for PPC64 David Engebretsen, IBM Corp.
- * Contains common pci routines for ppc64 platform, pSeries and iSeries brands.
- *
- * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
- *   Rework, based on alpha PCI code.
- *
- * Common pmac/prep/chrp pci routines. -- Cort
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/mm.h>
-#include <linux/shmem_fs.h>
-#include <linux/list.h>
-#include <linux/syscalls.h>
-#include <linux/irq.h>
-#include <linux/vmalloc.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-#include <linux/export.h>
-
-#include <asm/processor.h>
-#include <linux/io.h>
-#include <asm/pci-bridge.h>
-#include <asm/byteorder.h>
-
-static DEFINE_SPINLOCK(hose_spinlock);
-LIST_HEAD(hose_list);
-
-unsigned long isa_io_base;
-EXPORT_SYMBOL(isa_io_base);
-
-static resource_size_t pcibios_io_size(const struct pci_controller *hose)
-{
-	return resource_size(&hose->io_resource);
-}
-
-int pcibios_vaddr_is_ioport(void __iomem *address)
-{
-	int ret = 0;
-	struct pci_controller *hose;
-	resource_size_t size;
-
-	spin_lock(&hose_spinlock);
-	list_for_each_entry(hose, &hose_list, list_node) {
-		size = pcibios_io_size(hose);
-		if (address >= hose->io_base_virt &&
-		    address < (hose->io_base_virt + size)) {
-			ret = 1;
-			break;
-		}
-	}
-	spin_unlock(&hose_spinlock);
-	return ret;
-}
-
-/* Display the domain number in /proc */
-int pci_proc_domain(struct pci_bus *bus)
-{
-	return pci_domain_nr(bus);
-}
-- 
1.8.3.1

