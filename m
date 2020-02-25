Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3016BB96
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBYINC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 03:13:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50548 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgBYINB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 03:13:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P8Cnch100503;
        Tue, 25 Feb 2020 02:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582618369;
        bh=AjPWXiWRfwYr9E/yQ+iiQAgHij2JOgvin4hry77eZrA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gq07E6pgBPANdYa+hDUz8pwJJHxEEYZkclhsds2+xFJvLk3+bJ2SWrr8xT+w1cPo7
         bPJDCE8UX/a2TwS8QM36opeJXiMJLDqNFmmh4PEsC+1T9fIhSZXPJSFJ97zAlhZrSH
         u8lHcL/mLhEjpJcLy/qCvRz3B5Jxmb4IXcHVzkYU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P8CnXn079310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 02:12:49 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 02:12:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 02:12:49 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P8CYuB026220;
        Tue, 25 Feb 2020 02:12:46 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 3/3] PCI: keystone: Allow AM654 PCIe Endpoint to raise MSI-X interrupt
Date:   Tue, 25 Feb 2020 13:47:03 +0530
Message-ID: <20200225081703.8857-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225081703.8857-1-kishon@ti.com>
References: <20200225081703.8857-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM654 PCIe EP controller has MSI-X capability register and has the
ability to raise MSI-X interrupt. Add support in pci-keystone.c
for PCIe endpoint controller in AM654 to raise MSI-X interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c8c702c494a2..790679fdfa48 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -959,6 +959,9 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	case PCI_EPC_IRQ_MSI:
 		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 		break;
+	case PCI_EPC_IRQ_MSIX:
+		dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+		break;
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
 		return -EINVAL;
@@ -970,7 +973,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
+	.msix_capable = true,
 	.reserved_bar = 1 << BAR_0 | 1 << BAR_1,
 	.bar_fixed_64bit = 1 << BAR_0,
 	.bar_fixed_size[2] = SZ_1M,
-- 
2.17.1

