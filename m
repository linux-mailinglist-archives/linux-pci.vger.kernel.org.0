Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274F5EA732
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiIZN3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiIZN20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:28:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0869B866C;
        Mon, 26 Sep 2022 04:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SepCcrK9ZzflApzYs2sR30NyGYnf+z28wuXlwiKV/5XR+R7C59dVJanTMhhqAapBU3DwkPsxG1BugjL90yaYN0WBE7ARMkaJVGVlEoEiVQWpUD8xJ58195AFtKDNPPmUIN/Z0hy7szORNk8/htPrw/4lAkjdqHVXG+hO4MffiOpeBSIW/fF3keR8L+0EGoqhDvgH7C3Ts6Est2Sskw9h5ZfYYC2fAPVz+xHaq+9vjS2YndyWJXxgJGL00IFN32cLDKEFKyCds9A2hnLNIf/qu+JFnFmNs7JbRfp5jIbAjR2jcVZ/PJzBaMgg+2EtDW2WotcX6ffhuNcuMofdPEqhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAwdRdVc8Iglp6vRj+XW7KecFX9JibROcgI7a/cc8i4=;
 b=iRwTf0bF7QkHEVj45mK5YyNO4ju4/FPi9zIChhTHb/+yB211IwOOZ8BeQEV5ryJN1PdZ8bebOPM8U/e2dbhALwWLJOaooAb2u5B42+pD4tmL10QAo+WCvMgWkeRBBHLp2a/CLvhYrFv6Ai6jGKpeH5pjUplrwJprQCfJCM/xTaUqi8iJs3VblYTJ91xT10piXvEDVRmPxWLlofMLLUuyrF08L0ccBPIBg5ne13Kb2ZOvzR8bQBhPic4K8gOpL6ND4O79SvdRjjz9rptFFQc84h1grNar+xs9Axk8zHqLqqBNsM3mm2y2VuKVJqj43uVQaA4P1ITIcQuuLClJVFKfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAwdRdVc8Iglp6vRj+XW7KecFX9JibROcgI7a/cc8i4=;
 b=texEm9ofpLWYruXTGwyHrQrACFkIi9M0Alx/aIJDHtJpxi9DWnMGLPEfVfb51tVHqjadqmU/0lP1hpEU8KVSlBqRHXLaoajINat2Ts90CjK4hoAgc+rgY/J9q0F6O/zMCGnLup9/Rqd4y2hO5MSqKc+1xXY5MxniXmM5u4YbR9+brEcdZMmDcPuvIJL1O5KeczEwCbVXSLtG06D8HXo+q0q+XY520HkCqYuxLzN375A01uljyZY5vrQa2YfW0Q8MZ8iJCX14tetpvHccczuhu10TICAJDAIVlhoZGJdgWD8mVWo7dg7RTWztDKMO0L6epFqCiHDkhxji4HV5JY++dQ==
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 11:51:30 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::3a) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:18 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:14 -0700
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
Subject: [PATCH V2 5/9] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date:   Mon, 26 Sep 2022 17:20:34 +0530
Message-ID: <20220926115038.24727-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0a5653-adb1-40e8-8967-08da9fb5739d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBTPLqfDeaf32tNXLlYE4H1ieTkHZYqXEugctVUzJ6oMNDQ7Rf9BZhodUM72VSPR9Lh3SzV1SIyd6lQLnKtcYXLOC7mYKgQyTOEy2V9y/KdyE/4r02LN78wyOWB8LTxjTy9umQwY+mb2rMRQkP/0S8CQlaB/5cLHOqVv3F1fdbauN04osuCM9n+b0YgGgb1akum7rSL7TlXZ1q2F9bpt6bBex6M3IGmWZ83WflaCu3k7W7xNZda2D1BIyOYTC7/DmGGpdepkQ/sW5JvzpehWMAE/6iS7vs7mmluSJ9AoFZJnz/9VMPOg14u0VOAMIhKRdgobeVYkm0TEBLc5mBL9uJ65tk4q2M7x6JxufJ+PMQNmn3YPCQ9FoH7wU5pK3AgspzPFRDULODqnwE//JyCagn3Tbe/7WOIido31b4wLMCfph7eTdXzI9CcHAMjrq7U5FjHON/CWD2nB6uknE/+WdpigsQCcJnp2zDJuHwMlEj2Lcjc5A88r2GYnPXqjMz2KPUajFtN3FAm/1/RAIZ/jC3E/KuSL4rWDn3/DDxXMw+F43D0XeWFgz27LHSqInPiRloNn0Xox+BUAumofVserRKI/tcoVoGTlgwIC9S6dH3JsBt/sqMUXTG1mrlOH4RS/dpd7CUsJuCK4JRu4MhKrdTHf99wcTVADrIJnuxVtTfzSxr/mb8yngDlp+wYzWYK2109O7Thfk6J2iZQ3Yui+7IdZbfKvCiP6iiGLJsfz6KPG9sEAIJSysyEBQErE0/3RvLzhWKWo1o9fY9eNUAh+iO3g3Ct/p9maZfXlz4Rrz5U=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(40480700001)(47076005)(6666004)(336012)(83380400001)(426003)(41300700001)(7696005)(26005)(186003)(356005)(8936002)(921005)(5660300002)(2906002)(7416002)(86362001)(40460700003)(110136005)(54906003)(70206006)(316002)(8676002)(36860700001)(7636003)(1076003)(2616005)(478600001)(70586007)(82740400003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:30.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0a5653-adb1-40e8-8967-08da9fb5739d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PERST# and CLKREQ# pinctrl settings should be applied for both root port
and endpoint mode. Move pinctrl_pm_select_default_state() function call
from root port specific configuration function to probe().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0268eacdae48..4ba2a17d92d2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1659,12 +1659,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2120,6 +2114,19 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0) {
+		const char *level = KERN_ERR;
+
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, dev,
+			   "Failed to configure sideband pins: %d\n",
+			   ret);
+		return ret;
+	}
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.17.1

