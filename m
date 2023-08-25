Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1F789268
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 01:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHYXei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjHYXeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 19:34:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82126BD;
        Fri, 25 Aug 2023 16:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAkBB36V6aWLSe01PVFBKbxJFjX+N+vuO3Nz4kOzWtUX+Vk8gy1mW/S4C5L3AyPffqGznDqZaLb6WwVtLkIE4tx0wIt+V+lWjQLP+suaYPjHcpCLHpm1w7pUaXeq6jX7DwzeIlw4LCB6w7ICckaZjMK7dEQv62JUslotMS/zGKmcLx2ka27BBvPRe5YFYjYhjax50IXe6Qq19tH3fZ/pGK5f56ZsE2yRZ8lO8Pp35yTThCfocUMNTdyVejY6oDw5EwmlzYy8JYsBqM4ph1fCHaveeXWUhlvKkmHm1jsxErnEk8R6LSbIPNOi73lMwkUUmXcgUCXXG7olWrN7FFkWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btQEIKahGA+dVKNXsDbpcedjVIVjE9vkFI70RgFbKSs=;
 b=jP37kRM6efNRDUp+GPzzo8uQqVOklsBaKK4hIMEC4bWMaWm48BsE6eTxhEmYDachJZMMqZKm8MoaoliyK3AeFNX06GxezKfmhZHKimh55PVpbUHjJy9BSuxsgy2xGtWqxPuGo4o4JHr4fBBxIBj340OFl3EvK0GDtwS5t0iOgjdLeoiakI3bu79UWzdlav3hc7ajY/DV6nHuoubc3UCVqLcZvdHGgGWN42bn9CMYuRxUP5N9ft8DQ/FCVm9qXrVB0DxQw+CDICr6QcWks9nsLfqBT7Hd6soj00i+5BtnqeSgJ8/bs44MSTqyDfYUbT8J4xO3Ups2n+i7wUYcNcP+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btQEIKahGA+dVKNXsDbpcedjVIVjE9vkFI70RgFbKSs=;
 b=tdyTcO+SdL7Zjiz9uJdofarHWITlZ+hg0Q+BYTuBQTeFTcJ01VzbhLozgKgoLEeJZKHk5QPCNo5uL2HqhJ48h8GyeCC5HuF/3IW0AoC/YZp4EcHTKTH2YjRpAVOXBPq5SAL6wNAiJFuOrYY4OXyDQ1qzP1tfvqTu60JeYe6udDE=
Received: from SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::7)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 25 Aug
 2023 23:33:59 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::73) by SA1P222CA0034.outlook.office365.com
 (2603:10b6:806:2d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 23:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:33:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:33:58 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v9 08/15] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Fri, 25 Aug 2023 18:32:04 -0500
Message-ID: <20230825233211.3029825-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0166ce-a6d0-49a0-157a-08dba5c3c1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0jpy0ZaHOBQvh1lTvQDQds9Z0IOUJzdBddtM2VU6BILPOj4kPgKc7RfXpkpqNWhrSIThBAhO/HGVv0e+DJSq6hN8vVrVPJ0IxwvKGgOQViFhduntZoVbFquFLrxD4qJjJXKNtOxqgcLBXRlQwwQiUXpJQdsoursUj6oLKG5ReTJ68Iy7JwRgQoFtJi9DWwpSPznjtrf+kw9fHUs+pt2jmJWYLvZacrABTTER+2pJYjwRKbd9k2t2OdZFZrJl/jdBXWvLKKt9XuzBkFg4f0qgsJIPYwEKZsfnBOmVSyp4vhQiDRit4jiWCm+SGqlakVJh6QXyrqcSG9s8Y1giRdvC8fs7LYyk3hz2Xi4MYtGrEEytESZfI9BYc7lGwXUatJvg1S1vIjxPwXPLjJ+RgIti6YDaiX3nYYuLCsOlwtEQvb49FIgnJzttrDUvuICSbY2Zym0OY3xG0SBgHAsDCQ6CtnJ9N5Ni3lBasZa4McrDq0rojlL6V8XjlK8QvzYAiW8BsJ+mGYUUVEMlNjBCxQGQQAeDsvW5FQeWZv0TqBy8Zb+EHOzaXyY1iKLw51RUowIz2KUF5wSz01dlDbtZvlPPOBZwlIZraDSxzuQjXeuwjjjlB7oc50kxyqBb9Tlb3bME5YWLHmBoiv9iZjyIY0zEJFQmBQUsnoZj8XjFdNTElAIECPjGzyaF/rSmDPjIA2aam76vrmjiA1y/SO7ECcFEUJ1UobznUrLJQq35Uzqy2vlM4k2mjH8ea0Pd9faI7Ap+LVgTOz8ozRPR6EreCYsRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(6666004)(40460700003)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(36860700001)(47076005)(2616005)(83380400001)(1076003)(2906002)(336012)(426003)(16526019)(26005)(478600001)(110136005)(70586007)(70206006)(8936002)(8676002)(4326008)(44832011)(5660300002)(41300700001)(7416002)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:33:59.3636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0166ce-a6d0-49a0-157a-08dba5c3c1f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL driver plans to use cper_print_aer() for logging restricted CXL
host (RCH) AER errors. cper_print_aer() is not currently exported and
therefore not usable by the CXL drivers built as loadable modules. Export
the cper_print_aer() function. Use the EXPORT_SYMBOL_NS_GPL() variant
to restrict the export to CXL drivers.

The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
cper_print_aer(). cper_print_aer() logs the AER registers and is
useful in PCIE AER logging outside of APEI. Remove the
CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().

The cper_print_aer() function name implies CPER specific use but is useful
in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().

Also, update cxl_core to import CXL namespace imports.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 1 +
 drivers/pci/pcie/aer.c  | 9 +++++----
 include/linux/aer.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8dd9a44e8a7d..f3bb7ea37b44 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2062,3 +2062,4 @@ static void cxl_core_exit(void)
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..d3344fcf1f79 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -771,9 +771,10 @@ int cper_severity_to_aer(int cper_severity)
 	}
 }
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
+#endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer)
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
@@ -812,7 +813,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-#endif
+EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
 /**
  * add_error_device - list device to be handled
@@ -1009,7 +1010,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		cper_print_aer(pdev, entry.severity, entry.regs);
+		pci_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 97f64ba1b34a..8f124b904314 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -64,7 +64,7 @@ static inline void pci_save_aer_state(struct pci_dev *dev) {}
 static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-- 
2.34.1

