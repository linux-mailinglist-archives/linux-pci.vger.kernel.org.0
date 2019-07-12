Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512E566FF8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGLN0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 09:26:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33957 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLN0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 09:26:16 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hlvYz-00024H-6f; Fri, 12 Jul 2019 15:26:13 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, patchwork-lst@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH] PCI: dwc: avoid OOB read in find_next_bit
Date:   Fri, 12 Jul 2019 15:26:11 +0200
Message-Id: <20190712132611.3374-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Find_next_bit works on a long type, which causes a OOB read on the
u32 input when used on ARM64.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 77db32529319..81a2139d68d6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -78,15 +78,16 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	int i, pos, irq;
-	u32 val, num_ctrls;
+	u32 num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long val;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
 					(i * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &val);
+				    4, (u32 *)&val);
 		if (!val)
 			continue;
 
-- 
2.20.1

