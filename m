Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977CE5B6E42
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiIMNSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIMNSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 09:18:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A313DC3;
        Tue, 13 Sep 2022 06:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjOEiaGcSjpYg6z1/FmAfk4COYY+qG61OKJD0g/sULz77ZzAZOsnng/HumDbYyp6AM11QDLZZgDht9kw6blC7HNA+TJSLrPXa8JiezbInqH7t2jSgW5Q3DX+ivYA39ZzPmcp5u9Ekgsjg3Q7GVpry45SMZf/uUn3Qzdus+eGFsaSgJ4fxDU8tgM42qnWYT4W3r48guk+Thwxwza8qD5cKtLe8TUi5GbikxS6d2Ip3QmVa9+k78KmFa70S52hmX74QtsfZoJr/cZ0gsUgO3lxtPGTNhKmd8QqaLMaVeZv7BcyRMj4KnoSCqqxwaSyPYRczaDUZourxLedWF/B5KozCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjTTW9uCqu/TR/XcgNjJsUEmt4AGhGJtjdcDibrAMD8=;
 b=YcxTyHo1OGZQKU5QBhR9u9B5QRPIoEWBBqc6jheIyi4XU8//O4Bu7YzCsimUW0/Z2ueL7h1ezeNTUEIYai4b1PEcXVBhm0Y0dvg4TxRwf9KKDOKN5AajebPx4U9P/CDwAocSkZa2ewgADNtaaN2yAycJwA5Spj47lEYiqz0xaiQR6gAo1hHe1TSdQ6tzVHbdlslWq+Gmhuc39DuzUeoBMoRUPbLxCgcFIFzep164J4ta2ZhTSSj1FVFohu/I9T9WAlZAGNZlHCnG8qNEDPKbJwTP3mWWhKPcEkuIsvNfufUb197KC5X1WPTXG3pIX59ofQH89WigDP5xHgo5FqHGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjTTW9uCqu/TR/XcgNjJsUEmt4AGhGJtjdcDibrAMD8=;
 b=o+FQyXTQX1j5wklfhPNKUANY6cVnBAv8hMZm3omJdV8q2C00S43GQg7s8WEaZ6SlVye1oNhKJMD1/9hgnr4zo39jOZpS/EYHcdvPNrl8X1LZ+yDctBLGh1Xjdb+EdyqHkmdobO/5t2O9QLF8jcRJQThniqMYWL71ixcnfl+vVswAJf6sO9VKASkf+/mKbsOEwM8KXq1KtT0u9JM2iWItSNcPSHveXCNw31uEoZbVDfQhtHgQdTSHKKcHfsNrHuzWxuEaDEoeT+aWXsEkRS6V8Qedd1quRXOazLcSWoI2NN+d7SxIKYzyTdylhAs8uyeCUbABq99jfweky+mKcs02Jg==
Received: from MW4PR04CA0048.namprd04.prod.outlook.com (2603:10b6:303:6a::23)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 13:18:38 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::5f) by MW4PR04CA0048.outlook.office365.com
 (2603:10b6:303:6a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Tue, 13 Sep 2022 13:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 13:18:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 13:18:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 06:18:34 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 06:18:30 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <refactormyself@gmail.com>, <kw@linux.com>, <rajatja@google.com>,
        <kenny@panix.com>, <kai.heng.feng@canonical.com>,
        <abhsahu@nvidia.com>, <sagupta@nvidia.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V4 1/2] PCI/ASPM: Refactor ASPM L1SS control register programming
