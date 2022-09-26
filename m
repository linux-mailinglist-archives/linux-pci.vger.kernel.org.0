Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A895EA753
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiIZNbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiIZNbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:31:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCB1A399;
        Mon, 26 Sep 2022 04:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mluapaKuMQtm5BaYpK5Nq/sEL8wvfxsG4OIAY4xXWpgcuZ+9xBL7Dj7uFOs/9E2eIsfU/zCERjyawne8jCxzQjI8UCw5OI9AjxEs8MejOtlNq4JYNTKc5GpzqoQlyIU9YJnmLU2VhyQSX3W68Ym7Qf91F6l1en/j+UFJgJiX/7V9n4uSIV4+ZWMHpVcgNdmZucohEIZd91bPnl3I7Fz6K9Qm4ZKtD9ue9aJK7bolF6f6jrPqw1NV1VNOu+ngSuPjC25UW1uks482sI9e/RZuHiV+1T1bYSIpqsK1S5uBwTn8UOmu9plHtjzKz9jIWIHpvZhEpg2CO7B2K8dwPz9Xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RfYSIbmZOKJMK8FY5G2n0OJBNCOcjzm8RqyqgsTbrU=;
 b=lTEv0iI6+lcLruYfm0b8HVq7yZZWQZ5ytmHinycydVRYV1i7u3Y/UFnROc+5+d5KotfIYDOBRl5PdkRLBkAfBqGbr4i7Th3vlokWV38qiwqkE55MS1X20ZjIUWqkUob8lXurfWQ6nUfTicCDku7djiHBFFe5Wyl8/YlTzx7e0VFtWJhmV7gBXmayY7HHq2fAM2TGgZ//EvBNkgPbCU2hDU8hcJ72WI9cnKNmIrnTmJBh+kNwaph1jAd6UOf+NiPLHBFni/c0zM9DpAg1btQbx+Bxew7dU4lhgtHt2du2xPDikm5d7d6xzwlCr80r2kBt86lqVNueMiBcbSUcaL9Olg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RfYSIbmZOKJMK8FY5G2n0OJBNCOcjzm8RqyqgsTbrU=;
 b=VsFktSF/cW1JhgWN4drVzze1B8jgXESatEMHvmFTK6QfxAxdgezWtX9xcLgB5hMIrQ5ueRq+r8SC3tq0wLwaqeKrO3i3D0o74Vdju8qlpmYY+6Wyvp53VGDuI+ywCzad6InRFwefwkrLfjP2FabKyKkj80jzbRf6c7yDjJIMZFCh4xxqE+CK/c9+q4zfDa4BvJAd3vTTvxj6Gda5leeG50SDiwy4KEULI/U4ig2vGoXLBYbErwdNG5D34Uc274MlAudzW84itsfEXKR0YGyRl8MY7y2sW0HIzIjL9mWtjQfbsNEsrgWGVX6hWsSJ4yw3FrvDlBZs9+755qxGX/vnvA==
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 11:51:34 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::7a) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:25 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:20 -0700
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
Subject: [PATCH V2 6/9] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date:   Mon, 26 Sep 2022 17:20:35 +0530
Message-ID: <20220926115038.24727-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: d7289470-1b37-4715-122b-08da9fb57630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnJtJgwTZu9fNq5EDb8y8BdJpjLdKeOJdUHpBK73fzyKoHfxM6nvLtWG++OjoudEfoph9UyU/dHuvrUlm8IPByzfpHsL+d/0ewH6bedLq3TiyDgV2OGY6Bow8cEAI1c8TiiqvIuKIeyOKB4x9XOzB7LIpoo1HsNo6beIW2uH2IcuHjqugpA7HrrD2aWn5Gy0LG8B1oLAzWRWws4tnragxcxNZ4DYJ87vQxdF7XOn88QC/Wre/nGJGynu8j3O/zaUevsTTHUONC7LUP8pwQ4l3FTZWzgY3O4r1i0FTw5C98jGUbLzmd9jaRuxob+A1PFmzZwpXgyQXG9i4W2qK8i1giKMbjwIAiBEp521lnLlg6lGWmorH7z8u0MuO0MgxcpKD12PxllDs2JWuMimFI0l5xGVbhd1n9MlrWppxX5+2scqdiFMeTRa8l2dwkhujGcYcRGuxFzaKEv3T6rVMPVlX4ZDxQlhBljHEK8Z9D/3UcUgdIUnza/AM/+oRKrgRaOa6FyNBKAs3KJAFNWfO9Vn7do5n3/FYgKxvqcQIXBZrj0TpCVbDYOajWlOt/EMfXtXgYqr3mdaTvzy08KLFw97Uc9C+zjAbuFzjRcJNHemGOjr7sAtWllGDvLfGNL1FidziShQE50Nx3TSkiXnehRtpTm44XQVpm2efNhojGKmzaAD0b4dukLPXIKG5t2k+p3F390z8XAZAKryR/T8bwIG5vmuI9KQ9X9JkUYxESqSSiO9DiI81diLvlXRjm7Xcdi0KaNaIOTWMdC5HiCXCtRAq1lRX7YvJ4GPKVVttzLZG9g=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(7636003)(921005)(82740400003)(5660300002)(7416002)(26005)(36860700001)(336012)(36756003)(2616005)(86362001)(1076003)(186003)(54906003)(70206006)(70586007)(426003)(47076005)(40480700001)(110136005)(316002)(6666004)(356005)(7696005)(82310400005)(8936002)(83380400001)(41300700001)(478600001)(4326008)(2906002)(8676002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:34.5542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7289470-1b37-4715-122b-08da9fb57630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On surprise down LTSSM state transisition from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect.
Recovery.RcvrLock and Recovery.RcvrSpeed time is 24 msec and 48 msec
respectively. It takes ~96 msec to move from L0 to detect state, hence,
increase the poll time to 120 msec. Disable the LTSSM state after it moves
to detect to avoid LTSSM toggle between polling and detect.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 69 ++++++++++++++--------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4ba2a17d92d2..702c55deb747 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -140,7 +140,11 @@
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
@@ -209,7 +213,8 @@
 #define PME_ACK_DELAY		100   /* 100 us */
 #define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY		10000	/* 10 ms */
+#define LTSSM_TIMEOUT		120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1606,23 +1611,31 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
-		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
-		 */
-		data = readl(pcie->appl_base + APPL_CTRL);
-		data &= ~APPL_CTRL_LTSSM_EN;
-		writel(data, pcie->appl_base + APPL_CTRL);
-
 		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
 						data,
 						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
+						APPL_DEBUG_LTSSM_STATE_MASK) ==
+						LTSSM_STATE_DETECT_QUIET) ||
+						((data &
+						APPL_DEBUG_LTSSM_STATE_MASK) ==
+						LTSSM_STATE_DETECT_ACT) ||
+						((data &
+						APPL_DEBUG_LTSSM_STATE_MASK) ==
+						LTSSM_STATE_PRE_DETECT_QUIET) ||
+						((data &
+						APPL_DEBUG_LTSSM_STATE_MASK) ==
+						LTSSM_STATE_DETECT_WAIT),
+						LTSSM_DELAY, LTSSM_TIMEOUT);
 		if (err)
 			dev_info(pcie->dev, "Link didn't go to detect state\n");
+
+		/*
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
+		 */
+		data = readl(pcie->appl_base + APPL_CTRL);
+		data &= ~APPL_CTRL_LTSSM_EN;
+		writel(data, pcie->appl_base + APPL_CTRL);
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1698,19 +1711,29 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
+				 LTSSM_STATE_DETECT_QUIET) ||
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
+				 LTSSM_STATE_DETECT_ACT) ||
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
+				 LTSSM_STATE_PRE_DETECT_QUIET) ||
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
+				 LTSSM_STATE_DETECT_WAIT) ||
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
+				 LTSSM_STATE_L2_IDLE),
+				 LTSSM_DELAY, LTSSM_TIMEOUT);
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

