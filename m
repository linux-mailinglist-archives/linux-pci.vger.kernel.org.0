Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458C28840C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbgJIH4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 03:56:38 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:10305
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732239AbgJIH4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 03:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQy89hQTMXW1DsKiNO3alsPmsNpedlsFtUr/5l0JAT+NlsPZ3/oihtY2rfb8jLZWWN+sBdJPNQC0oSAAsJj2Bd5XBaphJXwNWW0SK5FrqUttLvVhSq5LlPXZIIIOF6e8o30G58D0w/kbw+2FEhVqLDXX5LlMYx1puGXcqO1dRaXgfBOJio9vEJ4Eg33IcSGHdXcj0tyjWbqOQLzDao7RDqbeLSy3/1r6yYdgNZc5mj8fnmCGIpf72g2WFIz0Y9IQhHCzoYOTgJywxOeVB/SjMmCdifVpAd4uRRIWFhnBpMniDeJzYh1lpGSGmDw3tOQIZpuP5u4/6oCtUlhiGnYGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnKCQc8R2wWS07bdI/Ree/oa+gv1cmQfIEW614Tq4SM=;
 b=XXqRcPq1EGXMhR8L8mBY1MnwZ78D1oHHKegzuzeGQlhQuoBiCEfKalrxT+ZVDo01EtS20roL9PiEs9GdwEx+7dtU73yDuLNM9WCjlcwKIFgFCXL5xPsAHDkOjgnqBZ5wenxcWlCAJFtERkXWr6ar96Gh036rmYIUT5471uxc2gE71eje9eIit4mKtMYbkuIpgal7TxYoEn0nyOBpqsDijCSbXIF8HYfwddCTHxhFkPyrIwKJvQnVCgFinLg1Qw+/sJiSooso1oEuQshpl44ASw26n8nc+aPhIQQzW4tLRazQPWN6/aAF5FZqwS3Nd0MzFZe+SHeJPdsqkBldw/YAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnKCQc8R2wWS07bdI/Ree/oa+gv1cmQfIEW614Tq4SM=;
 b=Ps5lXQBHkZnZNVjKvOum9v3j0/ioc5K1OYXJY0rKvZsfpzT5xHxWxyUjCG53rFonfYRRpRcWYGfFyc8OpQljhxQ2iefCOy9JUcz2keDrTa85GQS/CxIvRngR+ImIF3s2d0TWrt+63rS/ySXKlCAsk7I9Bdh961kW5SO4Ox1+kC4=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2683.namprd03.prod.outlook.com (2603:10b6:3:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 07:56:34 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 07:56:33 +0000
Date:   Fri, 9 Oct 2020 15:55:05 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
Message-ID: <20201009155505.5a580ef5@xhacker.debian>
In-Reply-To: <20201009155311.22d3caa5@xhacker.debian>
References: <20201009155311.22d3caa5@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16)
 To DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 07:56:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959db8b0-ba45-4512-52b0-08d86c28d70e
X-MS-TrafficTypeDiagnostic: DM5PR03MB2683:
X-Microsoft-Antispam-PRVS: <DM5PR03MB268301B1A9E4D0C8FB8EC2E3ED080@DM5PR03MB2683.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uClyWPoH3MzZDokbX9JRwoThFB9BwtITJw78hcTQaTG/hk8FtsfrJsTquNcZa21PIdF9SvYCC+j64w7N0+mW1X2Ze/Cs9QQhNkobBAbDGew/YE8zHoG0hYQTO6JtNZqo72sQfvs/6hXvV3ykFfx7D8a5ghJsduPktq+6171f+kfTqJzFwBFVaCt8an+rr0DQgVYlxMGStouGsRiGWrcwSDaZoLwWtsyGcAWJMdOt6SaYjdzyAOMQd2m2BMB+hymBw/C99uoi7okyTorcN/smsI/VHQuYzd7ZknkUcip4RtCS1DX/ybdGxiJYMH+68NrRYKnyEkP6Yb62if2HXicQug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39850400004)(5660300002)(6666004)(956004)(8676002)(66946007)(7416002)(86362001)(83380400001)(4326008)(55016002)(8936002)(110136005)(2906002)(16526019)(316002)(186003)(6506007)(15650500001)(66556008)(478600001)(1076003)(52116002)(9686003)(66476007)(26005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tfaNq7kOS3+g1ADUFB37e/J04ewROK5zCZ4EYfYiaRomWSBwcCYDDVC4+DioOAw4NJewamMHmmx4/Csu98PnqDZUqMJFAu7zVNTRPaV5SXnDYilqPc1CkzD9Q1lLpyDERe9LuidGgeVt1DndOEdOPpN4JFDwImGa27x2cYR3B2/Bf8XzBn61ASSWDJ0lAwH3Bdh0MbmKJaX5t5H8sv9PdTAtQy7yw5H6AQqNTzVa7pV/xD9j0PEfNtyXrrZBwap6ffX0mEymH4J+opY1Fbn+/z8OwCTza+Q13sqQPdRxFRwSrRAaIsBMz3iT11IlN+dURF9xXmAF+HMd7OGRJ5SzDPDmMaHsG+6tsm1ZMAT48jPVCALCFwcG9KZxN99MH9xa3YnrHAn5SgEimNeUW1WHefaZvUCUMcmygUP+ot+RH265I78uduvCZlVjyO0w5sIGSo6C39el6n0Vg0emAud305C9n6jLmPhaItVzioF4qOuSvfO9BoMbUGHVGuFEHxLibGff4Tpw1WIVUPmhZb3TwSzcx7QZaiSoVTejTV48jMka2W6QaE4HdAq3XLdso9N/AzR9DtjZ/1ak7MZ/kYOfAH19QtqXn5s1dry6fDj3l6ztHRkYrLrZLDMw9lNzucXXQzzHFA4VEAHkmmdoV4n9AA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959db8b0-ba45-4512-52b0-08d86c28d70e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:56:33.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXxfedvD1YQc5wZFFW96eQulWYMv5yjZHWcNC/r97SOS+dwx9sFjoAK35yMmMZh8yea+EvmbOT2zLLlmiToh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2683
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

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 8f0b6d644e4b..6d012d2b1e90 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -466,7 +466,9 @@ static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
 static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	u32 ctrl, num_ctrls;
+	int ret;
 
 	pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
 
@@ -482,7 +484,21 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
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
index d3e9ea11ce9e..d02c7e74738d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -266,30 +266,23 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
 
-	if (pp->msi_page)
-		__free_page(pp->msi_page);
+	if (pp->msi_data) {
+		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+		struct device *dev = pci->dev;
+
+		dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
+				       DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	}
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	u64 msi_target;
+	u64 msi_target = (u64)pp->msi_data;
 
 	if (!IS_ENABLED(CONFIG_PCI_MSI))
 		return;
 
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
-
 	/* Program the msi_data */
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
@@ -394,6 +387,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				irq_set_chained_handler_and_data(pp->msi_irq,
 							    dw_chained_msi_isr,
 							    pp);
+
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
index 97c7063b9e89..9d2f511f13fa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -190,8 +190,8 @@ struct pcie_port {
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

