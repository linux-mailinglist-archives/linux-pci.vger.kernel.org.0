Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01035FE195
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiJMSmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiJMSmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:42:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968CFE09BD;
        Thu, 13 Oct 2022 11:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiHV8Naim2z5MPR1xooWsl0J1T1S6jUj907HmVfVo2qaX8IZ/0YDrM7+/0pHBgncqCPLuHgahY3/KvoxtjOzovPtf06S2AjSxvoNiWWKkLpx9uXRE8Cu3Hm3UUGTvVv2tuYE3J8njYflC366/pNbLxJWEI7LnHMzJN2hw8LQD8jhGjfxt4njAlv56cI+bTae0a03uY1NrPT82YDcWt62ymE4rB//RMAspE8JokOWlm8U/O1Tf5u6Dbu89/TL3fbuF7PYlVtFptByBPh9NH15UKiYi6lcokorsu8XOoZgIg/MgmTVvRRnA+2lw6c90n+fQ/kEpm0A8CNiiKTYbxmYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyu6fTt0uPsz0f6b6dJQ1icECHhFxvqxTh7+vbJDwUU=;
 b=Lt//gGL7CH3hE7BBSmPIUxxashykLWY6+DD6wpE/C0U5bnhusBA5Zlx4IXQmxQz/LPL0BeVsm4e0zUFSp/bavnBHkS/5Iv7i7UkxJWI7ev5tweOeDEhBMUiNlH3W3NjZszfj92qCBbFpdWU2t00K7OgY2GUc2z9jd2AA2T6yvZinOf+Pu0eMYJo8E0Tdg5yxZZsBnSCNucGVKsAtko1VxMD3sQhWg+SDqUvJ7s4vdt7s8qCkiUTTKzsv4mev66ahkRA/rFzps5XkbYqINKq+wOAg4gDSGBN7t+43I/Jw4XwiDhqovmAtVLVvqJ2ZrKiNka8BwjT7tbi9DFcjG1iXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyu6fTt0uPsz0f6b6dJQ1icECHhFxvqxTh7+vbJDwUU=;
 b=hzh0osXW3CUKEynA1FTmoJ8xtwNpcaWLEQqGh9ZMuHBr+b1KeQ7U4Inssus5wSxOaXwJE+lle9JG40awdwc54qT6odBXXfqzMJ6kPjU6SCyBYY0vZps84/6NmVnU7/V+spdGSD8D0RyraXIS4OjSYUcO4HmQDGzvHlCueloBoFd3pme+SP7ZbPZwGgY4jQQ3HGSlck0VJIjA+i/OWHSpLD4kvxYmUbiA2Z1xk3VuagBmACbsnDoUaQ1UM3JjvBu+zMfUUSTIwBjZEDHxER3qtE9029OQCFfGyqH6UaOvBbaQ6f01eAWIjlsD4VD4fAiiHdGQWg3Hb8Nfoh6rqaBBSg==
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Thu, 13 Oct
 2022 18:39:48 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::c1) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Thu, 13 Oct 2022 18:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:39:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:39:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:39:42 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:39:38 -0700
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
Subject: [PATCH V3 06/21] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date:   Fri, 14 Oct 2022 00:08:39 +0530
Message-ID: <20221013183854.21087-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef0a5bf-ff76-43b6-ecb9-08daad4a4ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBDJXO4wuNqpxFvdAantnOu2LvdiYPeKVeyjgMmxJ3Gbt/r7c+AYIWMGibHZm+s6AbxcC+xeZq2Hxu2+fpHjrndiW7fw762p/dZJpyfwwAOvZBFtlZe4+mq9k+nZOGtkCfYlhaq3ZJgNzk5e9oWQdKQI0RVZCl3b/aDKCL16g7pbKffj8UKwXGMdXCYMyJ653ZDv6XrKBk44hu1onLXI3JBqgMovGjA2/NgJlRRz9BndjpiE9dSdp0hDxgraLwt21BdGXHia8Q9WmIDP9z04ubUzAm2Il+S62/Iz6Oea+a1dkXkiDdbJwJCV2vuPY5NsVD5y0pQhGp47XBDb2jz8vto8pQPkNMO5YcGXhgurmI2qNnyxE9LF4n2geQWKlnuKcb472DAZg1y13GvZu4CwkXlwWyHOBRAtU8iPwU7+7T0EkfdZCitKZwmS8z/vuLs1/tGij2DK0nTK9wB7CWFgtwezM6sA07/9QD5ACzzDPVhGJ+YIltDrsAo5hMOIiSMpnsd8pIuV9HrO/4LIE86GqPh+hu7jcqRECNB8g94xx7onl1fj9w8P56nNOeZekMUqMFHFdCy90gx84kSyLSDgVa8O3ncqI+ORiu5krvX7bThTuMxA95VEAYoFH8yo+AlfSZnMNx1gqq7h37LpuXAWWPK9GsTNwvgNYYpy/a8zfDJ1bp7ghFTSDGZGNcvtRC4DXum1qJcHYL8MyyVAgz9w/qcTMfz7Xbn9GaZRukXymxLbmipyQFrq0Nzrk/snKqsnhOdCGQs7yocNOGfn+Gl7nvaL0O0lSS4YY2yRxrubaec=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(82740400003)(70206006)(70586007)(1076003)(186003)(2906002)(8676002)(426003)(336012)(83380400001)(2616005)(40460700003)(47076005)(36860700001)(8936002)(36756003)(86362001)(40480700001)(7696005)(26005)(5660300002)(7416002)(4326008)(82310400005)(54906003)(478600001)(316002)(110136005)(7636003)(921005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:39:48.5195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef0a5bf-ff76-43b6-ecb9-08daad4a4ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
and Recovery.RcvrSpeed transit times are 24 msec and 48 msec respectively.
So, the total time taken to transit from L0 to detect state is ~96 msec.
Hence, increase the poll time to 120 msec.

Disable the LTSSM state after it transits to detect to avoid LTSSM
toggling between polling and detect states.

tegra_pcie_dw_pme_turnoff() function is called in non-atomic context
only, so use the non-atomic poll function.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Addressed review comments from Bjorn
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 69e11a74a0d7..897e2a22bcd3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -141,7 +141,11 @@
 #define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
 #define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_PRE_DETECT			5
+#define LTSSM_STATE_DETECT_QUIET		0x00
+#define LTSSM_STATE_DETECT_ACT			0x08
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
+#define LTSSM_STATE_DETECT_WAIT			0x30
+#define LTSSM_STATE_L2_IDLE			0xa8
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -210,7 +214,8 @@
 #define PME_ACK_DELAY		100   /* 100 us */
 #define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY		10000	/* 10 ms */
+#define LTSSM_TIMEOUT		120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1663,23 +1668,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY, LTSSM_TIMEOUT);
+		if (err)
+			dev_info(pcie->dev, "Link didn't go to detect state\n");
+
 		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
 		 */
 		data = readl(pcie->appl_base + APPL_CTRL);
 		data &= ~APPL_CTRL_LTSSM_EN;
 		writel(data, pcie->appl_base + APPL_CTRL);
-
-		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
-						data,
-						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
-		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1769,19 +1773,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY, LTSSM_TIMEOUT);
+	if (ret)
+		dev_err(pcie->dev, "LTSSM state: 0x%x timeout: %d\n", val, ret);
+
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
 	val = appl_readl(pcie, APPL_CTRL);
 	val &= ~APPL_CTRL_LTSSM_EN;
 	appl_writel(pcie, val, APPL_CTRL);
 
-	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
-				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-				 LTSSM_STATE_PRE_DETECT,
-				 1, LTSSM_TIMEOUT);
-	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
-
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);
-- 
2.17.1

