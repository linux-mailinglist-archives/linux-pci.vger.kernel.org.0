Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD48D545EF0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiFJI1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347695AbiFJI11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:27 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82AAB1B9FB6;
        Fri, 10 Jun 2022 01:25:45 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 16F2CBD3;
        Fri, 10 Jun 2022 11:26:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 16F2CBD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849591;
        bh=Bf4VbYSj3xU+fOl1ecpR6lOBW8ZCg2ytntOA+jkU3eE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=geU9WYCUp6FklyzZVxVW8HuMxpxc7B9idl2QAmGbAMKe10KfLDbXT8CeQ0SSE3dJM
         B4Veaz4kSYNGTNmW1tuF5Uot28Q2hIGbf+0/Afjzd832FeYKXoHK7autD6GBTvjfa1
         WmrRjkYWZYhcB1/2a9djCukYhLGP8tNI/rmKW2iY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/18] PCI: dwc: Disable outbound windows for controllers with iATU
Date:   Fri, 10 Jun 2022 11:25:19 +0300
Message-ID: <20220610082535.12802-4-Sergey.Semin@baikalelectronics.ru>
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

In accordance with the dw_pcie_setup_rc() method semantics and judging by
what the comment added in commit dd193929d91e ("PCI: designware: Explain
why we don't program ATU for some platforms") states there are DWC
PCIe-available platforms like Keystone (pci-keystone.c) or Amazon's
Annapurna Labs (pcie-al.c) which don't have the DW PCIe internal ATU
enabled and use it's own address translation approach implemented. In
these cases at the very least there is no point in touching the DW PCIe
iATU CSRs. Moreover depending on the vendor-specific address translation
implementation it might be even erroneous. So let's move the iATU windows
disabling procedure to being under the corresponding conditional statement
clause thus performing that procedure only if the iATU is expected to be
available on the platform.

Fixes: 458ad06c4cdd ("PCI: dwc: Ensure all outbound ATU windows are reset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7403b1709726..f686727bd3c1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -542,7 +542,6 @@ static struct pci_ops dw_pcie_ops = {
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
-	int i;
 	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
@@ -593,19 +592,22 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
-	/* Ensure all outbound windows are disabled so there are multiple matches */
-	for (i = 0; i < pci->num_ob_windows; i++)
-		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
-
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		int atu_idx = 0;
+		int i, atu_idx = 0;
 		struct resource_entry *entry;
 
+		/*
+		 * Ensure all outbound windows are disabled so there are
+		 * multiple matches
+		 */
+		for (i = 0; i < pci->num_ob_windows; i++)
+			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+
 		/* Get last memory resource entry */
 		resource_list_for_each_entry(entry, &pp->bridge->windows) {
 			if (resource_type(entry->res) != IORESOURCE_MEM)
-- 
2.35.1

