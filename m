Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF65662E7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGEGA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 02:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEGAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 02:00:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA074B4A0;
        Mon,  4 Jul 2022 23:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHNRN2q/a8c2K6FfHSSc1RJWM9OoH8F8cBDhGCRgB6Zh96ojI5/EEh5iXaQw0HjPkKiP6f2WWgv9DKm4dWZ9lPMJ/8FIkro+UgqnLaYnYOg8OkSLIHn/GairNO04w/DuBXTsUOGjT8jv2zzO1N1GVdKh/SGU7/TtD8/0zaoPYd+7s89fmFitL/38urHJXe4n3KfRzNTONpGeI32eO9lD1fVrlqYlYl4h7WzhkeQMbbhUzLy5f1tk+GHbRWi/eX6H4L9cDJ1NRnknQl77u3j4e3VgmCG//5Lhc7B0mn9/ND1c6ZclUlOuY8DQXm2Rw14/VUKYkyCxehLTNp6UNnzIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcmSt7LUN8gNB62lerIo/TdSUCsHKkdhzvNR4VsC3WU=;
 b=FWaGbxRoAI2eDf4wJXTN/I11CrpmhKFCmxYYmFUT8Nb+n3QtHDxJtxRRaXsXLtkNEhLGVOsNHWRiyY6bLaxcW5waEl+kR8CDWD3zCkvhDvfIrcIrFBUZcq6lUhQaOHbieQrF1RGyA+TdmQppYQV78kxJI3Z0tr1C1kFDRSGGymwwPOqVkM+E5g7TTzWNKnoCZKP3GSg5YeTdJUJpcTofE+7FmREy4xzh4QDZmu67serSw1TTmk/1o/F8QOX8vVw+FZdH+9TEZMgZDzCg07pUGI9kSn3z4w6DSo5D6qavsc3SbVkkZMgdWea/WO1Jve/pwtieVJvYI0nW0FM9i5FNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcmSt7LUN8gNB62lerIo/TdSUCsHKkdhzvNR4VsC3WU=;
 b=CLpzR8pG2Eudk8oomHJKJY/dx3s7PaDRs1KbbYEY22vb95GylN6vKSuIdQ+qJoUmKjdHV1+o3r1BJO4uuOBy20u9fBBf3A8PRmEXExOIh1ZKLBmwjWPMwKLB9lXPifBzwatHLTBvoieHO6oy64ojNyyZdVe0y0rCJu6lZeLiqoVdgiPQorDUTMThqf3ZvZQVwpe1giRnPOeisrKAUJdcp/l8XZwMtXp6pNFaGQsJvtfUTJsg/qus+Lrwck7vB2HZWIYfBDfny90qtwiFkGEc96vlGDkmsP3ebkiuWksw7PzEWTMDHnKqEM33+tqCegrghOR2HOXR8ReZ2WTzgJpgsQ==
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 06:00:22 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::95) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 06:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 06:00:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 5 Jul 2022 06:00:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Mon, 4 Jul 2022 23:00:21 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 23:00:17 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <refactormyself@gmail.com>, <kw@linux.com>, <rajatja@google.com>,
        <kenny@panix.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <abhsahu@nvidia.com>, <sagupta@nvidia.com>
CC:     <benchuanggli@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
Date:   Tue, 5 Jul 2022 11:30:14 +0530
Message-ID: <20220705060014.10050-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54056e7c-2b1e-4b89-d449-08da5e4ba5e2
X-MS-TrafficTypeDiagnostic: MN0PR12MB6149:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4c3Jo8b+VcUFOtXGB9NgUaF4+v45UDeyuM0lTtVnKnmOo7tBmeEQV4PhGKbwVFZpaX959kNZpDcqdaJCyFvWQFTI5XtOQuzb/BX+uyTc9DVCyp7ccTYHiCKgAjEAcdA7Vm+TBXsd0fICNV/Mxum8v77lptVEHAk6gAy1OOV0SUOAiH8oO02bX7H5JRmGGpfZgVpiRvm9XIcl2wCgSsbQvu//k0yGM4g4ZA87o2bDy60tK++Z1w0iW/M+BmbYIv8HCNZqP7nzgI+zDdOVnc+RO25dYOzNSbWN3ef6HQZzmi5rIWfEh93JsJ0W1p8g8TWTWWkhRSgI+DFgzRTkmI7weMO+uNhMUME+yzFveIAsxcVSsgGHj8zgQSvCJ0wwSIabTr6AWWfTzb85XgV8JbuM7e4uZ9EbCsy/OAOSZDBmWBMh34AxtCIz7oHUe7eQcoze2EQ4gCGMAmutS3kkcBbmUpYUhmEEnVdOJttEfMuHLKsnjuDhDrdRQg15rzheEzMxqc/NRQeHzk7Opgt16vNuosIicXYahjZrvyVRzwV3Sd0al3QSFELGhcSRiK9ERe8HRNAjp66MnqC84prBTdOCX6zQpZqPG11yol/K+L9o5iVb5tg2pv+JPI+ZQUmwMKa9Qx2rTyoIdPzhe75visX0zviF5949AQ5a3qRqpNaSS4F8In0kdL6pLyav5xUhA/O1gxBICcox1DsK9v5mLwcQ0NMAPJ9bA5Euv4in30ZSSBbt3TDrMxOEmskuMebmn8n2RGzzq1KJp+Zc1ec90QwMdsuxRU0DYVYptkbgBWa8M0sICfl2bA3fMaiEp9Cw8XSPhpyeXmd7alpTNklPAH+i1zOolbKxMS9R+aFJyX02OoGDcr17o7GWR4nMrEc3EaPIhUdAJYIHqed/fnOa5hCHpg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(336012)(40480700001)(82740400003)(426003)(36860700001)(36756003)(8676002)(921005)(6636002)(81166007)(186003)(83380400001)(70586007)(70206006)(316002)(4326008)(110136005)(54906003)(7696005)(6666004)(7416002)(478600001)(8936002)(1076003)(86362001)(2616005)(5660300002)(356005)(41300700001)(82310400005)(15650500001)(2906002)(26005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 06:00:22.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54056e7c-2b1e-4b89-d449-08da5e4ba5e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
---
Hi,
Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
on your laptop (Dell XPS 13) one last time?
IMHO, the regression observed on your laptop with an old version of the patch
could be due to a buggy old version BIOS in the laptop.

Thanks,
Vidya Sagar

 drivers/pci/pci.c       |  7 +++++++
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..aca05880aaa3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
 		return i;
 
 	pci_save_ltr_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
@@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index e10cdec6c56e..92d8c92662a4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_save_aspm_l1ss_state(struct pci_dev *dev);
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
+static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b7424c9bc..2c29fdd20059 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
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
+	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
+	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.17.1

