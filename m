Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7898B5BD4CD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiISSfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiISSer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:34:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56A644D;
        Mon, 19 Sep 2022 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnH6TawPcsMNUsl1vcHmU6hhEfSAiRSdVxECbSCxg1yXlkoxfHRNYeaGP4ON5nsGdWDW3YpfHgJJX8iQ0r9PL4o4pu0oEPZMNYYDM1u+7odUXriPju0DItc3D4hkZeW57eoAqpez0CQuBMglXA3g1zhAfDZGolhnX/+Q3NBhV3N+BzLzKSlUM+1ITgkhdL357AzCbYdmPl9WGvbndXrRdMHlKHuz4t3sy8BauoRxezht4X9aqAlVOO6OvTVANwOo2h3qHwv2OmZHnzBklXIOugOfX3zvYCHqgusO+vrKS85cotQlmvj2nRmKqV+kHwrARYK7Y/0vaAvqPOvujqtx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHAixVAfBaOoqe0aI9ixXFTmZSRX27g0ooH2OC9M+B8=;
 b=BgzSMYVm6YzGifKEoqoHLoiwfivgVxYp74SAKejg2YNngVSXaZEsT1nj1fDGKNhtso1MFpnjwx3XJQ9pIJ1oq4hpRZ+NuKz9xhVyk8xXgyIIpFOVhrCDa3YwfR7841JDO3V+3QIdJs5JiLZCh/y9uBaY6smp93vNeS6SpC/TAGIBKoKUFlcbEeHRAWZnAuwAKhqlfDO+eLgUQGGpQEwX30FdfStHcOmz/7Bixpd3MSx9BSKf4oZyyCceFtqPvhg8Gh4SlUB5SjHMu1dZ4SwOp+Ad9vt6q6Af+EGzQyJRl4//YlAo4d7Wul65ggzYLvp9Jvcr0NraYV9N/Lg/6yJ14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHAixVAfBaOoqe0aI9ixXFTmZSRX27g0ooH2OC9M+B8=;
 b=ufswIRNrnH8or9ZA4PODbzajMnRM4onc6lP9HSWUThKfB18/tjZmueyGFVRvsPghZafb4CCu6dUfjNB09FoxqaT5dp4lnARd/7XGagSJDerSz1+O0xXHisKD9gFgziCStIMDz9Heomi19mPkgW8geJhEbLlKu3iknf7CToqlJ/qUmjk6YYXB2mJKmIuRnrBkcxl9BNNYtIYBa56mq0UbhOTr3vs80YatyMdeaWIHoGkNRxlu3yH5eIxXEajiAmDiWY4hcsf0vVFoubYNPvier+1EAMUTcRUuHM5m5GdZTTUtcXyaQRaSToMqIsQhZg8BMNlpW4xAHXPoq9mJJhkurw==
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 18:34:35 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::dc) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Mon, 19 Sep 2022 18:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 18:34:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 11:34:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 11:34:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 11:34:06 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>,
        <Sergey.Semin@baikalelectronics.ru>, <dmitry.baryshkov@linaro.org>,
        <linmq006@gmail.com>, <ffclaire1224@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 3/3] PCI: tegra194: Refactor EP initialization completion
Date:   Tue, 20 Sep 2022 00:03:42 +0530
Message-ID: <20220919183342.4090-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919183342.4090-1-vidyas@nvidia.com>
References: <20220919183342.4090-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4290fc-cb41-4a94-20de-08da9a6d998e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBnlY9l8sHqYH5rlker7zbIFO3qNDR5IzY6zBMnGgqEel9BYBGPVMFE9KZXj9wTkN+05ovDgab3qaBmsGEsuGsgXAxGWcH7FHSe4fR3wcnZN7JEu1EWVqI2n9LB81l2bG6o/DT1TDJKopqUSpHo18/s2EBmrWTOIWDDVQGCDO5qDAL5R2Zib96bZ2B3K0UGdDCYeOj4jmx/IX8mjw1eShrR+EVW4v/QDSggwmGq5GWJquVEotCNrOQGdeYWp+ZCza2d6N+k9BYtNUfmHZFVkikVoi/ose4U1U1ieZ6fUtfYdDs6XViMYXSNJpqUB+Q52hYOgeBEzY9jSA5NTzMZS1S9Z8rSAqTOu9OMzODxyCz+YLzDf4i3UCLmnnaAPwLQDpJ7UGQgQ8eBJuBh1DKic1GYc5x0P71D+qW9KAX7R3ohway1pV4rjGV1Tavd9JYApC/3O3zlgUIDbPuWVOTGBaydphU/s7aybAK5gdaOgrhbakZ39F+zMupKBqLi4XQ4BGZbOsPNKtBMOhLsB3t9y2u8G889kaUjZjAf1EW3BaAy7pMZEYVmgsMD8POmQOqrnAL4mRcFtbb6IrdAwI6YShFPgJu12zyFD02AkJeoTTN6ictstJF1MMeNWgh/wBDlte9pc9/Uqp3vON86ySnlR8uprbDDHSx3bW1QBqVTCkKQDI7hxr2x4g87Mb041eDqVZQwqTaMb2Ig2F/a3ga4W2/yVUsU5UoMydtg1AGZqvvFwNYHzA80V/XEgaOwZ3rjOFh+pWf8JIEqVPFyR1egc1Xsr/fCabSg+k2wSO61O7XM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(7416002)(186003)(47076005)(426003)(336012)(41300700001)(8936002)(110136005)(54906003)(6666004)(2906002)(82310400005)(2616005)(4326008)(36756003)(8676002)(1076003)(83380400001)(70586007)(70206006)(7696005)(316002)(5660300002)(478600001)(40460700003)(40480700001)(86362001)(356005)(921005)(7636003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 18:34:34.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4290fc-cb41-4a94-20de-08da9a6d998e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call only dw_pcie_ep_init_notify() which internally takes care of calling
dw_pcie_ep_init_complete() to notify about the EP initialization
completion to the DWC EP framework.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b6b437823d2..2600304522eb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1885,14 +1885,12 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_notify(ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto fail_init_complete;
 	}
 
-	dw_pcie_ep_init_notify(ep);
-
 	/* Program the private control to allow sending LTR upstream */
 	if (pcie->of_data->has_ltr_req_fix) {
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
-- 
2.17.1

