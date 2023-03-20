Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB326C1FF7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjCTSgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCTSfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:35:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F22B289;
        Mon, 20 Mar 2023 11:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv9GNvJoV6EB1HgrKSPt9ZMScD3qk6c9UD4HWgBvhUBae39hl1+IfZcwAz1zJUZysGzKFXMoin/GVZ7m7HeA2RfJeT6swd1gYRXCA1LvBRefTB+81XACxJ3o82Psk6v5mLaqgeEUBwEh4HYcUGxZL3tDaZ/j8u6QjYnw/CGz9EYZldujTK1uqNW0RDBIjbuVJJghyc2O/faDC7TxrKNlUA6jiWqC+KlWUPk67hxvZ8QmozYoaGvBg09matXmvyg6ENDDYV8mvOdJZz00POQQTOMV4U2bVa7+ULb7KjRMIWgqf8VSSfK751bWKKyXBhE8vZexIaorsv5IQXPzxNw/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sexpUMgz4sNbKdwfL02pMAnMxx9Kiyp9FsqW9Yav37U=;
 b=LDrBnmOmTEKYWqt3ZD4zgKokieNxxZxzk3QCb0bKvdcLSFsq68VwUhzEs1dbKKYnkWGnWarEF78EJU1h3F/qWz0adr25E9jCC1isBPK0xis2aM2vHbFZs4hZDeyQFin+DujO5F+a+aDwureDjkmAh27dpavoO0rjlK+LeTp2FzVFiJtY0XoY6sXNm36CkXhAMdJBPrx/QkSmm3ZFYbvHQAFcTEOE6On4uoN0yBTPXRIpGasnMQGLmbxDtjOhfr6y+YvyooptgcNCGTFOOGTKwz69Qiq/+BKOq9Nma//zoq5XoxG+E/sNgXji7GVgiN976uUeSlV5GRfOB/cMWBHsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sexpUMgz4sNbKdwfL02pMAnMxx9Kiyp9FsqW9Yav37U=;
 b=kfvzuOcjziQS8VcfWxBfk61n/jbyjTF3NZv18AAAOjhd6w0XBcPHGTra1l/vS4zoPJ1suMF+hIPXFgiD39kwukT5nOr1f5zEMR4Q6oU5wdEvTt2s2VDegO4rqZ9sUlUoPE++/ka6KycLGdK1NgVseKTEPWZvPVZTFFaFPWHDH+dtw9KBSTwn/llfzLWvRPrLkL5EZBmVIyo34GeT04sWtE8Bs38ifVDf27njPJGj2BXtYvYTsT2kHXaMjGGiH0ypQ6HbwwLSABFOrY+dcWLxJBJwbzOIHUOnaodCzvYN0cX8vWECtJGVsLoTkXvrzb7hppsz1qWhTn+VE/mqc8F1nA==
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:27:09 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::35) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.2 via Frontend
 Transport; Mon, 20 Mar 2023 18:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 18:27:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:27:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:27:05 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:27:00 -0700
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
Subject: [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in BPMP
Date:   Mon, 20 Mar 2023 23:54:40 +0530
Message-ID: <20230320182441.11904-11-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: e37ed870-55d1-4b49-0101-08db2970b734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGVh/eEkwcplQ6rrca+wJPLiQJqOq79itVnSbaCsfek5ue/y9AvyVsFyDdBGKWpwNzTOCVCa1BDgg1+P5dY8kLGiLEusxepA+9ydT84VYtggjYd2F8myRX8RrLW0onctwxQ3HP1hocbjV72Xiqu9LtbqZ555Bs9NiHGDLtkTxBvXgMlBmke0N0mV8e+lxnsTvl1Vk7fTZ7fSUiRSe321GMdwg0kV3aewugxxFpw3Wyw8hB8hUkNp9smtzSbE7N+I+oCjkShhPfWfyRSB8DEL7TN1i/BCMP1cHJmdA8n6pnGTxYAR2AzA+pHXBNuQfKAJEeRdMOatGZbqvM/tf2WKB1FxSK/qqCBVzDhaHUrIvXvMXDXS3nzC0a+K82Q74KG4H0ZxzWqsd30Rzj4kQFFQ4L8rlAKn3GFfK5CR8yUJUMR1WTNMYiOXXLpPCNrHfdIW6PIUARq8jBBY/vyPGE/I5XPSpa+P5yQHGmJiicUTBlRiI3gDjW3/OjdU5LtXSPd/ljcP4tqS9V1rmfSOWczCdxrY6GdP6GQMWkJaRdr/KHtFOB/nrLXKZfRmdRL2c/dwc1cISnP03Pl21ey6ldtncxYrKh20L/LT4uxl4JID0Zarm/Xhtc4n0qKMoJO+5Mqcp6hkiOG43apLBA4r7uj7KockhQvl42YfdvaAvFRQpXfJBB3/tLClUfcynzZuoDJXwmmXficu14bUORZa2/x6gW2OPhayOS2ARUBSBxhUo7L6ZgGcyu77CS1XsirFnObj
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(2616005)(478600001)(7696005)(47076005)(426003)(107886003)(336012)(83380400001)(6666004)(316002)(8676002)(70206006)(70586007)(186003)(26005)(1076003)(54906003)(110136005)(4326008)(5660300002)(36860700001)(41300700001)(7416002)(8936002)(40460700003)(82740400003)(7636003)(2906002)(356005)(40480700001)(82310400005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:27:08.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ed870-55d1-4b49-0101-08db2970b734
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If BPMP-FW doesn't support 'MRQ_BWMGR_INT', then the MC Client driver
probe fails with 'EPROBE_DEFER' which it receives on calling the func
'devm_of_icc_get()'. Fix this by initializing the ICC even if the MRQ
is missing and return 'EINVAL' from 'icc_set_bw()' instead of passing
the request to BPMP-FW later when the BW request is made by client.

Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Tegra234")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra186-emc.c | 13 +++++++------
 drivers/memory/tegra/tegra234.c     |  6 ++++++
 include/soc/tegra/mc.h              |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 978be8f54de4..0d68a20fd376 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -343,13 +343,14 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 
 	mc = dev_get_drvdata(emc->dev->parent);
 	if (mc && mc->soc->icc_ops) {
-		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
-			err = tegra_emc_interconnect_init(emc);
-			if (err)
-				goto put_bpmp;
-		} else {
+		err = tegra_emc_interconnect_init(emc);
+		if (err)
+			goto put_bpmp;
+
+		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
+			mc->bwmgr_mrq_supported = true;
+		else
 			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
-		}
 	}
 
 	return 0;
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 0b608b820b28..5b4b359f7c71 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -828,6 +828,9 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	if (src->id == dst->id)
 		return 0;
 
+	if (!mc->bwmgr_mrq_supported)
+		return -EINVAL;
+
 	bpmp = of_tegra_bpmp_get();
 	if (IS_ERR(bpmp)) {
 		ret = PTR_ERR(bpmp);
@@ -874,6 +877,9 @@ static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	struct icc_provider *p = node->provider;
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
 
+	if (!mc->bwmgr_mrq_supported)
+		return -EINVAL;
+
 	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
 	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
 	    node->id == TEGRA_ICC_MC_CPU_CLUSTER2) {
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 2fe6f0217a39..522b7679500c 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -234,7 +234,7 @@ struct tegra_mc {
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
 	unsigned int num_channels;
-
+	bool bwmgr_mrq_supported;
 	struct reset_controller_dev reset;
 
 	struct icc_provider provider;
-- 
2.17.1

