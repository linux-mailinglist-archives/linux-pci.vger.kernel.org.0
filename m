Return-Path: <linux-pci+bounces-35375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A15B41F8C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02E31B23F76
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7FB265637;
	Wed,  3 Sep 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WDntU0TJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237012FDC43;
	Wed,  3 Sep 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903573; cv=none; b=rVEOnLYJj9h6W7KUFzDmsP3bAljxyL/Xlu25FpcJIR4vUSoNkD8MuMX+ywyDFvaRLnzEz7sazcIAGKbMjb/exRCrd/ZKyZqGllMx5WlLoTy47yUUAlbyPpvCOqHEgvTrNUqbMsZMF7rIyDiHkwjzKC98PDfIHPUf7/CTz+39AGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903573; c=relaxed/simple;
	bh=eELTOw4TFFXMp1myjC3VvY7dRkx/jEnFMJSUXs8Riyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaqfkQwoRkS9pmdZsndkQVYRQX8UfhzW3cztRQ7MFP8nCq84H+FqHd298efvUvxq0q3cKL61LE4CNJuyS+HBed012tfJ88DS6zGpBYmdIjarHXVqKv+a7xhdj/Ktqd8bafJtvWQXbeCqK8negVSlBcrOCx85XkLj5jnRL+1bX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WDntU0TJ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583Cjrwc3263852;
	Wed, 3 Sep 2025 07:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903553;
	bh=teF+KOtkZYo/wkZDuBpN5Zu/YgKSEJW0ToMr/y7CuHg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WDntU0TJ4Jrll9dgYmiZorQkVuUyVwE8R8rvP4Wc2V+U2eOftLCC8F2UdneMV3+kt
	 VMs+snVuWp70TrU0cJThnIqp/has5oPxEc3WemxwVKNwWTBrn6nOc7qD9ORxiYRd7j
	 co/6okDFR8hbMZU1lo9meA7KjOqiCgCJKcSe94b0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583Cjrxv3601814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:52 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wX1576150;
	Wed, 3 Sep 2025 07:45:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 06/11] PCI: keystone: Add ks_pcie_free_intx_irq() helper for cleanup
Date: Wed, 3 Sep 2025 18:14:47 +0530
Message-ID: <20250903124505.365913-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Introduce the helper function ks_pcie_free_intx_irq() which will undo the
configuration performed by the ks_pcie_config_intx_irq() function. This
will be required for implementing a future helper function to undo the
configuration performed by the ks_pcie_host_init() function.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 6cedb6dc4650..3afa298e89d1 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -745,6 +745,35 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+static void ks_pcie_free_intx_irq(struct keystone_pcie *ks_pcie)
+{
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count, i;
+	u32 val;
+
+	/* Nothing to do if INTx Interrupt Controller does not exist */
+	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
+	if (!intc_np)
+		return;
+
+	/* irq_count should be non-zero. Else, ks_pcie_host_init would have failed. */
+	irq_count = of_irq_count(intc_np);
+
+	/* Disable all legacy interrupts */
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		val = ks_pcie_app_readl(ks_pcie, IRQ_ENABLE_SET(i));
+		val &= ~INTx_EN;
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), val);
+	}
+
+	irq_domain_remove(ks_pcie->intx_irq_domain);
+	for (i = 0; i < irq_count; i++)
+		irq_set_chained_handler(ks_pcie->intx_host_irqs[i], NULL);
+
+	of_node_put(intc_np);
+}
+
 static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
-- 
2.43.0


