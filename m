Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39756C1FD1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCTSeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCTSd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:33:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE86EA1;
        Mon, 20 Mar 2023 11:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXYgdsLDW3tSMC+eSHVftyatopk/i6CXHA/blOfH7PLYex8AiCzvN/Np7iwZ/TLfnE7p0xXKSkLOdSYcBlTtkHcnxv3rVj0Ke2tvTA33MvvSCE9ncRK3gDq8XrXK+L5JpEpoMbga5dVrfE++2MZZiFC+nhQ4DlscwajYXQW+wAViwc90D/Frvxmee3z9MsImfKaIyqbt0hh1zrwHeeTNPkS9rCZHM4rcLQt58bc7fqV41u3nd3futuKDYnM9oQOSun0NoOkCEtYuOHdE6I4dVMj/gMz0ZxeJKx0mOLhUYKjqWKWpV+kUBF8V8OjEQSoCh+boYDYEHj4b7c+cbZRC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY7hBPAPyidQC30WF7UQ3BbHzOEMRgFy/GmbkaFA/xQ=;
 b=K0dvzQTrCEO4TE1y7IQ3+S41ZQDR+7YBuC6Dpzal3THrZEsFR+ss8CGxzp9kJHi3WhdXFDdCeC/90+Xl1nwM6sh9kym8F7UKFrv3hlDbJu6dtGCWM9edrnkGaRJGaKubW6QD4pHqB/NNzcNcbGGFe8yGfC0UQ/uMVXr0xDWDqEp+JNWEyyAVBo3Z2VDSpYbSIvRtSjuI7pKbdVuc4clLQh4rAzGL01+KwyiouKW8AQXyHxeofMQLFQE64V/b0OGkubLOp3VWfAoegixkBEr/rO/GqGSDfsfybBqNXoA0CW4T6L9bU/0p4SIS2kyWAPxcy8gYf3Pw32k190mnxJn8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY7hBPAPyidQC30WF7UQ3BbHzOEMRgFy/GmbkaFA/xQ=;
 b=PvMvX127qXl5WYitlBmsy5plMsG1gZpwNzAhYwR8x7HsGxLzd75udihDBtdinFFzZRNxs/ohWuJfljE4nyXHGXpVuKk8qm5f4iRYTzRyG1uR0lSgQe/PlfFjkwoeoOgSER21NnzRYN2Lg+5uLuGVIkXR4Myf+ZmL1A3fgPbGX+yh89YtbDU8ZjnV4J+uTlb9DwCdhnMlJLsOpPjHV2iqX1siv+bHOUz0kHk8XmDg81ogK18np+MxJ1blsxLAEuvlEFVEwpHqduYMHJPfVueh0DnI+qZv4ZzX0OAlfyB34gua8soXLdy2A1SoFxwAYdonEPcJyhA6pBxoLXEn1tYj4g==
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:25:24 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::1e) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 18:25:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:25:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:25:09 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:25:04 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v3 01/11] firmware: tegra: add function to get BPMP data
Date:   Mon, 20 Mar 2023 23:54:31 +0530
Message-ID: <20230320182441.11904-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 135b7234-a11e-47c9-410f-08db2970787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1Uq0tg3Gm/vLlgfzyv87t8jmJL6NBmGVBpS9K3jjyBdfUmZNIvLQBWxljqyI7/Y2NEuDwdHRLhBDVK7Q+k9KSsuBL2WimhLXv2RSE4jN0/MOG+or/lNyYa4EKa1eX+uc2u4m5PdcjtVISAnn/e251E8QbyKFivGFMyJHeu/MiTGxPUn5SuTF12LYWfAo8ebUu8CXOmS9IwO7ZNbilA+RwLMSa8ZBWlk87TxFNccMgxRQtczhI3hwU9lwOp/+Ya6l4CNbE2Mk5gPsJDIOzKysnL+F3xvECc43BPGFUYdWGzVq00k858Ra3GkygOT5KSSVYbWUw6pXqKqOsGNYmrggY5Tdr0fuztKF04Q3GSFzm0XVYfbyH7w54sOQUmJXgJM6OUcAnBzgBTkwcW1ilAst7gGDGdx4qu7oM+ZXj/jx8K/EYXkpsvcAFBS2+aajPd5cnzeq9bz6hflxZubzJDOfXOp03y5qofO0D5R2BsNdGlvlcOhQSegHtHsSA44UzDzqiGOKwhUK3xKcBv+OSCorhsN8aVrW29ehq/nCRI8Ri3Y9gZYMid4Vt6aaucDEL2hIg2OBbyEi3uCXuiR07kaU1dM+IuQi3gY+z2CU1+glU96LZqXc5mmPBpjkw9iT/LJ3JrUgoc2UKnVTQV8vViSWPHJJZOEHJLMf6i1O7/xLxqiZCsKWjDPbgsJgLkqBlUwV/chzOBE1GbfuGYuWcHiMWY/qywzNxJ1aC/7gGk3zXaAVr14eXDJmiwTSv/e/6Fd
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(110136005)(2616005)(426003)(47076005)(83380400001)(82310400005)(316002)(7696005)(54906003)(107886003)(7416002)(6666004)(5660300002)(478600001)(1076003)(186003)(26005)(36860700001)(356005)(336012)(40460700003)(86362001)(7636003)(70206006)(70586007)(8936002)(2906002)(82740400003)(40480700001)(4326008)(36756003)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:25:23.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135b7234-a11e-47c9-410f-08db2970787e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new function 'of_tegra_bpmp_get()' which can be
used by other drivers like MC to get BPMP data without
adding any property in respective drivers DT node.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 38 +++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 042c2043929d..d825067a223a 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -39,6 +39,44 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
 	return bpmp->soc->ops;
 }
 
+struct tegra_bpmp *of_tegra_bpmp_get(void)
+{
+	struct platform_device *pdev;
+	struct device_node *bpmp_dev;
+	struct tegra_bpmp *bpmp;
+
+	/* Check for bpmp device status in DT */
+	bpmp_dev = of_find_compatible_node(NULL, NULL, "nvidia,tegra186-bpmp");
+	if (!bpmp_dev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_out;
+	}
+	if (!of_device_is_available(bpmp_dev)) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_put;
+	}
+
+	pdev = of_find_device_by_node(bpmp_dev);
+	if (!pdev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_put;
+	}
+
+	bpmp = platform_get_drvdata(pdev);
+	if (!bpmp) {
+		bpmp = ERR_PTR(-EPROBE_DEFER);
+		put_device(&pdev->dev);
+		goto err_put;
+	}
+
+	return bpmp;
+err_put:
+	of_node_put(bpmp_dev);
+err_out:
+	return bpmp;
+}
+EXPORT_SYMBOL_GPL(of_tegra_bpmp_get);
+
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	struct platform_device *pdev;
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 5842e38bb288..9fd3aa9e69bb 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -120,6 +120,7 @@ struct tegra_bpmp_message {
 };
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
+struct tegra_bpmp *of_tegra_bpmp_get(void);
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
 void tegra_bpmp_put(struct tegra_bpmp *bpmp);
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
@@ -135,6 +136,10 @@ void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
 			 void *data);
 bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int mrq);
 #else
+static inline struct tegra_bpmp *of_tegra_bpmp_get(void)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.17.1

