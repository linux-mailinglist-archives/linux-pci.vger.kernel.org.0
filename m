Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6535B6E44
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIMNSt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiIMNSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 09:18:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452F1B794;
        Tue, 13 Sep 2022 06:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIYikmm8rRxBsDQGmvKdBtjPpbMSNhe0hg9b0CJ45flCAywtMwI6OmwQirMDxt19mzfnBwr8ak38yqpAiOUwImg1yVasXNZJTSXC+2FxJS71Zh6kmr6PWSOw572Wv1f2ey+oBfBEpZPcGdyVthXOnnrzn76CAjivuc/bDspILZLEsfvpmrwsOBc95en+bF1GH53+t1/2AVWWRbjIImp05v9ZF1izr7rhwDn48UE6IUNRlcHyan2xD5z+xv4ykHe2RIdXY/buW2Rl0GcyYjJTiwKbwtywJbPktnqDIJjzb0IALSxv1C3iTD2+dnG9Enrz9qAYOuk802xxwS3ASJqDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9SjNsXe/a7WO6rUvFjyaMd6e8+9yOGsJhR12RYydNU=;
 b=AO0QgLkOrqJbsS1ivynzCFSAVeIySvLt1SjyWBwtn1pgW6T9+U0E8Aa2IYgFScTeaB+itqBGFsCfdjS/9ukTE8okZHtJbFgI5g1crKspXwBPMk69ReUMn5GBhuwlOHdaYOokq/D8f7frj/PcPrN9yvjiBsZbMZ21HUTVcQ6iq/8uFuMXvcIGxCDobCoQVj3xnJIuBk9hXeC5Ar62mmQySAh/6ShCnQ6u8C5evqRgWIOkbsLgpfyAvgafSr+SNQP1f5+SHAl7GIl9QPWOIb0y3J24h5Uel1aSDzQInUJ8hucTQFakkkY/Qno466tYVDcn69sG0V7hlN/bNcxfdUIWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9SjNsXe/a7WO6rUvFjyaMd6e8+9yOGsJhR12RYydNU=;
 b=XyzxofOe78ErfXZSyj19bgjmkb6Z4b6w4eoj3R+YEeRLRWq4ZX8MYkb6o2sRT65QqaKZG4YnQWd+Kkwgickv7m9kwzoT4x+rOF6k7EKKWzXsuCGAtCK8YViSQ1lmAj+uDoemTOysdy76dBU0yXuGuzkhpuQh2bB4biT+QIV/4ifBLxz7weXYCsuj3dlCSd51Nb077yOV8Byk8DYeWE9qZLgDhPcYGPvwVs3aATCD5g3k6ocC6E0s9A8B8GRqqWY52lR1f2der8KHonkIrLfF6IYHTpzoMaYzbXM3WdsLe06+1ho5zx2R49DSmvCWxCcJ2jrehpRH3rp8C4idjpogDA==
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 13:18:42 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::97) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Tue, 13 Sep 2022 13:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 13:18:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 13:18:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 06:18:40 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 06:18:36 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <refactormyself@gmail.com>, <kw@linux.com>, <rajatja@google.com>,
        <kenny@panix.com>, <kai.heng.feng@canonical.com>,
        <abhsahu@nvidia.com>, <sagupta@nvidia.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V4 2/2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
Date:   Tue, 13 Sep 2022 18:48:22 +0530
Message-ID: <20220913131822.16557-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913131822.16557-1-vidyas@nvidia.com>
References: <20220913131822.16557-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: f972e8dd-8a04-4c6f-d6d4-08da958a7acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W33o6MojczfPAdqof8ts+OzCZxvjzG4ctCz1MXxbimayiYN9+gcdcZYEdAy5GSG9I1AMwyTzL141AEgZjn4Jne0q3EcE/TpseWwFpbSWlSINcckQ48fMFLBQjwDbORP6WN2MvCjq3Vezc3gNfns2pBPZrAcV7tnIaT0otu8EAjeVXkgXEDVZ72iLaO0N2iZHuCBcQoYdYWJYqen5M8doR564asO4mC2pCRk30dV/JMkwpU1rC5oryOQJaqTmXCS4X+Ne/sE9x32/xghPm836K9vvbIDErfFF72qliQlGlvfBMP2qy36peUCCRng/fzi1Gz89frxEBwB9zWRwLyt8BzN3zlFvWHGJXQp/fvVVdPDZ3k1wPb5E4STWARARuoyjeoIeRQWdoVT2S2U7EX81OXWmb9E+NW2MeMLIwRPHil44koSVjlvWlTQPTYOy2cafXQ+IqCwvwNjQM8ygVPlOBcrAnaZiN35aV0DMa8lM7tAzddxiVtE1lWt/dxtIOajXkyBdprpo29abCFuSM3dRWcm6QydosCHOP5RPbSuvP8S6a8qf1POkyOjgrGsuWUwNo36EChUWbd/ycnlUU/3D1MsEwDcohvAKJAh97iLGfvpV3Ns8sc9wiNivqHoChkPzxalPkgg95RcRKn3JgtLw8OxnvOvHwPCEmf1ekBte52vHIkcmmkrYZYI11blTOUSVmnZMyau3tKUhh2V+66x6ZJykh/UKQgdmYx7UEAQD7hnM9iLVGrt7Exa8EtdMHuQNQ/xKWIrRIg8NEh3OLMaP4QoUHgDgNyxZO2rMWrZPL1Jh7MgAOrNvHAgd04tcM4/WMd9ojqzA/NMYHFxR9LB4X36+A8esDehIVF5dE76Y9AzxBotxtqmOJVWqUnjUTgsq
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(40460700003)(478600001)(6636002)(6666004)(26005)(36860700001)(8676002)(110136005)(316002)(2616005)(81166007)(54906003)(40480700001)(7696005)(186003)(8936002)(70206006)(426003)(83380400001)(356005)(36756003)(15650500001)(86362001)(1076003)(7416002)(41300700001)(4326008)(2906002)(5660300002)(336012)(82310400005)(82740400003)(47076005)(32563001)(2101003)(36900700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:18:42.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f972e8dd-8a04-4c6f-d6d4-08da958a7acc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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
V4:
* Address review comments from Bjorn
* Use the API aspm_program_l1ss() to restore L1SS registers

V3:
* Disabled L1.2 enable fields while restoring Control-1 register

 drivers/pci/pci.c       |  7 +++++++
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

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
index ecbe3af4188d..dc2e21c7a9d4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -721,6 +721,49 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 l1ss = dev->l1ss;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap, ctl1, ctl2;
+	u16 l1ss = dev->l1ss;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	ctl2 = *cap++;
+	ctl1 = *cap;
+	aspm_program_l1ss(dev, ctl1, ctl2);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.17.1

