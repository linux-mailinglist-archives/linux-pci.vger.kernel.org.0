Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663F67B386
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjAYNim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYNil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 08:38:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF2355287;
        Wed, 25 Jan 2023 05:38:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN2o1tmobPwsFbAvPtTmkzG8pom4NNKLlKIt+9vmDfSvziHjhaenhIlVJNVDYa3dd+/QyqwK9Es/mUz7vj7b0zB9hJlcFBhSsju76FOk/ph27tWy8rbD/rskuQka9N9hp+VaoEX3kE2Pp9lCN/P4qDryBkbdHLAJD18qO2s9GkaIrH7aHrjHoorwAgJ1IwmmPmbbj9HNb5SWXvrdMA/D06a7+/RKz+QwsvVBO94Wh9dljjloalhEPUjaPLBTrq3+bE+y+2oMGegHTa4SGJ2fQ9lSWc0bqfysCIQo4/00qPpDNIw96gsVEkjcfjFL9+rBCXcNrS9VK7ebHrU25tg7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hbbEmp/tNCntjFwtt0pqVXSqee6QGw8Pkya/zDrDA8=;
 b=HJuR78MvCvVCzZBuyj6hu8gY+O9AYlKNBo97kxPN0hIhzUS7WggplXHQCqMx4mG2D7yNCRiNibBD1HIWJmj1FR7CZFW+DWD8YezTtWpsrie9XeTRTNW21cQ8RjqpUIc5ZE85uYKgcvSzC3OgdMIll2kADrkMkeNk/EnEhz5n2u39HSaELzI00QTvEBpIk8AyP+RlkDb6MumN3ELkqFsH4qs2zehBEKX1mDyYHaI/CYA0FIQauogWmhjfh6eOAlMAWAxm202lg4xy5cw//S8FFarFY69STx0H20IjkgEx1Wo4TZjmh7bsIzBFvUxeAZhLs6VOx0zPK+ySgLiLRAK4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hbbEmp/tNCntjFwtt0pqVXSqee6QGw8Pkya/zDrDA8=;
 b=GN37D+FuJSDnDzRGtw3bE1b/R/rcMY43HYmMCoLrUhjMq8u4VueMGDwQyVE2o+fzF9NKhD1NdH6QJIDjJ8glfPPzJOnBGS0OFyoY8A0YkHXEXo4dNi+jUEQzZWzG/VEVksA79mQlzu2lBvQcNaA/CNbe9UfBdS82MIvYm2OgtXEl608VQbQexOtv05hPqKdJtEbBVxJoPYjYGyGIV123BQM8XOnzfHjPZYMKCocyM4nLZ6kVSEsjJ6JSDoGDTEGsg3Xbx/zihREFVfoL+5txgroOOderm5PULr/1TYPMbnAXPCXqnDSkkymbfya7LLt6qEmKTyk9Y1ssJgrLafLomg==
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21; Wed, 25 Jan 2023 13:38:38 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::7) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 13:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 13:38:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 05:38:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 05:38:36 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 05:38:33 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <rafael.j.wysocki@intel.com>, <kai.heng.feng@canonical.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM configuration
Date:   Wed, 25 Jan 2023 19:08:30 +0530
Message-ID: <20230125133830.20620-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 78eadf38-d1a6-46c2-c59b-08dafed976e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s20q6Ov20a1VKSXYXBuAQ0wsg8RIJx7WiKn2vSLG/PqYlIWdWI+thcWW1wqdXjVZpVwMwIaEH78n6PAF7GiFT4d0t17cb0mTfQwA5j5OUKNQTwguD9Fu4iKDhPPVFilSndYLEQU80rIMAU1NqoH0at+5UWKOPG1i5w1xfIWQA1maOruTQ1ewfR+EW3vIJ3ysvgvSBhcvJklZA6r3A3D4tnACh5dA65FqLJHUT/2xI7aC6FT5iUXIoL69bei+oqtaBXoNcU4clsxcRXBphtR/e9EQ6U6SOAUs95GvdvhLvQ2Fv5cgPTeINeAeBHSB+apTsY6lG1me5AdzUJqL64olZWmeLdgA3jwH7wazw/EIm7QLc4/A2e5l5lpoYEu/LXbdnJUcRdBHQ0LMUFWHoaW2DvCDlsTumcYJJkaNWx57HVnaFCAspP9rvM219RUVp/KHGKsXvsH6WXFFg7ylOE6xmt+E7gWy6b/MKAHOJ9zLRnP4xP5y1PMFfL8wcha7NHK4c4ACZhMqBXf56XviKcPBpqrKQQBWBIl/FKNck5ofx+Fq2/EaoTaW8cCgBPcuSmV8V3ielAB8rPA/dSD4rvDIySFuetU16fdePJteqk+FwiDlZjLJK+J+VhiZFH1WsccT6nllC8y/kDVRVvfPwrmTy2/DIm/xIaV3KZALgb0fShMvEiie5xmdW1Kou5qJIMlDtkPshmMTUOgrnnh6dw7VQaT3Gttr4laN/nR4elI9hvQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(426003)(41300700001)(2616005)(47076005)(8936002)(336012)(356005)(7636003)(82740400003)(15650500001)(2906002)(5660300002)(83380400001)(1076003)(86362001)(82310400005)(186003)(26005)(478600001)(7696005)(70206006)(70586007)(8676002)(4326008)(316002)(36860700001)(54906003)(110136005)(40480700001)(40460700003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 13:38:38.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eadf38-d1a6-46c2-c59b-08dafed976e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many PCIe device drivers save the configuration state of their respective
devices during probe and restore the same when their 'slot_reset' hook
is called through PCIe Error Recovery System.
If the system has a change in ASPM policy after the driver's probe is
called and before error event occurred, 'slot_reset' hook restores the
PCIe configuration state to what it was at the time of probe but not with
what it was just before the occurrence of the error event.
This effectively leads to a mismatch in the ASPM configuration between
the device and its upstream parent device.
This patch addresses that issue by updating the saved configuration state
of the device with the latest info whenever there is a change w.r.t ASPM
policy.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9ed3b5550043..f4a91d4fe96d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -566,12 +566,16 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_save_aspm_state(struct pci_dev *dev);
+void pci_restore_aspm_state(struct pci_dev *dev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_save_aspm_state(struct pci_dev *dev) { }
+static inline void pci_restore_aspm_state(struct pci_dev *dev) { }
 static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
 static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..f25e0440d36b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
 	link->clkpm_enabled = !!enable;
+	pci_save_aspm_state(child);
 }
 
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
@@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
+void pci_save_aspm_state(struct pci_dev *dev)
+{
+	int i = 0;
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
+	i++;
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
+}
+
+void pci_restore_aspm_state(struct pci_dev *dev)
+{
+	int i = 0;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	i++;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
+}
+
 void pci_save_aspm_l1ss_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
@@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
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
2.17.1

