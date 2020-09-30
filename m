Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0B27DDA5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgI3BQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 21:16:55 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:9280
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729540AbgI3BQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 21:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQCb85wX/UREw8OK7cKNCSNmteV20Pl3mYJ3uGSGWUPbwROMM3NDKuDIzTLXoOUTwZ/gSG3VpShHK9F+Bn2MgHvvFQh4Cp+NfA0OvyNZAMHxXC7E9u45XVJESSNQTUyS8CIWFmw+xcU7BwkYq1rIGNEHZ/Zs5oLQjgNdXmhSqYhDypAgU4iFq9Raz2+5OjzLjXV6R98rpnPiXrKqsfiv4bLzsWcIv6YdMOQZxPU6fVJDqnOSjTuLLcSnYNkYe3s3antHkVEliOKDcYmx3tewlKjCHWwlxgeHfT5bBuadsaukZuz/GhpBSfsS0n5fv1IMz2MxY1plHzQkY3XPtCXhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIXixqAtYdnYAUnsl5z+k2g9dRYqvW+KDhC8Wv4eYoU=;
 b=Z8iGhk/iwHwIlsBzmIa6VHNoqyxC8VOC2OmBeHu2OOVQPNGSfppLzBHrMOGgGeoQgx5DnsJdtDxecMxQkbtfbnHqUiGiM0sQRgYar8/v/ZPIyIAz9fnfMa+IqeFhEdDtEOb8fWXqR/TOuX0oSU4ou110NcEVKkyuz+lj1RFqFU5XvOF8wrJfXK8WE2smdLEZobIwBrBcDo2yDI5v1bxv8zGAnyPJGnMQhFuZu78xpw8713ls5BLVACzienTL1nKfi3vS5x3UF0AVS/tyOn+dXFdcDSMZ/OcOFsFmkp9mtMgcEEKlB0VhMp4jhmAxqRpE9FupJdSJCuV0gCkHGtNa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIXixqAtYdnYAUnsl5z+k2g9dRYqvW+KDhC8Wv4eYoU=;
 b=G5Wu3uCAnsDeux9fu6jpTzHWa17Grkapu8/pq+TUQVojaeRczzZKhqqu9Tvp+X5sc3ojKsHYn25wDlhr0W6M8lfRcK8N7iuanqhV+DNWgQMbSsf8ZPTlwgBt2gWlz1XMCdTH8N7nJDqYhK0rfpvm2IaGvQ8Gdd5Tu/1i1/qaEb0=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5145.namprd03.prod.outlook.com (2603:10b6:5:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 01:16:52 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 01:16:52 +0000
Date:   Wed, 30 Sep 2020 09:15:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
Message-ID: <20200930091449.50ae0caf@xhacker.debian>
In-Reply-To: <20200930091205.792d6c7c@xhacker.debian>
References: <20200930091205.792d6c7c@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Wed, 30 Sep 2020 01:16:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd0b23b-382a-46e3-37e1-08d864de8376
X-MS-TrafficTypeDiagnostic: DM6PR03MB5145:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5145A58E2072628BEBB4BD81ED330@DM6PR03MB5145.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHfnJcHzzM0VjXdlT+ICELsM1QRu3+0rGF3g7jTWY1A6bcPWWPTzwCcQCPyLTIOfhyXsMg2NQty05/Y42IAomINTQUgIL+WTXDv16hBRQknlHGLDkQYGUyEpYQ39Nwzww8KeW1FAzd6diHy4XI1TYswB31ZG7yt/et+4cjYT2c38hwaf7x/JWi3iLNVyw9rIsTYvO5GJ/L0mBRdhe3xLV6KznC5NDnYcgRKbmYI9d7v+nD30YFM2yEWHNSE6k3hMS2htH+HO+r0u9wv9DiL9Tr4I9POGVn2bZBg3iLGogwJI3KFvdTiJFua5a6f2gH/u/DlpNe5Su/TToZj/K/PF6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39840400004)(366004)(396003)(6506007)(956004)(55016002)(5660300002)(6666004)(8676002)(15650500001)(4326008)(8936002)(83380400001)(478600001)(110136005)(316002)(66946007)(66556008)(66476007)(86362001)(1076003)(7416002)(186003)(7696005)(9686003)(2906002)(16526019)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iW2j/SYNugyLNGB7Qf9RsoNv58LmStQYLs+mW7C2a1Sq7TuAp8UDsJXDWourJeKaY8pXf5Z/YDusEzJqEUTPqENf7CfdTnXfDt7O8qusKckGDNXoPz4zGeA8kUo+lqLIp4iNOUOzT/SjALJLFy0x5KUGaDwDcXwI30enS3agvV7cmc9mS+M7U2Vpulv3M0err6lUJlV70hfjvv6U80O3OS7DKBX1+nl8ITg4jyn2OhKtX371WW/uQ8aWAzSHaauoXoSzeU4OkTphLNlc1S8uaqcUyd7MxvJYayHSAoZ3AjNBDQFlxqkduv1C+gtJc6eN16YMCk+0gCjFOMnPlTng32Aq0LJDPlq3DQkuSLIzEm4Dfu1D/MdOphq8UJ/9PKJkhH9hgx+AOFFL/1oklT1fyPk2x4UbVL4B4lJ+CMY0175pI8vOpET7Otv3P3oOnv1Qavdb0JXrP6+UAm9hwIva4isqD0wMH1kV9VQ+/vtvkTJf+DCdku1NgcTBvOxJbTv/IEl8TAINppOF881IIgysOwFszD3XQ4e68Z6+msQcIipjDQzh7F1HufZE1t3f3XpA6+O3a0iee0TcuhWhU5025nAEvD5Ry6+0LEKyOoYrLRx+1YcTGqn/wxc7U4BeRhKitq7u3Uyyvjup2IDa5OLaAA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd0b23b-382a-46e3-37e1-08d864de8376
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 01:16:52.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnI8bDikFP6wEJfJw611qCMucQ5PqeWSfNNNcBxTiS8qoqhun+VZILvlXhPr/Tb8GS06DSjXCOSkSe0Rzp2d5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5145
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, dw_pcie_msi_init() allocates and maps page for msi, then
program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
may lose power during suspend-to-RAM, so when we resume, we want to
redo the latter but not the former. If designware based driver (for
example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
msi page will be leaked.

As pointed out by Rob and Ard, there's no need to allocate a page for
the MSI address, we could use an address in the driver data.

To avoid map the MSI msg again during resume, we move the map MSI msg
from dw_pcie_msi_init() to dw_pcie_host_init().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 32 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dc387724cf08..a0b2deb7f628 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -490,7 +490,9 @@ static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
 static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	u32 ctrl, num_ctrls;
+	int ret;
 
 	pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
 
@@ -506,7 +508,21 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
 				    ~0);
 	}
 
