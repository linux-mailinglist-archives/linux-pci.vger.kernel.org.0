Return-Path: <linux-pci+bounces-3879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315E85FFF2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D0A287D7D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428B157E99;
	Thu, 22 Feb 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7QJpt6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073515699B;
	Thu, 22 Feb 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623902; cv=fail; b=uq+tuedmr0DW1zvz1IHs0tV3e2wwCWYPdOrq+6GntICh1sFkvc6Si/TdOqgteVxyWSkFf4JeQ3XCZYZYT6UgL7iuKsvothbFjYCh/TPqVrCEk2sdHzMrFmQUhiFIexARPtZNEWl6XyumNyjvX4PX8s79Mc8fnJBm0fM1s9zl3T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623902; c=relaxed/simple;
	bh=aOVe9Bw4qNzg2tfNsB0A02CI7kSYLm3plNpHpKzp8Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ea2361du4j2/lZ6SpXCp2tT94aRknIorllqgC/FuuOSlJDSwsoClwSsBJZqeQxBOdcP2saRtriffr+tUCbYIA8DlDvQJIZeQ5gCsCtfIt9BEAkmNbPTWJUHHKWszMGkNjm94RCUkZieYCKn5MJmI8LaNIvC4pin3Bcr/cqoQ1Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7QJpt6e; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvZXXpqivo1SGZqrlJloDtyqcBvtY8q8LjpUWTkBUtg91FiTFerL78ZxdR2EAGkp/d8dKCbM3CDB3WDRFaTYhcXuK7/WHldi4hjHO0BrGiFj14H3lqAhh5JWuEnDSI2qCS9d2rfczAkrs7Qv9YnSqu2SZncQfw05K2tSBIStupYdBg45NGwTrzl1owX7mJ1oCTXbws8+P1pO+WyXMpjdLT2ru2njudfX04XgzGPHHlCziyfH58347afbRNv/GEOeOM1i6aFpyjzE1nzUZ8+RhdKooRBqbvdlzMHsL7VpCwnMytnTteoO1xDDPzZHreXB+8ZyNWYhCu4N563PZvEZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XbFOAM2dx7oY57lt9KKSiBSqgsJ1pciuGTAMTW9/FM=;
 b=R9ymg6n/XxBtGqRKtWwK8LrZ5cuSD8+qmN1G6Fe/14OCny8DqaC0g2b7yQ07e7XbbOehRFEzcZvrh9EYFne8LvDOYF6+VtrPW1iIyIQ16pKQObQyp8HgbPKwF45HFuzaDHrdAKbtDcv9vgfoJgp8GjcL63xaw7pnRZWoBZ9TYOhpfoq0t8TtxELhuKzxLQvRDkVYwomaiC6YxR+HbqO4huTB2z7BSG854IJJTiZquHvTQ0Iap+7pltKvtSB9a3GbS6GDhKfPto0wVLQ21AJ9sZ9D/YCsyhuv7i2lsOS/yIxQr/ZVEiFULYWzqJ+LKL/R15ecyV19Cadd7CBgXn4Pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XbFOAM2dx7oY57lt9KKSiBSqgsJ1pciuGTAMTW9/FM=;
 b=E7QJpt6ebt+1YDvEBs0o32mKLUjESh0F30mwOfbPooOxdmoTV4ArE+box7CT4Ej8orM7ZxhPWApKYyM0IptyoNWKC+V5seKfOF35M93+eJNPn9CeTM6eIAHnKWTTKSeQEbgwx1YJD5mGOB4Yprzyg8fsJOE2Wby37eMTdG6lh4ZM1aJJCe6W3W9u9gbtMslf6TFM4d91mgpe+FR1ntBPl9HEsW1yy4wr9swDsZCFDJWrOmtpq3z03ciJXEHGZaFAOg5kvxt+ZHvAqr7to1UOeRThnEnxcuGs9PCR3k8xqNJKMtMLyEQIEzGHpdmiRURTn5cw1qlghzGfjI0vdjOfBQ==
