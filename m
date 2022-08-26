Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C465A2818
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbiHZMzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiHZMzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:55:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5280379;
        Fri, 26 Aug 2022 05:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ici/n01P9lUoWuHAzoK+LrPEnL8TIhsTERQq/QPvNbxQsOqxYcME3xLBC9R2PUK4CQZunufbHSsQ0oSp+U0Up71kosmv3v5U+EctQhOiwI/gjTh0vs27KfcLgh5rkgedW5fbTbNSPGEEjnbmYXPGXuD1D87REkJQlSkAhxs8/fWhLXD+z5PwTkc/t1cfjwDMn+vszgLFA1b2tSExliYwT0YRZ1T4zpCQ2ML7GZ6XnYgT4xN9j50+1+u+rVyB33ur1+yUY8XZz/t6aN9jApxgmgKzPrfKeOfhdD+pW6vGU3thQlEWdl0CwE5eAhnaFmx1zwhdK/e2+U9p78qYOI/k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwNvKqLjTyt9HhjqtQbw9r1eK/tB15devjzQghlsgM4=;
 b=DLNjgKXC+5Z95Ip9JUnWtOoMb/kgaY79mHriaSjIngIBbv3sACKOZ8gPKUHeHceiItGQC+x9Hrb8MNaj7pcReMK95HfN2ivEKFSBvZY0MqCNOIFYz57YOswlhXYKYXIZh2d4/i0qKdBn6Q0dD7ai8+iOUgdYYiLHAtf7lEtLliRvA97a4g6a16ws6oks0eaCVmbRqhVIbfCkFemKQnnc4rI0fbbeTK0Ws7TNZSNI671//JUfB1NuvxW3wTO9A7UFZhwREzY2RCoI8iPu4nFF8wuWl5Spd39QMK6di2et9+nxA1hO4WPpbF70Vs6QWpzkWxtoiDYam/vCx6TPW6zcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwNvKqLjTyt9HhjqtQbw9r1eK/tB15devjzQghlsgM4=;
 b=Iqh/+OkeiT6/EBpAtU2kMlzJEAopji3KkhzX+mrK3c0RHnpGpQ578pUPdXLoTNt8rK7BeMl41VJ479xHaYMJaS6mhA/r4wuFLy8OiRn4eGmC4GH1FfS23/0Ly96FAOMs+mtdwDeRAWlGjSUJs02A4tAKaWQS7r8wEyWdiofyOTgllzstNHD7MsL2PGIl32uJu4QkMtmayFQnMX/Vnta8/9QxWn9AOlwZNDFpz1yOaUpgswuopsZ+zQHtj5WY0olVm+NIhNm7OurrJUEE97P2qhzqtrkYKtm+9pO8U8z/vkkvtkSdxN0cTEOkcJx9kwp/SIHRmOtuGeAM29ubWSUNKg==
