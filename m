Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359115FE1C8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMSoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiJMSnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0F16C22F;
        Thu, 13 Oct 2022 11:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk8TNsbghTv0U9FvKOtb9kBkRu5cjA+bkCG/AsTwGet0gHm3GB/rH1nmFOb0HGLPtR629OVKJBoQ7hCciCr13GMdfW4B9K4LizgOjTYRHKZwX8lw0mciwtVCzsrytWv/jSDUK+cZ9dhnOpxgl7RCNfrUfk52UdNdg2UwhKVS0Oz9p022raFz6mWGZosjq7WXYch0zjl0tfMFaaN7bo4a/sFP2w2TczyLQR2BHS/pJS8xp0C9DkP6J11K9AdSS21TItBw23I4SchgHu1uKmSpQiHp23/M4gPgcFfP3rO6c2Z6ZRPr3E9H/VvnSWcmni+/5QmXem/gOmORljbN2chPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv0j2URtTMYtnBqq/A4uaetsHamRfZm8w0XaTV8Uimk=;
 b=mQ8Ag8UbcVMWcoDMAQlDb6a+A9zXThM07zIroOhmOqS2WHHm3SsuBW3kILBc8Cs//7kbX03913wp95FclHqj9CUPpnnqhSZU3rOJKojTKHM6bjt0BPqcpERuyCA/Sb5/kqYUKLEECvPFPd0E2Wvuhc+cx65hHBCzMgvuNuWQZN4lG7yJQrbMpVgSldEzzZB+GBftIqfeDPFlTZ14ekIVjJ2ERdXXc8yuqnp08mbZtjZIptSZqrhVsqQoIrh2XVCeTjtobm22IvkmBRolkOEKLWXb6FEiks6mSxmQj04bsAVkYjFNBuyWRHEdSKYh3/kN+mcw+saru8BLTuFhtjd6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv0j2URtTMYtnBqq/A4uaetsHamRfZm8w0XaTV8Uimk=;
 b=Yi0GhQBMQ59rufeq0V8+tfYCZwCYPE4XNPG5NXKrwYQROOu6Du3cg4Ux9Zhnqo3A70YnagI5wQRzJwsoWueSdtWHHR1Tm9Os/PJ9W4sIdPXTnqEJKF2jGLMMKYic21IECsR1XyKs0zPS7Y1TNC0ffvQKcG0XoJDHWAkYR6lXgVad9AHgxSzSSAdgTeEdmTNX8ZvvSfKc5j8KHd8rTXcX/zV8in6r2EDs3w1INZ2jmrCTlI2DPYplA9Ck0zsqYcBzM10nZcwVpSTp0Eqt/YqFM66NlAZbHwG5JieW9aoCWYQJJIur3oBNS/aML76FjauTZAy9H4Sq5UTIFoLurhk0WQ==
Received: from DM6PR05CA0059.namprd05.prod.outlook.com (2603:10b6:5:335::28)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 18:41:17 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::3e) by DM6PR05CA0059.outlook.office365.com
 (2603:10b6:5:335::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Thu, 13 Oct 2022 18:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:41:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:41:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:41:08 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:41:04 -0700
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
Subject: [PATCH V3 19/21] PCI: tegra194: Free up EP resources during remove()
Date:   Fri, 14 Oct 2022 00:08:52 +0530
Message-ID: <20221013183854.21087-20-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 816719c3-e7d0-437b-1cc2-08daad4a8390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl0onNJad4/pqYD7MRyvV31PIZupUaaV+G/yMgCiUH25oaTJ0C5XPKcsbW+euySu+h5CjJs4RmQweBsBttGGfCLnPpytfAbB4gCfcNpQH6ZYctGwMLCX8+UrymCvjVEKtZxHbH0CfTBFuWkM1v0CwVAKONe2MDa788pC6Z+qUCIM9njR1myhN7/jDwIfqgXFLTBt5kMsK4XiozomQIf7SU2n6/yWw0+QTCXIkYHnjDrzkDKLAz5AEmf3GkaGgea9uNCNwc1IDX8BbHJXoJ2lcUyiq3PEjDxy/x1clFVflLHsYs0Q7pDB4TvbtGUYmrRZ6qzAbFKu8a8akqWi8hNr/pb9lcA/G/Lg1/U2GOzHqrcLaf9y8wCk7UejFJct4945Bp/b/Bx8r+sb3CTNEaJCTdjgd5laC3qRO1JXYXgCbx3H5Hqj0+XkOHI66eSJ/678q4rUYDvkSZuNfUHbICJYCKSmG6f9zMKU0cs9cRM299vbAfpLcodKZbUiqQLLhhP7+9OOngJhAdm0bCS9sb7cOH7ZtwDMCGV9x+NSimyFhW0T5aBwHte05pMxAbGSgyj8heSRpzFIsWWsIquoEXZpo5c6vXq4/myc69WvSBkrmt/C1XbIO9cSBWkX+/i1/HTHeGdpuBwfiphLKlrNJs3jkr8EaIHyhFOPTYPwYM1EHmPOsX4+s1VNevY5wk2JEZK1KDMV5oco9Y09zhXljGGl3jdSj6+YJqd79nC0LB3AmlR6RrAZ21/Wrb18l1MOQoyZc/KUS/BrxkP2QlQIGeMnJFm4JfBLjPncUqp5uV4azvs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(54906003)(110136005)(426003)(4326008)(40460700003)(6666004)(36756003)(316002)(70206006)(70586007)(7696005)(47076005)(478600001)(7636003)(356005)(1076003)(186003)(40480700001)(921005)(82740400003)(336012)(2616005)(86362001)(36860700001)(26005)(82310400005)(8936002)(5660300002)(7416002)(8676002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:41:17.1385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816719c3-e7d0-437b-1cc2-08daad4a8390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Free up the resources during remove() that were acquired by the DesignWare
driver for the endpoint mode during proble().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3baf1a26fe68..c88c36d85ee5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2383,6 +2383,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state && !pcie->slot_pluggable)
@@ -2396,6 +2397,7 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_exit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.17.1

