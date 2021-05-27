Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43A392D3A
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhE0Lym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:54:42 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:54784
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234438AbhE0Lyl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed2clBuoQ5RiyRlTWQQudQrDvVSHTr+hdE7Ql0EYyKfmkH+hMQuIB7X0ijv7b+yJ88kj10KcsgGw7rSViJ6s6/HYDFFTxBS7Y7Bu9yhczrZIe+Y7QoLApHN3GvTS1ePbbNiPARLk3pxoBTqDpsdHukOHddyx6fBqPUtqWc8QvMNAtdK24UljI8AIqUFvY/jD5MhoWvDdRVyuzGrv4cfouGp36tK1Gu5som3PYdsFb2chzl1D7Wq1Bpc2E/x7e3n0UyiL+IG+PR8fQovHJ+Edb9tGjlF8tdw6Ldgd7T8wftVrPyTE7fCRLxzOm1iRUpPOxlfVkrbmsB26zII9kWqkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHkDEk+PXRjNch4/r18GUZQOtmmMvUrKeYwS6LPpo8E=;
 b=JJqFON5WqrPT/KI5pxprNc1S5gdqhZMSbFqZib+iIGxKCqIdEoyMTk4C8JI/0k9AeRiZkKB2yQlGpPbXTVdCceC8Er6hcon6WtRafuIrXpSjneEDpLd5ZSdvG1PBGIYOnvHSoVxk8oo6uIkByZoAxgKIfZiZcpdkkvYaLQGR1b7wbgEwL10jRwq2WgBHonz4hyJcbim5HlUIBfvjYFtgJXMnTD0K7Jylo+Wl9GD/fkjMYpi/NjuV1BRHQ6Z1YVU2gDDxdir4gR61JHJqdoD35/Dw4DOAtpTeP/sywrrRzY4x0xBq1CctGvTRxKl7CM0O8NPpkUgHWOMDg5WrSnuwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHkDEk+PXRjNch4/r18GUZQOtmmMvUrKeYwS6LPpo8E=;
 b=bmziFQ3nYdQAju2Su4zJV+8Yzst4mjy1VajyGmnzr/Fqs8M5HVbPCLtal4vDHsC/+tb5o861NoTNCzwrmog3JbCBvlm9J8mq9px6OcdytA2Xoh71teAgB17xwi1BxifwXFm/l9UH7KoDS+fCZD7VWyna3oUg768vh5Ykg2bruc9ZayTXq72UEuuBRmdA+D5p45lDn6+F1v4LlCX5HhiovbIhxp7/6rvtEL+YEkUFWVOTjfeOpooqKx5b+ujCTogP9UimpdoD4/qq9HUXAMbGeVV2TrrV6iaGo13NMwsOuc/Hazu5LjjgIBsM2xUvKAdvUfLF+280H1Mfrl4rygsMew==
Received: from DM5PR04CA0058.namprd04.prod.outlook.com (2603:10b6:3:ef::20) by
 DM5PR1201MB0156.namprd12.prod.outlook.com (2603:10b6:4:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 27 May 2021 11:53:07 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::2f) by DM5PR04CA0058.outlook.office365.com
 (2603:10b6:3:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:53:06 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:53:05 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:53:02 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 3/5] PCI: tegra: Disable interrupts before entering L2
Date:   Thu, 27 May 2021 17:22:44 +0530
Message-ID: <20210527115246.20509-4-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83425fd2-10ff-46e1-6503-08d92105fdeb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0156:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0156E65E14967B31B47D99BDDA239@DM5PR1201MB0156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EWQOUcJ+s13E8skETGJgcn42W0F4n+PhBbVz08SB8mfclRUSYt8ESDELRGvaDnvBcuyW2O92L+UH1UinMQETHrZVGzYdRnKrOYSLHODoHCSnB1jMXpPdriHRMiQH8uHIs+PyJU4KyWaZDqmXnbsq6rvyLh51yW9CznL8Ho68swl36gFE4gz4HG0rTLBmHUlx2KpVTd5lJkrVthf7HWwdGsgiaXm1TMZN0UbLNYA9SQUT7YPUq4UorzseNi9fPUsZarK45xcydEJiZl2qwkqiPvZLRxtZIbl3m0v8UCbOcpIctmnyDbqsfU+gwlNE1dRBvgQ6hltjslEKsY4TIqza0kvdx5Z10oWt30MbVB5mdkZRHPRq1LuON+e7zNbKfOQChvZEkW9o96UxjA+W67yRVtGkIQLFggOAd41AF8QQrhhetLFAxGI0NJw9rWmwneJM2eiJrjApV0fO7sUMl0og/KmblzKP7Ut5Ndq32USpfPO3V73kHeGLfp7M9QoYJT3gOTEEZJeKEtZzWcd9bQBppi1OprZIkAMydsIKqBMQiikr+TOV6Fsix5/iFcqVtlEquOA+x8MSBRvgeEe191oJflApRRabRqAEPr9U+V0BD9CgDY0TVehG0M6aAuOmERXy6y/Nb2+t5hHya72KBA0lh8it9dQ4bBwlOP4I0sUEmQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(4326008)(107886003)(2616005)(6666004)(8676002)(336012)(1076003)(426003)(36860700001)(356005)(83380400001)(82740400003)(70586007)(70206006)(47076005)(7636003)(86362001)(82310400003)(478600001)(5660300002)(36756003)(186003)(2906002)(26005)(8936002)(6636002)(54906003)(7696005)(110136005)(316002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:53:06.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83425fd2-10ff-46e1-6503-08d92105fdeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0156
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 implements suspend_noirq() hook and during the system suspend, the link
is taken to L2 state after PME_Turn_off handshake and if it doesn't go into L2,
PERST# is asserted. It is observed that with some of the endpoints (Ex:- Marvell
SATA controller), the link doesn't go into L2 state and asserting PERST# results
in Surprise Link Down error and the corresponding AER interrupt is also raised.
Since the system is in noirq phase, this interrupt is not served. Both PME and
AER interrupts are served by the same wire interrupt in Tegra194, and since the
PCIe sub-system enables wake capability for PME interrupt, having a pending AER
interrupt is treated as PME wake interrupt by the system and prevents the system
going into the suspend state. To address this issue, the interrupts are disabled
before taking the link into L2 state as the interrupts are not expected anyway
from the controller afterward.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 58fc2615014d..ae62fdc840e6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1593,6 +1593,16 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		return;
 	}
 
+	/*
+	 * PCIe controller exits from L2 only if reset is applied, so
+	 * controller doesn't handle interrupts. But in cases where
+	 * L2 entry fails, PERST# is asserted which can trigger surprise
+	 * link down AER. However this function call happens in
+	 * suspend_noirq(), so AER interrupt will not be processed.
+	 * Disable all interrupts to avoid such a scenario.
+	 */
+	appl_writel(pcie, 0x0, APPL_INTR_EN_L0_0);
+
 	if (tegra_pcie_try_link_l2(pcie)) {
 		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
 		/*
-- 
2.17.1

