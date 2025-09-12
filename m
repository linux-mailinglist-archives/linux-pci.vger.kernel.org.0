Return-Path: <linux-pci+bounces-36016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91DB54DA7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4393CA0348E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B430B53E;
	Fri, 12 Sep 2025 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L+A+bOhv"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF65309DC1;
	Fri, 12 Sep 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679900; cv=none; b=L9XT7YMeXrI+fwWcntRoXRw9s2BcY1Iq98cLHl55P98qEwYlYGWh5/gVclykGZfPNJyEgcyxiKfS9uW/we1MT0Hfe6DTQ8480/VMvguEhdaUs73LB1H+9ROGRvQaFUbB7JzlZyrXkDxuGuJwJY2Pt90lmiX0xoM2l2mWhVxxFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679900; c=relaxed/simple;
	bh=hjEjo1uLoOWxAHax+AlLFxg47ht5MuU75YE0ZPcRkNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUxbkv0mCT78J3MlI5jbaGMUpFNnDolfaygaTS4QY1t/zGWdbuLB31+78rrUhPB8OTR+3BsVfN56SqYcbW/RKvyBUGtkQPtZ5dydft10U7MLY1X2pUYXkUiEHo7DwV+d6Pf9H1xdGoehTPBAq68C85O70vuilM/gsAz0FMh9wPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L+A+bOhv; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCOdU81030262;
	Fri, 12 Sep 2025 07:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679879;
	bh=1b/F6WA6EQOMUHO5172BD3euAaLVPBGiusexrCvLpJU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L+A+bOhvijc7F1Pm0hASmWo2WFks9qFqfVEG4SFZZy6cybEsdQ0dqLiaK2cLzLRHt
	 rLsB75TLNOa7/nGreq7I7BqChTt+3Db3gEv5b177OW6FxHMMHKbim+lRoLIqfsQ2t6
	 IhbCjFW40wuDreOTqVJ9pQO8BU/gwNbWL8LcSG44=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCOdP32760539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:24:39 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:24:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:24:39 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLX3589278;
	Fri, 12 Sep 2025 07:24:32 -0500
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
Subject: [PATCH v2 05/10] PCI: keystone: Add ks_pcie_free_msi_irq() helper for cleanup
Date: Fri, 12 Sep 2025 17:46:16 +0530
Message-ID: <20250912122356.3326888-6-s-vadapalli@ti.com>
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

Introduce the helper function ks_pcie_free_msi_irq() which will undo the
configuration performed by the ks_pcie_config_msi_irq() function. This will
be required for implementing a future helper function to undo the
configuration performed by the ks_pcie_host_init() function.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1: https://lore.kernel.org/r/20250903124505.365913-6-s-vadapalli@ti.com/
No changes since v1.

 drivers/pci/controller/dwc/pci-keystone.c | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d03e95bf7d54..81c3686688c0 100644
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


