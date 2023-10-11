Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E97C50F1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbjJKLFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbjJKLFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:05:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E732C9;
        Wed, 11 Oct 2023 04:05:30 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9469524E37D;
        Wed, 11 Oct 2023 19:05:28 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:28 +0800
Received: from ubuntu.localdomain (183.27.96.95) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:27 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v8 14/22] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date:   Wed, 11 Oct 2023 19:05:06 +0800
Message-ID: <20231011110514.107528-15-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011110514.107528-1-minda.chen@starfivetech.com>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.95]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The INTx and MSI interrupt event num is different in Microchip and
StarFive platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 104332603e25..e99498b5b563 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -808,6 +808,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq      = mc_request_event_irq,
+	.intx_event             = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event              = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -948,7 +950,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -958,7 +960,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 907ad40f3188..5ad1b81c0086 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -124,6 +124,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 irqreturn_t plda_event_handler(int irq, void *dev_id);
-- 
2.17.1

