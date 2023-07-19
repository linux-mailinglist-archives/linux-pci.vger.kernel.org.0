Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D3759E7C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGSTXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGSTXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 15:23:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED47B199A;
        Wed, 19 Jul 2023 12:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo91w64TFJCzaYyd+XNjBf3irwBtCVuPR40GNO/LUYrDe2J5x5JjT4d6EWgSbKLaSoN9Fx1P1Y3ZG5E1D7ZN2QDotDsXKgeYOGzdkztskX6rfxf/ZTrvg1Gb4Vz4xo+ZmEmZPQqvwNodMu0tFQ+6IsF7bddUg1BdaXBdP+ox8OZFQKWPBuKUh61/d6K3y0XQRbQfBUwtRoB10h6Fa14COIUoKeh52d3QvW4VMRRrlISa5LMQ+AhKFLLiy6ni0leQKSxaMGTL4abIykObBnf/NkgpZwVjD3FaUWsGu+xiAXAjcxA+C9QI9EP/JpY8Nslhq4+DI3ufbjwA4q1ylC0SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3hYCZibEX5bnCxNNhEjRbMYIc6RaysVLBUjGB1e4YU=;
 b=fEkQ5Z9TpxA4u6KZkAARpwulsTFLyduFJDy2StPdnowwITpDl+r4v5wfFzC9p1YD6Qa+eLMiy3M65tqzXr0rzjNB00NAO3wmIWB9al98wW4nrtGagrdwoBGflwvjsxaHZPJjAgPrN5DmXN3UQj/sgVUVFhBymeIK5GWNYNA89UzZRCaGnphDFGGW872gvJiIB8gk/NqlqpJfVzHZDjkgJcF2uIi2c/g7aH6n3LqkzjepoBtOEwF9d+HE/nxPdMRTqNb5dm4kAgA1b/4uoETjsfOQXB9llrMOm8R2I5ldt/KvRZvkTMjXTz5BHgM5Awr6oPVO7GHbODNCegkTVXM50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3hYCZibEX5bnCxNNhEjRbMYIc6RaysVLBUjGB1e4YU=;
 b=itcpqkKCwIuZU1mjeFthTIw+VmYn0ZybyKmyLnksG1FC63kGYWAGVmInrRYaRa1DzFoYmZo+FM8UnrxiNCKTY29Wbf0pvYcmByk1OwzP2LrwqV/Tq1JRG5sGfQbEnrfapebgqyS5haQ2heWDr3ljiIU1B3lpKK8UKefISouUp/g=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 19:23:27 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::21) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 19:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 19:23:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 14:23:25 -0500
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
Subject: [PATCH 1/2] PCI, AER: Export and make pcie_aer_is_native() global
Date:   Wed, 19 Jul 2023 19:23:12 +0000
Message-ID: <20230719192313.38591-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: d8291a6b-0dbb-4aee-4b1c-08db888da0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS23WLuYRkOTDS6cDy4VlOtmaiYt63GfWHGdPip+kPME8y8IXTtVItONcknSHNjcJyFc70cyDUcit/OS0Pxkg6q9/wHu6wy+15kOGDfSMC8dpU2b+W0mGpG9harhyomb9rkD40eX4XRRIS/xcZ3WN5GEtxHB6nWLF0bb72oNWPAWjqnOQqz0abCcaSNIGVw8l+TO2J/H1Cia95IFy+7251qR7Omp73ExXQEyG4Oyc2AD2kV3AwFmjnju/UsC71o1ZNHZ8/xfrqTypgYeHLc8QzFd469vcxug9aNfpovmApVd23NyYMLJ5/M+chmbOEip5bwDz+M+kEU16BfElv87IgotMB2ew+z7TUySHI32toUneFwmgXe5pTyd+2OFN0vRdq1EM29k8SQnVyf91A+6Rrp0vS/e0W/5tgnGpA9I5pS/bfklgvH8EsC+pnEcrl2IqkY0jLhhUSI8YtJNafJiBMBlKAk7aols8BFeVdStT1JEppafzoKjUln917Fh6AhBZUJDLYwc3Trxkwvv/GJd2ON/MBm2aOrCtU0P5ndG1C2TsjI4vSRmU6Uye5X5LQEwCYuOoq1koNlwYG7aNhwdqjqoiaQ56/GQ4jgH0jAA1Phn3yxAa16ncWbfvFC21WqqPNbqy7nxgtKL3neGe6jQeFFSpw3paYZQtUJHqwKml/RpXc8PNxk/c6ftPBwik9wVpGAsiXe30eo+0UQ1ONTTaU1QzGtnJPw+CLgu1bu3qhBDQw4fxqNlxY7zq5XXUsRVlz7x0HrnrPRVhVEJnl0NFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(4326008)(70206006)(70586007)(316002)(2906002)(7416002)(86362001)(5660300002)(40480700001)(8676002)(8936002)(40460700003)(16526019)(186003)(336012)(26005)(1076003)(36756003)(47076005)(83380400001)(36860700001)(426003)(2616005)(356005)(54906003)(110136005)(81166007)(82740400003)(6666004)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:23:27.3625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8291a6b-0dbb-4aee-4b1c-08db888da0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
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

Export and move the declaration of pcie_aer_is_native() to a common header
file to be reused by cxl/pci module.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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

