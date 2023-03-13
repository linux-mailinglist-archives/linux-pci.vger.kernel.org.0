Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E056B77C9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCMMmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMMmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F436A9C4;
        Mon, 13 Mar 2023 05:41:59 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6Tkv1028699;
        Mon, 13 Mar 2023 05:41:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=OD8RFaXnTC6GTIr2I3m0IEpFxTlu+5lVoZMEMaa2whU=;
 b=J/X2Tqo2Ux7FCiYZtBtshXBEAo8cLZ2A3WNhko3ZpJdETaWemMXzG0gd6h8Yr9l/BJLi
 nR8ADpY+7a2Agq3FcVYPULB9JRM2MJABsjHQyDvyANijq8cioQpz4Xf1Uo18e7/CrDzR
 Ci4W7UM+ELUPNmxfiUe24AQc/Uzx70STaa1J0J20Eg0sE9nLiZTKJZXMoTl2aFdNKUkN
 ELpxUWQVHfM8Un4YvaapgbePNoK9PL5szcVAtntb36ORWm7Z5QBHxdbldkroufiM2482
 QCa4w6KqFrJpxws/yRDChEw6Vs7pWkJQODsYP9KiOfbRuyzT+xl3vGLW/HbjFc84LgzD JA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gd8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:41:48 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:26 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 39AA65B6921;
        Mon, 13 Mar 2023 05:41:23 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 7/8] PCI: dwc: Introduce configurable DMA mask
Date:   Mon, 13 Mar 2023 14:40:15 +0200
Message-ID: <20230313124016.17102-8-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: dHocvyUF3pegmSJR2gewwdMD3dcDt488
X-Proofpoint-ORIG-GUID: dHocvyUF3pegmSJR2gewwdMD3dcDt488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
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
start at address 0x2_0000_0000. In order to have the DMA coherent
allocation succeed later, a different DMA mask is required, as
defined in the DT file for such SOCs, using dma-ranges.

If not defined, fallback to 32-bit as previously done in the code.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
v4:
   1) Fix commit message formatting.

   2) Fix removal / addition of blank lines.

 .../pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..74393e59e7a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -325,10 +325,14 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	u32 num_dma_maskbits = 32;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -367,18 +371,36 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	}
 
 	/*
+	 * Some devices, such as AC5 and AC5X have their physical DDR memory
+	 * start at address 0x2_0000_0000 . In order to have the DMA
+	 * coherent allocation succeed later, a different DMA mask is
+	 * required, as defined in the DT file for such SOCs using dma-ranges.
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
+	ret = of_pci_dma_range_parser_init(&parser, np);
+	if (!ret) {
+		if (of_pci_range_parser_one(&parser, &range)) {
+			if (range.size > BIT_MASK(32) ) {
+				num_dma_maskbits = fls64(range.size);
+				dev_info(dev, "Overriding DMA mask to %u bits...\n", num_dma_maskbits);
+			}
+		}
+	}
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(num_dma_maskbits));
 	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+		dev_warn(dev,
+			 "Failed to set DMA mask to %u-bit. Devices with only 32-bit MSI support may not work properly\n",
+			 num_dma_maskbits);
 
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
-- 
2.17.1

