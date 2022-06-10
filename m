Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F31545EF7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbiFJI1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiFJI1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:36 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E951E6;
        Fri, 10 Jun 2022 01:25:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 7F6C7BD5;
        Fri, 10 Jun 2022 11:26:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 7F6C7BD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849592;
        bh=+gI71JLhhnSRusEOjeZv6TJRO628MYh6FKbmJ5Uln1A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AGxDMM1Bjuyn8lM+CJVqaAPRDAae45d0iLKNS/aGz/55MEKZNOOe6r2IB8P2YJ1oX
         omWwYQB4FqCpH8Y4ClVIxN8JAE/LU/rO839qZzpMp0oCecRjhAyksSvN6Nqv8o2kP6
         Jia0KtmUUCXTy34IyVHPaRHkM3dZUuq9KH3Z8biE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/18] PCI: dwc: Deallocate EPC memory on EP init error
Date:   Fri, 10 Jun 2022 11:25:21 +0300
Message-ID: <20220610082535.12802-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the dw_pcie_ep_init() method fails to perform any action after the EPC
memory is initialized and the MSI memory region is allocated, the later
parts won't be undone thus causing the memory leak.  Let's fix that by
introducing the cleanup-on-error path in the dw_pcie_ep_init() method,
which will be taken should any consequent erroneous situation happens.

Fixes: 2fd0c9d966cc ("PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v2:
- This is a new patch create as a result of the discussion in:
  Link: https://lore.kernel.org/linux-pci/20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru
---
 .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0eda8236c125..13c2e73f0eaf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -780,8 +780,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
 					     epc->mem->window.page_size);
 	if (!ep->msi_mem) {
+		ret = -ENOMEM;
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
-		return -ENOMEM;
+		goto err_exit_epc_mem;
 	}
 
 	if (ep->ops->get_features) {
@@ -790,6 +791,19 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			return 0;
 	}
 
-	return dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_complete(ep);
+	if (ret)
+		goto err_free_epc_mem;
+
+	return 0;
+
+err_free_epc_mem:
+	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
+			      epc->mem->window.page_size);
+
+err_exit_epc_mem:
+	pci_epc_mem_exit(epc);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
-- 
2.35.1