Received: from MW4PR04CA0243.namprd04.prod.outlook.com (2603:10b6:303:88::8)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 12:55:35 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::3c) by MW4PR04CA0243.outlook.office365.com
 (2603:10b6:303:88::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 12:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 12:55:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 26 Aug
 2022 12:55:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 26 Aug
 2022 05:55:33 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 26 Aug 2022 05:55:29 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <refactormyself@gmail.com>, <kw@linux.com>, <rajatja@google.com>,
        <kenny@panix.com>, <kai.heng.feng@canonical.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <abhsahu@nvidia.com>,
        <sagupta@nvidia.com>
CC:     <benchuanggli@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
Date:   Fri, 26 Aug 2022 18:25:26 +0530
Message-ID: <20220826125526.28859-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019dc06c-1db8-4fe5-0f55-08da87624466
X-MS-TrafficTypeDiagnostic: PH7PR12MB6491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsM1BCGTCty03LqDCPmD2rw2HutbwYwlae4eT5sFtFclEptJCBY/HqFM4fdB5TbezI2XIc32NsGjJjdaaYdCRWirzVJ53cZ7LR0RqzdZmAXk5X3G2b7px1XyHfopCG88Obe/Zx0ErFoQxU8dF40utppbvPYcP6M7pcfV458C1pmdazvuyFQwTBt190nL74qyI4hmR6LsMIT+TYywNQJn0r6zawjEmdyLaLUqqYbNB6Aoe+ZaPy0A9asdpQTAtdVTtTMwgqjTXmN3VDOwnK6cvVKP5j8Q8TnIk6Q0B8I+ulWc720JJEmdBF7xj+PzBGoOEmGZKUqOZf3Oqy7rdK8XxqkS5I3EFkLzahlgyqHNxRnkyJnFFrOAjDI9U0qSXZMOcGCwbNVjOOFEUU0UxB72YDzhiG/N/F1dopR8gg2QM8NhfKaT0SzedEL2tSasGL9fjRKHhbh8cNOZzcssZxJgoX/avSBTAMtuob+16dJD6EePMg26esxOXYqT0P94mGf2A4d3shLqBoJE6GdMkGeQeSw+ROo/2fwDLKzn4qOOMK31wHEfm2bvcyyB7Aev5/GLvLunDIR3RNokl/t2/Ndt9c5ccUY90ZbIEE3f7fi0tOstCvH2/x4H7MhaEk9ORxSxU0NSrWvq/OkqOcoBzmpBlD1DMwVdLLPAfVSyf/RdqR5gq1De+wnEIqTywLhX8uGcjf1wuz66a5xRKXTFCiYSLoEENJDh5gebQTNePrUToJLEMCTgwRZ4aU7e/WR6Dstdx6EhXkjOzJtkWrkyhZYEYcHVdGD6bwFuHS+DrtbHNoYRb9xLfNqb9TfVTfFKZG4Er6QFcQfyVh4CuBoqj5nqf+s4D2PHqIoJcDFiwLtI5Kehwrbj/bDas0YJD4NBzl6dWYWfqRXzOsl6mwniSznEcg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(40470700004)(36840700001)(316002)(7416002)(6666004)(15650500001)(6636002)(5660300002)(8936002)(54906003)(36756003)(2906002)(110136005)(478600001)(41300700001)(7696005)(40480700001)(356005)(81166007)(921005)(336012)(2616005)(186003)(82740400003)(26005)(1076003)(426003)(83380400001)(70206006)(86362001)(40460700003)(70586007)(8676002)(82310400005)(36860700001)(47076005)(4326008)(32563001)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:55:34.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019dc06c-1db8-4fe5-0f55-08da87624466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
saved and restored during suspend/resume leading to L1 Substates
configuration being lost post-resume.

Save the L1 Substates control registers so that the configuration is
retained post-resume.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Disabled L1.2 enable fields while restoring Control-1 register

Hi Kai-Heng,
Could you please try this patch on your setup?

Thanks & Regards,
Vidya Sagar

 drivers/pci/pci.c       |  7 ++++++
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aspm.c | 50 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..68a49fbaabde 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1663,6 +1663,7 @@ int pci_save_state(struct pci_dev *dev)
 		return i;
 
 	pci_save_ltr_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1769,6 +1770,7 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
@@ -3485,6 +3487,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
+					    2 * sizeof(u32));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..365a844ec430 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -561,10 +561,14 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_save_aspm_l1ss_state(struct pci_dev *dev);
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
+static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a8aec190986c..ee1f651bb1af 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -726,6 +726,56 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *dev)
+{
+	int aspm_l1ss;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!aspm_l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
+{
+	int aspm_l1ss;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap, l1_2_enable;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!aspm_l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
+	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
+	l1_2_enable = *cap & PCI_L1SS_CTL1_L1_2_MASK;
+	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1,
+			       (*cap & ~PCI_L1SS_CTL1_L1_2_MASK));
+	if (l1_2_enable)
+		pci_clear_and_set_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, 0,
+					l1_2_enable);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.17.1

