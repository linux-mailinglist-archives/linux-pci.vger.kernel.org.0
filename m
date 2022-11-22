Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C217633211
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKVBRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 20:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKVBRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 20:17:44 -0500
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E35DEAE
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 17:17:42 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id AED282015C;
        Tue, 22 Nov 2022 09:17:39 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: dwc: Round up num_ctrls if num_vectors is less than MAX_MSI_IRQS_PER_CTRL
Date:   Tue, 22 Nov 2022 09:17:34 +0800
Message-Id: <1669079854-225073-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHk5PVkkdGh1KSEJIQhkaHlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6Cjo6AT0oKCgpA0pKVigU
        NC4KFD5VSlVKTU1CS0xCQ01LT0pMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlMTUM3Bg++
X-HM-Tid: 0a849ce982a02eb6kusnaed282015c
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

Changes in v2:
- set num_ctrls to 1 if it's less than one

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37..5c2229f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -62,6 +62,8 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	if (num_ctrls < 1)
+		num_ctrls = 1
 
 	for (i = 0; i < num_ctrls; i++) {
 		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
@@ -343,6 +345,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	if (!pp->num_vectors)
 		pp->num_vectors = MSI_DEF_NUM_VECTORS;
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	if (num_ctrls < 1)
+		num_ctrls = 1
 
 	if (!pp->msi_irq[0]) {
 		pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
@@ -707,6 +711,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	if (pp->has_msi_ctrl) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+		if (num_ctrls < 1)
+			num_ctrls = 1
 
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-- 
2.7.4

