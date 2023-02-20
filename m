Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52EB69CED7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjBTOGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjBTOGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:06:36 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBF1F495;
        Mon, 20 Feb 2023 06:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5mC3OYbnE1NHoCNSM06T45ia3ESeCh9IT5HinCjxH+HDYvpCv3IL0zmv+ezeacFyVQ1yliUS4C9RFP7EMR9XCZTADoUbprWQczX+p7aHoNMJuhsGlB6hxpC4vachdWRUxrHQ2wN/zxv8von1YhwkadqPNq6Gmpg+2B5Ignld90xxEnNRxJtXZZWcgvAlNHCQ8GA9EPAiaCG3+WksKArQ09wvGDkIU/lnd4hCc00ZX7CUGbGrjc9R3cR6DcZaAOflDbuNsNkPqvQSRIZonUee9ZHjGg3a+j/wBhlkSsUAAHZAqlMgjCWYdO8KOjh6hs5l6EanuibaNLrVIW/DT+2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY7hBPAPyidQC30WF7UQ3BbHzOEMRgFy/GmbkaFA/xQ=;
 b=D7SEsmBBiHSf3ZGkkOCfIYp1URSPb6ChHAETICa7AmgdeFxW1ceB6pzDTVXqGOgQaZbXC0932OSQsnfrLnhDMjNXgw5hQfxTh6kvG9Z+DPSSA42Ejz80N3P9IoAcnLU5D2AYztkjG3vVnfD9QPHZcpgZrf3sWCm+RCQGuZO+eF97lZaQdJzgsuXNtf5mCXz4pkq89nczVTkHRyel1eV9EDXXqXCmqL1kFmDXHd0DuwLGJHE2/Mammidoh+ZzavxD+y7dBd9qgLvvDDEoCA8AK1jjUdLd9ktjTHEpVv04GQN5ksZ7s2d3+GelJxkBl5iNnBXMGx8splmUtlC3/d80Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY7hBPAPyidQC30WF7UQ3BbHzOEMRgFy/GmbkaFA/xQ=;
 b=VxLTob+oyy1SiavXVrad0hd7NKhFEOPWceQIYnEQXM6oHXQ7Jfu1ybr+CoPxCep3acfMa3W7pRp74v6QgfUHrEBVRxxNioMq442zlNqpeDBw5DmzLOOwvKo/kkwZ7I5eanjKDSgBnAUX0uxhsJdFj6jb0XI5Rki7Rvtuit0B8iRczVUQEDYDd8MnZFOA+toUubStk47cNP19Okc6N+wsNZF3XviQSg/DweXg4tkM4vXWj0c8Gj8LSSU3DGDXGaB5nm9xPlnEYCiD+Bl1JoazHb5t/MtyDk3b+FmwrGnghz7cunXWbWGM2Tcb6XqselLjzd3VWPeiVrESjC85mHKfWA==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 14:06:22 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::62) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20 via Frontend Transport; Mon, 20 Feb 2023 14:06:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:15 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:15 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:06:09 -0800
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
Subject: [Patch v2 1/9] firmware: tegra: add function to get BPMP data
Date:   Mon, 20 Feb 2023 19:35:51 +0530
Message-ID: <20230220140559.28289-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: a38e0771-9f04-49ce-9640-08db134ba5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5DjE0fJqCmMD9l0u1wuRs2+cJL3qzws24jTB51c2ARnm3LmXnWuBK8mGmbdMX7prN9XQ7gcWAXpqSetjnRJ5kcgNexM+svpPUDYJO9zrCzvhfF4sVRZQljphDpl1k0MJdQTSfPtFwh3CbwnxwAaT1i+iNvS+ZPEDbGIQB0OeKaPu7ViFjrdnnBR+WQ/FaKASaRW9nIGZ7sI3rbw/zcdleMGcK8eojvplch8lsjIBdxjTHDQF59YbK0oGQtdaFTtrmmtjueyCs9qsIFRu8yo3Ytq0Jyh7AcJVOpd27/lRVvjRMs0TuaYbSUhRV8YmlxSglFcnxZVR2HtLJDTwBoDDWOICsjykXEQAQ73k1HHZU4Q9HZw+M48M2gL+4akUshK1WHfk0ZXlStf8vLCg1JsUe1YZBINz1NB1iiNhP1GxMug6t8jEbg8xraGF7uPWCO1DKenbbu2l7m36U40StC883fQkUTgrKDZryZ0Z+zrgIXooQqGaYxt27M6VcJlxHFFSVQtaYIGeYSHy0Q3lcBEwWwr7UMGZrcvcaiTOXNUzjRPtAOTU72m/BeLBrNFKYNA761MjMKOLp6CVi/LF7RPpBHPo/6MLZ6fjKfGhpSjsD1u9DhuubnEnurOzWIHTEnJQpkOgT/gQihlMePWsgVnnRDvGTjmVcvK6d0yJBYV61PVdZ2lNh6A79i8gh/VJwy4OJsWiaJcciaEp3gI4j5HeQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(356005)(82740400003)(86362001)(40460700003)(36756003)(5660300002)(316002)(41300700001)(8676002)(4326008)(110136005)(54906003)(8936002)(478600001)(70586007)(70206006)(82310400005)(40480700001)(83380400001)(2906002)(36860700001)(26005)(186003)(6666004)(7696005)(47076005)(426003)(336012)(2616005)(7636003)(1076003)(107886003)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:06:22.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38e0771-9f04-49ce-9640-08db134ba5d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