Received: from CY5P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::12) by
 SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 17:44:57 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::b6) by CY5P221CA0060.outlook.office365.com
 (2603:10b6:930:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 17:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 17:44:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 09:44:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 09:44:43 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 09:44:39 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <macro@orcam.me.uk>, <ajayagarwal@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <david.e.box@linux.intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <hkallweit1@gmail.com>,
	<johan+linaro@kernel.org>, <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Date: Thu, 22 Feb 2024 23:14:36 +0530
Message-ID: <20240222174436.3565146-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108124248.1552420-1-vidyas@nvidia.com>
References: <20240108124248.1552420-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: d29ad02b-aa38-4e46-387a-08dc33cdfc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/OLxc7SHXWlGfzN1J9BHrxxMwvS9PA7C1lGDWZ1xzvNP9ro0FYyE8zvzNGbIBiQIUhACIaoHriwfdxcbB69zq5ZPFQyIYCpzNHJbSeSOAz/JFKnAMn69b1T3yAbgvcUbFEiXlWpiI3BysvhxwkXuADjytgLqJNsFKXw4+Rg2nrXUfDcl7aZEahGPXAHAWzGvCjX4Q/eWgjL98JyTeqQiL71iIu0gSyeCDzWhFatdrLLDn/THE0jiZ4SkJxDMMqvkhFMI1tri5LdEtEuDIEAZ0ZXXW1Z+RK3YpgTSWTGZnzJLgiOMSoH8kV+p+wTpDWPWqADACRTUoFPdNypq5Bee1YUAdYD76YQyO5E/h+iWf4DGhHoFSlYZfc0SXv5USZT7/T1rJQVkqwgdg9WsHGD0ex7I9kRv+RZfkaPTlXXCenP0yuYY7/DdpOGFOf4f0Z2mwSCbOCUtCGrJ9dpt4IkCfKmT29mIzgBlKhCvawSFoO/g6yQ42THXtrs1JhlZUmDA47g14fe6vgfc+UpECOVrbE7w2PI3pfzV/s11B7Xt+Al0Nqe2l47ajKsjJOkEV5xkbAF3bKPsQKFdKkF4IrbTqaPddIN7dGncGlA7ylR6CmoNZQHsQXnvzhinVpE4FYrsUKw2zeqk998GOhJWxF+wO3/DvlcTGiDUmXvLrLsPwGg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:44:57.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29ad02b-aa38-4e46-387a-08dc33cdfc69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119

Many PCIe device drivers save the configuration state of their respective
devices during probe and restore the same when their 'slot_reset' hook
is called through PCIe Error Recovery Handler.

If the system has a change in ASPM policy after the driver's probe is
called and before error event occurred, 'slot_reset' hook restores the
PCIe configuration state to what it was at the time of probe but not to
what it was just before the occurrence of the error event.
This effectively leads to a mismatch in the ASPM configuration between
the device and its upstream parent device.

Update the saved configuration state of the device with the latest info
whenever there is a change w.r.t ASPM policy.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Rebased on top of pci/aspm branch

V3:
* Addressed sathyanarayanan.kuppuswamy's review comments

V2:
* Rebased on top of the tree code
* Addressed Bjorn's review comments

 drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfc5b84dc9c9..3db606ba9344 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
-	pci_save_aspm_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	pci_save_ltr_state(dev);
 
 	return 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b217e74966eb..9fe78eb8b07d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_aspm_get_l1ss(struct pci_dev *pdev);
-void pci_save_aspm_state(struct pci_dev *pdev);
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
 void pci_restore_aspm_state(struct pci_dev *pdev);
 void pci_save_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7f1d674ff171..a62648dd52bc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,13 +24,29 @@
 
 #include "../pci.h"
 
+static void pci_save_aspm_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
+}
+
 void pci_aspm_get_l1ss(struct pci_dev *pdev)
 {
 	/* Read L1 PM substate capabilities */
 	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
 }
 
-void pci_save_aspm_state(struct pci_dev *pdev)
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 l1ss = pdev->l1ss;
@@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 	struct pci_bus *linkbus = link->pdev->subordinate;
 	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
+		pci_save_aspm_state(child);
+	}
 	link->clkpm_enabled = !!enable;
 }
 
@@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
+
+	/* Update latest ASPM configuration in saved context */
+	pci_save_aspm_state(link->downstream);
+	pci_save_aspm_l1ss_state(link->downstream);
+	pci_save_aspm_state(parent);
+	pci_save_aspm_l1ss_state(parent);
 }
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
-- 
2.25.1