-	return dw_pcie_allocate_domains(pp);
+	ret = dw_pcie_allocate_domains(pp);
+	if (ret)
+		return ret;
+
+	pp->msi_data = dma_map_single_attrs(dev, &pp->msi_msg,
+					   sizeof(pp->msi_msg),
+					   DMA_FROM_DEVICE,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_mapping_error(dev, pp->msi_data);
+	if (ret) {
+		dev_err(dev, "Failed to map MSI data\n");
+		pp->msi_data = 0;
+		dw_pcie_free_msi(pp);
+	}
+	return ret;
 }
 
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f08f4d97f321..27bbeee5718f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -288,26 +288,17 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
 
-	if (pp->msi_page)
-		__free_page(pp->msi_page);
+	if (pp->msi_data) {
+		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+		struct device *dev = pci->dev;
+		dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
+				       DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	}
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	u64 msi_target;
-
-	pp->msi_page = alloc_page(GFP_KERNEL);
-	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
-				    DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, pp->msi_data)) {
-		dev_err(dev, "Failed to map MSI data\n");
-		__free_page(pp->msi_page);
-		pp->msi_page = NULL;
-		return;
-	}
-	msi_target = (u64)pp->msi_data;
+	u64 msi_target = (u64)pp->msi_data;
 
 	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
@@ -440,6 +431,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				irq_set_chained_handler_and_data(pp->msi_irq,
 							    dw_chained_msi_isr,
 							    pp);
+			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
+						      sizeof(pp->msi_msg),
+						      DMA_FROM_DEVICE,
+						      DMA_ATTR_SKIP_CPU_SYNC);
+			if (dma_mapping_error(pci->dev, pp->msi_data)) {
+				dev_err(pci->dev, "Failed to map MSI data\n");
+				pp->msi_data = 0;
+				goto err_free_msi;
+			}
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f911760dcc69..cd9e76904c58 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -194,8 +194,8 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
+	u16			msi_msg;
 	dma_addr_t		msi_data;
-	struct page		*msi_page;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-- 
2.28.0

