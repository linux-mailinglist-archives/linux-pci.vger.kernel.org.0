Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D868D5FE1EA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiJMSrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiJMSqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:46:23 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873FEA6B3;
        Thu, 13 Oct 2022 11:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8epMa7xtCYI5wjfLUpvszLjo2LKUW8lZTWnxnZ9H3yg1hSLXvzzmW52Yi6lbfwlEgYNNfxTNzSXpXJEbhtmA8ouSc5UXAZwKFJb9G5FLAdq04xTby0RC3+V4D213bC3OBqMsVmuqkNE7RKc0yPjr9/toTnIeQW4T+6IqFEg64qL5CmPVqOSe9VzUSofFX5uHyfjzLaaEDzKHCA+2OQS06kuJxYvQQ5moJOkRkMLuZfmta3uH+Cjw/gi2mIYhUhLl9qChQ1ohJiE2QOsj+BhFrjEQ8jQigHm4CZ3YtKdLRfQhcHpsoFhTD8zY7GlJEM6XXrfgqMTyACqFmrVIKOvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do7jFBBJDjTpxwmlaFOhTACn7os+1N3Tp0MI+EIdnpo=;
 b=FcNgGsnoOElBsuktozZn9WaMuNZB8tUxiTmwe8CSYuDvklhtHbu+yXjRt0jcAUutF43hUVq6QT4SM6bJ+bfpLJ5w6IjZRhptp+0CsPKw02oJnOeQ0IG4bD+WFRyF8ITI08Vqngl5WYYhyI62IIteTY89ZR8LKL+4SCCef4xgww54B9naYzPwPRXdIawQMZEybQbhkVwDkETRLHnabfTDEpL1buB4vAOUiT8E9Abq/Wr8W1F5KKdbReZL9EfDzMRX63dN5pxUKnfmlT9vTnKXZDPfYGQCJOG/+Iuz+b4SnDBcvkjHXdpzCyF2LkvzfVyjtgurrHALu8ptEWG/dQbvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do7jFBBJDjTpxwmlaFOhTACn7os+1N3Tp0MI+EIdnpo=;
 b=IHW+LJJLVCjvQKe8JJEuT9RIswgqedh3bLFqUUyV/5hrP85xdmvEhgE4ZD3/j1yPDEaYyVbfarFrzAkNrx7vnBaRsIddUJ0rF+EQhldQZHeyQ+v5Pb095QwNx7aAkkHh64XwBK9Gx+9N1qH+35xY7LontMBvaTcKg5z30m2AXyy+5sb7HNhAonNbZo/9wign74JQ5AiV0ABTG3+pOvsGbhKc+hNJpO/14i3YGm3AJcI+gj/rVVKYbKV5MdIgiaUK0xpgbW7kii1aKAr5BMuR43cUo/yp0tepkeweR9jFmdfxDuWtcKULbG5N4W0pSERcGWLuc7ryJSU+TP+C5u8gpg==
Received: from DM6PR02CA0153.namprd02.prod.outlook.com (2603:10b6:5:332::20)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Thu, 13 Oct 2022 18:40:58 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::68) by DM6PR02CA0153.outlook.office365.com
 (2603:10b6:5:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:49 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:44 -0700
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
Subject: [PATCH V3 16/21] PCI: tegra194: Set LTR message request before PCIe link up
Date:   Fri, 14 Oct 2022 00:08:49 +0530
Message-ID: <20221013183854.21087-17-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: fe24e336-400c-4a5d-ee96-08daad4a7887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DypQODxzsh8gH4lH/AQurPZOJSxuF4+ATA7rs16tgQvmGWLnwNK3LgZrF7EQgOiSuMoL7eN6YXLhRt4RoGNig5RpO3TTxCaU/WAnYfsNbV33Iw7ex2jvhhi/33EWZx9lHNKjx85Tewl5ivDfANiPomOWb+JSjcGcjzS+Bs+UbfAeGAdW4hrNvI1ht8rw+kBErLrmInenCFkgIpw4wxTzYZ7jvABs1pqyKyMrUBsiQrfmiVecoSa/wYGnSlFH+cN4d+lfU3GCwTfCNyNF4a6lKjw52OOJPkAcI2aNrpEZ0qMPQsLbujSHfSJdFi2THi87UIBHeCNhk5b4Bffgeu97oPCe/UF6D5OcG3FX950Sfg3U25xkLc+RSHYci2LbBPm97WwO9yt4oE/e7nql9pzHeB2I/d5cg4b1cLnydat0q+Opei2B0MB46D/22RanzmrTCuogyqXbMDVcJv7DH/nWhTJPcOoc/SPQ9Y6ek8pvGu43Pl+HnqCIQ3ARLC3JT5cqBksZBlPWToXB3ih08uKqCxAgwqiIqyoEjCPwimmKvxXUuSSuNZPIQoKCbWx7JimreLyR6FYK+tNhGrJgi8BpMsv+UPpIH1X9mx2eaBevPe6eLSEKfmHuUVg/0riYIZ8rwuQtF+VT20r1LbiMQ840HjlmtywOlb5WTaG8N0tzt+itRKhHhIGV0ueXHBvEFkDcGox5AmazIGEiGIOv7uIyqMUtgmtsW98ptmYrECE0CbvjBRzSfWtYP+p1NOw8uv6UzA+FeR61Ll7VC5hqH4l2upokG/pxihf+CZPwcDOdLU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(86362001)(7416002)(41300700001)(7636003)(356005)(5660300002)(82740400003)(186003)(40480700001)(1076003)(478600001)(8936002)(36860700001)(8676002)(82310400005)(4326008)(70206006)(70586007)(36756003)(40460700003)(26005)(316002)(15650500001)(336012)(54906003)(110136005)(2906002)(426003)(47076005)(83380400001)(921005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:58.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe24e336-400c-4a5d-ee96-08daad4a7887
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LTR message should be sent as soon as the root port enables LTR in the
endpoint. Set snoop & no snoop LTR timing and LTR message request before
PCIe links up. This ensures that LTR message is sent upstream as soon as
LTR is enabled.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d592cf68b02c..23ca97401339 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -493,11 +493,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	if (val & PCI_COMMAND_MASTER) {
 		ktime_t timeout;
 
-		/* 110us for both snoop and no-snoop */
-		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
-		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
-		appl_writel(pcie, val, APPL_LTR_MSG_1);
-
 		/* Send LTR upstream */
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
 		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
@@ -1951,6 +1946,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
+	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.17.1

