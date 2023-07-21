Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8975D6C2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGUVsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGUVsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 17:48:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8152D51;
        Fri, 21 Jul 2023 14:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzjAwI5sSw3rrePQIlZrp5jPRLMdV8dHEl/VqsL1QmEFVGBtKLm6XUZ5E+CTZXC27NQqQmtPYcNLKX4CH6jn63XwS3xloWOyA8YiSiFHIyFg2dkOhAFC0Sm3iH2RTV0qURDNkF07xMjStyYDoSw5KAYicaIv0vJz9PxpM3vcGU+1s9GL5QMetFzYWwy9PZixQy1DyqbWOljOCexApGfTXVf8xahVPog7yvEdzmnQ1TEq110+Js7cIsrYJMNIXLovIqeDf+nHVnavXRJOJOyv4pjfxOyvefakRF5EqIkRuUV2PybWuiNYmF3meiQcxMSOILWIEWs4bNdY00aMJlsHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24yXo+3vwIvmHZQMWiAtl95Ub82l+rjbT3eZiOPPfQ4=;
 b=mcLzGzKDR/F+DDaQ9dlenj50T8JG02rvyBiDUzMv13EpKltmfvI5w+gcjR0RFpIOmfiHPp7MKsyihN2TuNsgYd7QDmKRqbvWPvQGN8k3Pp7REV4pKDkmYprXUUgJWXa33sVYrzohkJFP0OYon4gzc//4qzQLdVisVGR2X2zJBglYZeqP9sfTl5kJ6JuZNFfm2EZk63xduf/REp/kaCUrbGwIoalRllWkRajgW33+mHe36pANmgDDDxATLFTMsyXae51lHVH2VGmqS64zdQeimcSPUvHB0oyAXF81RTJmv3oDjH9IiVZTm4Ln/VQmOZF/UC5rP4ETzLJtZFyx+TjBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24yXo+3vwIvmHZQMWiAtl95Ub82l+rjbT3eZiOPPfQ4=;
 b=gz+f+wkmgg69KaOkj4R26Z0Y9IhR5trBMLW1qoJbmbK9FKte0/DXf2JoVXzJi3GeVXQRvhBktTkTmrplL/0VD3m/DqiKicd92/5gvWkexXa7K+Y8TwX716gEcPlcxxO8ct/Cm2FkiQdscO/pDChs4NoiWdoQTeDWSsHAhOtfphQ=
Received: from DM6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:5:120::21)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 21:47:55 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::7d) by DM6PR06CA0008.outlook.office365.com
 (2603:10b6:5:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 21:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 21:47:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 16:47:53 -0500
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
Subject: [PATCH v2 2/3] PCI/AER: Export pcie_aer_is_native()
Date:   Fri, 21 Jul 2023 21:47:39 +0000
Message-ID: <20230721214740.256602-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: b20186a4-ad76-4485-d327-08db8a3423f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igA1jodptDmGps3bsvXJBqlyTAc8edw6aC4zFcPU3CXkyl7PXUZcKDooLBsFyVWAgbJ7hRYNVEnRvaXCWvAAbPTmplXgNZDdFMyNeQohdcmEkbkKWiR5cuCVMPAmB+Zj+hhS8wopwoBqBk02Tqv00nBxWHzesfFTWPd1/hyDIMFAsHcx9iFTmS3OidzYkxXtAW2dudlqS0GLK2wicXrmtVc7YUQq/krKeIMEF+cHN+36Bl3mvcohfZagq47a2oevDScNiRPHcAsH9VShytC2G+nTzO26LDCWvixq5b623YmGxPQFofL/Q3TDhBWiN1qVunt0WVIpxo9EP3f9R8y7HeUvUr4gbWA0S2qfVsfVOK7UT5yLo7XEiuUmjHg85qb/2CzQ4m7Fgv0rTOwxRja1337+v7yEQrkOimollFpgw7dCzWNsLdKv0NpvQk+s4DYsm2JzO8waaM8idWgFPTw1CTWogqpeBfNQ2eEZk0Oj2cb7iWlNiIDWof91Z+7lNDkFV3IRGZEODcUMiSjMgxw+ZVrxmyPxfR+7ovMLJ+G+WepjLyHThnO//WHfdGOBroThKGZ/OhgR43ZoOfZ/ic2zz2CRAeQJnBztrm9sIY3sE8hieUBrgfRLNiuCSRvJg6bEzmJRUHc+ISAkZ3ZVqroNnUU11dSbNClHQ+85+5r8LBib4LuMJI90rYH8I4uK51wVm/kw4aZYwN5q0MBj/vIzfI0nixM9p1zMLrmYRXCuQM5NsqXyz9vcz7zcXTjUG7/wUb5r+6nSm10MqGhUBedgsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(2906002)(82740400003)(86362001)(16526019)(186003)(1076003)(336012)(426003)(83380400001)(47076005)(36860700001)(26005)(356005)(36756003)(81166007)(478600001)(6666004)(110136005)(7696005)(54906003)(40480700001)(316002)(41300700001)(4326008)(8936002)(7416002)(8676002)(5660300002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 21:47:54.7830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20186a4-ad76-4485-d327-08db8a3423f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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
---
v2:
	Fixed $SUBJECT
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

