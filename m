Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355E76F5E9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHCXBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjHCXBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 19:01:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE91FF0;
        Thu,  3 Aug 2023 16:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfVoM5G16n+O2EiwIiUCB2TfJrmlGMXSi1mJob6QPH469VJv1se02kdU19C5UVQWiaraND5ZmR+ZJHdg66e/tod4o0+WEwiOvGlnUIEpevdfu5HnUZyVhwP7UJl1IvBg+Vs0sxKEUIrVsZxyVs/DHte+ojeWryTt8JzgVkg7nU3rkJyNWmYbDOYeulxy57BuWOmvOJS2LgzT41i79YHgp5MgjNDDK0MvJg3Y2T4DSGmUF1MiP1eO6457aw5oRxci/28/AJ5B3hG84o+F1PPrcF7L22rA4ncVQ1CoUyDSeXLCYf4/LY3fYDoY0fb/+BpIp6Os0kv2psJVD5ma/eVb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8PcQoZqkJdOCwCS8Ahh13hNf57wf2tT1bkYRbMh4wA=;
 b=lJYxBWHV1g7y3HS62FA48j69HjgMYQCzEPMN/J0C1djhcLIOKjSLXyvjML+uMRnxX/uueAWNYwK7IRQJpcbZPObF3TiQGwSrfOB7CSSuYlatGyL4N9+FgGAxrASBQYUvrlV9BbBnu16NxfZqHsnFxPgPi8PC21hDuAT1rJDEIFzsn+Tmorh2OriSKQqNWRM3V2/GpPoue3t+EJhIoYzbVx0ap54rAl4WJxeuCD/ZH9si4CFY+f4wkb5jpc7RXf0LoMalHpgTVYZWHcER4bYwqadRbHX/GkogF3A/dGcuXnkfdzgJqEPf35Zc621hZlEvMLKdoSRUWv7BW7BKZWsRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8PcQoZqkJdOCwCS8Ahh13hNf57wf2tT1bkYRbMh4wA=;
 b=zFNuR+NHrskgbxs6GUn4JOqT/nhvG78tVhtRIVcc2LVe+Vul4LjVNRLyU32ZnAR4ZnrWe+h5uImIUad5Q9pttlx50qBaoChpVXHb3ksuhRyuKU4YR8/3WvwGKRc1L+5y5FQGVsF6hKW6/85Vor+KB6N0IVl1xOD2/iWvRSa9O+w=
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:01:46 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::76) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 23:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 23:01:45 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:01:43 -0500
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
Subject: [PATCH v3 2/3] PCI/AER: Export pcie_aer_is_native()
Date:   Thu, 3 Aug 2023 23:01:28 +0000
Message-ID: <20230803230129.127590-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 2558bfcd-e1a0-467d-e811-08db94759c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwdehzE42RS5IK9QOnHkEHHjqFq5v4VM8Az7jyuwsNlkN84BYnZ+3BVt+m6nJ24VmY1JcO1xaiEthW6W5P6udrOf54fEDU67sOvVP1a3iqwiRMvULqniIdF6QRPcWMUN2bldcYipHAPctCKcjvy8ouiXg6k5nvFddEPUJRdqc9uvefPv+bzGNgcW2NvmahUQoasQkpFtkQOomqMCUOQR8JT2g92tZ9HQpFf4X4xVB37dcNlX+ohM8K2Y0lFfmURc+oB43F+pnxk8wOjy8G1+r2QQVGdKfgRabdPZuhixvAnsTk0Mew1xNHXDZI7wNjnyYk91cpjag1pasSGGRArq4jBg7cxehd7r4PjwwCkSXQKB5gNOMshff5Ne80MQb5+8ws9Wgi7KFTuKs5B01uTclWK08BUA740Wnu2m8XRH/B44cVUBF6VQCxI6DwQCuE87HbuRaOpZQKzZLxFCN5eChUwLLZ0KVbtCgS/CkvKh4bXmobN/IPHDjr3opwmkLmnTfZe5lnh/V74Iri//pmMJAG7/2pqx+vufj5U3/zpWezeGflAFbFI+rXG7LAuupGgUFrl3KeqJE4Tzg/u/piiedcR/U1EBlI7pjz3tKGkfOeHzlrHTCjhZQJbjlZW1N4LiiSxuPF+F+mhTA7LaqLrbZLJr14te7HXWNdE5asnVIsYgmpNTk51XK8K71IFMW5XzQTw9VF0EuDJjWI5tnDWv8PFivKtnM+alZiviFDF+DyesFm/ZqBZfk2tOvSTtx2qtwXe8Z1AFcIN5Y8qsi3saVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(82310400008)(186006)(40470700004)(46966006)(36840700001)(4326008)(316002)(426003)(2616005)(70206006)(70586007)(5660300002)(40480700001)(40460700003)(26005)(41300700001)(7416002)(16526019)(336012)(1076003)(8676002)(8936002)(81166007)(54906003)(6666004)(7696005)(356005)(110136005)(478600001)(82740400003)(2906002)(86362001)(36756003)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:01:45.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558bfcd-e1a0-467d-e811-08db94759c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
v2:
	Fixed $SUBJECT
v3:
	Added "Reviewd-by" tag.
---
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..87d90dbda023 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 	return pcie_ports_native || host->native_aer;
 }
+EXPORT_SYMBOL_GPL(pcie_aer_is_native);
 
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

