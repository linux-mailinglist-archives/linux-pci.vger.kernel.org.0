Return-Path: <linux-pci+bounces-36009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04142B54DA5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34712188CEB0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B5285CBB;
	Fri, 12 Sep 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tewUMk2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D32F617C;
	Fri, 12 Sep 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679888; cv=none; b=mxh9pmWidcuvA57e+lguIsXKIpy0NrH2yJl4z7g5nYwZGxzbTbbVv+kbh2Jank1whOisH+JHo8aRBOCHa/oVTH2NH156GcvydJr0N0dBY6XRnDIBelkFtIdt04V0m8Rn/mrqpuqDSBJ7PgwD+9+lORolL2pB5tc+kbO3XyFziVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679888; c=relaxed/simple;
	bh=Rgx1GvIwMLh688LHM4GBTxzehQd62fpaaJpFV614cvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7tzBOSKrLiXFpbeFv/ut00ZLFNSjav7PW/RqwiZBGmKLB49MkWV44NORkaVBPtEwiQBjh19MTGgvHJArpze7/9l37aD95DlJre2zMDSqX/3Myr1ZBAPYwY6VvKeuASC7KdCw/MSqw/6lgZl3KRRkb637FlCb2t9T/u4AlE5MIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tewUMk2H; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCOPBL967959;
	Fri, 12 Sep 2025 07:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679865;
	bh=pqDTwaoHFH/fcGY1igBafDBCN/IWj/jn4EnovKh1SuI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tewUMk2HpYVPiVcXkcmBK6UewUsL3w12oB+eNlZRSAw55qyL4aqJuyCDiIIxQ3s9z
	 Z2KLnzzzHn2QzV8jU+zdPkk1EJ0SWulHjEKzGXRUZ+hjfVE18ApIQOVfgQfj5N0gJj
	 H2X5x55kKhZR0VZMFnalz7mUiaWb2tyD5C2Qb7YI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCOP2A1969681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:24:25 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:24:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:24:24 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLV3589278;
	Fri, 12 Sep 2025 07:24:18 -0500
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
Subject: [PATCH v2 03/10] PCI: dwc: Add dw_pcie_free_domains() helper for cleanup
Date: Fri, 12 Sep 2025 17:46:14 +0530
Message-ID: <20250912122356.3326888-4-s-vadapalli@ti.com>
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

Introduce the helper function dw_pcie_free_domains() which will undo the
allocation performed by the dw_pcie_allocate_domains() function. Export
this helper for the users of dw_pcie_allocate_domains().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1: https://lore.kernel.org/r/20250903124505.365913-4-s-vadapalli@ti.com/
No changes since v1.

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
index a333ab0b0bbd..89659d05ab29 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -801,6 +801,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
+void dw_pcie_free_domains(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
@@ -845,6 +846,10 @@ static inline void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
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


