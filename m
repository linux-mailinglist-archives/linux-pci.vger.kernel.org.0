Return-Path: <linux-pci+bounces-36021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C1B54DC3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F2E3AD269
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457A3019AC;
	Fri, 12 Sep 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bFgUuti5"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDC30FC2B;
	Fri, 12 Sep 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679921; cv=none; b=FWbd5tmHY9T+MIEB2gkKVZ1wnlqUGLz22KGQl0V/ObMAEddALT8xo+kAdw0CHpvf/WmLRd1If5MkftCOSYqM0A+qGnfPeTTnv9bt/9WGfEGNY2xu2UJkRo/idPfkCqzfs6/OMECeQAObv/+LYbukIXiDv+MsCB4+dVtzGBB5Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679921; c=relaxed/simple;
	bh=0Mu2TfwYTvGNT0/SOuznU8Xo9nEgevesqabtorRMzNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0Se2xe795M2LKzMqv3HC+hRPbIRIYveA1Tms9hpHl9RpouNZSqONVZpBVP39pH6USttsR0zXav3pK0hbyc8SqCPT84OGgrWsValLqI7Gm2+OzWSD7N+NV10tRhTg3vo0v6tmY50dQZKEiW5myZsy7gr/DsAAxn4xsZFVHY1ojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bFgUuti5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCOrbn517286;
	Fri, 12 Sep 2025 07:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679893;
	bh=vj2uaDJCxGQbaAM5o1tES0SUnARreMitm6wm4PP1R30=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bFgUuti5l61jeacjYH7OkeHcu6S6d9/GAcx/aiKxVI93iaBFlotTTLz3E3IbscnsP
	 CpkCje3swMwqyiNLrPoUoQ7YpGltPGsSLFzD3eCF01J4soG1vkfs9tYK8whgX5Y3O6
	 AfSy9QCMy8vqnrzSOwsj+kLjc/zjtxDSJHojY8lY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCOrtr1969762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:24:53 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:24:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:24:53 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLZ3589278;
	Fri, 12 Sep 2025 07:24:46 -0500
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
Subject: [PATCH v2 07/10] PCI: keystone: Add ks_pcie_host_deinit() helper for cleanup
Date: Fri, 12 Sep 2025 17:46:18 +0530
Message-ID: <20250912122356.3326888-8-s-vadapalli@ti.com>
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

Introduce the helper function ks_pcie_host_deinit() to undo the
configuration performed by the ks_pcie_host_init() function and also to
free the MSI Domains if the '.msi_init' callback was implemented which
would have made a call to dw_pcie_allocate_domains().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1: https://lore.kernel.org/r/20250903124505.365913-8-s-vadapalli@ti.com/
No changes since v1.

 drivers/pci/controller/dwc/pci-keystone.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 074566fb1d74..3a3188e89a2a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -885,6 +885,18 @@ static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
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
 static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -929,11 +941,13 @@ static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 
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


