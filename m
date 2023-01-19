Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1D6734C1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjASJtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 04:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjASJtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 04:49:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D869B36;
        Thu, 19 Jan 2023 01:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBKYAPrwU/QwtMJqzU23mMXYCXTsGvtxdssuQ3n7a+S4jf6y54ZNcjUt4tLymP2P56R4ENlbcH5KGevjWZQuCwZgcSpUVkXdNpXj+atcPw5tVyReKDvvQeOMsAjI+xVJtZEevCqQRDIhKmhY4nvHqWV++eNFHEsVHAIqspUM6CnE6f+t6UUPLw17dU/WB9ygbL+uwOAcHlBMpfVhnNIoG5+yzmdk4jt/FDL9nlP92b+tU1PGThxZFgEbpRyGh7uuWaWQ243T9EZxOQJ63vFnNIpaJIPOy5NgPZoyX5kk0AkXW+0eI66ZTUn5LmWYmRLE+LfrisTexf+jSqlfTQWNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XescRYhO7C3uQSTUROPJMg8doD2uzGVYdJpPp5Pnfo4=;
 b=ElgCHzhFD8vWevp9izKei6yVTUgxm7OIY83p8/gAyN8tEnPDLNnakz0x95QG+9jVW5fc5mpWe8P9z8dv8XcIoIiZoF0Icsg4wx890zIKTmS+QOzZ9pwzZvxi/+EHqokxbcCeaJ5SPQpqmf5zmLhBCGroupBwExFN0mj9YMfKq5EchCpZXbDbOxStvu2aPP6MK81DD1wAn1j0eOe0QbCaacSv+nEehXva8r4we9U7i7/tcqcUPWljV5JiJkLoTnhiOoptyKaebZWAm+3rDDUwv+u8MOI5mqb4URMaKetUU7b/GTNF6v8hNBis4/TvJuGXQ28HJgp4Y8VSdPML527/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XescRYhO7C3uQSTUROPJMg8doD2uzGVYdJpPp5Pnfo4=;
 b=T5XFuzCQFVtDCPy4YrfpUYl1TG5NjAIQMpAQvp+jW7LG7ncoO2Gt6w6HY35OcfySctscRhOUFBqDFI1QEK10q57GXyWBdqGXDrxLQhX8y1tmmXEhl7dkFqdinLa6gDsjdkaI0TbjNHCeNVSMkS+wNZYdgacs3Li1sygVBgopacsarZ6j0QnkqsI3z9kuEc0WmRXZwFjwgzINV17OHNu6IIpJk8Zf9xvkuS2H0IcqAj9+FIoRIfFtnuPvobP42cZfwlfMif/e33zylu0J5UU8RBRf9N2rs7AW4ylcVMi6Wxk2LNq3aUcdYL+z6Rk8IvE8VOZkxGgM7L3RKk8nzXBO9Q==
Received: from BL1PR13CA0432.namprd13.prod.outlook.com (2603:10b6:208:2c3::17)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 09:49:34 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::67) by BL1PR13CA0432.outlook.office365.com
 (2603:10b6:208:2c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.17 via Frontend
 Transport; Thu, 19 Jan 2023 09:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 09:49:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 01:49:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 01:49:19 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 19 Jan 2023 01:49:16 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <rafael.j.wysocki@intel.com>, <kai.heng.feng@canonical.com>,
        <enriquezmark36@gmail.com>, <tasev.stefanoska@skynet.be>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI/ASPM: Skip L1SS save/restore if not already enabled
Date:   Thu, 19 Jan 2023 15:19:13 +0530
Message-ID: <20230119094913.20536-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: c25bd968-019b-4287-42fb-08dafa027864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trkn4Mp01B9r+ctroPhs/f8IVj0Tz9s6R0WzC0eiA/2HLbBZrEZxcR9ZVCggO1tWrN+P/NJRy6mlZZLmJeR4oecLjT/JKtlrJYAVf9mTO88pUi/aT2P1k4ZKYsnMNWCrAgNAjoEnPJDtRrqlEhVXhy2N+CTOuWiwgi9Tu1DYP8F6mo57uV4hVCsLUKKHVLdNJgJB0VUzBNiz6v/wcYh1XCljhRGNRGkkbVrwyW0REyrXkadqywf65Imgb8/HfC65SgLQHa9CoKAEro8FYC/tkh9sRbPiFKxd3WV2FtZBOXZPdphyONr22Wea4P3c83r321zAoWtT60AFWDPJkU7UEiK291uuAyOZRz0ApmurifQwXWRAwX5sOuSlWcAXUJhPC45UjS1tVO5MDBfmvnMGK+ZntlPnXVe8JZO9QG7YpgbSjOgsDNLk021uCyKJvJaSQNhbrvLnQ6pCDJ4xfSSXWHA4UGpldMeLsRcgJZOceORGAtrPSjDwWg804qMEmBAigOMbqwekIM57XAYesGlGfGUVkR1TqvlosflMHpkKhlHF4Qj1nveFOdp5TN6T18EcdfkEe2h7edI0Lb68GWYfD0+cvQtl/bHVd1CMCalxwPLScH8ipADBbiTIbsiyRRzaVKMC6lO4OUeDaIKIqDGCcbFLiXPx1QqdjBg1EvfvQV9yvFcXsVsxrFQhqlP2XXanaJFiuewA0XPSfIgAiEx8aJAZ9I/9Xhr4cFM/SE896X9KeBhGawFRR8YFhgKJPHlPyaHfLJznE3f7LovxDs3d2BahIItbdEOX3CxDZGQ0brVBfHAgUXOroTFIhiJRN/yOTIy3tWJVk9mnvmOxT4hp0w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(1076003)(8936002)(316002)(5660300002)(86362001)(40460700003)(966005)(36756003)(7696005)(478600001)(6666004)(2906002)(82310400005)(2616005)(426003)(47076005)(110136005)(54906003)(336012)(7636003)(83380400001)(70206006)(70586007)(4326008)(8676002)(40480700001)(82740400003)(36860700001)(26005)(186003)(356005)(41300700001)(32563001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 09:49:34.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25bd968-019b-4287-42fb-08dafa027864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Skip save and restore of ASPM L1 Sub-States specific registers if they
are not already enabled in the system. This is to avoid issues observed
on certain platforms during restoration process, particularly when
restoring the L1SS registers contents.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pcie/aspm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..5d3f09b0a6a9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -757,15 +757,29 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
+static bool skip_l1ss_restore;
+
 void pci_save_aspm_l1ss_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 l1ss = dev->l1ss;
-	u32 *cap;
+	u32 *cap, val;
 
 	if (!l1ss)
 		return;
 
+	/*
+	 * Skip save and restore of L1 Sub-States registers if they are not
+	 * already enabled in the system
+	 */
+	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
+	if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
+		skip_l1ss_restore = 1;
+		return;
+	}
+
+	skip_l1ss_restore = 0;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
@@ -784,6 +798,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 	if (!l1ss)
 		return;
 
+	if (skip_l1ss_restore)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
-- 
2.17.1

