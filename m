Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296DB5BCF13
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiISOhg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiISOh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:37:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB32CE17;
        Mon, 19 Sep 2022 07:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPkKzL5B6Rrw2Lh3S921xtF5v0GBC9uxiqZ3mHiUtnzEgvLm2VTsrVhRGHYdoB0LheBgHknY9hYW5SdlKr8vFbT7H6t1j6hI4m22dXMT17frewyPH+JeuGbIc1Li1lB74VaGtMxJzO5F4uJ0ZO9krsY5/H2709qI3m59oV+H3aQz9P0w2v3o9cfrKKOYiFGsLEXV/gwVbf+VsJW2KlpuqJOzFq6Aq3enFR7qDcC6zofNEDzHaWxkcaa3Mxzp5+1GJzJmHy2DJfcE7b1RKPo47la2e4KpkjJ3vH12ljN5O3TLr6wYQhCY1draVtJk64aTfjIMziem4amTq3qnSrBdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8n0kLhHcUZbLMPCf87Ar+KuOHZRIVetp07CXqiub/4=;
 b=GUYf5N0JcnXW8ovEtaZGUauWjDkgK78UMleIKA5V5BP0gICUaMQiseW6I8dyOJh3RoSd0fwXSgjRuWPpy+EzWkbwo4PdzTyMD9Mz2KEu8LRO3xWDE2nw7k0SGGMPWpaR+vbFXCe2YP2c9bYs2ZyzIX+DPxeN64vADeWwOcnPoU1Fsd3Qtg0Tkr1PrU+HGTxhzklxIR79AHg5YI6CVgmK+ImQMbrYW7XiFYNQyvtzDErhu9EtG42D1bmj9CqgK/dzZlLtsrWtVvMKfY2RxwXDLpBVypdIqKBuxh+GVJBFVAHb1iMlBqsWuFBbaZcJbuyXdf28tf56snaViftW/ThSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8n0kLhHcUZbLMPCf87Ar+KuOHZRIVetp07CXqiub/4=;
 b=rtLDnjLyGSiRfcHQ67WXQy9NuQH0FlGfiX7/L4MxQaPASRVwe4ePYEDK1ca8ynUoVa2Z6XkHPNwsleYJvwyli9neUthk86rO8ExfgwS4Eb69F5jox4/mRoGcLwQPxkSUTh2/pqfIDCTvjZY9csVMKnnXJ8UCedaw+hXFalIjc/iL5EX04uwJHCOdD20Xc7iTthBhQvjovJkeZNHfUgfuZ6ntl+18z0MEzhJwqI4he4ZjqomONXZRkQvocaPHYSRHpAywdVWvbbQ1aqlslf5E0wOqBZLDS6aPyD8ZLl+wsqflHtgJDP3Az6J++g5Qxsbu8VSXvcIguoJbCcVc9wySiw==
Received: from CY5PR14CA0001.namprd14.prod.outlook.com (2603:10b6:930:2::13)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 14:37:22 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::c8) by CY5PR14CA0001.outlook.office365.com
 (2603:10b6:930:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:37:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:37:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:37:05 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:37:00 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 4/9] PCI: tegra194: Handle errors in BPMP response
Date:   Mon, 19 Sep 2022 20:06:22 +0530
Message-ID: <20220919143627.13803-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5415fe60-70a6-42b1-583b-08da9a4c7664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9olpM6m2RMw/DC0FHwxhQuPby2SfRKfFMyiqguPIy/Nc8lCtpvivMHOZRy829fgtMspWYxbwuICqcskxk75tdmfbIrhF2UQ0mgx1SsTNuLKbY5iBZqKxzJiJPz6FMA5cY4qv+2yRwgysdTlbz4HLJlkqDgJVpp6AKvcmv7/jNKZ4GY4Wy5fSuWV8KhvrIXi6tnZ3xhirt7FmKP+7+uyI3df//W81Xq10kluLrl0X/gwIFDmmU0x5SK83cReZ+i3ZTICmMKyA17bPSiTwkShkvWuvdc/emMX4iiwlJw5QOaMzCV15NjmAiWwPRK+yOgXdpgpXjQV05y5/UMC2d0dLQePaaa2jr2Cr1SJDB6VcbrV+jGvK8N6u4xM4BOV/hT7TbD8Lx3VJoXErqJpMmSCt7uCDMbBSgcnlKEJJayCFmjXRIT9JU3WgmS4yfGzkr67fWbWFJA3+js57+pIdFK8o1cPa5LKEQ6WN2aZ2YvFchWgr9d9geRqNoAaZWVmAUQ2QZgAamYkw3Hov1saRtjU6fOjjAK8CAPHhDjYy7nqmqOTC84XHgYPNDKG4PS6oPb1VbcOOcDorWX7XYbCAZ/s5brrGev1NTEw3s2Uj6eDwTKqwE3X2DsCLRNA5qJDiS5nm01CAbM0OhgbS6LlOd/gLMwmAx/i2KpvHY5KW27xnUwdh5Gel3wpov3uXVM7Y2Ygr3VKfAunHNvrfIzpOH2v+F276GZlXLeTOHhMAxILQRm1NmGRige51QbH7jnsGrthyoQxUzg6NhuPBVd2oaeeerpITUVeeEKtnrRpZ/XBJEM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(86362001)(47076005)(83380400001)(82310400005)(7636003)(921005)(356005)(82740400003)(8676002)(70206006)(478600001)(4326008)(5660300002)(41300700001)(316002)(54906003)(40480700001)(110136005)(426003)(7696005)(6666004)(186003)(26005)(2616005)(1076003)(70586007)(336012)(40460700003)(7416002)(2906002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:21.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5415fe60-70a6-42b1-583b-08da9a4c7664
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value from tegra_bpmp_transfer indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.
Add code to do this.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index de477192c4b8..65c2c689fcd5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1203,6 +1203,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1225,7 +1226,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1234,6 +1241,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1253,7 +1261,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-- 
2.17.1

