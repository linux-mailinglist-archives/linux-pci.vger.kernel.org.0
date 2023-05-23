Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16670E991
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 01:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbjEWX2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 19:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbjEWX22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 19:28:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DDE5D;
        Tue, 23 May 2023 16:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbqyjC5km4NSnergWzOMe8b1Ks2nwll4nUzrGhSyMT4JcA74b13GZcht91N9WVsr4ZsXBO533SqDNMhBmQRnkT3vou21EsUzgkWe6I+Jwgx1mWTdcJjPIerOSX+oNUt3AC86EO0Yl7bjPHvc/MpoaYwGzIA0wKSzRhbXfcBfhLzaQjxvf59xeSArAKRMLMqQB9n3GfNCyX81DFTto9ribiTwb6vy3jvfe4wZ607ggIOj28YNuuTea/4+4C+Jhq08fp8KIeh5iAfpBhJ2xnnQHBZ5aH+od1ttRw0U4+qVuQX29zqw8GutcXXLI1GW/S+Rq/9aZGP0N/CbSwmwz5QoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzzK9z2IsxftQgvUnj09M15zyKC2/T1SH4s3PelW8vQ=;
 b=loj5z/mYO6PiPe6aMXq7BQZ4qiuIPtz8rnKyXHdgXuSkNdxVDvAUOVVlUjLb1/pSxQ3a5QbY+djSQQUsjlsL7iGIgUzR9RiOLUa+qkuZ7cOm3L1qXDTw4e4hoCPgNc+39RcyHHs2oOXcQeyGTts8wGd4zmrg1ddhsPWiSGsdOXLtWdfyIMj8GcZb94tVsK5xDF+bMAEeFMKpgzOboDH5AMPIr56WSYIM01tDYoBhDCwiPJVfmLy6t/RsDBwqA0/uRVi9rgkpvC4qbEkFBb01WladCTxoVg3iqj0dl4lqsuzOmWD4mvR2MuSLEx8hIw+16Tp0Zq+1ZE5cTVIy0NSlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzzK9z2IsxftQgvUnj09M15zyKC2/T1SH4s3PelW8vQ=;
 b=CMN/GTbzXbny6S9NLBHWuZrB5NCP5E7gW1YvBfi2smibvVBU5dxl/Sl8efCSBUICxyMlj5b6HWSqdI/zCKw+PsMMdYWPPJjg9wEQsdipngNi6dHWzJi9LcbuzYi7x7ZT61W/VFYSGW7ax7rddGIaFGZPH5rAQMFhpehPnI0PkLg=
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 23:26:19 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::50) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 23:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:26:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:26:17 -0500
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
Subject: [PATCH v4 18/23] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Tue, 23 May 2023 18:22:09 -0500
Message-ID: <20230523232214.55282-19-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e79a52b-f7fb-44d0-fbbd-08db5be51cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XkvoLi3K7Uu2GKoKmmWqEfkTC4snVPFCKEtybYGljckK8oli4lFOWOPmx6FGw/TKIpGViL0iCwxrc1A3ckFBSoDeMVw3FZUvh7383oi/x1n1NQNKyghT1hNE+7CF7T4bxroU2Alc5DdBpAX6479zb/JYpz+FTWYbNfcoKD45eCbtQ6nY5y/r2lQ9vuAzDqa3O7o9Pj1dRt9TImJZtkbBOA6+WtBCkL4or1FsVPsuAqILpfeCut7+SERiGH791pxctAr2R8tyuI/Jp+rRYCtmSTLFrVX3AkxrWQyV3YWprKvN7tn4Z169fOX3r3kT3WUws+Q7JxJ/EWpdG/p/MN5y5bCC3dO0fnmXdOmxOZycfGiDyKZaUiIXman59cSWZZhxrY58zVMad10ZSPX+Q3QX8smHN0MzRF28vyrE8eBj4Z4LelykQqZ9pRq+oJUQVhWMr8B/RgLd2YW1/IyBCQTRsXv3AzE90kKbDogC+QOLe4K7tuvRXChejcUBCt21CoKiFN27Ds+B2iib0yz2VSL0FjBDDEHbCRcnnrh6Ye/DNe2qNKmwKKs0XupXr6oqNurg5XpdAZ/hrvu7VSkXvbQg4mFN0y5HNWvUOJUcCVGrcxaW0iEHadqayPD4sflh6Y7W4iehpJZLCBqEKNfBn8BzWw7kR/K0Qw65xw/6+s8eB08veTGbj472VR8mdfv1nEEN53m2Trb1w3PtVsOgrOuFaNwlH8NREUByh52kHEnDR0cruZq+pat0JkZVh4/u2lXnzwhjKMbeBfk3EPXAS86FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(110136005)(4326008)(70586007)(70206006)(478600001)(86362001)(54906003)(6666004)(41300700001)(7696005)(316002)(5660300002)(8936002)(8676002)(44832011)(1076003)(26005)(40460700003)(186003)(81166007)(356005)(82740400003)(7416002)(40480700001)(2906002)(16526019)(36756003)(36860700001)(426003)(336012)(83380400001)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:26:18.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79a52b-f7fb-44d0-fbbd-08db5be51cba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL driver plans to use cper_print_aer() for logging restricted CXL
host (RCH) AER errors. cper_print_aer() is not currently exported and
therefore not usable by the CXL driver built as a loadable module. Export
the cper_print_aer() function making it available.

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

