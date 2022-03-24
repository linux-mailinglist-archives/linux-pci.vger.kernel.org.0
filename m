Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9255B4E9A71
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiC1PK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiC1PKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:10:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2806B53A46;
        Mon, 28 Mar 2022 08:09:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 240DE1E28FF;
        Thu, 24 Mar 2022 04:25:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 240DE1E28FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085128;
        bh=kfxQKEOlP4ohIS01o1tX7PouvvGd/yuJ1ukMhFjn3Qs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Hyo9TubO9jqw3+G+0DYfNyYe5dSrqKR9rJkj8Es47o1CslyJCLOpoU003UJIjkYal
         /5szf0zP6Za3YC6xG8Unv7GvUyUrQQzKkUhhqmZS9vDbFutFcjjWUeK9ODlCTUtSBW
         ybh7vQ37yG8axglT5Y/pnIJBiQwQKhCKe5kwHK2A=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:25:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/12] PCI: dwc: Stop link in the host init error and de-initialization
Date:   Thu, 24 Mar 2022 04:25:12 +0300
Message-ID: <20220324012524.16784-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
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
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f4755f3a03be..a03619a30c20 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -414,8 +414,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -426,8 +432,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
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

