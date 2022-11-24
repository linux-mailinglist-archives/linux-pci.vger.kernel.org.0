Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEC637420
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKXIgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKXIgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 03:36:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA290F8876;
        Thu, 24 Nov 2022 00:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P94h4xjNOF5AA/zET1XJm4Kwp0ju7BfauMCJ8gXeD5ub6rVPlK2ZMvOBHLxkz1vFR0mhFpMVD8TBWcXMgimMwX9E4s+mO2J418szp5MpbKmCOtEdHGKNamHp0ocKflKLDr0F7BLHYywCqf6qjG+LJzAgixg7kV9Ny0wYHIGpbiQuWLKaET0qBN2E+iLe38uJbPGZ6KdC6qA57ygsY62MVvahqq8lHY0lKBkkASZB8TGmgmLN/1RYj/woxyB8fx6T5Wnl/O50UTzxArAZF3J70QTlGE5lWJARYVihMV1NRRq8WkCH/CFr/rujmW5RRWrvSQeknEgI+QcXpQ8zt9xB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY4vY09asHgYyDDAliTg5s2wLmFzg8o0YSVfP8bMTfw=;
 b=LMqm0lC89I3XXalooaWP26e1sm0l04irQdhP7TWHHvpSd8FZuGTOR87uodoJr7P9rNduDutahAT6pPCTLvH6o5jaAgy9ZFjoxZLmcJey/92j6t0S5SOfeeEh4Ncax4hVnfN2qiMxC2xky1wWRmK8ZsTv2K8LLlMLBGloRRK0mTENoPMSVIbgQ/EsQMQRIcF3ReibxoQWaPVizgGYBmFbqsIOd4RDJoaWPvFPxrPG3BC1tyvOECBIuj2fh6e0DcYnlj9u53nWicPfVPMzrsOVJ6eAdJsBtfkFMRIHljCBVp8EKIdK8YxFr2+d7I3MFUG5cKebRXjRsYd919+EQY156w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4vY09asHgYyDDAliTg5s2wLmFzg8o0YSVfP8bMTfw=;
 b=M8/Ge68EfPKhgl/jFbtrzGp/YbrRKLZs82Sp9VJEWsBUMQmM0ZG5QrRrftd9m1up4fRjxJfLVQqK4kzH9X1T1McusGcrM2NFk1sU/REA8UCFewpK9DO0iQPOqrH9oIa2ZXBJ77qpYGdoGnfX6BybaL1aMHweoX1vKn0OaGkz8vofvsyOnwyiupgQDKvqRkk2rmaeeX35WTtJavSoqxj1zBilp9hwMPBN+RS8sLK6qFIAAR0fmr+wKtK8xwrgOxnGb1ZrjvPHTY3K8f2Kte1LQKwfQBAjQrg3w5N1FxyT3GzgCA7Bfr5+qL6AfuwxvLNruyZ6kifzVh6Y4FCdDpmTFQ==
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19; Thu, 24 Nov 2022 08:36:25 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::67) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 08:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19 via Frontend Transport; Thu, 24 Nov 2022 08:36:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 00:36:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 00:36:12 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 24 Nov 2022 00:36:07 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <nkristam@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 3/3] phy: tegra: Add lane margin support
Date:   Thu, 24 Nov 2022 14:05:10 +0530
Message-ID: <20221124083510.3008139-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd3bad1-95c4-4fb2-31c0-08dacdf6f922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdRrvaD81VDrJ8Jkc4HZo8gDju2zNDfcF0V+f+E5hC+5OCSNRgFhKb5OR6mwq+ZWTjXCm5g5jvMYvmt0ubIUIxoKHTM5kb9eUlSisFMJkm4tCLzEV1l3/bfkSp7tnbypDih+wHtJ8JuZqe4uLL12uToY4mKWsb2yvZXX0ETTbQA6x0G1X14M4Dya9XhvAJirF5n5viCbdnVmi0QKZF5MWEYNTUu6H4w0lXHl+2SIb6fu67/UYmEuha0rxvTjJPjfeui3sVP816h+T+1OQsv//EYj3LAz8J/EzeMMzW1htH3VKcxF/TlglqDlXY3zv9zYC1NNz8hKqedNc9re31kprXo4diSC2tQATNqE1aQrZ/ynaVLfnpmf1H/fottTUwIMSazwUUfhwZlFSt2BHS82rwogDWnsJrR0gRLUrFQx33uLfezVP0mpBQ4r6WyanytOyX8lhCzBCjPQWKbcBypw9XXJcs88Q6XnqJ6bXt/GBK+zhzTf+Sz2E8Cz47VXw9/ZlFOjZrBwQWGbNv+82I8pEME39exUOEVClMD4tIxUG+Lhcj67CLg6uAnWMpYNpaYqdWeWgl0su7y9H3wzi+bTABd2L04RWgq02DWkCIAGd4YsJgeGiAOy4g7JEfj1wLodr+Bj2ylzsIA57wlo1TuReqW4gmAKbEu6bdqQ7rizWlSEJDizX6txl/fW+PPFs5jMkBijYevbKgxqMvv2kDzhIw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(2906002)(30864003)(36756003)(5660300002)(7416002)(8936002)(41300700001)(107886003)(6666004)(26005)(7696005)(40460700003)(186003)(336012)(426003)(1076003)(2616005)(86362001)(4326008)(8676002)(70586007)(47076005)(70206006)(82310400005)(110136005)(54906003)(316002)(6636002)(83380400001)(82740400003)(36860700001)(7636003)(356005)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 08:36:25.0200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd3bad1-95c4-4fb2-31c0-08dacdf6f922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per PCIe r6.0.1, section 4.2.18, Lane Margining at Receiver is mandatory
for all Ports supporting a data rate of 16.0 GT/s or higher. Tegra234
supports Gen4 and Receiver Lane Margining with per lane PIPE2UPHY instance
acting as a relay between PCIe controller and Universal PHY (UPHY).

