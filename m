Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A26631A1D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 08:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKUHXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 02:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUHXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 02:23:45 -0500
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Nov 2022 23:23:44 PST
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594539FCC
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 23:23:44 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 6C93A204BB;
        Mon, 21 Nov 2022 15:16:38 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dwc: Round up num_ctrls if num_vectors is less than MAX_MSI_IRQS_PER_CTRL
Date:   Mon, 21 Nov 2022 15:16:36 +0800
Message-Id: <1669014996-177686-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR9KVkJITBkYTBpMTUoZTVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6ERw6MD0ZEioOTAFRDjlI
        FzEwCyJVSlVKTU1CS0pPQkJCSUtKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDTkI3Bg++
X-HM-Tid: 0a84990bce592eb6kusn6c93a204bb
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some SoCs may only support 1 RC with a few MSIs support that the total numver of MSIs is
less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
up MSI support. Fix it by rounding up num_ctrls to at least one.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37..2cba2a8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -61,7 +61,7 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
 
 	for (i = 0; i < num_ctrls; i++) {
 		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
@@ -342,7 +342,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 
 	if (!pp->num_vectors)
 		pp->num_vectors = MSI_DEF_NUM_VECTORS;
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
 
 	if (!pp->msi_irq[0]) {
 		pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
@@ -706,7 +706,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	dw_pcie_setup(pci);
 
 	if (pp->has_msi_ctrl) {
-		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+		num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
 
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-- 
2.7.4

