Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AD519034
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiECV1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiECV1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:22 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 221464162E;
        Tue,  3 May 2022 14:23:36 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5D53816A9;
        Wed,  4 May 2022 00:24:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5D53816A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613049;
        bh=bo5OqnK+Z6C/zfKXy1FN6D2uyOimMZxXIfJNT8kWNlI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=icKemu7SIwVe5HDWo/ep1D9y8aOHLzTYni1wpNEF53a3vC9mME5CA6sE+3K6iE3NE
         4yxxXUuURFofMY9YRBUEsQ2hYa1P5mL9cGNmPf5MrxrT86g2UwgopxDo5vp+e7Qqn4
         2H11maKoNHZiZfaLEfpHYaufos/aY7SHAYGV0tIM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Joao Pinto <jpinto@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/13] PCI: dwc: Deallocate EPC memory on EP init error
Date:   Wed, 4 May 2022 00:22:57 +0300
Message-ID: <20220503212300.30105-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

---

Changelog v2:
- This is a new patch create as a result of the discussion in:
  Link: https://lore.kernel.org/linux-pci/20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru
---
 .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7c9315fffe24..7ad349c32082 100644
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