P2U driver enables MARGIN_SW_READY and MARGIN_READY bits to start snooping
on changes in lane margin control register in PCIe configuration space.
P2U HW generates MARGIN_START or MARGIN_CHANGE interrupt after it copied
margin control data to P2U_RX_MARGIN_CTRL register. On MARGIN_START or
MARGIN_CHANGE interrupt, P2U driver copies margin control data to UPHY
via mailbox communication. UPHY HW performs margining operation and
P2U driver copies margin status from UPHY to P2U_RX_MARGIN_STATUS
register. P2U driver repeats this until PCIe controller issues margin
stop command.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/phy/tegra/phy-tegra194-p2u.c | 272 +++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
index 633e6b747275..a86b4af70ab9 100644
--- a/drivers/phy/tegra/phy-tegra194-p2u.c
+++ b/drivers/phy/tegra/phy-tegra194-p2u.c
@@ -7,12 +7,15 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
 
 #define P2U_CONTROL_CMN			0x74
 #define P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE		BIT(13)
@@ -31,14 +34,57 @@
 #define P2U_DIR_SEARCH_CTRL				0xd4
 #define P2U_DIR_SEARCH_CTRL_GEN4_FINE_GRAIN_SEARCH_TWICE	BIT(18)
 
+#define P2U_RX_MARGIN_SW_INT_EN		0xe0
+#define P2U_RX_MARGIN_SW_INT_EN_READINESS		BIT(0)
+#define P2U_RX_MARGIN_SW_INT_EN_MARGIN_START		BIT(1)
+#define P2U_RX_MARGIN_SW_INT_EN_MARGIN_CHANGE		BIT(2)
+#define P2U_RX_MARGIN_SW_INT_EN_MARGIN_STOP		BIT(3)
+
+#define P2U_RX_MARGIN_SW_INT		0xe4
+#define P2U_RX_MARGIN_SW_INT_MASK			0xf
+#define P2U_RX_MARGIN_SW_INT_READINESS			BIT(0)
+#define P2U_RX_MARGIN_SW_INT_MARGIN_START		BIT(1)
+#define P2U_RX_MARGIN_SW_INT_MARGIN_CHANGE		BIT(2)
+#define P2U_RX_MARGIN_SW_INT_MARGIN_STOP		BIT(3)
+
+#define P2U_RX_MARGIN_SW_STATUS		0xe8
+#define P2U_RX_MARGIN_SW_STATUS_MARGIN_SW_READY		BIT(0)
+#define P2U_RX_MARGIN_SW_STATUS_MARGIN_READY		BIT(1)
+#define P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_STATUS	BIT(2)
+#define P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_ERROR_STATUS	BIT(3)
+
+#define P2U_RX_MARGIN_CTRL		0xec
+
+#define P2U_RX_MARGIN_STATUS		0xf0
+#define P2U_RX_MARGIN_STATUS_ERRORS_MASK		0xffff
+
+enum margin_state {
+	RX_MARGIN_START_CHANGE = 1,
+	RX_MARGIN_STOP,
+	RX_MARGIN_GET_MARGIN,
+};
+
 struct tegra_p2u_of_data {
 	bool one_dir_search;
+	bool lane_margin;
 };
 
 struct tegra_p2u {
 	void __iomem *base;
 	bool skip_sz_protection_en; /* Needed to support two retimers */
 	struct tegra_p2u_of_data *of_data;
+	struct device *dev;
+	struct tegra_bpmp *bpmp;
+	u32 id;
+	atomic_t margin_state;
+};
+
+struct margin_ctrl {
+	u32 en:1;
+	u32 clr:1;
+	u32 x:7;
+	u32 y:6;
+	u32 n_blks:8;
 };
 
 static inline void p2u_writel(struct tegra_p2u *phy, const u32 value,
@@ -83,6 +129,14 @@ static int tegra_p2u_power_on(struct phy *x)
 		p2u_writel(phy, val, P2U_DIR_SEARCH_CTRL);
 	}
 
