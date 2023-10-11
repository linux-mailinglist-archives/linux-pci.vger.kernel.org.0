Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD87C50F6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbjJKLF6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjJKLFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:05:37 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F6DC0;
        Wed, 11 Oct 2023 04:05:33 -0700 (PDT)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by ex01.ufhost.com (Postfix) with ESMTP id 2DA1724E386;
        Wed, 11 Oct 2023 19:05:32 +0800 (CST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1A00624DFCE;
        Wed, 11 Oct 2023 19:05:32 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:32 +0800
Received: from ubuntu.localdomain (183.27.96.95) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:30 +0800
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
Subject: [PATCH v8 18/22] PCI: plda: Set plda_event_handler() to static
Date:   Wed, 11 Oct 2023 19:05:10 +0800
Message-ID: <20231011110514.107528-19-minda.chen@starfivetech.com>
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

Set plda_event_handler() to static for it is just
referenced in its file now.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 2 +-
 drivers/pci/controller/plda/pcie-plda.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index a3fae91927be..4a4a2b5ef8fb 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -252,7 +252,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = plda_pcie_intx_map,
 };
 
-irqreturn_t plda_event_handler(int irq, void *dev_id)
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
 {
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 573ecf0bd9a8..ce7787aef4b7 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -137,7 +137,6 @@ struct plda_event {
 	int msi_event;
 };
 
-irqreturn_t plda_event_handler(int irq, void *dev_id);
 int plda_init_interrupts(struct platform_device *pdev,
 			 struct plda_pcie_rp *port,
 			 const struct plda_event *event);
-- 
2.17.1

