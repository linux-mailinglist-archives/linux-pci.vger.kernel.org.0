Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7457CD66
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiGUOXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiGUOWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B525868B9;
        Thu, 21 Jul 2022 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdhLC/1G403xLSZCqBTJdRCM0NU9FhFbXogcT2zYBdb0iDwYjwY+scFd/HYZ1eG67X+EnYZkRrHrDCslN98g4krA1ekLPaXp36dEAgTpy7zHYkps3zkYtXK0D94+EKwvxszs7qwyICSH7GcC1jG/bQ8u9P1m+4WBYKqPimaglq764TAzTuSUCrfqLV4Ssh+HsTu0jpc+fmG+hIU1mToZ2UXpl0bsyePkJ7s6EIsaoUPRaqiPGUwRrGxj4yRb+g3j/dmNddwAzQn3VtzvxVHAIi5VEjCOzHzbSP+I8Ai4gBCA115m0K80gBjRA8v03Q2xrxFbr4dv/AFzWYUD2/2N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWJjYg+WqWjAwu/ZjT36WNkhbiKF/no8rjlZR2mISeY=;
 b=Ka3CWwV2rzlX29QYKLrf1ZXcdMZ3QZapXTTMCEuapR1AXLUC8c5BKINXzi3ouqxUQL86bh+cwNGTLmzvQ39IyumYyxXy0qZqgD1HcRXo3QDK40OMXud2S36Q7mmr1rAmORC78U8H6BJVB4JzEeTcQXxQtRe6NWyhK5EoscTVjTS3ma8UQvqLlolcAkCQIkw7yms5BCgCf6RuCStjiiShvOWlIIxmCvfE+QRKm9BsSp7M2V/j2EF6gMKtO4MsJXYdProMiBC9ksp9uy/qp9JIW0FGw0tjeELz+d+MX8tN0xw7BAnyPCR6X0BK7zd1qs2R/T9Yvuk0dW4yh7TWAo4EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWJjYg+WqWjAwu/ZjT36WNkhbiKF/no8rjlZR2mISeY=;
 b=oJbzBJGDwchzZJyxN/WWCHRbv8V3nhHfsXq27uhNzbqUc4uU1JkEr6T31NIou0oQss8BjDZena1Z8VRgaB2Qag7M3dN1M9ACsYYoKmAjcoN5wPSt+0vhqaggeqx4qbkxav+4tNTkVO6h5vU7I3EknEuMsiquWf2g+BwLHDKvywnOdSoqpshpHrUT6GoU8MTjYGnv/82FGiFh84gfYATX3L+8VfP1/WqGeUwVgZJP7nGxCZsLqYBksLxymEoqSUbEjr6hgWRfejDdFah9V46rzwu/D2RRcYVDfU8NOQbJoqIbnJHJPdZ4uhAECIKfcHJW7bxnoLp58+B/MVERmZYjTw==
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:22:25 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::ab) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:23 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 11/16] PCI: tegra194: Clear bandwidth management status
Date:   Thu, 21 Jul 2022 19:50:47 +0530
Message-ID: <20220721142052.25971-12-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5084094-1cfa-46ef-229c-08da6b246ed9
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQ0F4Nx16itu236z41eFpwjyGdV2puPQR3QGiS5zjSRpVy1GBcYk9cCOiiM7J1jPlBb5059dWxTN86yq0BSJ246ar6d4mn3d1O+tptrjRc5rXcqeoYLMhkTZFHPzyx/kx/c2p6OAiiw8aKiEbFvWffc03vkEuHxlnScrVD1MIaB9Kjf5DNSsJa5Ohb+49QCxuExhE9BCUfJUxP4kGOwr4CGQsShTHnC1YyU8sgt5U2Pa3xXc18itRL9rTo4r27ucZCdKFUB+xSXWEhOXvR2boG9SCczY4kWgkusk2uc494hqIRf881eqksFXk1QGteZz86uzPurc5wCPyygSryF4EUhtB3owQ25d4E71kssXtRMrFQO0760nrtHTXSPj/a6FcUcWgJAacZQK0gXzNyu+sEGvkWiw8w4l2X1b1AOgTeU/V+ttv4/59qdev5LluTiLOWfA7NUVyEk19NixSgN0QjqXZdlbWnVyGWBRa2Vzd+FEc6ePxvvk2KAxoIdYMgCSh67sMNbKtUZxRM3t65ZCFiyjbiOXYWbfKvVQtolAdoL1f+2xp6pUZ43gK1MyYwxSQT9H7eznXezBT7Ij2hQeKNGgYM7kf2Zt0uY9toOtBNYizbSSZ4fEfmy1z5Vg1NHBADEu611UmYgKq7r9Ra1eLC0MeJzDECycgtvq2APHhPWZ6xRuDn2f+xpL6z5FXsETln9iOhvGFwHZp+1WX7+YTkJZPo/ujKHIXg2zu5R3kqpet2M5BOgHa7GwmBXkJNPOFBMtRp1kpssETqXaAXr1wurXyiv5eBvJa1xR1WQ/Bi45FvHNm3reyLcSoRNe3UTV2TD1xyvr/BQXdSQrebiaXwVKHYoQ/yLY47Axrh2a+iw=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(70206006)(54906003)(40460700003)(316002)(36860700001)(26005)(8676002)(47076005)(70586007)(336012)(86362001)(82310400005)(36756003)(186003)(2906002)(4326008)(110136005)(426003)(478600001)(7416002)(6666004)(8936002)(7696005)(40480700001)(81166007)(2616005)(41300700001)(1076003)(5660300002)(82740400003)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:24.8127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5084094-1cfa-46ef-229c-08da6b246ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the event of a bandwidth management interrupt, clear the bandwidth
management status in the configuration space also along with clearing
corresponding status in the application logic register to avoid slew
of interrupts.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 23377425952a..5f1798d37572 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -370,6 +370,12 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 			apply_bad_link_workaround(pp);
 		}
 		if (status_l1 & APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS) {
+			val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
+						  PCI_EXP_LNKSTA);
+			val_w |= PCI_EXP_LNKSTA_LBMS;
+			dw_pcie_writew_dbi(pci, pcie->pcie_cap_base +
+					   PCI_EXP_LNKSTA, val_w);
+
 			appl_writel(pcie,
 				    APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS,
 				    APPL_INTR_STATUS_L1_8_0);
-- 
2.17.1

