Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F072717F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjFGWWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjFGWWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 18:22:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB112690;
        Wed,  7 Jun 2023 15:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxkNLHqdHgA/8uAgm9ORxqT2itfY4wH5Gs4sVXtJioxsDaguRSL+L0NAWQ3XmdlMsf3Ht+X9hzaPMLGUUNUxYO+2FlrrQEB1AgNGB7xf6uMKcRPnB+5Q68i75a2tqnBUK+6J+lYNqSRfxQ/n/di5HQquMUg7jiE4M2z8GcKRthpCjH5HP5S6ODmRaOkquFPQ6yyXzTL2pRFCIIhzQ5cQVCwlZxshWb5h4SrMm3P6hB9nfmBCatKo5hZnmZEUJFnxkSPecZEL9IM9q/mW4CSgsq2AmTqVjL5kF5LbtS5Xjge1v7lOA2rQgQ3rcDJiaULOZu31vsFTdIwxKnG0mTtyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPVTVqgH/rM9tcepxIabNASFXB8dOA1xO9inPeYy10s=;
 b=VWR4SzNtM9uFWNsDf7DStls+1wA14DufTne9HbkjErWti6Uf5Q0LPj1qgqIkYH1pqdCCY1gHpcXUGy7LXhI5wkKlzT4oldXXNFuR2f7cdPN0H+LMRBXNSBi51F4bcMHs+UgGbefR/F679UAl9TCDMja5ddoOmymITcpnFo0foSG2tKZcz/RawsQ4I97yabUgxZuWHsjN6pEj8fv5DkJz3Lk3GKHs/a8Ch5/FUmHRq2LCQZ/Q+nbWcjVXcIlDeA6CrO6/PMzL1jhTr1OIhE8+oM7upuoTv9GOpFT07vyblVfw6VbRf9p5GSsBj/oCpQ7uJ28LcQbUzV1d9frMh/YJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPVTVqgH/rM9tcepxIabNASFXB8dOA1xO9inPeYy10s=;
 b=N1bOzz8st0GuLJKr+tH6EoGO+UjnI1ibVDlNW8aKp/hwzHZBJfn5qq4jHWX8XcyBFBBu0rUuE+5X+isiDrLNk7Hscb0CrulmM8iVrwIC96LICuuzM7Y0518htfsSv65hGx3COZweQG4TioyyNN37AysypKj5L5seB/4jOhffLLQ=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:47 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::70) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:45 -0500
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
Subject: [PATCH v5 20/26] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Wed, 7 Jun 2023 17:16:45 -0500
Message-ID: <20230607221651.2454764-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 61083b95-5bfb-40e2-0e9b-08db67a5712a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCCAhL/44O3Y5+290+zlGDMqCAE/9skqOGC2JlQuBoP3VsYVZBrcp1zQ5+KWe3l3aTFeSLy9ItcDDawsZWWS5tZV8HKZWOiyMU9JbQ82PwGrOgdw04sTOYSzOkyJjK2QZ7mbQOH2O3n3yxbGuxcMxw9wek4NJ+aOJWocT3TkLzrYZ9Kz6jM0OskowZmd2jRPPlBXqOB6q0Yql1JKZ8jJN2OZE1pwhJLgtvPqRLFDMb3k+J/1wux7ZWG1nA5yvSlEjZb5lv53OAYEDfCjquhtqxVm0VRwY5TvtA/CLKfyhrjIciPeADuAafIWWYBOjKXnLK20wWIziUR8eQKsT/oPww/qfhplTQ4VdBJyb4BzgAIVWlQX6Asg3J8Gv0IsIVjF8XVYzBvMlHuvLpTLkxJq6vyED8veuo4525OsXD4BW7D87CrziGpLK7exSG6m6Z4TlqYlSknzTH8oIzXayDnHCDzLyj/qUgO9QRqr3pver83g7J9ZdgLV6vGVi0afSeJ9LcCDzPjidKvrB3al0cAANS7hJ9Pzxjhhf5zFiybA0ZIdJqljD6x7sMbvT2olY0g8SAVjrsnrXkL+7TiSZpfG9zCTWq/DpkJc5i4x7Nm6dUqbZXx1BGCsTul/cYQk/HMGkz8/s5y7RIi/gPNT/9O2Iw8V0tSspzq2UF7NWPUEY0/cbFx86HBQuryJseG/KNMsaCYWOpo3jRG5v2gqFj9idQllne6YwmHlt6FRk879GQLBnea7sD3f6+F1muYF7A6lzWEkuhfgdXwWyZXbyAbapg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(40460700003)(478600001)(40480700001)(44832011)(8936002)(8676002)(7416002)(2906002)(36756003)(5660300002)(86362001)(82310400005)(4326008)(81166007)(70206006)(70586007)(356005)(82740400003)(316002)(2616005)(1076003)(41300700001)(16526019)(47076005)(26005)(36860700001)(186003)(83380400001)(336012)(7696005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:46.7809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61083b95-5bfb-40e2-0e9b-08db67a5712a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/pci/pcie/aer.c | 9 +++++----
 include/linux/aer.h    | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

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

