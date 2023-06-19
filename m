Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846D7351F9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 12:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFSK0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 06:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjFSK0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 06:26:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A042FFD;
        Mon, 19 Jun 2023 03:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqisWt8jN0b28QM/TbPwJc6tZbHffCrDAmLeNzESiHPQuVkKctJQjlPps7XFhSV+B1T2YIOi1wgbHuQVI5TXVwykNCh6Wta+uB48V1/wmi8kH32k2b3tTu4G3e6qCi3+sgNb/Cve3RrAPVd8q10Lf27QIi1Mg9YeelKO3bqB+H2i2xl87kHkCUeTW8Npv88xZ5ubrAz4ua8D76+/gJrenBh9UumCNgLR6owuW4foOl9trJFatGEIhNWtmgX3cxxK15UgWQ/c8aR13ekXoPgEZuyTFznGYUeL/tQ1vIpfKUVohj5jAZBDpoZ2FqlUHrPQKZF5ILAf0TIz2T7r4nZEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H28MgyNt1CF9P2tWsSysfPf3L9D1hgonlCR4ys7mQSk=;
 b=hvpyiVIh4rb6uS0rk82HOqxFVNYoAP42KYjqrWTIg4Po5ela9I11Km0fg+BcNqHz9/rv3ws1nrdEtDp6ByEMjva4XXJBCfEt2iTiT3IR3b0U7rI9CcIT6RAm5idG2nLrGfnanvgmfgYkBpzWThnnZpLyh3LOJedeZRtD1BB9kPBs9Wd+AkG/1fYiujWKEXivRgVAWzriQ+FmYK0zleqJg7XeVtCWvYVzUlyrKAZ9aX9aEIc1x8P5/Mw0FJoSYa3QdQeFZn0qqXhwoE0dA+zrCY7IxRhaUxwcs7kyjgxgqQ1pyHBsgr61xNtnPNTfwLZlC17wWLe0kfS2qHlyuqBcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H28MgyNt1CF9P2tWsSysfPf3L9D1hgonlCR4ys7mQSk=;
 b=uJ/VydoyVsQJknJeeWpr+jd3gK9nxOKVAw6P8TbaH6bigUNolGuvAiH3Lf/QQycN7U0CInpYPrD2n0XFqbAAwTBolkWTfHh2x8US9rL/VbSZ20Waa3e/8OfIQmRTHKceMuEi1mTk6+2oykOyyxCJkQG5qvqIX0dZy87ggGm33ByZARFqIUzTihrnrNMGWvR0krqmwwDgKYiCGsIkoLLIOniVuV5QIu1rZ3Wp2dodXKRa7oVRuAHZZAHQCiJuNW85BYJrP+cxtqnmHwhc2pTzh5fwSu9qqh5vcY6U1CBAHxYFRZ2odcLb0mcovekFH7pCtG/pHZnJyUkdQSTpasDe3w==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 10:26:17 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::d6) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 10:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 10:26:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 03:26:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 03:26:10 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 03:26:06 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Sergey.Semin@baikalelectronics.ru>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte payload"
Date:   Mon, 19 Jun 2023 15:56:04 +0530
Message-ID: <20230619102604.3735001-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619014218.1970846-1-vidyas@nvidia.com>
References: <20230619014218.1970846-1-vidyas@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5eafc7-be32-4169-eb1c-08db70af9daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThXyNcdU84QXOCvOpM00q5rB5UwqGZsUVlDWJL6vwy2NRw475fYYLbdpKTGTyKerpv9iOsw25qN5NN2R4ctz6C8KGvKIU1Fa7V1jhgGQjwJLkFIQAo/mabkhg89LjMEKjIx+F+rrmiCbevOc8DW+KDB1/Bwwm78cdnt/ZP8VVGuhAAmt/7t28bssz6zvrMJyGtl+6fkzSKp4AOFneYbCKEYI+EQ3W23dQAYuFQxjYXXrTQhvNxmbfjzgbod3inVl3NkN8W+91HGJ38dlWxJUvXls+rdKkt2Dv8EheM737Lwc5Yj91sFvDrB2aDwRSYXARrkvmXh1q08pfrdGCds1fa1S5CZy7LSrjffzMBgmHjSYgtGmidFALkoKFE0CyX15xU6ShCeH7DpRtdL5safvgQomGKcPOMLpZBfLMDr8OciSY98kD6z/GIN66yB4/e1dnucv+WK6KNwOJV2W8puG8KtVcoH4n4gH31/FT2UUpEb9a5koY8S6vhdD5P/waKwbAhC4iXcTjpHPH4h72hJEEsLbofjJIcjJpetolQyxpRkTQghDg0mtvE9WESE8uXTkovtYzTyM2WE3oRKQYS2Da6iSAIMqi1Lz/bu7yIiG049swsbIR/775ifcDJPDpIYlXE/7X9ygOiOrh+SNbgWfc7XmuXs9Rwj/rJdxjkI+bvQeGwr/F7+yRy7WOBm2GuM0+BIuGguty9Z0/3qeHNmlYOBt/jYO2utNHVY7ESiFpaY5pYoWxSzApQx/QIlpvEHY
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(7636003)(336012)(82740400003)(1076003)(186003)(2616005)(36860700001)(426003)(83380400001)(7416002)(47076005)(40480700001)(26005)(8936002)(41300700001)(8676002)(2906002)(5660300002)(4326008)(36756003)(478600001)(7696005)(70206006)(70586007)(316002)(40460700003)(54906003)(110136005)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:26:16.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5eafc7-be32-4169-eb1c-08db70af9daf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
support for 256 Byte payload").

Consider a PCIe hierarchy with a PCIe switch and a device connected
downstream of the switch that has support for MPS which is the minimum in
the hierarchy, and root port programmed with an MPS in its DevCtl register
that is greater than the minimum. In this scenario, the default bus
configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
MPS settings in the hierarchy correctly resulting in the device with
support for minimum MPS in the hierarchy receiving the TLPs of size more
than that. Although this can be addressed by appending "pci=pcie_bus_safe"
to the kernel command line, it doesn't seem to be a good idea to always
have this commandline argument even for the basic functionality to work.

Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
Byte payload") avoids this requirement and ensures that the basic
functionality of the devices irrespective of the hierarchy and the MPS of
the devices in the hierarchy.

To reap the benefits of having support for higher MPS, optionally, one can
always append the kernel command line with "pci=pcie_bus_perf".

Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Fixed a build issue

V2:
* Addressed review comments from Bjorn

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4fdadc7b045f..a772faff14b5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
-	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
+		u16 val_16;
+
 		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 					   PCI_EXP_LNKSTA);
 		val_16 &= ~PCI_EXP_LNKSTA_SLC;
 		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
 				   val_16);
 	}
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
-- 
2.25.1

