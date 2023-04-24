Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8C6ECCE7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjDXNQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjDXNQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:16:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56E49FF;
        Mon, 24 Apr 2023 06:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUUo0tKzoIwb/CjBcW0KjJZiCxHKsOVr8YVrfhw/8fiRkcPxxNE2lejuH+j9viSHonqhuGc+HNhMT01uHO6k2vuiCYMS2j53l3tZkCfd03NqSfu90dEQ45ktLiQcmjRn4bxcchv6W19SuYG4l9VLtVS256yz1tXNQWb7PjLaxfZdsz1hWSZDD2+b6RMby8PqqWAWstMJFlIoARMX/a2+wpZxQq0o5OSwr1orgj8fRqh04lIqFjXBiOOs3j03R57R6M8aS6i4h2rlECKLKbs083VOdqzglv2y++nRHYVSzIU0O9KvzdNNGes/WJSDfMjFQ5efgc2Er9mwdY8VunAgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoLxQ/aoqkolqX/Bc5Ghr9wWeKjvVcGBxx3jPRPmbH4=;
 b=QwSK0ZdMj+dkkQskkGFBsxy1C5o4ZXxF4oSP4VXRXL9fO9+dCXo01oSFYCMI0Mjo5KOijVp//RfLVH3zch/s/IUWoY7lXGKZS5hzLVLreXRV885tLnt5p0QHWvyESfuXBecIisu4WMfztdO17oZ9Oeg/fAgOQ1PG58aYH1tvBN4XUUGDjhnT0dgbjvCj39ufKCyUoIozrkWUkQ85GViptClJDt16j9+DnZ/pNynNO6/wQuyZb76PEUQfpliqapQ4jD2N1unm3d0BAFFyhCyPd1ZnXPsRJkowWwgxQyKiN0+eyoPWKlc4czosKekV/fQ5NCxbp+9gAlk5S/BeZOrMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoLxQ/aoqkolqX/Bc5Ghr9wWeKjvVcGBxx3jPRPmbH4=;
 b=NsLyj6cRFjg8CurCT4CsabTwuWAdj4r9mgZbtEf0Q+XX15Dlps7wy0KNz0/MzGheN1bJJzCBt/4LgGohpBfhHa9hI0lasJy2cOAcUxp8jP1RmnxSA8LsCNzOYVhq8lxa5o+jDHculhrRJNYEr+hWLULeRZdez83+erW7LzHBYLA9eVz0PS1OgiUraiXtzPj9COgBr9cdHCYV6Lxp1OaQHeIEF0o2au/fkiViqibH7+D8LQEkTnfcRTDOoxfmdR/6cciC6XxmJICU/OdlgU8TpRmYVB+sB+zVhcCjVGXaK7+urgRhlimIJbUNFQj4FnNyTqHWt5IcjAYLFJCbrgx09Q==
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 13:15:48 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::84) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 13:15:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:15:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:15:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:15:23 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v7 6/8] PCI: tegra194: Fix possible array out of bounds access
Date:   Mon, 24 Apr 2023 18:43:35 +0530
Message-ID: <20230424131337.20151-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 8130dd06-4705-4a63-e68d-08db44c604c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUbBLggUrZ92LAwGHr8pJ4Eq1Ufv5so2SbByZWHcoOvQK++h71hN2gflYQ6/oMap0HdJ9VauceI88P+yTPrmJzvvSN8sbHvdpcJLbdwIo7+V5nLaabPojhxdY0RxGVnBlVA9N932p3cah1Q0jZ/RKoQvKrh93qJeM1EYsjWZrBy7SDmmNGYw5uNeUqL0mnK1+4MzAblQn6PcdixuKwSJ4pJS4v87aUW+BbacolIcJs+Vnbb6/JZzqDSS0HHdoyPwstIoeCKcgEXAcTKrtvGH8zyL2CA9ExR+j1vg9Q4ogIvThUJqulAADc6kd/w4/9qkegtuNhd4tKFj1klhCY8JWw+lPLbV+d6opHuOUQkiT32+lm5g/8ZJ7R8tr/ie3AS/2/5Svs4t3VVzVPVrUb44Zjcd5Vvy6NaDdNFgAAh9nJ+bDydYAcq3Zmu2I/+YE76EK/bzIacj/xNOS2s3zV7JedQe9QWxwV6VAk5oa1dqCKpq4hvzCHLQ4u4vwF7ilNsSZcwf54Qc4t5RZEJNeMQoKOT/5bPzm7w+7Y1CNmMN5XWDOfzDbN1c0whxd4ZjE35BoAzkLE1vNveH7xOQ0yhbw7xVbMvb5MqMB3yKJ8qoouq/wq6P/c7r3PO+nnWAQCWFTkNOn9bU+n1h/bn7dXVufC+As7ZZWpY2Dk4TlMKgdE0pJdpPoYSE0kQGYBG7yh/kkAfjQVyb0W0SlVLHZwZRgnkZ2dwr4Y9BDz2xEcR9oTWgqFq71uiEjMNWL/n/2wwx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(426003)(336012)(966005)(40460700003)(107886003)(186003)(2616005)(1076003)(26005)(8676002)(8936002)(316002)(54906003)(7416002)(5660300002)(110136005)(41300700001)(86362001)(82310400005)(36756003)(82740400003)(4326008)(70586007)(70206006)(7636003)(356005)(6666004)(7696005)(47076005)(478600001)(40480700001)(36860700001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:15:47.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8130dd06-4705-4a63-e68d-08db44c604c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add check to fix the possible array out of bounds violation by
making speed equal to GEN1_CORE_CLK_FREQ when its value is more
than the size of "pcie_gen_freq" array. This array has size of
four but possible speed (CLS) values are from "0 to 0xF". So,
"speed - 1" values are "-1 to 0xE".

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..e6eec85480ca 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -223,6 +223,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -459,7 +460,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	if (pcie->of_data->has_ltr_req_fix)
 		return IRQ_HANDLED;
@@ -1020,7 +1025,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	tegra_pcie_enable_interrupts(pp);
 
-- 
2.17.1

