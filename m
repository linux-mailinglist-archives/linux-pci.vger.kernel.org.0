Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E006A0F24
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBWSGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjBWSG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:27 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F95BB8C;
        Thu, 23 Feb 2023 10:06:17 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHUWLJ027007;
        Thu, 23 Feb 2023 10:06:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=vRhsh7DuocTyQAHVEoGkeQztl6fu/GZoJreu/RdOAqo=;
 b=bT1a4kMHcWL94yuoChjsB60eE4MC8Uvq3RKGCC4OO9lgtHUZYEIPqGMBwZJe5dlB7BYi
 hnyqoGBSRwjo3m5YInZB3jCQIIIJgRVDjRCeGcXnkxqMgkIkQQcIZ7PQJ9UjCKm58w1o
 zbABaPYqV4hydlSC3T/DKIB38Av3CU+mFmCkSECG/V0BbuldQekaWqR+YeZomrqYg7bW
 Awuj+5SaAVosnCxB2pKuW5ucmBb01x2UlvSlDy83OSXY30IiFcC15PoPtc7H9LgTUlyg
 1nHEkA/JEt3j0mRVyhngvs0qrxHIHGAmCvByQZ7l1brCG9V/eEmpwBgH+VG68rpPw9fA Xg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:06:09 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:06:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:06:08 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 6A9333F708C;
        Thu, 23 Feb 2023 10:06:05 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v3 6/7] PCI: dwc: Introduce Configurable DMA mask
Date:   Thu, 23 Feb 2023 20:05:30 +0200
Message-ID: <20230223180531.15148-7-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: pzB7NhPyA0SgHlKfNXptrDENU0WYardP
X-Proofpoint-ORIG-GUID: pzB7NhPyA0SgHlKfNXptrDENU0WYardP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Some devices, such as AC5 and AC5X have their physical DDR memory
start at address 0x2_0000_0000 . In order to have the DMA
coherent allocation succeed later, a different DMA mask is
required, as defined in the DT file for such SOCs.
If not defined, fallback to 32-bit as previously done in the code.
DT property is called num-dmamask , and can range between 33 and 64.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..ac851b065325 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -204,7 +204,6 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 				    pp->msi_irq_chip,
 				    pp, handle_edge_irq,
 				    NULL, NULL);
-
 	return 0;
 }
 
@@ -250,7 +249,6 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 		irq_domain_remove(pp->irq_domain);
 		return -ENOMEM;
 	}
-
 	return 0;
 }
 
@@ -325,10 +323,12 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	u32 num_dma_maskbits;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -367,18 +367,30 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	}
 
 	/*
+	 * Some devices, such as AC5 and AC5X have their physical DDR memory
+	 * start at address 0x2_0000_0000 . In order to have the DMA
+	 * coherent allocation succeed later, a different DMA mask is
+	 * required, as defined in the DT file for such SOCs.
+	 * If not defined, fallback to 32-bit as described below:
+	 *
 	 * Even though the iMSI-RX Module supports 64-bit addresses some
 	 * peripheral PCIe devices may lack 64-bit message support. In
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
 	 *
-	 * Note until there is a better alternative found the reservation is
+	 * Note until there is a better alternative found, the reservation is
 	 * done by allocating from the artificially limited DMA-coherent
 	 * memory.
 	 */
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	ret = of_property_read_u32(np, "num-dmamask", &num_dma_maskbits);
 	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+		num_dma_maskbits = 32;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(num_dma_maskbits));
+	if (ret)
+		dev_warn(dev,
+			 "Failed to set DMA mask to %u-bit. Devices with only 32-bit MSI support may not work properly\n",
+			 num_dma_maskbits);
 
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
@@ -420,7 +432,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 		return -ENODEV;
 	}
-
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
-- 
2.17.1

