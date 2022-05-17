Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6E52A201
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbiEQMvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346427AbiEQMvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:51:47 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B84D340A12;
        Tue, 17 May 2022 05:51:40 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B7985BB3;
        Tue, 17 May 2022 15:52:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru B7985BB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652791953;
        bh=byo7LdWAOntp9CHllRKOliNs4EMYYCQa53BtH26Ghrw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rJ2lXTr4YB4apAAZuUuBZtaghhWL+Uw5NEz82MDjGYCIuU88xbd6PwHVGbej2QT50
         x9LIw/pedOkU4kVe9dasa0w2fnK41yU8ZtrAQYHmAmK17js75O5qgiLJg92Zc9xLk5
         B/4WX0aVFn8ou9tIORRyalDwcWAHymDnqp/+7crg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 May 2022 15:51:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/13] PCI: dwc: Stop link in the host init error and de-initialization
Date:   Tue, 17 May 2022 15:50:46 +0300
Message-ID: <20220517125058.18488-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f32d964..7403b1709726 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -420,8 +420,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -432,8 +438,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
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

