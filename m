Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2014D7C50F2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346649AbjJKLFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbjJKLFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:05:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C19E;
        Wed, 11 Oct 2023 04:05:30 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 86D3624E37E;
        Wed, 11 Oct 2023 19:05:29 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:29 +0800
Received: from ubuntu.localdomain (183.27.96.95) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:28 +0800
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
Subject: [PATCH v8 15/22] PCI: microchip: Add get_events() callback function
Date:   Wed, 11 Oct 2023 19:05:07 +0800
Message-ID: <20231011110514.107528-16-minda.chen@starfivetech.com>
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

For different interrupts to event num mapping function,
add get_events() function pointer.

For extenting event ops in the fucture, Add struct
plda_event_ops data structure.

plda_handle_events() will call the get_events() callback
function pointer directly. For the robustness of codes,
add checking in plda_init_interrupts().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 14 +++++++++++++-
 drivers/pci/controller/plda/pcie-plda.h           |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index e99498b5b563..fca1520d56c9 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -647,7 +647,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	events = mc_get_events(port);
+	events = port->event_ops->get_events(port);
 
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -806,7 +806,12 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 				0, event_cause[event].sym, plda);
 }
 
+static const struct plda_event_ops mc_event_ops = {
+	.get_events = mc_get_events,
+};
+
 static const struct plda_event mc_event = {
+	.event_ops              = &mc_event_ops,
 	.request_event_irq      = mc_request_event_irq,
 	.intx_event             = EVENT_LOCAL_PM_MSI_INT_INTX,
 	.msi_event              = EVENT_LOCAL_PM_MSI_INT_MSI,
@@ -920,6 +925,11 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
+	if (!event->event_ops || !event->event_ops->get_events) {
+		dev_err(dev, "no get events ops\n");
+		return -EINVAL;
+	}
+
 	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
@@ -930,6 +940,8 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	if (irq < 0)
 		return -ENODEV;
 
+	port->event_ops = event->event_ops;
+
 	for (i = 0; i < port->num_events; i++) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 5ad1b81c0086..6571a4befac9 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -102,6 +102,12 @@
 #define EVENT_PM_MSI_INT_SYS_ERR		12
 #define NUM_PLDA_EVENTS				13
 
+struct plda_pcie_rp;
+
+struct plda_event_ops {
+	u32 (*get_events)(struct plda_pcie_rp *pcie);
+};
+
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
@@ -117,11 +123,13 @@ struct plda_pcie_rp {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct plda_msi msi;
+	const struct plda_event_ops *event_ops;
 	void __iomem *bridge_addr;
 	int num_events;
 };
 
 struct plda_event {
+	const struct plda_event_ops *event_ops;
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
 	int intx_event;
-- 
2.17.1

