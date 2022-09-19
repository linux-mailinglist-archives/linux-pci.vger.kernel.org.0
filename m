Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5363D5BCF1A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISOh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiISOhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:37:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72733340;
        Mon, 19 Sep 2022 07:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJLhNzUmT8WPoZa1nxiNgCE3OgZNWTthmrpVb2DvgtkxKsRKJruYAqaqAUJ5tbv8kT9JMtYyyFec+VOLOlb1mvSGUcGPYTy06OR9xR4WRlAFnSSsCdUS188AAazquSLz/3MY9pLp4lrJs91hnLe9b9NZPv479VIFmbyyARNXrm3cT1XnETLbD0Q43dnWN6+uv70O7sUYFcuqAIEbeeQ1/86+ZNOCd0cRqIrj0IZ1UnPMKI0+fl/XOK4dxnvQqqJ3clFI28YMWWuqQjN1+ePRnAHPjVTxeNAwyDiVnL5dc7up4PWRzGXG/8zeYr2My6O0ZoWVYRAjeAzau0zEUAJTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFlWkTNu9V41TXZGNNEmku00Z68ht2wRGvk+UbdMVbg=;
 b=cMAvZACL0yAkw1u8yDCNQLnArnLRkaOCVg4VRKttOPrWJUy+SbqzfH+6gu1roO+JFM7pRZrv5mJi2/xXKx37g20sgMqrfTBCnkpZXXkN2XWezCB4+kPqTAu1T7oQ2qDT/8xzZbzplKwhr4ktmq6l9EybnrrM66D+SMjr4b5QymHwtDl14AJIzU8qT7yuhaw16/yO8tSjCjAEXp4tGx3ZIm1TUpUWuHeXEg2OZg/3cOCbm0Fz3ig5D4Em6+3as81dYOrUZPTB+y45jpCrv4QosiVePc20knoKcr9AafCYexI9kIn73guAEPUGljvpBt/q/aV7VINeGPqrpQyQUet8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFlWkTNu9V41TXZGNNEmku00Z68ht2wRGvk+UbdMVbg=;
 b=YJQZmKqB/i+W2Ij/QrHAaOTHCt7AG2YWfRbeiNUsRG6GbFR7Etr/EPKEFp9ohBH0PZOCL5NNwPp+l/4WEXSsDV4fHRGdIsLDG5lhFuJlh7qkQ5Skviom19rI8C7lqYgL3e4DwMWFtfoH45S4nmoqJ/X2+dWhQ/Bk761i549a7FB9Mz5vTs5SSRNI/kXrRJk4SM2JD2C37Y3eCYwa6B16lZCNTWkaQ/ThOOa/J+USjiEqYH83EsDW1z1DfVSPdTD5rwCy/uXncWHIRlr9AAdQN1+HdSkKV2BlsrvF7Y6kP7J95rgZDktvKlCQeNYVUCffpQ4YLqpNWKnAlJ89YXGzjA==
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 14:37:30 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ec) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:37:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:37:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:37:18 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:37:13 -0700
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
Subject: [PATCH V1 6/9] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date:   Mon, 19 Sep 2022 20:06:24 +0530
Message-ID: <20220919143627.13803-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: db22cfc1-12ed-457b-fc71-08da9a4c7b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lnD+J89fOYwm8nCFylnp3HS4WAt3mP1safN9DqYW22gA/i3XHdAPprCurx6xqHjFfGKn1KoIUi9MWwEj8xN+PKAnpFtPWtF1Ucpa5Km94YorQVBhKmNnwAKBl4DKBkNAnjA8/9YCYLN+su2+CjnM4+iaOAm1F8Q5Bb1AdwwPmqz3fiwFHYC/GLFDNF7Qk+o3ylo51BRLVy+VT7IBRt0fbh7x0voOvpnDnHG3OYKZEiotiWhzb8R6nupqb1npbyCaqnF2SHwDBlBVKH7eCG1J1WL5pUxUeo41ogg8G31zjjVQXdzOzoqkzIpk1EKTeKjlHEMlmIfDz1GYQV3TkhCPZvIFeFWUlDTIUSBGFK6M54ydrbBV4DldthGzwJVl4KDIYD/NB4t/tK/NcrxbTQ6u9joI2rDxmg12ZYta5e3VMJbvvlWwme4BYixGhfOneU0sa/lD6aJqGhsclLlGw4Gyik3aCAw1bwS0beb7O6uIGIhYgD4QLXapHMrzgoM0Z3Lk771ujRfblEwoNQT4+f4o/3yw/T/vAOPIGPmuuS6kcHnbCKyLDuh+u0RqiyFvSo+0GHJx6pzJd3fKg0DtmhhxlgA6KIphNb23KfkRDRIS9cECYk3/CMzB4M2WIhM9RMZv7iar/9fFeHbttDwzCphkQS6k0EjVyJv/bf6G/ZhYc8XjE3Pu9MOe4okbQaEewaMm8aazAQcE/ajXhboPDbR0+wXDXUz+IgawwJPaZWxDj5+clLp6/F8gmQ78Ge3SJcpbblwGlKCTpXh2QkKSvaRzUnzrMFBxdgRbeKvvamCJnU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(7696005)(921005)(2906002)(36860700001)(36756003)(40480700001)(86362001)(8936002)(26005)(356005)(70586007)(70206006)(8676002)(41300700001)(7636003)(6666004)(478600001)(82740400003)(110136005)(83380400001)(426003)(2616005)(82310400005)(1076003)(336012)(40460700003)(186003)(5660300002)(54906003)(7416002)(316002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:30.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db22cfc1-12ed-457b-fc71-08da9a4c7b95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-tegra194.c | 69 ++++++++++++++--------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f96f60c49dcb..e38fedd42034 100644
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

