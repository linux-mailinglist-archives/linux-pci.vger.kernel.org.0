Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56979559BAC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiFXOek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiFXOej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:34:39 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6174E3585B;
        Fri, 24 Jun 2022 07:34:35 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 69DA016D8;
        Fri, 24 Jun 2022 17:35:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 69DA016D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081352;
        bh=60k0dZt+gQ0eQT86COoWG8c9fkb3Ux99QvTMOhYMyzI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=re1nww5EulAWPyjiMhcVy1ZXRGQTx88kJ+O/5sIXLqjYVEQzXW06/zj27YgO8F2BM
         QNl98lWmiRm12NiiJhP95bkPAtjBvxrmpJ7QhixXdPh188r9UFdxMRJfA5gTR0TQeb
         CxNvMUl3pHLjd7O1+0KNjRk6SSqvTmW/ebgyFhCM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 01/18] PCI: dwc: Stop link in the host init error and de-initialization
Date:   Fri, 24 Jun 2022 17:34:11 +0300
Message-ID: <20220624143428.8334-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's logically correct to undo everything what was done in case of an
error is discovered or in the corresponding cleanup counterpart. Otherwise
the host controller will be left in an undetermined state. Seeing the link
is set up in the Host-initialization method it will be right to
de-activate it there in the cleanup-on-error block and stop the link in
the antagonistic routine - dw_pcie_host_deinit(). The link de-activation
is a platform-specific thing and is supposed to be implemented in the
framework of the dw_pcie_ops.stop_link() operation.

Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9979302532b7..bc9a7df130ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -421,8 +421,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->sysdata = pp;
 
 	ret = pci_host_probe(bridge);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto err_stop_link;
+
+	return 0;
+
+err_stop_link:
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
 
 err_free_msi:
 	if (pp->has_msi_ctrl)
@@ -433,8 +439,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
 void dw_pcie_host_deinit(struct pcie_port *pp)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
+
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 }
-- 
2.35.1

