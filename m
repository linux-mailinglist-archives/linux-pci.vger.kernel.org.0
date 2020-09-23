Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4802275178
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWG1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 02:27:30 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:64438
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIWG13 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 02:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0kSs2FycmMcV13/lJYFSPFtny5FZ7lTB3miueAskn2Q2Hi8BEiZdUtGrxOEO2oCOZnhWo7S1W1J7u/UdfdGAO6wD73wLM5CH9pNPQBrTNq3T7rTzo/DbeeqTKTLbcnAQ3oY9Iyg9wSe+phQ4dWcV5nzaL9/o2BK9t7GLaEBIOFn11nHQgSJjXXf9+mj2YpmR8GK5nlxnTw88uFd6AHeZX3exQ/WnDm52woIkJztYulrtk3Ok10bG7KWyIpTmpmt1U1V3GgOud4bLgb/qcR2uNgJ8D9fkci/bkH76rRTGvbN/268Py244ZvsfVYbzPLJP5i+Ty11m4o96ey6/WXfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g2NAP3+8asfVz5TnwA65boSew3P9cr7EnSkkE+UHTY=;
 b=Q8MiRLM15YBQAeeLDE8DNTlyYt32kGwu9Bo2uLHK/t4IJb/fLVLhT7vMTUx+CnJMdgT4honpwMJnrPvlXzWlvysw/t8+l0VGAUoes6DI21qbxbqr/hdi9QekJU8Q+IqDqNRwXo1yyCVbIZLl4+eR5cVCgD/W9sbqa/t05BcYlisrIfLggIJLUBqZ/ZSLHYTnR1IQlHM1HETEgYwW1/rOEGD9lsCw3HWluKUU8a/NMIS3LEVNHHv9jaMP2q9U17FNj8CMrNnbDBWPTzPTODDVG+g2dOWQ2DExuazIQm/TQYIqJg7DHVLoOqxnG6yikAJbzueqztBl3QBFAHpkxU7/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g2NAP3+8asfVz5TnwA65boSew3P9cr7EnSkkE+UHTY=;
 b=i6Va3w+flapu5hNu6aUt6zJx1WTkCg4ZrxmEiJr5tdKmVFl4OIBzKawLibp9GrBS/mdwC6qAqVUWuuVtSTUDBZfa0x+sWpP+e3cQ9UuV2hSabGJLEVZqfDTI5JehF2Mgx2VwIJM0L1YAhxvNrFDe0FCjxVkWSXS/CDaKDWbWwN0=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5177.namprd03.prod.outlook.com (2603:10b6:5:22b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Wed, 23 Sep
 2020 06:27:26 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 06:27:26 +0000
Date:   Wed, 23 Sep 2020 14:26:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: Move allocate and map page for msi out of
 dw_pcie_msi_init()
Message-ID: <20200923142607.10c89bd2@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:404:56::14) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:404:56::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 06:27:22 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b13486-19b8-45ce-3ad9-08d85f89bd23
X-MS-TrafficTypeDiagnostic: DM6PR03MB5177:
X-Microsoft-Antispam-PRVS: <DM6PR03MB51774770A19707EEFD3B90C7ED380@DM6PR03MB5177.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJbmB6CgJ+ZmxBmazII9ZcpYOh36Yr00ZKjRw3WDmc7FPk8P6B1V7+b+h2v3mk+20p11Z39i1yB0o8GHZ7pYtqfjBztv9nh5BUVd5cH56lkvHrXvFIVBuUiV5x8RMJFmLlRYDKzjA1ISZQ+BkljbM7qK4fqxUPyEBYV120PsUaJ/3eQKn6tcK01LHj92Rm5r2OW4Dy6Q2IWSFJN0bJ2jkmdw0kvB0VET/rVFff8/TZTc1fLOQbu6NOjkQl4UUskIkd5pWnKgza4MAzaHsNbXREau+7Q3URGgMmc92Y4uI2Uz5rvWzGm9hWWhscFvMe6MaM20g81T5PbHkzAXYk7Qeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39850400004)(136003)(396003)(9686003)(66556008)(66946007)(8936002)(16526019)(186003)(86362001)(2906002)(55016002)(83380400001)(66476007)(5660300002)(110136005)(1076003)(7416002)(316002)(6666004)(8676002)(4326008)(956004)(26005)(52116002)(7696005)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WB4NM5eXdSP1/kgX5jflJXTPj67rRQjlpcXBQ9JaHxBW5u4siKIOqnDsJ9ZV3IZ9pw8ln7yW/dVOzVh00SV9Ofdj8wFLOa9bof2bnFBkBA5rpvd3XFB6JA73ZOh30LKjiW3swdO+5deeZmfG3N4wHGalLLcmFF+uz892+DJpz7XVKXvXl6kP12ZW1CiwIZeiIh+Qp/4oBzhIfCKvnQIEaZxpLd6EJR2u7S8U7ZBLGAnxyTc7T/TpoR/7o8jazMFUFzIhSk3vcKHpO2gLWiwobXdpbrx3s1Ecw9Tzz7x4v04cA4B0HAR3vo7yu6NnLH1NqI4LTmw93JlT/iN2GrWQuC3yHqeOAmbKGoHqDeakcgALinyH0xePX2r7GfpgQvDjx7rfu97llycojeamfXdA3ZIJ5GJby+PYcbsYqzP/J0hAbpcBoPMkrPxUBBf4+kE0xHPptYrmQRr9PXoFvaGZrbbhzX/OSqnyk639CEaUBPph4+vraWQvN6cWBjj5LNC73N45x6dnqm1ctrU0BDtw0qOShfV6aWWjQRB3fN7lkj4ip9MnlZh1jxXs7pMrFxRV8HWvJW6ItfqK9kfQLrbmbxK8gVQoWk2uxIXcOTXUKyXOn5ofgiL2a5OdNVyq6ENchJ2Y1lcRDv3eIfKRIjMLuA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b13486-19b8-45ce-3ad9-08d85f89bd23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 06:27:26.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cseE0HNz6h+rvsg8S4m060FhJPs7T5kj1vwhyt7o44AiPCUfxgpad2y/j+GA/buBT/8HC+Kcg4ERIU7OhqI+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5177
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, dw_pcie_msi_init() allocates and maps page for msi, then
program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
may lose power during suspend-to-RAM, so when we resume, we want to
redo the latter but not the former. If designware based driver (for
example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
previous msi page will be leaked.

Move the allocate and map msi page from dw_pcie_msi_init() to
dw_pcie_host_init() to fix this problem.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 27 +++++++++----------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dc387724cf08..4301cf844a4c 100644
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
+	pp->msi_page = alloc_page(GFP_KERNEL);
+	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
+	ret = dma_mapping_error(dev, pp->msi_data);
+	if (ret) {
+		dev_err(dev, "Failed to map MSI data\n");
+		__free_page(pp->msi_page);
+		pp->msi_page = NULL;
+		dw_pcie_free_msi(pp);
+	}
+	return ret;
 }
 
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9dafecba347f..c23ba64f64fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -294,20 +294,7 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 
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
@@ -440,6 +427,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				irq_set_chained_handler_and_data(pp->msi_irq,
 							    dw_chained_msi_isr,
 							    pp);
+
+			pp->msi_page = alloc_page(GFP_KERNEL);
+			pp->msi_data = dma_map_page(pci->dev, pp->msi_page,
+						    0, PAGE_SIZE,
+						    DMA_FROM_DEVICE);
+			ret = dma_mapping_error(pci->dev, pp->msi_data);
+			if (ret) {
+				dev_err(pci->dev, "Failed to map MSI data\n");
+				__free_page(pp->msi_page);
+				pp->msi_page = NULL;
+				goto err_free_msi;
+			}
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
-- 
2.28.0

