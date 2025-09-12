Return-Path: <linux-pci+bounces-36020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D67B54DBF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888933BDB6D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433983043A5;
	Fri, 12 Sep 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFDYyMZu"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A23019AC;
	Fri, 12 Sep 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679918; cv=none; b=LHP5vXgIwopyS+WUkWuHiG2Zt3zj7E6ig17QIMnArbqBA2/TI7I5M8k/eS27b7pdmU1+8KAdOSZ0iRUa4KBdTocDVLRBU452vHxCn34ozGfeVf4Q6tuvF1+D4cJjWMKvY8r8qXWJVm8Fcd6BUdJlE6XtBc9eIAAM00wiPe9bjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679918; c=relaxed/simple;
	bh=lOl1bORjgtUVblIfSnhHhHV6S3RXTIIydyYBHH+vI90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzvkG6wGXm2jN1ozOUPQ5g16wctB3+PD6ULMoQshzhmA/+Tw63aFIkbPbomQCIdoOuEFKN+upb2b4VkLz5Z5M3aE3VJRYWJLLmVdlXPRByUzOZ5aFFYZv0dgM2nIcbq0ePoVD1ii9nsMxd7dbzjqApG6vU+FPzAzC3p6BC5I2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SFDYyMZu; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCOkQ11030270;
	Fri, 12 Sep 2025 07:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679886;
	bh=akHgpV0QofSJh7+9oJVQtZLcV4mul4y96HgMakofh04=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SFDYyMZuL/p17Zovwj5vhVROb6DWXPCjna7kNgtW0JhBYEpUY8imhcRAi4wjd3NQO
	 BcOW0sKgZkiKeddP6JVN25nNmyR5UTtdR1QBOILm8zCpSi38Sh/iw8BnlUt8k0m1Q3
	 J8LwDK1c/ZiK7MmPEMEihl/1SrhItHkqlrnBnzxM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCOk9a1291380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:24:46 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:24:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:24:46 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLY3589278;
	Fri, 12 Sep 2025 07:24:39 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <qiang.yu@oss.qualcomm.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <quic_schintav@quicinc.com>,
        <inochiama@gmail.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>
CC: <jirislaby@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 06/10] PCI: keystone: Add ks_pcie_free_intx_irq() helper for cleanup
Date: Fri, 12 Sep 2025 17:46:17 +0530
Message-ID: <20250912122356.3326888-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122356.3326888-1-s-vadapalli@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
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

v1: https://lore.kernel.org/r/20250903124505.365913-7-s-vadapalli@ti.com/
No changes since v1.

 drivers/pci/controller/dwc/pci-keystone.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 81c3686688c0..074566fb1d74 100644
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


