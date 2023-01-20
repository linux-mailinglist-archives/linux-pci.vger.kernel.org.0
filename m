Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77F767507B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 10:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjATJQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 04:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjATJQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 04:16:40 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0559574F;
        Fri, 20 Jan 2023 01:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebWCwISwP3DxV4kF4lSWfa3UNl7GJzMa9EMhj5iipdXW0LGSblDkh8RcXQlOd2aEyWwcJYYKKrKf/gokY0CzWT48UKCZZvVsINrYt7fn3Eij1gkWVQ/f5QL8q8E3+rUBYHHoBQP9HAWGQQiNJLMLpp3JpDHcFoNsYDBwgC7/DFdV+2ebHGzjE3qPAnr6nKcMxShC34mrp6LSIP3NaZ/280fUUmEjtXOkoaRN1K+ni5BMWN6wIspMcNdPWzt+th/xnX5L6tLgkQyYJom1GdsYULwVrJCnFel1XaVdCM/XeNbcqUFeUKGIfcg4wXsuUz2FgD5PHaa04Y4AJwWihvOJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/XRqw8pSYYNuJH25BnLnvNDDvANusGXglmfcHQRjQg=;
 b=f0RKYAIOLIPlV5zuSeHVLhuzO11mVVIw9IUIvgLwviyC2rsTqHbGExei6k/z4oCqUAO48MADB7rPyzUd+HzXZG5Zm5huS61n7xvtiDFaJKPuZVGTm6NLl0CRz4Zdguiuu7XLdxz0gJmxrwNrkD78UQ8dW5dq7wqITsRpiFKFZTMJ9+lBs7742dZ7j5zZ4G9dUhwc69OhbBVxw2awrl41Csxt9pHC2Deuyn7d8r46EK0HJvAZyLgyNrpgBaYBEHZFkVom6uZKWPvCvP5LD4iumVBGg9ltCTjhMdQzU2y9Lro+rZc7ghPXUPssjdRW7znsVG0RFPg7kzk7aI9mKUNXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/XRqw8pSYYNuJH25BnLnvNDDvANusGXglmfcHQRjQg=;
 b=ZVzp0HgLlQYHhFiiIeIolrpSZbY2vpf8rntVdW/QuJWKnwBrjWgEdqnRtEvy1IPuKmyku5QmwCugCU4APw+g/bXv1VpeB/4y4jjhaIyIw92E9L90ET7oM+tlrhXTS1rAim/+XjolNxtkGlQmkD4abRQPzQbgnj3VGjJVV1AUtgclUPTp2LnMHJ8/mXM6j4GCU5Fyc/Qg19lz1ssMcB1zDWOvLtbAJfP+BbSu2fZumqSbmgOdMQ9SrBdXCk7jVxYOIJAyCp65EG+z04+4DHApn62CfO9unY/j4wKa8+u7HEJpJY5F/QiSPIO4mLZr6/gIwtJIEpnDWm51Ti8bJaJYSQ==
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:16:00 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::a7) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 09:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 09:16:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 20 Jan
 2023 01:15:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 01:15:51 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 20 Jan 2023 01:15:48 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <rafael.j.wysocki@intel.com>, <kai.heng.feng@canonical.com>,
        <enriquezmark36@gmail.com>, <tasev.stefanoska@skynet.be>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already enabled
Date:   Fri, 20 Jan 2023 14:45:40 +0530
Message-ID: <20230120091540.3305-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119094913.20536-1-vidyas@nvidia.com>
References: <20230119094913.20536-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: e0220294-ac66-42fd-5a8d-08dafac6f27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRkmx+eztIoh3b28U8vne+LWFFdWq19Rit8907iBYkxhfRjsCVNhdwIEJ340d8M8LB4rwIdqnAwsCJaBsvSQpopaw/w9uxpSitJoxKOa5DKtAzshGAlGkrkKImSUqm7g48BNRZOxu0G5mhjhmT/6LW+drLBhWyoKRtILxs0172qDFq0mZ+aIR2o1htJ4E+JYkOHEu/Q+ibog2iaJIIAxUzB2CQaEIvHfAzQ56GAp12drobJnjFwE/sGvbQWagY283J3Bn80Vc7pYMOahA2TDbR5TnmLY6+QlEiE+5q88GItDQhTRFSztj25VXZ8vKWJEvdxjtFL6wbKUw7MvEab8uu+P7mGwWzpp0D0NtVedvgRVNXcz46KpAn4oJkBgi/Fir4Sa0XYHCQmV2uaunFB20xPUiTWqp2xgxzUMPWoQdET3jeGRa3x2+bxMRsF1xlZM9wy8nTBZosyi6glUySOCnPNc8/9lyh1s9DXB12MuD29w4kEOyxk576NaVw03og3T3OlsBht1dmhJvpPkHETlLZr8BIQcdvWmSNuLkolrEwbPxzS9ICNH0crGdwLpjEaEGWUROxcxVjY8tIfbg7jylOlBdbXZcsJZxTIGq6isNa80zpEEqR/IP9NUuXZytcRsgATdelh6T0wgEh5fSnSsMUpO7HozfZ/tJgukVVqeWWptBT/Uovo7UfAqagm44ks2O966JbJPfWMEZmnKS0B6DneX45y+PcJPBumfTh2Y+ykz/OT7HNt79NXSIEHo7GfGVRbwTm8nbDwt34UD/REfCP6aeuwH3aO0bDEJhLluFWt1iC+yxgkQNx/Se8TQxvEmrmLlwZ3jMeaFYdbdJ3CDrQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(26005)(2906002)(186003)(54906003)(110136005)(316002)(2616005)(966005)(7696005)(36756003)(478600001)(6666004)(36860700001)(7636003)(86362001)(40460700003)(356005)(82740400003)(40480700001)(336012)(1076003)(47076005)(426003)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(70206006)(70586007)(82310400005)(8676002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:16:00.3775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0220294-ac66-42fd-5a8d-08dafac6f27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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
v2:
* Address review comments from Kai-Heng Feng and Rafael

 drivers/pci/pcie/aspm.c | 17 ++++++++++++++++-
 include/linux/pci.h     |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..bd2a922081bd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -761,11 +761,23 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
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
+		dev->skip_l1ss_restore = true;
+		return;
+	}
+
+	dev->skip_l1ss_restore = false;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
@@ -784,6 +796,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 	if (!l1ss)
 		return;
 
+	if (dev->skip_l1ss_restore)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22319ea71ab0..39534602b55e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -395,6 +395,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
+	bool		skip_l1ss_restore;	/* Skip L1SS Save/Restore */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
-- 
2.17.1

