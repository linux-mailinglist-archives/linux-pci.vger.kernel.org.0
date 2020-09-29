Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5F27C281
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgI2KgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:36:11 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:2880
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2KgK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNr3R4kgHQ+0In2grDv5NLYRmpFKpyuD0MYmzu0gIxqyhamFuGDf9zBRv076iPCUb/qqEL0PA3LovlvRiSNkh0ZcW5iv2xJmkTIHD6dX8Z2en4FpzFm0ysQoY+16P9IKzd+84TnFsrO4iILph5odsQJ/joqO4+mC9G6+kP8WWb1Z+r84xFWlyBQd5Wbyp6DiYSmLZ6BGb7VM9V1XBr9FcHj+5kkhs6jzfcyRMHmAo88V/7Gu0tgpRqRL8KbDi1Qoq6KG6Ciq3MnAQtPAU1OUu6I0Ns8KCfjaII8cix7Mz4xx+bK2RJuz6fXM/1FCbQzqkimaZjed5GqDiQxVdkMABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLsmRuocSYHjRDfMW+H3OrXPClDCOufHTKyMVD6zYqM=;
 b=SgDr47P8m+76FoHQXJ3fcYazTH0SFReDlFUHLYjcR49+hPZEdUYl8XuRtUtTFyOUrNjM6gcbeYR5J7s8vwCQbBgi6sQ48scBvP0spHTdfe4JRpNZhE3g+57BG1cmN9PUsuIccNr86nVBeIErFU4/dUQiNGyYzXyR5EjH7vWBMu7wD1dQJRXRPooQXqtHvnx/cnUgAqnLlX3/cjjIHGeT99+MGm5T9UvjGJthOEiXFGuEsiopM1TNUn/VcXMGG+IjLKfT0jkf8CFsI3GFHQw9QsVHlNE5intxM5JLpsmmexR4JUHOc1V5HKv7xJNSul4ifksEWZ+klK2Ax1hwKFj8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLsmRuocSYHjRDfMW+H3OrXPClDCOufHTKyMVD6zYqM=;
 b=l9xyB80WwENpAQKt+/Q03mSUDvMu1wM+bR/Nz3n/3nAHH0/pXjHw6LKzwAva7tZNo4kA1F27ORQNHuNUuSa0uukf9NjzTRW9j7Yq4wMZzNBXJljK9kJyK39nt9MxrhnLG1/zsJjg5B0F8kWUda2x9+n3UyNdhHVQ9mLfn9Um82o=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5292.namprd03.prod.outlook.com (2603:10b6:5:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 10:36:07 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 10:36:07 +0000
Date:   Tue, 29 Sep 2020 18:34:58 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
Message-ID: <20200929183458.37f91a38@xhacker.debian>
In-Reply-To: <20200929183403.060d1853@xhacker.debian>
References: <20200929183403.060d1853@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::13) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:36:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92883639-5d06-48b2-25a1-08d864637920
X-MS-TrafficTypeDiagnostic: DM6PR03MB5292:
X-Microsoft-Antispam-PRVS: <DM6PR03MB52924CD234AE3414D6F95BD7ED320@DM6PR03MB5292.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i0HGzLOkqZ78x7yuvzSXEPxkmKD7l8ntVbsE+jAEhGi0nAuWpx5H8hRm8QE51nNs2umflTnbrPjXulGyGaydiCjJtmFFlXGCU+BFgqR6ESPy5S+UlxElv2kroBlNl4iD7MP2SYyzjNZ48f42joEqxugxx6F1S3Y2IF1a4u1EEHaCFHiN8w5VC/Ihrsqzc7mNlaTkxzDU4KBv3d6uJw14CQUsKX3caWaFcVL/h+5ZTwM8nt+G7FJuWCF+JIM49VrLj3Ab/d4vO/CwhcU37llsARRV3hAFbwe79uAa34hjyJ82JYmpFAW1aEZZB7kseO6/pO++gULiMpwvNY5aS4Lrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(4326008)(6506007)(186003)(8936002)(16526019)(26005)(55016002)(9686003)(8676002)(7696005)(52116002)(86362001)(66946007)(66556008)(66476007)(478600001)(5660300002)(1076003)(6666004)(956004)(110136005)(316002)(15650500001)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: s7Jsrq+yUJhYXOfNrHXQapgRyOzicXleWYUScjoGl07WeSzGpq59cAWnSNJmYEhnVu+zLmUkEhgTYoulIrODRSna9HG+tK5lcClK8h0RMY7Jlj7A6DN/BBq5M4EPGxY2EUM4e1uUaDi9guNfHuPTCh+yd8gcpeFz1/+jqKAhQFjyc97DrG/V1/BcR7UrL4UP9Qsq1jUj5tWqpebNXv45TJ7w0rK6BWenvmGwEvmLQf0YxlohnuPLZpi4dgj8OxQjYTsjMUqIsPQKLsWeSoSQ/zFN5MKGfgMbZFpa/PI2FdYuj7YUzQZzPzxtlKRM1UF5B9LCAMHnPATgqLiMmqdl6BMBcyQwK11gIrKMCnC5ZyhJMgpKGV0ZCOA5iNM8jMGMS8eVv/hQ9aHqkBR1zHwCKL2Lf+eySVnicKXsan0g3yE6PhR9Hb2b3IgMp80nlK0fVqIAGUBDYUuei4VUAHuksm9wUyiYheFDeNdx7zmRzBBcUfJ2qoIS1SOqhhVfkF1RNUi25c3UEaBb/5WVhmqI2nXJ+qeIzUblZs6DpzESJD5x0qBOw9QvvxVgYBS0sIMtZCz2ttj+qzgcKwEXMrVMNlK6xe9sBz9viEmYo39ER1eSTvn5GhnAlzvwxqp2u3YHSgtOYGFi/UhwhAWHDixSsw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92883639-5d06-48b2-25a1-08d864637920
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:36:07.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhkAgvVIeAx++P0yOqe9xfm5H52RzYMCb2c0oUvum0SsP8dr6hZzkcEpSDAc5iEqHGSsb+cB6cOKqLTCZzMq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5292
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
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 +++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 32 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dc387724cf08..688e5e88784e 100644
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
 
@@ -506,7 +508,19 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
 				    ~0);
 	}
 
-	return dw_pcie_allocate_domains(pp);
+	ret = dw_pcie_allocate_domains(pp);
+	if (ret)
+		return ret;
+
+	pp->msi_data = dma_map_single(dev, pp->msi_msg, sizeof(pp->msi_msg),
+				      DMA_FROM_DEVICE);
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

