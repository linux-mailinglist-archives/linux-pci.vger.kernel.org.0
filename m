Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF45FE016
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiJMSEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiJMSDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:03:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F8152C71;
        Thu, 13 Oct 2022 11:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtSiHpFQAfCdqfxDssCXKn9uLogbugEAfGJ8y6eVC5LKcy079tmqHBCv6ZrJpMhp9obe+Et5NDRPWMxKCn90JHq4yBk5sHDIW7bNWHxh9OghLkZZaCIViBT76POOxJAEw4XprjJt4YyMlN8GsHFTm6fa3WFLXvadrqZv03gJvZb/XoM7f3bFDYNbZcRIBdcv7y9LzOjOnFtf8O1zkaBSOGCvqBg8AS08LFaK/bm0iEKYWBqhVfZQmnsUVS63SZlG7nes2Av4FZGtKitQaErFArB1bDwOwcclLbgLHxL9s15MXGgGsJyFlvQJ2hMT3SwHYBXUn40/QJ8TmJMqk9VsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue/wl7jK7mpk+I0nfBhUsQp8iyn7yd0Y19aWd3/wRr0=;
 b=GL6f7GiP3H3GSxxv4SPjM6NFY2Sp6S6CL9W1T8QtdMuLEZbfzX/LEJ/EkWTktgNxNsPdbkoT9i2rHlRGlW66olUMCokE5oXEOGU64PHUrnBCE0yDhkJsm58TEgd17jMMX7gxJA7QIOLJtfA+leONHLLUBsIg/DzteLCHwrx6HnqkIghu3HcRihCU8SRtXvv3CMGxbjXtvv8BU63SLGwc8LUIb/FKjfDGKy6UF1XtKGCN/Gg+hceVypyS+pb+qc9WSEFTLY9elHz/rvdFgx1pmx9Icdo+M+0KY0Y+Uir8FcsJKH+Sfw8/sGN+K86R0wLYZS/kXG7jl4ESTXBs0SQCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue/wl7jK7mpk+I0nfBhUsQp8iyn7yd0Y19aWd3/wRr0=;
 b=dwb7bVKhq2AXMaF5LrKbyD2KbOAqp8CmjofsVAy4tf7TUxMnOPooa6kNUX4z3OnNYz6UCdItaWdzfXQXBe3b8+zq6431Jb2koX4mMFXeGWpwEYYQJnVzdGh+DeFDbDy9OMWnaeNO8BlKJMpkrZePSX0ujonIs2nVerujAYYP3UDIbtfXesextOBcOmlr2s5hZ2b4JYt5HjM/AMlLLA06yQpKeowqmUFgIZn1HktPfvzmpcrNKrZUwhRbUmQP5xX4fR9Ct1hoy7OQjMiGsfKpIE5pyyLaGaIyraMR4uLHyjUoccsfU/L1Kpq4kAc1OAIGfrvLU6jNrnGIwLvMMmbdvw==
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 17:57:58 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::b0) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 17:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 17:57:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 10:57:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 10:57:41 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 10:57:36 -0700
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
Subject: [PATCH V5 3/3] PCI: tegra194: Refactor EP initialization completion
Date:   Thu, 13 Oct 2022 23:27:12 +0530
Message-ID: <20221013175712.7539-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013175712.7539-1-vidyas@nvidia.com>
References: <20221013175712.7539-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a65003-5fc0-43c9-9e87-08daad44763c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUs/jkYoLcMeRRaHrU27zHVl5XQm15N8q9IBB5UEcHF6XOt1r1bIw+s74CpehKTbL7hzUMkHoyY01XYdkVbTm6bS09pue5ZXvpwjPsPaenE5GgcIxTOux/Apwhr5tTa1eV9xW4g5H/suSf9SOoyhtQtJGo3lHtSAfpO70PPMY1Cz2ij4uJgqqIe6FizCEZkmbiNuwd/lv6SYO0fa6D03UL0XC2/c3Bw9e0rQKKWldix8RToJ2kIKHBrYQWHxM50dWZpI/9nTqGdPaLEsC0GODaYTRlUMNNaQEjBfyOfXjQyKBWBxUlVDD+xTjaAl4bm7cGN7iBLaasmTaiRvlxbj2COUZPvRKK0UYeR/Ooc5LbUoRLe3OBS73Kl04DNoyDxbUedQILrQbe7viQuIQuE3dMqcw9D1gHbkl22o8RabZC9vTvEM+IQyvj0lef/56JYqA7Etc1I/bBLpJBc61YjL0Dz4Cyv3hgLk+ZYTW4c+YUfn7hXuzeHzBd1hfpC+VYcRPZQzZ4yEFEEJq+Xp+KLqIcHU032MydwpSjBNH+g99QsjS1i1xv7yVd6KKE2Y16pyzdyCvNaD6P37uIv/sUoVUy/d7tWPcbeubvrHZdKZcveyooAlF/V/SqmAc5LoB7PC9F++z2wnqgC+DnOZ04ngIl4Bd2Fguhy0YjlqeV/CGm85OkqXVml0g3JlNe5BGklgDuF6xcu1KQlQ8fCB0Z7eJhArM1AQouGx7XX2gDlbzuHfbZPFFh8Vc1XSEuhhiY1hYTL41A4wMDTc9D7ZUqiHKBc/dussBBs/jv7/tKyPQIw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(110136005)(356005)(82740400003)(7696005)(7636003)(921005)(41300700001)(40480700001)(40460700003)(36756003)(82310400005)(6666004)(4326008)(8676002)(7416002)(8936002)(26005)(86362001)(316002)(70586007)(70206006)(1076003)(336012)(36860700001)(54906003)(5660300002)(478600001)(186003)(2616005)(426003)(83380400001)(47076005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:57:57.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a65003-5fc0-43c9-9e87-08daad44763c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
V5:
* None

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