Date:   Tue, 13 Sep 2022 18:48:21 +0530
Message-ID: <20220913131822.16557-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913131822.16557-1-vidyas@nvidia.com>
References: <20220913131822.16557-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b281b1a-7dc3-4ceb-8f5a-08da958a77bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxB3frbLTHLE20xRFS0JMejxMrmjScuyCC0q3p4NUVZrj8nD3E1oFZoq9jWY8iKlSKAynaE+WVvEfJtYyNCHUi742WR9zGe8OIfhSYPrjdZAokLKBW6jl9RkMDlt9vM5RmguCQz+hvEbJjfdStve+aWl1rFykRT3VyaPlCt0nHQI15zVFcT5eXSbhzhyp70zaMvUEy+IjuuWJmn7fY42cJpejIIetrgpwFSvoilabrE2p1qeoJuSn5sj2zq4FgnnWKpcz2G4taL5Bbb3m5VmJnvp318kKhYPjHa/NujTKvPjjaiVlPNL+CmXjanafs6evXHyNcNmTB/B80ZpZe4U14ZJsqskv8vVWCK+iV0y5uGRFEFlnrCUiMA8bZWWzWxU8P67eGw/xPgXl/h3IZX2VHPOQZXxCILMfezndfDOwN/NWyj36WMaLMi0RFZvR2qbfPnuRSTwD6wb9yqam5/b9BH1TG743wfn1UpZcPZsBPJZUezpf6cbNoocyi68kqw6L8ZLpoSvjc9owBGmuurfURk0vEfPW0FaHx0Ja3bDt47M1wUW1tGZIdXeHcqt77fY6ugOm7K5rQEqa7X60jv9eusI5EUxkT6XWXKN9HczotnvHGflKPm3uV63F9SXAoErXVWRPb1saiiicQR7vR4N3sVG85HvsYvsBPwtsbPGzHxFhcp2MSWQgKMQO9qtHbaEXAVzD4mBLPmt17zGC0qfrfPZSRQR8Cf4nS77HFimpWUc8cygITvynU1GRaZ4T0t6TFhShjDs+MBghATTk57fd5aycRjVrc7UwhWkL79Tr+I5gXqoSN2mBeL1RcvcxJ6q1NIKPRLAh/NEvrcLoRTkBJYlm4OTU03WhHv7tEN7bTfvrc7C84ducnmIAW7EtpFk
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(7696005)(26005)(70206006)(186003)(4326008)(8676002)(83380400001)(316002)(7416002)(40460700003)(47076005)(110136005)(426003)(1076003)(356005)(70586007)(336012)(478600001)(5660300002)(41300700001)(2906002)(82310400005)(36756003)(81166007)(40480700001)(2616005)(6666004)(86362001)(6636002)(8936002)(82740400003)(54906003)(36860700001)(32563001)(36900700001)(2101003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:18:37.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b281b1a-7dc3-4ceb-8f5a-08da958a77bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor the code to extract the command code out to program
Control Registers-1 & 2 of L1 Sub-States capability to a new function
aspm_program_l1ss() and call it for both parent and child devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* New patch in this series

 drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a8aec190986c..ecbe3af4188d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -455,6 +455,31 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 	pci_write_config_dword(pdev, pos, val);
 }
 
+static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
+{
+	u16 l1ss = dev->l1ss;
+	u32 l1_2_enable;
+
+	/*
+	 * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
+	 * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
+	 */
+	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
+	 * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
+	if (l1_2_enable)
+		pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
+				       ctl1 | l1_2_enable);
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -464,7 +489,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
-	u32 pl1_2_enables, cl1_2_enables;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
@@ -513,39 +537,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
 
-	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
-	pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-
-	if (pl1_2_enables || cl1_2_enables) {
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_L1_2_MASK, 0);
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_L1_2_MASK, 0);
-	}
-
-	/* Program T_POWER_ON times in both ports */
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
-	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
-
-	/* Program Common_Mode_Restore_Time in upstream device */
-	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
-
-	/* Program LTR_L1.2_THRESHOLD time in both ports */
-	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
-	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
-
-	if (pl1_2_enables || cl1_2_enables) {
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
-					pl1_2_enables);
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
-					cl1_2_enables);
-	}
+	aspm_program_l1ss(parent,
+			  ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
+	aspm_program_l1ss(child,
+			  ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
-- 
2.17.1

