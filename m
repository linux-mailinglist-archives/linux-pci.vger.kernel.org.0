Return-Path: <linux-pci+bounces-968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267A812940
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11A51F21159
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB58DDDF;
	Thu, 14 Dec 2023 07:29:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7CA10FB;
	Wed, 13 Dec 2023 23:29:33 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 9B8C324E2F2;
	Thu, 14 Dec 2023 15:29:32 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:29:32 +0800
Received: from ubuntu.localdomain (113.72.145.168) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:29:30 +0800
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen
	<minda.chen@starfivetech.com>
Subject: [PATCH v13 13/21] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date: Thu, 14 Dec 2023 15:28:31 +0800
Message-ID: <20231214072839.2367-14-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214072839.2367-1-minda.chen@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag

The INTx and MSI interrupt event num is different in Microchip and
StarFive platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 624e4e2e97d3..00250781b11c 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -818,6 +818,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
+	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -961,7 +963,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -971,7 +973,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 28ed1374e1de..fba7343f9a96 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -124,6 +124,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


