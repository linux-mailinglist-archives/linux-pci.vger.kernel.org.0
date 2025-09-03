Return-Path: <linux-pci+bounces-35374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7EB41F89
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A9C1B27729
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37C3009C3;
	Wed,  3 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ILACtSZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D530100A;
	Wed,  3 Sep 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903566; cv=none; b=WFYbeTKWwZ+NM+AuE0Go+SXeoddGLQAxkLGexA8/03aViOXrveFZvI0zJYcrACrD0WiqsSYX7ch/j1X5Mqc6YHib7qY3lZ2zDWyyIdM2mUg+TIdedu2mSy2ho1/JESemh+krzIo4uG60HiQSR4rvGYAD4wnZ6DCTXL7mpwFyOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903566; c=relaxed/simple;
	bh=qF5436bTX16jxt4pf8yH0hQgEL15Nmwihn7GsSVjW4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoZIHEqwHhjQ1QLALCzWIAALgVuNG2AlWlzSRsyRfuE2kuUCzhRrVEwx6V8P2PeChL3ytYKSGkGohftsOCjlp7GLlvDCDI7TwJsGOf88pAjNt4z/mM6GTbZyxxIRUNGa/CMKIIbIHtUZuIAg5Z4tkQ6ArrLWL2XQ2fBNkuZQxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ILACtSZj; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CjlAm2831316;
	Wed, 3 Sep 2025 07:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903547;
	bh=IOJd8niW0aLqEJaIsbx3UOkA/f/bi/oRRBZYE6rFVXk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ILACtSZjqUdPHfO/CKnE5REYy9/xAYra7/30YxqqurZLlCjCb7EXmVz+tEweELlq2
	 GtxE5MxnObAPC05pnN425IuO1J2v3Tkb8vKnqYnwxptHq2l1jRVAS5jIoR23E+JvBk
	 D0sXlxczGtn8AtoAtGepFirZ8fVs7xWj3mLkyBQE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CjlZ33522784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:46 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wW1576150;
	Wed, 3 Sep 2025 07:45:40 -0500
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
Subject: [PATCH 05/11] PCI: keystone: Add ks_pcie_free_msi_irq() helper for cleanup
Date: Wed, 3 Sep 2025 18:14:46 +0530
Message-ID: <20250903124505.365913-6-s-vadapalli@ti.com>
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

Introduce the helper function ks_pcie_free_msi_irq() which will undo the
configuration performed by the ks_pcie_config_msi_irq() function. This will
be required for implementing a future helper function to undo the
configuration performed by the ks_pcie_host_init() function.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3d10e1112131..6cedb6dc4650 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -666,6 +666,31 @@ static void ks_pcie_intx_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void ks_pcie_free_msi_irq(struct keystone_pcie *ks_pcie)
+{
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count, irq, i;
+
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return;
+
+	/* Nothing to do if MSI Interrupt Controller does not exist */
+	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
+	if (!intc_np)
+		return;
+
+	/* irq_count should be non-zero. Else, ks_pcie_host_init would have failed. */
+	irq_count = of_irq_count(intc_np);
+
+	for (i = 0; i < irq_count; i++) {
+		/* We expect to get an irq since it succeeded during 'config'. */
+		irq = irq_of_parse_and_map(intc_np, i);
+		irq_set_chained_handler(irq, NULL);
+	}
+	of_node_put(intc_np);
+}
+
 static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
-- 
2.43.0


