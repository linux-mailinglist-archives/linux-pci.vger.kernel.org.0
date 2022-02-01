Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78234A5C5D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 13:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiBAMfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 07:35:51 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:5601
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235459AbiBAMfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 07:35:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm1Lh/LuY6K3aD8/f5v23sOeLMON1zk8JvP5Hf/kdL7LxUrqZAbUZzRxHhehj819E71kwZuZ88CDLC6VZ0SNyrs4nJilis5eG1MTls+rw0GDBBSly9lr6ooijjjHyoJC1+hFsCE7h5K1CGlnsW9CS0ggEL3HYhcmymhIiUt7TARbhSqW2DW64jSiaW/vBc+a5u+FpyxRboT+PtztuEiAk5VT78lpODf2D8MOaoLx05wR9wjklBaxqqiVEZIaC8CX30hMUEz3701B9HUj/kpR/eMpC03M0+BUl7SyaqtEDpk7rlvxPTDZdMcP8hLEke+wofeuE0vyp3Jb6240gz7YYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQsunT/a1gbPmqo98o64C2GAMBCL42dqoyCqJfW98wY=;
 b=kl8bOkCsCrIdJlVa/pLr2a+Hrf27ptMo5bywQZaj/7ImF3eofgZRSeVSW/RPoMccdqFbtGV5+Vkhqw4gtPc0kPUEleWJE+hRILbDVYj4BgVYyGmBloOqjBRgiN0s/86VcuGQqWooaLgGox7oaHixZWaafeHti95Gd29SLB4SN2w3RKW+oDdkPLIF6KlWOklPlEgPIlTKB+bm5YR9SsgsUOqLpApgX8v9ChjeuyB8VJj+U8zoXVfPQd0kiK14ebQ56P/HX9Q+5wzbpJmnA6jGfqN8Nd/F8+9xKTGWJ/kbzkquGcUdstiSVAAzsAcquL8Eo+/WHJ0wY3/jPU7XM4qLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=panix.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQsunT/a1gbPmqo98o64C2GAMBCL42dqoyCqJfW98wY=;
 b=TDE+PDR93Lt42npKbmlUwFwM0+/ojsXDUfM6z2YRt1BNwTSy66zsxGpSLONhH7WaCqgYZQCh/9gPUkI8J6UxI3KhRg0FQHNTTKCNieskntP6zBD/XBBYDiIuP+VW8Y6Eens42DGC3n25lxK5lHopoV+Rf4GSBGSlJWCDQD7y+OS+4+QwoctGmewCvkaBlEDUBe4Eh9Nk0iAJPwRx5cxp43oLA409JSt3GbNvL4oH+684cyoQXhsq3JZSaiOQInjCK8v+9ja+5ltqLegc4AwDnPHmrqwqaslKG1+Ezkp/4DoYwLwo8yDRJ/YlBJPoSi9yCsiuUecCjt64OLg2DKWo2A==
Received: from MN2PR12MB3310.namprd12.prod.outlook.com (2603:10b6:208:aa::25)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 12:35:49 +0000
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by MN2PR12MB3310.namprd12.prod.outlook.com (2603:10b6:208:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 12:35:48 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::a5) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 12:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 12:35:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 12:35:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 04:35:45 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 04:35:41 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <kenny@panix.com>, <hkallweit1@gmail.com>,
        <wangxiongfeng2@huawei.com>, <mika.westerberg@linux.intel.com>,
        <kai.heng.feng@canonical.com>, <chris.packham@alliedtelesis.co.nz>,
        <yangyicong@hisilicon.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <abhsahu@nvidia.com>, <sagupta@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
