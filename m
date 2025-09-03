Return-Path: <linux-pci+bounces-35376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F5B41F93
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4143AEF3B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC53002B8;
	Wed,  3 Sep 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="waZilO5r"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896F3019CA;
	Wed,  3 Sep 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903577; cv=none; b=TDQA67lP6l2ufSCjpSCYmZIA9Yr52qv5pnqTlgOqSIeJi0FvZEOP8QPSp3vg+G4u6ygfBgVAXm17qydNCeQ2c6VSJUoS3Lhbg3r1lD9G9GFlQlMQbVUg4lWz5pLSPYCFDHZkS6N6jCp9A5gl+k2xT2EfbHGcJKnaCOlMQh8DVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903577; c=relaxed/simple;
	bh=UcGpUncYIuK2K8q0nFk1U+GPhAZQCShpsSiXTy+pXBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1gIS2hl//mExFznvUZm9YxVMhlsUG13Q34BY8zD5hauQjW+Rrc+58mP2h1pebYtQjXlJxKeJWP5LzA8K0JpF/QszN322cgazl4lnMPwgp01+GQZVivt8H+UujYBzT6MMmDpu5CaaE1Ld8Navlnekj/NW5w/4lstQArkwO5F2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=waZilO5r; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583Ck03H3263860;
	Wed, 3 Sep 2025 07:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903560;
	bh=tTQYoXHzAsvVZHpeb9xbXoz42twoCo53trrb9qs+WBU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=waZilO5rLVGtPTi60mPbG6dTrt/Svxm2d7dcz67/xqqZ+O37eQHbzlWw0F6s+jjcw
	 eRd+jBiDGyBqSZhCAtyFGHegCb6rfTzsue+IXJLphMUoxUBUqoZIrRuRycE2nMwiLS
	 c8dFf8ybrwPII8KlyVqifdJpEsCGwQ5055ZvsYYo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583Cjx8h3601941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:46:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wY1576150;
	Wed, 3 Sep 2025 07:45:53 -0500
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
Subject: [PATCH 07/11] PCI: keystone: Add ks_pcie_host_deinit() helper for cleanup
Date: Wed, 3 Sep 2025 18:14:48 +0530
Message-ID: <20250903124505.365913-8-s-vadapalli@ti.com>
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

Introduce the helper function ks_pcie_host_deinit() to undo the
configuration performed by the ks_pcie_host_init() function and also to
free the MSI Domains if the '.msi_init' callback was implemented which
would have made a call to dw_pcie_allocate_domains().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3afa298e89d1..f432818f6802 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -885,6 +885,18 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
+static void ks_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	ks_pcie_stop_link(pci);
+	ks_pcie_free_msi_irq(ks_pcie);
+	ks_pcie_free_intx_irq(ks_pcie);
+	if (pci->pp.ops->msi_init)
+		dw_pcie_free_domains(pp);
+}
+
 static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -929,11 +941,13 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.init = ks_pcie_host_init,
+	.deinit = ks_pcie_host_deinit,
 	.msi_init = ks_pcie_msi_host_init,
 };
 
 static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
 	.init = ks_pcie_host_init,
+	.deinit = ks_pcie_host_deinit,
 };
 
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
-- 
2.43.0


