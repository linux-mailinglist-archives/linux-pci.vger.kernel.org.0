Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3562882DD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 08:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJIGoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 02:44:08 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:10720
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbgJIGoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 02:44:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuFQSCcxxqkguxtzsgzMoIn7oOu79eBAI0Q6LkR7uQx2AgoafBBpGKskx6+75alDFGNV95e7uHNJC4jZ0op2yUjrziRtrr560lLSm/frWD0IUe0vZa5PaG8TRVzZti+B1z5g++NN+XSj/OZcAnkU+/i4HpvI/vcUWVs51Ltjm2SwCWSOG6QSxcz9QG3W2Vr9nLC+eM+gu+FmiknEEx6ZeZe6qtOxur+0xZeKts9bz/yzcPzy/wbW4Nfp8NDfrTZTTetqlI016w4OpVmJeDdTUw0es8vdHMYzFN2lKDrPJrF2oUCS6QAss/14dDmB3mjiQd9HrkdJfGpUGwSoAdKzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfcWfFipBrAlmcG8Aeur2wlps5X4Ukgn0rbmjTtqTDw=;
 b=KgzjVjrjMOpkDvjTNKyRnlsdBA408MH4mW9b/NWmAn869KKs3S2IjuaNMQ7GR1/tKPnjYUFht+qrKUBA5D/NXf/wNMq2FFOEwuaBgfmVgq32XhLMXb+ADNL+bqcyeZ/J74H1OcuodGZLQVuHKh73yxtHsKC+8enjy02I6IA3S4IsgisRyHaw5lR5X17EcsNK3Ym6rFaglHHHZIVT1EDWw5yDxqiw6f5bHV3yjVaWN8Pgy3blnmyimSqKt+KgHxduGPiuKwQS0x7Z89Od0WgRj0HXoC9+39zidg/bGr/QyDbEwDd76D5T1SUnGzSkgHxp9huPdQfGptMSkJmES+51Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfcWfFipBrAlmcG8Aeur2wlps5X4Ukgn0rbmjTtqTDw=;
 b=YU/yXkdUQqetZzJrzSJSSforIcKPi0lB15YAp3D6BLiLIwUewZ0tZ35kYnbhtQ/fXtOvkcJUcmGBKymhhxgR2mJXOWDqZcGx+mi8CgdRTKeInOqaCLWeaGFXT94ndGD6vrqFQ0piZEPJXEXWfwFZLpWOivvnQAAANA2qLfNqMhs=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3036.namprd03.prod.outlook.com (2603:10b6:3:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 06:44:05 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 06:44:05 +0000
Date:   Fri, 9 Oct 2020 14:42:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
Message-ID: <20201009144208.0b223d6f@xhacker.debian>
In-Reply-To: <20201009144029.62f327a9@xhacker.debian>
References: <20201009144029.62f327a9@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:404:14::28) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:404:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Fri, 9 Oct 2020 06:44:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d427c59-a3ec-402e-375a-08d86c1eb723
X-MS-TrafficTypeDiagnostic: DM5PR03MB3036:
X-Microsoft-Antispam-PRVS: <DM5PR03MB303661CEF87135D7C9C5527FED080@DM5PR03MB3036.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbk5Wb9j97IcYM5fUFosMnvOWMHiqImrXweM2K+TOmdBlle6um1wRMvWc4fBCKEhuJ1W24nwirxtb5fnGb3Stj3PeKXooBVGvWOzp1pe/jqfgnE+Q1MgdmflIIfAbBRaI6MktoZKtC0GEiXSpPrSh6b5toFNBXLV4x1W37VYc8sDVyDk+u7sVmw3cik1q5AIvKs9pjhlOXnntSQzeVNxNqKrgmzvuL6DYrzlpe0r3mTwkk11Vp7md0ZBCMyrPWv8tNfZ7udX1RYJKUJGqxI5Ux+KIbgXmw8CXpZdYZbpuJefJgJj/w8+fY6Aj1bRo7AvKhCizmpFbfoGg0lQnREp+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(5660300002)(66946007)(8676002)(66476007)(66556008)(55016002)(9686003)(2906002)(7416002)(110136005)(86362001)(83380400001)(15650500001)(956004)(1076003)(26005)(6506007)(316002)(7696005)(52116002)(4326008)(478600001)(186003)(16526019)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Oic8bQM/uwREl2Ch3CDpivvDJsabRVXrcwqQ/5pjULRweLm+LkquNenefQG3kUjVui+blyCLgLMzz7MQ9PuPc/jkHbb6ZnmxHEX3gHz7ZW1uTF9qw7cf7/IbWTNg9Fic68xH35A2vYTPAo+uWj0i0kig2QL68mRgTon3nssTpSK8YfHicS98vCfZpDN6vNoDfafVbPfDbU1NA0RhJl0fxp8mZoj+BHHAAUMF6MLo7zPFQ2sq8LRKVShGAWjiVGEGf4UcxtQ0uKyAxUmfcGhVJw/SIvMUyzgdclT5m3cY841rhSXiVYgdQyNZRLiFHf698bEHvM4aTJjTUIfFuapJ+Sr8dL9FX24DnY4KZ+wszkl3lqlZEq5c6obcW6eQIQUanYkqFPXbFmP8fyb+A5gQNyrDw3H+B81D7w40fl15Fy+ypQMPqQ36Xb3I6u67qf8dWFKv0E6Ji9Fsg5CVyLwqCleskEZ5wdKMnOeSYNGwwROEYVLVxKc/cINvv7uPNxdwlRjCudAY87qubCx5rheqGiQLI23wD9zjQFGmKocqtU90aQxwihl+G46ZKOlPNfg7hrfD6TMDoeVxl1IeuioWttkLwvEDxhdb1w5DBRnu4RsoF4czlDv4NW0FyLSeAsNc9tuZLUUZ1+RhITHqjbT4hQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d427c59-a3ec-402e-375a-08d86c1eb723
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 06:44:05.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qPluUsIvky8gt2WVrCYQ7f918QsRjXDebpXdyCXzzY71BAvbtK1imWRuLzuGfMb7DhDSmu4rJT+F49BHJfLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3036
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
 .../pci/controller/dwc/pcie-designware-host.c | 36 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 36 insertions(+), 20 deletions(-)

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
index d3e9ea11ce9e..4db244596e79 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -266,29 +266,19 @@ void dw_pcie_free_msi(struct pcie_port *pp)
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
-
-	if (!IS_ENABLED(CONFIG_PCI_MSI))
-		return;
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
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
@@ -394,6 +384,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
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

