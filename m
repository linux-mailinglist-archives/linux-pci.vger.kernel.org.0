Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2EB26F7F4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIRISy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 04:18:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56944 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgIRISx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 04:18:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D08B1A01FB;
        Fri, 18 Sep 2020 10:08:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FF741A0291;
        Fri, 18 Sep 2020 10:08:51 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AAFA3402E3;
        Fri, 18 Sep 2020 10:08:42 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        shawnguo@kernel.org, kishon@ti.com, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andrew.murray@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv8 08/12] PCI: layerscape: Modify the MSIX to the doorbell mode
Date:   Fri, 18 Sep 2020 16:00:20 +0800
Message-Id: <20200918080024.13639-9-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
References: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

dw_pcie_ep_raise_msix_irq was never called in the exisitng driver
before, because the ls1046a platform don't support the MSIX feature
and msix_capable was always set to false.
Now that add the ls1088a platform with MSIX support, use the doorbell
method to support the MSIX feature.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V8:
 - No change.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 9601f9c09cb1..bfab1c694f00 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -79,7 +79,8 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_EPC_IRQ_MSIX:
-		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
+							  interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
 		return -EINVAL;
-- 
2.17.1

