Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65311AB2E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfLKMpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 07:45:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42480 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfLKMpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 07:45:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBCj8sH012121;
        Wed, 11 Dec 2019 06:45:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576068308;
        bh=2tvalbS51NRH72d/eck6wNFaarOFGq+9ECr88otyLfI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oJoyfKk6hUmwxuhwQ/RokizqaBg9NBAcGl9+qwYGDaqe1sSsGOrG+WiciI9ONFbkr
         Bz3gEngOMeo5KhbEQHQaHxgjShp/7vSFd8AzunP9rgSEWgmM1rohvLM8LCO65FGwKS
         FSKTy0WdR71YZY7bjeOxjSpB7tGSewdOJDlBQUWI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCj8RM105562;
        Wed, 11 Dec 2019 06:45:08 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 06:45:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 06:45:08 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCirfk125451;
        Wed, 11 Dec 2019 06:45:05 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 3/4] PCI: keystone: Allow AM654 PCIe Endpoint to raise MSIX interrupt
Date:   Wed, 11 Dec 2019 18:16:07 +0530
Message-ID: <20191211124608.887-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211124608.887-1-kishon@ti.com>
References: <20191211124608.887-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM654 PCIe EP controller has MSIX capability register and has the
ability to raise MSIX interrupt. Add support in pci-keystone.c
for PCIe endpoint controller in AM654 to raise MSIX interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index af677254a072..dbe31589eb61 100644
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

