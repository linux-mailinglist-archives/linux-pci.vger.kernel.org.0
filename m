Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE8786404
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbjHWXnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjHWXnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 19:43:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088010DC;
        Wed, 23 Aug 2023 16:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3RyeVVU2OW82ilYPFDeVFCz9G3Gkrkwshqmfyeuw8S9GsXkm3CoHNZIZ23z82ZeIytGP8QKX6ZYH72XhVB/tF0BCo8gWDkKrw1pylqmxV4QaM2mLLkVC8LimVfO+Mo2TM61U/2gMSSbmMNndPWVO5yHxsHme/MRfZgj9pR/HIvc59HLxiYGyl3nP6xWpn7b6x37RGmSlqRV6tBlwyCa1W1i6QK7QqQKkGVFMR6jnsWpxfg/rhBVpxXXus7d9RL9LoPIgknTrdnHX4DvKne61vtPJHw+EzdKUPuk2ofXkC9fWFY+9sFemy5tMZB4S7vcvJOqJTSP9isowiHLTD0Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwAcZXySfkxrGp64NTqVT3gGZZpUM9lOOGq3FeEf8h8=;
 b=BczHNsM8+kMuhH22W+cr3nWJMIHXvFruIA/0oI2QlzDeiQrHE0aXrR7jtKku5xL5NckG35vArdqwVkV9cc00D3SRuCX3OMRUeSD7kUoIOFQwL00pX0a2OxgSygM3o7cNIZMPefxVxyf/wzesabe0+r6ju7ayJJnrcQs2ItnchlDzCb+8SbiCX1MYt7nn1s8Pa15dmol5KYVgkTUyEYTW6YsuCrFRGUynFW/U0wgkObgltu4URua7glwijNMPGkHjLCcoA1+4z265W13gHpoR3DibchJoDGvfx23xHaQx+KBd8PKzNGvzVloqn1bnsgTjiWHUMDdCV+LlJtSP9MdQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwAcZXySfkxrGp64NTqVT3gGZZpUM9lOOGq3FeEf8h8=;
 b=1GOj5j1MDb+MVVY52w90psqiz1NFP1OsIs0F1wMWvoSCxYTjqOAl65wJy96kPt+WCnP3sYM2kqw8UpeGK2VQuqZF1zDFFOyI2J1kkriYb7vo/2YWvd0NdJ/ibUgf+OLjjMPwnrWJd2ntJaO0g/LMeih2PaR0rhTwnVLZ/DHI5IU=
Received: from CY5PR10CA0006.namprd10.prod.outlook.com (2603:10b6:930:1c::6)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 23:43:20 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::2b) by CY5PR10CA0006.outlook.office365.com
 (2603:10b6:930:1c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 23:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 23:43:19 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 18:43:18 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 2/3] PCI/AER: Export pcie_aer_is_native()
Date:   Wed, 23 Aug 2023 23:43:04 +0000
Message-ID: <20230823234305.27333-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daf0e14-5d2f-4c21-098e-08dba432bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG2/F6DvBc0+VBIt7/OLpfb8iddomoB6PUCH8kUTPBhuxrHXhgv2ye+MxZ/alJYZGXLNzn7kndGDM/eC6vrjcoHjLIIp/2FjnCg2DVJB75n5Wuj4NdlqRW/JMXmKRMM3w+Tv9n9jcrD81JZpr/xANMUBSguFuLCj89hi5DEw2jBQU4xiv6bBGYyF+ILuschvHtKIS1f++LV40YsmuWU2SG3TjjjNdkWfO7x5h4V2+tSzt6Bf8UfRDI6mBfuj5tQgzeceQMvmVfAtZFW+B85RTCWG00/74VQ6dvNxGZgHEhWju69fYeWeMvLx6Ufxx8Hrhvelu8vn7heJDBWBNj8+L3bun2ncxbGQiNmqFwB30LQJ22/Zxg7uQkZQ1eOs1ftRHr7wzOsRiNxMefuFRjUeOpu0ZGpPamGs21Kkj9gGc1PM2thXqSHXgZa8UCJUNjQCuFAykMqBH/esUDlC+BO6fUfL9EMDqTdCS8D8sgwyLRCweL4+lV3qURjpKDuo0JvNsoud6e7Fq3vdOQfi8n5OMhMv23pu7X/5gWoY4lu651re7jZcBce5V1QQC2eD5fOWxjH3bEWsJYJlE2wKz3ti+uL7ELinoxq8KExRDWnqDNCmSpRI06ZFPwkAp3Oj7w/n7tZ2j1BpLlz/W/ufV2Jsl9tZYzMAlwE4HZNJnrGWls+ihS1PUhadRnJtfNuK/xcDlPK/xo/xu3RiLze2XFZzIJEkvgf5so/ohKoXwlOHA1DNsZ+oX9mp1P6QNlmlyje5WlCK6WKm04PHzUY1d42A9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(478600001)(86362001)(36756003)(54906003)(316002)(7696005)(70586007)(110136005)(70206006)(6666004)(81166007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(82740400003)(1076003)(356005)(26005)(2616005)(16526019)(7416002)(83380400001)(336012)(426003)(40480700001)(40460700003)(47076005)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:43:19.9671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daf0e14-5d2f-4c21-098e-08dba432bb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export and move the declaration of pcie_aer_is_native() to a common header
file to be reused by cxl/pci module.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
	Fixed $SUBJECT
v3:
	Added "Reviewed-by" tag.
v4:
	"Reviewed-by" tags.
	EXPORT_SYMBOL_GPL(pcie_aer_is_native) ->
	EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, CXL)
---
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..8ee12827e2d8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 	return pcie_ports_native || host->native_aer;
 }
+EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, CXL);
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 58a2b1a1cae4..1f3803bde7ee 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
-int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pcie_aer_init(void) { return 0; }
-static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 3a3ab05e13fd..94ce49a5f8d5 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -45,6 +45,7 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
@@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.17.1

