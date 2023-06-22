Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21609739604
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 05:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFVD62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 23:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFVD5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 23:57:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811F2735;
        Wed, 21 Jun 2023 20:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv6TX9aydwPTZhgkuWUEeD0Pq4X99B4wECCCGqTzIiFj61alwxNBCgcU1shslmk3EH3lSkGnQV52z0mt3v5m9fxWfeUlB3rC8zKVgTnwVju0aFB1UDz0mfPz4lzqRTrkoV+Xw+fFxUUf08VMH62aqhO2pAAT9w2OJx+QdwC86o9wYSEKf6EABxpDGKoSaSARHVj/e4VWqHPX2pA7J9nagB9V16ReSiUw7XIfGWCjVteNZfN0quKYTDPfo7YPalgAQlfGhqLxalfxU8uJ/HA0byzjpnHEa8TD3X+og58IXRqtDefGYgN7moixAeVQnCCC3PFcBw1CMNwFlza9/mQ7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smd23x7vtbGpItusRCOZJCxcGcy/8nAFZ2Kmy/SFPc0=;
 b=flTZ2BqGmnuUpoOA0ePcK2HAIX6UIzKjXBdeSdTR7ZaR092bDj16pL50VGuVNAmzpJyafC8HjOYFSMjgVosntXCBuHshKj7UIGmMPCrJZv7V270/0ugEAxVhwd/htJsChU+JmRxguB7EdIoFepklq0VySRBmxm1zaHfVtg36BY9NXMD4CmTFygJ5C9zW/DZq/TA1BYZCx20c0iKnKh3FiKCDFN07L9yQkEWD9F6jlg9khkOdPQN3yUbLoXaOWV3TGtkI/EmzWDFUpAZIlzwT1J1eY+PPiVFTLLPc/FkRiAwZSC6gIoIxCE9GRjTedRNSm6AtSc81oaDxDNxQHndzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smd23x7vtbGpItusRCOZJCxcGcy/8nAFZ2Kmy/SFPc0=;
 b=euXQxCQ/M89h3mKoufBcRJdeQIhI9YTye4hMwK5fGDcSs+fTfFS+RZLGriK0g0uc8fo2Y6OJiCfcBInM36uELCwBQUmG/cWTLTH6bQaCnVTwg75sBwI5ocztGqkmgZpOF8eBSh4IGph4k31vGeJlvt6nMZsEP4eHFxt/RSNA4cY=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:56:35 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::3b) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:56:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:56:32 -0500
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
Subject: [PATCH v6 21/27] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Wed, 21 Jun 2023 22:51:20 -0500
Message-ID: <20230622035126.4130151-22-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 948bbba9-d21e-4fcf-bbeb-08db72d4aba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcvNPL13fPpAWGNBOYgGcTpmaQrDHUrojaa9K1J3sffJOQ2hb91fXeGeOZCOVohZAtL+fXnZHDsz0cCBCEE1oUhUYTmQcqjk8x7RhShVaSyzmD0KYCUgzNlluzueDDWG0x2hO59H/BYWPPmIMRcAzskennbtLcjSsUl9N/6p8K43Sg3GPRocYsUaPZEACiyorI4EfVJjE1KquQnoIyijLcCE3fheMCjYsOhmdl2clqVW4t6SVezlG/Mmvha8x057m+er2r0QnPMJca6/uuxtYZviWyAp3MBWvAUy5FUj/Ix56fKV2EaJiOIwaYow7tJ1xVcbZms6f/3v0yxXNDzcf21HfztBbuzrfGEGWQdN71MRuxIvDClvFOdBDAAk6zv4X8k0lXbjNs9+BX8cYF4M6PZ71uX03gIMlgDnfP30Rh11DRyCCq2G99XjdG7COgVirg/rubADbns3YgPdLXqEFaLHMIUUXPfu4ZtRXuJfofcJXMUKkO0JCrr1TE2d8l+qJzYgOvu+Y5Y8qNi4HyTYPGMtoQ09Fn+lYPXTdBVAWptaqu3pJHT/EwnipbGC9pmJHHjqgtfewab8JTS9TaECEveRZK9Jun+AjZTxiCiECGhP5MvN3Jp7xLohHrbUzvyq/z70pLzR2Ap0Jqk6NNFV0OGoRBckW8awXLpqthXoSeWXbFlBGWbdWnxhvp7NkhD4zWq5nZFEgMomC1BRiVE243MusG3xro/JH/Wg7AKg2MWbk8O9oTgKqJRHrpOtkgH+suWYJ9wbJlSuU9dJeZw9aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(478600001)(70206006)(70586007)(7696005)(36756003)(6666004)(316002)(40460700003)(54906003)(110136005)(426003)(86362001)(83380400001)(186003)(26005)(16526019)(2616005)(81166007)(336012)(82740400003)(36860700001)(41300700001)(8936002)(5660300002)(1076003)(356005)(8676002)(2906002)(4326008)(44832011)(47076005)(40480700001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:34.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948bbba9-d21e-4fcf-bbeb-08db72d4aba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/cxl/core/port.c | 1 +
 drivers/pci/pcie/aer.c  | 9 +++++----
 include/linux/aer.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 37ecd756b224..41e79a36c1ae 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2056,3 +2056,4 @@ static void cxl_core_exit(void)
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