Date:   Tue, 1 Feb 2022 18:05:36 +0530
Message-ID: <20220201123536.12962-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f43325d-5aa7-481a-a144-08d9e57f5f76
X-MS-TrafficTypeDiagnostic: MN2PR12MB3310:EE_|DM6PR12MB4153:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33108DF9C6EC0D34136434C4B8269@MN2PR12MB3310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jonbHmxC5nReYT+7mzZFQNQL7OHLJhZNHo57j4OyXmiI0P+oyveYEG/NwVWjj+/xnpf65MiX9j/Yo7KglxYvnYSUtdJpK75qNm4w8eXrzGfeEimAKQs14vMTdWGmh6E/BT7mOjnDjiF9hopR8o4cUebSNCo0DkX7wCl4LqtbjflDxsG0tqNIhl4o70+stTeFN8eYULwxrtjTS4SGFaQNui+ao41nMrlH2NI/Cd3aLHgPPwSkqC5S9efuocNkbLkSXSko1z6ZIidui7Ct+FhstWTkMhl8F133/5E5T4vo2pFgdTTJcozMnwaq4HyQKV0PcS/GwFY+RPGwFfO694Gx/rZBbHsF1IC1PzM2zIqeXxzfD0XMNE7tb5wqfEremFWjOdZK6ipwLfE1anUvY/753SnirJwqp2j/Jec1UVrf1xg2OnhaVXwzYovm5F6iQDYd4j0/gZyEAFuoMnCzJaA7MvGGlqFWZ9Qe97QA22Nr2iMdpIB7esgxEyqZEfz4sx8nLh2u2a3LQywq57Tdz03C9XHZxY2as0Of/u92eJoU1PpLGkUY3hkzRD5aYV/pie3CIvJ2zr2mtYlSiA194PLHg0EToevRaT3f9eZl1+Dn+p92qyDxsYyvOcrj3PV42XjYv0l0FbvVxgwoojy7Cz5CX4axzbLi8poyGaM61rSSqoxvdGU3GIl34ve0mv+QcKzFwsU2VYLamOwHEp/35tg4GLl254pbs6y9NqcV8WnJbv1HF7Nus7dRnkON7Aj0OeeTE+e8vhOR859k9Rhv4eYdCipWqYXH4w30LOZzT0uQK7n0+HB++jGZ5qq2QG6x3hdDJM7W1mPxOXenhztAJWABDJksaClj2hmBj9yTApuZVXN+9arWETrsWWRwTm8ztyXm
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(1076003)(47076005)(26005)(186003)(426003)(336012)(36860700001)(7696005)(6666004)(36756003)(508600001)(2616005)(40460700003)(86362001)(966005)(5660300002)(15650500001)(7416002)(8676002)(70206006)(4326008)(82310400004)(8936002)(70586007)(356005)(921005)(2906002)(81166007)(110136005)(6636002)(54906003)(316002)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 12:35:47.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f43325d-5aa7-481a-a144-08d9e57f5f76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Hi,
Similar patch was merged in the past through the commit 4257f7e008ea
("PCI/ASPM: Save/restore L1SS Capability for suspend/resume") but it later
got reverted through the commit 40fb68c7725a as Kenneth R. Crudup
<kenny@panix.com> reported disk IO errors because of it. I couldn't spend much
time debugging the issue back then, but taking a fresh look at the issue, it
seems more like an issue with the platform in question than this change itself.
Reason being that there are other devices that support ASPM L1 Sub-States
on that platform (as observed in the lspci output mentioned at
https://lore.kernel.org/linux-pci/53d3bd83-c0c2-d71f-9e5b-1dbdde55786@panix.com/ )
and assuming that L1 Sub-States are indeed enabled for those devices, there
are no issues reported from those devices except from the NVMe drive.
When it comes to the NVMe driver, the code at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3008
has some quirks for some of the models from Dell Inc and I'm wondering if
the model on which the issue was observed might need a quirk of its own??

So,
Kenneth R. Crudup <kenny@panix.com>
Could you please try this patch on top of linux-next and collect more info?
- 'sudo lspci -vvvv' output before and after hibernation
- could you please confirm the working of this patch for non NVMe devices that
  support L1 Sub-States?
- Could you please try "NVME_QUIRK_NO_DEEPEST_PS" and "NVME_QUIRK_SIMPLE_SUSPEND"
  quirks (one at a time) in check_vendor_combination_bug() API and see if it
  makes any difference?

Thanks & Regards,
Vidya Sagar

 drivers/pci/pci.c       |  7 +++++++
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..75a8b264ddac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1617,6 +1617,7 @@ int pci_save_state(struct pci_dev *dev)
 		return i;
 
 	pci_save_ltr_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1723,6 +1724,7 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
@@ -3430,6 +3432,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index 3d60cabde1a1..5de1cfe07749 100644
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

