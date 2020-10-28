Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50A29D533
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgJ1V62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:58:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:49799 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgJ1V6T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Oct 2020 10:31:59 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 491AE180C13;
        Wed, 28 Oct 2020 10:31:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Oct 2020 10:31:56 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A7A4E1A0509;
        Wed, 28 Oct 2020 10:31:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v8 2/3] PCI: dwc: Add msi_host_isr() callback
Date:   Wed, 28 Oct 2020 10:31:42 +0900
Message-Id: <1603848703-21099-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603848703-21099-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1603848703-21099-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds msi_host_isr() callback function support to describe
SoC-dependent service triggered by MSI.

For example, when AER interrupt is triggered by MSI, the callback function
reads SoC-dependent registers and detects that the interrupt is from AER,
and invoke AER interrupts related to MSI.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 674f32d..45eea6f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -61,6 +61,9 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	if (pp->ops->msi_host_isr)
+		pp->ops->msi_host_isr(pp);
+
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9d2f511..2ce3133 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -176,6 +176,7 @@ struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
+	void (*msi_host_isr)(struct pcie_port *pp);
 };
 
 struct pcie_port {
-- 
2.7.4

