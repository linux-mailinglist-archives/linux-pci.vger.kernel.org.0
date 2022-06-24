Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF34559BA1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiFXOfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiFXOfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:35:05 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ADE2562FC;
        Fri, 24 Jun 2022 07:34:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 7722A16D8;
        Fri, 24 Jun 2022 17:35:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 7722A16D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081358;
        bh=GQNBYPvYtx3tO/fRGqTo+0xh7CrU1ymivwXuiXPFLeQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=HExG/gRiR+/TrhXuQwBfxeCbawnYikhispM0oVL9uFZJc9XqnKx0evzJJ3pdhI8Wk
         3t/nsIZnc08WTmzCGlYnYcfCIBAbxeaIfSC2xKgWEraw85jmx0Ya7mnwqWpnnYwtdg
         7KT7jMIAsfoeQ+48zMtOHdEyvcBAWfXCqwkhKQKY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:38 +0300
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
Subject: [PATCH RESEND v5 10/18] PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
Date:   Fri, 24 Jun 2022 17:34:20 +0300
Message-ID: <20220624143428.8334-11-Sergey.Semin@baikalelectronics.ru>
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

While the rest of the generic DWC PCIe code is using the dedicated IO-mem
accessors, the dw_pcie_link_up() method for some unobvious reason directly
calls readl() to get PortLogic.DEBUG1 register content. Since the way the
dbi-bus is accessed can be platform-specific let's replace the direct dbi
memory space read procedure with the readl-wrapper invocation. Thus we'll
have a slightly more generic dw_pcie_link_up() method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index e5c30695f664..f9613835212b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -548,7 +548,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
-	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1);
 	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
 		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
 }
-- 
2.35.1

