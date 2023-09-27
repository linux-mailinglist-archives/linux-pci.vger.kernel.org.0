Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE32C7B092E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjI0PrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjI0Pqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:46:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7C272B7;
        Wed, 27 Sep 2023 08:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/A9V1tUCcSMQWokrf3oUW/SOt7CIyR4GbjuqWDzg79SSvAm+VGHvSVBhud6hRwHgWWpeFQ9gFw+wH5gUf62N3b3xL1TmKUuhdCeUpUoTO3cKc59PeAqg1hKjZeQ0Jvv9RiJbxsEgyoQ5qHzC6uGpybKWS+hyDPsvAyKpJpkflO/UCogpkiDLyQ5mIlYdgTl9ELTETtErAWqVD0+vNRPqnO8fdslSf856rTlQvWN0Nbv7Dxey6xQfZdANghKWHdTaShUHxR+Zizkl2t5wSUgq+47Ip1mdJk4wR+mX06Q8QMPFDCEnnFGxwNUVBLghsyvwPtqiYXRYqXGtWP4Wmf/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OQKVGh3EZ/j+8iwVEPWfT+hqonAJDDZqGI8hLrumcM=;
 b=VCBDrwIECFgtRLB9tJ/r/lsDPGc7dY3b/YGFKcqC+I88CJdYZMQrJqI7TKKM40aBqDiYuWt+3576sSPUGLSbCF4SBCMHpcRixbl5DbEScjY/a/koYHTjoQwMsXnqTOKg1hfIhTugzZ78yV4zV/OuTM3IKKLR+zxFhOW1LdrPzJQko3aOh9rjWJJ42Oasw0I3hcTtgfPhRdtcS0XfY/DGNbz3I3X76/T1DZJIDwh+PvOw5HxWOdWkZFCfQGQONlZzHGAIspQoOuoXeTTPX0nZHedqrIOSq5zZd8dJtbjtT/PLoMI5NuG927ekFUDohKRC7yymjCc8Jku9OVstvaVguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OQKVGh3EZ/j+8iwVEPWfT+hqonAJDDZqGI8hLrumcM=;
 b=bZt+Pyz4cJ5ScfXnpFJTJx5oLnuuTmt7Htl2fAKrsJVs1bSOLvgEsaE2MOn4ExiX2h79knSvJwLfGu3nLTrdSM+MqfadIcfEI2ml5YzZaVej8RnNXYK37Q6nZkVJXlciUF5fnp9dadSeT1asT4N4apbxeQxfRMrUng5uC+i+qdQ=
Received: from BL1PR13CA0133.namprd13.prod.outlook.com (2603:10b6:208:2bb::18)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 15:46:48 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::6) by BL1PR13CA0133.outlook.office365.com
 (2603:10b6:208:2bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:44 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v11 12/20] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Wed, 27 Sep 2023 17:43:31 +0200
Message-ID: <20230927154339.1600738-13-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 6049afcd-4b93-41cf-9b74-08dbbf70f5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8gKS8QpYx+wxC63naf4Hz8BZEpjQqcA80tR8tBaOhAmHjcsmh7ufnywQwfsCpANKR6ZcWKNHWIwm/XsFxI4+izKds2S5d7wausUpIzxVX3amdGoJY5b1M1D+dgjftAmZO6WnrxkFpRz6IN+tvMgoN/JTZGbXoHQBufojAbxkahXV+mUHZ/IILqTlQ+uEauhhY2N0O84nVNpeYdE2Zqq5M36+Rz+qSJ7ZowuZK3/FB+chKvhEsU7r7uExaDUTWNfhz4xP8RDolSixYiZVwwQvN4cQ/wcxWJLATQHl5C/+5x1ynGH47HkdAI1uVYRx68jDsKd8LvkZDULgniKSqIq1T+X67bg7pSL+TWm8OKgkY7sYql8WeAsVTms9bb5g0Pj16ah8DFcGocF5hT4UMY4WrTtURDMI/6Qtzn0Fkub81m6Ziga7BMti6YU0/uGL0K27ZgJTUVeKt8pPXc0mekzYy2nrREjtLrbdZbTcXYdnn+7hu2bsCU60Dji+/a/qD40Tsdbcvl7rHT6JYdPpoorWq4E4eHZAbG8AbOFfk7H3tZAhoPyxnZJS7AQ63DRJzHYpa+b6hXZcfkjmsHp+NPi9AedI8kNkhVY2RjDjQ2HRRmkFuwj2m5ntuR6R+P5qAmSxlUdET42BMJZcWFBxeCQ9av6AI6SVBja7jCxkretM0Pq275HItHnBO5wRl5n06PbOAGtL667GRCpHE8QEZp7ypOWNLQ+LjhQHHxxZJPeXMBAnN+5YxxJ82Uv8FpO8izGp1XdDBkgj8KEDKQzibnUJYu/Y80of2PtBMKJn+Tcyz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(316002)(921005)(40480700001)(40460700003)(41300700001)(4326008)(8676002)(8936002)(5660300002)(7416002)(36860700001)(36756003)(356005)(47076005)(478600001)(83380400001)(70586007)(2906002)(81166007)(110136005)(336012)(426003)(26005)(82740400003)(70206006)(16526019)(54906003)(1076003)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:48.2755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6049afcd-4b93-41cf-9b74-08dbbf70f5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

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
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
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
index 41a8aa56cffd..802e85321a63 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2101,3 +2101,4 @@ static void cxl_core_exit(void)
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9c8fd69ae5ad..6593fe3fc555 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -759,9 +759,10 @@ int cper_severity_to_aer(int cper_severity)
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
@@ -800,7 +801,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-#endif
+EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
 /**
  * add_error_device - list device to be handled
@@ -996,7 +997,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		cper_print_aer(pdev, entry.severity, entry.regs);
+		pci_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 29cc10220952..f6ea2f57d808 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -51,7 +51,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-- 
2.30.2

