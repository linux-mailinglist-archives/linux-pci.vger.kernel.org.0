Return-Path: <linux-pci+bounces-35372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C6B41F88
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A461B3AAD27
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659D3002D8;
	Wed,  3 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DsAmnW0Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409722FFDCB;
	Wed,  3 Sep 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903552; cv=none; b=g7m8i3aZP0QR0BCxYZs3QDg/FcpSnG0bY0fwg3w5FRrmL46tYNLSNihb9dMElbbVgpBM1544MSYnvVDNGM0rgjPV4ldDjnYiNOsYWzGJT4C0233n2l8ECIY/SgUP5nZ5tZOSCS61eESJbc65oHSboPwqaLSVuMT2S6uigqpGo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903552; c=relaxed/simple;
	bh=+QKYlKpERCPrAP8O0C+5KTKYG3bxu2S0WACh131NlXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2UaM/lpIBcpPJMrLclvamWe5Q9wFynQhJ4BXJx4IgkOelLAwd1QHUMy+qEZ8J5KpoIbGkR6wRpzsR40xI8k5qM92PqSHd1MO49n5MZp4HG9yxwkLq7lhh7qkA9k+nlkB1A6c7OTyRSn+AahrNHlMYf6sGDBSCFCP8u9XlFqOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DsAmnW0Z; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CjXRm3263808;
	Wed, 3 Sep 2025 07:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903534;
	bh=4QD21tgjxfBWtfcipGGATPRBLLmOBGCMaskE3EBQK8w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DsAmnW0ZLQ/P1vKp82E0eRSmQFK2Tjlxyw5N7Ry3pAVrP2RC24rBNzwTQaMASNwB0
	 kz7f7v22ECfwfbK5CT0PDScB9pZpsGBoobcv6GwS/gp3p9v2EcZmf51e6EqoCw2YX0
	 KD1gY5HjwbqcrvKDoQzdzCmUHN088BK4zgO3vowM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CjXH4084035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:32 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wU1576150;
	Wed, 3 Sep 2025 07:45:26 -0500
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
Subject: [PATCH 03/11] PCI: dwc: Add dw_pcie_free_domains() helper for cleanup
Date: Wed, 3 Sep 2025 18:14:44 +0530
Message-ID: <20250903124505.365913-4-s-vadapalli@ti.com>
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

Introduce the helper function dw_pcie_free_domains() which will undo the
allocation performed by the dw_pcie_allocate_domains() function. Export
this helper for the users of dw_pcie_allocate_domains().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3cc83d921376..df55c0ed75e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -211,6 +211,15 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 	.free	= dw_pcie_irq_domain_free,
 };
 
+void dw_pcie_free_domains(struct dw_pcie_rp *pp)
+{
+	if (pp->irq_domain) {
+		irq_domain_remove(pp->irq_domain);
+		pp->irq_domain = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(dw_pcie_free_domains);
+
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a44f2113925d..9f6f6f0ecd93 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -802,6 +802,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
+void dw_pcie_free_domains(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
@@ -846,6 +847,10 @@ static inline void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 }
 
+static inline void dw_pcie_free_domains(struct dw_pcie_rp *pp)
+{
+}
+
 static inline int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	return 0;
-- 
2.43.0