+	if (phy->of_data->lane_margin) {
+		p2u_writel(phy, P2U_RX_MARGIN_SW_INT_EN_READINESS |
+			   P2U_RX_MARGIN_SW_INT_EN_MARGIN_START |
+			   P2U_RX_MARGIN_SW_INT_EN_MARGIN_CHANGE |
+			   P2U_RX_MARGIN_SW_INT_EN_MARGIN_STOP,
+			   P2U_RX_MARGIN_SW_INT_EN);
+	}
+
 	return 0;
 }
 
@@ -104,17 +158,195 @@ static const struct phy_ops ops = {
 	.owner = THIS_MODULE,
 };
 
+static int tegra_p2u_set_margin_control(struct tegra_p2u *phy, u32 ctrl_data)
+{
+	struct tegra_bpmp_message msg;
+	struct mrq_uphy_response resp;
+	struct mrq_uphy_request req;
+	struct margin_ctrl ctrl;
+	int err;
+
+	memcpy(&ctrl, &ctrl_data, sizeof(ctrl_data));
+
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
+
+	req.lane = phy->id;
+	req.cmd = CMD_UPHY_PCIE_LANE_MARGIN_CONTROL;
+	req.uphy_set_margin_control.en = ctrl.en;
+	req.uphy_set_margin_control.clr = ctrl.clr;
+	req.uphy_set_margin_control.x = ctrl.x;
+	req.uphy_set_margin_control.y = ctrl.y;
+	req.uphy_set_margin_control.nblks = ctrl.n_blks;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_UPHY;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &resp;
+	msg.rx.size = sizeof(resp);
+
+	err = tegra_bpmp_transfer(phy->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int tegra_p2u_get_margin_status(struct tegra_p2u *phy, u32 *val)
+{
+	struct tegra_bpmp_message msg;
+	struct mrq_uphy_response resp;
+	struct mrq_uphy_request req;
+	int rc;
+
+	req.lane = phy->id;
+	req.cmd = CMD_UPHY_PCIE_LANE_MARGIN_STATUS;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_UPHY;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &resp;
+	msg.rx.size = sizeof(resp);
+
+	rc = tegra_bpmp_transfer(phy->bpmp, &msg);
+	if (rc)
+		return rc;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	*val = resp.uphy_get_margin_status.status;
+
+	return 0;
+}
+
+static irqreturn_t tegra_p2u_irq_thread(int irq, void *arg)
+{
+	struct tegra_p2u *phy = arg;
+	struct device *dev = phy->dev;
+	u32 val;
+	int state, ret;
+
+	do {
+		state = atomic_read(&phy->margin_state);
+		switch (state) {
+		case RX_MARGIN_START_CHANGE:
+		case RX_MARGIN_STOP:
+			/* Read margin control data and copy it to UPHY. */
+			val = p2u_readl(phy, P2U_RX_MARGIN_CTRL);
+			ret = tegra_p2u_set_margin_control(phy, val);
+			if (ret) {
+				dev_err(dev, "failed to set margin control: %d\n", ret);
+				break;
+			}
+
+			p2u_writel(phy, P2U_RX_MARGIN_SW_STATUS_MARGIN_SW_READY |
+				   P2U_RX_MARGIN_SW_STATUS_MARGIN_READY |
+				   P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_STATUS |
+				   P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_ERROR_STATUS,
+				   P2U_RX_MARGIN_SW_STATUS);
+
+			usleep_range(10, 11);
+
+			if (state == RX_MARGIN_STOP) {
+				/* Return from the loop if PCIe ctrl issues margin stop cmd. */
+				p2u_writel(phy, P2U_RX_MARGIN_SW_STATUS_MARGIN_SW_READY |
+					   P2U_RX_MARGIN_SW_STATUS_MARGIN_READY |
+					   P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_ERROR_STATUS,
+					   P2U_RX_MARGIN_SW_STATUS);
+
+				return IRQ_HANDLED;
+			}
+
+			atomic_set(&phy->margin_state, RX_MARGIN_GET_MARGIN);
+			break;
+
+		case RX_MARGIN_GET_MARGIN:
+			/*
+			 * Read margin status from UPHY and program it in P2U_RX_MARGIN_STATUS
+			 * register. This data will reflect in PCIe controller's margining lane
+			 * status register.
+			 */
+			ret = tegra_p2u_get_margin_status(phy, &val);
+			if (ret) {
+				dev_err(dev, "failed to get margin status: %d\n", ret);
+				break;
+			}
+			p2u_writel(phy, val & P2U_RX_MARGIN_STATUS_ERRORS_MASK,
+				   P2U_RX_MARGIN_STATUS);
+
+			p2u_writel(phy, P2U_RX_MARGIN_SW_STATUS_MARGIN_SW_READY |
+				   P2U_RX_MARGIN_SW_STATUS_MARGIN_READY |
+				   P2U_RX_MARGIN_SW_STATUS_PHY_MARGIN_ERROR_STATUS,
+				   P2U_RX_MARGIN_SW_STATUS);
+
+			msleep(20);
+			break;
+
+		default:
+			dev_err(dev, "Invalid margin state: %d\n", state);
+			return IRQ_HANDLED;
+		};
+	} while (1);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tegra_p2u_irq_handler(int irq, void *arg)
+{
+	struct tegra_p2u *phy = (struct tegra_p2u *)arg;
+	u32 val = 0;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	val = p2u_readl(phy, P2U_RX_MARGIN_SW_INT);
+	p2u_writel(phy, val, P2U_RX_MARGIN_SW_INT);
+
+	/*
+	 * When PCIe link trains to Gen4, P2U HW generate READINESS interrupt. Set MARGIN_SW_READY
+	 * and MARGIN_READY bits to enable P2U HW sample lane margin control data from PCIe
+	 * controller's configuration space.
+	 */
+	if (val & P2U_RX_MARGIN_SW_INT_READINESS)
+		p2u_writel(phy, P2U_RX_MARGIN_SW_STATUS_MARGIN_SW_READY |
+			   P2U_RX_MARGIN_SW_STATUS_MARGIN_READY,
+			   P2U_RX_MARGIN_SW_STATUS);
+
+	/*
+	 * P2U HW generates MARGIN_START or MARGIN_CHANGE interrupt after it copied margin control
+	 * data to P2U_RX_MARGIN_CTRL register.
+	 */
+	if ((val & P2U_RX_MARGIN_SW_INT_MARGIN_START) ||
+	    (val & P2U_RX_MARGIN_SW_INT_MARGIN_CHANGE)) {
+		atomic_set(&phy->margin_state, RX_MARGIN_START_CHANGE);
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	/* P2U HW generates MARGIN_STOP interrupt when PCIe controller issues margin stop cmd. */
+	if (val & P2U_RX_MARGIN_SW_INT_MARGIN_STOP)
+		atomic_set(&phy->margin_state, RX_MARGIN_STOP);
+
+	return ret;
+}
+
 static int tegra_p2u_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct phy *generic_phy;
 	struct tegra_p2u *phy;
+	int ret;
+	u32 irq;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
+	phy->dev = dev;
+	platform_set_drvdata(pdev, phy);
+
 	phy->of_data =
 		(struct tegra_p2u_of_data *)of_device_get_match_data(dev);
 	if (!phy->of_data)
@@ -140,15 +372,54 @@ static int tegra_p2u_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
+	if (phy->of_data->lane_margin) {
+		irq = platform_get_irq_byname(pdev, "intr");
+		if (irq < 0) {
+			dev_err(dev, "failed to get intr interrupt\n");
+			return irq;
+		}
+
+		ret = devm_request_threaded_irq(dev, irq, tegra_p2u_irq_handler,
+						tegra_p2u_irq_thread, 0,
+						"tegra-p2u-intr", phy);
+		if (ret) {
+			dev_err(dev, "failed to request intr irq\n");
+			return ret;
+		}
+
+		ret = of_property_read_u32_index(dev->of_node, "nvidia,bpmp",
+						 1, &phy->id);
+		if (ret) {
+			dev_err(dev, "failed to read P2U id: %d\n", ret);
+			return ret;
+		}
+
+		phy->bpmp = tegra_bpmp_get(dev);
+		if (IS_ERR(phy->bpmp))
+			return PTR_ERR(phy->bpmp);
+	}
+
+	return 0;
+}
+
+static int tegra_p2u_remove(struct platform_device *pdev)
+{
+	struct tegra_p2u *phy = platform_get_drvdata(pdev);
+
+	if (phy->of_data->lane_margin)
+		tegra_bpmp_put(phy->bpmp);
+
 	return 0;
 }
 
 static const struct tegra_p2u_of_data tegra194_p2u_of_data = {
 	.one_dir_search = false,
+	.lane_margin = false,
 };
 
 static const struct tegra_p2u_of_data tegra234_p2u_of_data = {
 	.one_dir_search = true,
+	.lane_margin = true,
 };
 
 static const struct of_device_id tegra_p2u_id_table[] = {
@@ -166,6 +437,7 @@ MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
 
 static struct platform_driver tegra_p2u_driver = {
 	.probe = tegra_p2u_probe,
+	.remove = tegra_p2u_remove,
 	.driver = {
 		.name = "tegra194-p2u",
 		.of_match_table = tegra_p2u_id_table,
-- 
2.25.1

