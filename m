Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8154559C82
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiFXOj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiFXOj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:39:57 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C57A64789;
        Fri, 24 Jun 2022 07:39:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 047F05BC4;
        Fri, 24 Jun 2022 17:41:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 047F05BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081673;
        bh=376VK9bz8YdbKQlFjxS2S2rqcfqNQoZ10LOGpnBBqoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=awwgw+th0X71qHXhJ1TZzEUYRV610fXK+DLvUpf0H+e5Zz5oGMFL0bJQF9xrrDuW3
         Wai4zUq036SwAnUt50lvLZLhvIh3tvDD9+cKIIzgpWKSzrm08o/IeZxiu00g6pt1DX
         Bj3RaRoSQdop5tmKD2oqp4QSxR1FtjYXFrhOlQ9o=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:39:53 +0300
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
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v4 01/15] PCI: dwc: Add more verbose link-up message
Date:   Fri, 24 Jun 2022 17:39:33 +0300
Message-ID: <20220624143947.8991-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
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

Printing just "link up" isn't that much informative especially when it
comes to working with the PCI Express bus. Even if the link is up, due to
multiple reasons the bus performance can degrade to slower speeds or to
narrower width than both Root Port and its partner is capable of. In that
case it would be handy to know the link specifications as early as
possible. So let's add a more verbose message to the busy-wait link-state
method, which will contain the link speed generation and the PCIe bus
width in case if the link up state is discovered. Otherwise an error will
be printed to the system log.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- Test the error condition first and return straight away if it comes true.
  The typical return is better to be unindented (@Joe).
---
 drivers/pci/controller/dwc/pcie-designware.c | 22 ++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ce01187947c9..e66d16a86168 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -524,20 +524,30 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
+	u32 offset, val;
 	int retries;
 
 	/* Check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (dw_pcie_link_up(pci)) {
-			dev_info(pci->dev, "Link up\n");
-			return 0;
-		}
+		if (dw_pcie_link_up(pci))
+			break;
+
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_info(pci->dev, "Phy link never came up\n");
+	if (retries >= LINK_WAIT_MAX_RETRIES) {
+		dev_err(pci->dev, "Phy link never came up\n");
+		return -ETIMEDOUT;
+	}
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-	return -ETIMEDOUT;
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
-- 
2.35.1

